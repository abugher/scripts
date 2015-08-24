Files:

  README.txt
    This file.  Hi!

  tally.sh
    Run this.  First, "be" in this directory (make it your CWD), then
    run ./tally.sh .  When you eat, tell it what you're eating, and how
    many.  It will save records of food in foods/ and records of point
    tallies in days/ .  If you name a new food, you will be asked for
    some information from the label.

  days/
    Each file in here is a point tally.  The program assumes you want to
    run one tally per day.

  foods/
    Each file in here is a record of the point value of one type of
    food.

  function_new_food.sh
  function_serving_points.sh
  utilities.sh
    These files contain code.  They should probably be one file.


Formulas:

  https://en.wikipedia.org/wiki/Weight_Watchers#Formulas

  Points per serving:
    (c/50) + (f/12) - (min(r,4)/5)

    c - calories
    f - fat
    r - dietary fiber

  Points per person (break-even target):
    (w / 10) + g + a + h + l + b

    w - weight in pounds
    g - gender-based, 2 for women, 8 for men
    a - age-based:
      4:  17-26
      3:  27-37
      2:  38-47
      1:  48-58
      0:  59+
    h - height-based:
      2:  5'11"+
      1:  5'1"-5'10"
      0:  5'0"-
    l - lifestyle-based; spend most of the day:
      6:  hard work
      4:  walking
      2:  standing
      0:  sitting
    b - breastfeeding:
      10: full breastfeeding
      5:  partial breastfeeding
