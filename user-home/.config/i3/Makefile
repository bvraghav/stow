SHELL		:= /usr/bin/zsh


I3_CONFIG	:= ${XDG_CONFIG_HOME}/i3/config

I3_HTML		:= ${XDG_CONFIG_HOME}/i3/keybindings.html

PAGE_TITLE	:= i3 Keybindings


# Neat space and nl trick from
# https://stackoverflow.com/a/4735256/4366367
# ----------------------------------------------------
NULL :=
SPACE := ${NULL} ${NULL}
${SPACE} := ${SPACE}

define \n


endef
# ----------------------------------------------------



ks		 = <span class="keystroke"><kbd>$1</kbd></span>
lshift		 = <span class="lshift">\&nbsp;</span>
as		 = <span class="$1">$2</span>

VERBS		+= kill focus move toggle mode_toggle grow
VERBS		+= reload restart resize shrink exit split
VERBS		+= layout

verbs		 = $(subst __,${ },$(subst ${ },\|,${VERBS}))

NOUNS		+= next prev left down up right fullscreen
NOUNS		+= parent child workspace__number container
NOUNS		+= floating height width stacking tabbed

nouns		 = $(subst __,${ },$(subst ${ },\|,${NOUNS}))

SID_RE		+= \( --no-startup-id\)\?
ARGS_RE		+= \(\([^\"]\+\|\"[^\"]*\"\)*\)
CNAME_RE	+= \([^ ]\+\)
CMD_RE		+= \"\?${CNAME_RE}${ARGS_RE}\"\?
EXEC_RE		+= exec${SID_RE} ${CMD_RE}

KW_HTML		+= $(call as,verb exec,exec)
CNAME_HTML	+= <span class="name">\2</span>
CMD_HTML	+= <kbd class="prog">${CNAME_HTML} \3</kbd>

EXEC_HTML	+= ${KW_HTML} ${CMD_HTML}

EXEC_SCRIPT	+= /exec /{
EXEC_SCRIPT	+= s,${EXEC_RE},${EXEC_HTML},;
EXEC_SCRIPT	+= t };


SED_SCRIPT	+= /^\([ ]*bindsym\|mode\)/!d;
SED_SCRIPT	+= s,^[ ]\+,$(lshift),;
SED_SCRIPT	+= s,bindsym \([^ ]\+\) ,$(call ks,\1),g;
SED_SCRIPT	+= s,mode [\"\$$]*\([^\" ]\+\)\([\" ]\|$$\),$(call as,noun exec,mode) <kbd>\&lt;\1\&gt;</kbd>,g;
SED_SCRIPT	+= s,\$$\([a-zA-Z0-9_]\+\),<kbd>\&lt;\1\&gt;</kbd>,g;
SED_SCRIPT	+= s,^.*$$,<p>&</p>,g;
SED_SCRIPT	+= s, to ,⟶,g;
SED_SCRIPT	+= ${EXEC_SCRIPT}
SED_SCRIPT	+= s,\($(nouns)\),$(call as,noun,\1),g;
SED_SCRIPT	+= s,\($(verbs)\),$(call as,verb,\1),g;

S1		+= .keystroke {
S1		+=   padding-right: 1em;
S1		+=   display: inline-block;
S1		+=   width: 10em;
S1		+= } 

S2		+= .lshift {
S2		+=   padding-left: 2em;
S2		+= } 

S3		+= kbd {
S3		+=   text-transform: uppercase;
# S3		+=   font-size: 1.0rem;
S3		+= } 

S4		+= .verb {
S4		+=   font-style: italic;
S4		+=   color: \#5a369c;
S4		+= } 

S5		+= .noun {
S5		+=   color: \#568020;
S5		+= } 

S6		+= .prog .name {
S6		+=   font-weight: bold;
S6		+=   color: \#b26104;
S6		+= } 

S7		+= .prog {
S7		+=   text-transform: none;
S7		+=   color: \#666462;
# S7		+=   font-size: 0.9rem;
S7		+=   padding-left: 0.5rem;
S7		+= } 

S8		+= .exec {
S8		+=   font-style:normal !important;
S8		+=   font-size:1.3rem;
S8		+=   text-transform: lowercase;
S8		+=   font-variant: common-ligatures small-caps;
S8		+= } 

S9		+= p {
S9		+=   margin-top: 0; margin-bottom: 0.25rem;
S9		+= } 

define WRITE_CSS_STYLES
echo "<style>" >>$1
echo "${S1}" >>$1
echo "${S2}" >>$1
echo "${S3}" >>$1
echo "${S4}" >>$1
echo "${S5}" >>$1
echo "${S6}" >>$1
echo "${S7}" >>$1
echo "${S8}" >>$1
echo "${S9}" >>$1
echo "</style>" >>$1
endef

define WRITE_TITLE
echo "<title>${PAGE_TITLE}</title>" >>$1
endef

define WRITE_H1
echo "<h1>${PAGE_TITLE}</h1>" >>$1
endef

.PHONY:
all :${I3_HTML}
	chromium 					\
	  --user-data-dir=${HOME}/.config/chromium-P 	\
	  --incognito 					\
	  file://${<}


%/keybindings.html : %/config
	rm ${@}
	$(call WRITE_CSS_STYLES,${@})
	$(call WRITE_TITLE,${@})
	$(call WRITE_H1,${@})
	cat ${<} 			\
	  | sed '${SED_SCRIPT}' 	\
	  | tee -a ${@}
	@echo VERBS:"'$(verbs)'"
	@echo NOUNS:"'$(nouns)'"
