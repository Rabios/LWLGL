# Using LWLGL from source code

Include `lwlgl.lua` then any file(s) from `src` folder via dofile function,For example:

```lua
dofile("src/lwlgl.lua")

-- Change directories
lwlgl.libs.gl[1] = "src/gl.lua"
lwlgl.libs.gl[2] = "dlls/opengl32"

-- Load OpenGL :)
dofile("src/gl.lua")

-- Do it!
```

### NOTES

1. LWLGL libs loaded directly,So modify directories before loading any bindings!
2. LWLGL source doesn't have `load_<something>` functions,Only `lwlgl.init()`
3. LWLGL might fail to load something and gives error if file not found if you use `lwlgl.init()` from source,Be careful!