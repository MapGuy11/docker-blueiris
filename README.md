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
  -e BLUEIRIS_VERSION=4 `#optional` \
  jshridha/blueiris
```
## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p novnc-port:8080` | For noVNC Web Interface |
| `-p vnc-port:5900` | For VNC Access Instead |
| `-p blueiris-webserver-port:81` | For BlueIris Web Interface |
| `-e BLUEIRIS_VERSION=4` | Optionally If You Want BlueIris 4 Instead Of Default BlueIris 5 |
| `-v /root/prefix32` | This Is To Store BlueIris Information And Other Dependecies |



# Known Issues:
* Saving and restoring settings backup via the BlueIris interface does not work!
