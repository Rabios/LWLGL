dofile("lwlgl.lua")
lwlgl.init()
init_glut()

glut.glutInitDisplayMode(require("bit").bor(glut.GLUT_DEPTH, glut.GLUT_DOUBLE, glut.GLUT_RGBA))
glut.glutInitWindowPosition(100, 100)
glut.glutInitWindowSize(320, 320)
glut.glutCreateWindow("Lighthouse3D- GLUT Tutorial")

function render()
    gl.glClear(require("bit").bor(gl.GL_COLOR_BUFFER_BIT, gl.GL_DEPTH_BUFFER_BIT))

	gl.glBegin(gl.GL_TRIANGLES)
		gl.glVertex3f(-0.5, -0.5, 0.0)
		gl.glVertex3f(0.5, 0.0, 0.0)
		gl.glVertex3f(0.0, 0.5, 0.0)
	gl.glEnd()

    glut.glutSwapBuffers()
end

glut.glutDisplayFunc(render)
glut.glutMainLoop()