#!/bin/bash
usage() {
    echo "usage: ./.print_doc_url.sh [ --ip <ip> --port <port> ] "
    echo "       --ip <ip>, localhost ip"
    echo "       --port <port>, port"
    echo "       --help, usage"
}

type=''
port=''

TEMP=$(getopt -o -a -l ip:,port:,help -n "./.print_doc_url.sh" -- "$@")
if [[ "$?" != 0 ]]; then
    echo "error options, terminating....."
    exit 1
fi

eval set -- "${TEMP}"

while true; do
    case "$1" in
    --port)
        port=$2
        shift 2
        ;;
    --ip)
        ip=$2
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

HEADER='\033[95m'
OKBLUE='\033[94m'
OKCYAN='\033[96m'
OKGREEN='\033[92m'
WARNING='\033[93m'
FAIL='\033[91m'
ENDC='\033[0m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

e_header() {
    printf "\n${BOLD}${HEADER}==========  %s  ==========${ENDC}\n" "$@"
}
e_error() {
    printf "${FAIL}✖ %s${ENDC}\n" "$@"
}
e_warning() {
    printf "${UNDERLINE}${WARNING}➜ %s${ENDC}\n" "$@"
}

e_header "点击以下链接查看文档:"
e_warning "http://${ip}:${port}"
e_warning "http://127.0.0.1:${port}"