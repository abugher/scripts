#!/bin/bash

# This program is free software. It comes without any warranty, to the
# extent permitted by applicable law. You can redistribute it and/or modify
# it under the terms of the Do What The Fuck You Want To Public License,
# Version 2, as published by Sam Hocevar. See WTFPL.txt or
# http://www.wtfpl.net/ for more details.

source utilities.sh
source function_new_food.sh

FOOD="x"
TALLY="0"
DATE="$(date "+%Y%m%d")"
TAB="state/days/${DATE}"

if [ -f "${TAB}" ]
then
  $e "You have a tab for ${DATE}.  [c]ontinue or [o]verwrite? [C,o]  "
  read REPLY
  if echo "${REPLY}" | grep -i "^o"
  then
    $e "Overwriting your old tab.\n"
    echo "" > "${TAB}"
  else
    $e "Continuing your old tab.\n"
    # Stripped version of the user-facing loop.
    while read FOOD
    do
      read SERVINGS

      # Check validity.
      for VAR in SERVINGS
      do
        eval $VAR=$(distill "${!VAR}")
        if [ "${!VAR}" == "" ]
        then
          $e "Error:  Invalid number for ${VAR}.\n"
          continue
        fi
      done

      # Handle new state/foods.  This shouldn't happen, but, eh ...
      if [ ! -f state/foods/"${FOOD}" ]
      then
        new_food "${FOOD}"
      fi

      # Get points per serving.
      POINTS_PER_SERVING=$(cat state/foods/"${FOOD}")

      # Do the math.
      POINTS=$(
        echo "scale=3; ${POINTS_PER_SERVING} * ${SERVINGS}" \
        | bc
      )

      $e "${FOOD}:\n"
      $e "  ${POINTS_PER_SERVING} x ${SERVINGS} = ${POINTS}\n"

      TALLY=$(
        echo "scale=3; ${TALLY} + ${POINTS}" \
        | bc
      )

      # Summary output.
      $e "  Tally:  ${TALLY}\n"
    done \
      < "${TAB}"
    # Reset FOOD so the main loop triggers.
    FOOD="x"
    $e "\n"
  fi
fi


# Condition is redundant to break line, but it's here for reference.
$e "Hit enter at the food prompt to finish.\n"
while [ "${FOOD}" != "" ]
do
  # Get details from the user.
  $e "    Food:  "
  read FOOD

  # Check for break condition.
  if [ "${FOOD}" == "" ]
  then
    break
  fi

  # Check for new food.
  if [ ! -f state/foods/"${FOOD}" ]
  then
    $e "Unknown food.  Please define.\n\n"
    new_food "${FOOD}"
    $e "\n"
  fi

  $e "Servings:  "
  read SERVINGS

  # Check validity of input.
  eval SERVINGS=$(distill "${SERVINGS}")
  if [ "${SERVINGS}" == "" ]
  then
    $e "Error:  Invalid number for SERVINGS.\n"
    continue
  fi

  # Get points per serving.
  POINTS_PER_SERVING=$(cat state/foods/"${FOOD}")

  # Do the math.
  POINTS=$(
    echo "scale=3; ${POINTS_PER_SERVING} * ${SERVINGS}" \
    | bc
  )

  TALLY=$(
    echo "scale=3; ${TALLY} + ${POINTS}" \
    | bc
  )

  # Output.
  $e "  Points:  ${POINTS}\n"
  $e "   Tally:  ${TALLY}\n"
  $e "\n"

  # Log food and servings.
  echo "${FOOD}" >> "${TAB}"
  echo "${SERVINGS}" >> "${TAB}"
done

# Print the final tally before exiting.
$e "   Tally:  ${TALLY}\n"
