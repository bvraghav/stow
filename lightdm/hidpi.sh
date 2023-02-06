#! /bin/sh

echo Xft.dpi: 192 | xrdb -load -
export GDK_SCALE=2
export GDK_DPI_SCALE=0.8

in_path() {
  NEEDLE=:"$1":
  HAYSTACK=:$2:
  echo $HAYSTACK | grep $NEEDLE >/dev/null 2>&1
}

find_fonts() {
  find ~/.fonts -iname fonts.dir          \
    | while read F ; do dirname $F ; done \
    | tr '\n' ','                         \
    | sed 's/,$//g'
}

enable_touchpad_dell () {

  # Enable touch pad
  # ... on Dell Laptop
  # https://wiki.archlinux.org/title/Libinput
  xinput set-prop                              \
         'AlpsPS/2 ALPS DualPoint TouchPad'    \
         --type=int 'libinput Tapping Enabled' \
         1

  # Stick acceleration control
  xinput set-prop                              \
         'AlpsPS/2 ALPS DualPoint Stick'       \
         --type=float 'libinput Accel Speed'   \
         -0.2
}

enable_touchpad_thinkpad () {

  # Enable touch pad tapping
  # ... on Thinkpad
  # https://wiki.archlinux.org/title/Libinput
  xinput set-prop                              \
         'ELAN0678:00 04F3:3195 Touchpad'      \
         --type=int 'libinput Tapping Enabled' \
         1

  # Stick acceleration control
  xinput set-prop                              \
         'TPPS/2 Elan TrackPoint'              \
         --type=float 'libinput Accel Speed'   \
         -0.2
}

enable_touchpad () {
  case ${1} in
    dell) enable_touchpad_dell ;;
    thinkpad) enable_touchpad_thinkpad ;;
    *) echo "Not Implemented enable_touchpad for ${1}" ;;
  esac
}

startup() {
  # https://wiki.archlinux.org/title/Xorg/Keyboard_configuration
  setxkbmap gb

  # THINKPAD
  redshift -P -l 50:0 -b 0.75:0.55 -t 4500:3500 -o  &
  # systemctl start --user pulseaudio &
  xset b 10 1 10
  xset -dpms
  xset s off

  # # startup polkit agent
  # /usr/bin/lxpolkit &

  # configure fonts
  F=`find_fonts`
  xset +fp $F
  xset fp rehash

  enable_touchpad thinkpad
  
}



## startup
## -----------------------------------
startup
