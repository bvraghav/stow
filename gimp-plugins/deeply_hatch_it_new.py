#!/usr/bin/env python

## Adapted from
# the tutorial available at: https://www.youtube.com/watch?v=nmb-0KcgXzI
# for feedback: jacksonbates@hotmail.com

from gimpfu import *

def new_image(image, layer):
    # function code goes here...
    pdb.gimp_message('Deeply Hatch It!')
    image = pdb.gimp_image_new(256, 256, 1)
    pdb.gimp_message('Image created!')
    display = pdb.gimp_display_new(image)
    pdb.gimp_message('Display created!')
    pdb.gimp_displays_flush()

register(
    "python-fu-new-image",
    "New Image",
    "Create new image",
    "B. V. Raghav", "B. V. Raghav", "2019",
    "<Image>/Bvr/New Image...",
    "",
    [ 
        # basic parameters are: (UI_ELEMENT, "variable", "label", Default)
        # (PF_IMAGE, "image", "takes current image", None),
        # (PF_DRAWABLE, "drawable", "Input layer", None)
        # PF_SLIDER, SPINNER have an extra tuple (min, max, step)
        # PF_RADIO has an extra tuples within a tuple:
        # eg. (("radio_label", "radio_value"), ...) for as many radio buttons
        # PF_OPTION has an extra tuple containing options in drop-down list
        # eg. ("opt1", "opt2", ...) for as many options
        # see ui_examples_1.py and ui_examples_2.py for live examples
    ],
    [],
    new_image)  # second item is menu location

main()
