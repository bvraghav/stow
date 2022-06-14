#!/usr/bin/env python

## Adapted from
# the tutorial available at: https://www.youtube.com/watch?v=nmb-0KcgXzI
# for feedback: jacksonbates@hotmail.com

import os
import subprocess as sp
import shlex as lx
from uuid import uuid4
from gimpfu import *

def transport(image, drawable, tmp, host, remote_path):
  # function code goes here...
  pdb.gimp_message("Starting Transport...")
  pdb.gimp_message("Image layers: %s" % (image.layers,))
  pdb.gimp_message("Tmp Directory: %s" % (tmp,))
  
  tmp_fname = os.path.join(
    tmp, '%s.ora' % (str(uuid4()).split('-').pop(0))
  )

  # Duplicate Image
  dupim = image.duplicate()
  pdb.gimp_file_save(image, image.layers[0], tmp_fname, os.path.basename(tmp_fname))
  pdb.gimp_message("Image sucessfully saved: %s" % (tmp_fname,))

  # scp
  cmd = lx.split('scp %s %s:%s' % (tmp_fname, host, remote_path))
  # config_file=os.path.join(os.getenv('HOME'), '.ssh/config')
  # if  os.path.exists(config_file):
  #   cmd.insert(1, config_file)
  #   cmd.insert(1, '-F')
  pdb.gimp_message(' '.join(cmd))
  p1 = sp.Popen(cmd, stdout=sp.PIPE)
  rc = p1.wait()
  pdb.gimp_message('rc: %s, stdout: %s' % (rc, p1.stdout.read(),))
  if rc != 0 :
    pdb.gimp_message('Error in transfer')
  else :
    pdb.gimp_message('Transfer Successful')

  # decompress
  remote_fname = os.path.join(remote_path, os.path.basename(tmp_fname))
  cmd = lx.split(
    'ssh ailab2 "~/.local/bin/decompress-ora %s"' % (remote_fname,)
  )
  pdb.gimp_message(' '.join(cmd))
  p1 = sp.Popen(cmd, stdout=sp.PIPE, stderr=sp.PIPE)
  rc = p1.wait()
  pdb.gimp_message('rc: %s, stdout: %s' % (rc, p1.stdout.read(),))
  if rc != 0 :
    pdb.gimp_message('Error in ssh: %s' % p1.stderr.read())
  else :
    pdb.gimp_message('ssh Successful')
  

register(
  "python-fu-transport",
  "Transport to and from a server",
  "Transport layer(s) to a deeply-hatch-it server, retrieve the output, and display it in a new layer.",
  "B. V. Raghav", "B. V. Raghav", "2019",
  "<Image>/Bvr/Transport...",
  "*",
  [
    (PF_DIRNAME, "tmp", "Tmp Directory", "/tmp"),
    (PF_STRING, "host", "Hostname or IP", "ailab2"),
    (PF_STRING, "remote_path", "Remote Path", "/new_data/gpu/raghav/tmp/"),

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
  transport)  # second item is menu location

main()
