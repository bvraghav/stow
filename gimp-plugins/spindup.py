#!/usr/bin/env python

# Tutorial available at: https://www.youtube.com/watch?v=nmb-0KcgXzI
# Feedback welcome: jacksonbates@hotmail.com

from gimpfu import *

def spindup(image, drawable):
  # function code goes here...
  pdb.gimp_message("Hello World!")
  pdb.gimp_message(drawable.name)

register(
  "python-fu-spindup",
  "Spin Duplicates",
  "Spin Duplicates",
  "B. V. Raghav", "B. V. Raghav", "2019",
  "<Image>/Filters/BVR/Spindup...",
  "*",
  [
    # basic parameters are: (UI_ELEMENT, "variable", "label", Default)
    # (PF_IMAGE, "image", "Current Image", None),
    # (PF_DRAWABLE, "drawable", "Input Layer", None)
    # PF_SLIDER, SPINNER have an extra tuple (min, max, step)
    # PF_RADIO has an extra tuples within a tuple:
    # eg. (("radio_label", "radio_value"), ...) for as many radio buttons
    # PF_OPTION has an extra tuple containing options in drop-down list
    # eg. ("opt1", "opt2", ...) for as many options
    # see ui_examples_1.py and ui_examples_2.py for live examples
    ],
  [],
  spindup
)  # second item is menu location

main()
