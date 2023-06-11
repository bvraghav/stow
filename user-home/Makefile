SHELL           := /usr/bin/zsh

FILES	+= .Xresources

all : $(FILES) append-to-gitignore

.% : .%.global.in .%.local
	@echo 'INFO: Creating: $(@) from: $(^)'
	@cat $(^) > $(@)

%.local : %.local.sample
	@echo 'WARNING: New locals config available: $(<)'
	@echo ''
	@-[ -f $(@) ] && diff $(<) $(@)
	@echo ''
	@if [ -f $(@) ]  \
	  ; then \
	    echo "To ignore: \`touch $(@)'" \
	  ; else \
	    echo "Try: \`cp $$PWD/$(<) $$PWD/$(@)'" \
	  ; fi
	@echo ''
	@exit 64
.SECONDARY: %.local

append-to-gitignore : .gitignore $(FILES)
	@$(foreach FNAME,$(FILES),\
	  if [ -z `cat .gitignore | grep -o $(FNAME)` ] ; then \
	    { echo $(FNAME) >> .gitignore } ; \
	  fi \
	)
	@echo '[INFO] $(@): DONE'

.gitignore :
	touch $(@)
