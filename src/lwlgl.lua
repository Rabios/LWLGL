lwlgl = {
    version = "v0.0.1",
	author = "Rabia Alhaffar",
	libs = {
	    gl = { "gl.lua", "bin/opengl32" },
		glu = { "glu.lua", "bin/glu32" },
		glut = { "glut.lua", "bin/freeglut" },
		sdl = { "sdl2.lua", "bin/SDL2" },
		sdl_sound = { "sdl_sound.lua", "bin/SDL_sound" },
		vulkan = { "vulkan.lua", "bin/vulkan-1" },
		devil = { "devil.lua", "bin/DevIL" },
		freetype = { "freetype.lua", "bin/freetype" },
		al = { "al.lua", "bin/OpenAL32" },
		cl = { "cl.lua", "bin/OpenCL"},
		physicsfs = { "physicsfs.lua", "bin/physfs" },
		chipmunk = { "chipmunk.lua", "bin/chipmunk" },
		assimp = { "assimp.lua", "bin/assimp" },
		collision = "collision.lua"
	}
}

lwlgl.init = function()
    dofile(lwlgl.libs.gl[1])
    dofile(lwlgl.libs.glu[1])
    dofile(lwlgl.libs.glut[1])
    dofile(lwlgl.libs.sdl[1])
	dofile(lwlgl.libs.sdl_sound[1])
    dofile(lwlgl.libs.vulkan[1])
    dofile(lwlgl.libs.devil[1])
    dofile(lwlgl.libs.freetype[1])
    dofile(lwlgl.libs.al[1])
    dofile(lwlgl.libs.cl[1])
    dofile(lwlgl.libs.physicsfs[1])
    dofile(lwlgl.libs.chipmunk[1])
    dofile(lwlgl.libs.assimp[1])
    dofile(lwlgl.libs.collision)
	
end