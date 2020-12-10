#!/usr/bin/env bash
echo $(dirname "${PWD}")
docker run --rm -ti -u $UID -e USER=$USER -v $(dirname "$PWD"):$(dirname "$PWD") -p 8000:8000 docs:latest bash -c "cd $(dirname "$PWD")/documentation && make html && bash ./.print_doc_url.sh --port 8000 --ip 0.0.0.0 && cd _build/html && python3 -m http.server $port"