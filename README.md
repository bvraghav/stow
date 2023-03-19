# My Stow 

To get an overview of what Stow is, [click
here](https://www.gnu.org/software/stow/).

Currently, I store the following configurations here,

1. **The dot files in user home**  
To install, them simply issue from the command line  
```sh
stow -t ~/  -S user-home
```

2. **GIMP Plugins**  
To install one needs to know the current version of
GIMP. But that can also be inferred from the shell. So
the gimp plugins may be installed as follows.  
```sh
VER=`gimp --version | tr ' ' '\n' | tac | head -1 | cut -d. -f 1,2`
stow -t ~/.config/GIMP/${VER}/plug-ins -S gimp-plugins
```

3. **NPMRC**  
[Please use nvm](https://github.com/nvm-sh/nvm) instead
of system install of node. That is far easier.  
However, for some reason, if at all a system install of
node is required, and there exists a need for defining
a global prefix directory so that `npm install -g`
works, copy the config from [`.npmrc` here](.npmrc)

4. **Setting Default Desktop**
```sh
xdg-settings set default-web-browser chromium-P.desktop
```
