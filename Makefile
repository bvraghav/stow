SRC_DIRS	:= $(shell find user-home -type d)
DST_DIRS	:= $(SRC_DIRS:user-home%=$(HOME)%)

stow : subs dirs
	stow -t ~/  -S user-home

subs :
	$(MAKE) -C user-home

dirs : $(DST_DIRS)
$(DST_DIRS) :
	mkdir -p $@
