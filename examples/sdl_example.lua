dofile("lwlgl.lua")
lwlgl.init()

play = true
color = { 0.0, 0.0, 0.0, 1.0 }

function main()
    sdl.SDL_Init(SDL_INIT_EVERYTHING)
    window = sdl.SDL_CreateWindow("Hit SPACE key to color!", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 800, 600, sdl.SDL_WINDOW_OPENGL)
    context = sdl.SDL_GL_CreateContext(window)
    
	e = ffi.new("SDL_Event")
    while play do
	    if sdl.SDL_PollEvent(e) then
	        if e.type == sdl.SDL_KEYDOWN then
	            if e.key.keysym.sym == sdl.SDLK_SPACE then
				    color = { 1.0, 0.0, 1.0, 1.0 }
				end
			elseif e.type == sdl.SDL_KEYUP then
			    if e.key.keysym.sym == sdl.SDLK_SPACE then
				    color = { 0.0, 0.0, 0.0, 1.0 }
				end
			elseif e.type == sdl.SDL_QUIT then
			    play = false
			end
		end

	    gl.glViewport(0, 0, 800, 600)
        gl.glClearColor(color[1], color[2], color[3], color[4])
        gl.glClear(gl.GL_COLOR_BUFFER_BIT)

        sdl.SDL_GL_SwapWindow(window)
		sdl.SDL_Delay(10)
    end
    
	sdl.SDL_DestroyWindow(window)
    sdl.SDL_Quit()
end

main()