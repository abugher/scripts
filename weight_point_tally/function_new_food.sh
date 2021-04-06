#!/bin/bash

# This program is free software. It comes without any warranty, to the
# extent permitted by applicable law. You can redistribute it and/or modify
# it under the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar. See WTFPL.txt or
# http://www.wtfpl.net/ for more details.

source utilities.sh
source function_serving_points.sh

function new_food
{
  FOOD="${1}"
  # Get details from the user.
  $e "              Calories per serving:  "
  read CALORIES
  $e "          Grams of fat per serving:  "
  read FAT
  $e "Grams of dietary fiber per serving:  "
  read FIBER

  # Check validity of input.
  for VAR in CALORIES FAT FIBER
  do
    eval $VAR=$(distill "${!VAR}")
    if [ "${!VAR}" == "" ]
    then
      $e "Error:  Invalid number for ${VAR}.\n"
      exit 1
    fi
  done

  # Output our inputs for some reason ...
  # $e "    Food:  ${FOOD}\n"
  # $e "Calories:  ${CALORIES}\n"
  # $e "     Fat:  ${FAT}\n"
  # $e "   Fiber:  ${FIBER}\n"

  # The heavy lifting.
  POINTS=$(serving_points "${FOOD}" "${CALORIES}" "${FAT}" "${FIBER}")

  $e "\n"
  $e "                            Points:  ${POINTS}\n"

  # Save the points per serving for this food.
  echo "${POINTS}" > state/foods/"${FOOD}"
}
