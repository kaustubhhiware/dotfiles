function unset_proxy -d 'unset proxy'
	gsettings set org.gnome.system.proxy mode 'none'
	gsettings reset org.gnome.system.proxy.http host
	gsettings reset org.gnome.system.proxy.http port
	gsettings reset org.gnome.system.proxy.https port
	gsettings reset org.gnome.system.proxy.https host
end
