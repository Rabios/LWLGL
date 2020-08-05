# Getting Started

Create a lua file beside `lwlgl.lua` and `bin` folder,Name it `glut_test.lua`,With the following:

```lua
-- Require LWLGL library
dofile("lwlgl.lua")
lwlgl.init()

-- Initialize GLUT
init_glut()

-- Create GLUT window with title
glut.glutInitDisplayMode(require("bit").bor(glut.GLUT_DEPTH, glut.GLUT_DOUBLE, glut.GLUT_RGBA))
glut.glutInitWindowPosition(100, 100)
glut.glutInitWindowSize(320, 320)
glut.glutCreateWindow("Lighthouse3D- GLUT Tutorial")

-- Render
function render()
    -- Clear graphics
    gl.glClear(require("bit").bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))
	
	-- Draw white,Filled triangle
	gl.glBegin(gl.GL_TRIANGLES)
		gl.glVertex3f(-0.5, -0.5, 0.0)
		gl.glVertex3f(0.5, 0.0, 0.0)
		gl.glVertex3f(0.0, 0.5, 0.0)
	gl.glEnd()

    -- Swap buffers
    glut.glutSwapBuffers()
end

-- GLUT loop
glut.glutDisplayFunc(render)
glut.glutMainLoop()
```

Then open command prompt from directory you created the file,type for example: `path\to\luajit.exe glut_test.lua`

If a window with white triangle appeared,Then congrats!
