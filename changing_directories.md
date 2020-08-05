# Changing directories in LWLGL

Changing load directories to load by LWLGL isn't hard so:

1. If you run LWLGL from source, You can modify source and dll load path.
2. Else if you run LWLGL from build,You can only modify dll load path.

### Using LWLGL from source

```lua
dofile("lwlgl.lua")
lwlgl.libs.gl[1] = "src/gl.lua"  -- Changed OpenGL Lua bindings path
lwlgl.libs.gl[2] = "opengl32"    -- Changed OpenGL DLL load path
lwlgl.init()
```

### Using LWLGL from build

```lua
dofile("lwlgl.lua")
lwlgl.libs.gl[2] = "gamefiles/opengl32" -- Same as we did before
lwlgl.init()
```