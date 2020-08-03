## docker-blueiris

This is a Container for BlueIris based on [solarkennedy/wine-x11-novnc-docker
](https://github.com/solarkennedy/wine-x11-novnc-docker)

This container runs:

* Xvfb - X11 in a virtual framebuffer
* x11vnc - A VNC server that scrapes the above X11 server
* [noNVC](https://github.com/novnc/noVNC) - A HTML5 canvas VNC viewer
* Fluxbox - A small window manager
* [WineHQ](https://www.winehq.org) - A compatibility layer to run Windows executables on Linux
* [BlueIris](https://blueirissoftware.com) - The Official Windows BlueIris executable
```
docker run -d \
  --name="BlueIris" \
  -p novnc-port:8080 \
  -p vnc-port:5900 \
  -p blueiris-webserver-port:81 \
  -v /path/to/data:/root/prefix32:rw \
  jshridha/blueiris
```
# Known Issues:
* Saving and restoring settings backup via the BlueIris interface does not work!
