# RedM Camera View

A lightweight and simple free-camera utility for **RedM** that allows developers and server administrators to freely move around the world, adjust the camera orientation, and quickly copy camera coordinates for use in scripts, maps, scenes, and development.

## Features

* 🎥 Free camera movement
* 🖱️ Mouse-controlled camera rotation
* ⬆️⬇️ Vertical camera movement
* ⬅️➡️ Horizontal camera movement
* 🎯 Adjustable camera field of view
* 📍 Displays live camera coordinates
* 🔄 Displays camera rotation values
* 📋 `/copycamera` command for copying the current camera position
* 🖥️ Custom NUI dialog for copying camera data
* ⌨️ Simple `/cameraview` toggle command
* 🧩 Lightweight and dependency-free
* 🐎 Designed specifically for RedM / RDR3

## Commands

### `/cameraview`

Enables or disables the free camera.

While active, the camera displays its current position and rotation:

```lua
{ x = 1436.990, y = -1301.686, z = 78.821, rotx = 0.000, roty = 0.000, rotz = 284.553, fov = 50.0 }
```

### `/copycamera`

Opens the camera coordinate interface and allows the current camera configuration to be copied directly to the clipboard.

## Camera Controls

| Control | Action        |
| ------- | ------------- |
| `W`     | Move forward  |
| `S`     | Move backward |
| `A`     | Move left     |
