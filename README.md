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
| `D`     | Move right    |
| `SPACE` | Move up     |
| `SHIFT` | Move down       |
| `Mouse` | Rotate camera |

## Camera Data

The script provides the following values:

* `x` — Camera X coordinate
* `y` — Camera Y coordinate
* `z` — Camera Z coordinate
* `rotx` — Camera pitch
* `roty` — Camera roll
* `rotz` — Camera heading/yaw
* `fov` — Camera field of view

This makes it easy to copy a camera position directly into other scripts or configuration files.

## Installation

1. Download or clone the resource into your RedM resources folder.
2. Add the resource to your `server.cfg`:

```cfg
ensure your_resource_name
```

3. Start your RedM server.
4. Use `/cameraview` in-game to activate the camera.

## Requirements

* RedM
* No external dependencies

## Screenshots

<img width="1544" height="972" alt="εικόνα" src="https://github.com/user-attachments/assets/552535ee-7aae-4f30-a2f9-a66cea2e181d" />
<img width="1651" height="1071" alt="εικόνα" src="https://github.com/user-attachments/assets/04aa1ae7-01d0-4562-8b51-f80066fa78db" />


### License

You are free to use and modify this resource according to the terms of the repository license.
