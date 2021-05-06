.. vim: syntax=rst



bash utils
============================

color outputs
---------------------------
.. code-block:: sh
   :linenos:
  
   bold=$(tput bold)
   underline=$(tput sgr 0 1)
   reset=$(tput sgr0)
   
   purple=$(tput setaf 171)
   red=$(tput setaf 1)
   green=$(tput setaf 76)
   tan=$(tput setaf 3)
   blue=$(tput setaf 38)
   
   #
   # Headers and  Logging
   #
   
   e_header() {
     printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
   }
   e_arrow() {
     printf "➜ $@\n"
   }
   e_success() {
     printf "${green}✔ %s${reset}\n" "$@"
   }
   e_error() {
     printf "${red}✖ %s${reset}\n" "$@"
   }
   e_warning() {
     printf "${tan}➜ %s${reset}\n" "$@"
   }
   e_underline() {
     printf "${underline}${bold}%s${reset}\n" "$@"
   }
   e_bold() {
     printf "${bold}%s${reset}\n" "$@"
   }
   e_note() {
     printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
   }

check binary exists
---------------------------

.. code-block:: sh
   :linenos:

   type_exists() {
     if [ $(type -P $1) ]; then
       return 0
     fi
     return 1
   }

retry 
---------------------------

.. code-block:: bash
   :linenos:

   # Retries a command on failure.
   # $1 - the max number of attempts
   # $2... - the command to run
   # example: retry 5 ls -ltr foo
   retry() {
     local -r -i max_attempts="$1"
     shift
     local -r cmd="$@"
     local -i attempt_num=1
   
     until $cmd; do
       if ((attempt_num == max_attempts)); then
         e_error "Attempt $attempt_num failed and there are no more attempts left!"
         return 1
       else
         echo "Attempt $attempt_num failed! Trying again in $attempt_num seconds..."
         sleep $((attempt_num++))
       fi
     done
   }


confirm
---------------------------

.. code-block:: bash
   :linenos:

   #
   # USAGE FOR SEEKING CONFIRMATION
   # seek_confirmation "Ask a question"
   # Credit: https://github.com/kevva/dotfiles
   #
   # if is_confirmed; then
   #   some action
   # else
   #   some other action
   # fi
   #
   
   seek_confirmation() {
     printf "\n${bold}$@${reset}"
     read -p " (y/n) " -n 1
     printf "\n"
   }
   
   # underlined
   seek_confirmation_head() {
     printf "\n${underline}${bold}$@${reset}"
     read -p "${underline}${bold} (y/n)${reset} " -n 1
     printf "\n"
   }
   
   # Test whether the result of an 'ask' is a confirmation
   is_confirmed() {
     if [[ "$REPLY" =~ ^[Yy]$ ]]; then
       return 0
     fi
     return 1
   }

check_status
---------------------------

.. code-block:: bash
   :linenos:

   # check status
   check_status() {
     if [ "$?" != 0 ]; then
       e_error "$@ failed, aborting"
       exit 1
     else
       e_success "$@ success"
     fi
   }

here_doc
-----------------------------

.. code-block:: language
   :linenos:

   cat <<EOF >result.json
   {
     "mongoUri" : "$mongo_uri",
     "mongoUser" : "$username",
     "mongoPassword" : "$password",
     "mongoHost" : "$mongo_host",
     "mongoTag" : "$mongo_tag"
   }
   EOF

usage
-----------------------------
.. code-block:: bash
   :linenos:

   usage() {
       echo "usage: ./start.sh [ --config-dir <config-dir> ] "
       echo "       --config-dir <config-dir>, default is .., the directory contains configurations of minio"
       echo "       --help, usage"
   }

   config_dir="$(pwd)/../"

   TEMP=$(getopt -o -a -l config-dir:,help -n "start.sh" -- "$@")
   if [[ "$?" != 0 ]]; then
       echo "error options, terminating....."
       exit 1
   fi

   eval set -- "${TEMP}"

   while true; do
       case "$1" in
       --config-dir)
           config_dir=$2
           shift 2
           ;;
       --help)
           usage
           exit 0
           shift
           ;;
       --)
           shift
           break
           ;;
       *)
           echo "unknown input option $1"
           usage
           exit 1
           ;;
       esac
   done


ensure
-------------
.. code-block:: language
   :linenos:

   say() {
       printf 'rustup: %s\n' "$1"
   }

   err() {
       say "$1" >&2
       exit 1
   }
   ensure() {
       if ! "$@"; then err "command failed: $*"; fi
   }
   ensure ls /xxx