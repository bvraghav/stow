#! /bin/zsh
## ----------------------------------------------------
##
## Functions
## ----------------------------------------------------

## Saisha's workspace access
## ----------------------------------------------------
saisha () {
  cd ~/svr/ailab/anda-saisha
  [ `ls | wc -l` -lt 1 ] && {
    sshfs raghav@ailab1:/nfs/151/gpu/saisha .
  }
}

saisha_show_masks() {
  n_epochs() {
    ls -t | \
      head -n1 | \
      awk -F_ '{ print substr($1, 6) }'
  }

  AWK_TMP=/tmp/awk-$(uuidgen | cut -d- -f1)
  cat > $AWK_TMP <<EOF
function fake_B(n,m) {
  return "epoch" n "_fake_B_" m ".png" ;
}
function fake_C(n) {
  return "epoch" n "_fake_C.png" ;
}

{
  n = sprintf("%03d",\$1) ;
  for (i=1; i<=4; ++i)
    print fake_B(n,i) ;
  print fake_C(n) ;
}
EOF

  seq 1 `n_epochs` | \
    awk -f $AWK_TMP |  \
    feh -m -f - -.Z -y 64 -W 960 -j ~/tmp

  rm $AWK_TMP
}
