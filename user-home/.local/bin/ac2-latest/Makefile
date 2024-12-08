SHELL           := /usr/bin/zsh

REPO		:= ${HOME}/src/ac2

THIS_DIR	:= ${PWD}

VER		:= $(shell	\
  cd $(REPO);			\
  gh release view		\
  | grep '^tag'			\
  | cut -d '	' -f2		\
)

ac2-SNAPSHOT.jar : $(REPO) $(VER)
	cd $(REPO);		\
	gh release download	\
	  --clobber		\
	  -O '$(THIS_DIR)/${@}'	\
	  -p '*.jar'

$(VER) : $(REPO)
	touch $(@)

