#!/bin/bash
./tmp/firepwd.py -d .mozilla/firefox/something.default/ \
| tail -n +24 \
| while read line; do 
  line="$(
    sed -E 's#^.*://##' <<< "${line}"
  )"
  site="$(
    sed -E 's#^([^ ]*): .*$#\1#' <<< "${line}"
  )"
  # Kinda just hoping comma-space-comma isn't part of any names.
  name="$(
    sed -E 's#^[^ ]*: (.*) , .*$#\1#' <<< "${line}"
  )"
  pass="$(
    sed -E 's#^.* , (.*)$#\1#' <<< "${line}"
  )"
  echo -e "${pass}\n${pass}" | pass add "${site}/${name}" && echo "Success:  ${site}" || echo "Failure:  ${site}"
done
