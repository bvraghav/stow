# Lightdm Setup Configuration

**Liable to break. Use with caution**

Add this to `/etc/lightdm/lightdm.conf`
```conf
display-setup-script = /path/to/this/folder/hidpi.sh
```

And restart the display manager, like:
```sh
sudo systemctl restart lightdm.service
```
