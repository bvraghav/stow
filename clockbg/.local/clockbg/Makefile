SHELL	:= /usr/bin/zsh

ifeq (,$(wildcard ./config.Makefile))
$(error "Create config.Makefile.")
endif

include ./config.Makefile

DIST	:= $(dir $(TARGET))

all : setbg

setbg : $(TARGET)
	DISPLAY=:0 feh --no-fehbg --bg-fill $(<)

$(TARGET) : assets/clockbg.in $(DIST) 
	@echo DIST: $(DIST)
	@echo TARGET: $(@)
	@cat $(<) | m4					\
	  -DBVR_DAY=`date +%A`				\
	  -DBVR_DATE="`date '+%d %b %Y'`"		\
	  -DBVR_TIME=`date '+%H:%M:%S'`			\
	| inkscape --pipe				\
	  --export-background="#000000"			\
          --export-background-opacity=1			\
	  --export-filename=$(@)

$(DIST) :
	-@mkdir -p $(DIST)
