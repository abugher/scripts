#!/bin/bash

# This program is free software. It comes without any warranty, to the
# extent permitted by applicable law. You can redistribute it and/or modify
# it under the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar. See WTFPL.txt or
# http://www.wtfpl.net/ for more details.

source utilities.sh

function serving_points
{
  # Parameters should be checked already.
  FOOD="${1}"
  CALORIES="${2}"
  FAT="${3}"
  FIBER="${4}"

  # min(fiber, 4)
  if [ "$(
    echo "a=${FIBER}; b=4; r=-1; if (a==b) r=0; if (a>b) r=1; r" \
      | bc
  )" == "1" ]
  then FIBER=4
  fi

  # The forumula, except for the min(fiber, 4) part, which is done above.
  POINTS=$(
    echo "scale=3; (${CALORIES} / 50) + (${FAT} / 12) - (${FIBER} / 5)" \
    | bc 
  )

  echo ${POINTS}
}
