stow : subs
	stow -t ~/  -S user-home

subs :
	$(MAKE) -C user-home
