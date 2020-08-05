-- LWLGL library
--[[

MIT License

Copyright (c) 2020 - 2021 Rabia Alhaffar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]
UINT64_MAX = 0xffffffffffffffffULL
MAX_COORD = 9.9999999999999998e+149
ffi = require("ffi")
bit = require("bit")
math = require("math")
bor  = bit.bor
band = bit.band

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
		cl = { "cl.lua", "bin/OpenCL" },
		physicsfs = { "physicsfs.lua", "bin/physfs" },
		chipmunk = { "chipmunk.lua", "bin/chipmunk" },
		assimp = { "assimp.lua", "bin/assimp" }
	}
}

function load_gl()

ffi.cdef([[

// gl.h
/*
 * Mesa 3-D graphics library
 * Version:  7.6
 *
 * Copyright (C) 1999-2006  Brian Paul   All Rights Reserved.
 * Copyright (C) 2009  VMware, Inc.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * BRIAN PAUL BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


enum {
    GL_VERSION_1_1      = 1,
    GL_VERSION_1_2      = 1,
    GL_VERSION_1_3      = 1,
    GL_ARB_imaging      = 1,
    GL_GLEXT_PROTOTYPES = 1
};

typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef void GLvoid;
typedef signed char	GLbyte;
typedef short GLshort;
typedef int GLint;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef int GLsizei;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef double GLclampd;
typedef void GLhandleARB;
typedef const char* GLcharARB;
typedef int GLclampx;

enum {
    GL_FALSE = 0x0,
    GL_TRUE  = 0x1
};

enum {
    GL_BYTE            = 0x1400,
    GL_UNSIGNED_BYTE   = 0x1401,
    GL_SHORT           = 0x1402,
    GL_UNSIGNED_SHORT  = 0x1403,
    GL_INT             = 0x1404,
    GL_UNSIGNED_INT    = 0x1405,
    GL_FLOAT           = 0x1406,
    GL_2_BYTES         = 0x1407,
    GL_3_BYTES         = 0x1408,
    GL_4_BYTES         = 0x1409,
    GL_DOUBLE          = 0x140A
};

enum {
    GL_POINTS			 = 0x0000,
    GL_LINES			 = 0x0001,
    GL_LINE_LOOP		 = 0x0002,
    GL_LINE_STRIP		 = 0x0003,
    GL_TRIANGLES		 = 0x0004,
    GL_TRIANGLE_STRIP	 = 0x0005,
    GL_TRIANGLE_FAN		 = 0x0006,
    GL_QUADS			 = 0x0007,
    GL_QUAD_STRIP		 = 0x0008,
    GL_POLYGON			 = 0x0009
};

enum {
    GL_VERTEX_ARRAY				    = 0x8074,
    GL_NORMAL_ARRAY				    = 0x8075,
    GL_COLOR_ARRAY				    = 0x8076,
    GL_INDEX_ARRAY				    = 0x8077,
    GL_TEXTURE_COORD_ARRAY			= 0x8078,
    GL_EDGE_FLAG_ARRAY			    = 0x8079,
    GL_VERTEX_ARRAY_SIZE			= 0x807A,
    GL_VERTEX_ARRAY_TYPE			= 0x807B,
    GL_VERTEX_ARRAY_STRIDE			= 0x807C,
    GL_NORMAL_ARRAY_TYPE			= 0x807E,
    GL_NORMAL_ARRAY_STRIDE			= 0x807F,
    GL_COLOR_ARRAY_SIZE			    = 0x8081,
    GL_COLOR_ARRAY_TYPE			    = 0x8082,
    GL_COLOR_ARRAY_STRIDE			= 0x8083,
    GL_INDEX_ARRAY_TYPE			    = 0x8085,
    GL_INDEX_ARRAY_STRIDE			= 0x8086,
    GL_TEXTURE_COORD_ARRAY_SIZE		= 0x8088,
    GL_TEXTURE_COORD_ARRAY_TYPE		= 0x8089,
    GL_TEXTURE_COORD_ARRAY_STRIDE   = 0x808A,
    GL_EDGE_FLAG_ARRAY_STRIDE		= 0x808C,
    GL_VERTEX_ARRAY_POINTER			= 0x808E,
    GL_NORMAL_ARRAY_POINTER			= 0x808F,
    GL_COLOR_ARRAY_POINTER			= 0x8090,
    GL_INDEX_ARRAY_POINTER			= 0x8091,
    GL_TEXTURE_COORD_ARRAY_POINTER	= 0x8092,
    GL_EDGE_FLAG_ARRAY_POINTER		= 0x8093,
    GL_V2F					        = 0x2A20,
    GL_V3F					        = 0x2A21,
    GL_C4UB_V2F				        = 0x2A22,
    GL_C4UB_V3F				        = 0x2A23,
    GL_C3F_V3F				        = 0x2A24,
    GL_N3F_V3F				        = 0x2A25,
    GL_C4F_N3F_V3F				    = 0x2A26,
    GL_T2F_V3F				        = 0x2A27,
    GL_T4F_V4F				        = 0x2A28,
    GL_T2F_C4UB_V3F				    = 0x2A29,
    GL_T2F_C3F_V3F				    = 0x2A2A,
    GL_T2F_N3F_V3F				    = 0x2A2B,
    GL_T2F_C4F_N3F_V3F			    = 0x2A2C,
    GL_T4F_C4F_N3F_V4F			    = 0x2A2D
};

enum {
    GL_MATRIX_MODE				= 0x0BA0,
    GL_MODELVIEW				= 0x1700,
    GL_PROJECTION				= 0x1701,
    GL_TEXTURE				    = 0x1702,
};

enum {
    GL_POINT_SMOOTH				= 0x0B10,
    GL_POINT_SIZE				= 0x0B11,
    GL_POINT_SIZE_GRANULARITY   = 0x0B13,
    GL_POINT_SIZE_RANGE			= 0x0B12
};

enum {
    GL_LINE_SMOOTH				= 0x0B20,
    GL_LINE_STIPPLE				= 0x0B24,
    GL_LINE_STIPPLE_PATTERN		= 0x0B25,
    GL_LINE_STIPPLE_REPEAT		= 0x0B26,
    GL_LINE_WIDTH				= 0x0B21,
    GL_LINE_WIDTH_GRANULARITY	= 0x0B23,
    GL_LINE_WIDTH_RANGE			= 0x0B22
};

enum {
    GL_POINT				    = 0x1B00,
    GL_LINE					    = 0x1B01,
    GL_FILL					    = 0x1B02,
    GL_CW					    = 0x0900,
    GL_CCW					    = 0x0901,
    GL_FRONT				    = 0x0404,
    GL_BACK					    = 0x0405,
    GL_POLYGON_MODE				= 0x0B40,
    GL_POLYGON_SMOOTH			= 0x0B41,
    GL_POLYGON_STIPPLE		    = 0x0B42,
    GL_EDGE_FLAG				= 0x0B43,
    GL_CULL_FACE				= 0x0B44,
    GL_CULL_FACE_MODE			= 0x0B45,
    GL_FRONT_FACE				= 0x0B46,
    GL_POLYGON_OFFSET_FACTOR	= 0x8038,
    GL_POLYGON_OFFSET_UNITS		= 0x2A00,
    GL_POLYGON_OFFSET_POINT		= 0x2A01,
    GL_POLYGON_OFFSET_LINE		= 0x2A02,
    GL_POLYGON_OFFSET_FILL		= 0x8037
};

enum {
    GL_COMPILE				= 0x1300,
    GL_COMPILE_AND_EXECUTE	= 0x1301,
    GL_LIST_BASE			= 0x0B32,
    GL_LIST_INDEX			= 0x0B33,
    GL_LIST_MODE			= 0x0B30
};

enum {
    GL_NEVER				= 0x0200,
    GL_LESS					= 0x0201,
    GL_EQUAL				= 0x0202,
    GL_LEQUAL				= 0x0203,
    GL_GREATER				= 0x0204,
    GL_NOTEQUAL				= 0x0205,
    GL_GEQUAL				= 0x0206,
    GL_ALWAYS				= 0x0207,
    GL_DEPTH_TEST			= 0x0B71,
    GL_DEPTH_BITS			= 0x0D56,
    GL_DEPTH_CLEAR_VALUE	= 0x0B73,
    GL_DEPTH_FUNC			= 0x0B74,
    GL_DEPTH_RANGE			= 0x0B70,
    GL_DEPTH_WRITEMASK		= 0x0B72,
    GL_DEPTH_COMPONENT		= 0x1902
};

enum {
    GL_LIGHTING				     = 0x0B50,
    GL_LIGHT0				     = 0x4000,
    GL_LIGHT1				     = 0x4001,
    GL_LIGHT2				     = 0x4002,
    GL_LIGHT3			         = 0x4003,
    GL_LIGHT4				     = 0x4004,
    GL_LIGHT5				     = 0x4005,
    GL_LIGHT6				     = 0x4006,
    GL_LIGHT7				     = 0x4007,
    GL_SPOT_EXPONENT		     = 0x1205,
    GL_SPOT_CUTOFF				 = 0x1206,
    GL_CONSTANT_ATTENUATION		 = 0x1207,
    GL_LINEAR_ATTENUATION		 = 0x1208,
    GL_QUADRATIC_ATTENUATION	 = 0x1209,
    GL_AMBIENT				     = 0x1200,
    GL_DIFFUSE				     = 0x1201,
    GL_SPECULAR				     = 0x1202,
    GL_SHININESS				 = 0x1601,
    GL_EMISSION			 	     = 0x1600,
    GL_POSITION				     = 0x1203,
    GL_SPOT_DIRECTION			 = 0x1204,
    GL_AMBIENT_AND_DIFFUSE		 = 0x1602,
    GL_COLOR_INDEXES			 = 0x1603,
    GL_LIGHT_MODEL_TWO_SIDE		 = 0x0B52,
    GL_LIGHT_MODEL_LOCAL_VIEWER	 = 0x0B51,
    GL_LIGHT_MODEL_AMBIENT		 = 0x0B53,
    GL_SHADE_MODEL				 = 0x0B54,
    GL_FLAT					     = 0x1D00,
    GL_SMOOTH				     = 0x1D01,
    GL_COLOR_MATERIAL			 = 0x0B57,
    GL_COLOR_MATERIAL_FACE		 = 0x0B55,
    GL_COLOR_MATERIAL_PARAMETER	 = 0x0B56,
    GL_NORMALIZE				 = 0x0BA1
};

enum {
    GL_CLIP_PLANE0				= 0x3000,
    GL_CLIP_PLANE1				= 0x3001,
    GL_CLIP_PLANE2				= 0x3002,
    GL_CLIP_PLANE3				= 0x3003,
    GL_CLIP_PLANE4				= 0x3004,
    GL_CLIP_PLANE5				= 0x3005
};

enum {
    GL_ACCUM_RED_BITS		= 0x0D58,
    GL_ACCUM_GREEN_BITS		= 0x0D59,
    GL_ACCUM_BLUE_BITS		= 0x0D5A,
    GL_ACCUM_ALPHA_BITS		= 0x0D5B,
    GL_ACCUM_CLEAR_VALUE	= 0x0B80,
    GL_ACCUM				= 0x0100,
    GL_ADD					= 0x0104,
    GL_LOAD					= 0x0101,
    GL_MULT					= 0x0103,
    GL_RETURN				= 0x0102
};

enum {
    GL_ALPHA_TEST				= 0x0BC0,
    GL_ALPHA_TEST_REF			= 0x0BC2,
    GL_ALPHA_TEST_FUNC			= 0x0BC1
};

enum {
    GL_BLEND				 = 0x0BE2,
    GL_BLEND_SRC			 = 0x0BE1,
    GL_BLEND_DST			 = 0x0BE0,
    GL_ZERO					 = 0x0,
    GL_ONE					 = 0x1,
    GL_SRC_COLOR			 = 0x0300,
    GL_ONE_MINUS_SRC_COLOR	 = 0x0301,
    GL_SRC_ALPHA			 = 0x0302,
    GL_ONE_MINUS_SRC_ALPHA	 = 0x0303,
    GL_DST_ALPHA			 = 0x0304,
    GL_ONE_MINUS_DST_ALPHA	 = 0x0305,
    GL_DST_COLOR			 = 0x0306,
    GL_ONE_MINUS_DST_COLOR	 = 0x0307,
    GL_SRC_ALPHA_SATURATE	 = 0x0308
};

enum {
    GL_FEEDBACK				= 0x1C01,
    GL_RENDER				= 0x1C00,
    GL_SELECT				= 0x1C02
};

enum {
    GL_2D					    = 0x0600,
    GL_3D					    = 0x0601,
    GL_3D_COLOR				    = 0x0602,
    GL_3D_COLOR_TEXTURE			= 0x0603,
    GL_4D_COLOR_TEXTURE			= 0x0604,
    GL_POINT_TOKEN				= 0x0701,
    GL_LINE_TOKEN				= 0x0702,
    GL_LINE_RESET_TOKEN			= 0x0707,
    GL_POLYGON_TOKEN			= 0x0703,
    GL_BITMAP_TOKEN				= 0x0704,
    GL_DRAW_PIXEL_TOKEN			= 0x0705,
    GL_COPY_PIXEL_TOKEN			= 0x0706,
    GL_PASS_THROUGH_TOKEN		= 0x0700,
    GL_FEEDBACK_BUFFER_POINTER	= 0x0DF0,
    GL_FEEDBACK_BUFFER_SIZE		= 0x0DF1,
    GL_FEEDBACK_BUFFER_TYPE		= 0x0DF2
};

enum {
    GL_SELECTION_BUFFER_POINTER		= 0x0DF3,
    GL_SELECTION_BUFFER_SIZE		= 0x0DF4
};

enum {
    GL_FOG				    = 0x0B60,
    GL_FOG_MODE				= 0x0B65,
    GL_FOG_DENSITY			= 0x0B62,
    GL_FOG_COLOR			= 0x0B66,
    GL_FOG_INDEX			= 0x0B61,
    GL_FOG_START			= 0x0B63,
    GL_FOG_END				= 0x0B64,
    GL_LINEAR				= 0x2601,
    GL_EXP					= 0x0800,
    GL_EXP2					= 0x0801
};

enum {
    GL_LOGIC_OP				= 0x0BF1,
    GL_INDEX_LOGIC_OP		= 0x0BF1,
    GL_COLOR_LOGIC_OP		= 0x0BF2,
    GL_LOGIC_OP_MODE		= 0x0BF0,
    GL_CLEAR				= 0x1500,
    GL_SET					= 0x150F,
    GL_COPY					= 0x1503,
    GL_COPY_INVERTED		= 0x150C,
    GL_NOOP					= 0x1505,
    GL_INVERT				= 0x150A,
    GL_AND					= 0x1501,
    GL_NAND					= 0x150E,
    GL_OR					= 0x1507,
    GL_NOR					= 0x1508,
    GL_XOR					= 0x1506,
    GL_EQUIV				= 0x1509,
    GL_AND_REVERSE			= 0x1502,
    GL_AND_INVERTED			= 0x1504,
    GL_OR_REVERSE			= 0x150B,
    GL_OR_INVERTED			= 0x150D
};

enum {
    GL_STENCIL_BITS				= 0x0D57,
    GL_STENCIL_TEST				= 0x0B90,
    GL_STENCIL_CLEAR_VALUE		= 0x0B91,
    GL_STENCIL_FUNC				= 0x0B92,
    GL_STENCIL_VALUE_MASK		= 0x0B93,
    GL_STENCIL_FAIL				= 0x0B94,
    GL_STENCIL_PASS_DEPTH_FAIL	= 0x0B95,
    GL_STENCIL_PASS_DEPTH_PASS	= 0x0B96,
    GL_STENCIL_REF				= 0x0B97,
    GL_STENCIL_WRITEMASK		= 0x0B98,
    GL_STENCIL_INDEX			= 0x1901,
    GL_KEEP					    = 0x1E00,
    GL_REPLACE				    = 0x1E01,
    GL_INCR					    = 0x1E02,
    GL_DECR					    = 0x1E03
};

enum {
    GL_NONE					= 0x0,
    GL_LEFT					= 0x0406,
    GL_RIGHT				= 0x0407,
    GL_FRONT_AND_BACK		= 0x0408
};

enum {
    GL_FRONT_LEFT			= 0x0400,
    GL_FRONT_RIGHT			= 0x0401,
    GL_BACK_LEFT			= 0x0402,
    GL_BACK_RIGHT			= 0x0403,
    GL_AUX0					= 0x0409,
    GL_AUX1					= 0x040A,
    GL_AUX2					= 0x040B,
    GL_AUX3					= 0x040C,
    GL_COLOR_INDEX			= 0x1900,
    GL_RED					= 0x1903,
    GL_GREEN				= 0x1904,
    GL_BLUE					= 0x1905,
    GL_ALPHA				= 0x1906,
    GL_LUMINANCE			= 0x1909,
    GL_LUMINANCE_ALPHA		= 0x190A,
    GL_ALPHA_BITS			= 0x0D55,
    GL_RED_BITS				= 0x0D52,
    GL_GREEN_BITS			= 0x0D53,
    GL_BLUE_BITS			= 0x0D54,
    GL_INDEX_BITS			= 0x0D51,
    GL_SUBPIXEL_BITS		= 0x0D50,
    GL_AUX_BUFFERS			= 0x0C00,
    GL_READ_BUFFER			= 0x0C02,
    GL_DRAW_BUFFER			= 0x0C01,
    GL_DOUBLEBUFFER			= 0x0C32,
    GL_STEREO				= 0x0C33,
    GL_BITMAP				= 0x1A00,
    GL_COLOR				= 0x1800,
    GL_DEPTH				= 0x1801,
    GL_STENCIL				= 0x1802,
    GL_DITHER				= 0x0BD0,
    GL_RGB					= 0x1907,
    GL_RGBA					= 0x1908
};

enum {
    GL_MAX_LIST_NESTING			        = 0x0B31,
    GL_MAX_EVAL_ORDER			        = 0x0D30,
    GL_MAX_LIGHTS				        = 0x0D31,
    GL_MAX_CLIP_PLANES			        = 0x0D32,
    GL_MAX_TEXTURE_SIZE			        = 0x0D33,
    GL_MAX_PIXEL_MAP_TABLE			    = 0x0D34,
    GL_MAX_ATTRIB_STACK_DEPTH	        = 0x0D35,
    GL_MAX_MODELVIEW_STACK_DEPTH		= 0x0D36,
    GL_MAX_NAME_STACK_DEPTH			    = 0x0D37,
    GL_MAX_PROJECTION_STACK_DEPTH		= 0x0D38,
    GL_MAX_TEXTURE_STACK_DEPTH		    = 0x0D39,
    GL_MAX_VIEWPORT_DIMS			    = 0x0D3A,
    GL_MAX_CLIENT_ATTRIB_STACK_DEPTH	= 0x0D3B
};

enum {
    GL_ATTRIB_STACK_DEPTH			    = 0x0BB0,
    GL_CLIENT_ATTRIB_STACK_DEPTH		= 0x0BB1,
    GL_COLOR_CLEAR_VALUE			    = 0x0C22,
    GL_COLOR_WRITEMASK			        = 0x0C23,
    GL_CURRENT_INDEX			        = 0x0B01,
    GL_CURRENT_COLOR			        = 0x0B00,
    GL_CURRENT_NORMAL			        = 0x0B02,
    GL_CURRENT_RASTER_COLOR			    = 0x0B04,
    GL_CURRENT_RASTER_DISTANCE		    = 0x0B09,
    GL_CURRENT_RASTER_INDEX			    = 0x0B05,
    GL_CURRENT_RASTER_POSITION		    = 0x0B07,
    GL_CURRENT_RASTER_TEXTURE_COORDS	= 0x0B06,
    GL_CURRENT_RASTER_POSITION_VALID	= 0x0B08,
    GL_CURRENT_TEXTURE_COORDS		    = 0x0B03,
    GL_INDEX_CLEAR_VALUE			    = 0x0C20,
    GL_INDEX_MODE				        = 0x0C30,
    GL_INDEX_WRITEMASK			        = 0x0C21,
    GL_MODELVIEW_MATRIX			        = 0x0BA6,
    GL_MODELVIEW_STACK_DEPTH		    = 0x0BA3,
    GL_NAME_STACK_DEPTH			        = 0x0D70,
    GL_PROJECTION_MATRIX			    = 0x0BA7,
    GL_PROJECTION_STACK_DEPTH		    = 0x0BA4,
    GL_RENDER_MODE				        = 0x0C40,
    GL_RGBA_MODE				        = 0x0C31,
    GL_TEXTURE_MATRIX			        = 0x0BA8,
    GL_TEXTURE_STACK_DEPTH			    = 0x0BA5,
    GL_VIEWPORT				            = 0x0BA2
};

enum {
    GL_AUTO_NORMAL				= 0x0D80,
    GL_MAP1_COLOR_4				= 0x0D90,
    GL_MAP1_INDEX				= 0x0D91,
    GL_MAP1_NORMAL				= 0x0D92,
    GL_MAP1_TEXTURE_COORD_1		= 0x0D93,
    GL_MAP1_TEXTURE_COORD_2		= 0x0D94,
    GL_MAP1_TEXTURE_COORD_3		= 0x0D95,
    GL_MAP1_TEXTURE_COORD_4		= 0x0D96,
    GL_MAP1_VERTEX_3			= 0x0D97,
    GL_MAP1_VERTEX_4			= 0x0D98,
    GL_MAP2_COLOR_4				= 0x0DB0,
    GL_MAP2_INDEX				= 0x0DB1,
    GL_MAP2_NORMAL				= 0x0DB2,
    GL_MAP2_TEXTURE_COORD_1		= 0x0DB3,
    GL_MAP2_TEXTURE_COORD_2		= 0x0DB4,
    GL_MAP2_TEXTURE_COORD_3		= 0x0DB5,
    GL_MAP2_TEXTURE_COORD_4		= 0x0DB6,
    GL_MAP2_VERTEX_3			= 0x0DB7,
    GL_MAP2_VERTEX_4			= 0x0DB8,
    GL_MAP1_GRID_DOMAIN			= 0x0DD0,
    GL_MAP1_GRID_SEGMENTS		= 0x0DD1,
    GL_MAP2_GRID_DOMAIN			= 0x0DD2,
    GL_MAP2_GRID_SEGMENTS		= 0x0DD3,
    GL_COEFF				    = 0x0A00,
    GL_ORDER				    = 0x0A01,
    GL_DOMAIN				    = 0x0A02
};

enum {
    GL_PERSPECTIVE_CORRECTION_HINT		= 0x0C50,
    GL_POINT_SMOOTH_HINT			    = 0x0C51,
    GL_LINE_SMOOTH_HINT			        = 0x0C52,
    GL_POLYGON_SMOOTH_HINT			    = 0x0C53,
    GL_FOG_HINT				            = 0x0C54,
    GL_DONT_CARE				        = 0x1100,
    GL_FASTEST				            = 0x1101,
    GL_NICEST				            = 0x1102
};

enum {
    GL_SCISSOR_BOX				= 0x0C10,
    GL_SCISSOR_TEST				= 0x0C11
};

enum {
    GL_MAP_COLOR				= 0x0D10,
    GL_MAP_STENCIL				= 0x0D11,
    GL_INDEX_SHIFT				= 0x0D12,
    GL_INDEX_OFFSET				= 0x0D13,
    GL_RED_SCALE				= 0x0D14,
    GL_RED_BIAS				    = 0x0D15,
    GL_GREEN_SCALE				= 0x0D18,
    GL_GREEN_BIAS				= 0x0D19,
    GL_BLUE_SCALE				= 0x0D1A,
    GL_BLUE_BIAS				= 0x0D1B,
    GL_ALPHA_SCALE				= 0x0D1C,
    GL_ALPHA_BIAS				= 0x0D1D,
    GL_DEPTH_SCALE				= 0x0D1E,
    GL_DEPTH_BIAS				= 0x0D1F,
    GL_PIXEL_MAP_S_TO_S_SIZE	= 0x0CB1,
    GL_PIXEL_MAP_I_TO_I_SIZE	= 0x0CB0,
    GL_PIXEL_MAP_I_TO_R_SIZE	= 0x0CB2,
    GL_PIXEL_MAP_I_TO_G_SIZE	= 0x0CB3,
    GL_PIXEL_MAP_I_TO_B_SIZE	= 0x0CB4,
    GL_PIXEL_MAP_I_TO_A_SIZE	= 0x0CB5,
    GL_PIXEL_MAP_R_TO_R_SIZE	= 0x0CB6,
    GL_PIXEL_MAP_G_TO_G_SIZE	= 0x0CB7,
    GL_PIXEL_MAP_B_TO_B_SIZE	= 0x0CB8,
    GL_PIXEL_MAP_A_TO_A_SIZE	= 0x0CB9,
    GL_PIXEL_MAP_S_TO_S			= 0x0C71,
    GL_PIXEL_MAP_I_TO_I			= 0x0C70,
    GL_PIXEL_MAP_I_TO_R			= 0x0C72,
    GL_PIXEL_MAP_I_TO_G			= 0x0C73,
    GL_PIXEL_MAP_I_TO_B			= 0x0C74,
    GL_PIXEL_MAP_I_TO_A			= 0x0C75,
    GL_PIXEL_MAP_R_TO_R			= 0x0C76,
    GL_PIXEL_MAP_G_TO_G			= 0x0C77,
    GL_PIXEL_MAP_B_TO_B			= 0x0C78,
    GL_PIXEL_MAP_A_TO_A			= 0x0C79,
    GL_PACK_ALIGNMENT			= 0x0D05,
    GL_PACK_LSB_FIRST			= 0x0D01,
    GL_PACK_ROW_LENGTH			= 0x0D02,
    GL_PACK_SKIP_PIXELS			= 0x0D04,
    GL_PACK_SKIP_ROWS			= 0x0D03,
    GL_PACK_SWAP_BYTES			= 0x0D00,
    GL_UNPACK_ALIGNMENT			= 0x0CF5,
    GL_UNPACK_LSB_FIRST			= 0x0CF1,
    GL_UNPACK_ROW_LENGTH		= 0x0CF2,
    GL_UNPACK_SKIP_PIXELS		= 0x0CF4,
    GL_UNPACK_SKIP_ROWS			= 0x0CF3,
    GL_UNPACK_SWAP_BYTES		= 0x0CF0,
    GL_ZOOM_X				    = 0x0D16,
    GL_ZOOM_Y				    = 0x0D17
};

enum {
    GL_TEXTURE_ENV				= 0x2300,
    GL_TEXTURE_ENV_MODE			= 0x2200,
    GL_TEXTURE_1D				= 0x0DE0,
    GL_TEXTURE_2D				= 0x0DE1,
    GL_TEXTURE_WRAP_S			= 0x2802,
    GL_TEXTURE_WRAP_T			= 0x2803,
    GL_TEXTURE_MAG_FILTER		= 0x2800,
    GL_TEXTURE_MIN_FILTER		= 0x2801,
    GL_TEXTURE_ENV_COLOR		= 0x2201,
    GL_TEXTURE_GEN_S			= 0x0C60,
    GL_TEXTURE_GEN_T			= 0x0C61,
    GL_TEXTURE_GEN_R			= 0x0C62,
    GL_TEXTURE_GEN_Q			= 0x0C63,
    GL_TEXTURE_GEN_MODE			= 0x2500,
    GL_TEXTURE_BORDER_COLOR		= 0x1004,
    GL_TEXTURE_WIDTH			= 0x1000,
    GL_TEXTURE_HEIGHT			= 0x1001,
    GL_TEXTURE_BORDER			= 0x1005,
    GL_TEXTURE_COMPONENTS		= 0x1003,
    GL_TEXTURE_RED_SIZE			= 0x805C,
    GL_TEXTURE_GREEN_SIZE		= 0x805D,
    GL_TEXTURE_BLUE_SIZE		= 0x805E,
    GL_TEXTURE_ALPHA_SIZE		= 0x805F,
    GL_TEXTURE_LUMINANCE_SIZE	= 0x8060,
    GL_TEXTURE_INTENSITY_SIZE	= 0x8061,
    GL_NEAREST_MIPMAP_NEAREST	= 0x2700,
    GL_NEAREST_MIPMAP_LINEAR	= 0x2702,
    GL_LINEAR_MIPMAP_NEAREST	= 0x2701,
    GL_LINEAR_MIPMAP_LINEAR		= 0x2703,
    GL_OBJECT_LINEAR			= 0x2401,
    GL_OBJECT_PLANE				= 0x2501,
    GL_EYE_LINEAR				= 0x2400,
    GL_EYE_PLANE				= 0x2502,
    GL_SPHERE_MAP				= 0x2402,
    GL_DECAL				    = 0x2101,
    GL_MODULATE				    = 0x2100,
    GL_NEAREST				    = 0x2600,
    GL_REPEAT			        = 0x2901,
    GL_CLAMP				    = 0x2900,
    GL_S					    = 0x2000,
    GL_T					    = 0x2001,
    GL_R					    = 0x2002,
    GL_Q					    = 0x2003
};

enum {
    GL_VENDOR				= 0x1F00,
    GL_RENDERER				= 0x1F01,
    GL_VERSION				= 0x1F02,
    GL_EXTENSIONS			= 0x1F03
};

enum {
    GL_NO_ERROR 				= 0x0,
    GL_INVALID_ENUM				= 0x0500,
    GL_INVALID_VALUE			= 0x0501,
    GL_INVALID_OPERATION		= 0x0502,
    GL_STACK_OVERFLOW			= 0x0503,
    GL_STACK_UNDERFLOW			= 0x0504,
    GL_OUT_OF_MEMORY			= 0x0505,
};

enum {
    GL_CURRENT_BIT			= 0x00000001,
    GL_POINT_BIT			= 0x00000002,
    GL_LINE_BIT				= 0x00000004,
    GL_POLYGON_BIT			= 0x00000008,
    GL_POLYGON_STIPPLE_BIT	= 0x00000010,
    GL_PIXEL_MODE_BIT		= 0x00000020,
    GL_LIGHTING_BIT			= 0x00000040,
    GL_FOG_BIT				= 0x00000080,
    GL_DEPTH_BUFFER_BIT		= 0x00000100,
    GL_ACCUM_BUFFER_BIT		= 0x00000200,
    GL_STENCIL_BUFFER_BIT	= 0x00000400,
    GL_VIEWPORT_BIT			= 0x00000800,
    GL_TRANSFORM_BIT		= 0x00001000,
    GL_ENABLE_BIT			= 0x00002000,
    GL_COLOR_BUFFER_BIT		= 0x00004000,
    GL_HINT_BIT				= 0x00008000,
    GL_EVAL_BIT				= 0x00010000,
    GL_LIST_BIT				= 0x00020000,
    GL_TEXTURE_BIT			= 0x00040000,
    GL_SCISSOR_BIT			= 0x00080000,
    GL_ALL_ATTRIB_BITS		= 0x000FFFFF
};

enum {
    GL_PROXY_TEXTURE_1D			= 0x8063,
    GL_PROXY_TEXTURE_2D			= 0x8064,
    GL_TEXTURE_PRIORITY			= 0x8066,
    GL_TEXTURE_RESIDENT			= 0x8067,
    GL_TEXTURE_BINDING_1D		= 0x8068,
    GL_TEXTURE_BINDING_2D		= 0x8069,
    GL_TEXTURE_INTERNAL_FORMAT	= 0x1003,
    GL_ALPHA4				    = 0x803B,
    GL_ALPHA8				    = 0x803C,
    GL_ALPHA12				    = 0x803D,
    GL_ALPHA16				    = 0x803E,
    GL_LUMINANCE4				= 0x803F,
    GL_LUMINANCE8				= 0x8040,
    GL_LUMINANCE12				= 0x8041,
    GL_LUMINANCE16				= 0x8042,
    GL_LUMINANCE4_ALPHA4		= 0x8043,
    GL_LUMINANCE6_ALPHA2		= 0x8044,
    GL_LUMINANCE8_ALPHA8		= 0x8045,
    GL_LUMINANCE12_ALPHA4		= 0x8046,
    GL_LUMINANCE12_ALPHA12		= 0x8047,
    GL_LUMINANCE16_ALPHA16		= 0x8048,
    GL_INTENSITY				= 0x8049,
    GL_INTENSITY4				= 0x804A,
    GL_INTENSITY8				= 0x804B,
    GL_INTENSITY12				= 0x804C,
    GL_INTENSITY16				= 0x804D,
    GL_R3_G3_B2				    = 0x2A10,
    GL_RGB4					    = 0x804F,
    GL_RGB5				        = 0x8050,
    GL_RGB8					    = 0x8051,
    GL_RGB10				    = 0x8052,
    GL_RGB12				    = 0x8053,
    GL_RGB16				    = 0x8054,
    GL_RGBA2				    = 0x8055,
    GL_RGBA4				    = 0x8056,
    GL_RGB5_A1				    = 0x8057,
    GL_RGBA8				    = 0x8058,
    GL_RGB10_A2				    = 0x8059,
    GL_RGBA12				    = 0x805A,
    GL_RGBA16				    = 0x805B,
    GL_CLIENT_PIXEL_STORE_BIT	= 0x00000001,
    GL_CLIENT_VERTEX_ARRAY_BIT	= 0x00000002,
    GL_ALL_CLIENT_ATTRIB_BITS 	= 0xFFFFFFFF,
    GL_CLIENT_ALL_ATTRIB_BITS 	= 0xFFFFFFFF
};

void glClearIndex( GLfloat c );
void glClearColor( GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha );
void glClear( GLbitfield mask );
void glIndexMask( GLuint mask );
void glColorMask( GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha );
void glAlphaFunc( GLenum func, GLclampf ref );
void glBlendFunc( GLenum sfactor, GLenum dfactor );
void glLogicOp( GLenum opcode );
void glCullFace( GLenum mode );
void glFrontFace( GLenum mode );
void glPointSize( GLfloat size );
void glLineWidth( GLfloat width );
void glLineStipple( GLint factor, GLushort pattern );
void glPolygonMode( GLenum face, GLenum mode );
void glPolygonOffset( GLfloat factor, GLfloat units );
void glPolygonStipple( const GLubyte *mask );
void glGetPolygonStipple( GLubyte *mask );
void glEdgeFlag( GLboolean flag );
void glEdgeFlagv( const GLboolean *flag );
void glScissor( GLint x, GLint y, GLsizei width, GLsizei height);
void glClipPlane( GLenum plane, const GLdouble *equation );
void glGetClipPlane( GLenum plane, GLdouble *equation );
void glDrawBuffer( GLenum mode );
void glReadBuffer( GLenum mode );
void glEnable( GLenum cap );
void glDisable( GLenum cap );
GLboolean glIsEnabled( GLenum cap );
void glEnableClientState( GLenum cap );  /* 1.1 */
void glDisableClientState( GLenum cap );  /* 1.1 */
void glGetBooleanv( GLenum pname, GLboolean *params );
void glGetDoublev( GLenum pname, GLdouble *params );
void glGetFloatv( GLenum pname, GLfloat *params );
void glGetIntegerv( GLenum pname, GLint *params );
void glPushAttrib( GLbitfield mask );
void glPopAttrib( void );
void glPushClientAttrib( GLbitfield mask );  /* 1.1 */
void glPopClientAttrib( void );  /* 1.1 */
GLint  glRenderMode( GLenum mode );
GLenum  glGetError( void );
const GLubyte *  glGetString( GLenum name );
void glFinish( void );
void glFlush( void );
void glHint( GLenum target, GLenum mode );
void glClearDepth( GLclampd depth );
void glDepthFunc( GLenum func );
void glDepthMask( GLboolean flag );
void glDepthRange( GLclampd near_val, GLclampd far_val );
void glClearAccum( GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha );
void glAccum( GLenum op, GLfloat value );
void glMatrixMode( GLenum mode );
void glOrtho( GLdouble left, GLdouble right,
                                 GLdouble bottom, GLdouble top,
                                 GLdouble near_val, GLdouble far_val );
void glFrustum( GLdouble left, GLdouble right,
                                   GLdouble bottom, GLdouble top,
                                   GLdouble near_val, GLdouble far_val );
void glViewport( GLint x, GLint y,
                                    GLsizei width, GLsizei height );
void glPushMatrix( void );
void glPopMatrix( void );
void glLoadIdentity( void );
void glLoadMatrixd( const GLdouble *m );
void glLoadMatrixf( const GLfloat *m );
void glMultMatrixd( const GLdouble *m );
void glMultMatrixf( const GLfloat *m );
void glRotated( GLdouble angle,
                                   GLdouble x, GLdouble y, GLdouble z );
void glRotatef( GLfloat angle,
                                   GLfloat x, GLfloat y, GLfloat z );
void glScaled( GLdouble x, GLdouble y, GLdouble z );
void glScalef( GLfloat x, GLfloat y, GLfloat z );
void glTranslated( GLdouble x, GLdouble y, GLdouble z );
void glTranslatef( GLfloat x, GLfloat y, GLfloat z );
GLboolean  glIsList( GLuint list );
void glDeleteLists( GLuint list, GLsizei range );
GLuint  glGenLists( GLsizei range );
void glNewList( GLuint list, GLenum mode );
void glEndList( void );
void glCallList( GLuint list );
void glCallLists( GLsizei n, GLenum type,
                                     const GLvoid *lists );
void glListBase( GLuint base );
void glBegin( GLenum mode );
void glEnd( void );
void glVertex2d( GLdouble x, GLdouble y );
void glVertex2f( GLfloat x, GLfloat y );
void glVertex2i( GLint x, GLint y );
void glVertex2s( GLshort x, GLshort y );
void glVertex3d( GLdouble x, GLdouble y, GLdouble z );
void glVertex3f( GLfloat x, GLfloat y, GLfloat z );
void glVertex3i( GLint x, GLint y, GLint z );
void glVertex3s( GLshort x, GLshort y, GLshort z );
void glVertex4d( GLdouble x, GLdouble y, GLdouble z, GLdouble w );
void glVertex4f( GLfloat x, GLfloat y, GLfloat z, GLfloat w );
void glVertex4i( GLint x, GLint y, GLint z, GLint w );
void glVertex4s( GLshort x, GLshort y, GLshort z, GLshort w );
void glVertex2dv( const GLdouble *v );
void glVertex2fv( const GLfloat *v );
void glVertex2iv( const GLint *v );
void glVertex2sv( const GLshort *v );
void glVertex3dv( const GLdouble *v );
void glVertex3fv( const GLfloat *v );
void glVertex3iv( const GLint *v );
void glVertex3sv( const GLshort *v );
void glVertex4dv( const GLdouble *v );
void glVertex4fv( const GLfloat *v );
void glVertex4iv( const GLint *v );
void glVertex4sv( const GLshort *v );
void glNormal3b( GLbyte nx, GLbyte ny, GLbyte nz );
void glNormal3d( GLdouble nx, GLdouble ny, GLdouble nz );
void glNormal3f( GLfloat nx, GLfloat ny, GLfloat nz );
void glNormal3i( GLint nx, GLint ny, GLint nz );
void glNormal3s( GLshort nx, GLshort ny, GLshort nz );
void glNormal3bv( const GLbyte *v );
void glNormal3dv( const GLdouble *v );
void glNormal3fv( const GLfloat *v );
void glNormal3iv( const GLint *v );
void glNormal3sv( const GLshort *v );
void glIndexd( GLdouble c );
void glIndexf( GLfloat c );
void glIndexi( GLint c );
void glIndexs( GLshort c );
void glIndexub( GLubyte c );  /* 1.1 */
void glIndexdv( const GLdouble *c );
void glIndexfv( const GLfloat *c );
void glIndexiv( const GLint *c );
void glIndexsv( const GLshort *c );
void glIndexubv( const GLubyte *c );  /* 1.1 */
void glColor3b( GLbyte red, GLbyte green, GLbyte blue );
void glColor3d( GLdouble red, GLdouble green, GLdouble blue );
void glColor3f( GLfloat red, GLfloat green, GLfloat blue );
void glColor3i( GLint red, GLint green, GLint blue );
void glColor3s( GLshort red, GLshort green, GLshort blue );
void glColor3ub( GLubyte red, GLubyte green, GLubyte blue );
void glColor3ui( GLuint red, GLuint green, GLuint blue );
void glColor3us( GLushort red, GLushort green, GLushort blue );
void glColor4b( GLbyte red, GLbyte green,
                                   GLbyte blue, GLbyte alpha );
void glColor4d( GLdouble red, GLdouble green,
                                   GLdouble blue, GLdouble alpha );
void glColor4f( GLfloat red, GLfloat green,
                                   GLfloat blue, GLfloat alpha );
void glColor4i( GLint red, GLint green,
                                   GLint blue, GLint alpha );
void glColor4s( GLshort red, GLshort green,
                                   GLshort blue, GLshort alpha );
void glColor4ub( GLubyte red, GLubyte green,
                                    GLubyte blue, GLubyte alpha );
void glColor4ui( GLuint red, GLuint green,
                                    GLuint blue, GLuint alpha );
void glColor4us( GLushort red, GLushort green,
                                    GLushort blue, GLushort alpha );
void glColor3bv( const GLbyte *v );
void glColor3dv( const GLdouble *v );
void glColor3fv( const GLfloat *v );
void glColor3iv( const GLint *v );
void glColor3sv( const GLshort *v );
void glColor3ubv( const GLubyte *v );
void glColor3uiv( const GLuint *v );
void glColor3usv( const GLushort *v );
void glColor4bv( const GLbyte *v );
void glColor4dv( const GLdouble *v );
void glColor4fv( const GLfloat *v );
void glColor4iv( const GLint *v );
void glColor4sv( const GLshort *v );
void glColor4ubv( const GLubyte *v );
void glColor4uiv( const GLuint *v );
void glColor4usv( const GLushort *v );
void glTexCoord1d( GLdouble s );
void glTexCoord1f( GLfloat s );
void glTexCoord1i( GLint s );
void glTexCoord1s( GLshort s );
void glTexCoord2d( GLdouble s, GLdouble t );
void glTexCoord2f( GLfloat s, GLfloat t );
void glTexCoord2i( GLint s, GLint t );
void glTexCoord2s( GLshort s, GLshort t );
void glTexCoord3d( GLdouble s, GLdouble t, GLdouble r );
void glTexCoord3f( GLfloat s, GLfloat t, GLfloat r );
void glTexCoord3i( GLint s, GLint t, GLint r );
void glTexCoord3s( GLshort s, GLshort t, GLshort r );
void glTexCoord4d( GLdouble s, GLdouble t, GLdouble r, GLdouble q );
void glTexCoord4f( GLfloat s, GLfloat t, GLfloat r, GLfloat q );
void glTexCoord4i( GLint s, GLint t, GLint r, GLint q );
void glTexCoord4s( GLshort s, GLshort t, GLshort r, GLshort q );
void glTexCoord1dv( const GLdouble *v );
void glTexCoord1fv( const GLfloat *v );
void glTexCoord1iv( const GLint *v );
void glTexCoord1sv( const GLshort *v );
void glTexCoord2dv( const GLdouble *v );
void glTexCoord2fv( const GLfloat *v );
void glTexCoord2iv( const GLint *v );
void glTexCoord2sv( const GLshort *v );
void glTexCoord3dv( const GLdouble *v );
void glTexCoord3fv( const GLfloat *v );
void glTexCoord3iv( const GLint *v );
void glTexCoord3sv( const GLshort *v );
void glTexCoord4dv( const GLdouble *v );
void glTexCoord4fv( const GLfloat *v );
void glTexCoord4iv( const GLint *v );
void glTexCoord4sv( const GLshort *v );
void glRasterPos2d( GLdouble x, GLdouble y );
void glRasterPos2f( GLfloat x, GLfloat y );
void glRasterPos2i( GLint x, GLint y );
void glRasterPos2s( GLshort x, GLshort y );
void glRasterPos3d( GLdouble x, GLdouble y, GLdouble z );
void glRasterPos3f( GLfloat x, GLfloat y, GLfloat z );
void glRasterPos3i( GLint x, GLint y, GLint z );
void glRasterPos3s( GLshort x, GLshort y, GLshort z );
void glRasterPos4d( GLdouble x, GLdouble y, GLdouble z, GLdouble w );
void glRasterPos4f( GLfloat x, GLfloat y, GLfloat z, GLfloat w );
void glRasterPos4i( GLint x, GLint y, GLint z, GLint w );
void glRasterPos4s( GLshort x, GLshort y, GLshort z, GLshort w );
void glRasterPos2dv( const GLdouble *v );
void glRasterPos2fv( const GLfloat *v );
void glRasterPos2iv( const GLint *v );
void glRasterPos2sv( const GLshort *v );
void glRasterPos3dv( const GLdouble *v );
void glRasterPos3fv( const GLfloat *v );
void glRasterPos3iv( const GLint *v );
void glRasterPos3sv( const GLshort *v );
void glRasterPos4dv( const GLdouble *v );
void glRasterPos4fv( const GLfloat *v );
void glRasterPos4iv( const GLint *v );
void glRasterPos4sv( const GLshort *v );
void glRectd( GLdouble x1, GLdouble y1, GLdouble x2, GLdouble y2 );
void glRectf( GLfloat x1, GLfloat y1, GLfloat x2, GLfloat y2 );
void glRecti( GLint x1, GLint y1, GLint x2, GLint y2 );
void glRects( GLshort x1, GLshort y1, GLshort x2, GLshort y2 );
void glRectdv( const GLdouble *v1, const GLdouble *v2 );
void glRectfv( const GLfloat *v1, const GLfloat *v2 );
void glRectiv( const GLint *v1, const GLint *v2 );
void glRectsv( const GLshort *v1, const GLshort *v2 );
void glVertexPointer( GLint size, GLenum type,
                                       GLsizei stride, const GLvoid *ptr );
void glNormalPointer( GLenum type, GLsizei stride,
                                       const GLvoid *ptr );
void glColorPointer( GLint size, GLenum type,
                                      GLsizei stride, const GLvoid *ptr );
void glIndexPointer( GLenum type, GLsizei stride,
                                      const GLvoid *ptr );
void glTexCoordPointer( GLint size, GLenum type,
                                         GLsizei stride, const GLvoid *ptr );
void glEdgeFlagPointer( GLsizei stride, const GLvoid *ptr );
void glGetPointerv( GLenum pname, GLvoid **params );
void glArrayElement( GLint i );
void glDrawArrays( GLenum mode, GLint first, GLsizei count );
void glDrawElements( GLenum mode, GLsizei count,
                                      GLenum type, const GLvoid *indices );
void glInterleavedArrays( GLenum format, GLsizei stride,
                                           const GLvoid *pointer );

void glShadeModel( GLenum mode );
void glLightf( GLenum light, GLenum pname, GLfloat param );
void glLighti( GLenum light, GLenum pname, GLint param );
void glLightfv( GLenum light, GLenum pname,
                                 const GLfloat *params );
void glLightiv( GLenum light, GLenum pname,
                                 const GLint *params );
void glGetLightfv( GLenum light, GLenum pname,
                                    GLfloat *params );
void glGetLightiv( GLenum light, GLenum pname,
                                    GLint *params );
void glLightModelf( GLenum pname, GLfloat param );
void glLightModeli( GLenum pname, GLint param );
void glLightModelfv( GLenum pname, const GLfloat *params );
void glLightModeliv( GLenum pname, const GLint *params );
void glMaterialf( GLenum face, GLenum pname, GLfloat param );
void glMateriali( GLenum face, GLenum pname, GLint param );
void glMaterialfv( GLenum face, GLenum pname, const GLfloat *params );
void glMaterialiv( GLenum face, GLenum pname, const GLint *params );
void glGetMaterialfv( GLenum face, GLenum pname, GLfloat *params );
void glGetMaterialiv( GLenum face, GLenum pname, GLint *params );
void glColorMaterial( GLenum face, GLenum mode );
void glPixelZoom( GLfloat xfactor, GLfloat yfactor );
void glPixelStoref( GLenum pname, GLfloat param );
void glPixelStorei( GLenum pname, GLint param );
void glPixelTransferf( GLenum pname, GLfloat param );
void glPixelTransferi( GLenum pname, GLint param );
void glPixelMapfv( GLenum map, GLsizei mapsize,
                                    const GLfloat *values );
void glPixelMapuiv( GLenum map, GLsizei mapsize,
                                     const GLuint *values );
void glPixelMapusv( GLenum map, GLsizei mapsize,
                                     const GLushort *values );
void glGetPixelMapfv( GLenum map, GLfloat *values );
void glGetPixelMapuiv( GLenum map, GLuint *values );
void glGetPixelMapusv( GLenum map, GLushort *values );
void glBitmap( GLsizei width, GLsizei height,
                                GLfloat xorig, GLfloat yorig,
                                GLfloat xmove, GLfloat ymove,
                                const GLubyte *bitmap );
void glReadPixels( GLint x, GLint y,
                                    GLsizei width, GLsizei height,
                                    GLenum format, GLenum type,
                                    GLvoid *pixels );
void glDrawPixels( GLsizei width, GLsizei height,
                                    GLenum format, GLenum type,
                                    const GLvoid *pixels );
void glCopyPixels( GLint x, GLint y,
                                    GLsizei width, GLsizei height,
                                    GLenum type );
void glStencilFunc( GLenum func, GLint ref, GLuint mask );
void glStencilMask( GLuint mask );
void glStencilOp( GLenum fail, GLenum zfail, GLenum zpass );
void glClearStencil( GLint s );
void glTexGend( GLenum coord, GLenum pname, GLdouble param );
void glTexGenf( GLenum coord, GLenum pname, GLfloat param );
void glTexGeni( GLenum coord, GLenum pname, GLint param );
void glTexGendv( GLenum coord, GLenum pname, const GLdouble *params );
void glTexGenfv( GLenum coord, GLenum pname, const GLfloat *params );
void glTexGeniv( GLenum coord, GLenum pname, const GLint *params );
void glGetTexGendv( GLenum coord, GLenum pname, GLdouble *params );
void glGetTexGenfv( GLenum coord, GLenum pname, GLfloat *params );
void glGetTexGeniv( GLenum coord, GLenum pname, GLint *params );
void glTexEnvf( GLenum target, GLenum pname, GLfloat param );
void glTexEnvi( GLenum target, GLenum pname, GLint param );
void glTexEnvfv( GLenum target, GLenum pname, const GLfloat *params );
void glTexEnviv( GLenum target, GLenum pname, const GLint *params );
void glGetTexEnvfv( GLenum target, GLenum pname, GLfloat *params );
void glGetTexEnviv( GLenum target, GLenum pname, GLint *params );
void glTexParameterf( GLenum target, GLenum pname, GLfloat param );
void glTexParameteri( GLenum target, GLenum pname, GLint param );
void glTexParameterfv( GLenum target, GLenum pname,
                                          const GLfloat *params );
void glTexParameteriv( GLenum target, GLenum pname,
                                          const GLint *params );
void glGetTexParameterfv( GLenum target,
                                           GLenum pname, GLfloat *params);
void glGetTexParameteriv( GLenum target,
                                           GLenum pname, GLint *params );
void glGetTexLevelParameterfv( GLenum target, GLint level,
                                                GLenum pname, GLfloat *params );
void glGetTexLevelParameteriv( GLenum target, GLint level,
                                                GLenum pname, GLint *params );
void glTexImage1D( GLenum target, GLint level,
                                    GLint internalFormat,
                                    GLsizei width, GLint border,
                                    GLenum format, GLenum type,
                                    const GLvoid *pixels );
void glTexImage2D( GLenum target, GLint level,
                                    GLint internalFormat,
                                    GLsizei width, GLsizei height,
                                    GLint border, GLenum format, GLenum type,
                                    const GLvoid *pixels );
void glGetTexImage( GLenum target, GLint level,
                                     GLenum format, GLenum type,
                                     GLvoid *pixels );
void glGenTextures( GLsizei n, GLuint *textures );
void glDeleteTextures( GLsizei n, const GLuint *textures);
void glBindTexture( GLenum target, GLuint texture );
void glPrioritizeTextures( GLsizei n,
                                            const GLuint *textures,
                                            const GLclampf *priorities );
GLboolean  glAreTexturesResident( GLsizei n,
                                                  const GLuint *textures,
                                                  GLboolean *residences );
GLboolean  glIsTexture( GLuint texture );
void glTexSubImage1D( GLenum target, GLint level,
                                       GLint xoffset,
                                       GLsizei width, GLenum format,
                                       GLenum type, const GLvoid *pixels );
void glTexSubImage2D( GLenum target, GLint level,
                                       GLint xoffset, GLint yoffset,
                                       GLsizei width, GLsizei height,
                                       GLenum format, GLenum type,
                                       const GLvoid *pixels );
void glCopyTexImage1D( GLenum target, GLint level,
                                        GLenum internalformat,
                                        GLint x, GLint y,
                                        GLsizei width, GLint border );
void glCopyTexImage2D( GLenum target, GLint level,
                                        GLenum internalformat,
                                        GLint x, GLint y,
                                        GLsizei width, GLsizei height,
                                        GLint border );
void glCopyTexSubImage1D( GLenum target, GLint level,
                                           GLint xoffset, GLint x, GLint y,
                                           GLsizei width );
void glCopyTexSubImage2D( GLenum target, GLint level,
                                           GLint xoffset, GLint yoffset,
                                           GLint x, GLint y,
                                           GLsizei width, GLsizei height );
void glMap1d( GLenum target, GLdouble u1, GLdouble u2,
                               GLint stride,
                               GLint order, const GLdouble *points );
void glMap1f( GLenum target, GLfloat u1, GLfloat u2,
                               GLint stride,
                               GLint order, const GLfloat *points );
void glMap2d( GLenum target,
		     GLdouble u1, GLdouble u2, GLint ustride, GLint uorder,
		     GLdouble v1, GLdouble v2, GLint vstride, GLint vorder,
		     const GLdouble *points );
void glMap2f( GLenum target,
		     GLfloat u1, GLfloat u2, GLint ustride, GLint uorder,
		     GLfloat v1, GLfloat v2, GLint vstride, GLint vorder,
		     const GLfloat *points );
void glGetMapdv( GLenum target, GLenum query, GLdouble *v );
void glGetMapfv( GLenum target, GLenum query, GLfloat *v );
void glGetMapiv( GLenum target, GLenum query, GLint *v );
void glEvalCoord1d( GLdouble u );
void glEvalCoord1f( GLfloat u );
void glEvalCoord1dv( const GLdouble *u );
void glEvalCoord1fv( const GLfloat *u );
void glEvalCoord2d( GLdouble u, GLdouble v );
void glEvalCoord2f( GLfloat u, GLfloat v );
void glEvalCoord2dv( const GLdouble *u );
void glEvalCoord2fv( const GLfloat *u );
void glMapGrid1d( GLint un, GLdouble u1, GLdouble u2 );
void glMapGrid1f( GLint un, GLfloat u1, GLfloat u2 );
void glMapGrid2d( GLint un, GLdouble u1, GLdouble u2,
                                   GLint vn, GLdouble v1, GLdouble v2 );
void glMapGrid2f( GLint un, GLfloat u1, GLfloat u2,
                                   GLint vn, GLfloat v1, GLfloat v2 );
void glEvalPoint1( GLint i );
void glEvalPoint2( GLint i, GLint j );
void glEvalMesh1( GLenum mode, GLint i1, GLint i2 );
void glEvalMesh2( GLenum mode, GLint i1, GLint i2, GLint j1, GLint j2 );
void glFogf( GLenum pname, GLfloat param );
void glFogi( GLenum pname, GLint param );
void glFogfv( GLenum pname, const GLfloat *params );
void glFogiv( GLenum pname, const GLint *params );
void glFeedbackBuffer( GLsizei size, GLenum type, GLfloat *buffer );
void glPassThrough( GLfloat token );
void glSelectBuffer( GLsizei size, GLuint *buffer );
void glInitNames( void );
void glLoadName( GLuint name );
void glPushName( GLuint name );
void glPopName( void );

enum {
    GL_RESCALE_NORMAL			        = 0x803A,
    GL_CLAMP_TO_EDGE			        = 0x812F,
    GL_MAX_ELEMENTS_VERTICES		    = 0x80E8,
    GL_MAX_ELEMENTS_INDICES			    = 0x80E9,
    GL_BGR					            = 0x80E0,
    GL_BGRA					            = 0x80E1,
    GL_UNSIGNED_BYTE_3_3_2			    = 0x8032,
    GL_UNSIGNED_BYTE_2_3_3_REV		    = 0x8362,
    GL_UNSIGNED_SHORT_5_6_5			    = 0x8363,
    GL_UNSIGNED_SHORT_5_6_5_REV		    = 0x8364,
    GL_UNSIGNED_SHORT_4_4_4_4		    = 0x8033,
    GL_UNSIGNED_SHORT_4_4_4_4_REV		= 0x8365,
    GL_UNSIGNED_SHORT_5_5_5_1		    = 0x8034,
    GL_UNSIGNED_SHORT_1_5_5_5_REV		= 0x8366,
    GL_UNSIGNED_INT_8_8_8_8			    = 0x8035,
    GL_UNSIGNED_INT_8_8_8_8_REV		    = 0x8367,
    GL_UNSIGNED_INT_10_10_10_2		    = 0x8036,
    GL_UNSIGNED_INT_2_10_10_10_REV		= 0x8368,
    GL_LIGHT_MODEL_COLOR_CONTROL		= 0x81F8,
    GL_SINGLE_COLOR				        = 0x81F9,
    GL_SEPARATE_SPECULAR_COLOR		    = 0x81FA,
    GL_TEXTURE_MIN_LOD			        = 0x813A,
    GL_TEXTURE_MAX_LOD			        = 0x813B,
    GL_TEXTURE_BASE_LEVEL			    = 0x813C,
    GL_TEXTURE_MAX_LEVEL			    = 0x813D,
    GL_SMOOTH_POINT_SIZE_RANGE		    = 0x0B12,
    GL_SMOOTH_POINT_SIZE_GRANULARITY	= 0x0B13,
    GL_SMOOTH_LINE_WIDTH_RANGE		    = 0x0B22,
    GL_SMOOTH_LINE_WIDTH_GRANULARITY	= 0x0B23,
    GL_ALIASED_POINT_SIZE_RANGE		    = 0x846D,
    GL_ALIASED_LINE_WIDTH_RANGE		    = 0x846E,
    GL_PACK_SKIP_IMAGES			        = 0x806B,
    GL_PACK_IMAGE_HEIGHT			    = 0x806C,
    GL_UNPACK_SKIP_IMAGES			    = 0x806D,
    GL_UNPACK_IMAGE_HEIGHT			    = 0x806E,
    GL_TEXTURE_3D				        = 0x806F,
    GL_PROXY_TEXTURE_3D			        = 0x8070,
    GL_TEXTURE_DEPTH			        = 0x8071,
    GL_TEXTURE_WRAP_R			        = 0x8072,
    GL_MAX_3D_TEXTURE_SIZE			    = 0x8073,
    GL_TEXTURE_BINDING_3D			    = 0x806A
};

void glDrawRangeElements( GLenum mode, GLuint start,
	GLuint end, GLsizei count, GLenum type, const GLvoid *indices );
void glTexImage3D( GLenum target, GLint level,
                                      GLint internalFormat,
                                      GLsizei width, GLsizei height,
                                      GLsizei depth, GLint border,
                                      GLenum format, GLenum type,
                                      const GLvoid *pixels );
void glTexSubImage3D( GLenum target, GLint level,
                                         GLint xoffset, GLint yoffset,
                                         GLint zoffset, GLsizei width,
                                         GLsizei height, GLsizei depth,
                                         GLenum format,
                                         GLenum type, const GLvoid *pixels);
void glCopyTexSubImage3D( GLenum target, GLint level,
                                             GLint xoffset, GLint yoffset,
                                             GLint zoffset, GLint x,
                                             GLint y, GLsizei width,
                                             GLsizei height );
typedef void (* PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void (* PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);

enum {
    GL_CONSTANT_COLOR			            = 0x8001,
    GL_ONE_MINUS_CONSTANT_COLOR		        = 0x8002,
    GL_CONSTANT_ALPHA			            = 0x8003,
    GL_ONE_MINUS_CONSTANT_ALPHA		        = 0x8004,
    GL_COLOR_TABLE				            = 0x80D0,
    GL_POST_CONVOLUTION_COLOR_TABLE		    = 0x80D1,
    GL_POST_COLOR_MATRIX_COLOR_TABLE	    = 0x80D2,
    GL_PROXY_COLOR_TABLE			        = 0x80D3,
    GL_PROXY_POST_CONVOLUTION_COLOR_TABLE	= 0x80D4,
    GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE	= 0x80D5,
    GL_COLOR_TABLE_SCALE			        = 0x80D6,
    GL_COLOR_TABLE_BIAS			            = 0x80D7,
    GL_COLOR_TABLE_FORMAT			        = 0x80D8,
    GL_COLOR_TABLE_WIDTH			        = 0x80D9,
    GL_COLOR_TABLE_RED_SIZE			        = 0x80DA,
    GL_COLOR_TABLE_GREEN_SIZE		        = 0x80DB,
    GL_COLOR_TABLE_BLUE_SIZE		        = 0x80DC,
    GL_COLOR_TABLE_ALPHA_SIZE		        = 0x80DD,
    GL_COLOR_TABLE_LUMINANCE_SIZE		    = 0x80DE,
    GL_COLOR_TABLE_INTENSITY_SIZE		    = 0x80DF,
    GL_CONVOLUTION_1D			            = 0x8010,
    GL_CONVOLUTION_2D			            = 0x8011,
    GL_SEPARABLE_2D				            = 0x8012,
    GL_CONVOLUTION_BORDER_MODE		        = 0x8013,
    GL_CONVOLUTION_FILTER_SCALE		        = 0x8014,
    GL_CONVOLUTION_FILTER_BIAS		        = 0x8015,
    GL_REDUCE				                = 0x8016,
    GL_CONVOLUTION_FORMAT			        = 0x8017,
    GL_CONVOLUTION_WIDTH			        = 0x8018,
    GL_CONVOLUTION_HEIGHT			        = 0x8019,
    GL_MAX_CONVOLUTION_WIDTH		        = 0x801A,
    GL_MAX_CONVOLUTION_HEIGHT		        = 0x801B,
    GL_POST_CONVOLUTION_RED_SCALE		    = 0x801C,
    GL_POST_CONVOLUTION_GREEN_SCALE		    = 0x801D,
    GL_POST_CONVOLUTION_BLUE_SCALE		    = 0x801E,
    GL_POST_CONVOLUTION_ALPHA_SCALE		    = 0x801F,
    GL_POST_CONVOLUTION_RED_BIAS		    = 0x8020,
    GL_POST_CONVOLUTION_GREEN_BIAS		    = 0x8021,
    GL_POST_CONVOLUTION_BLUE_BIAS		    = 0x8022,
    GL_POST_CONVOLUTION_ALPHA_BIAS		    = 0x8023,
    GL_CONSTANT_BORDER			            = 0x8151,
    GL_REPLICATE_BORDER			            = 0x8153,
    GL_CONVOLUTION_BORDER_COLOR		        = 0x8154,
    GL_COLOR_MATRIX				            = 0x80B1,
    GL_COLOR_MATRIX_STACK_DEPTH		        = 0x80B2,
    GL_MAX_COLOR_MATRIX_STACK_DEPTH		    = 0x80B3,
    GL_POST_COLOR_MATRIX_RED_SCALE		    = 0x80B4,
    GL_POST_COLOR_MATRIX_GREEN_SCALE	    = 0x80B5,
    GL_POST_COLOR_MATRIX_BLUE_SCALE		    = 0x80B6,
    GL_POST_COLOR_MATRIX_ALPHA_SCALE	    = 0x80B7,
    GL_POST_COLOR_MATRIX_RED_BIAS		    = 0x80B8,
    GL_POST_COLOR_MATRIX_GREEN_BIAS		    = 0x80B9,
    GL_POST_COLOR_MATRIX_BLUE_BIAS		    = 0x80BA,
    GL_POST_COLOR_MATRIX_ALPHA_BIAS		    = 0x80BB,
    GL_HISTOGRAM				            = 0x8024,
    GL_PROXY_HISTOGRAM			            = 0x8025,
    GL_HISTOGRAM_WIDTH			            = 0x8026,
    GL_HISTOGRAM_FORMAT			            = 0x8027,
    GL_HISTOGRAM_RED_SIZE			        = 0x8028,
    GL_HISTOGRAM_GREEN_SIZE			        = 0x8029,
    GL_HISTOGRAM_BLUE_SIZE			        = 0x802A,
    GL_HISTOGRAM_ALPHA_SIZE			        = 0x802B,
    GL_HISTOGRAM_LUMINANCE_SIZE		        = 0x802C,
    GL_HISTOGRAM_SINK			            = 0x802D,
    GL_MINMAX				                = 0x802E,
    GL_MINMAX_FORMAT			            = 0x802F,
    GL_MINMAX_SINK				            = 0x8030,
    GL_TABLE_TOO_LARGE			            = 0x8031,
    GL_BLEND_EQUATION			            = 0x8009,
    GL_MIN					                = 0x8007,
    GL_MAX					                = 0x8008,
    GL_FUNC_ADD				                = 0x8006,
    GL_FUNC_SUBTRACT			            = 0x800A,
    GL_FUNC_REVERSE_SUBTRACT		        = 0x800B,
    GL_BLEND_COLOR				            = 0x8005
};

void glColorTable( GLenum target, GLenum internalformat,
                                    GLsizei width, GLenum format,
                                    GLenum type, const GLvoid *table );
void glColorSubTable( GLenum target,
                                       GLsizei start, GLsizei count,
                                       GLenum format, GLenum type,
                                       const GLvoid *data );
void glColorTableParameteriv(GLenum target, GLenum pname,
                                              const GLint *params);
void glColorTableParameterfv(GLenum target, GLenum pname,
                                              const GLfloat *params);
void glCopyColorSubTable( GLenum target, GLsizei start,
                                           GLint x, GLint y, GLsizei width );
void glCopyColorTable( GLenum target, GLenum internalformat,
                                        GLint x, GLint y, GLsizei width );
void glGetColorTable( GLenum target, GLenum format,
                                       GLenum type, GLvoid *table );
void glGetColorTableParameterfv( GLenum target, GLenum pname,
                                                  GLfloat *params );
void glGetColorTableParameteriv( GLenum target, GLenum pname,
                                                  GLint *params );
void glBlendEquation( GLenum mode );
void glBlendColor( GLclampf red, GLclampf green,
                                    GLclampf blue, GLclampf alpha );
void glHistogram( GLenum target, GLsizei width,
				   GLenum internalformat, GLboolean sink );
void glResetHistogram( GLenum target );
void glGetHistogram( GLenum target, GLboolean reset,
				      GLenum format, GLenum type,
				      GLvoid *values );
void glGetHistogramParameterfv( GLenum target, GLenum pname,
						 GLfloat *params );
void glGetHistogramParameteriv( GLenum target, GLenum pname,
						 GLint *params );
void glMinmax( GLenum target, GLenum internalformat,
				GLboolean sink );
void glResetMinmax( GLenum target );
void glGetMinmax( GLenum target, GLboolean reset,
                                   GLenum format, GLenum types,
                                   GLvoid *values );
void glGetMinmaxParameterfv( GLenum target, GLenum pname,
					      GLfloat *params );
void glGetMinmaxParameteriv( GLenum target, GLenum pname,
					      GLint *params );
void glConvolutionFilter1D( GLenum target,
	GLenum internalformat, GLsizei width, GLenum format, GLenum type,
	const GLvoid *image );
void glConvolutionFilter2D( GLenum target,
	GLenum internalformat, GLsizei width, GLsizei height, GLenum format,
	GLenum type, const GLvoid *image );
void glConvolutionParameterf( GLenum target, GLenum pname,
	GLfloat params );
void glConvolutionParameterfv( GLenum target, GLenum pname,
	const GLfloat *params );
void glConvolutionParameteri( GLenum target, GLenum pname,
	GLint params );
void glConvolutionParameteriv( GLenum target, GLenum pname,
	const GLint *params );
void glCopyConvolutionFilter1D( GLenum target,
	GLenum internalformat, GLint x, GLint y, GLsizei width );
void glCopyConvolutionFilter2D( GLenum target,
	GLenum internalformat, GLint x, GLint y, GLsizei width,
	GLsizei height);
void glGetConvolutionFilter( GLenum target, GLenum format,
	GLenum type, GLvoid *image );
void glGetConvolutionParameterfv( GLenum target, GLenum pname,
	GLfloat *params );
void glGetConvolutionParameteriv( GLenum target, GLenum pname,
	GLint *params );
void glSeparableFilter2D( GLenum target,
	GLenum internalformat, GLsizei width, GLsizei height, GLenum format,
	GLenum type, const GLvoid *row, const GLvoid *column );
void glGetSeparableFilter( GLenum target, GLenum format,
	GLenum type, GLvoid *row, GLvoid *column, GLvoid *span );
typedef void (* PFNGLBLENDCOLORPROC) (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
typedef void (* PFNGLBLENDEQUATIONPROC) (GLenum mode);

enum {
    GL_TEXTURE0				    = 0x84C0,
    GL_TEXTURE1				    = 0x84C1,
    GL_TEXTURE2				    = 0x84C2,
    GL_TEXTURE3				    = 0x84C3,
    GL_TEXTURE4				    = 0x84C4,
    GL_TEXTURE5				    = 0x84C5,
    GL_TEXTURE6				    = 0x84C6,
    GL_TEXTURE7				    = 0x84C7,
    GL_TEXTURE8				    = 0x84C8,
    GL_TEXTURE9				    = 0x84C9,
    GL_TEXTURE10				= 0x84CA,
    GL_TEXTURE11				= 0x84CB,
    GL_TEXTURE12				= 0x84CC,
    GL_TEXTURE13				= 0x84CD,
    GL_TEXTURE14				= 0x84CE,
    GL_TEXTURE15				= 0x84CF,
    GL_TEXTURE16				= 0x84D0,
    GL_TEXTURE17				= 0x84D1,
    GL_TEXTURE18				= 0x84D2,
    GL_TEXTURE19				= 0x84D3,
    GL_TEXTURE20				= 0x84D4,
    GL_TEXTURE21				= 0x84D5,
    GL_TEXTURE22				= 0x84D6,
    GL_TEXTURE23				= 0x84D7,
    GL_TEXTURE24				= 0x84D8,
    GL_TEXTURE25				= 0x84D9,
    GL_TEXTURE26				= 0x84DA,
    GL_TEXTURE27				= 0x84DB,
    GL_TEXTURE28				= 0x84DC,
    GL_TEXTURE29				= 0x84DD,
    GL_TEXTURE30				= 0x84DE,
    GL_TEXTURE31				= 0x84DF,
    GL_ACTIVE_TEXTURE			= 0x84E0,
    GL_CLIENT_ACTIVE_TEXTURE	= 0x84E1,
    GL_MAX_TEXTURE_UNITS		= 0x84E2
};

enum {
    GL_NORMAL_MAP				        = 0x8511,
    GL_REFLECTION_MAP			        = 0x8512,
    GL_TEXTURE_CUBE_MAP			        = 0x8513,
    GL_TEXTURE_BINDING_CUBE_MAP		    = 0x8514,
    GL_TEXTURE_CUBE_MAP_POSITIVE_X		= 0x8515,
    GL_TEXTURE_CUBE_MAP_NEGATIVE_X		= 0x8516,
    GL_TEXTURE_CUBE_MAP_POSITIVE_Y		= 0x8517,
    GL_TEXTURE_CUBE_MAP_NEGATIVE_Y		= 0x8518,
    GL_TEXTURE_CUBE_MAP_POSITIVE_Z		= 0x8519,
    GL_TEXTURE_CUBE_MAP_NEGATIVE_Z		= 0x851A,
    GL_PROXY_TEXTURE_CUBE_MAP		    = 0x851B,
    GL_MAX_CUBE_MAP_TEXTURE_SIZE		= 0x851C
};

enum {
    GL_COMPRESSED_ALPHA			        = 0x84E9,
    GL_COMPRESSED_LUMINANCE			    = 0x84EA,
    GL_COMPRESSED_LUMINANCE_ALPHA		= 0x84EB,
    GL_COMPRESSED_INTENSITY			    = 0x84EC,
    GL_COMPRESSED_RGB			        = 0x84ED,
    GL_COMPRESSED_RGBA			        = 0x84EE,
    GL_TEXTURE_COMPRESSION_HINT		    = 0x84EF,
    GL_TEXTURE_COMPRESSED_IMAGE_SIZE	= 0x86A0,
    GL_TEXTURE_COMPRESSED			    = 0x86A1,
    GL_NUM_COMPRESSED_TEXTURE_FORMATS	= 0x86A2,
    GL_COMPRESSED_TEXTURE_FORMATS		= 0x86A3
};

enum {
    GL_MULTISAMPLE				= 0x809D,
    GL_SAMPLE_ALPHA_TO_COVERAGE	= 0x809E,
    GL_SAMPLE_ALPHA_TO_ONE		= 0x809F,
    GL_SAMPLE_COVERAGE			= 0x80A0,
    GL_SAMPLE_BUFFERS			= 0x80A8,
    GL_SAMPLES				    = 0x80A9,
    GL_SAMPLE_COVERAGE_VALUE	= 0x80AA,
    GL_SAMPLE_COVERAGE_INVERT	= 0x80AB,
    GL_MULTISAMPLE_BIT			= 0x20000000
};

enum {
    GL_TRANSPOSE_MODELVIEW_MATRIX	= 0x84E3,
    GL_TRANSPOSE_PROJECTION_MATRIX	= 0x84E4,
    GL_TRANSPOSE_TEXTURE_MATRIX		= 0x84E5,
    GL_TRANSPOSE_COLOR_MATRIX		= 0x84E6
};

enum {
    GL_COMBINE				= 0x8570,
    GL_COMBINE_RGB			= 0x8571,
    GL_COMBINE_ALPHA		= 0x8572,
    GL_SOURCE0_RGB			= 0x8580,
    GL_SOURCE1_RGB			= 0x8581,
    GL_SOURCE2_RGB			= 0x8582,
    GL_SOURCE0_ALPHA		= 0x8588,
    GL_SOURCE1_ALPHA		= 0x8589,
    GL_SOURCE2_ALPHA		= 0x858A,
    GL_OPERAND0_RGB			= 0x8590,
    GL_OPERAND1_RGB			= 0x8591,
    GL_OPERAND2_RGB			= 0x8592,
    GL_OPERAND0_ALPHA		= 0x8598,
    GL_OPERAND1_ALPHA		= 0x8599,
    GL_OPERAND2_ALPHA		= 0x859A,
    GL_RGB_SCALE			= 0x8573,
    GL_ADD_SIGNED			= 0x8574,
    GL_INTERPOLATE			= 0x8575,
    GL_SUBTRACT				= 0x84E7,
    GL_CONSTANT				= 0x8576,
    GL_PRIMARY_COLOR		= 0x8577,
    GL_PREVIOUS				= 0x8578
};

enum {
    GL_DOT3_RGB				= 0x86AE,
    GL_DOT3_RGBA			= 0x86AF
};

enum { GL_CLAMP_TO_BORDER = 0x812D };
void glActiveTexture( GLenum texture );
void glClientActiveTexture( GLenum texture );
void glCompressedTexImage1D( GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data );
void glCompressedTexImage2D( GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data );
void glCompressedTexImage3D( GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data );
void glCompressedTexSubImage1D( GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data );
void glCompressedTexSubImage2D( GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data );
void glCompressedTexSubImage3D( GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data );
void glGetCompressedTexImage( GLenum target, GLint lod, GLvoid *img );
void glMultiTexCoord1d( GLenum target, GLdouble s );
void glMultiTexCoord1dv( GLenum target, const GLdouble *v );
void glMultiTexCoord1f( GLenum target, GLfloat s );
void glMultiTexCoord1fv( GLenum target, const GLfloat *v );
void glMultiTexCoord1i( GLenum target, GLint s );
void glMultiTexCoord1iv( GLenum target, const GLint *v );
void glMultiTexCoord1s( GLenum target, GLshort s );
void glMultiTexCoord1sv( GLenum target, const GLshort *v );
void glMultiTexCoord2d( GLenum target, GLdouble s, GLdouble t );
void glMultiTexCoord2dv( GLenum target, const GLdouble *v );
void glMultiTexCoord2f( GLenum target, GLfloat s, GLfloat t );
void glMultiTexCoord2fv( GLenum target, const GLfloat *v );
void glMultiTexCoord2i( GLenum target, GLint s, GLint t );
void glMultiTexCoord2iv( GLenum target, const GLint *v );
void glMultiTexCoord2s( GLenum target, GLshort s, GLshort t );
void glMultiTexCoord2sv( GLenum target, const GLshort *v );
void glMultiTexCoord3d( GLenum target, GLdouble s, GLdouble t, GLdouble r );
void glMultiTexCoord3dv( GLenum target, const GLdouble *v );
void glMultiTexCoord3f( GLenum target, GLfloat s, GLfloat t, GLfloat r );
void glMultiTexCoord3fv( GLenum target, const GLfloat *v );
void glMultiTexCoord3i( GLenum target, GLint s, GLint t, GLint r );
void glMultiTexCoord3iv( GLenum target, const GLint *v );
void glMultiTexCoord3s( GLenum target, GLshort s, GLshort t, GLshort r );
void glMultiTexCoord3sv( GLenum target, const GLshort *v );
void glMultiTexCoord4d( GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q );
void glMultiTexCoord4dv( GLenum target, const GLdouble *v );
void glMultiTexCoord4f( GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q );
void glMultiTexCoord4fv( GLenum target, const GLfloat *v );
void glMultiTexCoord4i( GLenum target, GLint s, GLint t, GLint r, GLint q );
void glMultiTexCoord4iv( GLenum target, const GLint *v );
void glMultiTexCoord4s( GLenum target, GLshort s, GLshort t, GLshort r, GLshort q );
void glMultiTexCoord4sv( GLenum target, const GLshort *v );
void glLoadTransposeMatrixd( const GLdouble m[16] );
void glLoadTransposeMatrixf( const GLfloat m[16] );
void glMultTransposeMatrixd( const GLdouble m[16] );
void glMultTransposeMatrixf( const GLfloat m[16] );
void glSampleCoverage( GLclampf value, GLboolean invert );
typedef void (* PFNGLACTIVETEXTUREPROC) (GLenum texture);
typedef void (* PFNGLSAMPLECOVERAGEPROC) (GLclampf value, GLboolean invert);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, GLvoid *img);

enum { GL_ARB_multitexture = 1 };

enum {
    GL_TEXTURE0_ARB				    = 0x84C0,
    GL_TEXTURE1_ARB				    = 0x84C1,
    GL_TEXTURE2_ARB				    = 0x84C2,
    GL_TEXTURE3_ARB				    = 0x84C3,
    GL_TEXTURE4_ARB				    = 0x84C4,
    GL_TEXTURE5_ARB				    = 0x84C5,
    GL_TEXTURE6_ARB				    = 0x84C6,
    GL_TEXTURE7_ARB				    = 0x84C7,
    GL_TEXTURE8_ARB				    = 0x84C8,
    GL_TEXTURE9_ARB				    = 0x84C9,
    GL_TEXTURE10_ARB			    = 0x84CA,
    GL_TEXTURE11_ARB			    = 0x84CB,
    GL_TEXTURE12_ARB			    = 0x84CC,
    GL_TEXTURE13_ARB			    = 0x84CD,
    GL_TEXTURE14_ARB			    = 0x84CE,
    GL_TEXTURE15_ARB			    = 0x84CF,
    GL_TEXTURE16_ARB			    = 0x84D0,
    GL_TEXTURE17_ARB			    = 0x84D1,
    GL_TEXTURE18_ARB			    = 0x84D2,
    GL_TEXTURE19_ARB			    = 0x84D3,
    GL_TEXTURE20_ARB			    = 0x84D4,
    GL_TEXTURE21_ARB			    = 0x84D5,
    GL_TEXTURE22_ARB			    = 0x84D6,
    GL_TEXTURE23_ARB			    = 0x84D7,
    GL_TEXTURE24_ARB			    = 0x84D8,
    GL_TEXTURE25_ARB			    = 0x84D9,
    GL_TEXTURE26_ARB			    = 0x84DA,
    GL_TEXTURE27_ARB			    = 0x84DB,
    GL_TEXTURE28_ARB			    = 0x84DC,
    GL_TEXTURE29_ARB			    = 0x84DD,
    GL_TEXTURE30_ARB			    = 0x84DE,
    GL_TEXTURE31_ARB			    = 0x84DF,
    GL_ACTIVE_TEXTURE_ARB			= 0x84E0,
    GL_CLIENT_ACTIVE_TEXTURE_ARB    = 0x84E1,
    GL_MAX_TEXTURE_UNITS_ARB		= 0x84E2
};

void glActiveTextureARB(GLenum texture);
void glClientActiveTextureARB(GLenum texture);
void glMultiTexCoord1dARB(GLenum target, GLdouble s);
void glMultiTexCoord1dvARB(GLenum target, const GLdouble *v);
void glMultiTexCoord1fARB(GLenum target, GLfloat s);
void glMultiTexCoord1fvARB(GLenum target, const GLfloat *v);
void glMultiTexCoord1iARB(GLenum target, GLint s);
void glMultiTexCoord1ivARB(GLenum target, const GLint *v);
void glMultiTexCoord1sARB(GLenum target, GLshort s);
void glMultiTexCoord1svARB(GLenum target, const GLshort *v);
void glMultiTexCoord2dARB(GLenum target, GLdouble s, GLdouble t);
void glMultiTexCoord2dvARB(GLenum target, const GLdouble *v);
void glMultiTexCoord2fARB(GLenum target, GLfloat s, GLfloat t);
void glMultiTexCoord2fvARB(GLenum target, const GLfloat *v);
void glMultiTexCoord2iARB(GLenum target, GLint s, GLint t);
void glMultiTexCoord2ivARB(GLenum target, const GLint *v);
void glMultiTexCoord2sARB(GLenum target, GLshort s, GLshort t);
void glMultiTexCoord2svARB(GLenum target, const GLshort *v);
void glMultiTexCoord3dARB(GLenum target, GLdouble s, GLdouble t, GLdouble r);
void glMultiTexCoord3dvARB(GLenum target, const GLdouble *v);
void glMultiTexCoord3fARB(GLenum target, GLfloat s, GLfloat t, GLfloat r);
void glMultiTexCoord3fvARB(GLenum target, const GLfloat *v);
void glMultiTexCoord3iARB(GLenum target, GLint s, GLint t, GLint r);
void glMultiTexCoord3ivARB(GLenum target, const GLint *v);
void glMultiTexCoord3sARB(GLenum target, GLshort s, GLshort t, GLshort r);
void glMultiTexCoord3svARB(GLenum target, const GLshort *v);
void glMultiTexCoord4dARB(GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
void glMultiTexCoord4dvARB(GLenum target, const GLdouble *v);
void glMultiTexCoord4fARB(GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
void glMultiTexCoord4fvARB(GLenum target, const GLfloat *v);
void glMultiTexCoord4iARB(GLenum target, GLint s, GLint t, GLint r, GLint q);
void glMultiTexCoord4ivARB(GLenum target, const GLint *v);
void glMultiTexCoord4sARB(GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
void glMultiTexCoord4svARB(GLenum target, const GLshort *v);
typedef void (* PFNGLACTIVETEXTUREARBPROC) (GLenum texture);
typedef void (* PFNGLCLIENTACTIVETEXTUREARBPROC) (GLenum texture);
typedef void (* PFNGLMULTITEXCOORD1DARBPROC) (GLenum target, GLdouble s);
typedef void (* PFNGLMULTITEXCOORD1DVARBPROC) (GLenum target, const GLdouble *v);
typedef void (* PFNGLMULTITEXCOORD1FARBPROC) (GLenum target, GLfloat s);
typedef void (* PFNGLMULTITEXCOORD1FVARBPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD1IARBPROC) (GLenum target, GLint s);
typedef void (* PFNGLMULTITEXCOORD1IVARBPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD1SARBPROC) (GLenum target, GLshort s);
typedef void (* PFNGLMULTITEXCOORD1SVARBPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLMULTITEXCOORD2DARBPROC) (GLenum target, GLdouble s, GLdouble t);
typedef void (* PFNGLMULTITEXCOORD2DVARBPROC) (GLenum target, const GLdouble *v);
typedef void (* PFNGLMULTITEXCOORD2FARBPROC) (GLenum target, GLfloat s, GLfloat t);
typedef void (* PFNGLMULTITEXCOORD2FVARBPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD2IARBPROC) (GLenum target, GLint s, GLint t);
typedef void (* PFNGLMULTITEXCOORD2IVARBPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD2SARBPROC) (GLenum target, GLshort s, GLshort t);
typedef void (* PFNGLMULTITEXCOORD2SVARBPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLMULTITEXCOORD3DARBPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r);
typedef void (* PFNGLMULTITEXCOORD3DVARBPROC) (GLenum target, const GLdouble *v);
typedef void (* PFNGLMULTITEXCOORD3FARBPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r);
typedef void (* PFNGLMULTITEXCOORD3FVARBPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD3IARBPROC) (GLenum target, GLint s, GLint t, GLint r);
typedef void (* PFNGLMULTITEXCOORD3IVARBPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD3SARBPROC) (GLenum target, GLshort s, GLshort t, GLshort r);
typedef void (* PFNGLMULTITEXCOORD3SVARBPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLMULTITEXCOORD4DARBPROC) (GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
typedef void (* PFNGLMULTITEXCOORD4DVARBPROC) (GLenum target, const GLdouble *v);
typedef void (* PFNGLMULTITEXCOORD4FARBPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
typedef void (* PFNGLMULTITEXCOORD4FVARBPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD4IARBPROC) (GLenum target, GLint s, GLint t, GLint r, GLint q);
typedef void (* PFNGLMULTITEXCOORD4IVARBPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD4SARBPROC) (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
typedef void (* PFNGLMULTITEXCOORD4SVARBPROC) (GLenum target, const GLshort *v);
enum { GL_EXT_texture_array = 1 };
void glFramebufferTextureLayerEXT(GLenum target,
    GLenum attachment, GLuint texture, GLint level, GLint layer);

typedef void (* PFNGLFRAMEBUFFERTEXTURELAYEREXTPROC) (GLenum target,
    GLenum attachment, GLuint texture, GLint level, GLint layer);

enum {
    GL_TEXTURE_1D_ARRAY_EXT                     = 0x8C18,
    GL_PROXY_TEXTURE_1D_ARRAY_EXT               = 0x8C19,
    GL_TEXTURE_2D_ARRAY_EXT                     = 0x8C1A,
    GL_PROXY_TEXTURE_2D_ARRAY_EXT               = 0x8C1B,
    GL_TEXTURE_BINDING_1D_ARRAY_EXT             = 0x8C1C,
    GL_TEXTURE_BINDING_2D_ARRAY_EXT             = 0x8C1D,
    GL_MAX_ARRAY_TEXTURE_LAYERS_EXT             = 0x88FF,
    GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT = 0x8CD4
};

enum {
    GL_ATI_blend_equation_separate = 1,
    GL_ALPHA_BLEND_EQUATION_ATI    = 0x883D
};

void glBlendEquationSeparateATI( GLenum modeRGB, GLenum modeA );
typedef void (* PFNGLBLENDEQUATIONSEPARATEATIPROC) (GLenum modeRGB, GLenum modeA);

typedef void* GLeglImageOES;
enum { GL_OES_EGL_image = 1 };
void glEGLImageTargetTexture2DOES (GLenum target, GLeglImageOES image);
void glEGLImageTargetRenderbufferStorageOES (GLenum target, GLeglImageOES image);
typedef void (* PFNGLEGLIMAGETARGETTEXTURE2DOESPROC) (GLenum target, GLeglImageOES image);
typedef void (* PFNGLEGLIMAGETARGETRENDERBUFFERSTORAGEOESPROC) (GLenum target, GLeglImageOES image);

// glcorearb.h
/*
** Copyright (c) 2013-2018 The Khronos Group Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and/or associated documentation files (the
** "Materials"), to deal in the Materials without restriction, including
** without limitation the rights to use, copy, modify, merge, publish,
** distribute, sublicense, and/or sell copies of the Materials, and to
** permit persons to whom the Materials are furnished to do so, subject to
** the following conditions:
**
** The above copyright notice and this permission notice shall be included
** in all copies or substantial portions of the Materials.
**
** THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
** MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
*/

/* glcorearb.h is for use with OpenGL core profile implementations.
** It should should be placed in the same directory as gl.h and
** included as <GL/glcorearb.h>.
**
** glcorearb.h includes only APIs in the latest OpenGL core profile
** implementation together with APIs in newer ARB extensions which 
** can be supported by the core profile. It does not, and never will
** include functionality removed from the core profile, such as
** fixed-function vertex and fragment processing.
**
** Do not #include both <GL/glcorearb.h> and either of <GL/gl.h> or
** <GL/glext.h> in the same source file.
*/

/* Generated C header for:
 * API: gl
 * Profile: core
 * Versions considered: .*
 * Versions emitted: .*
 * Default extensions included: glcore
 * Additional extensions included: _nomatch_^
 * Extensions removed: _nomatch_^
*/

enum { GL_VERSION_1_4 = 1 };
enum {
    GL_BLEND_DST_RGB                  = 0x80C8,
    GL_BLEND_SRC_RGB                  = 0x80C9,
    GL_BLEND_DST_ALPHA                = 0x80CA,
    GL_BLEND_SRC_ALPHA                = 0x80CB,
    GL_POINT_FADE_THRESHOLD_SIZE      = 0x8128,
    GL_DEPTH_COMPONENT16              = 0x81A5,
    GL_DEPTH_COMPONENT24              = 0x81A6,
    GL_DEPTH_COMPONENT32              = 0x81A7,
    GL_MIRRORED_REPEAT                = 0x8370,
    GL_MAX_TEXTURE_LOD_BIAS           = 0x84FD,
    GL_TEXTURE_LOD_BIAS               = 0x8501,
    GL_INCR_WRAP                      = 0x8507,
    GL_DECR_WRAP                      = 0x8508,
    GL_TEXTURE_DEPTH_SIZE             = 0x884A,
    GL_TEXTURE_COMPARE_MODE           = 0x884C,
    GL_TEXTURE_COMPARE_FUNC           = 0x884D,
};

typedef void (* PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void (* PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
typedef void (* PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount);
typedef void (* PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param);
typedef void (* PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params);
typedef void (* PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param);
typedef void (* PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params);
typedef void (* PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (* PFNGLBLENDEQUATIONPROC) (GLenum mode);
void glBlendFuncSeparate (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
void glMultiDrawArrays (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
void glMultiDrawElements (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount);
void glPointParameterf (GLenum pname, GLfloat param);
void glPointParameterfv (GLenum pname, const GLfloat *params);
void glPointParameteri (GLenum pname, GLint param);
void glPointParameteriv (GLenum pname, const GLint *params);
void glBlendColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
void glBlendEquation (GLenum mode);

enum { GL_VERSION_1_5 = 1 };
typedef signed long long int GLsizeiptr;
typedef signed long long int GLintptr;
enum {
    GL_BUFFER_SIZE                    = 0x8764,
    GL_BUFFER_USAGE                   = 0x8765,
    GL_QUERY_COUNTER_BITS             = 0x8864,
    GL_CURRENT_QUERY                  = 0x8865,
    GL_QUERY_RESULT                   = 0x8866,
    GL_QUERY_RESULT_AVAILABLE         = 0x8867,
    GL_ARRAY_BUFFER                   = 0x8892,
    GL_ELEMENT_ARRAY_BUFFER           = 0x8893,
    GL_ARRAY_BUFFER_BINDING           = 0x8894,
    GL_ELEMENT_ARRAY_BUFFER_BINDING   = 0x8895,
    GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F,
    GL_READ_ONLY                      = 0x88B8,
    GL_WRITE_ONLY                     = 0x88B9,
    GL_READ_WRITE                     = 0x88BA,
    GL_BUFFER_ACCESS                  = 0x88BB,
    GL_BUFFER_MAPPED                  = 0x88BC,
    GL_BUFFER_MAP_POINTER             = 0x88BD,
    GL_STREAM_DRAW                    = 0x88E0,
    GL_STREAM_READ                    = 0x88E1,
    GL_STREAM_COPY                    = 0x88E2,
    GL_STATIC_DRAW                    = 0x88E4,
    GL_STATIC_READ                    = 0x88E5,
    GL_STATIC_COPY                    = 0x88E6,
    GL_DYNAMIC_DRAW                   = 0x88E8,
    GL_DYNAMIC_READ                   = 0x88E9,
    GL_DYNAMIC_COPY                   = 0x88EA,
    GL_SAMPLES_PASSED                 = 0x8914,
    GL_SRC1_ALPHA                     = 0x8589
};

typedef void (* PFNGLGENQUERIESPROC) (GLsizei n, GLuint *ids);
typedef void (* PFNGLDELETEQUERIESPROC) (GLsizei n, const GLuint *ids);
typedef GLboolean (* PFNGLISQUERYPROC) (GLuint id);
typedef void (* PFNGLBEGINQUERYPROC) (GLenum target, GLuint id);
typedef void (* PFNGLENDQUERYPROC) (GLenum target);
typedef void (* PFNGLGETQUERYIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETQUERYOBJECTIVPROC) (GLuint id, GLenum pname, GLint *params);
typedef void (* PFNGLGETQUERYOBJECTUIVPROC) (GLuint id, GLenum pname, GLuint *params);
typedef void (* PFNGLBINDBUFFERPROC) (GLenum target, GLuint buffer);
typedef void (* PFNGLDELETEBUFFERSPROC) (GLsizei n, const GLuint *buffers);
typedef void (* PFNGLGENBUFFERSPROC) (GLsizei n, GLuint *buffers);
typedef GLboolean (* PFNGLISBUFFERPROC) (GLuint buffer);
typedef void (* PFNGLBUFFERDATAPROC) (GLenum target, GLsizeiptr size, const void *data, GLenum usage);
typedef void (* PFNGLBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, const void *data);
typedef void (* PFNGLGETBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, void *data);
typedef void *(* PFNGLMAPBUFFERPROC) (GLenum target, GLenum access);
typedef GLboolean (* PFNGLUNMAPBUFFERPROC) (GLenum target);
typedef void (* PFNGLGETBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETBUFFERPOINTERVPROC) (GLenum target, GLenum pname, void **params);
void glGenQueries (GLsizei n, GLuint *ids);
void glDeleteQueries (GLsizei n, const GLuint *ids);
GLboolean glIsQuery (GLuint id);
void glBeginQuery (GLenum target, GLuint id);
void glEndQuery (GLenum target);
void glGetQueryiv (GLenum target, GLenum pname, GLint *params);
void glGetQueryObjectiv (GLuint id, GLenum pname, GLint *params);
void glGetQueryObjectuiv (GLuint id, GLenum pname, GLuint *params);
void glBindBuffer (GLenum target, GLuint buffer);
void glDeleteBuffers (GLsizei n, const GLuint *buffers);
void glGenBuffers (GLsizei n, GLuint *buffers);
GLboolean glIsBuffer (GLuint buffer);
void glBufferData (GLenum target, GLsizeiptr size, const void *data, GLenum usage);
void glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const void *data);
void glGetBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, void *data);
void *glMapBuffer (GLenum target, GLenum access);
GLboolean glUnmapBuffer (GLenum target);
void glGetBufferParameteriv (GLenum target, GLenum pname, GLint *params);
void glGetBufferPointerv (GLenum target, GLenum pname, void **params);

enum { GL_VERSION_2_0 = 1 };
typedef char GLchar;
typedef signed short int GLshort;
typedef unsigned short int GLushort;
typedef signed char GLbyte;

enum {
    GL_BLEND_EQUATION_RGB             = 0x8009,
    GL_VERTEX_ATTRIB_ARRAY_ENABLED    = 0x8622,
    GL_VERTEX_ATTRIB_ARRAY_SIZE       = 0x8623,
    GL_VERTEX_ATTRIB_ARRAY_STRIDE     = 0x8624,
    GL_VERTEX_ATTRIB_ARRAY_TYPE       = 0x8625,
    GL_CURRENT_VERTEX_ATTRIB          = 0x8626,
    GL_VERTEX_PROGRAM_POINT_SIZE      = 0x8642,
    GL_VERTEX_ATTRIB_ARRAY_POINTER    = 0x8645,
    GL_STENCIL_BACK_FUNC              = 0x8800,
    GL_STENCIL_BACK_FAIL              = 0x8801,
    GL_STENCIL_BACK_PASS_DEPTH_FAIL   = 0x8802,
    GL_STENCIL_BACK_PASS_DEPTH_PASS   = 0x8803,
    GL_MAX_DRAW_BUFFERS               = 0x8824,
    GL_DRAW_BUFFER0                   = 0x8825,
    GL_DRAW_BUFFER1                   = 0x8826,
    GL_DRAW_BUFFER2                   = 0x8827,
    GL_DRAW_BUFFER3                   = 0x8828,
    GL_DRAW_BUFFER4                   = 0x8829,
    GL_DRAW_BUFFER5                   = 0x882A,
    GL_DRAW_BUFFER6                   = 0x882B,
    GL_DRAW_BUFFER7                   = 0x882C,
    GL_DRAW_BUFFER8                   = 0x882D,
    GL_DRAW_BUFFER9                   = 0x882E,
    GL_DRAW_BUFFER10                  = 0x882F,
    GL_DRAW_BUFFER11                  = 0x8830,
    GL_DRAW_BUFFER12                  = 0x8831,
    GL_DRAW_BUFFER13                  = 0x8832,
    GL_DRAW_BUFFER14                  = 0x8833,
    GL_DRAW_BUFFER15                  = 0x8834,
    GL_BLEND_EQUATION_ALPHA           = 0x883D,
    GL_MAX_VERTEX_ATTRIBS             = 0x8869,
    GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = 0x886A,
    GL_MAX_TEXTURE_IMAGE_UNITS        = 0x8872,
    GL_FRAGMENT_SHADER                = 0x8B30,
    GL_VERTEX_SHADER                  = 0x8B31,
    GL_MAX_FRAGMENT_UNIFORM_COMPONENTS = 0x8B49,
    GL_MAX_VERTEX_UNIFORM_COMPONENTS  = 0x8B4A,
    GL_MAX_VARYING_FLOATS             = 0x8B4B,
    GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C,
    GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D,
    GL_SHADER_TYPE                    = 0x8B4F,
    GL_FLOAT_VEC2                     = 0x8B50,
    GL_FLOAT_VEC3                     = 0x8B51,
    GL_FLOAT_VEC4                     = 0x8B52,
    GL_INT_VEC2                       = 0x8B53,
    GL_INT_VEC3                       = 0x8B54,
    GL_INT_VEC4                       = 0x8B55,
    GL_BOOL                           = 0x8B56,
    GL_BOOL_VEC2                      = 0x8B57,
    GL_BOOL_VEC3                      = 0x8B58,
    GL_BOOL_VEC4                      = 0x8B59,
    GL_FLOAT_MAT2                     = 0x8B5A,
    GL_FLOAT_MAT3                     = 0x8B5B,
    GL_FLOAT_MAT4                     = 0x8B5C,
    GL_SAMPLER_1D                     = 0x8B5D,
    GL_SAMPLER_2D                     = 0x8B5E,
    GL_SAMPLER_3D                     = 0x8B5F,
    GL_SAMPLER_CUBE                   = 0x8B60,
    GL_SAMPLER_1D_SHADOW              = 0x8B61,
    GL_SAMPLER_2D_SHADOW              = 0x8B62,
    GL_DELETE_STATUS                  = 0x8B80,
    GL_COMPILE_STATUS                 = 0x8B81,
    GL_LINK_STATUS                    = 0x8B82,
    GL_VALIDATE_STATUS                = 0x8B83,
    GL_INFO_LOG_LENGTH                = 0x8B84,
    GL_ATTACHED_SHADERS               = 0x8B85,
    GL_ACTIVE_UNIFORMS                = 0x8B86,
    GL_ACTIVE_UNIFORM_MAX_LENGTH      = 0x8B87,
    GL_SHADER_SOURCE_LENGTH           = 0x8B88,
    GL_ACTIVE_ATTRIBUTES              = 0x8B89,
    GL_ACTIVE_ATTRIBUTE_MAX_LENGTH    = 0x8B8A,
    GL_FRAGMENT_SHADER_DERIVATIVE_HINT = 0x8B8B,
    GL_SHADING_LANGUAGE_VERSION       = 0x8B8C,
    GL_CURRENT_PROGRAM                = 0x8B8D,
    GL_POINT_SPRITE_COORD_ORIGIN      = 0x8CA0,
    GL_LOWER_LEFT                     = 0x8CA1,
    GL_UPPER_LEFT                     = 0x8CA2,
    GL_STENCIL_BACK_REF               = 0x8CA3,
    GL_STENCIL_BACK_VALUE_MASK        = 0x8CA4,
    GL_STENCIL_BACK_WRITEMASK         = 0x8CA5
};

typedef void (* PFNGLBLENDEQUATIONSEPARATEPROC) (GLenum modeRGB, GLenum modeAlpha);
typedef void (* PFNGLDRAWBUFFERSPROC) (GLsizei n, const GLenum *bufs);
typedef void (* PFNGLSTENCILOPSEPARATEPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
typedef void (* PFNGLSTENCILFUNCSEPARATEPROC) (GLenum face, GLenum func, GLint ref, GLuint mask);
typedef void (* PFNGLSTENCILMASKSEPARATEPROC) (GLenum face, GLuint mask);
typedef void (* PFNGLATTACHSHADERPROC) (GLuint program, GLuint shader);
typedef void (* PFNGLBINDATTRIBLOCATIONPROC) (GLuint program, GLuint index, const GLchar *name);
typedef void (* PFNGLCOMPILESHADERPROC) (GLuint shader);
typedef GLuint (* PFNGLCREATEPROGRAMPROC) (void);
typedef GLuint (* PFNGLCREATESHADERPROC) (GLenum type);
typedef void (* PFNGLDELETEPROGRAMPROC) (GLuint program);
typedef void (* PFNGLDELETESHADERPROC) (GLuint shader);
typedef void (* PFNGLDETACHSHADERPROC) (GLuint program, GLuint shader);
typedef void (* PFNGLDISABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void (* PFNGLENABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void (* PFNGLGETACTIVEATTRIBPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void (* PFNGLGETACTIVEUNIFORMPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void (* PFNGLGETATTACHEDSHADERSPROC) (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders);
typedef GLint (* PFNGLGETATTRIBLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLGETPROGRAMIVPROC) (GLuint program, GLenum pname, GLint *params);
typedef void (* PFNGLGETPROGRAMINFOLOGPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (* PFNGLGETSHADERIVPROC) (GLuint shader, GLenum pname, GLint *params);
typedef void (* PFNGLGETSHADERINFOLOGPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (* PFNGLGETSHADERSOURCEPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);
typedef GLint (* PFNGLGETUNIFORMLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLGETUNIFORMFVPROC) (GLuint program, GLint location, GLfloat *params);
typedef void (* PFNGLGETUNIFORMIVPROC) (GLuint program, GLint location, GLint *params);
typedef void (* PFNGLGETVERTEXATTRIBDVPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void (* PFNGLGETVERTEXATTRIBFVPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETVERTEXATTRIBIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void (* PFNGLGETVERTEXATTRIBPOINTERVPROC) (GLuint index, GLenum pname, void **pointer);
typedef GLboolean (* PFNGLISPROGRAMPROC) (GLuint program);
typedef GLboolean (* PFNGLISSHADERPROC) (GLuint shader);
typedef void (* PFNGLLINKPROGRAMPROC) (GLuint program);
typedef void (* PFNGLSHADERSOURCEPROC) (GLuint shader, GLsizei count, const GLchar *const*string, const GLint *length);
typedef void (* PFNGLUSEPROGRAMPROC) (GLuint program);
typedef void (* PFNGLUNIFORM1FPROC) (GLint location, GLfloat v0);
typedef void (* PFNGLUNIFORM2FPROC) (GLint location, GLfloat v0, GLfloat v1);
typedef void (* PFNGLUNIFORM3FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void (* PFNGLUNIFORM4FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void (* PFNGLUNIFORM1IPROC) (GLint location, GLint v0);
typedef void (* PFNGLUNIFORM2IPROC) (GLint location, GLint v0, GLint v1);
typedef void (* PFNGLUNIFORM3IPROC) (GLint location, GLint v0, GLint v1, GLint v2);
typedef void (* PFNGLUNIFORM4IPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void (* PFNGLUNIFORM1FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM2FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM3FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM4FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM1IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORM2IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORM3IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORM4IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORMMATRIX2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLVALIDATEPROGRAMPROC) (GLuint program);
typedef void (* PFNGLVERTEXATTRIB1DPROC) (GLuint index, GLdouble x);
typedef void (* PFNGLVERTEXATTRIB1DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB1FPROC) (GLuint index, GLfloat x);
typedef void (* PFNGLVERTEXATTRIB1FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB1SPROC) (GLuint index, GLshort x);
typedef void (* PFNGLVERTEXATTRIB1SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void (* PFNGLVERTEXATTRIB2DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB2FPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void (* PFNGLVERTEXATTRIB2FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB2SPROC) (GLuint index, GLshort x, GLshort y);
typedef void (* PFNGLVERTEXATTRIB2SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLVERTEXATTRIB3DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB3FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void (* PFNGLVERTEXATTRIB3FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB3SPROC) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void (* PFNGLVERTEXATTRIB3SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4NBVPROC) (GLuint index, const GLbyte *v);
typedef void (* PFNGLVERTEXATTRIB4NIVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIB4NSVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4NUBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void (* PFNGLVERTEXATTRIB4NUBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIB4NUIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIB4NUSVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLVERTEXATTRIB4BVPROC) (GLuint index, const GLbyte *v);
typedef void (* PFNGLVERTEXATTRIB4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLVERTEXATTRIB4DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB4FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* PFNGLVERTEXATTRIB4FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB4IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIB4SPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* PFNGLVERTEXATTRIB4SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4UBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIB4UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIB4USVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLVERTEXATTRIBPOINTERPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer);
void glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha);
void glDrawBuffers (GLsizei n, const GLenum *bufs);
void glStencilOpSeparate (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
void glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask);
void glStencilMaskSeparate (GLenum face, GLuint mask);
void glAttachShader (GLuint program, GLuint shader);
void glBindAttribLocation (GLuint program, GLuint index, const GLchar *name);
void glCompileShader (GLuint shader);
GLuint glCreateProgram (void);
GLuint glCreateShader (GLenum type);
void glDeleteProgram (GLuint program);
void glDeleteShader (GLuint shader);
void glDetachShader (GLuint program, GLuint shader);
void glDisableVertexAttribArray (GLuint index);
void glEnableVertexAttribArray (GLuint index);
void glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
void glGetActiveUniform (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
void glGetAttachedShaders (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders);
GLint glGetAttribLocation (GLuint program, const GLchar *name);
void glGetProgramiv (GLuint program, GLenum pname, GLint *params);
void glGetProgramInfoLog (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
void glGetShaderiv (GLuint shader, GLenum pname, GLint *params);
void glGetShaderInfoLog (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
void glGetShaderSource (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);
GLint glGetUniformLocation (GLuint program, const GLchar *name);
void glGetUniformfv (GLuint program, GLint location, GLfloat *params);
void glGetUniformiv (GLuint program, GLint location, GLint *params);
void glGetVertexAttribdv (GLuint index, GLenum pname, GLdouble *params);
void glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat *params);
void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params);
void glGetVertexAttribPointerv (GLuint index, GLenum pname, void **pointer);
GLboolean glIsProgram (GLuint program);
GLboolean glIsShader (GLuint shader);
void glLinkProgram (GLuint program);
void glShaderSource (GLuint shader, GLsizei count, const GLchar *const*string, const GLint *length);
void glUseProgram (GLuint program);
void glUniform1f (GLint location, GLfloat v0);
void glUniform2f (GLint location, GLfloat v0, GLfloat v1);
void glUniform3f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
void glUniform4f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
void glUniform1i (GLint location, GLint v0);
void glUniform2i (GLint location, GLint v0, GLint v1);
void glUniform3i (GLint location, GLint v0, GLint v1, GLint v2);
void glUniform4i (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
void glUniform1fv (GLint location, GLsizei count, const GLfloat *value);
void glUniform2fv (GLint location, GLsizei count, const GLfloat *value);
void glUniform3fv (GLint location, GLsizei count, const GLfloat *value);
void glUniform4fv (GLint location, GLsizei count, const GLfloat *value);
void glUniform1iv (GLint location, GLsizei count, const GLint *value);
void glUniform2iv (GLint location, GLsizei count, const GLint *value);
void glUniform3iv (GLint location, GLsizei count, const GLint *value);
void glUniform4iv (GLint location, GLsizei count, const GLint *value);
void glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glValidateProgram (GLuint program);
void glVertexAttrib1d (GLuint index, GLdouble x);
void glVertexAttrib1dv (GLuint index, const GLdouble *v);
void glVertexAttrib1f (GLuint index, GLfloat x);
void glVertexAttrib1fv (GLuint index, const GLfloat *v);
void glVertexAttrib1s (GLuint index, GLshort x);
void glVertexAttrib1sv (GLuint index, const GLshort *v);
void glVertexAttrib2d (GLuint index, GLdouble x, GLdouble y);
void glVertexAttrib2dv (GLuint index, const GLdouble *v);
void glVertexAttrib2f (GLuint index, GLfloat x, GLfloat y);
void glVertexAttrib2fv (GLuint index, const GLfloat *v);
void glVertexAttrib2s (GLuint index, GLshort x, GLshort y);
void glVertexAttrib2sv (GLuint index, const GLshort *v);
void glVertexAttrib3d (GLuint index, GLdouble x, GLdouble y, GLdouble z);
void glVertexAttrib3dv (GLuint index, const GLdouble *v);
void glVertexAttrib3f (GLuint index, GLfloat x, GLfloat y, GLfloat z);
void glVertexAttrib3fv (GLuint index, const GLfloat *v);
void glVertexAttrib3s (GLuint index, GLshort x, GLshort y, GLshort z);
void glVertexAttrib3sv (GLuint index, const GLshort *v);
void glVertexAttrib4Nbv (GLuint index, const GLbyte *v);
void glVertexAttrib4Niv (GLuint index, const GLint *v);
void glVertexAttrib4Nsv (GLuint index, const GLshort *v);
void glVertexAttrib4Nub (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
void glVertexAttrib4Nubv (GLuint index, const GLubyte *v);
void glVertexAttrib4Nuiv (GLuint index, const GLuint *v);
void glVertexAttrib4Nusv (GLuint index, const GLushort *v);
void glVertexAttrib4bv (GLuint index, const GLbyte *v);
void glVertexAttrib4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glVertexAttrib4dv (GLuint index, const GLdouble *v);
void glVertexAttrib4f (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
void glVertexAttrib4fv (GLuint index, const GLfloat *v);
void glVertexAttrib4iv (GLuint index, const GLint *v);
void glVertexAttrib4s (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
void glVertexAttrib4sv (GLuint index, const GLshort *v);
void glVertexAttrib4ubv (GLuint index, const GLubyte *v);
void glVertexAttrib4uiv (GLuint index, const GLuint *v);
void glVertexAttrib4usv (GLuint index, const GLushort *v);
void glVertexAttribPointer (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const void *pointer);

enum { GL_VERSION_2_1 = 1 };
enum {
    GL_PIXEL_PACK_BUFFER              = 0x88EB,
    GL_PIXEL_UNPACK_BUFFER            = 0x88EC,
    GL_PIXEL_PACK_BUFFER_BINDING      = 0x88ED,
    GL_PIXEL_UNPACK_BUFFER_BINDING    = 0x88EF,
    GL_FLOAT_MAT2x3                   = 0x8B65,
    GL_FLOAT_MAT2x4                   = 0x8B66,
    GL_FLOAT_MAT3x2                   = 0x8B67,
    GL_FLOAT_MAT3x4                   = 0x8B68,
    GL_FLOAT_MAT4x2                   = 0x8B69,
    GL_FLOAT_MAT4x3                   = 0x8B6A,
    GL_SRGB                           = 0x8C40,
    GL_SRGB8                          = 0x8C41,
    GL_SRGB_ALPHA                     = 0x8C42,
    GL_SRGB8_ALPHA8                   = 0x8C43,
    GL_COMPRESSED_SRGB                = 0x8C48,
    GL_COMPRESSED_SRGB_ALPHA          = 0x8C49
};

typedef void (* PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix2x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix3x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix2x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix4x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix3x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix4x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);

enum { GL_VERSION_3_0 = 1 };
typedef unsigned short int GLhalf;
enum {
    GL_COMPARE_REF_TO_TEXTURE         = 0x884E,
    GL_CLIP_DISTANCE0                 = 0x3000,
    GL_CLIP_DISTANCE1                 = 0x3001,
    GL_CLIP_DISTANCE2                 = 0x3002,
    GL_CLIP_DISTANCE3                 = 0x3003,
    GL_CLIP_DISTANCE4                 = 0x3004,
    GL_CLIP_DISTANCE5                 = 0x3005,
    GL_CLIP_DISTANCE6                 = 0x3006,
    GL_CLIP_DISTANCE7                 = 0x3007,
    GL_MAX_CLIP_DISTANCES             = 0x0D32,
    GL_MAJOR_VERSION                  = 0x821B,
    GL_MINOR_VERSION                  = 0x821C,
    GL_NUM_EXTENSIONS                 = 0x821D,
    GL_CONTEXT_FLAGS                  = 0x821E,
    GL_COMPRESSED_RED                 = 0x8225,
    GL_COMPRESSED_RG                  = 0x8226,
    GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT = 0x00000001,
    GL_RGBA32F                        = 0x8814,
    GL_RGB32F                         = 0x8815,
    GL_RGBA16F                        = 0x881A,
    GL_RGB16F                         = 0x881B,
    GL_VERTEX_ATTRIB_ARRAY_INTEGER    = 0x88FD,
    GL_MAX_ARRAY_TEXTURE_LAYERS       = 0x88FF,
    GL_MIN_PROGRAM_TEXEL_OFFSET       = 0x8904,
    GL_MAX_PROGRAM_TEXEL_OFFSET       = 0x8905,
    GL_CLAMP_READ_COLOR               = 0x891C,
    GL_FIXED_ONLY                     = 0x891D,
    GL_MAX_VARYING_COMPONENTS         = 0x8B4B,
    GL_TEXTURE_1D_ARRAY               = 0x8C18,
    GL_PROXY_TEXTURE_1D_ARRAY         = 0x8C19,
    GL_TEXTURE_2D_ARRAY               = 0x8C1A,
    GL_PROXY_TEXTURE_2D_ARRAY         = 0x8C1B,
    GL_TEXTURE_BINDING_1D_ARRAY       = 0x8C1C,
    GL_TEXTURE_BINDING_2D_ARRAY       = 0x8C1D,
    GL_R11F_G11F_B10F                 = 0x8C3A,
    GL_UNSIGNED_INT_10F_11F_11F_REV   = 0x8C3B,
    GL_RGB9_E5                        = 0x8C3D,
    GL_UNSIGNED_INT_5_9_9_9_REV       = 0x8C3E,
    GL_TEXTURE_SHARED_SIZE            = 0x8C3F,
    GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 0x8C76,
    GL_TRANSFORM_FEEDBACK_BUFFER_MODE = 0x8C7F,
    GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 0x8C80,
    GL_TRANSFORM_FEEDBACK_VARYINGS    = 0x8C83,
    GL_TRANSFORM_FEEDBACK_BUFFER_START = 0x8C84,
    GL_TRANSFORM_FEEDBACK_BUFFER_SIZE = 0x8C85,
    GL_PRIMITIVES_GENERATED           = 0x8C87,
    GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 0x8C88,
    GL_RASTERIZER_DISCARD             = 0x8C89,
    GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 0x8C8A,
    GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B,
    GL_INTERLEAVED_ATTRIBS            = 0x8C8C,
    GL_SEPARATE_ATTRIBS               = 0x8C8D,
    GL_TRANSFORM_FEEDBACK_BUFFER      = 0x8C8E,
    GL_TRANSFORM_FEEDBACK_BUFFER_BINDING = 0x8C8F,
    GL_RGBA32UI                       = 0x8D70,
    GL_RGB32UI                        = 0x8D71,
    GL_RGBA16UI                       = 0x8D76,
    GL_RGB16UI                        = 0x8D77,
    GL_RGBA8UI                        = 0x8D7C,
    GL_RGB8UI                         = 0x8D7D,
    GL_RGBA32I                        = 0x8D82,
    GL_RGB32I                         = 0x8D83,
    GL_RGBA16I                        = 0x8D88,
    GL_RGB16I                         = 0x8D89,
    GL_RGBA8I                         = 0x8D8E,
    GL_RGB8I                          = 0x8D8F,
    GL_RED_INTEGER                    = 0x8D94,
    GL_GREEN_INTEGER                  = 0x8D95,
    GL_BLUE_INTEGER                   = 0x8D96,
    GL_RGB_INTEGER                    = 0x8D98,
    GL_RGBA_INTEGER                   = 0x8D99,
    GL_BGR_INTEGER                    = 0x8D9A,
    GL_BGRA_INTEGER                   = 0x8D9B,
    GL_SAMPLER_1D_ARRAY               = 0x8DC0,
    GL_SAMPLER_2D_ARRAY               = 0x8DC1,
    GL_SAMPLER_1D_ARRAY_SHADOW        = 0x8DC3,
    GL_SAMPLER_2D_ARRAY_SHADOW        = 0x8DC4,
    GL_SAMPLER_CUBE_SHADOW            = 0x8DC5,
    GL_UNSIGNED_INT_VEC2              = 0x8DC6,
    GL_UNSIGNED_INT_VEC3              = 0x8DC7,
    GL_UNSIGNED_INT_VEC4              = 0x8DC8,
    GL_INT_SAMPLER_1D                 = 0x8DC9,
    GL_INT_SAMPLER_2D                 = 0x8DCA,
    GL_INT_SAMPLER_3D                 = 0x8DCB,
    GL_INT_SAMPLER_CUBE               = 0x8DCC,
    GL_INT_SAMPLER_1D_ARRAY           = 0x8DCE,
    GL_INT_SAMPLER_2D_ARRAY           = 0x8DCF,
    GL_UNSIGNED_INT_SAMPLER_1D        = 0x8DD1,
    GL_UNSIGNED_INT_SAMPLER_2D        = 0x8DD2,
    GL_UNSIGNED_INT_SAMPLER_3D        = 0x8DD3,
    GL_UNSIGNED_INT_SAMPLER_CUBE      = 0x8DD4,
    GL_UNSIGNED_INT_SAMPLER_1D_ARRAY  = 0x8DD6,
    GL_UNSIGNED_INT_SAMPLER_2D_ARRAY  = 0x8DD7,
    GL_QUERY_WAIT                     = 0x8E13,
    GL_QUERY_NO_WAIT                  = 0x8E14,
    GL_QUERY_BY_REGION_WAIT           = 0x8E15,
    GL_QUERY_BY_REGION_NO_WAIT        = 0x8E16,
    GL_BUFFER_ACCESS_FLAGS            = 0x911F,
    GL_BUFFER_MAP_LENGTH              = 0x9120,
    GL_BUFFER_MAP_OFFSET              = 0x9121,
    GL_DEPTH_COMPONENT32F             = 0x8CAC,
    GL_DEPTH32F_STENCIL8              = 0x8CAD,
    GL_FLOAT_32_UNSIGNED_INT_24_8_REV = 0x8DAD,
    GL_INVALID_FRAMEBUFFER_OPERATION  = 0x0506,
    GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 0x8210,
    GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 0x8211,
    GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE = 0x8212,
    GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 0x8213,
    GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 0x8214,
    GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 0x8215,
    GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 0x8216,
    GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 0x8217,
    GL_FRAMEBUFFER_DEFAULT            = 0x8218,
    GL_FRAMEBUFFER_UNDEFINED          = 0x8219,
    GL_DEPTH_STENCIL_ATTACHMENT       = 0x821A,
    GL_MAX_RENDERBUFFER_SIZE          = 0x84E8,
    GL_DEPTH_STENCIL                  = 0x84F9,
    GL_UNSIGNED_INT_24_8              = 0x84FA,
    GL_DEPTH24_STENCIL8               = 0x88F0,
    GL_TEXTURE_STENCIL_SIZE           = 0x88F1,
    GL_TEXTURE_RED_TYPE               = 0x8C10,
    GL_TEXTURE_GREEN_TYPE             = 0x8C11,
    GL_TEXTURE_BLUE_TYPE              = 0x8C12,
    GL_TEXTURE_ALPHA_TYPE             = 0x8C13,
    GL_TEXTURE_DEPTH_TYPE             = 0x8C16,
    GL_UNSIGNED_NORMALIZED            = 0x8C17,
    GL_FRAMEBUFFER_BINDING            = 0x8CA6,
    GL_DRAW_FRAMEBUFFER_BINDING       = 0x8CA6,
    GL_RENDERBUFFER_BINDING           = 0x8CA7,
    GL_READ_FRAMEBUFFER               = 0x8CA8,
    GL_DRAW_FRAMEBUFFER               = 0x8CA9,
    GL_READ_FRAMEBUFFER_BINDING       = 0x8CAA,
    GL_RENDERBUFFER_SAMPLES           = 0x8CAB,
    GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 0x8CD0,
    GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 0x8CD1,
    GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 0x8CD2,
    GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3,
    GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 0x8CD4,
    GL_FRAMEBUFFER_COMPLETE           = 0x8CD5,
    GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 0x8CD6,
    GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7,
    GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER = 0x8CDB,
    GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER = 0x8CDC,
    GL_FRAMEBUFFER_UNSUPPORTED        = 0x8CDD,
    GL_MAX_COLOR_ATTACHMENTS          = 0x8CDF,
    GL_COLOR_ATTACHMENT0              = 0x8CE0,
    GL_COLOR_ATTACHMENT1              = 0x8CE1,
    GL_COLOR_ATTACHMENT2              = 0x8CE2,
    GL_COLOR_ATTACHMENT3              = 0x8CE3,
    GL_COLOR_ATTACHMENT4              = 0x8CE4,
    GL_COLOR_ATTACHMENT5              = 0x8CE5,
    GL_COLOR_ATTACHMENT6              = 0x8CE6,
    GL_COLOR_ATTACHMENT7              = 0x8CE7,
    GL_COLOR_ATTACHMENT8              = 0x8CE8,
    GL_COLOR_ATTACHMENT9              = 0x8CE9,
    GL_COLOR_ATTACHMENT10             = 0x8CEA,
    GL_COLOR_ATTACHMENT11             = 0x8CEB,
    GL_COLOR_ATTACHMENT12             = 0x8CEC,
    GL_COLOR_ATTACHMENT13             = 0x8CED,
    GL_COLOR_ATTACHMENT14             = 0x8CEE,
    GL_COLOR_ATTACHMENT15             = 0x8CEF,
    GL_COLOR_ATTACHMENT16             = 0x8CF0,
    GL_COLOR_ATTACHMENT17             = 0x8CF1,
    GL_COLOR_ATTACHMENT18             = 0x8CF2,
    GL_COLOR_ATTACHMENT19             = 0x8CF3,
    GL_COLOR_ATTACHMENT20             = 0x8CF4,
    GL_COLOR_ATTACHMENT21             = 0x8CF5,
    GL_COLOR_ATTACHMENT22             = 0x8CF6,
    GL_COLOR_ATTACHMENT23             = 0x8CF7,
    GL_COLOR_ATTACHMENT24             = 0x8CF8,
    GL_COLOR_ATTACHMENT25             = 0x8CF9,
    GL_COLOR_ATTACHMENT26             = 0x8CFA,
    GL_COLOR_ATTACHMENT27             = 0x8CFB,
    GL_COLOR_ATTACHMENT28             = 0x8CFC,
    GL_COLOR_ATTACHMENT29             = 0x8CFD,
    GL_COLOR_ATTACHMENT30             = 0x8CFE,
    GL_COLOR_ATTACHMENT31             = 0x8CFF,
    GL_DEPTH_ATTACHMENT               = 0x8D00,
    GL_STENCIL_ATTACHMENT             = 0x8D20,
    GL_FRAMEBUFFER                    = 0x8D40,
    GL_RENDERBUFFER                   = 0x8D41,
    GL_RENDERBUFFER_WIDTH             = 0x8D42,
    GL_RENDERBUFFER_HEIGHT            = 0x8D43,
    GL_RENDERBUFFER_INTERNAL_FORMAT   = 0x8D44,
    GL_STENCIL_INDEX1                 = 0x8D46,
    GL_STENCIL_INDEX4                 = 0x8D47,
    GL_STENCIL_INDEX8                 = 0x8D48,
    GL_STENCIL_INDEX16                = 0x8D49,
    GL_RENDERBUFFER_RED_SIZE          = 0x8D50,
    GL_RENDERBUFFER_GREEN_SIZE        = 0x8D51,
    GL_RENDERBUFFER_BLUE_SIZE         = 0x8D52,
    GL_RENDERBUFFER_ALPHA_SIZE        = 0x8D53,
    GL_RENDERBUFFER_DEPTH_SIZE        = 0x8D54,
    GL_RENDERBUFFER_STENCIL_SIZE      = 0x8D55,
    GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 0x8D56,
    GL_MAX_SAMPLES                    = 0x8D57,
    GL_FRAMEBUFFER_SRGB               = 0x8DB9,
    GL_HALF_FLOAT                     = 0x140B,
    GL_MAP_READ_BIT                   = 0x0001,
    GL_MAP_WRITE_BIT                  = 0x0002,
    GL_MAP_INVALIDATE_RANGE_BIT       = 0x0004,
    GL_MAP_INVALIDATE_BUFFER_BIT      = 0x0008,
    GL_MAP_FLUSH_EXPLICIT_BIT         = 0x0010,
    GL_MAP_UNSYNCHRONIZED_BIT         = 0x0020,
    GL_COMPRESSED_RED_RGTC1           = 0x8DBB,
    GL_COMPRESSED_SIGNED_RED_RGTC1    = 0x8DBC,
    GL_COMPRESSED_RG_RGTC2            = 0x8DBD,
    GL_COMPRESSED_SIGNED_RG_RGTC2     = 0x8DBE,
    GL_RG                             = 0x8227,
    GL_RG_INTEGER                     = 0x8228,
    GL_R8                             = 0x8229,
    GL_R16                            = 0x822A,
    GL_RG8                            = 0x822B,
    GL_RG16                           = 0x822C,
    GL_R16F                           = 0x822D,
    GL_R32F                           = 0x822E,
    GL_RG16F                          = 0x822F,
    GL_RG32F                          = 0x8230,
    GL_R8I                            = 0x8231,
    GL_R8UI                           = 0x8232,
    GL_R16I                           = 0x8233,
    GL_R16UI                          = 0x8234,
    GL_R32I                           = 0x8235,
    GL_R32UI                          = 0x8236,
    GL_RG8I                           = 0x8237,
    GL_RG8UI                          = 0x8238,
    GL_RG16I                          = 0x8239,
    GL_RG16UI                         = 0x823A,
    GL_RG32I                          = 0x823B,
    GL_RG32UI                         = 0x823C,
    GL_VERTEX_ARRAY_BINDING           = 0x85B5
};

typedef void (* PFNGLCOLORMASKIPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
typedef void (* PFNGLGETBOOLEANI_VPROC) (GLenum target, GLuint index, GLboolean *data);
typedef void (* PFNGLGETINTEGERI_VPROC) (GLenum target, GLuint index, GLint *data);
typedef void (* PFNGLENABLEIPROC) (GLenum target, GLuint index);
typedef void (* PFNGLDISABLEIPROC) (GLenum target, GLuint index);
typedef GLboolean (* PFNGLISENABLEDIPROC) (GLenum target, GLuint index);
typedef void (* PFNGLBEGINTRANSFORMFEEDBACKPROC) (GLenum primitiveMode);
typedef void (* PFNGLENDTRANSFORMFEEDBACKPROC) (void);
typedef void (* PFNGLBINDBUFFERRANGEPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLBINDBUFFERBASEPROC) (GLenum target, GLuint index, GLuint buffer);
typedef void (* PFNGLTRANSFORMFEEDBACKVARYINGSPROC) (GLuint program, GLsizei count, const GLchar *const*varyings, GLenum bufferMode);
typedef void (* PFNGLGETTRANSFORMFEEDBACKVARYINGPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
typedef void (* PFNGLCLAMPCOLORPROC) (GLenum target, GLenum clamp);
typedef void (* PFNGLBEGINCONDITIONALRENDERPROC) (GLuint id, GLenum mode);
typedef void (* PFNGLENDCONDITIONALRENDERPROC) (void);
typedef void (* PFNGLVERTEXATTRIBIPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void (* PFNGLGETVERTEXATTRIBIIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void (* PFNGLGETVERTEXATTRIBIUIVPROC) (GLuint index, GLenum pname, GLuint *params);
typedef void (* PFNGLVERTEXATTRIBI1IPROC) (GLuint index, GLint x);
typedef void (* PFNGLVERTEXATTRIBI2IPROC) (GLuint index, GLint x, GLint y);
typedef void (* PFNGLVERTEXATTRIBI3IPROC) (GLuint index, GLint x, GLint y, GLint z);
typedef void (* PFNGLVERTEXATTRIBI4IPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void (* PFNGLVERTEXATTRIBI1UIPROC) (GLuint index, GLuint x);
typedef void (* PFNGLVERTEXATTRIBI2UIPROC) (GLuint index, GLuint x, GLuint y);
typedef void (* PFNGLVERTEXATTRIBI3UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z);
typedef void (* PFNGLVERTEXATTRIBI4UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void (* PFNGLVERTEXATTRIBI1IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI2IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI3IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI4IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI1UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI2UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI3UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI4UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI4BVPROC) (GLuint index, const GLbyte *v);
typedef void (* PFNGLVERTEXATTRIBI4SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIBI4UBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIBI4USVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLGETUNIFORMUIVPROC) (GLuint program, GLint location, GLuint *params);
typedef void (* PFNGLBINDFRAGDATALOCATIONPROC) (GLuint program, GLuint color, const GLchar *name);
typedef GLint (* PFNGLGETFRAGDATALOCATIONPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLUNIFORM1UIPROC) (GLint location, GLuint v0);
typedef void (* PFNGLUNIFORM2UIPROC) (GLint location, GLuint v0, GLuint v1);
typedef void (* PFNGLUNIFORM3UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void (* PFNGLUNIFORM4UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void (* PFNGLUNIFORM1UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLUNIFORM2UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLUNIFORM3UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLUNIFORM4UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, const GLuint *params);
typedef void (* PFNGLGETTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, GLuint *params);
typedef void (* PFNGLCLEARBUFFERIVPROC) (GLenum buffer, GLint drawbuffer, const GLint *value);
typedef void (* PFNGLCLEARBUFFERUIVPROC) (GLenum buffer, GLint drawbuffer, const GLuint *value);
typedef void (* PFNGLCLEARBUFFERFVPROC) (GLenum buffer, GLint drawbuffer, const GLfloat *value);
typedef void (* PFNGLCLEARBUFFERFIPROC) (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
typedef const GLubyte *(* PFNGLGETSTRINGIPROC) (GLenum name, GLuint index);
typedef GLboolean (* PFNGLISRENDERBUFFERPROC) (GLuint renderbuffer);
typedef void (* PFNGLBINDRENDERBUFFERPROC) (GLenum target, GLuint renderbuffer);
typedef void (* PFNGLDELETERENDERBUFFERSPROC) (GLsizei n, const GLuint *renderbuffers);
typedef void (* PFNGLGENRENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers);
typedef void (* PFNGLRENDERBUFFERSTORAGEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLGETRENDERBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef GLboolean (* PFNGLISFRAMEBUFFERPROC) (GLuint framebuffer);
typedef void (* PFNGLBINDFRAMEBUFFERPROC) (GLenum target, GLuint framebuffer);
typedef void (* PFNGLDELETEFRAMEBUFFERSPROC) (GLsizei n, const GLuint *framebuffers);
typedef void (* PFNGLGENFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers);
typedef GLenum (* PFNGLCHECKFRAMEBUFFERSTATUSPROC) (GLenum target);
typedef void (* PFNGLFRAMEBUFFERTEXTURE1DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (* PFNGLFRAMEBUFFERTEXTURE2DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (* PFNGLFRAMEBUFFERTEXTURE3DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void (* PFNGLFRAMEBUFFERRENDERBUFFERPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void (* PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params);
typedef void (* PFNGLGENERATEMIPMAPPROC) (GLenum target);
typedef void (* PFNGLBLITFRAMEBUFFERPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef void (* PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLFRAMEBUFFERTEXTURELAYERPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void *(* PFNGLMAPBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef void (* PFNGLFLUSHMAPPEDBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length);
typedef void (* PFNGLBINDVERTEXARRAYPROC) (GLuint array);
typedef void (* PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays);
typedef void (* PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean (* PFNGLISVERTEXARRAYPROC) (GLuint array);
void glColorMaski (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
void glGetBooleani_v (GLenum target, GLuint index, GLboolean *data);
void glGetIntegeri_v (GLenum target, GLuint index, GLint *data);
void glEnablei (GLenum target, GLuint index);
void glDisablei (GLenum target, GLuint index);
GLboolean glIsEnabledi (GLenum target, GLuint index);
void glBeginTransformFeedback (GLenum primitiveMode);
void glEndTransformFeedback (void);
void glBindBufferRange (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
void glBindBufferBase (GLenum target, GLuint index, GLuint buffer);
void glTransformFeedbackVaryings (GLuint program, GLsizei count, const GLchar *const*varyings, GLenum bufferMode);
void glGetTransformFeedbackVarying (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
void glClampColor (GLenum target, GLenum clamp);
void glBeginConditionalRender (GLuint id, GLenum mode);
void glEndConditionalRender (void);
void glVertexAttribIPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
void glGetVertexAttribIiv (GLuint index, GLenum pname, GLint *params);
void glGetVertexAttribIuiv (GLuint index, GLenum pname, GLuint *params);
void glVertexAttribI1i (GLuint index, GLint x);
void glVertexAttribI2i (GLuint index, GLint x, GLint y);
void glVertexAttribI3i (GLuint index, GLint x, GLint y, GLint z);
void glVertexAttribI4i (GLuint index, GLint x, GLint y, GLint z, GLint w);
void glVertexAttribI1ui (GLuint index, GLuint x);
void glVertexAttribI2ui (GLuint index, GLuint x, GLuint y);
void glVertexAttribI3ui (GLuint index, GLuint x, GLuint y, GLuint z);
void glVertexAttribI4ui (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
void glVertexAttribI1iv (GLuint index, const GLint *v);
void glVertexAttribI2iv (GLuint index, const GLint *v);
void glVertexAttribI3iv (GLuint index, const GLint *v);
void glVertexAttribI4iv (GLuint index, const GLint *v);
void glVertexAttribI1uiv (GLuint index, const GLuint *v);
void glVertexAttribI2uiv (GLuint index, const GLuint *v);
void glVertexAttribI3uiv (GLuint index, const GLuint *v);
void glVertexAttribI4uiv (GLuint index, const GLuint *v);
void glVertexAttribI4bv (GLuint index, const GLbyte *v);
void glVertexAttribI4sv (GLuint index, const GLshort *v);
void glVertexAttribI4ubv (GLuint index, const GLubyte *v);
void glVertexAttribI4usv (GLuint index, const GLushort *v);
void glGetUniformuiv (GLuint program, GLint location, GLuint *params);
void glBindFragDataLocation (GLuint program, GLuint color, const GLchar *name);
GLint glGetFragDataLocation (GLuint program, const GLchar *name);
void glUniform1ui (GLint location, GLuint v0);
void glUniform2ui (GLint location, GLuint v0, GLuint v1);
void glUniform3ui (GLint location, GLuint v0, GLuint v1, GLuint v2);
void glUniform4ui (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
void glUniform1uiv (GLint location, GLsizei count, const GLuint *value);
void glUniform2uiv (GLint location, GLsizei count, const GLuint *value);
void glUniform3uiv (GLint location, GLsizei count, const GLuint *value);
void glUniform4uiv (GLint location, GLsizei count, const GLuint *value);
void glTexParameterIiv (GLenum target, GLenum pname, const GLint *params);
void glTexParameterIuiv (GLenum target, GLenum pname, const GLuint *params);
void glGetTexParameterIiv (GLenum target, GLenum pname, GLint *params);
void glGetTexParameterIuiv (GLenum target, GLenum pname, GLuint *params);
void glClearBufferiv (GLenum buffer, GLint drawbuffer, const GLint *value);
void glClearBufferuiv (GLenum buffer, GLint drawbuffer, const GLuint *value);
void glClearBufferfv (GLenum buffer, GLint drawbuffer, const GLfloat *value);
void glClearBufferfi (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
const GLubyte *glGetStringi (GLenum name, GLuint index);
GLboolean glIsRenderbuffer (GLuint renderbuffer);
void glBindRenderbuffer (GLenum target, GLuint renderbuffer);
void glDeleteRenderbuffers (GLsizei n, const GLuint *renderbuffers);
void glGenRenderbuffers (GLsizei n, GLuint *renderbuffers);
void glRenderbufferStorage (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
void glGetRenderbufferParameteriv (GLenum target, GLenum pname, GLint *params);
GLboolean glIsFramebuffer (GLuint framebuffer);
void glBindFramebuffer (GLenum target, GLuint framebuffer);
void glDeleteFramebuffers (GLsizei n, const GLuint *framebuffers);
void glGenFramebuffers (GLsizei n, GLuint *framebuffers);
GLenum glCheckFramebufferStatus (GLenum target);
void glFramebufferTexture1D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void glFramebufferTexture2D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void glFramebufferTexture3D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
void glFramebufferRenderbuffer (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
void glGetFramebufferAttachmentParameteriv (GLenum target, GLenum attachment, GLenum pname, GLint *params);
void glGenerateMipmap (GLenum target);
void glBlitFramebuffer (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
void glRenderbufferStorageMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
void glFramebufferTextureLayer (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
void *glMapBufferRange (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
void glFlushMappedBufferRange (GLenum target, GLintptr offset, GLsizeiptr length);
void glBindVertexArray (GLuint array);
void glDeleteVertexArrays (GLsizei n, const GLuint *arrays);
void glGenVertexArrays (GLsizei n, GLuint *arrays);
GLboolean glIsVertexArray (GLuint array);

enum { GL_VERSION_3_1 = 1 };
enum {
    GL_SAMPLER_2D_RECT                = 0x8B63,
    GL_SAMPLER_2D_RECT_SHADOW         = 0x8B64,
    GL_SAMPLER_BUFFER                 = 0x8DC2,
    GL_INT_SAMPLER_2D_RECT            = 0x8DCD,
    GL_INT_SAMPLER_BUFFER             = 0x8DD0,
    GL_UNSIGNED_INT_SAMPLER_2D_RECT   = 0x8DD5,
    GL_UNSIGNED_INT_SAMPLER_BUFFER    = 0x8DD8,
    GL_TEXTURE_BUFFER                 = 0x8C2A,
    GL_MAX_TEXTURE_BUFFER_SIZE        = 0x8C2B,
    GL_TEXTURE_BINDING_BUFFER         = 0x8C2C,
    GL_TEXTURE_BUFFER_DATA_STORE_BINDING = 0x8C2D,
    GL_TEXTURE_RECTANGLE              = 0x84F5,
    GL_TEXTURE_BINDING_RECTANGLE      = 0x84F6,
    GL_PROXY_TEXTURE_RECTANGLE        = 0x84F7,
    GL_MAX_RECTANGLE_TEXTURE_SIZE     = 0x84F8,
    GL_R8_SNORM                       = 0x8F94,
    GL_RG8_SNORM                      = 0x8F95,
    GL_RGB8_SNORM                     = 0x8F96,
    GL_RGBA8_SNORM                    = 0x8F97,
    GL_R16_SNORM                      = 0x8F98,
    GL_RG16_SNORM                     = 0x8F99,
    GL_RGB16_SNORM                    = 0x8F9A,
    GL_RGBA16_SNORM                   = 0x8F9B,
    GL_SIGNED_NORMALIZED              = 0x8F9C,
    GL_PRIMITIVE_RESTART              = 0x8F9D,
    GL_PRIMITIVE_RESTART_INDEX        = 0x8F9E,
    GL_COPY_READ_BUFFER               = 0x8F36,
    GL_COPY_WRITE_BUFFER              = 0x8F37,
    GL_UNIFORM_BUFFER                 = 0x8A11,
    GL_UNIFORM_BUFFER_BINDING         = 0x8A28,
    GL_UNIFORM_BUFFER_START           = 0x8A29,
    GL_UNIFORM_BUFFER_SIZE            = 0x8A2A,
    GL_MAX_VERTEX_UNIFORM_BLOCKS      = 0x8A2B,
    GL_MAX_GEOMETRY_UNIFORM_BLOCKS    = 0x8A2C,
    GL_MAX_FRAGMENT_UNIFORM_BLOCKS    = 0x8A2D,
    GL_MAX_COMBINED_UNIFORM_BLOCKS    = 0x8A2E,
    GL_MAX_UNIFORM_BUFFER_BINDINGS    = 0x8A2F,
    GL_MAX_UNIFORM_BLOCK_SIZE         = 0x8A30,
    GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 0x8A31,
    GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS = 0x8A32,
    GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 0x8A33,
    GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT = 0x8A34,
    GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 0x8A35,
    GL_ACTIVE_UNIFORM_BLOCKS          = 0x8A36,
    GL_UNIFORM_TYPE                   = 0x8A37,
    GL_UNIFORM_SIZE                   = 0x8A38,
    GL_UNIFORM_NAME_LENGTH            = 0x8A39,
    GL_UNIFORM_BLOCK_INDEX            = 0x8A3A,
    GL_UNIFORM_OFFSET                 = 0x8A3B,
    GL_UNIFORM_ARRAY_STRIDE           = 0x8A3C,
    GL_UNIFORM_MATRIX_STRIDE          = 0x8A3D,
    GL_UNIFORM_IS_ROW_MAJOR           = 0x8A3E,
    GL_UNIFORM_BLOCK_BINDING          = 0x8A3F,
    GL_UNIFORM_BLOCK_DATA_SIZE        = 0x8A40,
    GL_UNIFORM_BLOCK_NAME_LENGTH      = 0x8A41,
    GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS  = 0x8A42,
    GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 0x8A43,
    GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 0x8A44,
    GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER = 0x8A45,
    GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 0x8A46,
    GL_INVALID_INDEX                  = 0xFFFFFFFFu
};
typedef void (* PFNGLDRAWARRAYSINSTANCEDPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount);
typedef void (* PFNGLTEXBUFFERPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void (* PFNGLPRIMITIVERESTARTINDEXPROC) (GLuint index);
typedef void (* PFNGLCOPYBUFFERSUBDATAPROC) (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void (* PFNGLGETUNIFORMINDICESPROC) (GLuint program, GLsizei uniformCount, const GLchar *const*uniformNames, GLuint *uniformIndices);
typedef void (* PFNGLGETACTIVEUNIFORMSIVPROC) (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
typedef void (* PFNGLGETACTIVEUNIFORMNAMEPROC) (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
typedef GLuint (* PFNGLGETUNIFORMBLOCKINDEXPROC) (GLuint program, const GLchar *uniformBlockName);
typedef void (* PFNGLGETACTIVEUNIFORMBLOCKIVPROC) (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
typedef void (* PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC) (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
typedef void (* PFNGLUNIFORMBLOCKBINDINGPROC) (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);
void glDrawArraysInstanced (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
void glDrawElementsInstanced (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount);
void glTexBuffer (GLenum target, GLenum internalformat, GLuint buffer);
void glPrimitiveRestartIndex (GLuint index);
void glCopyBufferSubData (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
void glGetUniformIndices (GLuint program, GLsizei uniformCount, const GLchar *const*uniformNames, GLuint *uniformIndices);
void glGetActiveUniformsiv (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
void glGetActiveUniformName (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
GLuint glGetUniformBlockIndex (GLuint program, const GLchar *uniformBlockName);
void glGetActiveUniformBlockiv (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
void glGetActiveUniformBlockName (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
void glUniformBlockBinding (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);


enum { GL_VERSION_3_2 = 1 };
typedef struct __GLsync *GLsync;
typedef uint64_t GLuint64;
typedef int64_t GLint64;
enum {
    GL_CONTEXT_CORE_PROFILE_BIT       = 0x00000001,
    GL_CONTEXT_COMPATIBILITY_PROFILE_BIT = 0x00000002,
    GL_LINES_ADJACENCY                = 0x000A,
    GL_LINE_STRIP_ADJACENCY           = 0x000B,
    GL_TRIANGLES_ADJACENCY            = 0x000C,
    GL_TRIANGLE_STRIP_ADJACENCY       = 0x000D,
    GL_PROGRAM_POINT_SIZE             = 0x8642,
    GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS = 0x8C29,
    GL_FRAMEBUFFER_ATTACHMENT_LAYERED = 0x8DA7,
    GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS = 0x8DA8,
    GL_GEOMETRY_SHADER                = 0x8DD9,
    GL_GEOMETRY_VERTICES_OUT          = 0x8916,
    GL_GEOMETRY_INPUT_TYPE            = 0x8917,
    GL_GEOMETRY_OUTPUT_TYPE           = 0x8918,
    GL_MAX_GEOMETRY_UNIFORM_COMPONENTS = 0x8DDF,
    GL_MAX_GEOMETRY_OUTPUT_VERTICES   = 0x8DE0,
    GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS = 0x8DE1,
    GL_MAX_VERTEX_OUTPUT_COMPONENTS   = 0x9122,
    GL_MAX_GEOMETRY_INPUT_COMPONENTS  = 0x9123,
    GL_MAX_GEOMETRY_OUTPUT_COMPONENTS = 0x9124,
    GL_MAX_FRAGMENT_INPUT_COMPONENTS  = 0x9125,
    GL_CONTEXT_PROFILE_MASK           = 0x9126,
    GL_DEPTH_CLAMP                    = 0x864F,
    GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION = 0x8E4C,
    GL_FIRST_VERTEX_CONVENTION        = 0x8E4D,
    GL_LAST_VERTEX_CONVENTION         = 0x8E4E,
    GL_PROVOKING_VERTEX               = 0x8E4F,
    GL_TEXTURE_CUBE_MAP_SEAMLESS      = 0x884F,
    GL_MAX_SERVER_WAIT_TIMEOUT        = 0x9111,
    GL_OBJECT_TYPE                    = 0x9112,
    GL_SYNC_CONDITION                 = 0x9113,
    GL_SYNC_STATUS                    = 0x9114,
    GL_SYNC_FLAGS                     = 0x9115,
    GL_SYNC_FENCE                     = 0x9116,
    GL_SYNC_GPU_COMMANDS_COMPLETE     = 0x9117,
    GL_UNSIGNALED                     = 0x9118,
    GL_SIGNALED                       = 0x9119,
    GL_ALREADY_SIGNALED               = 0x911A,
    GL_TIMEOUT_EXPIRED                = 0x911B,
    GL_CONDITION_SATISFIED            = 0x911C,
    GL_WAIT_FAILED                    = 0x911D,
/* GL_TIMEOUT_IGNORED                 = 0xFFFFFFFFFFFFFFFFull, */
    GL_SYNC_FLUSH_COMMANDS_BIT        = 0x00000001,
    GL_SAMPLE_POSITION                = 0x8E50,
    GL_SAMPLE_MASK                    = 0x8E51,
    GL_SAMPLE_MASK_VALUE              = 0x8E52,
    GL_MAX_SAMPLE_MASK_WORDS          = 0x8E59,
    GL_TEXTURE_2D_MULTISAMPLE         = 0x9100,
    GL_PROXY_TEXTURE_2D_MULTISAMPLE   = 0x9101,
    GL_TEXTURE_2D_MULTISAMPLE_ARRAY   = 0x9102,
    GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY = 0x9103,
    GL_TEXTURE_BINDING_2D_MULTISAMPLE = 0x9104,
    GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY = 0x9105,
    GL_TEXTURE_SAMPLES                = 0x9106,
    GL_TEXTURE_FIXED_SAMPLE_LOCATIONS = 0x9107,
    GL_SAMPLER_2D_MULTISAMPLE         = 0x9108,
    GL_INT_SAMPLER_2D_MULTISAMPLE     = 0x9109,
    GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE = 0x910A,
    GL_SAMPLER_2D_MULTISAMPLE_ARRAY   = 0x910B,
    GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910C,
    GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY = 0x910D,
    GL_MAX_COLOR_TEXTURE_SAMPLES      = 0x910E,
    GL_MAX_DEPTH_TEXTURE_SAMPLES      = 0x910F,
    GL_MAX_INTEGER_SAMPLES            = 0x9110
};
typedef void (* PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLint basevertex);
typedef void (* PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices, GLint basevertex);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex);
typedef void (* PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount, const GLint *basevertex);
typedef void (* PFNGLPROVOKINGVERTEXPROC) (GLenum mode);
typedef GLsync (* PFNGLFENCESYNCPROC) (GLenum condition, GLbitfield flags);
typedef GLboolean (* PFNGLISSYNCPROC) (GLsync sync);
typedef void (* PFNGLDELETESYNCPROC) (GLsync sync);
typedef GLenum (* PFNGLCLIENTWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void (* PFNGLWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void (* PFNGLGETINTEGER64VPROC) (GLenum pname, GLint64 *data);
typedef void (* PFNGLGETSYNCIVPROC) (GLsync sync, GLenum pname, GLsizei count, GLsizei *length, GLint *values);
typedef void (* PFNGLGETINTEGER64I_VPROC) (GLenum target, GLuint index, GLint64 *data);
typedef void (* PFNGLGETBUFFERPARAMETERI64VPROC) (GLenum target, GLenum pname, GLint64 *params);
typedef void (* PFNGLFRAMEBUFFERTEXTUREPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void (* PFNGLTEXIMAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXIMAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLGETMULTISAMPLEFVPROC) (GLenum pname, GLuint index, GLfloat *val);
typedef void (* PFNGLSAMPLEMASKIPROC) (GLuint maskNumber, GLbitfield mask);
void glDrawElementsBaseVertex (GLenum mode, GLsizei count, GLenum type, const void *indices, GLint basevertex);
void glDrawRangeElementsBaseVertex (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const void *indices, GLint basevertex);
void glDrawElementsInstancedBaseVertex (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex);
void glMultiDrawElementsBaseVertex (GLenum mode, const GLsizei *count, GLenum type, const void *const*indices, GLsizei drawcount, const GLint *basevertex);
void glProvokingVertex (GLenum mode);
GLsync glFenceSync (GLenum condition, GLbitfield flags);
GLboolean glIsSync (GLsync sync);
void glDeleteSync (GLsync sync);
GLenum glClientWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout);
void glWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout);
void glGetInteger64v (GLenum pname, GLint64 *data);
void glGetSynciv (GLsync sync, GLenum pname, GLsizei count, GLsizei *length, GLint *values);
void glGetInteger64i_v (GLenum target, GLuint index, GLint64 *data);
void glGetBufferParameteri64v (GLenum target, GLenum pname, GLint64 *params);
void glFramebufferTexture (GLenum target, GLenum attachment, GLuint texture, GLint level);
void glTexImage2DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
void glTexImage3DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
void glGetMultisamplefv (GLenum pname, GLuint index, GLfloat *val);
void glSampleMaski (GLuint maskNumber, GLbitfield mask);

enum { GL_VERSION_3_3 = 1 };
enum {
    GL_VERTEX_ATTRIB_ARRAY_DIVISOR    = 0x88FE,
    GL_SRC1_COLOR                     = 0x88F9,
    GL_ONE_MINUS_SRC1_COLOR           = 0x88FA,
    GL_ONE_MINUS_SRC1_ALPHA           = 0x88FB,
    GL_MAX_DUAL_SOURCE_DRAW_BUFFERS   = 0x88FC,
    GL_ANY_SAMPLES_PASSED             = 0x8C2F,
    GL_SAMPLER_BINDING                = 0x8919,
    GL_RGB10_A2UI                     = 0x906F,
    GL_TEXTURE_SWIZZLE_R              = 0x8E42,
    GL_TEXTURE_SWIZZLE_G              = 0x8E43,
    GL_TEXTURE_SWIZZLE_B              = 0x8E44,
    GL_TEXTURE_SWIZZLE_A              = 0x8E45,
    GL_TEXTURE_SWIZZLE_RGBA           = 0x8E46,
    GL_TIME_ELAPSED                   = 0x88BF,
    GL_TIMESTAMP                      = 0x8E28,
    GL_INT_2_10_10_10_REV             = 0x8D9F
};
typedef void (* PFNGLBINDFRAGDATALOCATIONINDEXEDPROC) (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
typedef GLint (* PFNGLGETFRAGDATAINDEXPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLGENSAMPLERSPROC) (GLsizei count, GLuint *samplers);
typedef void (* PFNGLDELETESAMPLERSPROC) (GLsizei count, const GLuint *samplers);
typedef GLboolean (* PFNGLISSAMPLERPROC) (GLuint sampler);
typedef void (* PFNGLBINDSAMPLERPROC) (GLuint unit, GLuint sampler);
typedef void (* PFNGLSAMPLERPARAMETERIPROC) (GLuint sampler, GLenum pname, GLint param);
typedef void (* PFNGLSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void (* PFNGLSAMPLERPARAMETERFPROC) (GLuint sampler, GLenum pname, GLfloat param);
typedef void (* PFNGLSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, const GLfloat *param);
typedef void (* PFNGLSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void (* PFNGLSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, const GLuint *param);
typedef void (* PFNGLGETSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void (* PFNGLGETSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void (* PFNGLGETSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, GLuint *params);
typedef void (* PFNGLQUERYCOUNTERPROC) (GLuint id, GLenum target);
typedef void (* PFNGLGETQUERYOBJECTI64VPROC) (GLuint id, GLenum pname, GLint64 *params);
typedef void (* PFNGLGETQUERYOBJECTUI64VPROC) (GLuint id, GLenum pname, GLuint64 *params);
typedef void (* PFNGLVERTEXATTRIBDIVISORPROC) (GLuint index, GLuint divisor);
typedef void (* PFNGLVERTEXATTRIBP1UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP1UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXATTRIBP2UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP2UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXATTRIBP3UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP3UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXATTRIBP4UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP4UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
void glBindFragDataLocationIndexed (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
GLint glGetFragDataIndex (GLuint program, const GLchar *name);
void glGenSamplers (GLsizei count, GLuint *samplers);
void glDeleteSamplers (GLsizei count, const GLuint *samplers);
GLboolean glIsSampler (GLuint sampler);
void glBindSampler (GLuint unit, GLuint sampler);
void glSamplerParameteri (GLuint sampler, GLenum pname, GLint param);
void glSamplerParameteriv (GLuint sampler, GLenum pname, const GLint *param);
void glSamplerParameterf (GLuint sampler, GLenum pname, GLfloat param);
void glSamplerParameterfv (GLuint sampler, GLenum pname, const GLfloat *param);
void glSamplerParameterIiv (GLuint sampler, GLenum pname, const GLint *param);
void glSamplerParameterIuiv (GLuint sampler, GLenum pname, const GLuint *param);
void glGetSamplerParameteriv (GLuint sampler, GLenum pname, GLint *params);
void glGetSamplerParameterIiv (GLuint sampler, GLenum pname, GLint *params);
void glGetSamplerParameterfv (GLuint sampler, GLenum pname, GLfloat *params);
void glGetSamplerParameterIuiv (GLuint sampler, GLenum pname, GLuint *params);
void glQueryCounter (GLuint id, GLenum target);
void glGetQueryObjecti64v (GLuint id, GLenum pname, GLint64 *params);
void glGetQueryObjectui64v (GLuint id, GLenum pname, GLuint64 *params);
void glVertexAttribDivisor (GLuint index, GLuint divisor);
void glVertexAttribP1ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
void glVertexAttribP1uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
void glVertexAttribP2ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
void glVertexAttribP2uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
void glVertexAttribP3ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
void glVertexAttribP3uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
void glVertexAttribP4ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
void glVertexAttribP4uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);

enum { GL_VERSION_4_0 = 1 };
enum {
    GL_SAMPLE_SHADING                 = 0x8C36,
    GL_MIN_SAMPLE_SHADING_VALUE       = 0x8C37,
    GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET = 0x8E5E,
    GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET = 0x8E5F,
    GL_TEXTURE_CUBE_MAP_ARRAY         = 0x9009,
    GL_TEXTURE_BINDING_CUBE_MAP_ARRAY = 0x900A,
    GL_PROXY_TEXTURE_CUBE_MAP_ARRAY   = 0x900B,
    GL_SAMPLER_CUBE_MAP_ARRAY         = 0x900C,
    GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW  = 0x900D,
    GL_INT_SAMPLER_CUBE_MAP_ARRAY     = 0x900E,
    GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY = 0x900F,
    GL_DRAW_INDIRECT_BUFFER           = 0x8F3F,
    GL_DRAW_INDIRECT_BUFFER_BINDING   = 0x8F43,
    GL_GEOMETRY_SHADER_INVOCATIONS    = 0x887F,
    GL_MAX_GEOMETRY_SHADER_INVOCATIONS = 0x8E5A,
    GL_MIN_FRAGMENT_INTERPOLATION_OFFSET = 0x8E5B,
    GL_MAX_FRAGMENT_INTERPOLATION_OFFSET = 0x8E5C,
    GL_FRAGMENT_INTERPOLATION_OFFSET_BITS = 0x8E5D,
    GL_MAX_VERTEX_STREAMS             = 0x8E71,
    GL_DOUBLE_VEC2                    = 0x8FFC,
    GL_DOUBLE_VEC3                    = 0x8FFD,
    GL_DOUBLE_VEC4                    = 0x8FFE,
    GL_DOUBLE_MAT2                    = 0x8F46,
    GL_DOUBLE_MAT3                    = 0x8F47,
    GL_DOUBLE_MAT4                    = 0x8F48,
    GL_DOUBLE_MAT2x3                  = 0x8F49,
    GL_DOUBLE_MAT2x4                  = 0x8F4A,
    GL_DOUBLE_MAT3x2                  = 0x8F4B,
    GL_DOUBLE_MAT3x4                  = 0x8F4C,
    GL_DOUBLE_MAT4x2                  = 0x8F4D,
    GL_DOUBLE_MAT4x3                  = 0x8F4E,
    GL_ACTIVE_SUBROUTINES             = 0x8DE5,
    GL_ACTIVE_SUBROUTINE_UNIFORMS     = 0x8DE6,
    GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS = 0x8E47,
    GL_ACTIVE_SUBROUTINE_MAX_LENGTH   = 0x8E48,
    GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH = 0x8E49,
    GL_MAX_SUBROUTINES                = 0x8DE7,
    GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS = 0x8DE8,
    GL_NUM_COMPATIBLE_SUBROUTINES     = 0x8E4A,
    GL_COMPATIBLE_SUBROUTINES         = 0x8E4B,
    GL_PATCHES                        = 0x000E,
    GL_PATCH_VERTICES                 = 0x8E72,
    GL_PATCH_DEFAULT_INNER_LEVEL      = 0x8E73,
    GL_PATCH_DEFAULT_OUTER_LEVEL      = 0x8E74,
    GL_TESS_CONTROL_OUTPUT_VERTICES   = 0x8E75,
    GL_TESS_GEN_MODE                  = 0x8E76,
    GL_TESS_GEN_SPACING               = 0x8E77,
    GL_TESS_GEN_VERTEX_ORDER          = 0x8E78,
    GL_TESS_GEN_POINT_MODE            = 0x8E79,
    GL_ISOLINES                       = 0x8E7A,
    GL_FRACTIONAL_ODD                 = 0x8E7B,
    GL_FRACTIONAL_EVEN                = 0x8E7C,
    GL_MAX_PATCH_VERTICES             = 0x8E7D,
    GL_MAX_TESS_GEN_LEVEL             = 0x8E7E,
    GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS = 0x8E7F,
    GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS = 0x8E80,
    GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS = 0x8E81,
    GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = 0x8E82,
    GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS = 0x8E83,
    GL_MAX_TESS_PATCH_COMPONENTS      = 0x8E84,
    GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS = 0x8E85,
    GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS = 0x8E86,
    GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS = 0x8E89,
    GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS = 0x8E8A,
    GL_MAX_TESS_CONTROL_INPUT_COMPONENTS = 0x886C,
    GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS = 0x886D,
    GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS = 0x8E1E,
    GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS = 0x8E1F,
    GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER = 0x84F0,
    GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER = 0x84F1,
    GL_TESS_EVALUATION_SHADER         = 0x8E87,
    GL_TESS_CONTROL_SHADER            = 0x8E88,
    GL_TRANSFORM_FEEDBACK             = 0x8E22,
    GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED = 0x8E23,
    GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE = 0x8E24,
    GL_TRANSFORM_FEEDBACK_BINDING     = 0x8E25,
    GL_MAX_TRANSFORM_FEEDBACK_BUFFERS = 0x8E70
};

typedef void (* PFNGLMINSAMPLESHADINGPROC) (GLfloat value);
typedef void (* PFNGLBLENDEQUATIONIPROC) (GLuint buf, GLenum mode);
typedef void (* PFNGLBLENDEQUATIONSEPARATEIPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void (* PFNGLBLENDFUNCIPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void (* PFNGLBLENDFUNCSEPARATEIPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
typedef void (* PFNGLDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect);
typedef void (* PFNGLDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect);
typedef void (* PFNGLUNIFORM1DPROC) (GLint location, GLdouble x);
typedef void (* PFNGLUNIFORM2DPROC) (GLint location, GLdouble x, GLdouble y);
typedef void (* PFNGLUNIFORM3DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLUNIFORM4DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLUNIFORM1DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORM2DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORM3DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORM4DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX2X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX2X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX3X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX3X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX4X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX4X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLGETUNIFORMDVPROC) (GLuint program, GLint location, GLdouble *params);
typedef GLint (* PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef GLuint (* PFNGLGETSUBROUTINEINDEXPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef void (* PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC) (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
typedef void (* PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void (* PFNGLGETACTIVESUBROUTINENAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void (* PFNGLUNIFORMSUBROUTINESUIVPROC) (GLenum shadertype, GLsizei count, const GLuint *indices);
typedef void (* PFNGLGETUNIFORMSUBROUTINEUIVPROC) (GLenum shadertype, GLint location, GLuint *params);
typedef void (* PFNGLGETPROGRAMSTAGEIVPROC) (GLuint program, GLenum shadertype, GLenum pname, GLint *values);
typedef void (* PFNGLPATCHPARAMETERIPROC) (GLenum pname, GLint value);
typedef void (* PFNGLPATCHPARAMETERFVPROC) (GLenum pname, const GLfloat *values);
typedef void (* PFNGLBINDTRANSFORMFEEDBACKPROC) (GLenum target, GLuint id);
typedef void (* PFNGLDELETETRANSFORMFEEDBACKSPROC) (GLsizei n, const GLuint *ids);
typedef void (* PFNGLGENTRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef GLboolean (* PFNGLISTRANSFORMFEEDBACKPROC) (GLuint id);
typedef void (* PFNGLPAUSETRANSFORMFEEDBACKPROC) (void);
typedef void (* PFNGLRESUMETRANSFORMFEEDBACKPROC) (void);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKPROC) (GLenum mode, GLuint id);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC) (GLenum mode, GLuint id, GLuint stream);
typedef void (* PFNGLBEGINQUERYINDEXEDPROC) (GLenum target, GLuint index, GLuint id);
typedef void (* PFNGLENDQUERYINDEXEDPROC) (GLenum target, GLuint index);
typedef void (* PFNGLGETQUERYINDEXEDIVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params);
void glMinSampleShading (GLfloat value);
void glBlendEquationi (GLuint buf, GLenum mode);
void glBlendEquationSeparatei (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
void glBlendFunci (GLuint buf, GLenum src, GLenum dst);
void glBlendFuncSeparatei (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
void glDrawArraysIndirect (GLenum mode, const void *indirect);
void glDrawElementsIndirect (GLenum mode, GLenum type, const void *indirect);
void glUniform1d (GLint location, GLdouble x);
void glUniform2d (GLint location, GLdouble x, GLdouble y);
void glUniform3d (GLint location, GLdouble x, GLdouble y, GLdouble z);
void glUniform4d (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glUniform1dv (GLint location, GLsizei count, const GLdouble *value);
void glUniform2dv (GLint location, GLsizei count, const GLdouble *value);
void glUniform3dv (GLint location, GLsizei count, const GLdouble *value);
void glUniform4dv (GLint location, GLsizei count, const GLdouble *value);
void glUniformMatrix2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix2x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix2x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix3x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix3x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix4x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glUniformMatrix4x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glGetUniformdv (GLuint program, GLint location, GLdouble *params);
GLint glGetSubroutineUniformLocation (GLuint program, GLenum shadertype, const GLchar *name);
GLuint glGetSubroutineIndex (GLuint program, GLenum shadertype, const GLchar *name);
void glGetActiveSubroutineUniformiv (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
void glGetActiveSubroutineUniformName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
void glGetActiveSubroutineName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
void glUniformSubroutinesuiv (GLenum shadertype, GLsizei count, const GLuint *indices);
void glGetUniformSubroutineuiv (GLenum shadertype, GLint location, GLuint *params);
void glGetProgramStageiv (GLuint program, GLenum shadertype, GLenum pname, GLint *values);
void glPatchParameteri (GLenum pname, GLint value);
void glPatchParameterfv (GLenum pname, const GLfloat *values);
void glBindTransformFeedback (GLenum target, GLuint id);
void glDeleteTransformFeedbacks (GLsizei n, const GLuint *ids);
void glGenTransformFeedbacks (GLsizei n, GLuint *ids);
GLboolean glIsTransformFeedback (GLuint id);
void glPauseTransformFeedback (void);
void glResumeTransformFeedback (void);
void glDrawTransformFeedback (GLenum mode, GLuint id);
void glDrawTransformFeedbackStream (GLenum mode, GLuint id, GLuint stream);
void glBeginQueryIndexed (GLenum target, GLuint index, GLuint id);
void glEndQueryIndexed (GLenum target, GLuint index);
void glGetQueryIndexediv (GLenum target, GLuint index, GLenum pname, GLint *params);

enum { GL_VERSION_4_1 = 1 };
enum {
    GL_FIXED                          = 0x140C,
    GL_IMPLEMENTATION_COLOR_READ_TYPE = 0x8B9A,
    GL_IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B,
    GL_LOW_FLOAT                      = 0x8DF0,
    GL_MEDIUM_FLOAT                   = 0x8DF1,
    GL_HIGH_FLOAT                     = 0x8DF2,
    GL_LOW_INT                        = 0x8DF3,
    GL_MEDIUM_INT                     = 0x8DF4,
    GL_HIGH_INT                       = 0x8DF5,
    GL_SHADER_COMPILER                = 0x8DFA,
    GL_SHADER_BINARY_FORMATS          = 0x8DF8,
    GL_NUM_SHADER_BINARY_FORMATS      = 0x8DF9,
    GL_MAX_VERTEX_UNIFORM_VECTORS     = 0x8DFB,
    GL_MAX_VARYING_VECTORS            = 0x8DFC,
    GL_MAX_FRAGMENT_UNIFORM_VECTORS   = 0x8DFD,
    GL_RGB565                         = 0x8D62,
    GL_PROGRAM_BINARY_RETRIEVABLE_HINT = 0x8257,
    GL_PROGRAM_BINARY_LENGTH          = 0x8741,
    GL_NUM_PROGRAM_BINARY_FORMATS     = 0x87FE,
    GL_PROGRAM_BINARY_FORMATS         = 0x87FF,
    GL_VERTEX_SHADER_BIT              = 0x00000001,
    GL_FRAGMENT_SHADER_BIT            = 0x00000002,
    GL_GEOMETRY_SHADER_BIT            = 0x00000004,
    GL_TESS_CONTROL_SHADER_BIT        = 0x00000008,
    GL_TESS_EVALUATION_SHADER_BIT     = 0x00000010,
    GL_ALL_SHADER_BITS                = 0xFFFFFFFF,
    GL_PROGRAM_SEPARABLE              = 0x8258,
    GL_ACTIVE_PROGRAM                 = 0x8259,
    GL_PROGRAM_PIPELINE_BINDING       = 0x825A,
    GL_MAX_VIEWPORTS                  = 0x825B,
    GL_VIEWPORT_SUBPIXEL_BITS         = 0x825C,
    GL_VIEWPORT_BOUNDS_RANGE          = 0x825D,
    GL_LAYER_PROVOKING_VERTEX         = 0x825E,
    GL_VIEWPORT_INDEX_PROVOKING_VERTEX = 0x825F,
    GL_UNDEFINED_VERTEX               = 0x8260
};

typedef void (* PFNGLRELEASESHADERCOMPILERPROC) (void);
typedef void (* PFNGLSHADERBINARYPROC) (GLsizei count, const GLuint *shaders, GLenum binaryformat, const void *binary, GLsizei length);
typedef void (* PFNGLGETSHADERPRECISIONFORMATPROC) (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
typedef void (* PFNGLDEPTHRANGEFPROC) (GLfloat n, GLfloat f);
typedef void (* PFNGLCLEARDEPTHFPROC) (GLfloat d);
typedef void (* PFNGLGETPROGRAMBINARYPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, void *binary);
typedef void (* PFNGLPROGRAMBINARYPROC) (GLuint program, GLenum binaryFormat, const void *binary, GLsizei length);
typedef void (* PFNGLPROGRAMPARAMETERIPROC) (GLuint program, GLenum pname, GLint value);
typedef void (* PFNGLUSEPROGRAMSTAGESPROC) (GLuint pipeline, GLbitfield stages, GLuint program);
typedef void (* PFNGLACTIVESHADERPROGRAMPROC) (GLuint pipeline, GLuint program);
typedef GLuint (* PFNGLCREATESHADERPROGRAMVPROC) (GLenum type, GLsizei count, const GLchar *const*strings);
typedef void (* PFNGLBINDPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void (* PFNGLDELETEPROGRAMPIPELINESPROC) (GLsizei n, const GLuint *pipelines);
typedef void (* PFNGLGENPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines);
typedef GLboolean (* PFNGLISPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void (* PFNGLGETPROGRAMPIPELINEIVPROC) (GLuint pipeline, GLenum pname, GLint *params);
typedef void (* PFNGLPROGRAMUNIFORM1IPROC) (GLuint program, GLint location, GLint v0);
typedef void (* PFNGLPROGRAMUNIFORM1IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM1FPROC) (GLuint program, GLint location, GLfloat v0);
typedef void (* PFNGLPROGRAMUNIFORM1FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM1DPROC) (GLuint program, GLint location, GLdouble v0);
typedef void (* PFNGLPROGRAMUNIFORM1DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM1UIPROC) (GLuint program, GLint location, GLuint v0);
typedef void (* PFNGLPROGRAMUNIFORM1UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM2IPROC) (GLuint program, GLint location, GLint v0, GLint v1);
typedef void (* PFNGLPROGRAMUNIFORM2IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM2FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1);
typedef void (* PFNGLPROGRAMUNIFORM2FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM2DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1);
typedef void (* PFNGLPROGRAMUNIFORM2DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM2UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1);
typedef void (* PFNGLPROGRAMUNIFORM2UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM3IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
typedef void (* PFNGLPROGRAMUNIFORM3IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM3FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void (* PFNGLPROGRAMUNIFORM3FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM3DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);
typedef void (* PFNGLPROGRAMUNIFORM3DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM3UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void (* PFNGLPROGRAMUNIFORM3UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM4IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void (* PFNGLPROGRAMUNIFORM4IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM4FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void (* PFNGLPROGRAMUNIFORM4FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM4DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);
typedef void (* PFNGLPROGRAMUNIFORM4DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM4UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void (* PFNGLPROGRAMUNIFORM4UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLVALIDATEPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void (* PFNGLGETPROGRAMPIPELINEINFOLOGPROC) (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (* PFNGLVERTEXATTRIBL1DPROC) (GLuint index, GLdouble x);
typedef void (* PFNGLVERTEXATTRIBL2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void (* PFNGLVERTEXATTRIBL3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLVERTEXATTRIBL4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLVERTEXATTRIBL1DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBL2DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBL3DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBL4DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBLPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void (* PFNGLGETVERTEXATTRIBLDVPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void (* PFNGLVIEWPORTARRAYVPROC) (GLuint first, GLsizei count, const GLfloat *v);
typedef void (* PFNGLVIEWPORTINDEXEDFPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);
typedef void (* PFNGLVIEWPORTINDEXEDFVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLSCISSORARRAYVPROC) (GLuint first, GLsizei count, const GLint *v);
typedef void (* PFNGLSCISSORINDEXEDPROC) (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);
typedef void (* PFNGLSCISSORINDEXEDVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLDEPTHRANGEARRAYVPROC) (GLuint first, GLsizei count, const GLdouble *v);
typedef void (* PFNGLDEPTHRANGEINDEXEDPROC) (GLuint index, GLdouble n, GLdouble f);
typedef void (* PFNGLGETFLOATI_VPROC) (GLenum target, GLuint index, GLfloat *data);
typedef void (* PFNGLGETDOUBLEI_VPROC) (GLenum target, GLuint index, GLdouble *data);
void glReleaseShaderCompiler (void);
void glShaderBinary (GLsizei count, const GLuint *shaders, GLenum binaryformat, const void *binary, GLsizei length);
void glGetShaderPrecisionFormat (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
void glDepthRangef (GLfloat n, GLfloat f);
void glClearDepthf (GLfloat d);
void glGetProgramBinary (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, void *binary);
void glProgramBinary (GLuint program, GLenum binaryFormat, const void *binary, GLsizei length);
void glProgramParameteri (GLuint program, GLenum pname, GLint value);
void glUseProgramStages (GLuint pipeline, GLbitfield stages, GLuint program);
void glActiveShaderProgram (GLuint pipeline, GLuint program);
GLuint glCreateShaderProgramv (GLenum type, GLsizei count, const GLchar *const*strings);
void glBindProgramPipeline (GLuint pipeline);
void glDeleteProgramPipelines (GLsizei n, const GLuint *pipelines);
void glGenProgramPipelines (GLsizei n, GLuint *pipelines);
GLboolean glIsProgramPipeline (GLuint pipeline);
void glGetProgramPipelineiv (GLuint pipeline, GLenum pname, GLint *params);
void glProgramUniform1i (GLuint program, GLint location, GLint v0);
void glProgramUniform1iv (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform1f (GLuint program, GLint location, GLfloat v0);
void glProgramUniform1fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform1d (GLuint program, GLint location, GLdouble v0);
void glProgramUniform1dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform1ui (GLuint program, GLint location, GLuint v0);
void glProgramUniform1uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniform2i (GLuint program, GLint location, GLint v0, GLint v1);
void glProgramUniform2iv (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform2f (GLuint program, GLint location, GLfloat v0, GLfloat v1);
void glProgramUniform2fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform2d (GLuint program, GLint location, GLdouble v0, GLdouble v1);
void glProgramUniform2dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform2ui (GLuint program, GLint location, GLuint v0, GLuint v1);
void glProgramUniform2uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniform3i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
void glProgramUniform3iv (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform3f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
void glProgramUniform3fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform3d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);
void glProgramUniform3dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform3ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
void glProgramUniform3uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniform4i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
void glProgramUniform4iv (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform4f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
void glProgramUniform4fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform4d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);
void glProgramUniform4dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform4ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
void glProgramUniform4uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniformMatrix2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix2x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix3x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix2x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix4x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix3x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix4x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix2x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix3x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix2x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix4x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix3x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix4x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glValidateProgramPipeline (GLuint pipeline);
void glGetProgramPipelineInfoLog (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
void glVertexAttribL1d (GLuint index, GLdouble x);
void glVertexAttribL2d (GLuint index, GLdouble x, GLdouble y);
void glVertexAttribL3d (GLuint index, GLdouble x, GLdouble y, GLdouble z);
void glVertexAttribL4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glVertexAttribL1dv (GLuint index, const GLdouble *v);
void glVertexAttribL2dv (GLuint index, const GLdouble *v);
void glVertexAttribL3dv (GLuint index, const GLdouble *v);
void glVertexAttribL4dv (GLuint index, const GLdouble *v);
void glVertexAttribLPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const void *pointer);
void glGetVertexAttribLdv (GLuint index, GLenum pname, GLdouble *params);
void glViewportArrayv (GLuint first, GLsizei count, const GLfloat *v);
void glViewportIndexedf (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);
void glViewportIndexedfv (GLuint index, const GLfloat *v);
void glScissorArrayv (GLuint first, GLsizei count, const GLint *v);
void glScissorIndexed (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);
void glScissorIndexedv (GLuint index, const GLint *v);
void glDepthRangeArrayv (GLuint first, GLsizei count, const GLdouble *v);
void glDepthRangeIndexed (GLuint index, GLdouble n, GLdouble f);
void glGetFloati_v (GLenum target, GLuint index, GLfloat *data);
void glGetDoublei_v (GLenum target, GLuint index, GLdouble *data);

enum { GL_VERSION_4_2 = 1 };
enum {
    GL_COPY_READ_BUFFER_BINDING       = 0x8F36,
    GL_COPY_WRITE_BUFFER_BINDING      = 0x8F37,
    GL_TRANSFORM_FEEDBACK_ACTIVE      = 0x8E24,
    GL_TRANSFORM_FEEDBACK_PAUSED      = 0x8E23,
    GL_UNPACK_COMPRESSED_BLOCK_WIDTH  = 0x9127,
    GL_UNPACK_COMPRESSED_BLOCK_HEIGHT = 0x9128,
    GL_UNPACK_COMPRESSED_BLOCK_DEPTH  = 0x9129,
    GL_UNPACK_COMPRESSED_BLOCK_SIZE   = 0x912A,
    GL_PACK_COMPRESSED_BLOCK_WIDTH    = 0x912B,
    GL_PACK_COMPRESSED_BLOCK_HEIGHT   = 0x912C,
    GL_PACK_COMPRESSED_BLOCK_DEPTH    = 0x912D,
    GL_PACK_COMPRESSED_BLOCK_SIZE     = 0x912E,
    GL_NUM_SAMPLE_COUNTS              = 0x9380,
    GL_MIN_MAP_BUFFER_ALIGNMENT       = 0x90BC,
    GL_ATOMIC_COUNTER_BUFFER          = 0x92C0,
    GL_ATOMIC_COUNTER_BUFFER_BINDING  = 0x92C1,
    GL_ATOMIC_COUNTER_BUFFER_START    = 0x92C2,
    GL_ATOMIC_COUNTER_BUFFER_SIZE     = 0x92C3,
    GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE = 0x92C4,
    GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS = 0x92C5,
    GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES = 0x92C6,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER = 0x92C7,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER = 0x92C8,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER = 0x92C9,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER = 0x92CA,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER = 0x92CB,
    GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS = 0x92CC,
    GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = 0x92CD,
    GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS = 0x92CE,
    GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS = 0x92CF,
    GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS = 0x92D0,
    GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS = 0x92D1,
    GL_MAX_VERTEX_ATOMIC_COUNTERS     = 0x92D2,
    GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS = 0x92D3,
    GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS = 0x92D4,
    GL_MAX_GEOMETRY_ATOMIC_COUNTERS   = 0x92D5,
    GL_MAX_FRAGMENT_ATOMIC_COUNTERS   = 0x92D6,
    GL_MAX_COMBINED_ATOMIC_COUNTERS   = 0x92D7,
    GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE = 0x92D8,
    GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS = 0x92DC,
    GL_ACTIVE_ATOMIC_COUNTER_BUFFERS  = 0x92D9,
    GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX = 0x92DA,
    GL_UNSIGNED_INT_ATOMIC_COUNTER    = 0x92DB,
    GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT = 0x00000001,
    GL_ELEMENT_ARRAY_BARRIER_BIT      = 0x00000002,
    GL_UNIFORM_BARRIER_BIT            = 0x00000004,
    GL_TEXTURE_FETCH_BARRIER_BIT      = 0x00000008,
    GL_SHADER_IMAGE_ACCESS_BARRIER_BIT = 0x00000020,
    GL_COMMAND_BARRIER_BIT            = 0x00000040,
    GL_PIXEL_BUFFER_BARRIER_BIT       = 0x00000080,
    GL_TEXTURE_UPDATE_BARRIER_BIT     = 0x00000100,
    GL_BUFFER_UPDATE_BARRIER_BIT      = 0x00000200,
    GL_FRAMEBUFFER_BARRIER_BIT        = 0x00000400,
    GL_TRANSFORM_FEEDBACK_BARRIER_BIT = 0x00000800,
    GL_ATOMIC_COUNTER_BARRIER_BIT     = 0x00001000,
    GL_ALL_BARRIER_BITS               = 0xFFFFFFFF,
    GL_MAX_IMAGE_UNITS                = 0x8F38,
    GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS = 0x8F39,
    GL_IMAGE_BINDING_NAME             = 0x8F3A,
    GL_IMAGE_BINDING_LEVEL            = 0x8F3B,
    GL_IMAGE_BINDING_LAYERED          = 0x8F3C,
    GL_IMAGE_BINDING_LAYER            = 0x8F3D,
    GL_IMAGE_BINDING_ACCESS           = 0x8F3E,
    GL_IMAGE_1D                       = 0x904C,
    GL_IMAGE_2D                       = 0x904D,
    GL_IMAGE_3D                       = 0x904E,
    GL_IMAGE_2D_RECT                  = 0x904F,
    GL_IMAGE_CUBE                     = 0x9050,
    GL_IMAGE_BUFFER                   = 0x9051,
    GL_IMAGE_1D_ARRAY                 = 0x9052,
    GL_IMAGE_2D_ARRAY                 = 0x9053,
    GL_IMAGE_CUBE_MAP_ARRAY           = 0x9054,
    GL_IMAGE_2D_MULTISAMPLE           = 0x9055,
    GL_IMAGE_2D_MULTISAMPLE_ARRAY     = 0x9056,
    GL_INT_IMAGE_1D                   = 0x9057,
    GL_INT_IMAGE_2D                   = 0x9058,
    GL_INT_IMAGE_3D                   = 0x9059,
    GL_INT_IMAGE_2D_RECT              = 0x905A,
    GL_INT_IMAGE_CUBE                 = 0x905B,
    GL_INT_IMAGE_BUFFER               = 0x905C,
    GL_INT_IMAGE_1D_ARRAY             = 0x905D,
    GL_INT_IMAGE_2D_ARRAY             = 0x905E,
    GL_INT_IMAGE_CUBE_MAP_ARRAY       = 0x905F,
    GL_INT_IMAGE_2D_MULTISAMPLE       = 0x9060,
    GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY = 0x9061,
    GL_UNSIGNED_INT_IMAGE_1D          = 0x9062,
    GL_UNSIGNED_INT_IMAGE_2D          = 0x9063,
    GL_UNSIGNED_INT_IMAGE_3D          = 0x9064,
    GL_UNSIGNED_INT_IMAGE_2D_RECT     = 0x9065,
    GL_UNSIGNED_INT_IMAGE_CUBE        = 0x9066,
    GL_UNSIGNED_INT_IMAGE_BUFFER      = 0x9067,
    GL_UNSIGNED_INT_IMAGE_1D_ARRAY    = 0x9068,
    GL_UNSIGNED_INT_IMAGE_2D_ARRAY    = 0x9069,
    GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY = 0x906A,
    GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE = 0x906B,
    GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = 0x906C,
    GL_MAX_IMAGE_SAMPLES              = 0x906D,
    GL_IMAGE_BINDING_FORMAT           = 0x906E,
    GL_IMAGE_FORMAT_COMPATIBILITY_TYPE = 0x90C7,
    GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE = 0x90C8,
    GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS = 0x90C9,
    GL_MAX_VERTEX_IMAGE_UNIFORMS      = 0x90CA,
    GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS = 0x90CB,
    GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS = 0x90CC,
    GL_MAX_GEOMETRY_IMAGE_UNIFORMS    = 0x90CD,
    GL_MAX_FRAGMENT_IMAGE_UNIFORMS    = 0x90CE,
    GL_MAX_COMBINED_IMAGE_UNIFORMS    = 0x90CF,
    GL_COMPRESSED_RGBA_BPTC_UNORM     = 0x8E8C,
    GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM = 0x8E8D,
    GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT = 0x8E8E,
    GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT = 0x8E8F,
    GL_TEXTURE_IMMUTABLE_FORMAT       = 0x912F
};
typedef void (* PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance);
typedef void (* PFNGLGETINTERNALFORMATIVPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint *params);
typedef void (* PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC) (GLuint program, GLuint bufferIndex, GLenum pname, GLint *params);
typedef void (* PFNGLBINDIMAGETEXTUREPROC) (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);
typedef void (* PFNGLMEMORYBARRIERPROC) (GLbitfield barriers);
typedef void (* PFNGLTEXSTORAGE1DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void (* PFNGLTEXSTORAGE2DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXSTORAGE3DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC) (GLenum mode, GLuint id, GLsizei instancecount);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC) (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount);
void glDrawArraysInstancedBaseInstance (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance);
void glDrawElementsInstancedBaseInstance (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance);
void glDrawElementsInstancedBaseVertexBaseInstance (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance);
void glGetInternalformativ (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint *params);
void glGetActiveAtomicCounterBufferiv (GLuint program, GLuint bufferIndex, GLenum pname, GLint *params);
void glBindImageTexture (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);
void glMemoryBarrier (GLbitfield barriers);
void glTexStorage1D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
void glTexStorage2D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
void glTexStorage3D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
void glDrawTransformFeedbackInstanced (GLenum mode, GLuint id, GLsizei instancecount);
void glDrawTransformFeedbackStreamInstanced (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount);

enum { GL_VERSION_4_3 = 1 };
typedef void ( *GLDEBUGPROC)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);
enum {   
    GL_NUM_SHADING_LANGUAGE_VERSIONS  = 0x82E9,
    GL_VERTEX_ATTRIB_ARRAY_LONG       = 0x874E,
    GL_COMPRESSED_RGB8_ETC2           = 0x9274,
    GL_COMPRESSED_SRGB8_ETC2          = 0x9275,
    GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 0x9276,
    GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 0x9277,
    GL_COMPRESSED_RGBA8_ETC2_EAC      = 0x9278,
    GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = 0x9279,
    GL_COMPRESSED_R11_EAC             = 0x9270,
    GL_COMPRESSED_SIGNED_R11_EAC      = 0x9271,
    GL_COMPRESSED_RG11_EAC            = 0x9272,
    GL_COMPRESSED_SIGNED_RG11_EAC     = 0x9273,
    GL_PRIMITIVE_RESTART_FIXED_INDEX  = 0x8D69,
    GL_ANY_SAMPLES_PASSED_CONSERVATIVE = 0x8D6A,
    GL_MAX_ELEMENT_INDEX              = 0x8D6B,
    GL_COMPUTE_SHADER                 = 0x91B9,
    GL_MAX_COMPUTE_UNIFORM_BLOCKS     = 0x91BB,
    GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS = 0x91BC,
    GL_MAX_COMPUTE_IMAGE_UNIFORMS     = 0x91BD,
    GL_MAX_COMPUTE_SHARED_MEMORY_SIZE = 0x8262,
    GL_MAX_COMPUTE_UNIFORM_COMPONENTS = 0x8263,
    GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS = 0x8264,
    GL_MAX_COMPUTE_ATOMIC_COUNTERS    = 0x8265,
    GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = 0x8266,
    GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS = 0x90EB,
    GL_MAX_COMPUTE_WORK_GROUP_COUNT   = 0x91BE,
    GL_MAX_COMPUTE_WORK_GROUP_SIZE    = 0x91BF,
    GL_COMPUTE_WORK_GROUP_SIZE        = 0x8267,
    GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER = 0x90EC,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER = 0x90ED,
    GL_DISPATCH_INDIRECT_BUFFER       = 0x90EE,
    GL_DISPATCH_INDIRECT_BUFFER_BINDING = 0x90EF,
    GL_COMPUTE_SHADER_BIT             = 0x00000020,
    GL_DEBUG_OUTPUT_SYNCHRONOUS       = 0x8242,
    GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH = 0x8243,
    GL_DEBUG_CALLBACK_FUNCTION        = 0x8244,
    GL_DEBUG_CALLBACK_USER_PARAM      = 0x8245,
    GL_DEBUG_SOURCE_API               = 0x8246,
    GL_DEBUG_SOURCE_WINDOW_SYSTEM     = 0x8247,
    GL_DEBUG_SOURCE_SHADER_COMPILER   = 0x8248,
    GL_DEBUG_SOURCE_THIRD_PARTY       = 0x8249,
    GL_DEBUG_SOURCE_APPLICATION       = 0x824A,
    GL_DEBUG_SOURCE_OTHER             = 0x824B,
    GL_DEBUG_TYPE_ERROR               = 0x824C,
    GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR = 0x824D,
    GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR  = 0x824E,
    GL_DEBUG_TYPE_PORTABILITY         = 0x824F,
    GL_DEBUG_TYPE_PERFORMANCE         = 0x8250,
    GL_DEBUG_TYPE_OTHER               = 0x8251,
    GL_MAX_DEBUG_MESSAGE_LENGTH       = 0x9143,
    GL_MAX_DEBUG_LOGGED_MESSAGES      = 0x9144,
    GL_DEBUG_LOGGED_MESSAGES          = 0x9145,
    GL_DEBUG_SEVERITY_HIGH            = 0x9146,
    GL_DEBUG_SEVERITY_MEDIUM          = 0x9147,
    GL_DEBUG_SEVERITY_LOW             = 0x9148,
    GL_DEBUG_TYPE_MARKER              = 0x8268,
    GL_DEBUG_TYPE_PUSH_GROUP          = 0x8269,
    GL_DEBUG_TYPE_POP_GROUP           = 0x826A,
    GL_DEBUG_SEVERITY_NOTIFICATION    = 0x826B,
    GL_MAX_DEBUG_GROUP_STACK_DEPTH    = 0x826C,
    GL_DEBUG_GROUP_STACK_DEPTH        = 0x826D,
    GL_BUFFER                         = 0x82E0,
    GL_SHADER                         = 0x82E1,
    GL_PROGRAM                        = 0x82E2,
    GL_QUERY                          = 0x82E3,
    GL_PROGRAM_PIPELINE               = 0x82E4,
    GL_SAMPLER                        = 0x82E6,
    GL_MAX_LABEL_LENGTH               = 0x82E8,
    GL_DEBUG_OUTPUT                   = 0x92E0,
    GL_CONTEXT_FLAG_DEBUG_BIT         = 0x00000002,
    GL_MAX_UNIFORM_LOCATIONS          = 0x826E,
    GL_FRAMEBUFFER_DEFAULT_WIDTH      = 0x9310,
    GL_FRAMEBUFFER_DEFAULT_HEIGHT     = 0x9311,
    GL_FRAMEBUFFER_DEFAULT_LAYERS     = 0x9312,
    GL_FRAMEBUFFER_DEFAULT_SAMPLES    = 0x9313,
    GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS = 0x9314,
    GL_MAX_FRAMEBUFFER_WIDTH          = 0x9315,
    GL_MAX_FRAMEBUFFER_HEIGHT         = 0x9316,
    GL_MAX_FRAMEBUFFER_LAYERS         = 0x9317,
    GL_MAX_FRAMEBUFFER_SAMPLES        = 0x9318,
    GL_INTERNALFORMAT_SUPPORTED       = 0x826F,
    GL_INTERNALFORMAT_PREFERRED       = 0x8270,
    GL_INTERNALFORMAT_RED_SIZE        = 0x8271,
    GL_INTERNALFORMAT_GREEN_SIZE      = 0x8272,
    GL_INTERNALFORMAT_BLUE_SIZE       = 0x8273,
    GL_INTERNALFORMAT_ALPHA_SIZE      = 0x8274,
    GL_INTERNALFORMAT_DEPTH_SIZE      = 0x8275,
    GL_INTERNALFORMAT_STENCIL_SIZE    = 0x8276,
    GL_INTERNALFORMAT_SHARED_SIZE     = 0x8277,
    GL_INTERNALFORMAT_RED_TYPE        = 0x8278,
    GL_INTERNALFORMAT_GREEN_TYPE      = 0x8279,
    GL_INTERNALFORMAT_BLUE_TYPE       = 0x827A,
    GL_INTERNALFORMAT_ALPHA_TYPE      = 0x827B,
    GL_INTERNALFORMAT_DEPTH_TYPE      = 0x827C,
    GL_INTERNALFORMAT_STENCIL_TYPE    = 0x827D,
    GL_MAX_WIDTH                      = 0x827E,
    GL_MAX_HEIGHT                     = 0x827F,
    GL_MAX_DEPTH                      = 0x8280,
    GL_MAX_LAYERS                     = 0x8281,
    GL_MAX_COMBINED_DIMENSIONS        = 0x8282,
    GL_COLOR_COMPONENTS               = 0x8283,
    GL_DEPTH_COMPONENTS               = 0x8284,
    GL_STENCIL_COMPONENTS             = 0x8285,
    GL_COLOR_RENDERABLE               = 0x8286,
    GL_DEPTH_RENDERABLE               = 0x8287,
    GL_STENCIL_RENDERABLE             = 0x8288,
    GL_FRAMEBUFFER_RENDERABLE         = 0x8289,
    GL_FRAMEBUFFER_RENDERABLE_LAYERED = 0x828A,
    GL_FRAMEBUFFER_BLEND              = 0x828B,
    GL_READ_PIXELS                    = 0x828C,
    GL_READ_PIXELS_FORMAT             = 0x828D,
    GL_READ_PIXELS_TYPE               = 0x828E,
    GL_TEXTURE_IMAGE_FORMAT           = 0x828F,
    GL_TEXTURE_IMAGE_TYPE             = 0x8290,
    GL_GET_TEXTURE_IMAGE_FORMAT       = 0x8291,
    GL_GET_TEXTURE_IMAGE_TYPE         = 0x8292,
    GL_MIPMAP                         = 0x8293,
    GL_MANUAL_GENERATE_MIPMAP         = 0x8294,
    GL_AUTO_GENERATE_MIPMAP           = 0x8295,
    GL_COLOR_ENCODING                 = 0x8296,
    GL_SRGB_READ                      = 0x8297,
    GL_SRGB_WRITE                     = 0x8298,
    GL_FILTER                         = 0x829A,
    GL_VERTEX_TEXTURE                 = 0x829B,
    GL_TESS_CONTROL_TEXTURE           = 0x829C,
    GL_TESS_EVALUATION_TEXTURE        = 0x829D,
    GL_GEOMETRY_TEXTURE               = 0x829E,
    GL_FRAGMENT_TEXTURE               = 0x829F,
    GL_COMPUTE_TEXTURE                = 0x82A0,
    GL_TEXTURE_SHADOW                 = 0x82A1,
    GL_TEXTURE_GATHER                 = 0x82A2,
    GL_TEXTURE_GATHER_SHADOW          = 0x82A3,
    GL_SHADER_IMAGE_LOAD              = 0x82A4,
    GL_SHADER_IMAGE_STORE             = 0x82A5,
    GL_SHADER_IMAGE_ATOMIC            = 0x82A6,
    GL_IMAGE_TEXEL_SIZE               = 0x82A7,
    GL_IMAGE_COMPATIBILITY_CLASS      = 0x82A8,
    GL_IMAGE_PIXEL_FORMAT             = 0x82A9,
    GL_IMAGE_PIXEL_TYPE               = 0x82AA,
    GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST = 0x82AC,
    GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST = 0x82AD,
    GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE = 0x82AE,
    GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE = 0x82AF,
    GL_TEXTURE_COMPRESSED_BLOCK_WIDTH = 0x82B1,
    GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT = 0x82B2,
    GL_TEXTURE_COMPRESSED_BLOCK_SIZE  = 0x82B3,
    GL_CLEAR_BUFFER                   = 0x82B4,
    GL_TEXTURE_VIEW                   = 0x82B5,
    GL_VIEW_COMPATIBILITY_CLASS       = 0x82B6,
    GL_FULL_SUPPORT                   = 0x82B7,
    GL_CAVEAT_SUPPORT                 = 0x82B8,
    GL_IMAGE_CLASS_4_X_32             = 0x82B9,
    GL_IMAGE_CLASS_2_X_32             = 0x82BA,
    GL_IMAGE_CLASS_1_X_32             = 0x82BB,
    GL_IMAGE_CLASS_4_X_16             = 0x82BC,
    GL_IMAGE_CLASS_2_X_16             = 0x82BD,
    GL_IMAGE_CLASS_1_X_16             = 0x82BE,
    GL_IMAGE_CLASS_4_X_8              = 0x82BF,
    GL_IMAGE_CLASS_2_X_8              = 0x82C0,
    GL_IMAGE_CLASS_1_X_8              = 0x82C1,
    GL_IMAGE_CLASS_11_11_10           = 0x82C2,
    GL_IMAGE_CLASS_10_10_10_2         = 0x82C3,
    GL_VIEW_CLASS_128_BITS            = 0x82C4,
    GL_VIEW_CLASS_96_BITS             = 0x82C5,
    GL_VIEW_CLASS_64_BITS             = 0x82C6,
    GL_VIEW_CLASS_48_BITS             = 0x82C7,
    GL_VIEW_CLASS_32_BITS             = 0x82C8,
    GL_VIEW_CLASS_24_BITS             = 0x82C9,
    GL_VIEW_CLASS_16_BITS             = 0x82CA,
    GL_VIEW_CLASS_8_BITS              = 0x82CB,
    GL_VIEW_CLASS_S3TC_DXT1_RGB       = 0x82CC,
    GL_VIEW_CLASS_S3TC_DXT1_RGBA      = 0x82CD,
    GL_VIEW_CLASS_S3TC_DXT3_RGBA      = 0x82CE,
    GL_VIEW_CLASS_S3TC_DXT5_RGBA      = 0x82CF,
    GL_VIEW_CLASS_RGTC1_RED           = 0x82D0,
    GL_VIEW_CLASS_RGTC2_RG            = 0x82D1,
    GL_VIEW_CLASS_BPTC_UNORM          = 0x82D2,
    GL_VIEW_CLASS_BPTC_FLOAT          = 0x82D3,
    GL_UNIFORM                        = 0x92E1,
    GL_UNIFORM_BLOCK                  = 0x92E2,
    GL_PROGRAM_INPUT                  = 0x92E3,
    GL_PROGRAM_OUTPUT                 = 0x92E4,
    GL_BUFFER_VARIABLE                = 0x92E5,
    GL_SHADER_STORAGE_BLOCK           = 0x92E6,
    GL_VERTEX_SUBROUTINE              = 0x92E8,
    GL_TESS_CONTROL_SUBROUTINE        = 0x92E9,
    GL_TESS_EVALUATION_SUBROUTINE     = 0x92EA,
    GL_GEOMETRY_SUBROUTINE            = 0x92EB,
    GL_FRAGMENT_SUBROUTINE            = 0x92EC,
    GL_COMPUTE_SUBROUTINE             = 0x92ED,
    GL_VERTEX_SUBROUTINE_UNIFORM      = 0x92EE,
    GL_TESS_CONTROL_SUBROUTINE_UNIFORM = 0x92EF,
    GL_TESS_EVALUATION_SUBROUTINE_UNIFORM = 0x92F0,
    GL_GEOMETRY_SUBROUTINE_UNIFORM    = 0x92F1,
    GL_FRAGMENT_SUBROUTINE_UNIFORM    = 0x92F2,
    GL_COMPUTE_SUBROUTINE_UNIFORM     = 0x92F3,
    GL_TRANSFORM_FEEDBACK_VARYING     = 0x92F4,
    GL_ACTIVE_RESOURCES               = 0x92F5,
    GL_MAX_NAME_LENGTH                = 0x92F6,
    GL_MAX_NUM_ACTIVE_VARIABLES       = 0x92F7,
    GL_MAX_NUM_COMPATIBLE_SUBROUTINES = 0x92F8,
    GL_NAME_LENGTH                    = 0x92F9,
    GL_TYPE                           = 0x92FA,
    GL_ARRAY_SIZE                     = 0x92FB,
    GL_OFFSET                         = 0x92FC,
    GL_BLOCK_INDEX                    = 0x92FD,
    GL_ARRAY_STRIDE                   = 0x92FE,
    GL_MATRIX_STRIDE                  = 0x92FF,
    GL_IS_ROW_MAJOR                   = 0x9300,
    GL_ATOMIC_COUNTER_BUFFER_INDEX    = 0x9301,
    GL_BUFFER_BINDING                 = 0x9302,
    GL_BUFFER_DATA_SIZE               = 0x9303,
    GL_NUM_ACTIVE_VARIABLES           = 0x9304,
    GL_ACTIVE_VARIABLES               = 0x9305,
    GL_REFERENCED_BY_VERTEX_SHADER    = 0x9306,
    GL_REFERENCED_BY_TESS_CONTROL_SHADER = 0x9307,
    GL_REFERENCED_BY_TESS_EVALUATION_SHADER = 0x9308,
    GL_REFERENCED_BY_GEOMETRY_SHADER  = 0x9309,
    GL_REFERENCED_BY_FRAGMENT_SHADER  = 0x930A,
    GL_REFERENCED_BY_COMPUTE_SHADER   = 0x930B,
    GL_TOP_LEVEL_ARRAY_SIZE           = 0x930C,
    GL_TOP_LEVEL_ARRAY_STRIDE         = 0x930D,
    GL_LOCATION                       = 0x930E,
    GL_LOCATION_INDEX                 = 0x930F,
    GL_IS_PER_PATCH                   = 0x92E7,
    GL_SHADER_STORAGE_BUFFER          = 0x90D2,
    GL_SHADER_STORAGE_BUFFER_BINDING  = 0x90D3,
    GL_SHADER_STORAGE_BUFFER_START    = 0x90D4,
    GL_SHADER_STORAGE_BUFFER_SIZE     = 0x90D5,
    GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS = 0x90D6,
    GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS = 0x90D7,
    GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS = 0x90D8,
    GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS = 0x90D9,
    GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS = 0x90DA,
    GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS = 0x90DB,
    GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS = 0x90DC,
    GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS = 0x90DD,
    GL_MAX_SHADER_STORAGE_BLOCK_SIZE  = 0x90DE,
    GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT = 0x90DF,
    GL_SHADER_STORAGE_BARRIER_BIT     = 0x00002000,
    GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES = 0x8F39,
    GL_DEPTH_STENCIL_TEXTURE_MODE     = 0x90EA,
    GL_TEXTURE_BUFFER_OFFSET          = 0x919D,
    GL_TEXTURE_BUFFER_SIZE            = 0x919E,
    GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT = 0x919F,
    GL_TEXTURE_VIEW_MIN_LEVEL         = 0x82DB,
    GL_TEXTURE_VIEW_NUM_LEVELS        = 0x82DC,
    GL_TEXTURE_VIEW_MIN_LAYER         = 0x82DD,
    GL_TEXTURE_VIEW_NUM_LAYERS        = 0x82DE,
    GL_TEXTURE_IMMUTABLE_LEVELS       = 0x82DF,
    GL_VERTEX_ATTRIB_BINDING          = 0x82D4,
    GL_VERTEX_ATTRIB_RELATIVE_OFFSET  = 0x82D5,
    GL_VERTEX_BINDING_DIVISOR         = 0x82D6,
    GL_VERTEX_BINDING_OFFSET          = 0x82D7,
    GL_VERTEX_BINDING_STRIDE          = 0x82D8,
    GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET = 0x82D9,
    GL_MAX_VERTEX_ATTRIB_BINDINGS     = 0x82DA,
    GL_VERTEX_BINDING_BUFFER          = 0x8F4F
};
typedef void (* PFNGLCLEARBUFFERDATAPROC) (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARBUFFERSUBDATAPROC) (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLDISPATCHCOMPUTEPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);
typedef void (* PFNGLDISPATCHCOMPUTEINDIRECTPROC) (GLintptr indirect);
typedef void (* PFNGLCOPYIMAGESUBDATAPROC) (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);
typedef void (* PFNGLFRAMEBUFFERPARAMETERIPROC) (GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLGETFRAMEBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETINTERNALFORMATI64VPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint64 *params);
typedef void (* PFNGLINVALIDATETEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLINVALIDATETEXIMAGEPROC) (GLuint texture, GLint level);
typedef void (* PFNGLINVALIDATEBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void (* PFNGLINVALIDATEBUFFERDATAPROC) (GLuint buffer);
typedef void (* PFNGLINVALIDATEFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments);
typedef void (* PFNGLINVALIDATESUBFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLMULTIDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride);
typedef void (* PFNGLMULTIDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride);
typedef void (* PFNGLGETPROGRAMINTERFACEIVPROC) (GLuint program, GLenum programInterface, GLenum pname, GLint *params);
typedef GLuint (* PFNGLGETPROGRAMRESOURCEINDEXPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef void (* PFNGLGETPROGRAMRESOURCENAMEPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void (* PFNGLGETPROGRAMRESOURCEIVPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLint *params);
typedef GLint (* PFNGLGETPROGRAMRESOURCELOCATIONPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef GLint (* PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef void (* PFNGLSHADERSTORAGEBLOCKBINDINGPROC) (GLuint program, GLuint storageBlockIndex, GLuint storageBlockBinding);
typedef void (* PFNGLTEXBUFFERRANGEPROC) (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLTEXSTORAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXSTORAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXTUREVIEWPROC) (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers);
typedef void (* PFNGLBINDVERTEXBUFFERPROC) (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void (* PFNGLVERTEXATTRIBFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void (* PFNGLVERTEXATTRIBIFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXATTRIBLFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXATTRIBBINDINGPROC) (GLuint attribindex, GLuint bindingindex);
typedef void (* PFNGLVERTEXBINDINGDIVISORPROC) (GLuint bindingindex, GLuint divisor);
typedef void (* PFNGLDEBUGMESSAGECONTROLPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void (* PFNGLDEBUGMESSAGEINSERTPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
typedef void (* PFNGLDEBUGMESSAGECALLBACKPROC) (GLDEBUGPROC callback, const void *userParam);
typedef GLuint (* PFNGLGETDEBUGMESSAGELOGPROC) (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
typedef void (* PFNGLPUSHDEBUGGROUPPROC) (GLenum source, GLuint id, GLsizei length, const GLchar *message);
typedef void (* PFNGLPOPDEBUGGROUPPROC) (void);
typedef void (* PFNGLOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei length, const GLchar *label);
typedef void (* PFNGLGETOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label);
typedef void (* PFNGLOBJECTPTRLABELPROC) (const void *ptr, GLsizei length, const GLchar *label);
typedef void (* PFNGLGETOBJECTPTRLABELPROC) (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label);

void glClearBufferData (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data);
void glClearBufferSubData (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
void glDispatchCompute (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);
void glDispatchComputeIndirect (GLintptr indirect);
void glCopyImageSubData (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);
void glFramebufferParameteri (GLenum target, GLenum pname, GLint param);
void glGetFramebufferParameteriv (GLenum target, GLenum pname, GLint *params);
void glGetInternalformati64v (GLenum target, GLenum internalformat, GLenum pname, GLsizei count, GLint64 *params);
void glInvalidateTexSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth);
void glInvalidateTexImage (GLuint texture, GLint level);
void glInvalidateBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr length);
void glInvalidateBufferData (GLuint buffer);
void glInvalidateFramebuffer (GLenum target, GLsizei numAttachments, const GLenum *attachments);
void glInvalidateSubFramebuffer (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
void glMultiDrawArraysIndirect (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride);
void glMultiDrawElementsIndirect (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride);
void glGetProgramInterfaceiv (GLuint program, GLenum programInterface, GLenum pname, GLint *params);
GLuint glGetProgramResourceIndex (GLuint program, GLenum programInterface, const GLchar *name);
void glGetProgramResourceName (GLuint program, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
void glGetProgramResourceiv (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLint *params);
GLint glGetProgramResourceLocation (GLuint program, GLenum programInterface, const GLchar *name);
GLint glGetProgramResourceLocationIndex (GLuint program, GLenum programInterface, const GLchar *name);
void glShaderStorageBlockBinding (GLuint program, GLuint storageBlockIndex, GLuint storageBlockBinding);
void glTexBufferRange (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
void glTexStorage2DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
void glTexStorage3DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
void glTextureView (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers);
void glBindVertexBuffer (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
void glVertexAttribFormat (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
void glVertexAttribIFormat (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
void glVertexAttribLFormat (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
void glVertexAttribBinding (GLuint attribindex, GLuint bindingindex);
void glVertexBindingDivisor (GLuint bindingindex, GLuint divisor);
void glDebugMessageControl (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
void glDebugMessageInsert (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
void glDebugMessageCallback (GLDEBUGPROC callback, const void *userParam);
GLuint glGetDebugMessageLog (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
void glPushDebugGroup (GLenum source, GLuint id, GLsizei length, const GLchar *message);
void glPopDebugGroup (void);
void glObjectLabel (GLenum identifier, GLuint name, GLsizei length, const GLchar *label);
void glGetObjectLabel (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label);
void glObjectPtrLabel (const void *ptr, GLsizei length, const GLchar *label);
void glGetObjectPtrLabel (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label);

enum { GL_VERSION_4_4 = 1 };
enum {
    GL_MAX_VERTEX_ATTRIB_STRIDE       = 0x82E5,
    GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED = 0x8221,
    GL_TEXTURE_BUFFER_BINDING         = 0x8C2A,
    GL_MAP_PERSISTENT_BIT             = 0x0040,
    GL_MAP_COHERENT_BIT               = 0x0080,
    GL_DYNAMIC_STORAGE_BIT            = 0x0100,
    GL_CLIENT_STORAGE_BIT             = 0x0200,
    GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT = 0x00004000,
    GL_BUFFER_IMMUTABLE_STORAGE       = 0x821F,
    GL_BUFFER_STORAGE_FLAGS           = 0x8220,
    GL_CLEAR_TEXTURE                  = 0x9365,
    GL_LOCATION_COMPONENT             = 0x934A,
    GL_TRANSFORM_FEEDBACK_BUFFER_INDEX = 0x934B,
    GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE = 0x934C,
    GL_QUERY_BUFFER                   = 0x9192,
    GL_QUERY_BUFFER_BARRIER_BIT       = 0x00008000,
    GL_QUERY_BUFFER_BINDING           = 0x9193,
    GL_QUERY_RESULT_NO_WAIT           = 0x9194,
    GL_MIRROR_CLAMP_TO_EDGE           = 0x8743
};
typedef void (* PFNGLBUFFERSTORAGEPROC) (GLenum target, GLsizeiptr size, const void *data, GLbitfield flags);
typedef void (* PFNGLCLEARTEXIMAGEPROC) (GLuint texture, GLint level, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARTEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLBINDBUFFERSBASEPROC) (GLenum target, GLuint first, GLsizei count, const GLuint *buffers);
typedef void (* PFNGLBINDBUFFERSRANGEPROC) (GLenum target, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizeiptr *sizes);
typedef void (* PFNGLBINDTEXTURESPROC) (GLuint first, GLsizei count, const GLuint *textures);
typedef void (* PFNGLBINDSAMPLERSPROC) (GLuint first, GLsizei count, const GLuint *samplers);
typedef void (* PFNGLBINDIMAGETEXTURESPROC) (GLuint first, GLsizei count, const GLuint *textures);
typedef void (* PFNGLBINDVERTEXBUFFERSPROC) (GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);

void glBufferStorage (GLenum target, GLsizeiptr size, const void *data, GLbitfield flags);
void glClearTexImage (GLuint texture, GLint level, GLenum format, GLenum type, const void *data);
void glClearTexSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *data);
void glBindBuffersBase (GLenum target, GLuint first, GLsizei count, const GLuint *buffers);
void glBindBuffersRange (GLenum target, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizeiptr *sizes);
void glBindTextures (GLuint first, GLsizei count, const GLuint *textures);
void glBindSamplers (GLuint first, GLsizei count, const GLuint *samplers);
void glBindImageTextures (GLuint first, GLsizei count, const GLuint *textures);
void glBindVertexBuffers (GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);

enum { GL_VERSION_4_5 = 1 };
enum {
    GL_CONTEXT_LOST                   = 0x0507,
    GL_NEGATIVE_ONE_TO_ONE            = 0x935E,
    GL_ZERO_TO_ONE                    = 0x935F,
    GL_CLIP_ORIGIN                    = 0x935C,
    GL_CLIP_DEPTH_MODE                = 0x935D,
    GL_QUERY_WAIT_INVERTED            = 0x8E17,
    GL_QUERY_NO_WAIT_INVERTED         = 0x8E18,
    GL_QUERY_BY_REGION_WAIT_INVERTED  = 0x8E19,
    GL_QUERY_BY_REGION_NO_WAIT_INVERTED = 0x8E1A,
    GL_MAX_CULL_DISTANCES             = 0x82F9,
    GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES = 0x82FA,
    GL_TEXTURE_TARGET                 = 0x1006,
    GL_QUERY_TARGET                   = 0x82EA,
    GL_GUILTY_CONTEXT_RESET           = 0x8253,
    GL_INNOCENT_CONTEXT_RESET         = 0x8254,
    GL_UNKNOWN_CONTEXT_RESET          = 0x8255,
    GL_RESET_NOTIFICATION_STRATEGY    = 0x8256,
    GL_LOSE_CONTEXT_ON_RESET          = 0x8252,
    GL_NO_RESET_NOTIFICATION          = 0x8261,
    GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT = 0x00000004,
    GL_CONTEXT_RELEASE_BEHAVIOR       = 0x82FB,
    GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = 0x82FC
};
typedef void (* PFNGLCLIPCONTROLPROC) (GLenum origin, GLenum depth);
typedef void (* PFNGLCREATETRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef void (* PFNGLTRANSFORMFEEDBACKBUFFERBASEPROC) (GLuint xfb, GLuint index, GLuint buffer);
typedef void (* PFNGLTRANSFORMFEEDBACKBUFFERRANGEPROC) (GLuint xfb, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLGETTRANSFORMFEEDBACKIVPROC) (GLuint xfb, GLenum pname, GLint *param);
typedef void (* PFNGLGETTRANSFORMFEEDBACKI_VPROC) (GLuint xfb, GLenum pname, GLuint index, GLint *param);
typedef void (* PFNGLGETTRANSFORMFEEDBACKI64_VPROC) (GLuint xfb, GLenum pname, GLuint index, GLint64 *param);
typedef void (* PFNGLCREATEBUFFERSPROC) (GLsizei n, GLuint *buffers);
typedef void (* PFNGLNAMEDBUFFERSTORAGEPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);
typedef void (* PFNGLNAMEDBUFFERDATAPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);
typedef void (* PFNGLNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
typedef void (* PFNGLCOPYNAMEDBUFFERSUBDATAPROC) (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void (* PFNGLCLEARNAMEDBUFFERDATAPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void *(* PFNGLMAPNAMEDBUFFERPROC) (GLuint buffer, GLenum access);
typedef void *(* PFNGLMAPNAMEDBUFFERRANGEPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef GLboolean (* PFNGLUNMAPNAMEDBUFFERPROC) (GLuint buffer);
typedef void (* PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void (* PFNGLGETNAMEDBUFFERPARAMETERIVPROC) (GLuint buffer, GLenum pname, GLint *params);
typedef void (* PFNGLGETNAMEDBUFFERPARAMETERI64VPROC) (GLuint buffer, GLenum pname, GLint64 *params);
typedef void (* PFNGLGETNAMEDBUFFERPOINTERVPROC) (GLuint buffer, GLenum pname, void **params);
typedef void (* PFNGLGETNAMEDBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);
typedef void (* PFNGLCREATEFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers);
typedef void (* PFNGLNAMEDFRAMEBUFFERRENDERBUFFERPROC) (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void (* PFNGLNAMEDFRAMEBUFFERPARAMETERIPROC) (GLuint framebuffer, GLenum pname, GLint param);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTUREPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTURELAYERPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void (* PFNGLNAMEDFRAMEBUFFERDRAWBUFFERPROC) (GLuint framebuffer, GLenum buf);
typedef void (* PFNGLNAMEDFRAMEBUFFERDRAWBUFFERSPROC) (GLuint framebuffer, GLsizei n, const GLenum *bufs);
typedef void (* PFNGLNAMEDFRAMEBUFFERREADBUFFERPROC) (GLuint framebuffer, GLenum src);
typedef void (* PFNGLINVALIDATENAMEDFRAMEBUFFERDATAPROC) (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments);
typedef void (* PFNGLINVALIDATENAMEDFRAMEBUFFERSUBDATAPROC) (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLCLEARNAMEDFRAMEBUFFERIVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLint *value);
typedef void (* PFNGLCLEARNAMEDFRAMEBUFFERUIVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLuint *value);
typedef void (* PFNGLCLEARNAMEDFRAMEBUFFERFVPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLfloat *value);
typedef void (* PFNGLCLEARNAMEDFRAMEBUFFERFIPROC) (GLuint framebuffer, GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
typedef void (* PFNGLBLITNAMEDFRAMEBUFFERPROC) (GLuint readFramebuffer, GLuint drawFramebuffer, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef GLenum (* PFNGLCHECKNAMEDFRAMEBUFFERSTATUSPROC) (GLuint framebuffer, GLenum target);
typedef void (* PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVPROC) (GLuint framebuffer, GLenum pname, GLint *param);
typedef void (* PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);
typedef void (* PFNGLCREATERENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers);
typedef void (* PFNGLNAMEDRENDERBUFFERSTORAGEPROC) (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLGETNAMEDRENDERBUFFERPARAMETERIVPROC) (GLuint renderbuffer, GLenum pname, GLint *params);
typedef void (* PFNGLCREATETEXTURESPROC) (GLenum target, GLsizei n, GLuint *textures);
typedef void (* PFNGLTEXTUREBUFFERPROC) (GLuint texture, GLenum internalformat, GLuint buffer);
typedef void (* PFNGLTEXTUREBUFFERRANGEPROC) (GLuint texture, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLTEXTURESTORAGE1DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void (* PFNGLTEXTURESTORAGE2DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXTURESTORAGE3DPROC) (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLTEXTURESTORAGE2DMULTISAMPLEPROC) (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXTURESTORAGE3DMULTISAMPLEPROC) (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLCOMPRESSEDTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);
typedef void (* PFNGLCOMPRESSEDTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);
typedef void (* PFNGLCOMPRESSEDTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);
typedef void (* PFNGLCOPYTEXTURESUBIMAGE1DPROC) (GLuint texture, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLCOPYTEXTURESUBIMAGE2DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLCOPYTEXTURESUBIMAGE3DPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXTUREPARAMETERFPROC) (GLuint texture, GLenum pname, GLfloat param);
typedef void (* PFNGLTEXTUREPARAMETERFVPROC) (GLuint texture, GLenum pname, const GLfloat *param);
typedef void (* PFNGLTEXTUREPARAMETERIPROC) (GLuint texture, GLenum pname, GLint param);
typedef void (* PFNGLTEXTUREPARAMETERIIVPROC) (GLuint texture, GLenum pname, const GLint *params);
typedef void (* PFNGLTEXTUREPARAMETERIUIVPROC) (GLuint texture, GLenum pname, const GLuint *params);
typedef void (* PFNGLTEXTUREPARAMETERIVPROC) (GLuint texture, GLenum pname, const GLint *param);
typedef void (* PFNGLGENERATETEXTUREMIPMAPPROC) (GLuint texture);
typedef void (* PFNGLBINDTEXTUREUNITPROC) (GLuint unit, GLuint texture);
typedef void (* PFNGLGETTEXTUREIMAGEPROC) (GLuint texture, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
typedef void (* PFNGLGETCOMPRESSEDTEXTUREIMAGEPROC) (GLuint texture, GLint level, GLsizei bufSize, void *pixels);
typedef void (* PFNGLGETTEXTURELEVELPARAMETERFVPROC) (GLuint texture, GLint level, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETTEXTURELEVELPARAMETERIVPROC) (GLuint texture, GLint level, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXTUREPARAMETERFVPROC) (GLuint texture, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETTEXTUREPARAMETERIIVPROC) (GLuint texture, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXTUREPARAMETERIUIVPROC) (GLuint texture, GLenum pname, GLuint *params);
typedef void (* PFNGLGETTEXTUREPARAMETERIVPROC) (GLuint texture, GLenum pname, GLint *params);
typedef void (* PFNGLCREATEVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef void (* PFNGLDISABLEVERTEXARRAYATTRIBPROC) (GLuint vaobj, GLuint index);
typedef void (* PFNGLENABLEVERTEXARRAYATTRIBPROC) (GLuint vaobj, GLuint index);
typedef void (* PFNGLVERTEXARRAYELEMENTBUFFERPROC) (GLuint vaobj, GLuint buffer);
typedef void (* PFNGLVERTEXARRAYVERTEXBUFFERPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void (* PFNGLVERTEXARRAYVERTEXBUFFERSPROC) (GLuint vaobj, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);
typedef void (* PFNGLVERTEXARRAYATTRIBBINDINGPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
typedef void (* PFNGLVERTEXARRAYATTRIBFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYATTRIBIFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYATTRIBLFORMATPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYBINDINGDIVISORPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor);
typedef void (* PFNGLGETVERTEXARRAYIVPROC) (GLuint vaobj, GLenum pname, GLint *param);
typedef void (* PFNGLGETVERTEXARRAYINDEXEDIVPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint *param);
typedef void (* PFNGLGETVERTEXARRAYINDEXED64IVPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint64 *param);
typedef void (* PFNGLCREATESAMPLERSPROC) (GLsizei n, GLuint *samplers);
typedef void (* PFNGLCREATEPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines);
typedef void (* PFNGLCREATEQUERIESPROC) (GLenum target, GLsizei n, GLuint *ids);
typedef void (* PFNGLGETQUERYBUFFEROBJECTI64VPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void (* PFNGLGETQUERYBUFFEROBJECTIVPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void (* PFNGLGETQUERYBUFFEROBJECTUI64VPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void (* PFNGLGETQUERYBUFFEROBJECTUIVPROC) (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
typedef void (* PFNGLMEMORYBARRIERBYREGIONPROC) (GLbitfield barriers);
typedef void (* PFNGLGETTEXTURESUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
typedef void (* PFNGLGETCOMPRESSEDTEXTURESUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei bufSize, void *pixels);
typedef GLenum (* PFNGLGETGRAPHICSRESETSTATUSPROC) (void);
typedef void (* PFNGLGETNCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint lod, GLsizei bufSize, void *pixels);
typedef void (* PFNGLGETNTEXIMAGEPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
typedef void (* PFNGLGETNUNIFORMDVPROC) (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);
typedef void (* PFNGLGETNUNIFORMFVPROC) (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
typedef void (* PFNGLGETNUNIFORMIVPROC) (GLuint program, GLint location, GLsizei bufSize, GLint *params);
typedef void (* PFNGLGETNUNIFORMUIVPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
typedef void (* PFNGLREADNPIXELSPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
typedef void (* PFNGLTEXTUREBARRIERPROC) (void);

void glClipControl (GLenum origin, GLenum depth);
void glCreateTransformFeedbacks (GLsizei n, GLuint *ids);
void glTransformFeedbackBufferBase (GLuint xfb, GLuint index, GLuint buffer);
void glTransformFeedbackBufferRange (GLuint xfb, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
void glGetTransformFeedbackiv (GLuint xfb, GLenum pname, GLint *param);
void glGetTransformFeedbacki_v (GLuint xfb, GLenum pname, GLuint index, GLint *param);
void glGetTransformFeedbacki64_v (GLuint xfb, GLenum pname, GLuint index, GLint64 *param);
void glCreateBuffers (GLsizei n, GLuint *buffers);
void glNamedBufferStorage (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);
void glNamedBufferData (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);
void glNamedBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
void glCopyNamedBufferSubData (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
void glClearNamedBufferData (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
void glClearNamedBufferSubData (GLuint buffer, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
void *glMapNamedBuffer (GLuint buffer, GLenum access);
void *glMapNamedBufferRange (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);
GLboolean glUnmapNamedBuffer (GLuint buffer);
void glFlushMappedNamedBufferRange (GLuint buffer, GLintptr offset, GLsizeiptr length);
void glGetNamedBufferParameteriv (GLuint buffer, GLenum pname, GLint *params);
void glGetNamedBufferParameteri64v (GLuint buffer, GLenum pname, GLint64 *params);
void glGetNamedBufferPointerv (GLuint buffer, GLenum pname, void **params);
void glGetNamedBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);
void glCreateFramebuffers (GLsizei n, GLuint *framebuffers);
void glNamedFramebufferRenderbuffer (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
void glNamedFramebufferParameteri (GLuint framebuffer, GLenum pname, GLint param);
void glNamedFramebufferTexture (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);
void glNamedFramebufferTextureLayer (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);
void glNamedFramebufferDrawBuffer (GLuint framebuffer, GLenum buf);
void glNamedFramebufferDrawBuffers (GLuint framebuffer, GLsizei n, const GLenum *bufs);
void glNamedFramebufferReadBuffer (GLuint framebuffer, GLenum src);
void glInvalidateNamedFramebufferData (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments);
void glInvalidateNamedFramebufferSubData (GLuint framebuffer, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
void glClearNamedFramebufferiv (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLint *value);
void glClearNamedFramebufferuiv (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLuint *value);
void glClearNamedFramebufferfv (GLuint framebuffer, GLenum buffer, GLint drawbuffer, const GLfloat *value);
void glClearNamedFramebufferfi (GLuint framebuffer, GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
void glBlitNamedFramebuffer (GLuint readFramebuffer, GLuint drawFramebuffer, GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
GLenum glCheckNamedFramebufferStatus (GLuint framebuffer, GLenum target);
void glGetNamedFramebufferParameteriv (GLuint framebuffer, GLenum pname, GLint *param);
void glGetNamedFramebufferAttachmentParameteriv (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);
void glCreateRenderbuffers (GLsizei n, GLuint *renderbuffers);
void glNamedRenderbufferStorage (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);
void glNamedRenderbufferStorageMultisample (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
void glGetNamedRenderbufferParameteriv (GLuint renderbuffer, GLenum pname, GLint *params);
void glCreateTextures (GLenum target, GLsizei n, GLuint *textures);
void glTextureBuffer (GLuint texture, GLenum internalformat, GLuint buffer);
void glTextureBufferRange (GLuint texture, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
void glTextureStorage1D (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width);
void glTextureStorage2D (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
void glTextureStorage3D (GLuint texture, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
void glTextureStorage2DMultisample (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
void glTextureStorage3DMultisample (GLuint texture, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
void glTextureSubImage1D (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
void glTextureSubImage2D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
void glTextureSubImage3D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
void glCompressedTextureSubImage1D (GLuint texture, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *data);
void glCompressedTextureSubImage2D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *data);
void glCompressedTextureSubImage3D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *data);
void glCopyTextureSubImage1D (GLuint texture, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
void glCopyTextureSubImage2D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glCopyTextureSubImage3D (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glTextureParameterf (GLuint texture, GLenum pname, GLfloat param);
void glTextureParameterfv (GLuint texture, GLenum pname, const GLfloat *param);
void glTextureParameteri (GLuint texture, GLenum pname, GLint param);
void glTextureParameterIiv (GLuint texture, GLenum pname, const GLint *params);
void glTextureParameterIuiv (GLuint texture, GLenum pname, const GLuint *params);
void glTextureParameteriv (GLuint texture, GLenum pname, const GLint *param);
void glGenerateTextureMipmap (GLuint texture);
void glBindTextureUnit (GLuint unit, GLuint texture);
void glGetTextureImage (GLuint texture, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
void glGetCompressedTextureImage (GLuint texture, GLint level, GLsizei bufSize, void *pixels);
void glGetTextureLevelParameterfv (GLuint texture, GLint level, GLenum pname, GLfloat *params);
void glGetTextureLevelParameteriv (GLuint texture, GLint level, GLenum pname, GLint *params);
void glGetTextureParameterfv (GLuint texture, GLenum pname, GLfloat *params);
void glGetTextureParameterIiv (GLuint texture, GLenum pname, GLint *params);
void glGetTextureParameterIuiv (GLuint texture, GLenum pname, GLuint *params);
void glGetTextureParameteriv (GLuint texture, GLenum pname, GLint *params);
void glCreateVertexArrays (GLsizei n, GLuint *arrays);
void glDisableVertexArrayAttrib (GLuint vaobj, GLuint index);
void glEnableVertexArrayAttrib (GLuint vaobj, GLuint index);
void glVertexArrayElementBuffer (GLuint vaobj, GLuint buffer);
void glVertexArrayVertexBuffer (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
void glVertexArrayVertexBuffers (GLuint vaobj, GLuint first, GLsizei count, const GLuint *buffers, const GLintptr *offsets, const GLsizei *strides);
void glVertexArrayAttribBinding (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
void glVertexArrayAttribFormat (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
void glVertexArrayAttribIFormat (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
void glVertexArrayAttribLFormat (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
void glVertexArrayBindingDivisor (GLuint vaobj, GLuint bindingindex, GLuint divisor);
void glGetVertexArrayiv (GLuint vaobj, GLenum pname, GLint *param);
void glGetVertexArrayIndexediv (GLuint vaobj, GLuint index, GLenum pname, GLint *param);
void glGetVertexArrayIndexed64iv (GLuint vaobj, GLuint index, GLenum pname, GLint64 *param);
void glCreateSamplers (GLsizei n, GLuint *samplers);
void glCreateProgramPipelines (GLsizei n, GLuint *pipelines);
void glCreateQueries (GLenum target, GLsizei n, GLuint *ids);
void glGetQueryBufferObjecti64v (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
void glGetQueryBufferObjectiv (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
void glGetQueryBufferObjectui64v (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
void glGetQueryBufferObjectuiv (GLuint id, GLuint buffer, GLenum pname, GLintptr offset);
void glMemoryBarrierByRegion (GLbitfield barriers);
void glGetTextureSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
void glGetCompressedTextureSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLsizei bufSize, void *pixels);
GLenum glGetGraphicsResetStatus (void);
void glGetnCompressedTexImage (GLenum target, GLint lod, GLsizei bufSize, void *pixels);
void glGetnTexImage (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *pixels);
void glGetnUniformdv (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);
void glGetnUniformfv (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
void glGetnUniformiv (GLuint program, GLint location, GLsizei bufSize, GLint *params);
void glGetnUniformuiv (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
void glReadnPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
void glTextureBarrier (void);

enum { GL_VERSION_4_6 = 1 };
enum {
    GL_SHADER_BINARY_FORMAT_SPIR_V    = 0x9551,
    GL_SPIR_V_BINARY                  = 0x9552,
    GL_PARAMETER_BUFFER               = 0x80EE,
    GL_PARAMETER_BUFFER_BINDING       = 0x80EF,
    GL_CONTEXT_FLAG_NO_ERROR_BIT      = 0x00000008,
    GL_VERTICES_SUBMITTED             = 0x82EE,
    GL_PRIMITIVES_SUBMITTED           = 0x82EF,
    GL_VERTEX_SHADER_INVOCATIONS      = 0x82F0,
    GL_TESS_CONTROL_SHADER_PATCHES    = 0x82F1,
    GL_TESS_EVALUATION_SHADER_INVOCATIONS = 0x82F2,
    GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED = 0x82F3,
    GL_FRAGMENT_SHADER_INVOCATIONS    = 0x82F4,
    GL_COMPUTE_SHADER_INVOCATIONS     = 0x82F5,
    GL_CLIPPING_INPUT_PRIMITIVES      = 0x82F6,
    GL_CLIPPING_OUTPUT_PRIMITIVES     = 0x82F7,
    GL_POLYGON_OFFSET_CLAMP           = 0x8E1B,
    GL_SPIR_V_EXTENSIONS              = 0x9553,
    GL_NUM_SPIR_V_EXTENSIONS          = 0x9554,
    GL_TEXTURE_MAX_ANISOTROPY         = 0x84FE,
    GL_MAX_TEXTURE_MAX_ANISOTROPY     = 0x84FF,
    GL_TRANSFORM_FEEDBACK_OVERFLOW    = 0x82EC,
    GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW = 0x82ED
};
typedef void (* PFNGLSPECIALIZESHADERPROC) (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);
typedef void (* PFNGLMULTIDRAWARRAYSINDIRECTCOUNTPROC) (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void (* PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTPROC) (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void (* PFNGLPOLYGONOFFSETCLAMPPROC) (GLfloat factor, GLfloat units, GLfloat clamp);
void glSpecializeShader (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);
void glMultiDrawArraysIndirectCount (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
void glMultiDrawElementsIndirectCount (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
void glPolygonOffsetClamp (GLfloat factor, GLfloat units, GLfloat clamp);

enum { GL_ARB_ES2_compatibility = 1 };
enum { GL_ARB_ES3_1_compatibility = 1 };

enum {
    GL_ARB_ES3_2_compatibility = 1,
    GL_PRIMITIVE_BOUNDING_BOX_ARB     = 0x92BE,
    GL_MULTISAMPLE_LINE_WIDTH_RANGE_ARB = 0x9381,
    GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB = 0x9382
};
typedef void (* PFNGLPRIMITIVEBOUNDINGBOXARBPROC) (GLfloat minX, GLfloat minY, GLfloat minZ, GLfloat minW, GLfloat maxX, GLfloat maxY, GLfloat maxZ, GLfloat maxW);
void glPrimitiveBoundingBoxARB (GLfloat minX, GLfloat minY, GLfloat minZ, GLfloat minW, GLfloat maxX, GLfloat maxY, GLfloat maxZ, GLfloat maxW);

enum { GL_ARB_ES3_compatibility = 1 };
enum { GL_ARB_arrays_of_arrays = 1 };
enum { GL_ARB_base_instance = 1 };
enum { GL_ARB_bindless_texture = 1 };
typedef uint64_t GLuint64EXT;
enum { GL_UNSIGNED_INT64_ARB = 0x140F };
typedef GLuint64 (* PFNGLGETTEXTUREHANDLEARBPROC) (GLuint texture);
typedef GLuint64 (* PFNGLGETTEXTURESAMPLERHANDLEARBPROC) (GLuint texture, GLuint sampler);
typedef void (* PFNGLMAKETEXTUREHANDLERESIDENTARBPROC) (GLuint64 handle);
typedef void (* PFNGLMAKETEXTUREHANDLENONRESIDENTARBPROC) (GLuint64 handle);
typedef GLuint64 (* PFNGLGETIMAGEHANDLEARBPROC) (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);
typedef void (* PFNGLMAKEIMAGEHANDLERESIDENTARBPROC) (GLuint64 handle, GLenum access);
typedef void (* PFNGLMAKEIMAGEHANDLENONRESIDENTARBPROC) (GLuint64 handle);
typedef void (* PFNGLUNIFORMHANDLEUI64ARBPROC) (GLint location, GLuint64 value);
typedef void (* PFNGLUNIFORMHANDLEUI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLPROGRAMUNIFORMHANDLEUI64ARBPROC) (GLuint program, GLint location, GLuint64 value);
typedef void (* PFNGLPROGRAMUNIFORMHANDLEUI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *values);
typedef GLboolean (* PFNGLISTEXTUREHANDLERESIDENTARBPROC) (GLuint64 handle);
typedef GLboolean (* PFNGLISIMAGEHANDLERESIDENTARBPROC) (GLuint64 handle);
typedef void (* PFNGLVERTEXATTRIBL1UI64ARBPROC) (GLuint index, GLuint64EXT x);
typedef void (* PFNGLVERTEXATTRIBL1UI64VARBPROC) (GLuint index, const GLuint64EXT *v);
typedef void (* PFNGLGETVERTEXATTRIBLUI64VARBPROC) (GLuint index, GLenum pname, GLuint64EXT *params);

GLuint64 glGetTextureHandleARB (GLuint texture);
GLuint64 glGetTextureSamplerHandleARB (GLuint texture, GLuint sampler);
void glMakeTextureHandleResidentARB (GLuint64 handle);
void glMakeTextureHandleNonResidentARB (GLuint64 handle);
GLuint64 glGetImageHandleARB (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);
void glMakeImageHandleResidentARB (GLuint64 handle, GLenum access);
void glMakeImageHandleNonResidentARB (GLuint64 handle);
void glUniformHandleui64ARB (GLint location, GLuint64 value);
void glUniformHandleui64vARB (GLint location, GLsizei count, const GLuint64 *value);
void glProgramUniformHandleui64ARB (GLuint program, GLint location, GLuint64 value);
void glProgramUniformHandleui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *values);
GLboolean glIsTextureHandleResidentARB (GLuint64 handle);
GLboolean glIsImageHandleResidentARB (GLuint64 handle);
void glVertexAttribL1ui64ARB (GLuint index, GLuint64EXT x);
void glVertexAttribL1ui64vARB (GLuint index, const GLuint64EXT *v);
void glGetVertexAttribLui64vARB (GLuint index, GLenum pname, GLuint64EXT *params);

enum { GL_ARB_blend_func_extended = 1 };
enum { GL_ARB_buffer_storage = 1 };

enum { GL_ARB_cl_event = 1 };
struct _cl_context;
struct _cl_event;
enum {
    GL_SYNC_CL_EVENT_ARB              = 0x8240,
    GL_SYNC_CL_EVENT_COMPLETE_ARB     = 0x8241
};
typedef GLsync (* PFNGLCREATESYNCFROMCLEVENTARBPROC) (struct _cl_context *context, struct _cl_event *event, GLbitfield flags);
GLsync glCreateSyncFromCLeventARB (struct _cl_context *context, struct _cl_event *event, GLbitfield flags);

enum { GL_ARB_clear_buffer_object = 1 };
enum { GL_ARB_clear_texture = 1 };
enum { GL_ARB_clip_control = 1 };
enum { GL_ARB_compressed_texture_pixel_storage = 1 };
enum { GL_ARB_compute_shader = 1 };

enum {
    GL_ARB_compute_variable_group_size = 1,
    GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB = 0x9344,
    GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB = 0x90EB,
    GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB = 0x9345,
    GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB = 0x91BF
};
typedef void (* PFNGLDISPATCHCOMPUTEGROUPSIZEARBPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z, GLuint group_size_x, GLuint group_size_y, GLuint group_size_z);
void glDispatchComputeGroupSizeARB (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z, GLuint group_size_x, GLuint group_size_y, GLuint group_size_z);

enum { GL_ARB_conditional_render_inverted = 1 };
enum { GL_ARB_conservative_depth = 1 };
enum { GL_ARB_copy_buffer = 1 };
enum { GL_ARB_copy_image = 1 };
enum { GL_ARB_cull_distance = 1 };
enum { GL_ARB_debug_output = 1 };
typedef void ( *GLDEBUGPROCARB)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);
enum {
    GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB   = 0x8242,
    GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB = 0x8243,
    GL_DEBUG_CALLBACK_FUNCTION_ARB    = 0x8244,
    GL_DEBUG_CALLBACK_USER_PARAM_ARB  = 0x8245,
    GL_DEBUG_SOURCE_API_ARB           = 0x8246,
    GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB = 0x8247,
    GL_DEBUG_SOURCE_SHADER_COMPILER_ARB = 0x8248,
    GL_DEBUG_SOURCE_THIRD_PARTY_ARB   = 0x8249,
    GL_DEBUG_SOURCE_APPLICATION_ARB   = 0x824A,
    GL_DEBUG_SOURCE_OTHER_ARB         = 0x824B,
    GL_DEBUG_TYPE_ERROR_ARB           = 0x824C,
    GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB = 0x824D,
    GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB = 0x824E,
    GL_DEBUG_TYPE_PORTABILITY_ARB     = 0x824F,
    GL_DEBUG_TYPE_PERFORMANCE_ARB     = 0x8250,
    GL_DEBUG_TYPE_OTHER_ARB           = 0x8251,
    GL_MAX_DEBUG_MESSAGE_LENGTH_ARB   = 0x9143,
    GL_MAX_DEBUG_LOGGED_MESSAGES_ARB  = 0x9144,
    GL_DEBUG_LOGGED_MESSAGES_ARB      = 0x9145,
    GL_DEBUG_SEVERITY_HIGH_ARB        = 0x9146,
    GL_DEBUG_SEVERITY_MEDIUM_ARB      = 0x9147,
    GL_DEBUG_SEVERITY_LOW_ARB         = 0x9148
};
typedef void (* PFNGLDEBUGMESSAGECONTROLARBPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void (* PFNGLDEBUGMESSAGEINSERTARBPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
typedef void (* PFNGLDEBUGMESSAGECALLBACKARBPROC) (GLDEBUGPROCARB callback, const void *userParam);
typedef GLuint (* PFNGLGETDEBUGMESSAGELOGARBPROC) (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);

void glDebugMessageControlARB (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
void glDebugMessageInsertARB (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
void glDebugMessageCallbackARB (GLDEBUGPROCARB callback, const void *userParam);
GLuint glGetDebugMessageLogARB (GLuint count, GLsizei bufSize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);

enum { GL_ARB_depth_buffer_float = 1 };
enum { GL_ARB_depth_clamp = 1 };
enum { GL_ARB_derivative_control = 1 };
enum { GL_ARB_direct_state_access = 1 };
enum { GL_ARB_draw_buffers_blend = 1 };
typedef void (* PFNGLBLENDEQUATIONIARBPROC) (GLuint buf, GLenum mode);
typedef void (* PFNGLBLENDEQUATIONSEPARATEIARBPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void (* PFNGLBLENDFUNCIARBPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void (* PFNGLBLENDFUNCSEPARATEIARBPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
void glBlendEquationiARB (GLuint buf, GLenum mode);
void glBlendEquationSeparateiARB (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
void glBlendFunciARB (GLuint buf, GLenum src, GLenum dst);
void glBlendFuncSeparateiARB (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
enum { GL_ARB_draw_elements_base_vertex = 1 };
enum { GL_ARB_draw_indirect = 1 };
enum { GL_ARB_draw_instanced = 1 };
typedef void (* PFNGLDRAWARRAYSINSTANCEDARBPROC) (GLenum mode, GLint first, GLsizei count, GLsizei primcount);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDARBPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);
void glDrawArraysInstancedARB (GLenum mode, GLint first, GLsizei count, GLsizei primcount);
void glDrawElementsInstancedARB (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);

enum { GL_ARB_enhanced_layouts = 1 };
enum { GL_ARB_explicit_attrib_location = 1 };
enum { GL_ARB_explicit_uniform_location = 1 };
enum { GL_ARB_fragment_coord_conventions = 1 };
enum { GL_ARB_fragment_layer_viewport = 1 };
enum { GL_ARB_fragment_shader_interlock = 1 };
enum { GL_ARB_framebuffer_no_attachments = 1 };
enum { GL_ARB_framebuffer_object = 1 };
enum { GL_ARB_framebuffer_sRGB = 1 };

enum {
    GL_ARB_geometry_shader4 = 1,
    GL_LINES_ADJACENCY_ARB            = 0x000A,
    GL_LINE_STRIP_ADJACENCY_ARB       = 0x000B,
    GL_TRIANGLES_ADJACENCY_ARB        = 0x000C,
    GL_TRIANGLE_STRIP_ADJACENCY_ARB   = 0x000D,
    GL_PROGRAM_POINT_SIZE_ARB         = 0x8642,
    GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB = 0x8C29,
    GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB = 0x8DA7,
    GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB = 0x8DA8,
    GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB = 0x8DA9,
    GL_GEOMETRY_SHADER_ARB            = 0x8DD9,
    GL_GEOMETRY_VERTICES_OUT_ARB      = 0x8DDA,
    GL_GEOMETRY_INPUT_TYPE_ARB        = 0x8DDB,
    GL_GEOMETRY_OUTPUT_TYPE_ARB       = 0x8DDC,
    GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB = 0x8DDD,
    GL_MAX_VERTEX_VARYING_COMPONENTS_ARB = 0x8DDE,
    GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB = 0x8DDF,
    GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB = 0x8DE0,
    GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB = 0x8DE1
};
typedef void (* PFNGLPROGRAMPARAMETERIARBPROC) (GLuint program, GLenum pname, GLint value);
typedef void (* PFNGLFRAMEBUFFERTEXTUREARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void (* PFNGLFRAMEBUFFERTEXTURELAYERARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void (* PFNGLFRAMEBUFFERTEXTUREFACEARBPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face);
void glProgramParameteriARB (GLuint program, GLenum pname, GLint value);
void glFramebufferTextureARB (GLenum target, GLenum attachment, GLuint texture, GLint level);
void glFramebufferTextureLayerARB (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
void glFramebufferTextureFaceARB (GLenum target, GLenum attachment, GLuint texture, GLint level, GLenum face);

enum { GL_ARB_get_program_binary = 1 };
enum { GL_ARB_get_texture_sub_image = 1 };

enum { GL_ARB_gl_spirv = 1 };
enum {
    GL_SHADER_BINARY_FORMAT_SPIR_V_ARB = 0x9551,
    GL_SPIR_V_BINARY_ARB              = 0x9552
};
typedef void (* PFNGLSPECIALIZESHADERARBPROC) (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);
void glSpecializeShaderARB (GLuint shader, const GLchar *pEntryPoint, GLuint numSpecializationConstants, const GLuint *pConstantIndex, const GLuint *pConstantValue);

enum { GL_ARB_gpu_shader5 = 1 };
enum { GL_ARB_gpu_shader_fp64 = 1 };

enum {
    GL_ARB_gpu_shader_int64           = 1,
    GL_INT64_ARB                      = 0x140E,
    GL_INT64_VEC2_ARB                 = 0x8FE9,
    GL_INT64_VEC3_ARB                 = 0x8FEA,
    GL_INT64_VEC4_ARB                 = 0x8FEB,
    GL_UNSIGNED_INT64_VEC2_ARB        = 0x8FF5,
    GL_UNSIGNED_INT64_VEC3_ARB        = 0x8FF6,
    GL_UNSIGNED_INT64_VEC4_ARB        = 0x8FF7
};
typedef void (* PFNGLUNIFORM1I64ARBPROC) (GLint location, GLint64 x);
typedef void (* PFNGLUNIFORM2I64ARBPROC) (GLint location, GLint64 x, GLint64 y);
typedef void (* PFNGLUNIFORM3I64ARBPROC) (GLint location, GLint64 x, GLint64 y, GLint64 z);
typedef void (* PFNGLUNIFORM4I64ARBPROC) (GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
typedef void (* PFNGLUNIFORM1I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLUNIFORM2I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLUNIFORM3I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLUNIFORM4I64VARBPROC) (GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLUNIFORM1UI64ARBPROC) (GLint location, GLuint64 x);
typedef void (* PFNGLUNIFORM2UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y);
typedef void (* PFNGLUNIFORM3UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y, GLuint64 z);
typedef void (* PFNGLUNIFORM4UI64ARBPROC) (GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
typedef void (* PFNGLUNIFORM1UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLUNIFORM2UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLUNIFORM3UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLUNIFORM4UI64VARBPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLGETUNIFORMI64VARBPROC) (GLuint program, GLint location, GLint64 *params);
typedef void (* PFNGLGETUNIFORMUI64VARBPROC) (GLuint program, GLint location, GLuint64 *params);
typedef void (* PFNGLGETNUNIFORMI64VARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLint64 *params);
typedef void (* PFNGLGETNUNIFORMUI64VARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint64 *params);
typedef void (* PFNGLPROGRAMUNIFORM1I64ARBPROC) (GLuint program, GLint location, GLint64 x);
typedef void (* PFNGLPROGRAMUNIFORM2I64ARBPROC) (GLuint program, GLint location, GLint64 x, GLint64 y);
typedef void (* PFNGLPROGRAMUNIFORM3I64ARBPROC) (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z);
typedef void (* PFNGLPROGRAMUNIFORM4I64ARBPROC) (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
typedef void (* PFNGLPROGRAMUNIFORM1I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM2I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM3I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM4I64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM1UI64ARBPROC) (GLuint program, GLint location, GLuint64 x);
typedef void (* PFNGLPROGRAMUNIFORM2UI64ARBPROC) (GLuint program, GLint location, GLuint64 x, GLuint64 y);
typedef void (* PFNGLPROGRAMUNIFORM3UI64ARBPROC) (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z);
typedef void (* PFNGLPROGRAMUNIFORM4UI64ARBPROC) (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
typedef void (* PFNGLPROGRAMUNIFORM1UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM2UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM3UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLPROGRAMUNIFORM4UI64VARBPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *value);

void glUniform1i64ARB (GLint location, GLint64 x);
void glUniform2i64ARB (GLint location, GLint64 x, GLint64 y);
void glUniform3i64ARB (GLint location, GLint64 x, GLint64 y, GLint64 z);
void glUniform4i64ARB (GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
void glUniform1i64vARB (GLint location, GLsizei count, const GLint64 *value);
void glUniform2i64vARB (GLint location, GLsizei count, const GLint64 *value);
void glUniform3i64vARB (GLint location, GLsizei count, const GLint64 *value);
void glUniform4i64vARB (GLint location, GLsizei count, const GLint64 *value);
void glUniform1ui64ARB (GLint location, GLuint64 x);
void glUniform2ui64ARB (GLint location, GLuint64 x, GLuint64 y);
void glUniform3ui64ARB (GLint location, GLuint64 x, GLuint64 y, GLuint64 z);
void glUniform4ui64ARB (GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
void glUniform1ui64vARB (GLint location, GLsizei count, const GLuint64 *value);
void glUniform2ui64vARB (GLint location, GLsizei count, const GLuint64 *value);
void glUniform3ui64vARB (GLint location, GLsizei count, const GLuint64 *value);
void glUniform4ui64vARB (GLint location, GLsizei count, const GLuint64 *value);
void glGetUniformi64vARB (GLuint program, GLint location, GLint64 *params);
void glGetUniformui64vARB (GLuint program, GLint location, GLuint64 *params);
void glGetnUniformi64vARB (GLuint program, GLint location, GLsizei bufSize, GLint64 *params);
void glGetnUniformui64vARB (GLuint program, GLint location, GLsizei bufSize, GLuint64 *params);
void glProgramUniform1i64ARB (GLuint program, GLint location, GLint64 x);
void glProgramUniform2i64ARB (GLuint program, GLint location, GLint64 x, GLint64 y);
void glProgramUniform3i64ARB (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z);
void glProgramUniform4i64ARB (GLuint program, GLint location, GLint64 x, GLint64 y, GLint64 z, GLint64 w);
void glProgramUniform1i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);
void glProgramUniform2i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);
void glProgramUniform3i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);
void glProgramUniform4i64vARB (GLuint program, GLint location, GLsizei count, const GLint64 *value);
void glProgramUniform1ui64ARB (GLuint program, GLint location, GLuint64 x);
void glProgramUniform2ui64ARB (GLuint program, GLint location, GLuint64 x, GLuint64 y);
void glProgramUniform3ui64ARB (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z);
void glProgramUniform4ui64ARB (GLuint program, GLint location, GLuint64 x, GLuint64 y, GLuint64 z, GLuint64 w);
void glProgramUniform1ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
void glProgramUniform2ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
void glProgramUniform3ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);
void glProgramUniform4ui64vARB (GLuint program, GLint location, GLsizei count, const GLuint64 *value);

enum { GL_ARB_half_float_vertex = 1 };
enum { GL_ARB_indirect_parameters = 1 };
enum {
    GL_PARAMETER_BUFFER_ARB           = 0x80EE,
    GL_PARAMETER_BUFFER_BINDING_ARB   = 0x80EF
};
typedef void (* PFNGLMULTIDRAWARRAYSINDIRECTCOUNTARBPROC) (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
typedef void (* PFNGLMULTIDRAWELEMENTSINDIRECTCOUNTARBPROC) (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
void glMultiDrawArraysIndirectCountARB (GLenum mode, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
void glMultiDrawElementsIndirectCountARB (GLenum mode, GLenum type, const void *indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
enum {
    GL_ARB_instanced_arrays = 1,
    GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB = 0x88FE
};
typedef void (* PFNGLVERTEXATTRIBDIVISORARBPROC) (GLuint index, GLuint divisor);
void glVertexAttribDivisorARB (GLuint index, GLuint divisor);

enum { GL_ARB_internalformat_query = 1 };

enum {
    GL_ARB_internalformat_query2      = 1,
    GL_SRGB_DECODE_ARB                = 0x8299,
    GL_VIEW_CLASS_EAC_R11             = 0x9383,
    GL_VIEW_CLASS_EAC_RG11            = 0x9384,
    GL_VIEW_CLASS_ETC2_RGB            = 0x9385,
    GL_VIEW_CLASS_ETC2_RGBA           = 0x9386,
    GL_VIEW_CLASS_ETC2_EAC_RGBA       = 0x9387,
    GL_VIEW_CLASS_ASTC_4x4_RGBA       = 0x9388,
    GL_VIEW_CLASS_ASTC_5x4_RGBA       = 0x9389,
    GL_VIEW_CLASS_ASTC_5x5_RGBA       = 0x938A,
    GL_VIEW_CLASS_ASTC_6x5_RGBA       = 0x938B,
    GL_VIEW_CLASS_ASTC_6x6_RGBA       = 0x938C,
    GL_VIEW_CLASS_ASTC_8x5_RGBA       = 0x938D,
    GL_VIEW_CLASS_ASTC_8x6_RGBA       = 0x938E,
    GL_VIEW_CLASS_ASTC_8x8_RGBA       = 0x938F,
    GL_VIEW_CLASS_ASTC_10x5_RGBA      = 0x9390,
    GL_VIEW_CLASS_ASTC_10x6_RGBA      = 0x9391,
    GL_VIEW_CLASS_ASTC_10x8_RGBA      = 0x9392,
    GL_VIEW_CLASS_ASTC_10x10_RGBA     = 0x9393,
    GL_VIEW_CLASS_ASTC_12x10_RGBA     = 0x9394,
    GL_VIEW_CLASS_ASTC_12x12_RGBA     = 0x9395
};

enum { GL_ARB_invalidate_subdata = 1 };
enum { GL_ARB_map_buffer_alignment = 1 };
enum { GL_ARB_map_buffer_range = 1 };
enum { GL_ARB_multi_bind = 1 };
enum { GL_ARB_multi_draw_indirect = 1 };
enum { GL_ARB_occlusion_query2 = 1 };

enum {
    GL_ARB_parallel_shader_compile     = 1,
    GL_MAX_SHADER_COMPILER_THREADS_ARB = 0x91B0,
    GL_COMPLETION_STATUS_ARB           = 0x91B1
};
typedef void (* PFNGLMAXSHADERCOMPILERTHREADSARBPROC) (GLuint count);
void glMaxShaderCompilerThreadsARB (GLuint count);

enum {
    GL_ARB_pipeline_statistics_query = 1,
    GL_VERTICES_SUBMITTED_ARB         = 0x82EE,
    GL_PRIMITIVES_SUBMITTED_ARB       = 0x82EF,
    GL_VERTEX_SHADER_INVOCATIONS_ARB  = 0x82F0,
    GL_TESS_CONTROL_SHADER_PATCHES_ARB = 0x82F1,
    GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB = 0x82F2,
    GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB = 0x82F3,
    GL_FRAGMENT_SHADER_INVOCATIONS_ARB = 0x82F4,
    GL_COMPUTE_SHADER_INVOCATIONS_ARB = 0x82F5,
    GL_CLIPPING_INPUT_PRIMITIVES_ARB  = 0x82F6,
    GL_CLIPPING_OUTPUT_PRIMITIVES_ARB = 0x82F7
};

enum {
    GL_ARB_pixel_buffer_object = 1,
    GL_PIXEL_PACK_BUFFER_ARB          = 0x88EB,
    GL_PIXEL_UNPACK_BUFFER_ARB        = 0x88EC,
    GL_PIXEL_PACK_BUFFER_BINDING_ARB  = 0x88ED,
    GL_PIXEL_UNPACK_BUFFER_BINDING_ARB = 0x88EF
};

enum { GL_ARB_polygon_offset_clamp = 1 };
enum { GL_ARB_post_depth_coverage = 1 };
enum { GL_ARB_program_interface_query = 1 };
enum { GL_ARB_provoking_vertex = 1 };
enum { GL_ARB_query_buffer_object = 1 };
enum { GL_ARB_robust_buffer_access_behavior = 1 };

enum {
    GL_ARB_robustness = 1,
    GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB = 0x00000004,
    GL_LOSE_CONTEXT_ON_RESET_ARB      = 0x8252,
    GL_GUILTY_CONTEXT_RESET_ARB       = 0x8253,
    GL_INNOCENT_CONTEXT_RESET_ARB     = 0x8254,
    GL_UNKNOWN_CONTEXT_RESET_ARB      = 0x8255,
    GL_RESET_NOTIFICATION_STRATEGY_ARB = 0x8256,
    GL_NO_RESET_NOTIFICATION_ARB      = 0x8261
};

typedef GLenum (* PFNGLGETGRAPHICSRESETSTATUSARBPROC) (void);
typedef void (* PFNGLGETNTEXIMAGEARBPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *img);
typedef void (* PFNGLREADNPIXELSARBPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
typedef void (* PFNGLGETNCOMPRESSEDTEXIMAGEARBPROC) (GLenum target, GLint lod, GLsizei bufSize, void *img);
typedef void (* PFNGLGETNUNIFORMFVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
typedef void (* PFNGLGETNUNIFORMIVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLint *params);
typedef void (* PFNGLGETNUNIFORMUIVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
typedef void (* PFNGLGETNUNIFORMDVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);

GLenum glGetGraphicsResetStatusARB (void);
void glGetnTexImageARB (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, void *img);
void glReadnPixelsARB (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, void *data);
void glGetnCompressedTexImageARB (GLenum target, GLint lod, GLsizei bufSize, void *img);
void glGetnUniformfvARB (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
void glGetnUniformivARB (GLuint program, GLint location, GLsizei bufSize, GLint *params);
void glGetnUniformuivARB (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
void glGetnUniformdvARB (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);

enum { GL_ARB_robustness_isolation = 1 };
enum {
    GL_ARB_sample_locations = 1,
    GL_SAMPLE_LOCATION_SUBPIXEL_BITS_ARB = 0x933D,
    GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB = 0x933E,
    GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB = 0x933F,
    GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB = 0x9340,
    GL_SAMPLE_LOCATION_ARB            = 0x8E50,
    GL_PROGRAMMABLE_SAMPLE_LOCATION_ARB = 0x9341,
    GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB = 0x9342,
    GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB = 0x9343
};
typedef void (* PFNGLFRAMEBUFFERSAMPLELOCATIONSFVARBPROC) (GLenum target, GLuint start, GLsizei count, const GLfloat *v);
typedef void (* PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVARBPROC) (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
typedef void (* PFNGLEVALUATEDEPTHVALUESARBPROC) (void);
void glFramebufferSampleLocationsfvARB (GLenum target, GLuint start, GLsizei count, const GLfloat *v);
void glNamedFramebufferSampleLocationsfvARB (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
void glEvaluateDepthValuesARB (void);
enum {
    GL_ARB_sample_shading = 1,
    GL_SAMPLE_SHADING_ARB             = 0x8C36,
    GL_MIN_SAMPLE_SHADING_VALUE_ARB   = 0x8C37
};
typedef void (* PFNGLMINSAMPLESHADINGARBPROC) (GLfloat value);
void glMinSampleShadingARB (GLfloat value);

enum { GL_ARB_sampler_objects = 1 };
enum { GL_ARB_seamless_cube_map = 1 };
enum { GL_ARB_seamless_cubemap_per_texture = 1 };
enum { GL_ARB_separate_shader_objects = 1 };
enum { GL_ARB_shader_atomic_counter_ops = 1 };
enum { GL_ARB_shader_atomic_counters = 1 };
enum { GL_ARB_shader_ballot = 1 };
enum { GL_ARB_shader_bit_encoding = 1 };
enum { GL_ARB_shader_clock = 1 };
enum { GL_ARB_shader_draw_parameters = 1 };
enum { GL_ARB_shader_group_vote = 1 };
enum { GL_ARB_shader_image_load_store = 1 };
enum { GL_ARB_shader_image_size = 1 };
enum { GL_ARB_shader_precision = 1 };
enum { GL_ARB_shader_stencil_export = 1 };
enum { GL_ARB_shader_storage_buffer_object = 1 };
enum { GL_ARB_shader_subroutine = 1 };
enum { GL_ARB_shader_texture_image_samples = 1 };
enum { GL_ARB_shader_viewport_layer_array = 1 };
enum { GL_ARB_shading_language_420pack = 1 };
enum {
    GL_ARB_shading_language_include   = 1,
    GL_SHADER_INCLUDE_ARB             = 0x8DAE,
    GL_NAMED_STRING_LENGTH_ARB        = 0x8DE9,
    GL_NAMED_STRING_TYPE_ARB          = 0x8DEA
};

typedef void (* PFNGLNAMEDSTRINGARBPROC) (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string);
typedef void (* PFNGLDELETENAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name);
typedef void (* PFNGLCOMPILESHADERINCLUDEARBPROC) (GLuint shader, GLsizei count, const GLchar *const*path, const GLint *length);
typedef GLboolean (* PFNGLISNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name);
typedef void (* PFNGLGETNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string);
typedef void (* PFNGLGETNAMEDSTRINGIVARBPROC) (GLint namelen, const GLchar *name, GLenum pname, GLint *params);
void glNamedStringARB (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string);
void glDeleteNamedStringARB (GLint namelen, const GLchar *name);
void glCompileShaderIncludeARB (GLuint shader, GLsizei count, const GLchar *const*path, const GLint *length);
GLboolean glIsNamedStringARB (GLint namelen, const GLchar *name);
void glGetNamedStringARB (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string);

enum { GL_ARB_shading_language_packing = 1 };
enum {
    GL_ARB_sparse_buffer              = 1,
    GL_SPARSE_STORAGE_BIT_ARB         = 0x0400,
    GL_SPARSE_BUFFER_PAGE_SIZE_ARB    = 0x82F8
};
typedef void (* PFNGLBUFFERPAGECOMMITMENTARBPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLboolean commit);
typedef void (* PFNGLNAMEDBUFFERPAGECOMMITMENTEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);
typedef void (* PFNGLNAMEDBUFFERPAGECOMMITMENTARBPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);

void glBufferPageCommitmentARB (GLenum target, GLintptr offset, GLsizeiptr size, GLboolean commit);
void glNamedBufferPageCommitmentEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);
void glNamedBufferPageCommitmentARB (GLuint buffer, GLintptr offset, GLsizeiptr size, GLboolean commit);
enum {
    GL_ARB_sparse_texture             = 1,
    GL_TEXTURE_SPARSE_ARB             = 0x91A6,
    GL_VIRTUAL_PAGE_SIZE_INDEX_ARB    = 0x91A7,
    GL_NUM_SPARSE_LEVELS_ARB          = 0x91AA,
    GL_NUM_VIRTUAL_PAGE_SIZES_ARB     = 0x91A8,
    GL_VIRTUAL_PAGE_SIZE_X_ARB        = 0x9195,
    GL_VIRTUAL_PAGE_SIZE_Y_ARB        = 0x9196,
    GL_VIRTUAL_PAGE_SIZE_Z_ARB        = 0x9197,
    GL_MAX_SPARSE_TEXTURE_SIZE_ARB    = 0x9198,
    GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB = 0x9199,
    GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB = 0x919A,
    GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB = 0x91A9
};
typedef void (* PFNGLTEXPAGECOMMITMENTARBPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);
void glTexPageCommitmentARB (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);

enum { GL_ARB_sparse_texture2 = 1 };
enum { GL_ARB_sparse_texture_clamp = 1 };
enum { GL_ARB_spirv_extensions = 1 };
enum { GL_ARB_stencil_texturing = 1 };
enum { GL_ARB_sync = 1 };
enum { GL_ARB_tessellation_shader = 1 };
enum { GL_ARB_texture_barrier = 1 };
enum { GL_ARB_texture_border_clamp = 1 };
enum { GL_CLAMP_TO_BORDER_ARB = 0x812D };
enum {
    GL_ARB_texture_buffer_object      = 1,
    GL_TEXTURE_BUFFER_ARB             = 0x8C2A,
    GL_MAX_TEXTURE_BUFFER_SIZE_ARB    = 0x8C2B,
    GL_TEXTURE_BINDING_BUFFER_ARB     = 0x8C2C,
    GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB = 0x8C2D,
    GL_TEXTURE_BUFFER_FORMAT_ARB      = 0x8C2E
};

typedef void (* PFNGLTEXBUFFERARBPROC) (GLenum target, GLenum internalformat, GLuint buffer);
void glTexBufferARB (GLenum target, GLenum internalformat, GLuint buffer);

enum { GL_ARB_texture_buffer_object_rgb32 = 1 };
enum { GL_ARB_texture_buffer_range = 1 };
enum {
    GL_ARB_texture_compression_bptc = 1,
    GL_COMPRESSED_RGBA_BPTC_UNORM_ARB = 0x8E8C,
    GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB = 0x8E8D,
    GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB = 0x8E8E,
    GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB = 0x8E8F
};
enum { GL_ARB_texture_compression_rgtc = 1 };
enum {
    GL_ARB_texture_cube_map_array = 1,
    GL_TEXTURE_CUBE_MAP_ARRAY_ARB     = 0x9009,
    GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB = 0x900A,
    GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB = 0x900B,
    GL_SAMPLER_CUBE_MAP_ARRAY_ARB     = 0x900C,
    GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB = 0x900D,
    GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 0x900E,
    GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 0x900F
};
enum { GL_ARB_texture_filter_anisotropic = 1 };
enum {
    GL_ARB_texture_filter_minmax = 1,
    GL_TEXTURE_REDUCTION_MODE_ARB     = 0x9366,
    GL_WEIGHTED_AVERAGE_ARB           = 0x9367
};
enum {
    GL_ARB_texture_gather = 1,
    GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = 0x8E5E,
    GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB = 0x8E5F,
    GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB = 0x8F9F
};
enum { GL_ARB_texture_mirror_clamp_to_edge = 1 };
enum {
    GL_ARB_texture_mirrored_repeat = 1,
    GL_MIRRORED_REPEAT_ARB         = 0x8370
};

enum { GL_ARB_texture_multisample = 1 };
enum { GL_ARB_texture_non_power_of_two = 1 };
enum { GL_ARB_texture_query_levels = 1 };
enum { GL_ARB_texture_query_lod = 1 };
enum { GL_ARB_texture_rg = 1 };
enum { GL_ARB_texture_rgb10_a2ui = 1 };
enum { GL_ARB_texture_stencil8 = 1 };
enum { GL_ARB_texture_storage = 1 };
enum { GL_ARB_texture_storage_multisample = 1 };
enum { GL_ARB_texture_swizzle = 1 };
enum { GL_ARB_texture_view = 1 };
enum { GL_ARB_timer_query = 1 };
enum { GL_ARB_transform_feedback2 = 1 };
enum { GL_ARB_transform_feedback3 = 1 };
enum { GL_ARB_transform_feedback_instanced = 1 };
enum {
    GL_ARB_transform_feedback_overflow_query = 1,
    GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB = 0x82EC,
    GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB = 0x82ED
};

enum { GL_ARB_uniform_buffer_object = 1 };
enum { GL_ARB_vertex_array_bgra = 1 };
enum { GL_ARB_vertex_array_object = 1 };
enum { GL_ARB_vertex_attrib_64bit = 1 };
enum { GL_ARB_vertex_attrib_binding = 1 };
enum { GL_ARB_vertex_type_10f_11f_11f_rev = 1 };
enum { GL_ARB_vertex_type_2_10_10_10_rev = 1 };
enum { GL_ARB_viewport_array = 1 };
typedef void (* PFNGLDEPTHRANGEARRAYDVNVPROC) (GLuint first, GLsizei count, const GLdouble *v);
typedef void (* PFNGLDEPTHRANGEINDEXEDDNVPROC) (GLuint index, GLdouble n, GLdouble f);

void glDepthRangeArraydvNV (GLuint first, GLsizei count, const GLdouble *v);
void glDepthRangeIndexeddNV (GLuint index, GLdouble n, GLdouble f);

enum {
    GL_KHR_blend_equation_advanced    = 1,
    GL_MULTIPLY_KHR                   = 0x9294,
    GL_SCREEN_KHR                     = 0x9295,
    GL_OVERLAY_KHR                    = 0x9296,
    GL_DARKEN_KHR                     = 0x9297,
    GL_LIGHTEN_KHR                    = 0x9298,
    GL_COLORDODGE_KHR                 = 0x9299,
    GL_COLORBURN_KHR                  = 0x929A,
    GL_HARDLIGHT_KHR                  = 0x929B,
    GL_SOFTLIGHT_KHR                  = 0x929C,
    GL_DIFFERENCE_KHR                 = 0x929E,
    GL_EXCLUSION_KHR                  = 0x92A0,
    GL_HSL_HUE_KHR                    = 0x92AD,
    GL_HSL_SATURATION_KHR             = 0x92AE,
    GL_HSL_COLOR_KHR                  = 0x92AF,
    GL_HSL_LUMINOSITY_KHR             = 0x92B0
};
typedef void (* PFNGLBLENDBARRIERKHRPROC) (void);
void glBlendBarrierKHR (void);

enum {
    GL_KHR_blend_equation_advanced_coherent = 1,
    GL_BLEND_ADVANCED_COHERENT_KHR    = 0x9285
};

enum { GL_KHR_context_flush_control = 1 };
enum { GL_KHR_debug = 1 };
enum {
    GL_KHR_no_error = 1,
    GL_CONTEXT_FLAG_NO_ERROR_BIT_KHR  = 0x00000008
};

enum {
    GL_KHR_parallel_shader_compile = 1,
    GL_MAX_SHADER_COMPILER_THREADS_KHR = 0x91B0,
    GL_COMPLETION_STATUS_KHR          = 0x91B1
};
typedef void (* PFNGLMAXSHADERCOMPILERTHREADSKHRPROC) (GLuint count);
void glMaxShaderCompilerThreadsKHR (GLuint count);

enum { GL_KHR_robust_buffer_access_behavior = 1 };
enum {
    GL_KHR_robustness = 1,
    GL_CONTEXT_ROBUST_ACCESS          = 0x90F3
};

enum {
    GL_KHR_shader_subgroup = 1,
    GL_SUBGROUP_SIZE_KHR              = 0x9532,
    GL_SUBGROUP_SUPPORTED_STAGES_KHR  = 0x9533,
    GL_SUBGROUP_SUPPORTED_FEATURES_KHR = 0x9534,
    GL_SUBGROUP_QUAD_ALL_STAGES_KHR   = 0x9535,
    GL_SUBGROUP_FEATURE_BASIC_BIT_KHR = 0x00000001,
    GL_SUBGROUP_FEATURE_VOTE_BIT_KHR  = 0x00000002,
    GL_SUBGROUP_FEATURE_ARITHMETIC_BIT_KHR = 0x00000004,
    GL_SUBGROUP_FEATURE_BALLOT_BIT_KHR = 0x00000008,
    GL_SUBGROUP_FEATURE_SHUFFLE_BIT_KHR = 0x00000010,
    GL_SUBGROUP_FEATURE_SHUFFLE_RELATIVE_BIT_KHR = 0x00000020,
    GL_SUBGROUP_FEATURE_CLUSTERED_BIT_KHR = 0x00000040,
    GL_SUBGROUP_FEATURE_QUAD_BIT_KHR  = 0x00000080
};

enum {
    GL_KHR_texture_compression_astc_hdr = 1,
    GL_COMPRESSED_RGBA_ASTC_4x4_KHR   = 0x93B0,
    GL_COMPRESSED_RGBA_ASTC_5x4_KHR   = 0x93B1,
    GL_COMPRESSED_RGBA_ASTC_5x5_KHR   = 0x93B2,
    GL_COMPRESSED_RGBA_ASTC_6x5_KHR   = 0x93B3,
    GL_COMPRESSED_RGBA_ASTC_6x6_KHR   = 0x93B4,
    GL_COMPRESSED_RGBA_ASTC_8x5_KHR   = 0x93B5,
    GL_COMPRESSED_RGBA_ASTC_8x6_KHR   = 0x93B6,
    GL_COMPRESSED_RGBA_ASTC_8x8_KHR   = 0x93B7,
    GL_COMPRESSED_RGBA_ASTC_10x5_KHR  = 0x93B8,
    GL_COMPRESSED_RGBA_ASTC_10x6_KHR  = 0x93B9,
    GL_COMPRESSED_RGBA_ASTC_10x8_KHR  = 0x93BA,
    GL_COMPRESSED_RGBA_ASTC_10x10_KHR = 0x93BB,
    GL_COMPRESSED_RGBA_ASTC_12x10_KHR = 0x93BC,
    GL_COMPRESSED_RGBA_ASTC_12x12_KHR = 0x93BD,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR = 0x93D0,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR = 0x93D1,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR = 0x93D2,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR = 0x93D3,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR = 0x93D4,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR = 0x93D5,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR = 0x93D6,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR = 0x93D7,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR = 0x93D8,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR = 0x93D9,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR = 0x93DA,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR = 0x93DB,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR = 0x93DC,
    GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR = 0x93DD
};

enum { GL_KHR_texture_compression_astc_ldr = 1 };
enum { GL_KHR_texture_compression_astc_sliced_3d = 1 };
enum {
    GL_AMD_framebuffer_multisample_advanced = 1,
    GL_RENDERBUFFER_STORAGE_SAMPLES_AMD = 0x91B2,
    GL_MAX_COLOR_FRAMEBUFFER_SAMPLES_AMD = 0x91B3,
    GL_MAX_COLOR_FRAMEBUFFER_STORAGE_SAMPLES_AMD = 0x91B4,
    GL_MAX_DEPTH_STENCIL_FRAMEBUFFER_SAMPLES_AMD = 0x91B5,
    GL_NUM_SUPPORTED_MULTISAMPLE_MODES_AMD = 0x91B6,
    GL_SUPPORTED_MULTISAMPLE_MODES_AMD = 0x91B7
};
typedef void (* PFNGLRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC) (GLenum target, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEADVANCEDAMDPROC) (GLuint renderbuffer, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);
void glRenderbufferStorageMultisampleAdvancedAMD (GLenum target, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);
void glNamedRenderbufferStorageMultisampleAdvancedAMD (GLuint renderbuffer, GLsizei samples, GLsizei storageSamples, GLenum internalformat, GLsizei width, GLsizei height);

enum {
    GL_AMD_performance_monitor        = 1,
    GL_COUNTER_TYPE_AMD               = 0x8BC0,
    GL_COUNTER_RANGE_AMD              = 0x8BC1,
    GL_UNSIGNED_INT64_AMD             = 0x8BC2,
    GL_PERCENTAGE_AMD                 = 0x8BC3,
    GL_PERFMON_RESULT_AVAILABLE_AMD   = 0x8BC4,
    GL_PERFMON_RESULT_SIZE_AMD        = 0x8BC5,
    GL_PERFMON_RESULT_AMD             = 0x8BC6
};
typedef void (* PFNGLGETPERFMONITORGROUPSAMDPROC) (GLint *numGroups, GLsizei groupsSize, GLuint *groups);
typedef void (* PFNGLGETPERFMONITORCOUNTERSAMDPROC) (GLuint group, GLint *numCounters, GLint *maxActiveCounters, GLsizei counterSize, GLuint *counters);
typedef void (* PFNGLGETPERFMONITORGROUPSTRINGAMDPROC) (GLuint group, GLsizei bufSize, GLsizei *length, GLchar *groupString);
typedef void (* PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC) (GLuint group, GLuint counter, GLsizei bufSize, GLsizei *length, GLchar *counterString);
typedef void (* PFNGLGETPERFMONITORCOUNTERINFOAMDPROC) (GLuint group, GLuint counter, GLenum pname, void *data);
typedef void (* PFNGLGENPERFMONITORSAMDPROC) (GLsizei n, GLuint *monitors);
typedef void (* PFNGLDELETEPERFMONITORSAMDPROC) (GLsizei n, GLuint *monitors);
typedef void (* PFNGLSELECTPERFMONITORCOUNTERSAMDPROC) (GLuint monitor, GLboolean enable, GLuint group, GLint numCounters, GLuint *counterList);
typedef void (* PFNGLBEGINPERFMONITORAMDPROC) (GLuint monitor);
typedef void (* PFNGLENDPERFMONITORAMDPROC) (GLuint monitor);
typedef void (* PFNGLGETPERFMONITORCOUNTERDATAAMDPROC) (GLuint monitor, GLenum pname, GLsizei dataSize, GLuint *data, GLint *bytesWritten);

void glGetPerfMonitorGroupsAMD (GLint *numGroups, GLsizei groupsSize, GLuint *groups);
void glGetPerfMonitorCountersAMD (GLuint group, GLint *numCounters, GLint *maxActiveCounters, GLsizei counterSize, GLuint *counters);
void glGetPerfMonitorGroupStringAMD (GLuint group, GLsizei bufSize, GLsizei *length, GLchar *groupString);
void glGetPerfMonitorCounterStringAMD (GLuint group, GLuint counter, GLsizei bufSize, GLsizei *length, GLchar *counterString);
void glGetPerfMonitorCounterInfoAMD (GLuint group, GLuint counter, GLenum pname, void *data);
void glGenPerfMonitorsAMD (GLsizei n, GLuint *monitors);
void glDeletePerfMonitorsAMD (GLsizei n, GLuint *monitors);
void glSelectPerfMonitorCountersAMD (GLuint monitor, GLboolean enable, GLuint group, GLint numCounters, GLuint *counterList);
void glBeginPerfMonitorAMD (GLuint monitor);
void glEndPerfMonitorAMD (GLuint monitor);
void glGetPerfMonitorCounterDataAMD (GLuint monitor, GLenum pname, GLsizei dataSize, GLuint *data, GLint *bytesWritten);

enum {
    GL_APPLE_rgb_422                  = 1,
    GL_RGB_422_APPLE                  = 0x8A1F,
    GL_UNSIGNED_SHORT_8_8_APPLE       = 0x85BA,
    GL_UNSIGNED_SHORT_8_8_REV_APPLE   = 0x85BB,
    GL_RGB_RAW_422_APPLE              = 0x8A51
};

enum { GL_EXT_EGL_image_storage = 1 };
typedef void *GLeglImageOES;
typedef void (* PFNGLEGLIMAGETARGETTEXSTORAGEEXTPROC) (GLenum target, GLeglImageOES image, const GLint* attrib_list);
typedef void (* PFNGLEGLIMAGETARGETTEXTURESTORAGEEXTPROC) (GLuint texture, GLeglImageOES image, const GLint* attrib_list);

void glEGLImageTargetTexStorageEXT (GLenum target, GLeglImageOES image, const GLint* attrib_list);
void glEGLImageTargetTextureStorageEXT (GLuint texture, GLeglImageOES image, const GLint* attrib_list);

enum { GL_EXT_EGL_sync = 1 };
enum {
    GL_EXT_debug_label                = 1,
    GL_PROGRAM_PIPELINE_OBJECT_EXT    = 0x8A4F,
    GL_PROGRAM_OBJECT_EXT             = 0x8B40,
    GL_SHADER_OBJECT_EXT              = 0x8B48,
    GL_BUFFER_OBJECT_EXT              = 0x9151,
    GL_QUERY_OBJECT_EXT               = 0x9153,
    GL_VERTEX_ARRAY_OBJECT_EXT        = 0x9154
};
typedef void (* PFNGLLABELOBJECTEXTPROC) (GLenum type, GLuint object, GLsizei length, const GLchar *label);
typedef void (* PFNGLGETOBJECTLABELEXTPROC) (GLenum type, GLuint object, GLsizei bufSize, GLsizei *length, GLchar *label);
void glLabelObjectEXT (GLenum type, GLuint object, GLsizei length, const GLchar *label);
void glGetObjectLabelEXT (GLenum type, GLuint object, GLsizei bufSize, GLsizei *length, GLchar *label);

enum { GL_EXT_debug_marker = 1 };
typedef void (* PFNGLINSERTEVENTMARKEREXTPROC) (GLsizei length, const GLchar *marker);
typedef void (* PFNGLPUSHGROUPMARKEREXTPROC) (GLsizei length, const GLchar *marker);
typedef void (* PFNGLPOPGROUPMARKEREXTPROC) (void);
void glInsertEventMarkerEXT (GLsizei length, const GLchar *marker);
void glPushGroupMarkerEXT (GLsizei length, const GLchar *marker);
void glPopGroupMarkerEXT (void);

enum {
    GL_EXT_direct_state_access        = 1,
    GL_PROGRAM_MATRIX_EXT             = 0x8E2D,
    GL_TRANSPOSE_PROGRAM_MATRIX_EXT   = 0x8E2E,
    GL_PROGRAM_MATRIX_STACK_DEPTH_EXT = 0x8E2F
};
typedef void (* PFNGLMATRIXLOADFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void (* PFNGLMATRIXLOADDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void (* PFNGLMATRIXMULTFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void (* PFNGLMATRIXMULTDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void (* PFNGLMATRIXLOADIDENTITYEXTPROC) (GLenum mode);
typedef void (* PFNGLMATRIXROTATEFEXTPROC) (GLenum mode, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
typedef void (* PFNGLMATRIXROTATEDEXTPROC) (GLenum mode, GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLMATRIXSCALEFEXTPROC) (GLenum mode, GLfloat x, GLfloat y, GLfloat z);
typedef void (* PFNGLMATRIXSCALEDEXTPROC) (GLenum mode, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLMATRIXTRANSLATEFEXTPROC) (GLenum mode, GLfloat x, GLfloat y, GLfloat z);
typedef void (* PFNGLMATRIXTRANSLATEDEXTPROC) (GLenum mode, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLMATRIXFRUSTUMEXTPROC) (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
typedef void (* PFNGLMATRIXORTHOEXTPROC) (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
typedef void (* PFNGLMATRIXPOPEXTPROC) (GLenum mode);
typedef void (* PFNGLMATRIXPUSHEXTPROC) (GLenum mode);
typedef void (* PFNGLCLIENTATTRIBDEFAULTEXTPROC) (GLbitfield mask);
typedef void (* PFNGLPUSHCLIENTATTRIBDEFAULTEXTPROC) (GLbitfield mask);
typedef void (* PFNGLTEXTUREPARAMETERFEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLfloat param);
typedef void (* PFNGLTEXTUREPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLfloat *params);
typedef void (* PFNGLTEXTUREPARAMETERIEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLTEXTUREPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLCOPYTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void (* PFNGLCOPYTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void (* PFNGLCOPYTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLCOPYTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLGETTEXTUREIMAGEEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);
typedef void (* PFNGLGETTEXTUREPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETTEXTUREPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXTURELEVELPARAMETERFVEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETTEXTURELEVELPARAMETERIVEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum pname, GLint *params);
typedef void (* PFNGLTEXTUREIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLCOPYTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLBINDMULTITEXTUREEXTPROC) (GLenum texunit, GLenum target, GLuint texture);
typedef void (* PFNGLMULTITEXCOORDPOINTEREXTPROC) (GLenum texunit, GLint size, GLenum type, GLsizei stride, const void *pointer);
typedef void (* PFNGLMULTITEXENVFEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat param);
typedef void (* PFNGLMULTITEXENVFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);
typedef void (* PFNGLMULTITEXENVIEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLMULTITEXENVIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLMULTITEXGENDEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLdouble param);
typedef void (* PFNGLMULTITEXGENDVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLdouble *params);
typedef void (* PFNGLMULTITEXGENFEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLfloat param);
typedef void (* PFNGLMULTITEXGENFVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLfloat *params);
typedef void (* PFNGLMULTITEXGENIEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLint param);
typedef void (* PFNGLMULTITEXGENIVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, const GLint *params);
typedef void (* PFNGLGETMULTITEXENVFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETMULTITEXENVIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETMULTITEXGENDVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLdouble *params);
typedef void (* PFNGLGETMULTITEXGENFVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETMULTITEXGENIVEXTPROC) (GLenum texunit, GLenum coord, GLenum pname, GLint *params);
typedef void (* PFNGLMULTITEXPARAMETERIEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLMULTITEXPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLMULTITEXPARAMETERFEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat param);
typedef void (* PFNGLMULTITEXPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);
typedef void (* PFNGLMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLCOPYMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void (* PFNGLCOPYMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void (* PFNGLCOPYMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLCOPYMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLGETMULTITEXIMAGEEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);
typedef void (* PFNGLGETMULTITEXPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETMULTITEXPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETMULTITEXLEVELPARAMETERFVEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETMULTITEXLEVELPARAMETERIVEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum pname, GLint *params);
typedef void (* PFNGLMULTITEXIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
typedef void (* PFNGLCOPYMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLENABLECLIENTSTATEINDEXEDEXTPROC) (GLenum array, GLuint index);
typedef void (* PFNGLDISABLECLIENTSTATEINDEXEDEXTPROC) (GLenum array, GLuint index);
typedef void (* PFNGLGETFLOATINDEXEDVEXTPROC) (GLenum target, GLuint index, GLfloat *data);
typedef void (* PFNGLGETDOUBLEINDEXEDVEXTPROC) (GLenum target, GLuint index, GLdouble *data);
typedef void (* PFNGLGETPOINTERINDEXEDVEXTPROC) (GLenum target, GLuint index, void **data);
typedef void (* PFNGLENABLEINDEXEDEXTPROC) (GLenum target, GLuint index);
typedef void (* PFNGLDISABLEINDEXEDEXTPROC) (GLenum target, GLuint index);
typedef GLboolean (* PFNGLISENABLEDINDEXEDEXTPROC) (GLenum target, GLuint index);
typedef void (* PFNGLGETINTEGERINDEXEDVEXTPROC) (GLenum target, GLuint index, GLint *data);
typedef void (* PFNGLGETBOOLEANINDEXEDVEXTPROC) (GLenum target, GLuint index, GLboolean *data);
typedef void (* PFNGLCOMPRESSEDTEXTUREIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDTEXTUREIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDTEXTUREIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDTEXTURESUBIMAGE3DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDTEXTURESUBIMAGE2DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDTEXTURESUBIMAGE1DEXTPROC) (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);
typedef void (* PFNGLGETCOMPRESSEDTEXTUREIMAGEEXTPROC) (GLuint texture, GLenum target, GLint lod, void *img);
typedef void (* PFNGLCOMPRESSEDMULTITEXIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDMULTITEXIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDMULTITEXIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDMULTITEXSUBIMAGE3DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDMULTITEXSUBIMAGE2DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);
typedef void (* PFNGLCOMPRESSEDMULTITEXSUBIMAGE1DEXTPROC) (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);
typedef void (* PFNGLGETCOMPRESSEDMULTITEXIMAGEEXTPROC) (GLenum texunit, GLenum target, GLint lod, void *img);
typedef void (* PFNGLMATRIXLOADTRANSPOSEFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void (* PFNGLMATRIXLOADTRANSPOSEDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void (* PFNGLMATRIXMULTTRANSPOSEFEXTPROC) (GLenum mode, const GLfloat *m);
typedef void (* PFNGLMATRIXMULTTRANSPOSEDEXTPROC) (GLenum mode, const GLdouble *m);
typedef void (* PFNGLNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);
typedef void (* PFNGLNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
typedef void *(* PFNGLMAPNAMEDBUFFEREXTPROC) (GLuint buffer, GLenum access);
typedef GLboolean (* PFNGLUNMAPNAMEDBUFFEREXTPROC) (GLuint buffer);
typedef void (* PFNGLGETNAMEDBUFFERPARAMETERIVEXTPROC) (GLuint buffer, GLenum pname, GLint *params);
typedef void (* PFNGLGETNAMEDBUFFERPOINTERVEXTPROC) (GLuint buffer, GLenum pname, void **params);
typedef void (* PFNGLGETNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);
typedef void (* PFNGLPROGRAMUNIFORM1FEXTPROC) (GLuint program, GLint location, GLfloat v0);
typedef void (* PFNGLPROGRAMUNIFORM2FEXTPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1);
typedef void (* PFNGLPROGRAMUNIFORM3FEXTPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void (* PFNGLPROGRAMUNIFORM4FEXTPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void (* PFNGLPROGRAMUNIFORM1IEXTPROC) (GLuint program, GLint location, GLint v0);
typedef void (* PFNGLPROGRAMUNIFORM2IEXTPROC) (GLuint program, GLint location, GLint v0, GLint v1);
typedef void (* PFNGLPROGRAMUNIFORM3IEXTPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
typedef void (* PFNGLPROGRAMUNIFORM4IEXTPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void (* PFNGLPROGRAMUNIFORM1FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM2FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM3FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM4FVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM1IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM2IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM3IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM4IVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X3FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X2FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X4FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X2FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X4FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X3FVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLTEXTUREBUFFEREXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer);
typedef void (* PFNGLMULTITEXBUFFEREXTPROC) (GLenum texunit, GLenum target, GLenum internalformat, GLuint buffer);
typedef void (* PFNGLTEXTUREPARAMETERIIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLTEXTUREPARAMETERIUIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, const GLuint *params);
typedef void (* PFNGLGETTEXTUREPARAMETERIIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXTUREPARAMETERIUIVEXTPROC) (GLuint texture, GLenum target, GLenum pname, GLuint *params);
typedef void (* PFNGLMULTITEXPARAMETERIIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLMULTITEXPARAMETERIUIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, const GLuint *params);
typedef void (* PFNGLGETMULTITEXPARAMETERIIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETMULTITEXPARAMETERIUIVEXTPROC) (GLenum texunit, GLenum target, GLenum pname, GLuint *params);
typedef void (* PFNGLPROGRAMUNIFORM1UIEXTPROC) (GLuint program, GLint location, GLuint v0);
typedef void (* PFNGLPROGRAMUNIFORM2UIEXTPROC) (GLuint program, GLint location, GLuint v0, GLuint v1);
typedef void (* PFNGLPROGRAMUNIFORM3UIEXTPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void (* PFNGLPROGRAMUNIFORM4UIEXTPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void (* PFNGLPROGRAMUNIFORM1UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM2UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM3UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM4UIVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERS4FVEXTPROC) (GLuint program, GLenum target, GLuint index, GLsizei count, const GLfloat *params);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERI4IEXTPROC) (GLuint program, GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERI4IVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLint *params);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERSI4IVEXTPROC) (GLuint program, GLenum target, GLuint index, GLsizei count, const GLint *params);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIEXTPROC) (GLuint program, GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERI4UIVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLuint *params);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETERSI4UIVEXTPROC) (GLuint program, GLenum target, GLuint index, GLsizei count, const GLuint *params);
typedef void (* PFNGLGETNAMEDPROGRAMLOCALPARAMETERIIVEXTPROC) (GLuint program, GLenum target, GLuint index, GLint *params);
typedef void (* PFNGLGETNAMEDPROGRAMLOCALPARAMETERIUIVEXTPROC) (GLuint program, GLenum target, GLuint index, GLuint *params);
typedef void (* PFNGLENABLECLIENTSTATEIEXTPROC) (GLenum array, GLuint index);
typedef void (* PFNGLDISABLECLIENTSTATEIEXTPROC) (GLenum array, GLuint index);
typedef void (* PFNGLGETFLOATI_VEXTPROC) (GLenum pname, GLuint index, GLfloat *params);
typedef void (* PFNGLGETDOUBLEI_VEXTPROC) (GLenum pname, GLuint index, GLdouble *params);
typedef void (* PFNGLGETPOINTERI_VEXTPROC) (GLenum pname, GLuint index, void **params);
typedef void (* PFNGLNAMEDPROGRAMSTRINGEXTPROC) (GLuint program, GLenum target, GLenum format, GLsizei len, const void *string);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETER4DEXTPROC) (GLuint program, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETER4DVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLdouble *params);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETER4FEXTPROC) (GLuint program, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* PFNGLNAMEDPROGRAMLOCALPARAMETER4FVEXTPROC) (GLuint program, GLenum target, GLuint index, const GLfloat *params);
typedef void (* PFNGLGETNAMEDPROGRAMLOCALPARAMETERDVEXTPROC) (GLuint program, GLenum target, GLuint index, GLdouble *params);
typedef void (* PFNGLGETNAMEDPROGRAMLOCALPARAMETERFVEXTPROC) (GLuint program, GLenum target, GLuint index, GLfloat *params);
typedef void (* PFNGLGETNAMEDPROGRAMIVEXTPROC) (GLuint program, GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETNAMEDPROGRAMSTRINGEXTPROC) (GLuint program, GLenum target, GLenum pname, void *string);
typedef void (* PFNGLNAMEDRENDERBUFFERSTORAGEEXTPROC) (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLGETNAMEDRENDERBUFFERPARAMETERIVEXTPROC) (GLuint renderbuffer, GLenum pname, GLint *params);
typedef void (* PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLEEXTPROC) (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLNAMEDRENDERBUFFERSTORAGEMULTISAMPLECOVERAGEEXTPROC) (GLuint renderbuffer, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);
typedef GLenum (* PFNGLCHECKNAMEDFRAMEBUFFERSTATUSEXTPROC) (GLuint framebuffer, GLenum target);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTURE1DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTURE2DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTURE3DEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void (* PFNGLNAMEDFRAMEBUFFERRENDERBUFFEREXTPROC) (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void (* PFNGLGETNAMEDFRAMEBUFFERATTACHMENTPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);
typedef void (* PFNGLGENERATETEXTUREMIPMAPEXTPROC) (GLuint texture, GLenum target);
typedef void (* PFNGLGENERATEMULTITEXMIPMAPEXTPROC) (GLenum texunit, GLenum target);
typedef void (* PFNGLFRAMEBUFFERDRAWBUFFEREXTPROC) (GLuint framebuffer, GLenum mode);
typedef void (* PFNGLFRAMEBUFFERDRAWBUFFERSEXTPROC) (GLuint framebuffer, GLsizei n, const GLenum *bufs);
typedef void (* PFNGLFRAMEBUFFERREADBUFFEREXTPROC) (GLuint framebuffer, GLenum mode);
typedef void (* PFNGLGETFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params);
typedef void (* PFNGLNAMEDCOPYBUFFERSUBDATAEXTPROC) (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTUREEXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTURELAYEREXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef void (* PFNGLNAMEDFRAMEBUFFERTEXTUREFACEEXTPROC) (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLenum face);
typedef void (* PFNGLTEXTURERENDERBUFFEREXTPROC) (GLuint texture, GLenum target, GLuint renderbuffer);
typedef void (* PFNGLMULTITEXRENDERBUFFEREXTPROC) (GLenum texunit, GLenum target, GLuint renderbuffer);
typedef void (* PFNGLVERTEXARRAYVERTEXOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYCOLOROFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYEDGEFLAGOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYINDEXOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYNORMALOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYTEXCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYMULTITEXCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum texunit, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYFOGCOORDOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYSECONDARYCOLOROFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLintptr offset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBIOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLENABLEVERTEXARRAYEXTPROC) (GLuint vaobj, GLenum array);
typedef void (* PFNGLDISABLEVERTEXARRAYEXTPROC) (GLuint vaobj, GLenum array);
typedef void (* PFNGLENABLEVERTEXARRAYATTRIBEXTPROC) (GLuint vaobj, GLuint index);
typedef void (* PFNGLDISABLEVERTEXARRAYATTRIBEXTPROC) (GLuint vaobj, GLuint index);
typedef void (* PFNGLGETVERTEXARRAYINTEGERVEXTPROC) (GLuint vaobj, GLenum pname, GLint *param);
typedef void (* PFNGLGETVERTEXARRAYPOINTERVEXTPROC) (GLuint vaobj, GLenum pname, void **param);
typedef void (* PFNGLGETVERTEXARRAYINTEGERI_VEXTPROC) (GLuint vaobj, GLuint index, GLenum pname, GLint *param);
typedef void (* PFNGLGETVERTEXARRAYPOINTERI_VEXTPROC) (GLuint vaobj, GLuint index, GLenum pname, void **param);
typedef void *(* PFNGLMAPNAMEDBUFFERRANGEEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef void (* PFNGLFLUSHMAPPEDNAMEDBUFFERRANGEEXTPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void (* PFNGLNAMEDBUFFERSTORAGEEXTPROC) (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);
typedef void (* PFNGLCLEARNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLsizeiptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC) (GLuint framebuffer, GLenum pname, GLint param);
typedef void (* PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params);
typedef void (* PFNGLPROGRAMUNIFORM1DEXTPROC) (GLuint program, GLint location, GLdouble x);
typedef void (* PFNGLPROGRAMUNIFORM2DEXTPROC) (GLuint program, GLint location, GLdouble x, GLdouble y);
typedef void (* PFNGLPROGRAMUNIFORM3DEXTPROC) (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLPROGRAMUNIFORM4DEXTPROC) (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLPROGRAMUNIFORM1DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM2DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM3DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM4DVEXTPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X3DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X4DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X2DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X4DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X2DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X3DVEXTPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLTEXTUREBUFFERRANGEEXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLTEXTURESTORAGE1DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void (* PFNGLTEXTURESTORAGE2DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXTURESTORAGE3DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
typedef void (* PFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBLOFFSETEXTPROC) (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);
typedef void (* PFNGLTEXTUREPAGECOMMITMENTEXTPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBDIVISOREXTPROC) (GLuint vaobj, GLuint index, GLuint divisor);

void glMatrixLoadfEXT (GLenum mode, const GLfloat *m);
void glMatrixLoaddEXT (GLenum mode, const GLdouble *m);
void glMatrixMultfEXT (GLenum mode, const GLfloat *m);
void glMatrixMultdEXT (GLenum mode, const GLdouble *m);
void glMatrixLoadIdentityEXT (GLenum mode);
void glMatrixRotatefEXT (GLenum mode, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
void glMatrixRotatedEXT (GLenum mode, GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
void glMatrixScalefEXT (GLenum mode, GLfloat x, GLfloat y, GLfloat z);
void glMatrixScaledEXT (GLenum mode, GLdouble x, GLdouble y, GLdouble z);
void glMatrixTranslatefEXT (GLenum mode, GLfloat x, GLfloat y, GLfloat z);
void glMatrixTranslatedEXT (GLenum mode, GLdouble x, GLdouble y, GLdouble z);
void glMatrixFrustumEXT (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
void glMatrixOrthoEXT (GLenum mode, GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar);
void glMatrixPopEXT (GLenum mode);
void glMatrixPushEXT (GLenum mode);
void glClientAttribDefaultEXT (GLbitfield mask);
void glPushClientAttribDefaultEXT (GLbitfield mask);
void glTextureParameterfEXT (GLuint texture, GLenum target, GLenum pname, GLfloat param);
void glTextureParameterfvEXT (GLuint texture, GLenum target, GLenum pname, const GLfloat *params);
void glTextureParameteriEXT (GLuint texture, GLenum target, GLenum pname, GLint param);
void glTextureParameterivEXT (GLuint texture, GLenum target, GLenum pname, const GLint *params);
void glTextureImage1DEXT (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);
void glTextureImage2DEXT (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);
void glTextureSubImage1DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
void glTextureSubImage2DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
void glCopyTextureImage1DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
void glCopyTextureImage2DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
void glCopyTextureSubImage1DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
void glCopyTextureSubImage2DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glGetTextureImageEXT (GLuint texture, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);
void glGetTextureParameterfvEXT (GLuint texture, GLenum target, GLenum pname, GLfloat *params);
void glGetTextureParameterivEXT (GLuint texture, GLenum target, GLenum pname, GLint *params);
void glGetTextureLevelParameterfvEXT (GLuint texture, GLenum target, GLint level, GLenum pname, GLfloat *params);
void glGetTextureLevelParameterivEXT (GLuint texture, GLenum target, GLint level, GLenum pname, GLint *params);
void glTextureImage3DEXT (GLuint texture, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
void glTextureSubImage3DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
void glCopyTextureSubImage3DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glBindMultiTextureEXT (GLenum texunit, GLenum target, GLuint texture);
void glMultiTexCoordPointerEXT (GLenum texunit, GLint size, GLenum type, GLsizei stride, const void *pointer);
void glMultiTexEnvfEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat param);
void glMultiTexEnvfvEXT (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);
void glMultiTexEnviEXT (GLenum texunit, GLenum target, GLenum pname, GLint param);
void glMultiTexEnvivEXT (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
void glMultiTexGendEXT (GLenum texunit, GLenum coord, GLenum pname, GLdouble param);
void glMultiTexGendvEXT (GLenum texunit, GLenum coord, GLenum pname, const GLdouble *params);
void glMultiTexGenfEXT (GLenum texunit, GLenum coord, GLenum pname, GLfloat param);
void glMultiTexGenfvEXT (GLenum texunit, GLenum coord, GLenum pname, const GLfloat *params);
void glMultiTexGeniEXT (GLenum texunit, GLenum coord, GLenum pname, GLint param);
void glMultiTexGenivEXT (GLenum texunit, GLenum coord, GLenum pname, const GLint *params);
void glGetMultiTexEnvfvEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);
void glGetMultiTexEnvivEXT (GLenum texunit, GLenum target, GLenum pname, GLint *params);
void glGetMultiTexGendvEXT (GLenum texunit, GLenum coord, GLenum pname, GLdouble *params);
void glGetMultiTexGenfvEXT (GLenum texunit, GLenum coord, GLenum pname, GLfloat *params);
void glGetMultiTexGenivEXT (GLenum texunit, GLenum coord, GLenum pname, GLint *params);
void glMultiTexParameteriEXT (GLenum texunit, GLenum target, GLenum pname, GLint param);
void glMultiTexParameterivEXT (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
void glMultiTexParameterfEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat param);
void glMultiTexParameterfvEXT (GLenum texunit, GLenum target, GLenum pname, const GLfloat *params);
void glMultiTexImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const void *pixels);
void glMultiTexImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const void *pixels);
void glMultiTexSubImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const void *pixels);
void glMultiTexSubImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
void glCopyMultiTexImage1DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
void glCopyMultiTexImage2DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
void glCopyMultiTexSubImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
void glCopyMultiTexSubImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glGetMultiTexImageEXT (GLenum texunit, GLenum target, GLint level, GLenum format, GLenum type, void *pixels);
void glGetMultiTexParameterfvEXT (GLenum texunit, GLenum target, GLenum pname, GLfloat *params);
void glGetMultiTexParameterivEXT (GLenum texunit, GLenum target, GLenum pname, GLint *params);
void glGetMultiTexLevelParameterfvEXT (GLenum texunit, GLenum target, GLint level, GLenum pname, GLfloat *params);
void glGetMultiTexLevelParameterivEXT (GLenum texunit, GLenum target, GLint level, GLenum pname, GLint *params);
void glMultiTexImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const void *pixels);
void glMultiTexSubImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *pixels);
void glCopyMultiTexSubImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
void glEnableClientStateIndexedEXT (GLenum array, GLuint index);
void glDisableClientStateIndexedEXT (GLenum array, GLuint index);
void glGetFloatIndexedvEXT (GLenum target, GLuint index, GLfloat *data);
void glGetDoubleIndexedvEXT (GLenum target, GLuint index, GLdouble *data);
void glGetPointerIndexedvEXT (GLenum target, GLuint index, void **data);
void glEnableIndexedEXT (GLenum target, GLuint index);
void glDisableIndexedEXT (GLenum target, GLuint index);
GLboolean glIsEnabledIndexedEXT (GLenum target, GLuint index);
void glGetIntegerIndexedvEXT (GLenum target, GLuint index, GLint *data);
void glGetBooleanIndexedvEXT (GLenum target, GLuint index, GLboolean *data);
void glCompressedTextureImage3DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);
void glCompressedTextureImage2DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);
void glCompressedTextureImage1DEXT (GLuint texture, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);
void glCompressedTextureSubImage3DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);
void glCompressedTextureSubImage2DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);
void glCompressedTextureSubImage1DEXT (GLuint texture, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);
void glGetCompressedTextureImageEXT (GLuint texture, GLenum target, GLint lod, void *img);
void glCompressedMultiTexImage3DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const void *bits);
void glCompressedMultiTexImage2DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const void *bits);
void glCompressedMultiTexImage1DEXT (GLenum texunit, GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const void *bits);
void glCompressedMultiTexSubImage3DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const void *bits);
void glCompressedMultiTexSubImage2DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const void *bits);
void glCompressedMultiTexSubImage1DEXT (GLenum texunit, GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const void *bits);
void glGetCompressedMultiTexImageEXT (GLenum texunit, GLenum target, GLint lod, void *img);
void glMatrixLoadTransposefEXT (GLenum mode, const GLfloat *m);
void glMatrixLoadTransposedEXT (GLenum mode, const GLdouble *m);
void glMatrixMultTransposefEXT (GLenum mode, const GLfloat *m);
void glMatrixMultTransposedEXT (GLenum mode, const GLdouble *m);
void glNamedBufferDataEXT (GLuint buffer, GLsizeiptr size, const void *data, GLenum usage);
void glNamedBufferSubDataEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, const void *data);
void *glMapNamedBufferEXT (GLuint buffer, GLenum access);
GLboolean glUnmapNamedBufferEXT (GLuint buffer);
void glGetNamedBufferParameterivEXT (GLuint buffer, GLenum pname, GLint *params);
void glGetNamedBufferPointervEXT (GLuint buffer, GLenum pname, void **params);
void glGetNamedBufferSubDataEXT (GLuint buffer, GLintptr offset, GLsizeiptr size, void *data);
void glProgramUniform1fEXT (GLuint program, GLint location, GLfloat v0);
void glProgramUniform2fEXT (GLuint program, GLint location, GLfloat v0, GLfloat v1);
void glProgramUniform3fEXT (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
void glProgramUniform4fEXT (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
void glProgramUniform1iEXT (GLuint program, GLint location, GLint v0);
void glProgramUniform2iEXT (GLuint program, GLint location, GLint v0, GLint v1);
void glProgramUniform3iEXT (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
void glProgramUniform4iEXT (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
void glProgramUniform1fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform2fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform3fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform4fvEXT (GLuint program, GLint location, GLsizei count, const GLfloat *value);
void glProgramUniform1ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform2ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform3ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniform4ivEXT (GLuint program, GLint location, GLsizei count, const GLint *value);
void glProgramUniformMatrix2fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix3fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix4fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix2x3fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix3x2fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix2x4fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix4x2fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix3x4fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glProgramUniformMatrix4x3fvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glTextureBufferEXT (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer);
void glMultiTexBufferEXT (GLenum texunit, GLenum target, GLenum internalformat, GLuint buffer);
void glTextureParameterIivEXT (GLuint texture, GLenum target, GLenum pname, const GLint *params);
void glTextureParameterIuivEXT (GLuint texture, GLenum target, GLenum pname, const GLuint *params);
void glGetTextureParameterIivEXT (GLuint texture, GLenum target, GLenum pname, GLint *params);
void glGetTextureParameterIuivEXT (GLuint texture, GLenum target, GLenum pname, GLuint *params);
void glMultiTexParameterIivEXT (GLenum texunit, GLenum target, GLenum pname, const GLint *params);
void glMultiTexParameterIuivEXT (GLenum texunit, GLenum target, GLenum pname, const GLuint *params);
void glGetMultiTexParameterIivEXT (GLenum texunit, GLenum target, GLenum pname, GLint *params);
void glGetMultiTexParameterIuivEXT (GLenum texunit, GLenum target, GLenum pname, GLuint *params);
void glProgramUniform1uiEXT (GLuint program, GLint location, GLuint v0);
void glProgramUniform2uiEXT (GLuint program, GLint location, GLuint v0, GLuint v1);
void glProgramUniform3uiEXT (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
void glProgramUniform4uiEXT (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
void glProgramUniform1uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniform2uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniform3uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glProgramUniform4uivEXT (GLuint program, GLint location, GLsizei count, const GLuint *value);
void glNamedProgramLocalParameters4fvEXT (GLuint program, GLenum target, GLuint index, GLsizei count, const GLfloat *params);
void glNamedProgramLocalParameterI4iEXT (GLuint program, GLenum target, GLuint index, GLint x, GLint y, GLint z, GLint w);
void glNamedProgramLocalParameterI4ivEXT (GLuint program, GLenum target, GLuint index, const GLint *params);
void glNamedProgramLocalParametersI4ivEXT (GLuint program, GLenum target, GLuint index, GLsizei count, const GLint *params);
void glNamedProgramLocalParameterI4uiEXT (GLuint program, GLenum target, GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
void glNamedProgramLocalParameterI4uivEXT (GLuint program, GLenum target, GLuint index, const GLuint *params);
void glNamedProgramLocalParametersI4uivEXT (GLuint program, GLenum target, GLuint index, GLsizei count, const GLuint *params);
void glGetNamedProgramLocalParameterIivEXT (GLuint program, GLenum target, GLuint index, GLint *params);
void glGetNamedProgramLocalParameterIuivEXT (GLuint program, GLenum target, GLuint index, GLuint *params);
void glEnableClientStateiEXT (GLenum array, GLuint index);
void glDisableClientStateiEXT (GLenum array, GLuint index);
void glGetFloati_vEXT (GLenum pname, GLuint index, GLfloat *params);
void glGetDoublei_vEXT (GLenum pname, GLuint index, GLdouble *params);
void glGetPointeri_vEXT (GLenum pname, GLuint index, void **params);
void glNamedProgramStringEXT (GLuint program, GLenum target, GLenum format, GLsizei len, const void *string);
void glNamedProgramLocalParameter4dEXT (GLuint program, GLenum target, GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glNamedProgramLocalParameter4dvEXT (GLuint program, GLenum target, GLuint index, const GLdouble *params);
void glNamedProgramLocalParameter4fEXT (GLuint program, GLenum target, GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
void glNamedProgramLocalParameter4fvEXT (GLuint program, GLenum target, GLuint index, const GLfloat *params);
void glGetNamedProgramLocalParameterdvEXT (GLuint program, GLenum target, GLuint index, GLdouble *params);
void glGetNamedProgramLocalParameterfvEXT (GLuint program, GLenum target, GLuint index, GLfloat *params);
void glGetNamedProgramivEXT (GLuint program, GLenum target, GLenum pname, GLint *params);
void glGetNamedProgramStringEXT (GLuint program, GLenum target, GLenum pname, void *string);
void glNamedRenderbufferStorageEXT (GLuint renderbuffer, GLenum internalformat, GLsizei width, GLsizei height);
void glGetNamedRenderbufferParameterivEXT (GLuint renderbuffer, GLenum pname, GLint *params);
void glNamedRenderbufferStorageMultisampleEXT (GLuint renderbuffer, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
void glNamedRenderbufferStorageMultisampleCoverageEXT (GLuint renderbuffer, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);
GLenum glCheckNamedFramebufferStatusEXT (GLuint framebuffer, GLenum target);
void glNamedFramebufferTexture1DEXT (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void glNamedFramebufferTexture2DEXT (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void glNamedFramebufferTexture3DEXT (GLuint framebuffer, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
void glNamedFramebufferRenderbufferEXT (GLuint framebuffer, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
void glGetNamedFramebufferAttachmentParameterivEXT (GLuint framebuffer, GLenum attachment, GLenum pname, GLint *params);
void glGenerateTextureMipmapEXT (GLuint texture, GLenum target);
void glGenerateMultiTexMipmapEXT (GLenum texunit, GLenum target);
void glFramebufferDrawBufferEXT (GLuint framebuffer, GLenum mode);
void glFramebufferDrawBuffersEXT (GLuint framebuffer, GLsizei n, const GLenum *bufs);
void glFramebufferReadBufferEXT (GLuint framebuffer, GLenum mode);
void glGetFramebufferParameterivEXT (GLuint framebuffer, GLenum pname, GLint *params);
void glNamedCopyBufferSubDataEXT (GLuint readBuffer, GLuint writeBuffer, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
void glNamedFramebufferTextureEXT (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level);
void glNamedFramebufferTextureLayerEXT (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLint layer);
void glNamedFramebufferTextureFaceEXT (GLuint framebuffer, GLenum attachment, GLuint texture, GLint level, GLenum face);
void glTextureRenderbufferEXT (GLuint texture, GLenum target, GLuint renderbuffer);
void glMultiTexRenderbufferEXT (GLenum texunit, GLenum target, GLuint renderbuffer);
void glVertexArrayVertexOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayColorOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayEdgeFlagOffsetEXT (GLuint vaobj, GLuint buffer, GLsizei stride, GLintptr offset);
void glVertexArrayIndexOffsetEXT (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayNormalOffsetEXT (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayTexCoordOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayMultiTexCoordOffsetEXT (GLuint vaobj, GLuint buffer, GLenum texunit, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayFogCoordOffsetEXT (GLuint vaobj, GLuint buffer, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArraySecondaryColorOffsetEXT (GLuint vaobj, GLuint buffer, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glVertexArrayVertexAttribOffsetEXT (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, GLintptr offset);
void glVertexArrayVertexAttribIOffsetEXT (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glEnableVertexArrayEXT (GLuint vaobj, GLenum array);
void glDisableVertexArrayEXT (GLuint vaobj, GLenum array);
void glEnableVertexArrayAttribEXT (GLuint vaobj, GLuint index);
void glDisableVertexArrayAttribEXT (GLuint vaobj, GLuint index);
void glGetVertexArrayIntegervEXT (GLuint vaobj, GLenum pname, GLint *param);
void glGetVertexArrayPointervEXT (GLuint vaobj, GLenum pname, void **param);
void glGetVertexArrayIntegeri_vEXT (GLuint vaobj, GLuint index, GLenum pname, GLint *param);
void glGetVertexArrayPointeri_vEXT (GLuint vaobj, GLuint index, GLenum pname, void **param);
void *glMapNamedBufferRangeEXT (GLuint buffer, GLintptr offset, GLsizeiptr length, GLbitfield access);
void glFlushMappedNamedBufferRangeEXT (GLuint buffer, GLintptr offset, GLsizeiptr length);
void glNamedBufferStorageEXT (GLuint buffer, GLsizeiptr size, const void *data, GLbitfield flags);
void glClearNamedBufferDataEXT (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
void glClearNamedBufferSubDataEXT (GLuint buffer, GLenum internalformat, GLsizeiptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
void glNamedFramebufferParameteriEXT (GLuint framebuffer, GLenum pname, GLint param);
void glGetNamedFramebufferParameterivEXT (GLuint framebuffer, GLenum pname, GLint *params);
void glProgramUniform1dEXT (GLuint program, GLint location, GLdouble x);
void glProgramUniform2dEXT (GLuint program, GLint location, GLdouble x, GLdouble y);
void glProgramUniform3dEXT (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z);
void glProgramUniform4dEXT (GLuint program, GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
void glProgramUniform1dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform2dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform3dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniform4dvEXT (GLuint program, GLint location, GLsizei count, const GLdouble *value);
void glProgramUniformMatrix2dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix3dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix4dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix2x3dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix2x4dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix3x2dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix3x4dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix4x2dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glProgramUniformMatrix4x3dvEXT (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
void glTextureBufferRangeEXT (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
void glTextureStorage1DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
void glTextureStorage2DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
void glTextureStorage3DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
void glTextureStorage2DMultisampleEXT (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
void glTextureStorage3DMultisampleEXT (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
void glVertexArrayBindVertexBufferEXT (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
void glVertexArrayVertexAttribFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
void glVertexArrayVertexAttribIFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
void glVertexArrayVertexAttribLFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
void glVertexArrayVertexAttribBindingEXT (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
void glVertexArrayVertexBindingDivisorEXT (GLuint vaobj, GLuint bindingindex, GLuint divisor);
void glVertexArrayVertexAttribLOffsetEXT (GLuint vaobj, GLuint buffer, GLuint index, GLint size, GLenum type, GLsizei stride, GLintptr offset);
void glTexturePageCommitmentEXT (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLboolean commit);
void glVertexArrayVertexAttribDivisorEXT (GLuint vaobj, GLuint index, GLuint divisor);


enum { GL_EXT_draw_instanced = 1 };
typedef void (* PFNGLDRAWARRAYSINSTANCEDEXTPROC) (GLenum mode, GLint start, GLsizei count, GLsizei primcount);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDEXTPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);
void glDrawArraysInstancedEXT (GLenum mode, GLint start, GLsizei count, GLsizei primcount);
void glDrawElementsInstancedEXT (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei primcount);

enum { GL_EXT_multiview_tessellation_geometry_shader = 1 };
enum { GL_EXT_multiview_texture_multisample = 1 };
enum { GL_EXT_multiview_timer_query = 1 };
enum {
    GL_EXT_polygon_offset_clamp       = 1,
    GL_POLYGON_OFFSET_CLAMP_EXT       = 0x8E1B
};
typedef void (* PFNGLPOLYGONOFFSETCLAMPEXTPROC) (GLfloat factor, GLfloat units, GLfloat clamp);
void glPolygonOffsetClampEXT (GLfloat factor, GLfloat units, GLfloat clamp);

enum { GL_EXT_post_depth_coverage = 1 };
enum {
    GL_EXT_raster_multisample         = 1,
    GL_RASTER_MULTISAMPLE_EXT         = 0x9327,
    GL_RASTER_SAMPLES_EXT             = 0x9328,
    GL_MAX_RASTER_SAMPLES_EXT         = 0x9329,
    GL_RASTER_FIXED_SAMPLE_LOCATIONS_EXT = 0x932A,
    GL_MULTISAMPLE_RASTERIZATION_ALLOWED_EXT = 0x932B,
    GL_EFFECTIVE_RASTER_SAMPLES_EXT   = 0x932C
};
typedef void (* PFNGLRASTERSAMPLESEXTPROC) (GLuint samples, GLboolean fixedsamplelocations);
void glRasterSamplesEXT (GLuint samples, GLboolean fixedsamplelocations);
enum {
    GL_EXT_separate_shader_objects    = 1,
    GL_ACTIVE_PROGRAM_EXT             = 0x8B8D
};
typedef void (* PFNGLUSESHADERPROGRAMEXTPROC) (GLenum type, GLuint program);
typedef void (* PFNGLACTIVEPROGRAMEXTPROC) (GLuint program);
typedef GLuint (* PFNGLCREATESHADERPROGRAMEXTPROC) (GLenum type, const GLchar *string);

void glUseShaderProgramEXT (GLenum type, GLuint program);
void glActiveProgramEXT (GLuint program);
GLuint glCreateShaderProgramEXT (GLenum type, const GLchar *string);
enum {
    GL_EXT_shader_framebuffer_fetch         = 1,
    GL_FRAGMENT_SHADER_DISCARDS_SAMPLES_EXT = 0x8A52
};

enum { GL_EXT_shader_framebuffer_fetch_non_coherent = 1 };
typedef void (* PFNGLFRAMEBUFFERFETCHBARRIEREXTPROC) (void);
void glFramebufferFetchBarrierEXT (void);

enum { GL_EXT_shader_integer_mix = 1 };
enum {
    GL_EXT_texture_compression_s3tc   = 1,
    GL_COMPRESSED_RGB_S3TC_DXT1_EXT   = 0x83F0,
    GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  = 0x83F1,
    GL_COMPRESSED_RGBA_S3TC_DXT3_EXT  = 0x83F2,
    GL_COMPRESSED_RGBA_S3TC_DXT5_EXT  = 0x83F3
};

enum {
    GL_EXT_texture_filter_minmax      = 1,
    GL_TEXTURE_REDUCTION_MODE_EXT     = 0x9366,
    GL_WEIGHTED_AVERAGE_EXT           = 0x9367
};

enum {
    GL_EXT_texture_sRGB_R8            = 1,
    GL_SR8_EXT                        = 0x8FBD
};

enum {
    GL_EXT_texture_sRGB_decode        = 1,
    GL_TEXTURE_SRGB_DECODE_EXT        = 0x8A48,
    GL_DECODE_EXT                     = 0x8A49,
    GL_SKIP_DECODE_EXT                = 0x8A4A
};

enum { GL_EXT_texture_shadow_lod = 1 };
enum {
    GL_EXT_window_rectangles          = 1,
    GL_INCLUSIVE_EXT                  = 0x8F10,
    GL_EXCLUSIVE_EXT                  = 0x8F11,
    GL_WINDOW_RECTANGLE_EXT           = 0x8F12,
    GL_WINDOW_RECTANGLE_MODE_EXT      = 0x8F13,
    GL_MAX_WINDOW_RECTANGLES_EXT      = 0x8F14,
    GL_NUM_WINDOW_RECTANGLES_EXT      = 0x8F15
};
typedef void (* PFNGLWINDOWRECTANGLESEXTPROC) (GLenum mode, GLsizei count, const GLint *box);
void glWindowRectanglesEXT (GLenum mode, GLsizei count, const GLint *box);

enum {
    GL_INTEL_blackhole_render         = 1,
    GL_BLACKHOLE_RENDER_INTEL         = 0x83FC
};

enum {
    GL_INTEL_conservative_rasterization = 1,
    GL_CONSERVATIVE_RASTERIZATION_INTEL = 0x83FE
};

enum { GL_INTEL_framebuffer_CMAA = 1 };
typedef void (* PFNGLAPPLYFRAMEBUFFERATTACHMENTCMAAINTELPROC) (void);
void glApplyFramebufferAttachmentCMAAINTEL (void);

enum {
    GL_INTEL_performance_query        = 1,
    GL_PERFQUERY_SINGLE_CONTEXT_INTEL = 0x00000000,
    GL_PERFQUERY_GLOBAL_CONTEXT_INTEL = 0x00000001,
    GL_PERFQUERY_WAIT_INTEL           = 0x83FB,
    GL_PERFQUERY_FLUSH_INTEL          = 0x83FA,
    GL_PERFQUERY_DONOT_FLUSH_INTEL    = 0x83F9,
    GL_PERFQUERY_COUNTER_EVENT_INTEL  = 0x94F0,
    GL_PERFQUERY_COUNTER_DURATION_NORM_INTEL = 0x94F1,
    GL_PERFQUERY_COUNTER_DURATION_RAW_INTEL = 0x94F2,
    GL_PERFQUERY_COUNTER_THROUGHPUT_INTEL = 0x94F3,
    GL_PERFQUERY_COUNTER_RAW_INTEL    = 0x94F4,
    GL_PERFQUERY_COUNTER_TIMESTAMP_INTEL = 0x94F5,
    GL_PERFQUERY_COUNTER_DATA_UINT32_INTEL = 0x94F8,
    GL_PERFQUERY_COUNTER_DATA_UINT64_INTEL = 0x94F9,
    GL_PERFQUERY_COUNTER_DATA_FLOAT_INTEL = 0x94FA,
    GL_PERFQUERY_COUNTER_DATA_DOUBLE_INTEL = 0x94FB,
    GL_PERFQUERY_COUNTER_DATA_BOOL32_INTEL = 0x94FC,
    GL_PERFQUERY_QUERY_NAME_LENGTH_MAX_INTEL = 0x94FD,
    GL_PERFQUERY_COUNTER_NAME_LENGTH_MAX_INTEL = 0x94FE,
    GL_PERFQUERY_COUNTER_DESC_LENGTH_MAX_INTEL = 0x94FF,
    GL_PERFQUERY_GPA_EXTENDED_COUNTERS_INTEL = 0x9500
};
typedef void (* PFNGLBEGINPERFQUERYINTELPROC) (GLuint queryHandle);
typedef void (* PFNGLCREATEPERFQUERYINTELPROC) (GLuint queryId, GLuint *queryHandle);
typedef void (* PFNGLDELETEPERFQUERYINTELPROC) (GLuint queryHandle);
typedef void (* PFNGLENDPERFQUERYINTELPROC) (GLuint queryHandle);
typedef void (* PFNGLGETFIRSTPERFQUERYIDINTELPROC) (GLuint *queryId);
typedef void (* PFNGLGETNEXTPERFQUERYIDINTELPROC) (GLuint queryId, GLuint *nextQueryId);
typedef void (* PFNGLGETPERFCOUNTERINFOINTELPROC) (GLuint queryId, GLuint counterId, GLuint counterNameLength, GLchar *counterName, GLuint counterDescLength, GLchar *counterDesc, GLuint *counterOffset, GLuint *counterDataSize, GLuint *counterTypeEnum, GLuint *counterDataTypeEnum, GLuint64 *rawCounterMaxValue);
typedef void (* PFNGLGETPERFQUERYDATAINTELPROC) (GLuint queryHandle, GLuint flags, GLsizei dataSize, void *data, GLuint *bytesWritten);
typedef void (* PFNGLGETPERFQUERYIDBYNAMEINTELPROC) (GLchar *queryName, GLuint *queryId);
typedef void (* PFNGLGETPERFQUERYINFOINTELPROC) (GLuint queryId, GLuint queryNameLength, GLchar *queryName, GLuint *dataSize, GLuint *noCounters, GLuint *noInstances, GLuint *capsMask);

void glBeginPerfQueryINTEL (GLuint queryHandle);
void glCreatePerfQueryINTEL (GLuint queryId, GLuint *queryHandle);
void glDeletePerfQueryINTEL (GLuint queryHandle);
void glEndPerfQueryINTEL (GLuint queryHandle);
void glGetFirstPerfQueryIdINTEL (GLuint *queryId);
void glGetNextPerfQueryIdINTEL (GLuint queryId, GLuint *nextQueryId);
void glGetPerfCounterInfoINTEL (GLuint queryId, GLuint counterId, GLuint counterNameLength, GLchar *counterName, GLuint counterDescLength, GLchar *counterDesc, GLuint *counterOffset, GLuint *counterDataSize, GLuint *counterTypeEnum, GLuint *counterDataTypeEnum, GLuint64 *rawCounterMaxValue);
void glGetPerfQueryDataINTEL (GLuint queryHandle, GLuint flags, GLsizei dataSize, void *data, GLuint *bytesWritten);
void glGetPerfQueryIdByNameINTEL (GLchar *queryName, GLuint *queryId);
void glGetPerfQueryInfoINTEL (GLuint queryId, GLuint queryNameLength, GLchar *queryName, GLuint *dataSize, GLuint *noCounters, GLuint *noInstances, GLuint *capsMask);

enum {
    GL_MESA_framebuffer_flip_x        = 1,
    GL_FRAMEBUFFER_FLIP_X_MESA        = 0x8BBC
};

enum {
    GL_MESA_framebuffer_flip_y        = 1,
    GL_FRAMEBUFFER_FLIP_Y_MESA        = 0x8BBB
};
typedef void (* PFNGLFRAMEBUFFERPARAMETERIMESAPROC) (GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLGETFRAMEBUFFERPARAMETERIVMESAPROC) (GLenum target, GLenum pname, GLint *params);

void glFramebufferParameteriMESA (GLenum target, GLenum pname, GLint param);
void glGetFramebufferParameterivMESA (GLenum target, GLenum pname, GLint *params);
enum {
    GL_MESA_framebuffer_swap_xy       = 1,
    GL_FRAMEBUFFER_SWAP_XY_MESA       = 0x8BBD
};

enum { GL_NV_bindless_multi_draw_indirect = 1 };
typedef void (* PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSNVPROC) (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);
typedef void (* PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSNVPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);

void glMultiDrawArraysIndirectBindlessNV (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);
void glMultiDrawElementsIndirectBindlessNV (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei stride, GLint vertexBufferCount);

enum { GL_NV_bindless_multi_draw_indirect_count = 1 };
typedef void (* PFNGLMULTIDRAWARRAYSINDIRECTBINDLESSCOUNTNVPROC) (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);
typedef void (* PFNGLMULTIDRAWELEMENTSINDIRECTBINDLESSCOUNTNVPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);

void glMultiDrawArraysIndirectBindlessCountNV (GLenum mode, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);
void glMultiDrawElementsIndirectBindlessCountNV (GLenum mode, GLenum type, const void *indirect, GLsizei drawCount, GLsizei maxDrawCount, GLsizei stride, GLint vertexBufferCount);

enum { GL_NV_bindless_texture = 1 };
typedef GLuint64 (* PFNGLGETTEXTUREHANDLENVPROC) (GLuint texture);
typedef GLuint64 (* PFNGLGETTEXTURESAMPLERHANDLENVPROC) (GLuint texture, GLuint sampler);
typedef void (* PFNGLMAKETEXTUREHANDLERESIDENTNVPROC) (GLuint64 handle);
typedef void (* PFNGLMAKETEXTUREHANDLENONRESIDENTNVPROC) (GLuint64 handle);
typedef GLuint64 (* PFNGLGETIMAGEHANDLENVPROC) (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);
typedef void (* PFNGLMAKEIMAGEHANDLERESIDENTNVPROC) (GLuint64 handle, GLenum access);
typedef void (* PFNGLMAKEIMAGEHANDLENONRESIDENTNVPROC) (GLuint64 handle);
typedef void (* PFNGLUNIFORMHANDLEUI64NVPROC) (GLint location, GLuint64 value);
typedef void (* PFNGLUNIFORMHANDLEUI64VNVPROC) (GLint location, GLsizei count, const GLuint64 *value);
typedef void (* PFNGLPROGRAMUNIFORMHANDLEUI64NVPROC) (GLuint program, GLint location, GLuint64 value);
typedef void (* PFNGLPROGRAMUNIFORMHANDLEUI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64 *values);
typedef GLboolean (* PFNGLISTEXTUREHANDLERESIDENTNVPROC) (GLuint64 handle);
typedef GLboolean (* PFNGLISIMAGEHANDLERESIDENTNVPROC) (GLuint64 handle);

GLuint64 glGetTextureHandleNV (GLuint texture);
GLuint64 glGetTextureSamplerHandleNV (GLuint texture, GLuint sampler);
void glMakeTextureHandleResidentNV (GLuint64 handle);
void glMakeTextureHandleNonResidentNV (GLuint64 handle);
GLuint64 glGetImageHandleNV (GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum format);
void glMakeImageHandleResidentNV (GLuint64 handle, GLenum access);
void glMakeImageHandleNonResidentNV (GLuint64 handle);
void glUniformHandleui64NV (GLint location, GLuint64 value);
void glUniformHandleui64vNV (GLint location, GLsizei count, const GLuint64 *value);
void glProgramUniformHandleui64NV (GLuint program, GLint location, GLuint64 value);
void glProgramUniformHandleui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64 *values);
GLboolean glIsTextureHandleResidentNV (GLuint64 handle);
GLboolean glIsImageHandleResidentNV (GLuint64 handle);

enum {
    GL_NV_blend_equation_advanced     = 1,
    GL_BLEND_OVERLAP_NV               = 0x9281,
    GL_BLEND_PREMULTIPLIED_SRC_NV     = 0x9280,
    GL_BLUE_NV                        = 0x1905,
    GL_COLORBURN_NV                   = 0x929A,
    GL_COLORDODGE_NV                  = 0x9299,
    GL_CONJOINT_NV                    = 0x9284,
    GL_CONTRAST_NV                    = 0x92A1,
    GL_DARKEN_NV                      = 0x9297,
    GL_DIFFERENCE_NV                  = 0x929E,
    GL_DISJOINT_NV                    = 0x9283,
    GL_DST_ATOP_NV                    = 0x928F,
    GL_DST_IN_NV                      = 0x928B,
    GL_DST_NV                         = 0x9287,
    GL_DST_OUT_NV                     = 0x928D,
    GL_DST_OVER_NV                    = 0x9289,
    GL_EXCLUSION_NV                   = 0x92A0,
    GL_GREEN_NV                       = 0x1904,
    GL_HARDLIGHT_NV                   = 0x929B,
    GL_HARDMIX_NV                     = 0x92A9,
    GL_HSL_COLOR_NV                   = 0x92AF,
    GL_HSL_HUE_NV                     = 0x92AD,
    GL_HSL_LUMINOSITY_NV              = 0x92B0,
    GL_HSL_SATURATION_NV              = 0x92AE,
    GL_INVERT_OVG_NV                  = 0x92B4,
    GL_INVERT_RGB_NV                  = 0x92A3,
    GL_LIGHTEN_NV                     = 0x9298,
    GL_LINEARBURN_NV                  = 0x92A5,
    GL_LINEARDODGE_NV                 = 0x92A4,
    GL_LINEARLIGHT_NV                 = 0x92A7,
    GL_MINUS_CLAMPED_NV               = 0x92B3,
    GL_MINUS_NV                       = 0x929F,
    GL_MULTIPLY_NV                    = 0x9294,
    GL_OVERLAY_NV                     = 0x9296,
    GL_PINLIGHT_NV                    = 0x92A8,
    GL_PLUS_CLAMPED_ALPHA_NV          = 0x92B2,
    GL_PLUS_CLAMPED_NV                = 0x92B1,
    GL_PLUS_DARKER_NV                 = 0x9292,
    GL_PLUS_NV                        = 0x9291,
    GL_RED_NV                         = 0x1903,
    GL_SCREEN_NV                      = 0x9295,
    GL_SOFTLIGHT_NV                   = 0x929C,
    GL_SRC_ATOP_NV                    = 0x928E,
    GL_SRC_IN_NV                      = 0x928A,
    GL_SRC_NV                         = 0x9286,
    GL_SRC_OUT_NV                     = 0x928C,
    GL_SRC_OVER_NV                    = 0x9288,
    GL_UNCORRELATED_NV                = 0x9282,
    GL_VIVIDLIGHT_NV                  = 0x92A6,
    GL_XOR_NV                         = 0x1506
};
typedef void (* PFNGLBLENDPARAMETERINVPROC) (GLenum pname, GLint value);
typedef void (* PFNGLBLENDBARRIERNVPROC) (void);

void glBlendParameteriNV (GLenum pname, GLint value);
void glBlendBarrierNV (void);

enum {
    GL_NV_blend_equation_advanced_coherent = 1,
    GL_BLEND_ADVANCED_COHERENT_NV     = 0x9285
};

enum {
    GL_NV_blend_minmax_factor         = 1,
    GL_FACTOR_MIN_AMD                 = 0x901C,
    GL_FACTOR_MAX_AMD                 = 0x901D
};

enum {
    GL_NV_clip_space_w_scaling        = 1,
    GL_VIEWPORT_POSITION_W_SCALE_NV   = 0x937C,
    GL_VIEWPORT_POSITION_W_SCALE_X_COEFF_NV = 0x937D,
    GL_VIEWPORT_POSITION_W_SCALE_Y_COEFF_NV = 0x937E
};
typedef void (* PFNGLVIEWPORTPOSITIONWSCALENVPROC) (GLuint index, GLfloat xcoeff, GLfloat ycoeff);
void glViewportPositionWScaleNV (GLuint index, GLfloat xcoeff, GLfloat ycoeff);

enum {
    GL_NV_command_list                = 1,
    GL_TERMINATE_SEQUENCE_COMMAND_NV  = 0x0000,
    GL_NOP_COMMAND_NV                 = 0x0001,
    GL_DRAW_ELEMENTS_COMMAND_NV       = 0x0002,
    GL_DRAW_ARRAYS_COMMAND_NV         = 0x0003,
    GL_DRAW_ELEMENTS_STRIP_COMMAND_NV = 0x0004,
    GL_DRAW_ARRAYS_STRIP_COMMAND_NV   = 0x0005,
    GL_DRAW_ELEMENTS_INSTANCED_COMMAND_NV = 0x0006,
    GL_DRAW_ARRAYS_INSTANCED_COMMAND_NV = 0x0007,
    GL_ELEMENT_ADDRESS_COMMAND_NV     = 0x0008,
    GL_ATTRIBUTE_ADDRESS_COMMAND_NV   = 0x0009,
    GL_UNIFORM_ADDRESS_COMMAND_NV     = 0x000A,
    GL_BLEND_COLOR_COMMAND_NV         = 0x000B,
    GL_STENCIL_REF_COMMAND_NV         = 0x000C,
    GL_LINE_WIDTH_COMMAND_NV          = 0x000D,
    GL_POLYGON_OFFSET_COMMAND_NV      = 0x000E,
    GL_ALPHA_REF_COMMAND_NV           = 0x000F,
    GL_VIEWPORT_COMMAND_NV            = 0x0010,
    GL_SCISSOR_COMMAND_NV             = 0x0011,
    GL_FRONT_FACE_COMMAND_NV          = 0x0012
};
typedef void (* PFNGLCREATESTATESNVPROC) (GLsizei n, GLuint *states);
typedef void (* PFNGLDELETESTATESNVPROC) (GLsizei n, const GLuint *states);
typedef GLboolean (* PFNGLISSTATENVPROC) (GLuint state);
typedef void (* PFNGLSTATECAPTURENVPROC) (GLuint state, GLenum mode);
typedef GLuint (* PFNGLGETCOMMANDHEADERNVPROC) (GLenum tokenID, GLuint size);
typedef GLushort (* PFNGLGETSTAGEINDEXNVPROC) (GLenum shadertype);
typedef void (* PFNGLDRAWCOMMANDSNVPROC) (GLenum primitiveMode, GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, GLuint count);
typedef void (* PFNGLDRAWCOMMANDSADDRESSNVPROC) (GLenum primitiveMode, const GLuint64 *indirects, const GLsizei *sizes, GLuint count);
typedef void (* PFNGLDRAWCOMMANDSSTATESNVPROC) (GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
typedef void (* PFNGLDRAWCOMMANDSSTATESADDRESSNVPROC) (const GLuint64 *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
typedef void (* PFNGLCREATECOMMANDLISTSNVPROC) (GLsizei n, GLuint *lists);
typedef void (* PFNGLDELETECOMMANDLISTSNVPROC) (GLsizei n, const GLuint *lists);
typedef GLboolean (* PFNGLISCOMMANDLISTNVPROC) (GLuint list);
typedef void (* PFNGLLISTDRAWCOMMANDSSTATESCLIENTNVPROC) (GLuint list, GLuint segment, const void **indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
typedef void (* PFNGLCOMMANDLISTSEGMENTSNVPROC) (GLuint list, GLuint segments);
typedef void (* PFNGLCOMPILECOMMANDLISTNVPROC) (GLuint list);
typedef void (* PFNGLCALLCOMMANDLISTNVPROC) (GLuint list);

void glCreateStatesNV (GLsizei n, GLuint *states);
void glDeleteStatesNV (GLsizei n, const GLuint *states);
GLboolean glIsStateNV (GLuint state);
void glStateCaptureNV (GLuint state, GLenum mode);
GLuint glGetCommandHeaderNV (GLenum tokenID, GLuint size);
GLushort glGetStageIndexNV (GLenum shadertype);
void glDrawCommandsNV (GLenum primitiveMode, GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, GLuint count);
void glDrawCommandsAddressNV (GLenum primitiveMode, const GLuint64 *indirects, const GLsizei *sizes, GLuint count);
void glDrawCommandsStatesNV (GLuint buffer, const GLintptr *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
void glDrawCommandsStatesAddressNV (const GLuint64 *indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
void glCreateCommandListsNV (GLsizei n, GLuint *lists);
void glDeleteCommandListsNV (GLsizei n, const GLuint *lists);
GLboolean glIsCommandListNV (GLuint list);
void glListDrawCommandsStatesClientNV (GLuint list, GLuint segment, const void **indirects, const GLsizei *sizes, const GLuint *states, const GLuint *fbos, GLuint count);
void glCommandListSegmentsNV (GLuint list, GLuint segments);
void glCompileCommandListNV (GLuint list);
void glCallCommandListNV (GLuint list);

enum { GL_NV_compute_shader_derivatives = 1 };

enum {
    GL_NV_conditional_render          = 1,
    GL_QUERY_WAIT_NV                  = 0x8E13,
    GL_QUERY_NO_WAIT_NV               = 0x8E14,
    GL_QUERY_BY_REGION_WAIT_NV        = 0x8E15,
    GL_QUERY_BY_REGION_NO_WAIT_NV     = 0x8E16
};
typedef void (* PFNGLBEGINCONDITIONALRENDERNVPROC) (GLuint id, GLenum mode);
typedef void (* PFNGLENDCONDITIONALRENDERNVPROC) (void);

void glBeginConditionalRenderNV (GLuint id, GLenum mode);
void glEndConditionalRenderNV (void);

enum {
    GL_NV_conservative_raster = 1,
    GL_CONSERVATIVE_RASTERIZATION_NV  = 0x9346,
    GL_SUBPIXEL_PRECISION_BIAS_X_BITS_NV = 0x9347,
    GL_SUBPIXEL_PRECISION_BIAS_Y_BITS_NV = 0x9348,
    GL_MAX_SUBPIXEL_PRECISION_BIAS_BITS_NV = 0x9349
};
typedef void (* PFNGLSUBPIXELPRECISIONBIASNVPROC) (GLuint xbits, GLuint ybits);
void glSubpixelPrecisionBiasNV (GLuint xbits, GLuint ybits);

enum {
    GL_NV_conservative_raster_dilate = 1,
    GL_CONSERVATIVE_RASTER_DILATE_NV  = 0x9379,
    GL_CONSERVATIVE_RASTER_DILATE_RANGE_NV = 0x937A,
    GL_CONSERVATIVE_RASTER_DILATE_GRANULARITY_NV = 0x937B
};
typedef void (* PFNGLCONSERVATIVERASTERPARAMETERFNVPROC) (GLenum pname, GLfloat value);
void glConservativeRasterParameterfNV (GLenum pname, GLfloat value);

enum {
    GL_NV_conservative_raster_pre_snap  = 1,
    GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_NV = 0x9550
};

enum {
    GL_NV_conservative_raster_pre_snap_triangles = 1,
    GL_CONSERVATIVE_RASTER_MODE_NV    = 0x954D,
    GL_CONSERVATIVE_RASTER_MODE_POST_SNAP_NV = 0x954E,
    GL_CONSERVATIVE_RASTER_MODE_PRE_SNAP_TRIANGLES_NV = 0x954F
};
typedef void (* PFNGLCONSERVATIVERASTERPARAMETERINVPROC) (GLenum pname, GLint param);
void glConservativeRasterParameteriNV (GLenum pname, GLint param);

enum { GL_NV_conservative_raster_underestimation = 1 };
enum {
    GL_NV_depth_buffer_float = 1,
    GL_DEPTH_COMPONENT32F_NV          = 0x8DAB,
    GL_DEPTH32F_STENCIL8_NV           = 0x8DAC,
    GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV = 0x8DAD,
    GL_DEPTH_BUFFER_FLOAT_MODE_NV     = 0x8DAF
};
typedef void (* PFNGLDEPTHRANGEDNVPROC) (GLdouble zNear, GLdouble zFar);
typedef void (* PFNGLCLEARDEPTHDNVPROC) (GLdouble depth);
typedef void (* PFNGLDEPTHBOUNDSDNVPROC) (GLdouble zmin, GLdouble zmax);
void glDepthRangedNV (GLdouble zNear, GLdouble zFar);
void glClearDepthdNV (GLdouble depth);
void glDepthBoundsdNV (GLdouble zmin, GLdouble zmax);

enum { GL_NV_draw_vulkan_image = 1 };
typedef void ( *GLVULKANPROCNV)(void);
typedef void (* PFNGLDRAWVKIMAGENVPROC) (GLuint64 vkImage, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1);
typedef GLVULKANPROCNV (* PFNGLGETVKPROCADDRNVPROC) (const GLchar *name);
typedef void (* PFNGLWAITVKSEMAPHORENVPROC) (GLuint64 vkSemaphore);
typedef void (* PFNGLSIGNALVKSEMAPHORENVPROC) (GLuint64 vkSemaphore);
typedef void (* PFNGLSIGNALVKFENCENVPROC) (GLuint64 vkFence);

void glDrawVkImageNV (GLuint64 vkImage, GLuint sampler, GLfloat x0, GLfloat y0, GLfloat x1, GLfloat y1, GLfloat z, GLfloat s0, GLfloat t0, GLfloat s1, GLfloat t1);
GLVULKANPROCNV glGetVkProcAddrNV (const GLchar *name);
void glWaitVkSemaphoreNV (GLuint64 vkSemaphore);
void glSignalVkSemaphoreNV (GLuint64 vkSemaphore);
void glSignalVkFenceNV (GLuint64 vkFence);

enum {
    GL_NV_fill_rectangle = 1,
    GL_FILL_RECTANGLE_NV              = 0x933C
};

enum {
    GL_NV_fragment_coverage_to_color  = 1,
    GL_FRAGMENT_COVERAGE_TO_COLOR_NV  = 0x92DD,
    GL_FRAGMENT_COVERAGE_COLOR_NV     = 0x92DE
};
typedef void (* PFNGLFRAGMENTCOVERAGECOLORNVPROC) (GLuint color);
void glFragmentCoverageColorNV (GLuint color);

enum { GL_NV_fragment_shader_barycentric = 1 };
enum { GL_NV_fragment_shader_interlock = 1 };
enum {
    GL_NV_framebuffer_mixed_samples   = 1,
    GL_COVERAGE_MODULATION_TABLE_NV   = 0x9331,
    GL_COLOR_SAMPLES_NV               = 0x8E20,
    GL_DEPTH_SAMPLES_NV               = 0x932D,
    GL_STENCIL_SAMPLES_NV             = 0x932E,
    GL_MIXED_DEPTH_SAMPLES_SUPPORTED_NV = 0x932F,
    GL_MIXED_STENCIL_SAMPLES_SUPPORTED_NV = 0x9330,
    GL_COVERAGE_MODULATION_NV         = 0x9332,
    GL_COVERAGE_MODULATION_TABLE_SIZE_NV = 0x9333
};
typedef void (* PFNGLCOVERAGEMODULATIONTABLENVPROC) (GLsizei n, const GLfloat *v);
typedef void (* PFNGLGETCOVERAGEMODULATIONTABLENVPROC) (GLsizei bufSize, GLfloat *v);
typedef void (* PFNGLCOVERAGEMODULATIONNVPROC) (GLenum components);

void glCoverageModulationTableNV (GLsizei n, const GLfloat *v);
void glGetCoverageModulationTableNV (GLsizei bufSize, GLfloat *v);
void glCoverageModulationNV (GLenum components);

enum {
    GL_NV_framebuffer_multisample_coverage = 1,
    GL_RENDERBUFFER_COVERAGE_SAMPLES_NV = 0x8CAB,
    GL_RENDERBUFFER_COLOR_SAMPLES_NV  = 0x8E10,
    GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV = 0x8E11,
    GL_MULTISAMPLE_COVERAGE_MODES_NV  = 0x8E12
};
typedef void (* PFNGLRENDERBUFFERSTORAGEMULTISAMPLECOVERAGENVPROC) (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);
void glRenderbufferStorageMultisampleCoverageNV (GLenum target, GLsizei coverageSamples, GLsizei colorSamples, GLenum internalformat, GLsizei width, GLsizei height);

enum { GL_NV_geometry_shader_passthrough = 1 };

enum { GL_NV_gpu_shader5 = 1 };
typedef int64_t GLint64EXT;
enum {
    GL_INT64_NV                       = 0x140E,
    GL_UNSIGNED_INT64_NV              = 0x140F,
    GL_INT8_NV                        = 0x8FE0,
    GL_INT8_VEC2_NV                   = 0x8FE1,
    GL_INT8_VEC3_NV                   = 0x8FE2,
    GL_INT8_VEC4_NV                   = 0x8FE3,
    GL_INT16_NV                       = 0x8FE4,
    GL_INT16_VEC2_NV                  = 0x8FE5,
    GL_INT16_VEC3_NV                  = 0x8FE6,
    GL_INT16_VEC4_NV                  = 0x8FE7,
    GL_INT64_VEC2_NV                  = 0x8FE9,
    GL_INT64_VEC3_NV                  = 0x8FEA,
    GL_INT64_VEC4_NV                  = 0x8FEB,
    GL_UNSIGNED_INT8_NV               = 0x8FEC,
    GL_UNSIGNED_INT8_VEC2_NV          = 0x8FED,
    GL_UNSIGNED_INT8_VEC3_NV          = 0x8FEE,
    GL_UNSIGNED_INT8_VEC4_NV          = 0x8FEF,
    GL_UNSIGNED_INT16_NV              = 0x8FF0,
    GL_UNSIGNED_INT16_VEC2_NV         = 0x8FF1,
    GL_UNSIGNED_INT16_VEC3_NV         = 0x8FF2,
    GL_UNSIGNED_INT16_VEC4_NV         = 0x8FF3,
    GL_UNSIGNED_INT64_VEC2_NV         = 0x8FF5,
    GL_UNSIGNED_INT64_VEC3_NV         = 0x8FF6,
    GL_UNSIGNED_INT64_VEC4_NV         = 0x8FF7,
    GL_FLOAT16_NV                     = 0x8FF8,
    GL_FLOAT16_VEC2_NV                = 0x8FF9,
    GL_FLOAT16_VEC3_NV                = 0x8FFA,
    GL_FLOAT16_VEC4_NV                = 0x8FFB
};
typedef void (* PFNGLUNIFORM1I64NVPROC) (GLint location, GLint64EXT x);
typedef void (* PFNGLUNIFORM2I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y);
typedef void (* PFNGLUNIFORM3I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
typedef void (* PFNGLUNIFORM4I64NVPROC) (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
typedef void (* PFNGLUNIFORM1I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLUNIFORM2I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLUNIFORM3I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLUNIFORM4I64VNVPROC) (GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLUNIFORM1UI64NVPROC) (GLint location, GLuint64EXT x);
typedef void (* PFNGLUNIFORM2UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y);
typedef void (* PFNGLUNIFORM3UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
typedef void (* PFNGLUNIFORM4UI64NVPROC) (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
typedef void (* PFNGLUNIFORM1UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLUNIFORM2UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLUNIFORM3UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLUNIFORM4UI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLGETUNIFORMI64VNVPROC) (GLuint program, GLint location, GLint64EXT *params);
typedef void (* PFNGLPROGRAMUNIFORM1I64NVPROC) (GLuint program, GLint location, GLint64EXT x);
typedef void (* PFNGLPROGRAMUNIFORM2I64NVPROC) (GLuint program, GLint location, GLint64EXT x, GLint64EXT y);
typedef void (* PFNGLPROGRAMUNIFORM3I64NVPROC) (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
typedef void (* PFNGLPROGRAMUNIFORM4I64NVPROC) (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
typedef void (* PFNGLPROGRAMUNIFORM1I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM2I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM3I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM4I64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM1UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x);
typedef void (* PFNGLPROGRAMUNIFORM2UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y);
typedef void (* PFNGLPROGRAMUNIFORM3UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
typedef void (* PFNGLPROGRAMUNIFORM4UI64NVPROC) (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
typedef void (* PFNGLPROGRAMUNIFORM1UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM2UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM3UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLPROGRAMUNIFORM4UI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);

void glUniform1i64NV (GLint location, GLint64EXT x);
void glUniform2i64NV (GLint location, GLint64EXT x, GLint64EXT y);
void glUniform3i64NV (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
void glUniform4i64NV (GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
void glUniform1i64vNV (GLint location, GLsizei count, const GLint64EXT *value);
void glUniform2i64vNV (GLint location, GLsizei count, const GLint64EXT *value);
void glUniform3i64vNV (GLint location, GLsizei count, const GLint64EXT *value);
void glUniform4i64vNV (GLint location, GLsizei count, const GLint64EXT *value);
void glUniform1ui64NV (GLint location, GLuint64EXT x);
void glUniform2ui64NV (GLint location, GLuint64EXT x, GLuint64EXT y);
void glUniform3ui64NV (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
void glUniform4ui64NV (GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
void glUniform1ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);
void glUniform2ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);
void glUniform3ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);
void glUniform4ui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);
void glGetUniformi64vNV (GLuint program, GLint location, GLint64EXT *params);
void glProgramUniform1i64NV (GLuint program, GLint location, GLint64EXT x);
void glProgramUniform2i64NV (GLuint program, GLint location, GLint64EXT x, GLint64EXT y);
void glProgramUniform3i64NV (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z);
void glProgramUniform4i64NV (GLuint program, GLint location, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
void glProgramUniform1i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
void glProgramUniform2i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
void glProgramUniform3i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
void glProgramUniform4i64vNV (GLuint program, GLint location, GLsizei count, const GLint64EXT *value);
void glProgramUniform1ui64NV (GLuint program, GLint location, GLuint64EXT x);
void glProgramUniform2ui64NV (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y);
void glProgramUniform3ui64NV (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
void glProgramUniform4ui64NV (GLuint program, GLint location, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
void glProgramUniform1ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
void glProgramUniform2ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
void glProgramUniform3ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);
void glProgramUniform4ui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);

enum {
    GL_NV_internalformat_sample_query = 1,
    GL_MULTISAMPLES_NV                = 0x9371,
    GL_SUPERSAMPLE_SCALE_X_NV         = 0x9372,
    GL_SUPERSAMPLE_SCALE_Y_NV         = 0x9373,
    GL_CONFORMANT_NV                  = 0x9374
};
typedef void (* PFNGLGETINTERNALFORMATSAMPLEIVNVPROC) (GLenum target, GLenum internalformat, GLsizei samples, GLenum pname, GLsizei count, GLint *params);
void glGetInternalformatSampleivNV (GLenum target, GLenum internalformat, GLsizei samples, GLenum pname, GLsizei count, GLint *params);

enum {
    GL_NV_memory_attachment           = 1,
    GL_ATTACHED_MEMORY_OBJECT_NV      = 0x95A4,
    GL_ATTACHED_MEMORY_OFFSET_NV      = 0x95A5,
    GL_MEMORY_ATTACHABLE_ALIGNMENT_NV = 0x95A6,
    GL_MEMORY_ATTACHABLE_SIZE_NV      = 0x95A7,
    GL_MEMORY_ATTACHABLE_NV           = 0x95A8,
    GL_DETACHED_MEMORY_INCARNATION_NV = 0x95A9,
    GL_DETACHED_TEXTURES_NV           = 0x95AA,
    GL_DETACHED_BUFFERS_NV            = 0x95AB,
    GL_MAX_DETACHED_TEXTURES_NV       = 0x95AC,
    GL_MAX_DETACHED_BUFFERS_NV        = 0x95AD
};
typedef void (* PFNGLGETMEMORYOBJECTDETACHEDRESOURCESUIVNVPROC) (GLuint memory, GLenum pname, GLint first, GLsizei count, GLuint *params);
typedef void (* PFNGLRESETMEMORYOBJECTPARAMETERNVPROC) (GLuint memory, GLenum pname);
typedef void (* PFNGLTEXATTACHMEMORYNVPROC) (GLenum target, GLuint memory, GLuint64 offset);
typedef void (* PFNGLBUFFERATTACHMEMORYNVPROC) (GLenum target, GLuint memory, GLuint64 offset);
typedef void (* PFNGLTEXTUREATTACHMEMORYNVPROC) (GLuint texture, GLuint memory, GLuint64 offset);
typedef void (* PFNGLNAMEDBUFFERATTACHMEMORYNVPROC) (GLuint buffer, GLuint memory, GLuint64 offset);

void glGetMemoryObjectDetachedResourcesuivNV (GLuint memory, GLenum pname, GLint first, GLsizei count, GLuint *params);
void glResetMemoryObjectParameterNV (GLuint memory, GLenum pname);
void glTexAttachMemoryNV (GLenum target, GLuint memory, GLuint64 offset);
void glBufferAttachMemoryNV (GLenum target, GLuint memory, GLuint64 offset);
void glTextureAttachMemoryNV (GLuint texture, GLuint memory, GLuint64 offset);
void glNamedBufferAttachMemoryNV (GLuint buffer, GLuint memory, GLuint64 offset);

enum {
    GL_NV_mesh_shader                 = 1,
    GL_MESH_SHADER_NV                 = 0x9559,
    GL_TASK_SHADER_NV                 = 0x955A,
    GL_MAX_MESH_UNIFORM_BLOCKS_NV     = 0x8E60,
    GL_MAX_MESH_TEXTURE_IMAGE_UNITS_NV = 0x8E61,
    GL_MAX_MESH_IMAGE_UNIFORMS_NV     = 0x8E62,
    GL_MAX_MESH_UNIFORM_COMPONENTS_NV = 0x8E63,
    GL_MAX_MESH_ATOMIC_COUNTER_BUFFERS_NV = 0x8E64,
    GL_MAX_MESH_ATOMIC_COUNTERS_NV    = 0x8E65,
    GL_MAX_MESH_SHADER_STORAGE_BLOCKS_NV = 0x8E66,
    GL_MAX_COMBINED_MESH_UNIFORM_COMPONENTS_NV = 0x8E67,
    GL_MAX_TASK_UNIFORM_BLOCKS_NV     = 0x8E68,
    GL_MAX_TASK_TEXTURE_IMAGE_UNITS_NV = 0x8E69,
    GL_MAX_TASK_IMAGE_UNIFORMS_NV     = 0x8E6A,
    GL_MAX_TASK_UNIFORM_COMPONENTS_NV = 0x8E6B,
    GL_MAX_TASK_ATOMIC_COUNTER_BUFFERS_NV = 0x8E6C,
    GL_MAX_TASK_ATOMIC_COUNTERS_NV    = 0x8E6D,
    GL_MAX_TASK_SHADER_STORAGE_BLOCKS_NV = 0x8E6E,
    GL_MAX_COMBINED_TASK_UNIFORM_COMPONENTS_NV = 0x8E6F,
    GL_MAX_MESH_WORK_GROUP_INVOCATIONS_NV = 0x95A2,
    GL_MAX_TASK_WORK_GROUP_INVOCATIONS_NV = 0x95A3,
    GL_MAX_MESH_TOTAL_MEMORY_SIZE_NV  = 0x9536,
    GL_MAX_TASK_TOTAL_MEMORY_SIZE_NV  = 0x9537,
    GL_MAX_MESH_OUTPUT_VERTICES_NV    = 0x9538,
    GL_MAX_MESH_OUTPUT_PRIMITIVES_NV  = 0x9539,
    GL_MAX_TASK_OUTPUT_COUNT_NV       = 0x953A,
    GL_MAX_DRAW_MESH_TASKS_COUNT_NV   = 0x953D,
    GL_MAX_MESH_VIEWS_NV              = 0x9557,
    GL_MESH_OUTPUT_PER_VERTEX_GRANULARITY_NV = 0x92DF,
    GL_MESH_OUTPUT_PER_PRIMITIVE_GRANULARITY_NV = 0x9543,
    GL_MAX_MESH_WORK_GROUP_SIZE_NV    = 0x953B,
    GL_MAX_TASK_WORK_GROUP_SIZE_NV    = 0x953C,
    GL_MESH_WORK_GROUP_SIZE_NV        = 0x953E,
    GL_TASK_WORK_GROUP_SIZE_NV        = 0x953F,
    GL_MESH_VERTICES_OUT_NV           = 0x9579,
    GL_MESH_PRIMITIVES_OUT_NV         = 0x957A,
    GL_MESH_OUTPUT_TYPE_NV            = 0x957B,
    GL_UNIFORM_BLOCK_REFERENCED_BY_MESH_SHADER_NV = 0x959C,
    GL_UNIFORM_BLOCK_REFERENCED_BY_TASK_SHADER_NV = 0x959D,
    GL_REFERENCED_BY_MESH_SHADER_NV   = 0x95A0,
    GL_REFERENCED_BY_TASK_SHADER_NV   = 0x95A1,
    GL_MESH_SHADER_BIT_NV             = 0x00000040,
    GL_TASK_SHADER_BIT_NV             = 0x00000080,
    GL_MESH_SUBROUTINE_NV             = 0x957C,
    GL_TASK_SUBROUTINE_NV             = 0x957D,
    GL_MESH_SUBROUTINE_UNIFORM_NV     = 0x957E,
    GL_TASK_SUBROUTINE_UNIFORM_NV     = 0x957F,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_MESH_SHADER_NV = 0x959E,
    GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TASK_SHADER_NV = 0x959F
};
typedef void (* PFNGLDRAWMESHTASKSNVPROC) (GLuint first, GLuint count);
typedef void (* PFNGLDRAWMESHTASKSINDIRECTNVPROC) (GLintptr indirect);
typedef void (* PFNGLMULTIDRAWMESHTASKSINDIRECTNVPROC) (GLintptr indirect, GLsizei drawcount, GLsizei stride);
typedef void (* PFNGLMULTIDRAWMESHTASKSINDIRECTCOUNTNVPROC) (GLintptr indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);
void glDrawMeshTasksNV (GLuint first, GLuint count);
void glDrawMeshTasksIndirectNV (GLintptr indirect);
void glMultiDrawMeshTasksIndirectNV (GLintptr indirect, GLsizei drawcount, GLsizei stride);
void glMultiDrawMeshTasksIndirectCountNV (GLintptr indirect, GLintptr drawcount, GLsizei maxdrawcount, GLsizei stride);

enum {
    GL_NV_path_rendering              = 1,
    GL_PATH_FORMAT_SVG_NV             = 0x9070,
    GL_PATH_FORMAT_PS_NV              = 0x9071,
    GL_STANDARD_FONT_NAME_NV          = 0x9072,
    GL_SYSTEM_FONT_NAME_NV            = 0x9073,
    GL_FILE_NAME_NV                   = 0x9074,
    GL_PATH_STROKE_WIDTH_NV           = 0x9075,
    GL_PATH_END_CAPS_NV               = 0x9076,
    GL_PATH_INITIAL_END_CAP_NV        = 0x9077,
    GL_PATH_TERMINAL_END_CAP_NV       = 0x9078,
    GL_PATH_JOIN_STYLE_NV             = 0x9079,
    GL_PATH_MITER_LIMIT_NV            = 0x907A,
    GL_PATH_DASH_CAPS_NV              = 0x907B,
    GL_PATH_INITIAL_DASH_CAP_NV       = 0x907C,
    GL_PATH_TERMINAL_DASH_CAP_NV      = 0x907D,
    GL_PATH_DASH_OFFSET_NV            = 0x907E,
    GL_PATH_CLIENT_LENGTH_NV          = 0x907F,
    GL_PATH_FILL_MODE_NV              = 0x9080,
    GL_PATH_FILL_MASK_NV              = 0x9081,
    GL_PATH_FILL_COVER_MODE_NV        = 0x9082,
    GL_PATH_STROKE_COVER_MODE_NV      = 0x9083,
    GL_PATH_STROKE_MASK_NV            = 0x9084,
    GL_COUNT_UP_NV                    = 0x9088,
    GL_COUNT_DOWN_NV                  = 0x9089,
    GL_PATH_OBJECT_BOUNDING_BOX_NV    = 0x908A,
    GL_CONVEX_HULL_NV                 = 0x908B,
    GL_BOUNDING_BOX_NV                = 0x908D,
    GL_TRANSLATE_X_NV                 = 0x908E,
    GL_TRANSLATE_Y_NV                 = 0x908F,
    GL_TRANSLATE_2D_NV                = 0x9090,
    GL_TRANSLATE_3D_NV                = 0x9091,
    GL_AFFINE_2D_NV                   = 0x9092,
    GL_AFFINE_3D_NV                   = 0x9094,
    GL_TRANSPOSE_AFFINE_2D_NV         = 0x9096,
    GL_TRANSPOSE_AFFINE_3D_NV         = 0x9098,
    GL_UTF8_NV                        = 0x909A,
    GL_UTF16_NV                       = 0x909B,
    GL_BOUNDING_BOX_OF_BOUNDING_BOXES_NV = 0x909C,
    GL_PATH_COMMAND_COUNT_NV          = 0x909D,
    GL_PATH_COORD_COUNT_NV            = 0x909E,
    GL_PATH_DASH_ARRAY_COUNT_NV       = 0x909F,
    GL_PATH_COMPUTED_LENGTH_NV        = 0x90A0,
    GL_PATH_FILL_BOUNDING_BOX_NV      = 0x90A1,
    GL_PATH_STROKE_BOUNDING_BOX_NV    = 0x90A2,
    GL_SQUARE_NV                      = 0x90A3,
    GL_ROUND_NV                       = 0x90A4,
    GL_TRIANGULAR_NV                  = 0x90A5,
    GL_BEVEL_NV                       = 0x90A6,
    GL_MITER_REVERT_NV                = 0x90A7,
    GL_MITER_TRUNCATE_NV              = 0x90A8,
    GL_SKIP_MISSING_GLYPH_NV          = 0x90A9,
    GL_USE_MISSING_GLYPH_NV           = 0x90AA,
    GL_PATH_ERROR_POSITION_NV         = 0x90AB,
    GL_ACCUM_ADJACENT_PAIRS_NV        = 0x90AD,
    GL_ADJACENT_PAIRS_NV              = 0x90AE,
    GL_FIRST_TO_REST_NV               = 0x90AF,
    GL_PATH_GEN_MODE_NV               = 0x90B0,
    GL_PATH_GEN_COEFF_NV              = 0x90B1,
    GL_PATH_GEN_COMPONENTS_NV         = 0x90B3,
    GL_PATH_STENCIL_FUNC_NV           = 0x90B7,
    GL_PATH_STENCIL_REF_NV            = 0x90B8,
    GL_PATH_STENCIL_VALUE_MASK_NV     = 0x90B9,
    GL_PATH_STENCIL_DEPTH_OFFSET_FACTOR_NV = 0x90BD,
    GL_PATH_STENCIL_DEPTH_OFFSET_UNITS_NV = 0x90BE,
    GL_PATH_COVER_DEPTH_FUNC_NV       = 0x90BF,
    GL_PATH_DASH_OFFSET_RESET_NV      = 0x90B4,
    GL_MOVE_TO_RESETS_NV              = 0x90B5,
    GL_MOVE_TO_CONTINUES_NV           = 0x90B6,
    GL_CLOSE_PATH_NV                  = 0x00,
    GL_MOVE_TO_NV                     = 0x02,
    GL_RELATIVE_MOVE_TO_NV            = 0x03,
    GL_LINE_TO_NV                     = 0x04,
    GL_RELATIVE_LINE_TO_NV            = 0x05,
    GL_HORIZONTAL_LINE_TO_NV          = 0x06,
    GL_RELATIVE_HORIZONTAL_LINE_TO_NV = 0x07,
    GL_VERTICAL_LINE_TO_NV            = 0x08,
    GL_RELATIVE_VERTICAL_LINE_TO_NV   = 0x09,
    GL_QUADRATIC_CURVE_TO_NV          = 0x0A,
    GL_RELATIVE_QUADRATIC_CURVE_TO_NV = 0x0B,
    GL_CUBIC_CURVE_TO_NV              = 0x0C,
    GL_RELATIVE_CUBIC_CURVE_TO_NV     = 0x0D,
    GL_SMOOTH_QUADRATIC_CURVE_TO_NV   = 0x0E,
    GL_RELATIVE_SMOOTH_QUADRATIC_CURVE_TO_NV = 0x0F,
    GL_SMOOTH_CUBIC_CURVE_TO_NV       = 0x10,
    GL_RELATIVE_SMOOTH_CUBIC_CURVE_TO_NV = 0x11,
    GL_SMALL_CCW_ARC_TO_NV            = 0x12,
    GL_RELATIVE_SMALL_CCW_ARC_TO_NV   = 0x13,
    GL_SMALL_CW_ARC_TO_NV             = 0x14,
    GL_RELATIVE_SMALL_CW_ARC_TO_NV    = 0x15,
    GL_LARGE_CCW_ARC_TO_NV            = 0x16,
    GL_RELATIVE_LARGE_CCW_ARC_TO_NV   = 0x17,
    GL_LARGE_CW_ARC_TO_NV             = 0x18,
    GL_RELATIVE_LARGE_CW_ARC_TO_NV    = 0x19,
    GL_RESTART_PATH_NV                = 0xF0,
    GL_DUP_FIRST_CUBIC_CURVE_TO_NV    = 0xF2,
    GL_DUP_LAST_CUBIC_CURVE_TO_NV     = 0xF4,
    GL_RECT_NV                        = 0xF6,
    GL_CIRCULAR_CCW_ARC_TO_NV         = 0xF8,
    GL_CIRCULAR_CW_ARC_TO_NV          = 0xFA,
    GL_CIRCULAR_TANGENT_ARC_TO_NV     = 0xFC,
    GL_ARC_TO_NV                      = 0xFE,
    GL_RELATIVE_ARC_TO_NV             = 0xFF,
    GL_BOLD_BIT_NV                    = 0x01,
    GL_ITALIC_BIT_NV                  = 0x02,
    GL_GLYPH_WIDTH_BIT_NV             = 0x01,
    GL_GLYPH_HEIGHT_BIT_NV            = 0x02,
    GL_GLYPH_HORIZONTAL_BEARING_X_BIT_NV = 0x04,
    GL_GLYPH_HORIZONTAL_BEARING_Y_BIT_NV = 0x08,
    GL_GLYPH_HORIZONTAL_BEARING_ADVANCE_BIT_NV = 0x10,
    GL_GLYPH_VERTICAL_BEARING_X_BIT_NV = 0x20,
    GL_GLYPH_VERTICAL_BEARING_Y_BIT_NV = 0x40,
    GL_GLYPH_VERTICAL_BEARING_ADVANCE_BIT_NV = 0x80,
    GL_GLYPH_HAS_KERNING_BIT_NV       = 0x100,
    GL_FONT_X_MIN_BOUNDS_BIT_NV       = 0x00010000,
    GL_FONT_Y_MIN_BOUNDS_BIT_NV       = 0x00020000,
    GL_FONT_X_MAX_BOUNDS_BIT_NV       = 0x00040000,
    GL_FONT_Y_MAX_BOUNDS_BIT_NV       = 0x00080000,
    GL_FONT_UNITS_PER_EM_BIT_NV       = 0x00100000,
    GL_FONT_ASCENDER_BIT_NV           = 0x00200000,
    GL_FONT_DESCENDER_BIT_NV          = 0x00400000,
    GL_FONT_HEIGHT_BIT_NV             = 0x00800000,
    GL_FONT_MAX_ADVANCE_WIDTH_BIT_NV  = 0x01000000,
    GL_FONT_MAX_ADVANCE_HEIGHT_BIT_NV = 0x02000000,
    GL_FONT_UNDERLINE_POSITION_BIT_NV = 0x04000000,
    GL_FONT_UNDERLINE_THICKNESS_BIT_NV = 0x08000000,
    GL_FONT_HAS_KERNING_BIT_NV        = 0x10000000,
    GL_ROUNDED_RECT_NV                = 0xE8,
    GL_RELATIVE_ROUNDED_RECT_NV       = 0xE9,
    GL_ROUNDED_RECT2_NV               = 0xEA,
    GL_RELATIVE_ROUNDED_RECT2_NV      = 0xEB,
    GL_ROUNDED_RECT4_NV               = 0xEC,
    GL_RELATIVE_ROUNDED_RECT4_NV      = 0xED,
    GL_ROUNDED_RECT8_NV               = 0xEE,
    GL_RELATIVE_ROUNDED_RECT8_NV      = 0xEF,
    GL_RELATIVE_RECT_NV               = 0xF7,
    GL_FONT_GLYPHS_AVAILABLE_NV       = 0x9368,
    GL_FONT_TARGET_UNAVAILABLE_NV     = 0x9369,
    GL_FONT_UNAVAILABLE_NV            = 0x936A,
    GL_FONT_UNINTELLIGIBLE_NV         = 0x936B,
    GL_CONIC_CURVE_TO_NV              = 0x1A,
    GL_RELATIVE_CONIC_CURVE_TO_NV     = 0x1B,
    GL_FONT_NUM_GLYPH_INDICES_BIT_NV  = 0x20000000,
    GL_STANDARD_FONT_FORMAT_NV        = 0x936C,
    GL_PATH_PROJECTION_NV             = 0x1701,
    GL_PATH_MODELVIEW_NV              = 0x1700,
    GL_PATH_MODELVIEW_STACK_DEPTH_NV  = 0x0BA3,
    GL_PATH_MODELVIEW_MATRIX_NV       = 0x0BA6,
    GL_PATH_MAX_MODELVIEW_STACK_DEPTH_NV = 0x0D36,
    GL_PATH_TRANSPOSE_MODELVIEW_MATRIX_NV = 0x84E3,
    GL_PATH_PROJECTION_STACK_DEPTH_NV = 0x0BA4,
    GL_PATH_PROJECTION_MATRIX_NV      = 0x0BA7,
    GL_PATH_MAX_PROJECTION_STACK_DEPTH_NV = 0x0D38,
    GL_PATH_TRANSPOSE_PROJECTION_MATRIX_NV = 0x84E4,
    GL_FRAGMENT_INPUT_NV              = 0x936D
};
typedef GLuint (* PFNGLGENPATHSNVPROC) (GLsizei range);
typedef void (* PFNGLDELETEPATHSNVPROC) (GLuint path, GLsizei range);
typedef GLboolean (* PFNGLISPATHNVPROC) (GLuint path);
typedef void (* PFNGLPATHCOMMANDSNVPROC) (GLuint path, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void (* PFNGLPATHCOORDSNVPROC) (GLuint path, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void (* PFNGLPATHSUBCOMMANDSNVPROC) (GLuint path, GLsizei commandStart, GLsizei commandsToDelete, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void (* PFNGLPATHSUBCOORDSNVPROC) (GLuint path, GLsizei coordStart, GLsizei numCoords, GLenum coordType, const void *coords);
typedef void (* PFNGLPATHSTRINGNVPROC) (GLuint path, GLenum format, GLsizei length, const void *pathString);
typedef void (* PFNGLPATHGLYPHSNVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLsizei numGlyphs, GLenum type, const void *charcodes, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef void (* PFNGLPATHGLYPHRANGENVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyph, GLsizei numGlyphs, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef void (* PFNGLWEIGHTPATHSNVPROC) (GLuint resultPath, GLsizei numPaths, const GLuint *paths, const GLfloat *weights);
typedef void (* PFNGLCOPYPATHNVPROC) (GLuint resultPath, GLuint srcPath);
typedef void (* PFNGLINTERPOLATEPATHSNVPROC) (GLuint resultPath, GLuint pathA, GLuint pathB, GLfloat weight);
typedef void (* PFNGLTRANSFORMPATHNVPROC) (GLuint resultPath, GLuint srcPath, GLenum transformType, const GLfloat *transformValues);
typedef void (* PFNGLPATHPARAMETERIVNVPROC) (GLuint path, GLenum pname, const GLint *value);
typedef void (* PFNGLPATHPARAMETERINVPROC) (GLuint path, GLenum pname, GLint value);
typedef void (* PFNGLPATHPARAMETERFVNVPROC) (GLuint path, GLenum pname, const GLfloat *value);
typedef void (* PFNGLPATHPARAMETERFNVPROC) (GLuint path, GLenum pname, GLfloat value);
typedef void (* PFNGLPATHDASHARRAYNVPROC) (GLuint path, GLsizei dashCount, const GLfloat *dashArray);
typedef void (* PFNGLPATHSTENCILFUNCNVPROC) (GLenum func, GLint ref, GLuint mask);
typedef void (* PFNGLPATHSTENCILDEPTHOFFSETNVPROC) (GLfloat factor, GLfloat units);
typedef void (* PFNGLSTENCILFILLPATHNVPROC) (GLuint path, GLenum fillMode, GLuint mask);
typedef void (* PFNGLSTENCILSTROKEPATHNVPROC) (GLuint path, GLint reference, GLuint mask);
typedef void (* PFNGLSTENCILFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum transformType, const GLfloat *transformValues);
typedef void (* PFNGLSTENCILSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum transformType, const GLfloat *transformValues);
typedef void (* PFNGLPATHCOVERDEPTHFUNCNVPROC) (GLenum func);
typedef void (* PFNGLCOVERFILLPATHNVPROC) (GLuint path, GLenum coverMode);
typedef void (* PFNGLCOVERSTROKEPATHNVPROC) (GLuint path, GLenum coverMode);
typedef void (* PFNGLCOVERFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef void (* PFNGLCOVERSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef void (* PFNGLGETPATHPARAMETERIVNVPROC) (GLuint path, GLenum pname, GLint *value);
typedef void (* PFNGLGETPATHPARAMETERFVNVPROC) (GLuint path, GLenum pname, GLfloat *value);
typedef void (* PFNGLGETPATHCOMMANDSNVPROC) (GLuint path, GLubyte *commands);
typedef void (* PFNGLGETPATHCOORDSNVPROC) (GLuint path, GLfloat *coords);
typedef void (* PFNGLGETPATHDASHARRAYNVPROC) (GLuint path, GLfloat *dashArray);
typedef void (* PFNGLGETPATHMETRICSNVPROC) (GLbitfield metricQueryMask, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLsizei stride, GLfloat *metrics);
typedef void (* PFNGLGETPATHMETRICRANGENVPROC) (GLbitfield metricQueryMask, GLuint firstPathName, GLsizei numPaths, GLsizei stride, GLfloat *metrics);
typedef void (* PFNGLGETPATHSPACINGNVPROC) (GLenum pathListMode, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLfloat advanceScale, GLfloat kerningScale, GLenum transformType, GLfloat *returnedSpacing);
typedef GLboolean (* PFNGLISPOINTINFILLPATHNVPROC) (GLuint path, GLuint mask, GLfloat x, GLfloat y);
typedef GLboolean (* PFNGLISPOINTINSTROKEPATHNVPROC) (GLuint path, GLfloat x, GLfloat y);
typedef GLfloat (* PFNGLGETPATHLENGTHNVPROC) (GLuint path, GLsizei startSegment, GLsizei numSegments);
typedef GLboolean (* PFNGLPOINTALONGPATHNVPROC) (GLuint path, GLsizei startSegment, GLsizei numSegments, GLfloat distance, GLfloat *x, GLfloat *y, GLfloat *tangentX, GLfloat *tangentY);
typedef void (* PFNGLMATRIXLOAD3X2FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void (* PFNGLMATRIXLOAD3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void (* PFNGLMATRIXLOADTRANSPOSE3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void (* PFNGLMATRIXMULT3X2FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void (* PFNGLMATRIXMULT3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void (* PFNGLMATRIXMULTTRANSPOSE3X3FNVPROC) (GLenum matrixMode, const GLfloat *m);
typedef void (* PFNGLSTENCILTHENCOVERFILLPATHNVPROC) (GLuint path, GLenum fillMode, GLuint mask, GLenum coverMode);
typedef void (* PFNGLSTENCILTHENCOVERSTROKEPATHNVPROC) (GLuint path, GLint reference, GLuint mask, GLenum coverMode);
typedef void (* PFNGLSTENCILTHENCOVERFILLPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef void (* PFNGLSTENCILTHENCOVERSTROKEPATHINSTANCEDNVPROC) (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
typedef GLenum (* PFNGLPATHGLYPHINDEXRANGENVPROC) (GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint pathParameterTemplate, GLfloat emScale, GLuint baseAndCount[2]);
typedef GLenum (* PFNGLPATHGLYPHINDEXARRAYNVPROC) (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef GLenum (* PFNGLPATHMEMORYGLYPHINDEXARRAYNVPROC) (GLuint firstPathName, GLenum fontTarget, GLsizeiptr fontSize, const void *fontData, GLsizei faceIndex, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
typedef void (* PFNGLPROGRAMPATHFRAGMENTINPUTGENNVPROC) (GLuint program, GLint location, GLenum genMode, GLint components, const GLfloat *coeffs);
typedef void (* PFNGLGETPROGRAMRESOURCEFVNVPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLfloat *params);

GLuint glGenPathsNV (GLsizei range);
void glDeletePathsNV (GLuint path, GLsizei range);
GLboolean glIsPathNV (GLuint path);
void glPathCommandsNV (GLuint path, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);
void glPathCoordsNV (GLuint path, GLsizei numCoords, GLenum coordType, const void *coords);
void glPathSubCommandsNV (GLuint path, GLsizei commandStart, GLsizei commandsToDelete, GLsizei numCommands, const GLubyte *commands, GLsizei numCoords, GLenum coordType, const void *coords);
void glPathSubCoordsNV (GLuint path, GLsizei coordStart, GLsizei numCoords, GLenum coordType, const void *coords);
void glPathStringNV (GLuint path, GLenum format, GLsizei length, const void *pathString);
void glPathGlyphsNV (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLsizei numGlyphs, GLenum type, const void *charcodes, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
void glPathGlyphRangeNV (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyph, GLsizei numGlyphs, GLenum handleMissingGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
void glWeightPathsNV (GLuint resultPath, GLsizei numPaths, const GLuint *paths, const GLfloat *weights);
void glCopyPathNV (GLuint resultPath, GLuint srcPath);
void glInterpolatePathsNV (GLuint resultPath, GLuint pathA, GLuint pathB, GLfloat weight);
void glTransformPathNV (GLuint resultPath, GLuint srcPath, GLenum transformType, const GLfloat *transformValues);
void glPathParameterivNV (GLuint path, GLenum pname, const GLint *value);
void glPathParameteriNV (GLuint path, GLenum pname, GLint value);
void glPathParameterfvNV (GLuint path, GLenum pname, const GLfloat *value);
void glPathParameterfNV (GLuint path, GLenum pname, GLfloat value);
void glPathDashArrayNV (GLuint path, GLsizei dashCount, const GLfloat *dashArray);
void glPathStencilFuncNV (GLenum func, GLint ref, GLuint mask);
void glPathStencilDepthOffsetNV (GLfloat factor, GLfloat units);
void glStencilFillPathNV (GLuint path, GLenum fillMode, GLuint mask);
void glStencilStrokePathNV (GLuint path, GLint reference, GLuint mask);
void glStencilFillPathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum transformType, const GLfloat *transformValues);
void glStencilStrokePathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum transformType, const GLfloat *transformValues);
void glPathCoverDepthFuncNV (GLenum func);
void glCoverFillPathNV (GLuint path, GLenum coverMode);
void glCoverStrokePathNV (GLuint path, GLenum coverMode);
void glCoverFillPathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
void glCoverStrokePathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
void glGetPathParameterivNV (GLuint path, GLenum pname, GLint *value);
void glGetPathParameterfvNV (GLuint path, GLenum pname, GLfloat *value);
void glGetPathCommandsNV (GLuint path, GLubyte *commands);
void glGetPathCoordsNV (GLuint path, GLfloat *coords);
void glGetPathDashArrayNV (GLuint path, GLfloat *dashArray);
void glGetPathMetricsNV (GLbitfield metricQueryMask, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLsizei stride, GLfloat *metrics);
void glGetPathMetricRangeNV (GLbitfield metricQueryMask, GLuint firstPathName, GLsizei numPaths, GLsizei stride, GLfloat *metrics);
void glGetPathSpacingNV (GLenum pathListMode, GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLfloat advanceScale, GLfloat kerningScale, GLenum transformType, GLfloat *returnedSpacing);
GLboolean glIsPointInFillPathNV (GLuint path, GLuint mask, GLfloat x, GLfloat y);
GLboolean glIsPointInStrokePathNV (GLuint path, GLfloat x, GLfloat y);
GLfloat glGetPathLengthNV (GLuint path, GLsizei startSegment, GLsizei numSegments);
GLboolean glPointAlongPathNV (GLuint path, GLsizei startSegment, GLsizei numSegments, GLfloat distance, GLfloat *x, GLfloat *y, GLfloat *tangentX, GLfloat *tangentY);
void glMatrixLoad3x2fNV (GLenum matrixMode, const GLfloat *m);
void glMatrixLoad3x3fNV (GLenum matrixMode, const GLfloat *m);
void glMatrixLoadTranspose3x3fNV (GLenum matrixMode, const GLfloat *m);
void glMatrixMult3x2fNV (GLenum matrixMode, const GLfloat *m);
void glMatrixMult3x3fNV (GLenum matrixMode, const GLfloat *m);
void glMatrixMultTranspose3x3fNV (GLenum matrixMode, const GLfloat *m);
void glStencilThenCoverFillPathNV (GLuint path, GLenum fillMode, GLuint mask, GLenum coverMode);
void glStencilThenCoverStrokePathNV (GLuint path, GLint reference, GLuint mask, GLenum coverMode);
void glStencilThenCoverFillPathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLenum fillMode, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
void glStencilThenCoverStrokePathInstancedNV (GLsizei numPaths, GLenum pathNameType, const void *paths, GLuint pathBase, GLint reference, GLuint mask, GLenum coverMode, GLenum transformType, const GLfloat *transformValues);
GLenum glPathGlyphIndexRangeNV (GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint pathParameterTemplate, GLfloat emScale, GLuint baseAndCount[2]);
GLenum glPathGlyphIndexArrayNV (GLuint firstPathName, GLenum fontTarget, const void *fontName, GLbitfield fontStyle, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
GLenum glPathMemoryGlyphIndexArrayNV (GLuint firstPathName, GLenum fontTarget, GLsizeiptr fontSize, const void *fontData, GLsizei faceIndex, GLuint firstGlyphIndex, GLsizei numGlyphs, GLuint pathParameterTemplate, GLfloat emScale);
void glProgramPathFragmentInputGenNV (GLuint program, GLint location, GLenum genMode, GLint components, const GLfloat *coeffs);
void glGetProgramResourcefvNV (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei count, GLsizei *length, GLfloat *params);

enum {
    GL_NV_path_rendering_shared_edge  = 1,
    GL_SHARED_EDGE_NV                 = 0xC0
};

enum {
    GL_NV_representative_fragment_test = 1,
    GL_REPRESENTATIVE_FRAGMENT_TEST_NV = 0x937F
};

enum {
    GL_NV_sample_locations = 1,
    GL_SAMPLE_LOCATION_SUBPIXEL_BITS_NV = 0x933D,
    GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_NV = 0x933E,
    GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_NV = 0x933F,
    GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_NV = 0x9340,
    GL_SAMPLE_LOCATION_NV             = 0x8E50,
    GL_PROGRAMMABLE_SAMPLE_LOCATION_NV = 0x9341,
    GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_NV = 0x9342,
    GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_NV = 0x9343
};
typedef void (* PFNGLFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLenum target, GLuint start, GLsizei count, const GLfloat *v);
typedef void (* PFNGLNAMEDFRAMEBUFFERSAMPLELOCATIONSFVNVPROC) (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
typedef void (* PFNGLRESOLVEDEPTHVALUESNVPROC) (void);
void glFramebufferSampleLocationsfvNV (GLenum target, GLuint start, GLsizei count, const GLfloat *v);
void glNamedFramebufferSampleLocationsfvNV (GLuint framebuffer, GLuint start, GLsizei count, const GLfloat *v);
void glResolveDepthValuesNV (void);

enum { GL_NV_sample_mask_override_coverage = 1 };
enum {
    GL_NV_scissor_exclusive           = 1,
    GL_SCISSOR_TEST_EXCLUSIVE_NV      = 0x9555,
    GL_SCISSOR_BOX_EXCLUSIVE_NV       = 0x9556
};
typedef void (* PFNGLSCISSOREXCLUSIVENVPROC) (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLSCISSOREXCLUSIVEARRAYVNVPROC) (GLuint first, GLsizei count, const GLint *v);
void glScissorExclusiveNV (GLint x, GLint y, GLsizei width, GLsizei height);
void glScissorExclusiveArrayvNV (GLuint first, GLsizei count, const GLint *v);

enum { GL_NV_shader_atomic_counters = 1 };
enum { GL_NV_shader_atomic_float = 1 };
enum { GL_NV_shader_atomic_float64 = 1 };
enum { GL_NV_shader_atomic_fp16_vector = 1 };
enum { GL_NV_shader_atomic_int64 = 1 };
enum {
    GL_NV_shader_buffer_load          = 1,
    GL_BUFFER_GPU_ADDRESS_NV          = 0x8F1D,
    GL_GPU_ADDRESS_NV                 = 0x8F34,
    GL_MAX_SHADER_BUFFER_ADDRESS_NV   = 0x8F35
};
typedef void (* PFNGLMAKEBUFFERRESIDENTNVPROC) (GLenum target, GLenum access);
typedef void (* PFNGLMAKEBUFFERNONRESIDENTNVPROC) (GLenum target);
typedef GLboolean (* PFNGLISBUFFERRESIDENTNVPROC) (GLenum target);
typedef void (* PFNGLMAKENAMEDBUFFERRESIDENTNVPROC) (GLuint buffer, GLenum access);
typedef void (* PFNGLMAKENAMEDBUFFERNONRESIDENTNVPROC) (GLuint buffer);
typedef GLboolean (* PFNGLISNAMEDBUFFERRESIDENTNVPROC) (GLuint buffer);
typedef void (* PFNGLGETBUFFERPARAMETERUI64VNVPROC) (GLenum target, GLenum pname, GLuint64EXT *params);
typedef void (* PFNGLGETNAMEDBUFFERPARAMETERUI64VNVPROC) (GLuint buffer, GLenum pname, GLuint64EXT *params);
typedef void (* PFNGLGETINTEGERUI64VNVPROC) (GLenum value, GLuint64EXT *result);
typedef void (* PFNGLUNIFORMUI64NVPROC) (GLint location, GLuint64EXT value);
typedef void (* PFNGLUNIFORMUI64VNVPROC) (GLint location, GLsizei count, const GLuint64EXT *value);
typedef void (* PFNGLGETUNIFORMUI64VNVPROC) (GLuint program, GLint location, GLuint64EXT *params);
typedef void (* PFNGLPROGRAMUNIFORMUI64NVPROC) (GLuint program, GLint location, GLuint64EXT value);
typedef void (* PFNGLPROGRAMUNIFORMUI64VNVPROC) (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);

void glMakeBufferResidentNV (GLenum target, GLenum access);
void glMakeBufferNonResidentNV (GLenum target);
GLboolean glIsBufferResidentNV (GLenum target);
void glMakeNamedBufferResidentNV (GLuint buffer, GLenum access);
void glMakeNamedBufferNonResidentNV (GLuint buffer);
GLboolean glIsNamedBufferResidentNV (GLuint buffer);
void glGetBufferParameterui64vNV (GLenum target, GLenum pname, GLuint64EXT *params);
void glGetNamedBufferParameterui64vNV (GLuint buffer, GLenum pname, GLuint64EXT *params);
void glGetIntegerui64vNV (GLenum value, GLuint64EXT *result);
void glUniformui64NV (GLint location, GLuint64EXT value);
void glUniformui64vNV (GLint location, GLsizei count, const GLuint64EXT *value);
void glGetUniformui64vNV (GLuint program, GLint location, GLuint64EXT *params);
void glProgramUniformui64NV (GLuint program, GLint location, GLuint64EXT value);
void glProgramUniformui64vNV (GLuint program, GLint location, GLsizei count, const GLuint64EXT *value);

enum {
    GL_NV_shader_buffer_store              = 1,
    GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV = 0x00000010
};

enum {
    GL_NV_shader_subgroup_partitioned      = 1,
    GL_SUBGROUP_FEATURE_PARTITIONED_BIT_NV = 0x00000100
};

enum { GL_NV_shader_texture_footprint = 1 };
enum {
    GL_NV_shader_thread_group         = 1,
    GL_WARP_SIZE_NV                   = 0x9339,
    GL_WARPS_PER_SM_NV                = 0x933A,
    GL_SM_COUNT_NV                    = 0x933B
};

enum { GL_NV_shader_thread_shuffle = 1 };
enum {
    GL_NV_shading_rate_image          = 1,
    GL_SHADING_RATE_IMAGE_NV          = 0x9563,
    GL_SHADING_RATE_NO_INVOCATIONS_NV = 0x9564,
    GL_SHADING_RATE_1_INVOCATION_PER_PIXEL_NV = 0x9565,
    GL_SHADING_RATE_1_INVOCATION_PER_1X2_PIXELS_NV = 0x9566,
    GL_SHADING_RATE_1_INVOCATION_PER_2X1_PIXELS_NV = 0x9567,
    GL_SHADING_RATE_1_INVOCATION_PER_2X2_PIXELS_NV = 0x9568,
    GL_SHADING_RATE_1_INVOCATION_PER_2X4_PIXELS_NV = 0x9569,
    GL_SHADING_RATE_1_INVOCATION_PER_4X2_PIXELS_NV = 0x956A,
    GL_SHADING_RATE_1_INVOCATION_PER_4X4_PIXELS_NV = 0x956B,
    GL_SHADING_RATE_2_INVOCATIONS_PER_PIXEL_NV = 0x956C,
    GL_SHADING_RATE_4_INVOCATIONS_PER_PIXEL_NV = 0x956D,
    GL_SHADING_RATE_8_INVOCATIONS_PER_PIXEL_NV = 0x956E,
    GL_SHADING_RATE_16_INVOCATIONS_PER_PIXEL_NV = 0x956F,
    GL_SHADING_RATE_IMAGE_BINDING_NV  = 0x955B,
    GL_SHADING_RATE_IMAGE_TEXEL_WIDTH_NV = 0x955C,
    GL_SHADING_RATE_IMAGE_TEXEL_HEIGHT_NV = 0x955D,
    GL_SHADING_RATE_IMAGE_PALETTE_SIZE_NV = 0x955E,
    GL_MAX_COARSE_FRAGMENT_SAMPLES_NV = 0x955F,
    GL_SHADING_RATE_SAMPLE_ORDER_DEFAULT_NV = 0x95AE,
    GL_SHADING_RATE_SAMPLE_ORDER_PIXEL_MAJOR_NV = 0x95AF,
    GL_SHADING_RATE_SAMPLE_ORDER_SAMPLE_MAJOR_NV = 0x95B0
};
typedef void (* PFNGLBINDSHADINGRATEIMAGENVPROC) (GLuint texture);
typedef void (* PFNGLGETSHADINGRATEIMAGEPALETTENVPROC) (GLuint viewport, GLuint entry, GLenum *rate);
typedef void (* PFNGLGETSHADINGRATESAMPLELOCATIONIVNVPROC) (GLenum rate, GLuint samples, GLuint index, GLint *location);
typedef void (* PFNGLSHADINGRATEIMAGEBARRIERNVPROC) (GLboolean synchronize);
typedef void (* PFNGLSHADINGRATEIMAGEPALETTENVPROC) (GLuint viewport, GLuint first, GLsizei count, const GLenum *rates);
typedef void (* PFNGLSHADINGRATESAMPLEORDERNVPROC) (GLenum order);
typedef void (* PFNGLSHADINGRATESAMPLEORDERCUSTOMNVPROC) (GLenum rate, GLuint samples, const GLint *locations);

void glBindShadingRateImageNV (GLuint texture);
void glGetShadingRateImagePaletteNV (GLuint viewport, GLuint entry, GLenum *rate);
void glGetShadingRateSampleLocationivNV (GLenum rate, GLuint samples, GLuint index, GLint *location);
void glShadingRateImageBarrierNV (GLboolean synchronize);
void glShadingRateImagePaletteNV (GLuint viewport, GLuint first, GLsizei count, const GLenum *rates);
void glShadingRateSampleOrderNV (GLenum order);
void glShadingRateSampleOrderCustomNV (GLenum rate, GLuint samples, const GLint *locations);

enum { GL_NV_stereo_view_rendering = 1 };

enum { GL_NV_texture_barrier = 1 };
typedef void (* PFNGLTEXTUREBARRIERNVPROC) (void);
void glTextureBarrierNV (void);

enum { GL_NV_texture_rectangle_compressed = 1 };
enum {
    GL_NV_uniform_buffer_unified_memory = 1,
    GL_UNIFORM_BUFFER_UNIFIED_NV      = 0x936E,
    GL_UNIFORM_BUFFER_ADDRESS_NV      = 0x936F,
    GL_UNIFORM_BUFFER_LENGTH_NV       = 0x9370
};

enum { GL_NV_vertex_attrib_integer_64bit = 1 };
typedef void (* PFNGLVERTEXATTRIBL1I64NVPROC) (GLuint index, GLint64EXT x);
typedef void (* PFNGLVERTEXATTRIBL2I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y);
typedef void (* PFNGLVERTEXATTRIBL3I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z);
typedef void (* PFNGLVERTEXATTRIBL4I64NVPROC) (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
typedef void (* PFNGLVERTEXATTRIBL1I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL2I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL3I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL4I64VNVPROC) (GLuint index, const GLint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL1UI64NVPROC) (GLuint index, GLuint64EXT x);
typedef void (* PFNGLVERTEXATTRIBL2UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y);
typedef void (* PFNGLVERTEXATTRIBL3UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
typedef void (* PFNGLVERTEXATTRIBL4UI64NVPROC) (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
typedef void (* PFNGLVERTEXATTRIBL1UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL2UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL3UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void (* PFNGLVERTEXATTRIBL4UI64VNVPROC) (GLuint index, const GLuint64EXT *v);
typedef void (* PFNGLGETVERTEXATTRIBLI64VNVPROC) (GLuint index, GLenum pname, GLint64EXT *params);
typedef void (* PFNGLGETVERTEXATTRIBLUI64VNVPROC) (GLuint index, GLenum pname, GLuint64EXT *params);
typedef void (* PFNGLVERTEXATTRIBLFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLsizei stride);

void glVertexAttribL1i64NV (GLuint index, GLint64EXT x);
void glVertexAttribL2i64NV (GLuint index, GLint64EXT x, GLint64EXT y);
void glVertexAttribL3i64NV (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z);
void glVertexAttribL4i64NV (GLuint index, GLint64EXT x, GLint64EXT y, GLint64EXT z, GLint64EXT w);
void glVertexAttribL1i64vNV (GLuint index, const GLint64EXT *v);
void glVertexAttribL2i64vNV (GLuint index, const GLint64EXT *v);
void glVertexAttribL3i64vNV (GLuint index, const GLint64EXT *v);
void glVertexAttribL4i64vNV (GLuint index, const GLint64EXT *v);
void glVertexAttribL1ui64NV (GLuint index, GLuint64EXT x);
void glVertexAttribL2ui64NV (GLuint index, GLuint64EXT x, GLuint64EXT y);
void glVertexAttribL3ui64NV (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z);
void glVertexAttribL4ui64NV (GLuint index, GLuint64EXT x, GLuint64EXT y, GLuint64EXT z, GLuint64EXT w);
void glVertexAttribL1ui64vNV (GLuint index, const GLuint64EXT *v);
void glVertexAttribL2ui64vNV (GLuint index, const GLuint64EXT *v);
void glVertexAttribL3ui64vNV (GLuint index, const GLuint64EXT *v);
void glVertexAttribL4ui64vNV (GLuint index, const GLuint64EXT *v);
void glGetVertexAttribLi64vNV (GLuint index, GLenum pname, GLint64EXT *params);
void glGetVertexAttribLui64vNV (GLuint index, GLenum pname, GLuint64EXT *params);
void glVertexAttribLFormatNV (GLuint index, GLint size, GLenum type, GLsizei stride);

enum {
    GL_NV_vertex_buffer_unified_memory = 1,
    GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV = 0x8F1E,
    GL_ELEMENT_ARRAY_UNIFIED_NV       = 0x8F1F,
    GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV = 0x8F20,
    GL_VERTEX_ARRAY_ADDRESS_NV        = 0x8F21,
    GL_NORMAL_ARRAY_ADDRESS_NV        = 0x8F22,
    GL_COLOR_ARRAY_ADDRESS_NV         = 0x8F23,
    GL_INDEX_ARRAY_ADDRESS_NV         = 0x8F24,
    GL_TEXTURE_COORD_ARRAY_ADDRESS_NV = 0x8F25,
    GL_EDGE_FLAG_ARRAY_ADDRESS_NV     = 0x8F26,
    GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV = 0x8F27,
    GL_FOG_COORD_ARRAY_ADDRESS_NV     = 0x8F28,
    GL_ELEMENT_ARRAY_ADDRESS_NV       = 0x8F29,
    GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV  = 0x8F2A,
    GL_VERTEX_ARRAY_LENGTH_NV         = 0x8F2B,
    GL_NORMAL_ARRAY_LENGTH_NV         = 0x8F2C,
    GL_COLOR_ARRAY_LENGTH_NV          = 0x8F2D,
    GL_INDEX_ARRAY_LENGTH_NV          = 0x8F2E,
    GL_TEXTURE_COORD_ARRAY_LENGTH_NV  = 0x8F2F,
    GL_EDGE_FLAG_ARRAY_LENGTH_NV      = 0x8F30,
    GL_SECONDARY_COLOR_ARRAY_LENGTH_NV = 0x8F31,
    GL_FOG_COORD_ARRAY_LENGTH_NV      = 0x8F32,
    GL_ELEMENT_ARRAY_LENGTH_NV        = 0x8F33,
    GL_DRAW_INDIRECT_UNIFIED_NV       = 0x8F40,
    GL_DRAW_INDIRECT_ADDRESS_NV       = 0x8F41,
    GL_DRAW_INDIRECT_LENGTH_NV        = 0x8F42
};
typedef void (* PFNGLBUFFERADDRESSRANGENVPROC) (GLenum pname, GLuint index, GLuint64EXT address, GLsizeiptr length);
typedef void (* PFNGLVERTEXFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void (* PFNGLNORMALFORMATNVPROC) (GLenum type, GLsizei stride);
typedef void (* PFNGLCOLORFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void (* PFNGLINDEXFORMATNVPROC) (GLenum type, GLsizei stride);
typedef void (* PFNGLTEXCOORDFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void (* PFNGLEDGEFLAGFORMATNVPROC) (GLsizei stride);
typedef void (* PFNGLSECONDARYCOLORFORMATNVPROC) (GLint size, GLenum type, GLsizei stride);
typedef void (* PFNGLFOGCOORDFORMATNVPROC) (GLenum type, GLsizei stride);
typedef void (* PFNGLVERTEXATTRIBFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride);
typedef void (* PFNGLVERTEXATTRIBIFORMATNVPROC) (GLuint index, GLint size, GLenum type, GLsizei stride);
typedef void (* PFNGLGETINTEGERUI64I_VNVPROC) (GLenum value, GLuint index, GLuint64EXT *result);

void glBufferAddressRangeNV (GLenum pname, GLuint index, GLuint64EXT address, GLsizeiptr length);
void glVertexFormatNV (GLint size, GLenum type, GLsizei stride);
void glNormalFormatNV (GLenum type, GLsizei stride);
void glColorFormatNV (GLint size, GLenum type, GLsizei stride);
void glIndexFormatNV (GLenum type, GLsizei stride);
void glTexCoordFormatNV (GLint size, GLenum type, GLsizei stride);
void glEdgeFlagFormatNV (GLsizei stride);
void glSecondaryColorFormatNV (GLint size, GLenum type, GLsizei stride);
void glFogCoordFormatNV (GLenum type, GLsizei stride);
void glVertexAttribFormatNV (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride);
void glVertexAttribIFormatNV (GLuint index, GLint size, GLenum type, GLsizei stride);
void glGetIntegerui64i_vNV (GLenum value, GLuint index, GLuint64EXT *result);

enum { GL_NV_viewport_array2 = 1 };
enum {
    GL_NV_viewport_swizzle            = 1,
    GL_VIEWPORT_SWIZZLE_POSITIVE_X_NV = 0x9350,
    GL_VIEWPORT_SWIZZLE_NEGATIVE_X_NV = 0x9351,
    GL_VIEWPORT_SWIZZLE_POSITIVE_Y_NV = 0x9352,
    GL_VIEWPORT_SWIZZLE_NEGATIVE_Y_NV = 0x9353,
    GL_VIEWPORT_SWIZZLE_POSITIVE_Z_NV = 0x9354,
    GL_VIEWPORT_SWIZZLE_NEGATIVE_Z_NV = 0x9355,
    GL_VIEWPORT_SWIZZLE_POSITIVE_W_NV = 0x9356,
    GL_VIEWPORT_SWIZZLE_NEGATIVE_W_NV = 0x9357,
    GL_VIEWPORT_SWIZZLE_X_NV          = 0x9358,
    GL_VIEWPORT_SWIZZLE_Y_NV          = 0x9359,
    GL_VIEWPORT_SWIZZLE_Z_NV          = 0x935A,
    GL_VIEWPORT_SWIZZLE_W_NV          = 0x935B
};
typedef void (* PFNGLVIEWPORTSWIZZLENVPROC) (GLuint index, GLenum swizzlex, GLenum swizzley, GLenum swizzlez, GLenum swizzlew);
void glViewportSwizzleNV (GLuint index, GLenum swizzlex, GLenum swizzley, GLenum swizzlez, GLenum swizzlew);

enum {
    GL_OVR_multiview = 1,
    GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_NUM_VIEWS_OVR = 0x9630,
    GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_BASE_VIEW_INDEX_OVR = 0x9632,
    GL_MAX_VIEWS_OVR                  = 0x9631,
    GL_FRAMEBUFFER_INCOMPLETE_VIEW_TARGETS_OVR = 0x9633
};
typedef void (* PFNGLFRAMEBUFFERTEXTUREMULTIVIEWOVRPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint baseViewIndex, GLsizei numViews);
void glFramebufferTextureMultiviewOVR (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint baseViewIndex, GLsizei numViews);

enum { GL_OVR_multiview2 = 1 };

]])

gl = ffi.load(lwlgl.libs.gl[2])

end

function load_glu()

ffi.cdef([[

/*
** License Applicability. Except to the extent portions of this file are
** made subject to an alternative license as permitted in the SGI Free
** Software License B, Version 1.1 (the "License"), the contents of this
** file are subject only to the provisions of the License. You may not use
** this file except in compliance with the License. You may obtain a copy
** of the License at Silicon Graphics, Inc., attn: Legal Services, 1600
** Amphitheatre Parkway, Mountain View, CA 94043-1351, or at:
** 
** http://oss.sgi.com/projects/FreeB
** 
** Note that, as provided in the License, the Software is distributed on an
** "AS IS" basis, with ALL EXPRESS AND IMPLIED WARRANTIES AND CONDITIONS
** DISCLAIMED, INCLUDING, WITHOUT LIMITATION, ANY IMPLIED WARRANTIES AND
** CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A
** PARTICULAR PURPOSE, AND NON-INFRINGEMENT.
** 
** Original Code. The Original Code is: OpenGL Sample Implementation,
** Version 1.2.1, released January 26, 2000, developed by Silicon Graphics,
** Inc. The Original Code is Copyright (c) 1991-2000 Silicon Graphics, Inc.
** Copyright in any portions created by third parties is as indicated
** elsewhere herein. All Rights Reserved.
** 
** Additional Notice Provisions: This software was created using the
** OpenGL(R) version 1.2.1 Sample Implementation published by SGI, but has
** not been independently verified as being compliant with the OpenGL(R)
** version 1.2.1 Specification.
*/

/*
 * 2002-Apr-15, Marcus Geelnard:
 *   Changed GLAPIENTRY to APIENTRY.
 */

typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef void GLvoid;
typedef signed char	GLbyte;
typedef short GLshort;
typedef int GLint;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef int GLsizei;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef double GLclampd;
typedef void GLhandleARB;
typedef const char* GLcharARB;

enum {
    GLU_EXT_object_space_tess          = 1,
    GLU_EXT_nurbs_tessellator          = 1,

    GLU_FALSE                          = 0,
    GLU_TRUE                           = 1,

    GLU_VERSION_1_1                    = 1,
    GLU_VERSION_1_2                    = 1,
    GLU_VERSION_1_3                    = 1,

    GLU_VERSION                        = 100800,
    GLU_EXTENSIONS                     = 100801,

    GLU_INVALID_ENUM                   = 100900,
    GLU_INVALID_VALUE                  = 100901,
    GLU_OUT_OF_MEMORY                  = 100902,
    GLU_INVALID_OPERATION              = 100904,

    GLU_OUTLINE_POLYGON                = 100240,
    GLU_OUTLINE_PATCH                  = 100241,

    GLU_NURBS_ERROR                    = 100103,
    GLU_ERROR                          = 100103,
    GLU_NURBS_BEGIN                    = 100164,
    GLU_NURBS_BEGIN_EXT                = 100164,
    GLU_NURBS_VERTEX                   = 100165,
    GLU_NURBS_VERTEX_EXT               = 100165,
    GLU_NURBS_NORMAL                   = 100166,
    GLU_NURBS_NORMAL_EXT               = 100166,
    GLU_NURBS_COLOR                    = 100167,
    GLU_NURBS_COLOR_EXT                = 100167,
    GLU_NURBS_TEXTURE_COORD            = 100168,
    GLU_NURBS_TEX_COORD_EXT            = 100168,
    GLU_NURBS_END                      = 100169,
    GLU_NURBS_END_EXT                  = 100169,
    GLU_NURBS_BEGIN_DATA               = 100170,
    GLU_NURBS_BEGIN_DATA_EXT           = 100170,
    GLU_NURBS_VERTEX_DATA              = 100171,
    GLU_NURBS_VERTEX_DATA_EXT          = 100171,
    GLU_NURBS_NORMAL_DATA              = 100172,
    GLU_NURBS_NORMAL_DATA_EXT          = 100172,
    GLU_NURBS_COLOR_DATA               = 100173,
    GLU_NURBS_COLOR_DATA_EXT           = 100173,
    GLU_NURBS_TEXTURE_COORD_DATA       = 100174,
    GLU_NURBS_TEX_COORD_DATA_EXT       = 100174,
    GLU_NURBS_END_DATA                 = 100175,
    GLU_NURBS_END_DATA_EXT             = 100175,

    GLU_NURBS_ERROR1                   = 100251,
    GLU_NURBS_ERROR2                   = 100252,
    GLU_NURBS_ERROR3                   = 100253,
    GLU_NURBS_ERROR4                   = 100254,
    GLU_NURBS_ERROR5                   = 100255,
    GLU_NURBS_ERROR6                   = 100256,
    GLU_NURBS_ERROR7                   = 100257,
    GLU_NURBS_ERROR8                   = 100258,
    GLU_NURBS_ERROR9                   = 100259,
    GLU_NURBS_ERROR10                  = 100260,
    GLU_NURBS_ERROR11                  = 100261,
    GLU_NURBS_ERROR12                  = 100262,
    GLU_NURBS_ERROR13                  = 100263,
    GLU_NURBS_ERROR14                  = 100264,
    GLU_NURBS_ERROR15                  = 100265,
    GLU_NURBS_ERROR16                  = 100266,
    GLU_NURBS_ERROR17                  = 100267,
    GLU_NURBS_ERROR18                  = 100268,
    GLU_NURBS_ERROR19                  = 100269,
    GLU_NURBS_ERROR20                  = 100270,
    GLU_NURBS_ERROR21                  = 100271,
    GLU_NURBS_ERROR22                  = 100272,
    GLU_NURBS_ERROR23                  = 100273,
    GLU_NURBS_ERROR24                  = 100274,
    GLU_NURBS_ERROR25                  = 100275,
    GLU_NURBS_ERROR26                  = 100276,
    GLU_NURBS_ERROR27                  = 100277,
    GLU_NURBS_ERROR28                  = 100278,
    GLU_NURBS_ERROR29                  = 100279,
    GLU_NURBS_ERROR30                  = 100280,
    GLU_NURBS_ERROR31                  = 100281,
    GLU_NURBS_ERROR32                  = 100282,
    GLU_NURBS_ERROR33                  = 100283,
    GLU_NURBS_ERROR34                  = 100284,
    GLU_NURBS_ERROR35                  = 100285,
    GLU_NURBS_ERROR36                  = 100286,
    GLU_NURBS_ERROR37                  = 100287,

    GLU_AUTO_LOAD_MATRIX               = 100200,
    GLU_CULLING                        = 100201,
    GLU_SAMPLING_TOLERANCE             = 100203,
    GLU_DISPLAY_MODE                   = 100204,
    GLU_PARAMETRIC_TOLERANCE           = 100202,
    GLU_SAMPLING_METHOD                = 100205,
    GLU_U_STEP                         = 100206,
    GLU_V_STEP                         = 100207,
    GLU_NURBS_MODE                     = 100160,
    GLU_NURBS_MODE_EXT                 = 100160,
    GLU_NURBS_TESSELLATOR              = 100161,
    GLU_NURBS_TESSELLATOR_EXT          = 100161,
    GLU_NURBS_RENDERER                 = 100162,
    GLU_NURBS_RENDERER_EXT             = 100162,

    GLU_OBJECT_PARAMETRIC_ERROR        = 100208,
    GLU_OBJECT_PARAMETRIC_ERROR_EXT    = 100208,
    GLU_OBJECT_PATH_LENGTH             = 100209,
    GLU_OBJECT_PATH_LENGTH_EXT         = 100209,
    GLU_PATH_LENGTH                    = 100215,
    GLU_PARAMETRIC_ERROR               = 100216,
    GLU_DOMAIN_DISTANCE                = 100217,

    GLU_MAP1_TRIM_2                    = 100210,
    GLU_MAP1_TRIM_3                    = 100211,

    GLU_POINT                          = 100010,
    GLU_LINE                           = 100011,
    GLU_FILL                           = 100012,
    GLU_SILHOUETTE                     = 100013,

    GLU_SMOOTH                         = 100000,
    GLU_FLAT                           = 100001,
    GLU_NONE                           = 100002,

    GLU_OUTSIDE                        = 100020,
    GLU_INSIDE                         = 100021,

    GLU_TESS_BEGIN                     = 100100,
    GLU_BEGIN                          = 100100,
    GLU_TESS_VERTEX                    = 100101,
    GLU_VERTEX                         = 100101,
    GLU_TESS_END                       = 100102,
    GLU_END                            = 100102,
    GLU_TESS_ERROR                     = 100103,
    GLU_TESS_EDGE_FLAG                 = 100104,
    GLU_EDGE_FLAG                      = 100104,
    GLU_TESS_COMBINE                   = 100105,
    GLU_TESS_BEGIN_DATA                = 100106,
    GLU_TESS_VERTEX_DATA               = 100107,
    GLU_TESS_END_DATA                  = 100108,
    GLU_TESS_ERROR_DATA                = 100109,
    GLU_TESS_EDGE_FLAG_DATA            = 100110,
    GLU_TESS_COMBINE_DATA              = 100111,

    GLU_CW                             = 100120,
    GLU_CCW                            = 100121,
    GLU_INTERIOR                       = 100122,
    GLU_EXTERIOR                       = 100123,
    GLU_UNKNOWN                        = 100124,

    GLU_TESS_WINDING_RULE              = 100140,
    GLU_TESS_BOUNDARY_ONLY             = 100141,
    GLU_TESS_TOLERANCE                 = 100142,

    GLU_TESS_ERROR1                    = 100151,
    GLU_TESS_ERROR2                    = 100152,
    GLU_TESS_ERROR3                    = 100153,
    GLU_TESS_ERROR4                    = 100154,
    GLU_TESS_ERROR5                    = 100155,
    GLU_TESS_ERROR6                    = 100156,
    GLU_TESS_ERROR7                    = 100157,
    GLU_TESS_ERROR8                    = 100158,
    GLU_TESS_MISSING_BEGIN_POLYGON     = 100151,
    GLU_TESS_MISSING_BEGIN_CONTOUR     = 100152,
    GLU_TESS_MISSING_END_POLYGON       = 100153,
    GLU_TESS_MISSING_END_CONTOUR       = 100154,
    GLU_TESS_COORD_TOO_LARGE           = 100155,
    GLU_TESS_NEED_COMBINE_CALLBACK     = 100156,

    GLU_TESS_WINDING_ODD               = 100130,
    GLU_TESS_WINDING_NONZERO           = 100131,
    GLU_TESS_WINDING_POSITIVE          = 100132,
    GLU_TESS_WINDING_NEGATIVE          = 100133,
    GLU_TESS_WINDING_ABS_GEQ_TWO       = 100134
};

typedef struct GLUnurbs GLUnurbs;
typedef struct GLUquadric GLUquadric;
typedef struct GLUtesselator GLUtesselator;
typedef GLUnurbs GLUnurbsObj;
typedef GLUquadric GLUquadricObj;
typedef GLUtesselator GLUtesselatorObj;
typedef GLUtesselator GLUtriangulatorObj;

/* enum { GLU_TESS_MAX_COORD = 9.9999999999999998e+149 }; */
typedef void (*_GLUfuncptr)();

void gluBeginCurve (GLUnurbs* nurb);
void gluBeginPolygon (GLUtesselator* tess);
void gluBeginSurface (GLUnurbs* nurb);
void gluBeginTrim (GLUnurbs* nurb);
GLint gluBuild1DMipmapLevels (GLenum target, GLint internalFormat, GLsizei width, GLenum format, GLenum type, GLint level, GLint base, GLint max, const void *data);
GLint gluBuild1DMipmaps (GLenum target, GLint internalFormat, GLsizei width, GLenum format, GLenum type, const void *data);
GLint gluBuild2DMipmapLevels (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLenum format, GLenum type, GLint level, GLint base, GLint max, const void *data);
GLint gluBuild2DMipmaps (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *data);
GLint gluBuild3DMipmapLevels (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, GLint level, GLint base, GLint max, const void *data);
GLint gluBuild3DMipmaps (GLenum target, GLint internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const void *data);
GLboolean gluCheckExtension (const GLubyte *extName, const GLubyte *extString);
void gluCylinder (GLUquadric* quad, GLdouble base, GLdouble top, GLdouble height, GLint slices, GLint stacks);
void gluDeleteNurbsRenderer (GLUnurbs* nurb);
void gluDeleteQuadric (GLUquadric* quad);
void gluDeleteTess (GLUtesselator* tess);
void gluDisk (GLUquadric* quad, GLdouble inner, GLdouble outer, GLint slices, GLint loops);
void gluEndCurve (GLUnurbs* nurb);
void gluEndPolygon (GLUtesselator* tess);
void gluEndSurface (GLUnurbs* nurb);
void gluEndTrim (GLUnurbs* nurb);
const GLubyte * gluErrorString (GLenum error);
void gluGetNurbsProperty (GLUnurbs* nurb, GLenum property, GLfloat* data);
const GLubyte * gluGetString (GLenum name);
void gluGetTessProperty (GLUtesselator* tess, GLenum which, GLdouble* data);
void gluLoadSamplingMatrices (GLUnurbs* nurb, const GLfloat *model, const GLfloat *perspective, const GLint *view);
void gluLookAt (GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble centerX, GLdouble centerY, GLdouble centerZ, GLdouble upX, GLdouble upY, GLdouble upZ);
GLUnurbs* gluNewNurbsRenderer (void);
GLUquadric* gluNewQuadric (void);
GLUtesselator* gluNewTess (void);
void gluNextContour (GLUtesselator* tess, GLenum type);
void gluNurbsCallback (GLUnurbs* nurb, GLenum which, _GLUfuncptr CallBackFunc);
void gluNurbsCallbackData (GLUnurbs* nurb, GLvoid* userData);
void gluNurbsCallbackDataEXT (GLUnurbs* nurb, GLvoid* userData);
void gluNurbsCurve (GLUnurbs* nurb, GLint knotCount, GLfloat *knots, GLint stride, GLfloat *control, GLint order, GLenum type);
void gluNurbsProperty (GLUnurbs* nurb, GLenum property, GLfloat value);
void gluNurbsSurface (GLUnurbs* nurb, GLint sKnotCount, GLfloat* sKnots, GLint tKnotCount, GLfloat* tKnots, GLint sStride, GLint tStride, GLfloat* control, GLint sOrder, GLint tOrder, GLenum type);
void gluOrtho2D (GLdouble left, GLdouble right, GLdouble bottom, GLdouble top);
void gluPartialDisk (GLUquadric* quad, GLdouble inner, GLdouble outer, GLint slices, GLint loops, GLdouble start, GLdouble sweep);
void gluPerspective (GLdouble fovy, GLdouble aspect, GLdouble zNear, GLdouble zFar);
void gluPickMatrix (GLdouble x, GLdouble y, GLdouble delX, GLdouble delY, GLint *viewport);
GLint gluProject (GLdouble objX, GLdouble objY, GLdouble objZ, const GLdouble *model, const GLdouble *proj, const GLint *view, GLdouble* winX, GLdouble* winY, GLdouble* winZ);
void gluPwlCurve (GLUnurbs* nurb, GLint count, GLfloat* data, GLint stride, GLenum type);
void gluQuadricCallback (GLUquadric* quad, GLenum which, _GLUfuncptr CallBackFunc);
void gluQuadricDrawStyle (GLUquadric* quad, GLenum draw);
void gluQuadricNormals (GLUquadric* quad, GLenum normal);
void gluQuadricOrientation (GLUquadric* quad, GLenum orientation);
void gluQuadricTexture (GLUquadric* quad, GLboolean texture);
GLint gluScaleImage (GLenum format, GLsizei wIn, GLsizei hIn, GLenum typeIn, const void *dataIn, GLsizei wOut, GLsizei hOut, GLenum typeOut, GLvoid* dataOut);
void gluSphere (GLUquadric* quad, GLdouble radius, GLint slices, GLint stacks);
void gluTessBeginContour (GLUtesselator* tess);
void gluTessBeginPolygon (GLUtesselator* tess, GLvoid* data);
void gluTessCallback (GLUtesselator* tess, GLenum which, _GLUfuncptr CallBackFunc);
void gluTessEndContour (GLUtesselator* tess);
void gluTessEndPolygon (GLUtesselator* tess);
void gluTessNormal (GLUtesselator* tess, GLdouble valueX, GLdouble valueY, GLdouble valueZ);
void gluTessProperty (GLUtesselator* tess, GLenum which, GLdouble data);
void gluTessVertex (GLUtesselator* tess, GLdouble *location, GLvoid* data);
GLint gluUnProject (GLdouble winX, GLdouble winY, GLdouble winZ, const GLdouble *model, const GLdouble *proj, const GLint *view, GLdouble* objX, GLdouble* objY, GLdouble* objZ);
GLint gluUnProject4 (GLdouble winX, GLdouble winY, GLdouble winZ, GLdouble clipW, const GLdouble *model, const GLdouble *proj, const GLint *view, GLdouble nearVal, GLdouble farVal, GLdouble* objX, GLdouble* objY, GLdouble* objZ, GLdouble* objW);

]])

glu = ffi.load(lwlgl.libs.glu[2])

end

function load_glut()

ffi.cdef([[

typedef signed char GLbyte;
typedef float GLclampf;
typedef int32_t GLfixed;
typedef signed short int GLshort;
typedef unsigned short int GLushort;
typedef void GLvoid;
typedef struct __GLsync *GLsync;
typedef int64_t GLint64;
typedef uint64_t GLuint64;
typedef unsigned int GLenum;
typedef unsigned int GLuint;
typedef char GLchar;
typedef float GLfloat;
typedef signed long long int GLsizeiptr;
typedef signed long long int GLintptr;
typedef unsigned int GLbitfield;
typedef int GLint;
typedef unsigned char GLboolean;
typedef int GLsizei;
typedef unsigned char GLubyte;
typedef double GLdouble;
typedef int GLclampx;

/* constants */
enum {

/* Display mode bit masks. */
  GLUT_RGB                        = 0,
  GLUT_RGBA                       = GLUT_RGB,
  GLUT_INDEX                      = 1,
  GLUT_SINGLE                     = 0,
  GLUT_DOUBLE                     = 2,
  GLUT_ACCUM                      = 4,
  GLUT_ALPHA                      = 8,
  GLUT_DEPTH                      = 16,
  GLUT_STENCIL                    = 32,
  GLUT_MULTISAMPLE                = 128,
  GLUT_STEREO                     = 256,
  GLUT_LUMINANCE                  = 512,
  GLUT_NO_RECOVERY                = 1024,

/* Mouse buttons. */
  GLUT_LEFT_BUTTON                = 0,
  GLUT_MIDDLE_BUTTON              = 1,
  GLUT_RIGHT_BUTTON               = 2,

/* Mouse button  state. */
  GLUT_DOWN                       = 0,
  GLUT_UP                         = 1,

/* function keys */
  GLUT_KEY_F1                     = 1,
  GLUT_KEY_F2                     = 2,
  GLUT_KEY_F3                     = 3,
  GLUT_KEY_F4                     = 4,
  GLUT_KEY_F5                     = 5,
  GLUT_KEY_F6                     = 6,
  GLUT_KEY_F7                     = 7,
  GLUT_KEY_F8                     = 8,
  GLUT_KEY_F9                     = 9,
  GLUT_KEY_F10                    = 10,
  GLUT_KEY_F11                    = 11,
  GLUT_KEY_F12                    = 12,
/* directional keys */
  GLUT_KEY_LEFT                   = 100,
  GLUT_KEY_UP                     = 101,
  GLUT_KEY_RIGHT                  = 102,
  GLUT_KEY_DOWN                   = 103,
  GLUT_KEY_PAGE_UP                = 104,
  GLUT_KEY_PAGE_DOWN              = 105,
  GLUT_KEY_HOME                   = 106,
  GLUT_KEY_END                    = 107,
  GLUT_KEY_INSERT                 = 108,

/* Entry/exit  state. */
  GLUT_LEFT                       = 0,
  GLUT_ENTERED                    = 1,

/* Menu usage  state. */
  GLUT_MENU_NOT_IN_USE            = 0,
  GLUT_MENU_IN_USE                = 1,

/* Visibility  state. */
  GLUT_NOT_VISIBLE                = 0,
  GLUT_VISIBLE                    = 1,

/* Window status  state. */
  GLUT_HIDDEN                     = 0,
  GLUT_FULLY_RETAINED             = 1,
  GLUT_PARTIALLY_RETAINED         = 2,
  GLUT_FULLY_COVERED              = 3,

/* Color index component selection values. */
  GLUT_RED                        = 0,
  GLUT_GREEN                      = 1,
  GLUT_BLUE                       = 2,

/* Layers for use. */
  GLUT_NORMAL                     = 0,
  GLUT_OVERLAY                    = 1,

/* Stroke font opaque addresses (use constants instead in source code). */
/* REMOVED */
/* Bitmap font opaque addresses (use constants instead in source code). */
/* REMOVED */

/* glutGet parameters. */
  GLUT_WINDOW_X                   = 100,
  GLUT_WINDOW_Y                   = 101,
  GLUT_WINDOW_WIDTH               = 102,
  GLUT_WINDOW_HEIGHT              = 103,
  GLUT_WINDOW_BUFFER_SIZE         = 104,
  GLUT_WINDOW_STENCIL_SIZE        = 105,
  GLUT_WINDOW_DEPTH_SIZE          = 106,
  GLUT_WINDOW_RED_SIZE            = 107,
  GLUT_WINDOW_GREEN_SIZE          = 108,
  GLUT_WINDOW_BLUE_SIZE           = 109,
  GLUT_WINDOW_ALPHA_SIZE          = 110,
  GLUT_WINDOW_ACCUM_RED_SIZE      = 111,
  GLUT_WINDOW_ACCUM_GREEN_SIZE    = 112,
  GLUT_WINDOW_ACCUM_BLUE_SIZE     = 113,
  GLUT_WINDOW_ACCUM_ALPHA_SIZE    = 114,
  GLUT_WINDOW_DOUBLEBUFFER        = 115,
  GLUT_WINDOW_RGBA                = 116,
  GLUT_WINDOW_PARENT              = 117,
  GLUT_WINDOW_NUM_CHILDREN        = 118,
  GLUT_WINDOW_COLORMAP_SIZE       = 119,
  GLUT_WINDOW_NUM_SAMPLES         = 120,
  GLUT_WINDOW_STEREO              = 121,
  GLUT_WINDOW_CURSOR              = 122,
  GLUT_SCREEN_WIDTH               = 200,
  GLUT_SCREEN_HEIGHT              = 201,
  GLUT_SCREEN_WIDTH_MM            = 202,
  GLUT_SCREEN_HEIGHT_MM           = 203,
  GLUT_MENU_NUM_ITEMS             = 300,
  GLUT_DISPLAY_MODE_POSSIBLE      = 400,
  GLUT_INIT_WINDOW_X              = 500,
  GLUT_INIT_WINDOW_Y              = 501,
  GLUT_INIT_WINDOW_WIDTH          = 502,
  GLUT_INIT_WINDOW_HEIGHT         = 503,
  GLUT_INIT_DISPLAY_MODE          = 504,
  GLUT_ELAPSED_TIME               = 700,
  GLUT_WINDOW_FORMAT_ID           = 123,

/* glutDeviceGet parameters. */
  GLUT_HAS_KEYBOARD               = 600,
  GLUT_HAS_MOUSE                  = 601,
  GLUT_HAS_SPACEBALL              = 602,
  GLUT_HAS_DIAL_AND_BUTTON_BOX    = 603,
  GLUT_HAS_TABLET                 = 604,
  GLUT_NUM_MOUSE_BUTTONS          = 605,
  GLUT_NUM_SPACEBALL_BUTTONS      = 606,
  GLUT_NUM_BUTTON_BOX_BUTTONS     = 607,
  GLUT_NUM_DIALS                  = 608,
  GLUT_NUM_TABLET_BUTTONS         = 609,
  GLUT_DEVICE_IGNORE_KEY_REPEAT   = 610,
  GLUT_DEVICE_KEY_REPEAT          = 611,
  GLUT_HAS_JOYSTICK               = 612,
  GLUT_OWNS_JOYSTICK              = 613,
  GLUT_JOYSTICK_BUTTONS           = 614,
  GLUT_JOYSTICK_AXES              = 615,
  GLUT_JOYSTICK_POLL_RATE         = 616,

/* glutLayerGet parameters. */
  GLUT_OVERLAY_POSSIBLE           = 800,
  GLUT_LAYER_IN_USE               = 801,
  GLUT_HAS_OVERLAY                = 802,
  GLUT_TRANSPARENT_INDEX          = 803,
  GLUT_NORMAL_DAMAGED             = 804,
  GLUT_OVERLAY_DAMAGED            = 805,

/* glutVideoResizeGet parameters. */
  GLUT_VIDEO_RESIZE_POSSIBLE      = 900,
  GLUT_VIDEO_RESIZE_IN_USE        = 901,
  GLUT_VIDEO_RESIZE_X_DELTA       = 902,
  GLUT_VIDEO_RESIZE_Y_DELTA       = 903,
  GLUT_VIDEO_RESIZE_WIDTH_DELTA   = 904,
  GLUT_VIDEO_RESIZE_HEIGHT_DELTA  = 905,
  GLUT_VIDEO_RESIZE_X             = 906,
  GLUT_VIDEO_RESIZE_Y             = 907,
  GLUT_VIDEO_RESIZE_WIDTH         = 908,
  GLUT_VIDEO_RESIZE_HEIGHT        = 909,

/* glutUseLayer parameters. */
/*
  GLUT_NORMAL                     = 0,
  GLUT_OVERLAY                    = 1,
*/

/*
  GLUT_STROKE_ROMAN               = ((void*)0)
  GLUT_STROKE_MONO_ROMAN          = ((void*)1)
*/
/* Bitmap font constants (use these in GLUT program). */
/*
  GLUT_BITMAP_9_BY_15             = ((void*)2)
  GLUT_BITMAP_8_BY_13             = ((void*)3)
  GLUT_BITMAP_TIMES_ROMAN_10      = ((void*)4)
  GLUT_BITMAP_TIMES_ROMAN_24      = ((void*)5)
  GLUT_BITMAP_HELVETICA_10        = ((void*)6)
  GLUT_BITMAP_HELVETICA_12        = ((void*)7)
  GLUT_BITMAP_HELVETICA_18        = ((void*)8)
*/
/* glutGetModifiers return mask. */
  GLUT_ACTIVE_SHIFT               = 1,
  GLUT_ACTIVE_CTRL                = 2,
  GLUT_ACTIVE_ALT                 = 4,

/* glutSetCursor parameters. */
/* Basic arrows. */
  GLUT_CURSOR_RIGHT_ARROW         = 0,
  GLUT_CURSOR_LEFT_ARROW          = 1,
/* Symbolic cursor shapes. */
  GLUT_CURSOR_INFO                = 2,
  GLUT_CURSOR_DESTROY             = 3,
  GLUT_CURSOR_HELP                = 4,
  GLUT_CURSOR_CYCLE               = 5,
  GLUT_CURSOR_SPRAY               = 6,
  GLUT_CURSOR_WAIT                = 7,
  GLUT_CURSOR_TEXT                = 8,
  GLUT_CURSOR_CROSSHAIR           = 9,
/* Directional cursors. */
  GLUT_CURSOR_UP_DOWN             = 10,
  GLUT_CURSOR_LEFT_RIGHT          = 11,
/* Sizing cursors. */
  GLUT_CURSOR_TOP_SIDE            = 12,
  GLUT_CURSOR_BOTTOM_SIDE         = 13,
  GLUT_CURSOR_LEFT_SIDE           = 14,
  GLUT_CURSOR_RIGHT_SIDE          = 15,
  GLUT_CURSOR_TOP_LEFT_CORNER     = 16,
  GLUT_CURSOR_TOP_RIGHT_CORNER    = 17,
  GLUT_CURSOR_BOTTOM_RIGHT_CORNER = 18,
  GLUT_CURSOR_BOTTOM_LEFT_CORNER  = 19,
/* Inherit from parent window. */
  GLUT_CURSOR_INHERIT             = 100,
/* Blank cursor. */
  GLUT_CURSOR_NONE                = 101,
/* Fullscreen crosshair (if available). */
  GLUT_CURSOR_FULL_CROSSHAIR      = 102
};

/* GLUT initialization sub-API. */
void glutInit(int *argcp, char **argv);
void glutInitDisplayMode(unsigned int mode);
void glutInitDisplayString(const char *string);
void glutInitWindowPosition(int x, int y);
void glutInitWindowSize(int width, int height);
void glutMainLoop(void);

/* GLUT window sub-API. */
int glutCreateWindow(const char *title);
int glutCreateSubWindow(int win, int x, int y, int width, int height);
void glutDestroyWindow(int win);
void glutPostRedisplay(void);
void glutPostWindowRedisplay(int win);
void glutSwapBuffers(void);
int glutGetWindow(void);
void glutSetWindow(int win);
void glutSetWindowTitle(const char *title);
void glutSetIconTitle(const char *title);
void glutPositionWindow(int x, int y);
void glutReshapeWindow(int width, int height);
void glutPopWindow(void);
void glutPushWindow(void);
void glutIconifyWindow(void);
void glutShowWindow(void);
void glutHideWindow(void);
void glutFullScreen(void);
void glutSetCursor(int cursor);
void glutWarpPointer(int x, int y);
/* surface texturing API Mac OS X specific
*  Note:
*       glutSurfaceTexture has been deprecated, use GL_EXT_framebuffer_object
*/
void glutSurfaceTexture (GLenum target, GLenum internalformat, int surfacewin);
/* Mac OS X specific API */
void glutWMCloseFunc(void (*func)(void));
void glutCheckLoop(void);

/* GLUT overlay sub-API. */
void glutEstablishOverlay(void);
void glutRemoveOverlay(void);
void glutUseLayer(GLenum layer);
void glutPostOverlayRedisplay(void);
void glutPostWindowOverlayRedisplay(int win);
void glutShowOverlay(void);
void glutHideOverlay(void);

/* GLUT menu sub-API. */
int glutCreateMenu(void (*)(int));
void glutDestroyMenu(int menu);
int glutGetMenu(void);
void glutSetMenu(int menu);
void glutAddMenuEntry(const char *label, int value);
void glutAddSubMenu(const char *label, int submenu);
void glutChangeToMenuEntry(int item, const char *label, int value);
void glutChangeToSubMenu(int item, const char *label, int submenu);
void glutRemoveMenuItem(int item);
void glutAttachMenu(int button);
void glutDetachMenu(int button);

/* GLUT window callback sub-API. */
void glutDisplayFunc(void (*func)(void));
void glutReshapeFunc(void (*func)(int width, int height));
void glutKeyboardFunc(void (*func)(unsigned char key, int x, int y));
void glutMouseFunc(void (*func)(int button, int state, int x, int y));
void glutMotionFunc(void (*func)(int x, int y));
void glutPassiveMotionFunc(void (*func)(int x, int y));
void glutEntryFunc(void (*func)(int state));
void glutVisibilityFunc(void (*func)(int state));
void glutIdleFunc(void (*func)(void));
void glutTimerFunc(unsigned int millis, void (*func)(int value), int value);
void glutMenuStateFunc(void (*func)(int state));
void glutSpecialFunc(void (*func)(int key, int x, int y));
void glutSpaceballMotionFunc(void (*func)(int x, int y, int z));
void glutSpaceballRotateFunc(void (*func)(int x, int y, int z));
void glutSpaceballButtonFunc(void (*func)(int button, int state));
void glutButtonBoxFunc(void (*func)(int button, int state));
void glutDialsFunc(void (*func)(int dial, int value));
void glutTabletMotionFunc(void (*func)(int x, int y));
void glutTabletButtonFunc(void (*func)(int button, int state, int x, int y));
void glutMenuStatusFunc(void (*func)(int status, int x, int y));
void glutOverlayDisplayFunc(void (*func)(void));
void glutWindowStatusFunc(void (*func)(int state));
void glutKeyboardUpFunc(void (*func)(unsigned char key, int x, int y));
void glutSpecialUpFunc(void (*func)(int key, int x, int y));
void glutJoystickFunc(void (*func)(unsigned int buttonMask, int x, int y, int z), int pollInterval);

/* GLUT color index sub-API. */
void glutSetColor(int, GLfloat red, GLfloat green, GLfloat blue);
GLfloat glutGetColor(int ndx, int component);
void glutCopyColormap(int win);

/* GLUT state retrieval sub-API. */
int glutGet(GLenum type);
int glutDeviceGet(GLenum type);
/* GLUT extension support sub-API */
int glutExtensionSupported(const char *name);
int glutGetModifiers(void);
int glutLayerGet(GLenum type);
void * glutGetProcAddress(const char *procName);

/* GLUT font sub-API */
void glutBitmapCharacter(void *font, int character);
int glutBitmapWidth(void *font, int character);
void glutStrokeCharacter(void *font, int character);
int glutStrokeWidth(void *font, int character);
int glutBitmapLength(void *font, const unsigned char *string);
int glutStrokeLength(void *font, const unsigned char *string);

/* GLUT pre-built models sub-API */
void glutWireSphere(GLdouble radius, GLint slices, GLint stacks);
void glutSolidSphere(GLdouble radius, GLint slices, GLint stacks);
void glutWireCone(GLdouble base, GLdouble height, GLint slices, GLint stacks);
void glutSolidCone(GLdouble base, GLdouble height, GLint slices, GLint stacks);
void glutWireCube(GLdouble size);
void glutSolidCube(GLdouble size);
void glutWireTorus(GLdouble innerRadius, GLdouble outerRadius, GLint sides, GLint rings);
void glutSolidTorus(GLdouble innerRadius, GLdouble outerRadius, GLint sides, GLint rings);
void glutWireDodecahedron(void);
void glutSolidDodecahedron(void);
void glutWireTeapot(GLdouble size);
void glutSolidTeapot(GLdouble size);
void glutWireOctahedron(void);
void glutSolidOctahedron(void);
void glutWireTetrahedron(void);
void glutSolidTetrahedron(void);
void glutWireIcosahedron(void);
void glutSolidIcosahedron(void);

/* GLUT video resize sub-API. */
int glutVideoResizeGet(GLenum param);
void glutSetupVideoResizing(void);
void glutStopVideoResizing(void);
void glutVideoResize(int x, int y, int width, int height);
void glutVideoPan(int x, int y, int width, int height);

/* GLUT debugging sub-API. */
void glutReportErrors(void);

/* GLUT device control sub-API. */
enum {
/* glutSetKeyRepeat modes. */
  GLUT_KEY_REPEAT_OFF             = 0,
  GLUT_KEY_REPEAT_ON              = 1,
  GLUT_KEY_REPEAT_DEFAULT         = 2,

/* Joystick button masks. */
  GLUT_JOYSTICK_BUTTON_A          = 1,
  GLUT_JOYSTICK_BUTTON_B          = 2,
  GLUT_JOYSTICK_BUTTON_C          = 4,
  GLUT_JOYSTICK_BUTTON_D          = 8,
};

void glutIgnoreKeyRepeat(int ignore);
void glutSetKeyRepeat(int repeatMode);
void glutForceJoystickFunc(void);

/* GLUT game mode sub-API. */
enum {
/* glutGameModeGet. */
  GLUT_GAME_MODE_ACTIVE           = 0,
  GLUT_GAME_MODE_POSSIBLE         = 1,
  GLUT_GAME_MODE_WIDTH            = 2,
  GLUT_GAME_MODE_HEIGHT           = 3,
  GLUT_GAME_MODE_PIXEL_DEPTH      = 4,
  GLUT_GAME_MODE_REFRESH_RATE     = 5,
  GLUT_GAME_MODE_DISPLAY_CHANGED  = 6
};

void glutGameModeString(const char *string);
int glutEnterGameMode(void);
void glutLeaveGameMode(void);
int glutGameModeGet(GLenum mode);

/* FreeGLUT extensions for core profile initialization */
enum {
/*
 * Flags for glutInitContextFlags, see freeglut_init.c
 */
  GLUT_DEBUG                         = 0x0001,
  GLUT_FORWARD_COMPATIBLE            = 0x0002,


/*
 * Flags for glutInitContextProfile, see freeglut_init.c
 */
  GLUT_CORE_PROFILE                   = 0x0001,
  GLUT_COMPATIBILITY_PROFILE          = 0x0002,
};

void    glutInitContextVersion( int majorVersion, int minorVersion );
void    glutInitContextFlags( int flags );
void    glutInitContextProfile( int profile );

]])

glut = ffi.load(lwlgl.libs.glut[2])

end

function init_glut()
    argvp = {}
    if arg ~= nil then
        for i = 0, #arg do argvp[#argvp+1] = ffi.new("char[?]", #arg[i]+1, arg[i]) end
    end
    argv = ffi.new("char *[?]", #argvp, argvp)
    argcp = ffi.new("int[1]", #argvp)
    glut.glutInit(argcp, argv)
    if arg ~= nil then
        for i = #arg, argcp[0] do table.remove(arg, i) end
        for i = 0, argcp[0]-1  do arg[i] = ffi.string(argv[i]) end
    end
end

function load_sdl()

ffi.cdef([[

const char * SDL_GetPlatform (void);
typedef enum
{
    SDL_FALSE = 0,
    SDL_TRUE = 1
} SDL_bool;
typedef int8_t Sint8;
typedef uint8_t Uint8;
typedef int16_t Sint16;
typedef uint16_t Uint16;
typedef int32_t Sint32;
typedef uint32_t Uint32;
typedef int64_t Sint64;
typedef uint64_t Uint64;
typedef int SDL_dummy_uint8[(sizeof(Uint8) == 1) * 2 - 1];
typedef int SDL_dummy_sint8[(sizeof(Sint8) == 1) * 2 - 1];
typedef int SDL_dummy_uint16[(sizeof(Uint16) == 2) * 2 - 1];
typedef int SDL_dummy_sint16[(sizeof(Sint16) == 2) * 2 - 1];
typedef int SDL_dummy_uint32[(sizeof(Uint32) == 4) * 2 - 1];
typedef int SDL_dummy_sint32[(sizeof(Sint32) == 4) * 2 - 1];
typedef int SDL_dummy_uint64[(sizeof(Uint64) == 8) * 2 - 1];
typedef int SDL_dummy_sint64[(sizeof(Sint64) == 8) * 2 - 1];
typedef enum
{
    DUMMY_ENUM_VALUE
} SDL_DUMMY_ENUM;
typedef int SDL_dummy_enum[(sizeof(SDL_DUMMY_ENUM) == sizeof(int)) * 2 - 1];
void * SDL_malloc(size_t size);
void * SDL_calloc(size_t nmemb, size_t size);
void * SDL_realloc(void *mem, size_t size);
void SDL_free(void *mem);
char * SDL_getenv(const char *name);
int SDL_setenv(const char *name, const char *value, int overwrite);
void SDL_qsort(void *base, size_t nmemb, size_t size, int (*compare) (const void *, const void *));
int SDL_abs(int x);
int SDL_isdigit(int x);
int SDL_isspace(int x);
int SDL_toupper(int x);
int SDL_tolower(int x);
void * SDL_memset( void *dst, int c, size_t len);
__attribute__((always_inline)) static __inline__ void SDL_memset4(void *dst, Uint32 val, size_t dwords)
{
    size_t _n = (dwords + 3) / 4;
    Uint32 *_p = ((Uint32 *)(dst));
    Uint32 _val = (val);
    if (dwords == 0)
        return;
    switch (dwords % 4)
    {
        case 0: do { *_p++ = _val;
        case 3: *_p++ = _val;
        case 2: *_p++ = _val;
        case 1: *_p++ = _val;
        } while ( --_n );
    }
}
void * SDL_memcpy( void *dst, const void *src, size_t len);
void * SDL_memmove( void *dst, const void *src, size_t len);
int SDL_memcmp(const void *s1, const void *s2, size_t len);
size_t SDL_wcslen(const wchar_t *wstr);
size_t SDL_wcslcpy( wchar_t *dst, const wchar_t *src, size_t maxlen);
size_t SDL_wcslcat( wchar_t *dst, const wchar_t *src, size_t maxlen);
size_t SDL_strlen(const char *str);
size_t SDL_strlcpy( char *dst, const char *src, size_t maxlen);
size_t SDL_utf8strlcpy( char *dst, const char *src, size_t dst_bytes);
size_t SDL_strlcat( char *dst, const char *src, size_t maxlen);
char * SDL_strdup(const char *str);
char * SDL_strrev(char *str);
char * SDL_strupr(char *str);
char * SDL_strlwr(char *str);
char * SDL_strchr(const char *str, int c);
char * SDL_strrchr(const char *str, int c);
char * SDL_strstr(const char *haystack, const char *needle);
char * SDL_itoa(int value, char *str, int radix);
char * SDL_uitoa(unsigned int value, char *str, int radix);
char * SDL_ltoa(long value, char *str, int radix);
char * SDL_ultoa(unsigned long value, char *str, int radix);
char * SDL_lltoa(Sint64 value, char *str, int radix);
char * SDL_ulltoa(Uint64 value, char *str, int radix);
int SDL_atoi(const char *str);
double SDL_atof(const char *str);
long SDL_strtol(const char *str, char **endp, int base);
unsigned long SDL_strtoul(const char *str, char **endp, int base);
Sint64 SDL_strtoll(const char *str, char **endp, int base);
Uint64 SDL_strtoull(const char *str, char **endp, int base);
double SDL_strtod(const char *str, char **endp);
int SDL_strcmp(const char *str1, const char *str2);
int SDL_strncmp(const char *str1, const char *str2, size_t maxlen);
int SDL_strcasecmp(const char *str1, const char *str2);
int SDL_strncasecmp(const char *str1, const char *str2, size_t len);
int SDL_sscanf(const char *text, const char *fmt, ...) __attribute__ (( format( __scanf__, 2, 2 +1 )));
int SDL_vsscanf(const char *text, const char *fmt, va_list ap);
int SDL_snprintf( char *text, size_t maxlen, const char *fmt, ... ) __attribute__ (( format( __printf__, 3, 3 +1 )));
int SDL_vsnprintf( char *text, size_t maxlen, const char *fmt, va_list ap);
double SDL_acos(double x);
double SDL_asin(double x);
double SDL_atan(double x);
double SDL_atan2(double x, double y);
double SDL_ceil(double x);
double SDL_copysign(double x, double y);
double SDL_cos(double x);
float SDL_cosf(float x);
double SDL_fabs(double x);
double SDL_floor(double x);
double SDL_log(double x);
double SDL_pow(double x, double y);
double SDL_scalbn(double x, int n);
double SDL_sin(double x);
float SDL_sinf(float x);
double SDL_sqrt(double x);
float SDL_sqrtf(float x);
double SDL_tan(double x);
float SDL_tanf(float x);
typedef struct _SDL_iconv_t *SDL_iconv_t;
SDL_iconv_t SDL_iconv_open(const char *tocode,
                                                   const char *fromcode);
int SDL_iconv_close(SDL_iconv_t cd);
size_t SDL_iconv(SDL_iconv_t cd, const char **inbuf,
                                         size_t * inbytesleft, char **outbuf,
                                         size_t * outbytesleft);
char * SDL_iconv_string(const char *tocode,
                                               const char *fromcode,
                                               const char *inbuf,
                                               size_t inbytesleft);
__attribute__((always_inline)) static __inline__ void *SDL_memcpy4( void *dst, const void *src, size_t dwords)
{
    return SDL_memcpy(dst, src, dwords * 4);
}
extern int SDL_main(int argc, char *argv[]);
void SDL_SetMainReady(void);
typedef enum
{
    SDL_ASSERTION_RETRY,
    SDL_ASSERTION_BREAK,
    SDL_ASSERTION_ABORT,
    SDL_ASSERTION_IGNORE,
    SDL_ASSERTION_ALWAYS_IGNORE
} SDL_AssertState;
typedef struct SDL_AssertData
{
    int always_ignore;
    unsigned int trigger_count;
    const char *condition;
    const char *filename;
    int linenum;
    const char *function;
    const struct SDL_AssertData *next;
} SDL_AssertData;
SDL_AssertState SDL_ReportAssertion(SDL_AssertData *,
                                                             const char *,
                                                             const char *, int)
   __attribute__((analyzer_noreturn))
;
typedef SDL_AssertState ( *SDL_AssertionHandler)(
                                 const SDL_AssertData* data, void* userdata);
void SDL_SetAssertionHandler(
                                            SDL_AssertionHandler handler,
                                            void *userdata);
SDL_AssertionHandler SDL_GetDefaultAssertionHandler(void);
SDL_AssertionHandler SDL_GetAssertionHandler(void **puserdata);
const SDL_AssertData * SDL_GetAssertionReport(void);
void SDL_ResetAssertionReport(void);
typedef int SDL_SpinLock;
SDL_bool SDL_AtomicTryLock(SDL_SpinLock *lock);
void SDL_AtomicLock(SDL_SpinLock *lock);
void SDL_AtomicUnlock(SDL_SpinLock *lock);
typedef struct { int value; } SDL_atomic_t;
SDL_bool SDL_AtomicCAS(SDL_atomic_t *a, int oldval, int newval);
int SDL_AtomicSet(SDL_atomic_t *a, int v);
int SDL_AtomicGet(SDL_atomic_t *a);
int SDL_AtomicAdd(SDL_atomic_t *a, int v);
SDL_bool SDL_AtomicCASPtr(void **a, void *oldval, void *newval);
void* SDL_AtomicSetPtr(void **a, void* v);
void* SDL_AtomicGetPtr(void **a);
int SDL_SetError( const char *fmt, ...) __attribute__ (( format( __printf__, 1, 1 +1 )));
const char * SDL_GetError(void);
void SDL_ClearError(void);
typedef enum
{
    SDL_ENOMEM,
    SDL_EFREAD,
    SDL_EFWRITE,
    SDL_EFSEEK,
    SDL_UNSUPPORTED,
    SDL_LASTERROR
} SDL_errorcode;
int SDL_Error(SDL_errorcode code);
__attribute__((always_inline)) static __inline__ Uint16
SDL_Swap16(Uint16 x)
{
  __asm__("xchgb %b0,%h0": "=Q"(x):"0"(x));
    return x;
}
__attribute__((always_inline)) static __inline__ Uint32
SDL_Swap32(Uint32 x)
{
  __asm__("bswapl %0": "=r"(x):"0"(x));
    return x;
}
__attribute__((always_inline)) static __inline__ Uint64
SDL_Swap64(Uint64 x)
{
  __asm__("bswapq %0": "=r"(x):"0"(x));
    return x;
}
__attribute__((always_inline)) static __inline__ float
SDL_SwapFloat(float x)
{
    union
    {
        float f;
        Uint32 ui32;
    } swapper;
    swapper.f = x;
    swapper.ui32 = SDL_Swap32(swapper.ui32);
    return swapper.f;
}
struct SDL_mutex;
typedef struct SDL_mutex SDL_mutex;
SDL_mutex * SDL_CreateMutex(void);
int SDL_LockMutex(SDL_mutex * mutex);
int SDL_TryLockMutex(SDL_mutex * mutex);
int SDL_UnlockMutex(SDL_mutex * mutex);
void SDL_DestroyMutex(SDL_mutex * mutex);
struct SDL_semaphore;
typedef struct SDL_semaphore SDL_sem;
SDL_sem * SDL_CreateSemaphore(Uint32 initial_value);
void SDL_DestroySemaphore(SDL_sem * sem);
int SDL_SemWait(SDL_sem * sem);
int SDL_SemTryWait(SDL_sem * sem);
int SDL_SemWaitTimeout(SDL_sem * sem, Uint32 ms);
int SDL_SemPost(SDL_sem * sem);
Uint32 SDL_SemValue(SDL_sem * sem);
struct SDL_cond;
typedef struct SDL_cond SDL_cond;
SDL_cond * SDL_CreateCond(void);
void SDL_DestroyCond(SDL_cond * cond);
int SDL_CondSignal(SDL_cond * cond);
int SDL_CondBroadcast(SDL_cond * cond);
int SDL_CondWait(SDL_cond * cond, SDL_mutex * mutex);
int SDL_CondWaitTimeout(SDL_cond * cond,
                                                SDL_mutex * mutex, Uint32 ms);
struct SDL_Thread;
typedef struct SDL_Thread SDL_Thread;
typedef unsigned long SDL_threadID;
typedef unsigned int SDL_TLSID;
typedef enum {
    SDL_THREAD_PRIORITY_LOW,
    SDL_THREAD_PRIORITY_NORMAL,
    SDL_THREAD_PRIORITY_HIGH
} SDL_ThreadPriority;
typedef int ( * SDL_ThreadFunction) (void *data);
SDL_Thread *
SDL_CreateThread(SDL_ThreadFunction fn, const char *name, void *data);
const char * SDL_GetThreadName(SDL_Thread *thread);
SDL_threadID SDL_ThreadID(void);
SDL_threadID SDL_GetThreadID(SDL_Thread * thread);
int SDL_SetThreadPriority(SDL_ThreadPriority priority);
void SDL_WaitThread(SDL_Thread * thread, int *status);
void SDL_DetachThread(SDL_Thread * thread);
SDL_TLSID SDL_TLSCreate(void);
void * SDL_TLSGet(SDL_TLSID id);
int SDL_TLSSet(SDL_TLSID id, const void *value, void (*destructor)(void*));
typedef struct SDL_RWops
{
    Sint64 ( * size) (struct SDL_RWops * context);
    Sint64 ( * seek) (struct SDL_RWops * context, Sint64 offset,
                             int whence);
    size_t ( * read) (struct SDL_RWops * context, void *ptr,
                             size_t size, size_t maxnum);
    size_t ( * write) (struct SDL_RWops * context, const void *ptr,
                              size_t size, size_t num);
    int ( * close) (struct SDL_RWops * context);
    Uint32 type;
    union
    {
        struct
        {
            SDL_bool autoclose;
            // FILE *fp;
        } stdio;
        struct
        {
            Uint8 *base;
            Uint8 *here;
            Uint8 *stop;
        } mem;
        struct
        {
            void *data1;
            void *data2;
        } unknown;
    } hidden;
} SDL_RWops;
SDL_RWops * SDL_RWFromFile(const char *file,
                                                  const char *mode);
// SDL_RWops * SDL_RWFromFP(FILE * fp,
//                                                 SDL_bool autoclose);
SDL_RWops * SDL_RWFromMem(void *mem, int size);
SDL_RWops * SDL_RWFromConstMem(const void *mem,
                                                      int size);
SDL_RWops * SDL_AllocRW(void);
void SDL_FreeRW(SDL_RWops * area);
Uint8 SDL_ReadU8(SDL_RWops * src);
Uint16 SDL_ReadLE16(SDL_RWops * src);
Uint16 SDL_ReadBE16(SDL_RWops * src);
Uint32 SDL_ReadLE32(SDL_RWops * src);
Uint32 SDL_ReadBE32(SDL_RWops * src);
Uint64 SDL_ReadLE64(SDL_RWops * src);
Uint64 SDL_ReadBE64(SDL_RWops * src);
size_t SDL_WriteU8(SDL_RWops * dst, Uint8 value);
size_t SDL_WriteLE16(SDL_RWops * dst, Uint16 value);
size_t SDL_WriteBE16(SDL_RWops * dst, Uint16 value);
size_t SDL_WriteLE32(SDL_RWops * dst, Uint32 value);
size_t SDL_WriteBE32(SDL_RWops * dst, Uint32 value);
size_t SDL_WriteLE64(SDL_RWops * dst, Uint64 value);
size_t SDL_WriteBE64(SDL_RWops * dst, Uint64 value);
typedef Uint16 SDL_AudioFormat;
typedef void ( * SDL_AudioCallback) (void *userdata, Uint8 * stream,
                                            int len);
typedef struct SDL_AudioSpec
{
    int freq;
    SDL_AudioFormat format;
    Uint8 channels;
    Uint8 silence;
    Uint16 samples;
    Uint16 padding;
    Uint32 size;
    SDL_AudioCallback callback;
    void *userdata;
} SDL_AudioSpec;
struct SDL_AudioCVT;
typedef void ( * SDL_AudioFilter) (struct SDL_AudioCVT * cvt,
                                          SDL_AudioFormat format);
typedef struct SDL_AudioCVT
{
    int needed;
    SDL_AudioFormat src_format;
    SDL_AudioFormat dst_format;
    double rate_incr;
    Uint8 *buf;
    int len;
    int len_cvt;
    int len_mult;
    double len_ratio;
    SDL_AudioFilter filters[10];
    int filter_index;
} __attribute__((packed)) SDL_AudioCVT;
int SDL_GetNumAudioDrivers(void);
const char * SDL_GetAudioDriver(int index);
int SDL_AudioInit(const char *driver_name);
void SDL_AudioQuit(void);
const char * SDL_GetCurrentAudioDriver(void);
int SDL_OpenAudio(SDL_AudioSpec * desired,
                                          SDL_AudioSpec * obtained);
typedef Uint32 SDL_AudioDeviceID;
int SDL_GetNumAudioDevices(int iscapture);
const char * SDL_GetAudioDeviceName(int index,
                                                           int iscapture);
SDL_AudioDeviceID SDL_OpenAudioDevice(const char
                                                              *device,
                                                              int iscapture,
                                                              const
                                                              SDL_AudioSpec *
                                                              desired,
                                                              SDL_AudioSpec *
                                                              obtained,
                                                              int
                                                              allowed_changes);
typedef enum
{
    SDL_AUDIO_STOPPED = 0,
    SDL_AUDIO_PLAYING,
    SDL_AUDIO_PAUSED
} SDL_AudioStatus;
SDL_AudioStatus SDL_GetAudioStatus(void);
SDL_AudioStatus
SDL_GetAudioDeviceStatus(SDL_AudioDeviceID dev);
void SDL_PauseAudio(int pause_on);
void SDL_PauseAudioDevice(SDL_AudioDeviceID dev,
                                                  int pause_on);
SDL_AudioSpec * SDL_LoadWAV_RW(SDL_RWops * src,
                                                      int freesrc,
                                                      SDL_AudioSpec * spec,
                                                      Uint8 ** audio_buf,
                                                      Uint32 * audio_len);
void SDL_FreeWAV(Uint8 * audio_buf);
int SDL_BuildAudioCVT(SDL_AudioCVT * cvt,
                                              SDL_AudioFormat src_format,
                                              Uint8 src_channels,
                                              int src_rate,
                                              SDL_AudioFormat dst_format,
                                              Uint8 dst_channels,
                                              int dst_rate);
int SDL_ConvertAudio(SDL_AudioCVT * cvt);
void SDL_MixAudio(Uint8 * dst, const Uint8 * src,
                                          Uint32 len, int volume);
void SDL_MixAudioFormat(Uint8 * dst,
                                                const Uint8 * src,
                                                SDL_AudioFormat format,
                                                Uint32 len, int volume);
int SDL_QueueAudio(SDL_AudioDeviceID dev, const void *data, Uint32 len);
Uint32 SDL_DequeueAudio(SDL_AudioDeviceID dev, void *data, Uint32 len);
Uint32 SDL_GetQueuedAudioSize(SDL_AudioDeviceID dev);
void SDL_ClearQueuedAudio(SDL_AudioDeviceID dev);
void SDL_LockAudio(void);
void SDL_LockAudioDevice(SDL_AudioDeviceID dev);
void SDL_UnlockAudio(void);
void SDL_UnlockAudioDevice(SDL_AudioDeviceID dev);
void SDL_CloseAudio(void);
void SDL_CloseAudioDevice(SDL_AudioDeviceID dev);
int SDL_SetClipboardText(const char *text);
char * SDL_GetClipboardText(void);
SDL_bool SDL_HasClipboardText(void);
int SDL_GetCPUCount(void);
int SDL_GetCPUCacheLineSize(void);
SDL_bool SDL_HasRDTSC(void);
SDL_bool SDL_HasAltiVec(void);
SDL_bool SDL_HasMMX(void);
SDL_bool SDL_Has3DNow(void);
SDL_bool SDL_HasSSE(void);
SDL_bool SDL_HasSSE2(void);
SDL_bool SDL_HasSSE3(void);
SDL_bool SDL_HasSSE41(void);
SDL_bool SDL_HasSSE42(void);
SDL_bool SDL_HasAVX(void);
SDL_bool SDL_HasAVX2(void);
int SDL_GetSystemRAM(void);
enum
{
    SDL_PIXELTYPE_UNKNOWN,
    SDL_PIXELTYPE_INDEX1,
    SDL_PIXELTYPE_INDEX4,
    SDL_PIXELTYPE_INDEX8,
    SDL_PIXELTYPE_PACKED8,
    SDL_PIXELTYPE_PACKED16,
    SDL_PIXELTYPE_PACKED32,
    SDL_PIXELTYPE_ARRAYU8,
    SDL_PIXELTYPE_ARRAYU16,
    SDL_PIXELTYPE_ARRAYU32,
    SDL_PIXELTYPE_ARRAYF16,
    SDL_PIXELTYPE_ARRAYF32
};
enum
{
    SDL_BITMAPORDER_NONE,
    SDL_BITMAPORDER_4321,
    SDL_BITMAPORDER_1234
};
enum
{
    SDL_PACKEDORDER_NONE,
    SDL_PACKEDORDER_XRGB,
    SDL_PACKEDORDER_RGBX,
    SDL_PACKEDORDER_ARGB,
    SDL_PACKEDORDER_RGBA,
    SDL_PACKEDORDER_XBGR,
    SDL_PACKEDORDER_BGRX,
    SDL_PACKEDORDER_ABGR,
    SDL_PACKEDORDER_BGRA
};
enum
{
    SDL_ARRAYORDER_NONE,
    SDL_ARRAYORDER_RGB,
    SDL_ARRAYORDER_RGBA,
    SDL_ARRAYORDER_ARGB,
    SDL_ARRAYORDER_BGR,
    SDL_ARRAYORDER_BGRA,
    SDL_ARRAYORDER_ABGR
};
enum
{
    SDL_PACKEDLAYOUT_NONE,
    SDL_PACKEDLAYOUT_332,
    SDL_PACKEDLAYOUT_4444,
    SDL_PACKEDLAYOUT_1555,
    SDL_PACKEDLAYOUT_5551,
    SDL_PACKEDLAYOUT_565,
    SDL_PACKEDLAYOUT_8888,
    SDL_PACKEDLAYOUT_2101010,
    SDL_PACKEDLAYOUT_1010102
};
enum
{
    SDL_PIXELFORMAT_UNKNOWN,
    SDL_PIXELFORMAT_INDEX1LSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX1) << 24) | ((SDL_BITMAPORDER_4321) << 20) | ((0) << 16) | ((1) << 8) | ((0) << 0)),
    SDL_PIXELFORMAT_INDEX1MSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX1) << 24) | ((SDL_BITMAPORDER_1234) << 20) | ((0) << 16) | ((1) << 8) | ((0) << 0)),
    SDL_PIXELFORMAT_INDEX4LSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX4) << 24) | ((SDL_BITMAPORDER_4321) << 20) | ((0) << 16) | ((4) << 8) | ((0) << 0)),
    SDL_PIXELFORMAT_INDEX4MSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX4) << 24) | ((SDL_BITMAPORDER_1234) << 20) | ((0) << 16) | ((4) << 8) | ((0) << 0)),
    SDL_PIXELFORMAT_INDEX8 =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX8) << 24) | ((0) << 20) | ((0) << 16) | ((8) << 8) | ((1) << 0)),
    SDL_PIXELFORMAT_RGB332 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED8) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_332) << 16) | ((8) << 8) | ((1) << 0)),
    SDL_PIXELFORMAT_RGB444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((12) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_RGB555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((15) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_BGR555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((15) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_ARGB4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_RGBA4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_RGBA) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_ABGR4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ABGR) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_BGRA4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_BGRA) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_ARGB1555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_RGBA5551 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_RGBA) << 20) | ((SDL_PACKEDLAYOUT_5551) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_ABGR1555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ABGR) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_BGRA5551 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_BGRA) << 20) | ((SDL_PACKEDLAYOUT_5551) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_RGB565 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_565) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_BGR565 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_565) << 16) | ((16) << 8) | ((2) << 0)),
    SDL_PIXELFORMAT_RGB24 =
        ((1 << 28) | ((SDL_PIXELTYPE_ARRAYU8) << 24) | ((SDL_ARRAYORDER_RGB) << 20) | ((0) << 16) | ((24) << 8) | ((3) << 0)),
    SDL_PIXELFORMAT_BGR24 =
        ((1 << 28) | ((SDL_PIXELTYPE_ARRAYU8) << 24) | ((SDL_ARRAYORDER_BGR) << 20) | ((0) << 16) | ((24) << 8) | ((3) << 0)),
    SDL_PIXELFORMAT_RGB888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_RGBX8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_RGBX) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_BGR888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_BGRX8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_BGRX) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_ARGB8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_RGBA8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_RGBA) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_ABGR8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_ABGR) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_BGRA8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_BGRA) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_ARGB2101010 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_2101010) << 16) | ((32) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888,
    SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888,
    SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888,
    SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888,
    SDL_PIXELFORMAT_YV12 =
        ((((Uint32)(((Uint8)(('Y'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('1'))))) << 16) | (((Uint32)(((Uint8)(('2'))))) << 24)),
    SDL_PIXELFORMAT_IYUV =
        ((((Uint32)(((Uint8)(('I'))))) << 0) | (((Uint32)(((Uint8)(('Y'))))) << 8) | (((Uint32)(((Uint8)(('U'))))) << 16) | (((Uint32)(((Uint8)(('V'))))) << 24)),
    SDL_PIXELFORMAT_YUY2 =
        ((((Uint32)(((Uint8)(('Y'))))) << 0) | (((Uint32)(((Uint8)(('U'))))) << 8) | (((Uint32)(((Uint8)(('Y'))))) << 16) | (((Uint32)(((Uint8)(('2'))))) << 24)),
    SDL_PIXELFORMAT_UYVY =
        ((((Uint32)(((Uint8)(('U'))))) << 0) | (((Uint32)(((Uint8)(('Y'))))) << 8) | (((Uint32)(((Uint8)(('V'))))) << 16) | (((Uint32)(((Uint8)(('Y'))))) << 24)),
    SDL_PIXELFORMAT_YVYU =
        ((((Uint32)(((Uint8)(('Y'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('Y'))))) << 16) | (((Uint32)(((Uint8)(('U'))))) << 24)),
    SDL_PIXELFORMAT_NV12 =
        ((((Uint32)(((Uint8)(('N'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('1'))))) << 16) | (((Uint32)(((Uint8)(('2'))))) << 24)),
    SDL_PIXELFORMAT_NV21 =
        ((((Uint32)(((Uint8)(('N'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('2'))))) << 16) | (((Uint32)(((Uint8)(('1'))))) << 24))
};
typedef struct SDL_Color
{
    Uint8 r;
    Uint8 g;
    Uint8 b;
    Uint8 a;
} SDL_Color;
typedef struct SDL_Palette
{
    int ncolors;
    SDL_Color *colors;
    Uint32 version;
    int refcount;
} SDL_Palette;
typedef struct SDL_PixelFormat
{
    Uint32 format;
    SDL_Palette *palette;
    Uint8 BitsPerPixel;
    Uint8 BytesPerPixel;
    Uint8 padding[2];
    Uint32 Rmask;
    Uint32 Gmask;
    Uint32 Bmask;
    Uint32 Amask;
    Uint8 Rloss;
    Uint8 Gloss;
    Uint8 Bloss;
    Uint8 Aloss;
    Uint8 Rshift;
    Uint8 Gshift;
    Uint8 Bshift;
    Uint8 Ashift;
    int refcount;
    struct SDL_PixelFormat *next;
} SDL_PixelFormat;
const char* SDL_GetPixelFormatName(Uint32 format);
SDL_bool SDL_PixelFormatEnumToMasks(Uint32 format,
                                                            int *bpp,
                                                            Uint32 * Rmask,
                                                            Uint32 * Gmask,
                                                            Uint32 * Bmask,
                                                            Uint32 * Amask);
Uint32 SDL_MasksToPixelFormatEnum(int bpp,
                                                          Uint32 Rmask,
                                                          Uint32 Gmask,
                                                          Uint32 Bmask,
                                                          Uint32 Amask);
SDL_PixelFormat * SDL_AllocFormat(Uint32 pixel_format);
void SDL_FreeFormat(SDL_PixelFormat *format);
SDL_Palette * SDL_AllocPalette(int ncolors);
int SDL_SetPixelFormatPalette(SDL_PixelFormat * format,
                                                      SDL_Palette *palette);
int SDL_SetPaletteColors(SDL_Palette * palette,
                                                 const SDL_Color * colors,
                                                 int firstcolor, int ncolors);
void SDL_FreePalette(SDL_Palette * palette);
Uint32 SDL_MapRGB(const SDL_PixelFormat * format,
                                          Uint8 r, Uint8 g, Uint8 b);
Uint32 SDL_MapRGBA(const SDL_PixelFormat * format,
                                           Uint8 r, Uint8 g, Uint8 b,
                                           Uint8 a);
void SDL_GetRGB(Uint32 pixel,
                                        const SDL_PixelFormat * format,
                                        Uint8 * r, Uint8 * g, Uint8 * b);
void SDL_GetRGBA(Uint32 pixel,
                                         const SDL_PixelFormat * format,
                                         Uint8 * r, Uint8 * g, Uint8 * b,
                                         Uint8 * a);
void SDL_CalculateGammaRamp(float gamma, Uint16 * ramp);
typedef struct SDL_Point
{
    int x;
    int y;
} SDL_Point;
typedef struct SDL_Rect
{
    int x, y;
    int w, h;
} SDL_Rect;
typedef struct SDL_Surface {
        Uint32 flags;                           /* Read-only */
        SDL_PixelFormat *format;                /* Read-only */
        int w, h;                               /* Read-only */
        Uint16 pitch;                           /* Read-only */
        void *pixels;                           /* Read-write */

        /* clipping information */
        SDL_Rect clip_rect;                     /* Read-only */

        /* Reference count -- used when freeing surface */
        int refcount;                           /* Read-mostly */

	/* This structure also contains private fields not shown here */
} SDL_Surface;
__attribute__((always_inline)) static __inline__ SDL_bool SDL_PointInRect(const SDL_Point *p, const SDL_Rect *r)
{
    return ( (p->x >= r->x) && (p->x < (r->x + r->w)) &&
             (p->y >= r->y) && (p->y < (r->y + r->h)) ) ? SDL_TRUE : SDL_FALSE;
}
__attribute__((always_inline)) static __inline__ SDL_bool SDL_RectEmpty(const SDL_Rect *r)
{
    return ((!r) || (r->w <= 0) || (r->h <= 0)) ? SDL_TRUE : SDL_FALSE;
}
__attribute__((always_inline)) static __inline__ SDL_bool SDL_RectEquals(const SDL_Rect *a, const SDL_Rect *b)
{
    return (a && b && (a->x == b->x) && (a->y == b->y) &&
            (a->w == b->w) && (a->h == b->h)) ? SDL_TRUE : SDL_FALSE;
}
SDL_bool SDL_HasIntersection(const SDL_Rect * A,
                                                     const SDL_Rect * B);
SDL_bool SDL_IntersectRect(const SDL_Rect * A,
                                                   const SDL_Rect * B,
                                                   SDL_Rect * result);
void SDL_UnionRect(const SDL_Rect * A,
                                           const SDL_Rect * B,
                                           SDL_Rect * result);
SDL_bool SDL_EnclosePoints(const SDL_Point * points,
                                                   int count,
                                                   const SDL_Rect * clip,
                                                   SDL_Rect * result);
SDL_bool SDL_IntersectRectAndLine(const SDL_Rect *
                                                          rect, int *X1,
                                                          int *Y1, int *X2,
                                                          int *Y2);
typedef enum
{
    SDL_BLENDMODE_NONE = 0x00000000,
    SDL_BLENDMODE_BLEND = 0x00000001,
    SDL_BLENDMODE_ADD = 0x00000002,
    SDL_BLENDMODE_MOD = 0x00000004
} SDL_BlendMode;
typedef int (*SDL_blit) (struct SDL_Surface * src, SDL_Rect * srcrect,
                         struct SDL_Surface * dst, SDL_Rect * dstrect);
SDL_Surface * SDL_CreateRGBSurface
    (Uint32 flags, int width, int height, int depth,
     Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);
SDL_Surface * SDL_CreateRGBSurfaceWithFormat
    (Uint32 flags, int width, int height, int depth, Uint32 format);
SDL_Surface * SDL_CreateRGBSurfaceFrom(void *pixels,
                                                              int width,
                                                              int height,
                                                              int depth,
                                                              int pitch,
                                                              Uint32 Rmask,
                                                              Uint32 Gmask,
                                                              Uint32 Bmask,
                                                              Uint32 Amask);
SDL_Surface * SDL_CreateRGBSurfaceWithFormatFrom
    (void *pixels, int width, int height, int depth, int pitch, Uint32 format);
void SDL_FreeSurface(SDL_Surface * surface);
int SDL_SetSurfacePalette(SDL_Surface * surface,
                                                  SDL_Palette * palette);
int SDL_LockSurface(SDL_Surface * surface);
void SDL_UnlockSurface(SDL_Surface * surface);
SDL_Surface * SDL_LoadBMP_RW(SDL_RWops * src,
                                                    int freesrc);
int SDL_SaveBMP_RW
    (SDL_Surface * surface, SDL_RWops * dst, int freedst);
int SDL_SetSurfaceRLE(SDL_Surface * surface,
                                              int flag);
int SDL_SetColorKey(SDL_Surface * surface,
                                            int flag, Uint32 key);
int SDL_GetColorKey(SDL_Surface * surface,
                                            Uint32 * key);
int SDL_SetSurfaceColorMod(SDL_Surface * surface,
                                                   Uint8 r, Uint8 g, Uint8 b);
int SDL_GetSurfaceColorMod(SDL_Surface * surface,
                                                   Uint8 * r, Uint8 * g,
                                                   Uint8 * b);
int SDL_SetSurfaceAlphaMod(SDL_Surface * surface,
                                                   Uint8 alpha);
int SDL_GetSurfaceAlphaMod(SDL_Surface * surface,
                                                   Uint8 * alpha);
int SDL_SetSurfaceBlendMode(SDL_Surface * surface,
                                                    SDL_BlendMode blendMode);
int SDL_GetSurfaceBlendMode(SDL_Surface * surface,
                                                    SDL_BlendMode *blendMode);
SDL_bool SDL_SetClipRect(SDL_Surface * surface,
                                                 const SDL_Rect * rect);
void SDL_GetClipRect(SDL_Surface * surface,
                                             SDL_Rect * rect);
SDL_Surface * SDL_ConvertSurface
    (SDL_Surface * src, const SDL_PixelFormat * fmt, Uint32 flags);
SDL_Surface * SDL_ConvertSurfaceFormat
    (SDL_Surface * src, Uint32 pixel_format, Uint32 flags);
int SDL_ConvertPixels(int width, int height,
                                              Uint32 src_format,
                                              const void * src, int src_pitch,
                                              Uint32 dst_format,
                                              void * dst, int dst_pitch);
int SDL_FillRect
    (SDL_Surface * dst, const SDL_Rect * rect, Uint32 color);
int SDL_FillRects
    (SDL_Surface * dst, const SDL_Rect * rects, int count, Uint32 color);
int SDL_UpperBlit
    (SDL_Surface * src, const SDL_Rect * srcrect,
     SDL_Surface * dst, SDL_Rect * dstrect);
int SDL_LowerBlit
    (SDL_Surface * src, SDL_Rect * srcrect,
     SDL_Surface * dst, SDL_Rect * dstrect);
int SDL_SoftStretch(SDL_Surface * src,
                                            const SDL_Rect * srcrect,
                                            SDL_Surface * dst,
                                            const SDL_Rect * dstrect);
int SDL_UpperBlitScaled
    (SDL_Surface * src, const SDL_Rect * srcrect,
    SDL_Surface * dst, SDL_Rect * dstrect);
int SDL_LowerBlitScaled
    (SDL_Surface * src, SDL_Rect * srcrect,
    SDL_Surface * dst, SDL_Rect * dstrect);
typedef struct
{
    Uint32 format;
    int w;
    int h;
    int refresh_rate;
    void *driverdata;
} SDL_DisplayMode;
typedef struct SDL_Window SDL_Window;
typedef enum
{
    SDL_WINDOW_FULLSCREEN = 0x00000001,
    SDL_WINDOW_OPENGL = 0x00000002,
    SDL_WINDOW_SHOWN = 0x00000004,
    SDL_WINDOW_HIDDEN = 0x00000008,
    SDL_WINDOW_BORDERLESS = 0x00000010,
    SDL_WINDOW_RESIZABLE = 0x00000020,
    SDL_WINDOW_MINIMIZED = 0x00000040,
    SDL_WINDOW_MAXIMIZED = 0x00000080,
    SDL_WINDOW_INPUT_GRABBED = 0x00000100,
    SDL_WINDOW_INPUT_FOCUS = 0x00000200,
    SDL_WINDOW_MOUSE_FOCUS = 0x00000400,
    SDL_WINDOW_FULLSCREEN_DESKTOP = ( SDL_WINDOW_FULLSCREEN | 0x00001000 ),
    SDL_WINDOW_FOREIGN = 0x00000800,
    SDL_WINDOW_ALLOW_HIGHDPI = 0x00002000,
    SDL_WINDOW_MOUSE_CAPTURE = 0x00004000,
    SDL_WINDOW_ALWAYS_ON_TOP = 0x00008000,
    SDL_WINDOW_SKIP_TASKBAR = 0x00010000,
    SDL_WINDOW_UTILITY = 0x00020000,
    SDL_WINDOW_TOOLTIP = 0x00040000,
    SDL_WINDOW_POPUP_MENU = 0x00080000
} SDL_WindowFlags;
typedef enum
{
    SDL_WINDOWEVENT_NONE,
    SDL_WINDOWEVENT_SHOWN,
    SDL_WINDOWEVENT_HIDDEN,
    SDL_WINDOWEVENT_EXPOSED,
    SDL_WINDOWEVENT_MOVED,
    SDL_WINDOWEVENT_RESIZED,
    SDL_WINDOWEVENT_SIZE_CHANGED,
    SDL_WINDOWEVENT_MINIMIZED,
    SDL_WINDOWEVENT_MAXIMIZED,
    SDL_WINDOWEVENT_RESTORED,
    SDL_WINDOWEVENT_ENTER,
    SDL_WINDOWEVENT_LEAVE,
    SDL_WINDOWEVENT_FOCUS_GAINED,
    SDL_WINDOWEVENT_FOCUS_LOST,
    SDL_WINDOWEVENT_CLOSE,
    SDL_WINDOWEVENT_TAKE_FOCUS,
    SDL_WINDOWEVENT_HIT_TEST
} SDL_WindowEventID;
typedef void *SDL_GLContext;
typedef enum
{
    SDL_GL_RED_SIZE,
    SDL_GL_GREEN_SIZE,
    SDL_GL_BLUE_SIZE,
    SDL_GL_ALPHA_SIZE,
    SDL_GL_BUFFER_SIZE,
    SDL_GL_DOUBLEBUFFER,
    SDL_GL_DEPTH_SIZE,
    SDL_GL_STENCIL_SIZE,
    SDL_GL_ACCUM_RED_SIZE,
    SDL_GL_ACCUM_GREEN_SIZE,
    SDL_GL_ACCUM_BLUE_SIZE,
    SDL_GL_ACCUM_ALPHA_SIZE,
    SDL_GL_STEREO,
    SDL_GL_MULTISAMPLEBUFFERS,
    SDL_GL_MULTISAMPLESAMPLES,
    SDL_GL_ACCELERATED_VISUAL,
    SDL_GL_RETAINED_BACKING,
    SDL_GL_CONTEXT_MAJOR_VERSION,
    SDL_GL_CONTEXT_MINOR_VERSION,
    SDL_GL_CONTEXT_EGL,
    SDL_GL_CONTEXT_FLAGS,
    SDL_GL_CONTEXT_PROFILE_MASK,
    SDL_GL_SHARE_WITH_CURRENT_CONTEXT,
    SDL_GL_FRAMEBUFFER_SRGB_CAPABLE,
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR
} SDL_GLattr;
typedef enum
{
    SDL_GL_CONTEXT_PROFILE_CORE = 0x0001,
    SDL_GL_CONTEXT_PROFILE_COMPATIBILITY = 0x0002,
    SDL_GL_CONTEXT_PROFILE_ES = 0x0004
} SDL_GLprofile;
typedef enum
{
    SDL_GL_CONTEXT_DEBUG_FLAG = 0x0001,
    SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = 0x0002,
    SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG = 0x0004,
    SDL_GL_CONTEXT_RESET_ISOLATION_FLAG = 0x0008
} SDL_GLcontextFlag;
typedef enum
{
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE = 0x0000,
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = 0x0001
} SDL_GLcontextReleaseFlag;
int SDL_GetNumVideoDrivers(void);
const char * SDL_GetVideoDriver(int index);
int SDL_VideoInit(const char *driver_name);
void SDL_VideoQuit(void);
const char * SDL_GetCurrentVideoDriver(void);
int SDL_GetNumVideoDisplays(void);
const char * SDL_GetDisplayName(int displayIndex);
int SDL_GetDisplayBounds(int displayIndex, SDL_Rect * rect);
int SDL_GetDisplayDPI(int displayIndex, float * ddpi, float * hdpi, float * vdpi);
int SDL_GetDisplayUsableBounds(int displayIndex, SDL_Rect * rect);
int SDL_GetNumDisplayModes(int displayIndex);
int SDL_GetDisplayMode(int displayIndex, int modeIndex,
                                               SDL_DisplayMode * mode);
int SDL_GetDesktopDisplayMode(int displayIndex, SDL_DisplayMode * mode);
int SDL_GetCurrentDisplayMode(int displayIndex, SDL_DisplayMode * mode);
SDL_DisplayMode * SDL_GetClosestDisplayMode(int displayIndex, const SDL_DisplayMode * mode, SDL_DisplayMode * closest);
int SDL_GetWindowDisplayIndex(SDL_Window * window);
int SDL_SetWindowDisplayMode(SDL_Window * window,
                                                     const SDL_DisplayMode
                                                         * mode);
int SDL_GetWindowDisplayMode(SDL_Window * window,
                                                     SDL_DisplayMode * mode);
Uint32 SDL_GetWindowPixelFormat(SDL_Window * window);
SDL_Window * SDL_CreateWindow(const char *title,
                                                      int x, int y, int w,
                                                      int h, Uint32 flags);
SDL_Window * SDL_CreateWindowFrom(const void *data);
Uint32 SDL_GetWindowID(SDL_Window * window);
SDL_Window * SDL_GetWindowFromID(Uint32 id);
Uint32 SDL_GetWindowFlags(SDL_Window * window);
void SDL_SetWindowTitle(SDL_Window * window,
                                                const char *title);
const char * SDL_GetWindowTitle(SDL_Window * window);
void SDL_SetWindowIcon(SDL_Window * window,
                                               SDL_Surface * icon);
void* SDL_SetWindowData(SDL_Window * window,
                                                const char *name,
                                                void *userdata);
void * SDL_GetWindowData(SDL_Window * window,
                                                const char *name);
void SDL_SetWindowPosition(SDL_Window * window,
                                                   int x, int y);
void SDL_GetWindowPosition(SDL_Window * window,
                                                   int *x, int *y);
void SDL_SetWindowSize(SDL_Window * window, int w,
                                               int h);
void SDL_GetWindowSize(SDL_Window * window, int *w,
                                               int *h);
int SDL_GetWindowBordersSize(SDL_Window * window,
                                                     int *top, int *left,
                                                     int *bottom, int *right);
void SDL_SetWindowMinimumSize(SDL_Window * window,
                                                      int min_w, int min_h);
void SDL_GetWindowMinimumSize(SDL_Window * window,
                                                      int *w, int *h);
void SDL_SetWindowMaximumSize(SDL_Window * window,
                                                      int max_w, int max_h);
void SDL_GetWindowMaximumSize(SDL_Window * window,
                                                      int *w, int *h);
void SDL_SetWindowBordered(SDL_Window * window,
                                                   SDL_bool bordered);
void SDL_SetWindowResizable(SDL_Window * window,
                                                    SDL_bool resizable);
void SDL_ShowWindow(SDL_Window * window);
void SDL_HideWindow(SDL_Window * window);
void SDL_RaiseWindow(SDL_Window * window);
void SDL_MaximizeWindow(SDL_Window * window);
void SDL_MinimizeWindow(SDL_Window * window);
void SDL_RestoreWindow(SDL_Window * window);
int SDL_SetWindowFullscreen(SDL_Window * window,
                                                    Uint32 flags);
SDL_Surface * SDL_GetWindowSurface(SDL_Window * window);
int SDL_UpdateWindowSurface(SDL_Window * window);
int SDL_UpdateWindowSurfaceRects(SDL_Window * window,
                                                         const SDL_Rect * rects,
                                                         int numrects);
void SDL_SetWindowGrab(SDL_Window * window,
                                               SDL_bool grabbed);
SDL_bool SDL_GetWindowGrab(SDL_Window * window);
SDL_Window * SDL_GetGrabbedWindow(void);
int SDL_SetWindowBrightness(SDL_Window * window, float brightness);
float SDL_GetWindowBrightness(SDL_Window * window);
int SDL_SetWindowOpacity(SDL_Window * window, float opacity);
int SDL_GetWindowOpacity(SDL_Window * window, float * out_opacity);
int SDL_SetWindowModalFor(SDL_Window * modal_window, SDL_Window * parent_window);
int SDL_SetWindowInputFocus(SDL_Window * window);
int SDL_SetWindowGammaRamp(SDL_Window * window,
                                                   const Uint16 * red,
                                                   const Uint16 * green,
                                                   const Uint16 * blue);
int SDL_GetWindowGammaRamp(SDL_Window * window,
                                                   Uint16 * red,
                                                   Uint16 * green,
                                                   Uint16 * blue);
typedef enum
{
    SDL_HITTEST_NORMAL,
    SDL_HITTEST_DRAGGABLE,
    SDL_HITTEST_RESIZE_TOPLEFT,
    SDL_HITTEST_RESIZE_TOP,
    SDL_HITTEST_RESIZE_TOPRIGHT,
    SDL_HITTEST_RESIZE_RIGHT,
    SDL_HITTEST_RESIZE_BOTTOMRIGHT,
    SDL_HITTEST_RESIZE_BOTTOM,
    SDL_HITTEST_RESIZE_BOTTOMLEFT,
    SDL_HITTEST_RESIZE_LEFT
} SDL_HitTestResult;
typedef SDL_HitTestResult ( *SDL_HitTest)(SDL_Window *win,
                                                 const SDL_Point *area,
                                                 void *data);
int SDL_SetWindowHitTest(SDL_Window * window,
                                                 SDL_HitTest callback,
                                                 void *callback_data);
void SDL_DestroyWindow(SDL_Window * window);
SDL_bool SDL_IsScreenSaverEnabled(void);
void SDL_EnableScreenSaver(void);
void SDL_DisableScreenSaver(void);
int SDL_GL_LoadLibrary(const char *path);
void * SDL_GL_GetProcAddress(const char *proc);
void SDL_GL_UnloadLibrary(void);
SDL_bool SDL_GL_ExtensionSupported(const char
                                                           *extension);
void SDL_GL_ResetAttributes(void);
int SDL_GL_SetAttribute(SDL_GLattr attr, int value);
int SDL_GL_GetAttribute(SDL_GLattr attr, int *value);
SDL_GLContext SDL_GL_CreateContext(SDL_Window *
                                                           window);
int SDL_GL_MakeCurrent(SDL_Window * window,
                                               SDL_GLContext context);
SDL_Window* SDL_GL_GetCurrentWindow(void);
SDL_GLContext SDL_GL_GetCurrentContext(void);
void SDL_GL_GetDrawableSize(SDL_Window * window, int *w,
                                                    int *h);
int SDL_GL_SetSwapInterval(int interval);
int SDL_GL_GetSwapInterval(void);
void SDL_GL_SwapWindow(SDL_Window * window);
void SDL_GL_DeleteContext(SDL_GLContext context);
typedef enum
{
    SDL_SCANCODE_UNKNOWN = 0,
    SDL_SCANCODE_A = 4,
    SDL_SCANCODE_B = 5,
    SDL_SCANCODE_C = 6,
    SDL_SCANCODE_D = 7,
    SDL_SCANCODE_E = 8,
    SDL_SCANCODE_F = 9,
    SDL_SCANCODE_G = 10,
    SDL_SCANCODE_H = 11,
    SDL_SCANCODE_I = 12,
    SDL_SCANCODE_J = 13,
    SDL_SCANCODE_K = 14,
    SDL_SCANCODE_L = 15,
    SDL_SCANCODE_M = 16,
    SDL_SCANCODE_N = 17,
    SDL_SCANCODE_O = 18,
    SDL_SCANCODE_P = 19,
    SDL_SCANCODE_Q = 20,
    SDL_SCANCODE_R = 21,
    SDL_SCANCODE_S = 22,
    SDL_SCANCODE_T = 23,
    SDL_SCANCODE_U = 24,
    SDL_SCANCODE_V = 25,
    SDL_SCANCODE_W = 26,
    SDL_SCANCODE_X = 27,
    SDL_SCANCODE_Y = 28,
    SDL_SCANCODE_Z = 29,
    SDL_SCANCODE_1 = 30,
    SDL_SCANCODE_2 = 31,
    SDL_SCANCODE_3 = 32,
    SDL_SCANCODE_4 = 33,
    SDL_SCANCODE_5 = 34,
    SDL_SCANCODE_6 = 35,
    SDL_SCANCODE_7 = 36,
    SDL_SCANCODE_8 = 37,
    SDL_SCANCODE_9 = 38,
    SDL_SCANCODE_0 = 39,
    SDL_SCANCODE_RETURN = 40,
    SDL_SCANCODE_ESCAPE = 41,
    SDL_SCANCODE_BACKSPACE = 42,
    SDL_SCANCODE_TAB = 43,
    SDL_SCANCODE_SPACE = 44,
    SDL_SCANCODE_MINUS = 45,
    SDL_SCANCODE_EQUALS = 46,
    SDL_SCANCODE_LEFTBRACKET = 47,
    SDL_SCANCODE_RIGHTBRACKET = 48,
    SDL_SCANCODE_BACKSLASH = 49,
    SDL_SCANCODE_NONUSHASH = 50,
    SDL_SCANCODE_SEMICOLON = 51,
    SDL_SCANCODE_APOSTROPHE = 52,
    SDL_SCANCODE_GRAVE = 53,
    SDL_SCANCODE_COMMA = 54,
    SDL_SCANCODE_PERIOD = 55,
    SDL_SCANCODE_SLASH = 56,
    SDL_SCANCODE_CAPSLOCK = 57,
    SDL_SCANCODE_F1 = 58,
    SDL_SCANCODE_F2 = 59,
    SDL_SCANCODE_F3 = 60,
    SDL_SCANCODE_F4 = 61,
    SDL_SCANCODE_F5 = 62,
    SDL_SCANCODE_F6 = 63,
    SDL_SCANCODE_F7 = 64,
    SDL_SCANCODE_F8 = 65,
    SDL_SCANCODE_F9 = 66,
    SDL_SCANCODE_F10 = 67,
    SDL_SCANCODE_F11 = 68,
    SDL_SCANCODE_F12 = 69,
    SDL_SCANCODE_PRINTSCREEN = 70,
    SDL_SCANCODE_SCROLLLOCK = 71,
    SDL_SCANCODE_PAUSE = 72,
    SDL_SCANCODE_INSERT = 73,
    SDL_SCANCODE_HOME = 74,
    SDL_SCANCODE_PAGEUP = 75,
    SDL_SCANCODE_DELETE = 76,
    SDL_SCANCODE_END = 77,
    SDL_SCANCODE_PAGEDOWN = 78,
    SDL_SCANCODE_RIGHT = 79,
    SDL_SCANCODE_LEFT = 80,
    SDL_SCANCODE_DOWN = 81,
    SDL_SCANCODE_UP = 82,
    SDL_SCANCODE_NUMLOCKCLEAR = 83,
    SDL_SCANCODE_KP_DIVIDE = 84,
    SDL_SCANCODE_KP_MULTIPLY = 85,
    SDL_SCANCODE_KP_MINUS = 86,
    SDL_SCANCODE_KP_PLUS = 87,
    SDL_SCANCODE_KP_ENTER = 88,
    SDL_SCANCODE_KP_1 = 89,
    SDL_SCANCODE_KP_2 = 90,
    SDL_SCANCODE_KP_3 = 91,
    SDL_SCANCODE_KP_4 = 92,
    SDL_SCANCODE_KP_5 = 93,
    SDL_SCANCODE_KP_6 = 94,
    SDL_SCANCODE_KP_7 = 95,
    SDL_SCANCODE_KP_8 = 96,
    SDL_SCANCODE_KP_9 = 97,
    SDL_SCANCODE_KP_0 = 98,
    SDL_SCANCODE_KP_PERIOD = 99,
    SDL_SCANCODE_NONUSBACKSLASH = 100,
    SDL_SCANCODE_APPLICATION = 101,
    SDL_SCANCODE_POWER = 102,
    SDL_SCANCODE_KP_EQUALS = 103,
    SDL_SCANCODE_F13 = 104,
    SDL_SCANCODE_F14 = 105,
    SDL_SCANCODE_F15 = 106,
    SDL_SCANCODE_F16 = 107,
    SDL_SCANCODE_F17 = 108,
    SDL_SCANCODE_F18 = 109,
    SDL_SCANCODE_F19 = 110,
    SDL_SCANCODE_F20 = 111,
    SDL_SCANCODE_F21 = 112,
    SDL_SCANCODE_F22 = 113,
    SDL_SCANCODE_F23 = 114,
    SDL_SCANCODE_F24 = 115,
    SDL_SCANCODE_EXECUTE = 116,
    SDL_SCANCODE_HELP = 117,
    SDL_SCANCODE_MENU = 118,
    SDL_SCANCODE_SELECT = 119,
    SDL_SCANCODE_STOP = 120,
    SDL_SCANCODE_AGAIN = 121,
    SDL_SCANCODE_UNDO = 122,
    SDL_SCANCODE_CUT = 123,
    SDL_SCANCODE_COPY = 124,
    SDL_SCANCODE_PASTE = 125,
    SDL_SCANCODE_FIND = 126,
    SDL_SCANCODE_MUTE = 127,
    SDL_SCANCODE_VOLUMEUP = 128,
    SDL_SCANCODE_VOLUMEDOWN = 129,
    SDL_SCANCODE_KP_COMMA = 133,
    SDL_SCANCODE_KP_EQUALSAS400 = 134,
    SDL_SCANCODE_INTERNATIONAL1 = 135,
    SDL_SCANCODE_INTERNATIONAL2 = 136,
    SDL_SCANCODE_INTERNATIONAL3 = 137,
    SDL_SCANCODE_INTERNATIONAL4 = 138,
    SDL_SCANCODE_INTERNATIONAL5 = 139,
    SDL_SCANCODE_INTERNATIONAL6 = 140,
    SDL_SCANCODE_INTERNATIONAL7 = 141,
    SDL_SCANCODE_INTERNATIONAL8 = 142,
    SDL_SCANCODE_INTERNATIONAL9 = 143,
    SDL_SCANCODE_LANG1 = 144,
    SDL_SCANCODE_LANG2 = 145,
    SDL_SCANCODE_LANG3 = 146,
    SDL_SCANCODE_LANG4 = 147,
    SDL_SCANCODE_LANG5 = 148,
    SDL_SCANCODE_LANG6 = 149,
    SDL_SCANCODE_LANG7 = 150,
    SDL_SCANCODE_LANG8 = 151,
    SDL_SCANCODE_LANG9 = 152,
    SDL_SCANCODE_ALTERASE = 153,
    SDL_SCANCODE_SYSREQ = 154,
    SDL_SCANCODE_CANCEL = 155,
    SDL_SCANCODE_CLEAR = 156,
    SDL_SCANCODE_PRIOR = 157,
    SDL_SCANCODE_RETURN2 = 158,
    SDL_SCANCODE_SEPARATOR = 159,
    SDL_SCANCODE_OUT = 160,
    SDL_SCANCODE_OPER = 161,
    SDL_SCANCODE_CLEARAGAIN = 162,
    SDL_SCANCODE_CRSEL = 163,
    SDL_SCANCODE_EXSEL = 164,
    SDL_SCANCODE_KP_00 = 176,
    SDL_SCANCODE_KP_000 = 177,
    SDL_SCANCODE_THOUSANDSSEPARATOR = 178,
    SDL_SCANCODE_DECIMALSEPARATOR = 179,
    SDL_SCANCODE_CURRENCYUNIT = 180,
    SDL_SCANCODE_CURRENCYSUBUNIT = 181,
    SDL_SCANCODE_KP_LEFTPAREN = 182,
    SDL_SCANCODE_KP_RIGHTPAREN = 183,
    SDL_SCANCODE_KP_LEFTBRACE = 184,
    SDL_SCANCODE_KP_RIGHTBRACE = 185,
    SDL_SCANCODE_KP_TAB = 186,
    SDL_SCANCODE_KP_BACKSPACE = 187,
    SDL_SCANCODE_KP_A = 188,
    SDL_SCANCODE_KP_B = 189,
    SDL_SCANCODE_KP_C = 190,
    SDL_SCANCODE_KP_D = 191,
    SDL_SCANCODE_KP_E = 192,
    SDL_SCANCODE_KP_F = 193,
    SDL_SCANCODE_KP_XOR = 194,
    SDL_SCANCODE_KP_POWER = 195,
    SDL_SCANCODE_KP_PERCENT = 196,
    SDL_SCANCODE_KP_LESS = 197,
    SDL_SCANCODE_KP_GREATER = 198,
    SDL_SCANCODE_KP_AMPERSAND = 199,
    SDL_SCANCODE_KP_DBLAMPERSAND = 200,
    SDL_SCANCODE_KP_VERTICALBAR = 201,
    SDL_SCANCODE_KP_DBLVERTICALBAR = 202,
    SDL_SCANCODE_KP_COLON = 203,
    SDL_SCANCODE_KP_HASH = 204,
    SDL_SCANCODE_KP_SPACE = 205,
    SDL_SCANCODE_KP_AT = 206,
    SDL_SCANCODE_KP_EXCLAM = 207,
    SDL_SCANCODE_KP_MEMSTORE = 208,
    SDL_SCANCODE_KP_MEMRECALL = 209,
    SDL_SCANCODE_KP_MEMCLEAR = 210,
    SDL_SCANCODE_KP_MEMADD = 211,
    SDL_SCANCODE_KP_MEMSUBTRACT = 212,
    SDL_SCANCODE_KP_MEMMULTIPLY = 213,
    SDL_SCANCODE_KP_MEMDIVIDE = 214,
    SDL_SCANCODE_KP_PLUSMINUS = 215,
    SDL_SCANCODE_KP_CLEAR = 216,
    SDL_SCANCODE_KP_CLEARENTRY = 217,
    SDL_SCANCODE_KP_BINARY = 218,
    SDL_SCANCODE_KP_OCTAL = 219,
    SDL_SCANCODE_KP_DECIMAL = 220,
    SDL_SCANCODE_KP_HEXADECIMAL = 221,
    SDL_SCANCODE_LCTRL = 224,
    SDL_SCANCODE_LSHIFT = 225,
    SDL_SCANCODE_LALT = 226,
    SDL_SCANCODE_LGUI = 227,
    SDL_SCANCODE_RCTRL = 228,
    SDL_SCANCODE_RSHIFT = 229,
    SDL_SCANCODE_RALT = 230,
    SDL_SCANCODE_RGUI = 231,
    SDL_SCANCODE_MODE = 257,
    SDL_SCANCODE_AUDIONEXT = 258,
    SDL_SCANCODE_AUDIOPREV = 259,
    SDL_SCANCODE_AUDIOSTOP = 260,
    SDL_SCANCODE_AUDIOPLAY = 261,
    SDL_SCANCODE_AUDIOMUTE = 262,
    SDL_SCANCODE_MEDIASELECT = 263,
    SDL_SCANCODE_WWW = 264,
    SDL_SCANCODE_MAIL = 265,
    SDL_SCANCODE_CALCULATOR = 266,
    SDL_SCANCODE_COMPUTER = 267,
    SDL_SCANCODE_AC_SEARCH = 268,
    SDL_SCANCODE_AC_HOME = 269,
    SDL_SCANCODE_AC_BACK = 270,
    SDL_SCANCODE_AC_FORWARD = 271,
    SDL_SCANCODE_AC_STOP = 272,
    SDL_SCANCODE_AC_REFRESH = 273,
    SDL_SCANCODE_AC_BOOKMARKS = 274,
    SDL_SCANCODE_BRIGHTNESSDOWN = 275,
    SDL_SCANCODE_BRIGHTNESSUP = 276,
    SDL_SCANCODE_DISPLAYSWITCH = 277,
    SDL_SCANCODE_KBDILLUMTOGGLE = 278,
    SDL_SCANCODE_KBDILLUMDOWN = 279,
    SDL_SCANCODE_KBDILLUMUP = 280,
    SDL_SCANCODE_EJECT = 281,
    SDL_SCANCODE_SLEEP = 282,
    SDL_SCANCODE_APP1 = 283,
    SDL_SCANCODE_APP2 = 284,
    SDL_NUM_SCANCODES = 512
} SDL_Scancode;
typedef Sint32 SDL_Keycode;
enum
{
    SDLK_UNKNOWN = 0,
    SDLK_RETURN = '\r',
    SDLK_ESCAPE = '\033',
    SDLK_BACKSPACE = '\b',
    SDLK_TAB = '\t',
    SDLK_SPACE = ' ',
    SDLK_EXCLAIM = '!',
    SDLK_QUOTEDBL = '"',
    SDLK_HASH = '#',
    SDLK_PERCENT = '%',
    SDLK_DOLLAR = '$',
    SDLK_AMPERSAND = '&',
    SDLK_QUOTE = '\'',
    SDLK_LEFTPAREN = '(',
    SDLK_RIGHTPAREN = ')',
    SDLK_ASTERISK = '*',
    SDLK_PLUS = '+',
    SDLK_COMMA = ',',
    SDLK_MINUS = '-',
    SDLK_PERIOD = '.',
    SDLK_SLASH = '/',
    SDLK_0 = '0',
    SDLK_1 = '1',
    SDLK_2 = '2',
    SDLK_3 = '3',
    SDLK_4 = '4',
    SDLK_5 = '5',
    SDLK_6 = '6',
    SDLK_7 = '7',
    SDLK_8 = '8',
    SDLK_9 = '9',
    SDLK_COLON = ':',
    SDLK_SEMICOLON = ';',
    SDLK_LESS = '<',
    SDLK_EQUALS = '=',
    SDLK_GREATER = '>',
    SDLK_QUESTION = '?',
    SDLK_AT = '@',
    SDLK_LEFTBRACKET = '[',
    SDLK_BACKSLASH = '\\',
    SDLK_RIGHTBRACKET = ']',
    SDLK_CARET = '^',
    SDLK_UNDERSCORE = '_',
    SDLK_BACKQUOTE = '`',
    SDLK_a = 'a',
    SDLK_b = 'b',
    SDLK_c = 'c',
    SDLK_d = 'd',
    SDLK_e = 'e',
    SDLK_f = 'f',
    SDLK_g = 'g',
    SDLK_h = 'h',
    SDLK_i = 'i',
    SDLK_j = 'j',
    SDLK_k = 'k',
    SDLK_l = 'l',
    SDLK_m = 'm',
    SDLK_n = 'n',
    SDLK_o = 'o',
    SDLK_p = 'p',
    SDLK_q = 'q',
    SDLK_r = 'r',
    SDLK_s = 's',
    SDLK_t = 't',
    SDLK_u = 'u',
    SDLK_v = 'v',
    SDLK_w = 'w',
    SDLK_x = 'x',
    SDLK_y = 'y',
    SDLK_z = 'z',
    SDLK_CAPSLOCK = (SDL_SCANCODE_CAPSLOCK | (1<<30)),
    SDLK_F1 = (SDL_SCANCODE_F1 | (1<<30)),
    SDLK_F2 = (SDL_SCANCODE_F2 | (1<<30)),
    SDLK_F3 = (SDL_SCANCODE_F3 | (1<<30)),
    SDLK_F4 = (SDL_SCANCODE_F4 | (1<<30)),
    SDLK_F5 = (SDL_SCANCODE_F5 | (1<<30)),
    SDLK_F6 = (SDL_SCANCODE_F6 | (1<<30)),
    SDLK_F7 = (SDL_SCANCODE_F7 | (1<<30)),
    SDLK_F8 = (SDL_SCANCODE_F8 | (1<<30)),
    SDLK_F9 = (SDL_SCANCODE_F9 | (1<<30)),
    SDLK_F10 = (SDL_SCANCODE_F10 | (1<<30)),
    SDLK_F11 = (SDL_SCANCODE_F11 | (1<<30)),
    SDLK_F12 = (SDL_SCANCODE_F12 | (1<<30)),
    SDLK_PRINTSCREEN = (SDL_SCANCODE_PRINTSCREEN | (1<<30)),
    SDLK_SCROLLLOCK = (SDL_SCANCODE_SCROLLLOCK | (1<<30)),
    SDLK_PAUSE = (SDL_SCANCODE_PAUSE | (1<<30)),
    SDLK_INSERT = (SDL_SCANCODE_INSERT | (1<<30)),
    SDLK_HOME = (SDL_SCANCODE_HOME | (1<<30)),
    SDLK_PAGEUP = (SDL_SCANCODE_PAGEUP | (1<<30)),
    SDLK_DELETE = '\177',
    SDLK_END = (SDL_SCANCODE_END | (1<<30)),
    SDLK_PAGEDOWN = (SDL_SCANCODE_PAGEDOWN | (1<<30)),
    SDLK_RIGHT = (SDL_SCANCODE_RIGHT | (1<<30)),
    SDLK_LEFT = (SDL_SCANCODE_LEFT | (1<<30)),
    SDLK_DOWN = (SDL_SCANCODE_DOWN | (1<<30)),
    SDLK_UP = (SDL_SCANCODE_UP | (1<<30)),
    SDLK_NUMLOCKCLEAR = (SDL_SCANCODE_NUMLOCKCLEAR | (1<<30)),
    SDLK_KP_DIVIDE = (SDL_SCANCODE_KP_DIVIDE | (1<<30)),
    SDLK_KP_MULTIPLY = (SDL_SCANCODE_KP_MULTIPLY | (1<<30)),
    SDLK_KP_MINUS = (SDL_SCANCODE_KP_MINUS | (1<<30)),
    SDLK_KP_PLUS = (SDL_SCANCODE_KP_PLUS | (1<<30)),
    SDLK_KP_ENTER = (SDL_SCANCODE_KP_ENTER | (1<<30)),
    SDLK_KP_1 = (SDL_SCANCODE_KP_1 | (1<<30)),
    SDLK_KP_2 = (SDL_SCANCODE_KP_2 | (1<<30)),
    SDLK_KP_3 = (SDL_SCANCODE_KP_3 | (1<<30)),
    SDLK_KP_4 = (SDL_SCANCODE_KP_4 | (1<<30)),
    SDLK_KP_5 = (SDL_SCANCODE_KP_5 | (1<<30)),
    SDLK_KP_6 = (SDL_SCANCODE_KP_6 | (1<<30)),
    SDLK_KP_7 = (SDL_SCANCODE_KP_7 | (1<<30)),
    SDLK_KP_8 = (SDL_SCANCODE_KP_8 | (1<<30)),
    SDLK_KP_9 = (SDL_SCANCODE_KP_9 | (1<<30)),
    SDLK_KP_0 = (SDL_SCANCODE_KP_0 | (1<<30)),
    SDLK_KP_PERIOD = (SDL_SCANCODE_KP_PERIOD | (1<<30)),
    SDLK_APPLICATION = (SDL_SCANCODE_APPLICATION | (1<<30)),
    SDLK_POWER = (SDL_SCANCODE_POWER | (1<<30)),
    SDLK_KP_EQUALS = (SDL_SCANCODE_KP_EQUALS | (1<<30)),
    SDLK_F13 = (SDL_SCANCODE_F13 | (1<<30)),
    SDLK_F14 = (SDL_SCANCODE_F14 | (1<<30)),
    SDLK_F15 = (SDL_SCANCODE_F15 | (1<<30)),
    SDLK_F16 = (SDL_SCANCODE_F16 | (1<<30)),
    SDLK_F17 = (SDL_SCANCODE_F17 | (1<<30)),
    SDLK_F18 = (SDL_SCANCODE_F18 | (1<<30)),
    SDLK_F19 = (SDL_SCANCODE_F19 | (1<<30)),
    SDLK_F20 = (SDL_SCANCODE_F20 | (1<<30)),
    SDLK_F21 = (SDL_SCANCODE_F21 | (1<<30)),
    SDLK_F22 = (SDL_SCANCODE_F22 | (1<<30)),
    SDLK_F23 = (SDL_SCANCODE_F23 | (1<<30)),
    SDLK_F24 = (SDL_SCANCODE_F24 | (1<<30)),
    SDLK_EXECUTE = (SDL_SCANCODE_EXECUTE | (1<<30)),
    SDLK_HELP = (SDL_SCANCODE_HELP | (1<<30)),
    SDLK_MENU = (SDL_SCANCODE_MENU | (1<<30)),
    SDLK_SELECT = (SDL_SCANCODE_SELECT | (1<<30)),
    SDLK_STOP = (SDL_SCANCODE_STOP | (1<<30)),
    SDLK_AGAIN = (SDL_SCANCODE_AGAIN | (1<<30)),
    SDLK_UNDO = (SDL_SCANCODE_UNDO | (1<<30)),
    SDLK_CUT = (SDL_SCANCODE_CUT | (1<<30)),
    SDLK_COPY = (SDL_SCANCODE_COPY | (1<<30)),
    SDLK_PASTE = (SDL_SCANCODE_PASTE | (1<<30)),
    SDLK_FIND = (SDL_SCANCODE_FIND | (1<<30)),
    SDLK_MUTE = (SDL_SCANCODE_MUTE | (1<<30)),
    SDLK_VOLUMEUP = (SDL_SCANCODE_VOLUMEUP | (1<<30)),
    SDLK_VOLUMEDOWN = (SDL_SCANCODE_VOLUMEDOWN | (1<<30)),
    SDLK_KP_COMMA = (SDL_SCANCODE_KP_COMMA | (1<<30)),
    SDLK_KP_EQUALSAS400 =
        (SDL_SCANCODE_KP_EQUALSAS400 | (1<<30)),
    SDLK_ALTERASE = (SDL_SCANCODE_ALTERASE | (1<<30)),
    SDLK_SYSREQ = (SDL_SCANCODE_SYSREQ | (1<<30)),
    SDLK_CANCEL = (SDL_SCANCODE_CANCEL | (1<<30)),
    SDLK_CLEAR = (SDL_SCANCODE_CLEAR | (1<<30)),
    SDLK_PRIOR = (SDL_SCANCODE_PRIOR | (1<<30)),
    SDLK_RETURN2 = (SDL_SCANCODE_RETURN2 | (1<<30)),
    SDLK_SEPARATOR = (SDL_SCANCODE_SEPARATOR | (1<<30)),
    SDLK_OUT = (SDL_SCANCODE_OUT | (1<<30)),
    SDLK_OPER = (SDL_SCANCODE_OPER | (1<<30)),
    SDLK_CLEARAGAIN = (SDL_SCANCODE_CLEARAGAIN | (1<<30)),
    SDLK_CRSEL = (SDL_SCANCODE_CRSEL | (1<<30)),
    SDLK_EXSEL = (SDL_SCANCODE_EXSEL | (1<<30)),
    SDLK_KP_00 = (SDL_SCANCODE_KP_00 | (1<<30)),
    SDLK_KP_000 = (SDL_SCANCODE_KP_000 | (1<<30)),
    SDLK_THOUSANDSSEPARATOR =
        (SDL_SCANCODE_THOUSANDSSEPARATOR | (1<<30)),
    SDLK_DECIMALSEPARATOR =
        (SDL_SCANCODE_DECIMALSEPARATOR | (1<<30)),
    SDLK_CURRENCYUNIT = (SDL_SCANCODE_CURRENCYUNIT | (1<<30)),
    SDLK_CURRENCYSUBUNIT =
        (SDL_SCANCODE_CURRENCYSUBUNIT | (1<<30)),
    SDLK_KP_LEFTPAREN = (SDL_SCANCODE_KP_LEFTPAREN | (1<<30)),
    SDLK_KP_RIGHTPAREN = (SDL_SCANCODE_KP_RIGHTPAREN | (1<<30)),
    SDLK_KP_LEFTBRACE = (SDL_SCANCODE_KP_LEFTBRACE | (1<<30)),
    SDLK_KP_RIGHTBRACE = (SDL_SCANCODE_KP_RIGHTBRACE | (1<<30)),
    SDLK_KP_TAB = (SDL_SCANCODE_KP_TAB | (1<<30)),
    SDLK_KP_BACKSPACE = (SDL_SCANCODE_KP_BACKSPACE | (1<<30)),
    SDLK_KP_A = (SDL_SCANCODE_KP_A | (1<<30)),
    SDLK_KP_B = (SDL_SCANCODE_KP_B | (1<<30)),
    SDLK_KP_C = (SDL_SCANCODE_KP_C | (1<<30)),
    SDLK_KP_D = (SDL_SCANCODE_KP_D | (1<<30)),
    SDLK_KP_E = (SDL_SCANCODE_KP_E | (1<<30)),
    SDLK_KP_F = (SDL_SCANCODE_KP_F | (1<<30)),
    SDLK_KP_XOR = (SDL_SCANCODE_KP_XOR | (1<<30)),
    SDLK_KP_POWER = (SDL_SCANCODE_KP_POWER | (1<<30)),
    SDLK_KP_PERCENT = (SDL_SCANCODE_KP_PERCENT | (1<<30)),
    SDLK_KP_LESS = (SDL_SCANCODE_KP_LESS | (1<<30)),
    SDLK_KP_GREATER = (SDL_SCANCODE_KP_GREATER | (1<<30)),
    SDLK_KP_AMPERSAND = (SDL_SCANCODE_KP_AMPERSAND | (1<<30)),
    SDLK_KP_DBLAMPERSAND =
        (SDL_SCANCODE_KP_DBLAMPERSAND | (1<<30)),
    SDLK_KP_VERTICALBAR =
        (SDL_SCANCODE_KP_VERTICALBAR | (1<<30)),
    SDLK_KP_DBLVERTICALBAR =
        (SDL_SCANCODE_KP_DBLVERTICALBAR | (1<<30)),
    SDLK_KP_COLON = (SDL_SCANCODE_KP_COLON | (1<<30)),
    SDLK_KP_HASH = (SDL_SCANCODE_KP_HASH | (1<<30)),
    SDLK_KP_SPACE = (SDL_SCANCODE_KP_SPACE | (1<<30)),
    SDLK_KP_AT = (SDL_SCANCODE_KP_AT | (1<<30)),
    SDLK_KP_EXCLAM = (SDL_SCANCODE_KP_EXCLAM | (1<<30)),
    SDLK_KP_MEMSTORE = (SDL_SCANCODE_KP_MEMSTORE | (1<<30)),
    SDLK_KP_MEMRECALL = (SDL_SCANCODE_KP_MEMRECALL | (1<<30)),
    SDLK_KP_MEMCLEAR = (SDL_SCANCODE_KP_MEMCLEAR | (1<<30)),
    SDLK_KP_MEMADD = (SDL_SCANCODE_KP_MEMADD | (1<<30)),
    SDLK_KP_MEMSUBTRACT =
        (SDL_SCANCODE_KP_MEMSUBTRACT | (1<<30)),
    SDLK_KP_MEMMULTIPLY =
        (SDL_SCANCODE_KP_MEMMULTIPLY | (1<<30)),
    SDLK_KP_MEMDIVIDE = (SDL_SCANCODE_KP_MEMDIVIDE | (1<<30)),
    SDLK_KP_PLUSMINUS = (SDL_SCANCODE_KP_PLUSMINUS | (1<<30)),
    SDLK_KP_CLEAR = (SDL_SCANCODE_KP_CLEAR | (1<<30)),
    SDLK_KP_CLEARENTRY = (SDL_SCANCODE_KP_CLEARENTRY | (1<<30)),
    SDLK_KP_BINARY = (SDL_SCANCODE_KP_BINARY | (1<<30)),
    SDLK_KP_OCTAL = (SDL_SCANCODE_KP_OCTAL | (1<<30)),
    SDLK_KP_DECIMAL = (SDL_SCANCODE_KP_DECIMAL | (1<<30)),
    SDLK_KP_HEXADECIMAL =
        (SDL_SCANCODE_KP_HEXADECIMAL | (1<<30)),
    SDLK_LCTRL = (SDL_SCANCODE_LCTRL | (1<<30)),
    SDLK_LSHIFT = (SDL_SCANCODE_LSHIFT | (1<<30)),
    SDLK_LALT = (SDL_SCANCODE_LALT | (1<<30)),
    SDLK_LGUI = (SDL_SCANCODE_LGUI | (1<<30)),
    SDLK_RCTRL = (SDL_SCANCODE_RCTRL | (1<<30)),
    SDLK_RSHIFT = (SDL_SCANCODE_RSHIFT | (1<<30)),
    SDLK_RALT = (SDL_SCANCODE_RALT | (1<<30)),
    SDLK_RGUI = (SDL_SCANCODE_RGUI | (1<<30)),
    SDLK_MODE = (SDL_SCANCODE_MODE | (1<<30)),
    SDLK_AUDIONEXT = (SDL_SCANCODE_AUDIONEXT | (1<<30)),
    SDLK_AUDIOPREV = (SDL_SCANCODE_AUDIOPREV | (1<<30)),
    SDLK_AUDIOSTOP = (SDL_SCANCODE_AUDIOSTOP | (1<<30)),
    SDLK_AUDIOPLAY = (SDL_SCANCODE_AUDIOPLAY | (1<<30)),
    SDLK_AUDIOMUTE = (SDL_SCANCODE_AUDIOMUTE | (1<<30)),
    SDLK_MEDIASELECT = (SDL_SCANCODE_MEDIASELECT | (1<<30)),
    SDLK_WWW = (SDL_SCANCODE_WWW | (1<<30)),
    SDLK_MAIL = (SDL_SCANCODE_MAIL | (1<<30)),
    SDLK_CALCULATOR = (SDL_SCANCODE_CALCULATOR | (1<<30)),
    SDLK_COMPUTER = (SDL_SCANCODE_COMPUTER | (1<<30)),
    SDLK_AC_SEARCH = (SDL_SCANCODE_AC_SEARCH | (1<<30)),
    SDLK_AC_HOME = (SDL_SCANCODE_AC_HOME | (1<<30)),
    SDLK_AC_BACK = (SDL_SCANCODE_AC_BACK | (1<<30)),
    SDLK_AC_FORWARD = (SDL_SCANCODE_AC_FORWARD | (1<<30)),
    SDLK_AC_STOP = (SDL_SCANCODE_AC_STOP | (1<<30)),
    SDLK_AC_REFRESH = (SDL_SCANCODE_AC_REFRESH | (1<<30)),
    SDLK_AC_BOOKMARKS = (SDL_SCANCODE_AC_BOOKMARKS | (1<<30)),
    SDLK_BRIGHTNESSDOWN =
        (SDL_SCANCODE_BRIGHTNESSDOWN | (1<<30)),
    SDLK_BRIGHTNESSUP = (SDL_SCANCODE_BRIGHTNESSUP | (1<<30)),
    SDLK_DISPLAYSWITCH = (SDL_SCANCODE_DISPLAYSWITCH | (1<<30)),
    SDLK_KBDILLUMTOGGLE =
        (SDL_SCANCODE_KBDILLUMTOGGLE | (1<<30)),
    SDLK_KBDILLUMDOWN = (SDL_SCANCODE_KBDILLUMDOWN | (1<<30)),
    SDLK_KBDILLUMUP = (SDL_SCANCODE_KBDILLUMUP | (1<<30)),
    SDLK_EJECT = (SDL_SCANCODE_EJECT | (1<<30)),
    SDLK_SLEEP = (SDL_SCANCODE_SLEEP | (1<<30))
};
typedef enum
{
    KMOD_NONE = 0x0000,
    KMOD_LSHIFT = 0x0001,
    KMOD_RSHIFT = 0x0002,
    KMOD_LCTRL = 0x0040,
    KMOD_RCTRL = 0x0080,
    KMOD_LALT = 0x0100,
    KMOD_RALT = 0x0200,
    KMOD_LGUI = 0x0400,
    KMOD_RGUI = 0x0800,
    KMOD_NUM = 0x1000,
    KMOD_CAPS = 0x2000,
    KMOD_MODE = 0x4000,
    KMOD_RESERVED = 0x8000
} SDL_Keymod;
typedef struct SDL_Keysym
{
    SDL_Scancode scancode;
    SDL_Keycode sym;
    Uint16 mod;
    Uint32 unused;
} SDL_Keysym;
SDL_Window * SDL_GetKeyboardFocus(void);
const Uint8 * SDL_GetKeyboardState(int *numkeys);
SDL_Keymod SDL_GetModState(void);
void SDL_SetModState(SDL_Keymod modstate);
SDL_Keycode SDL_GetKeyFromScancode(SDL_Scancode scancode);
SDL_Scancode SDL_GetScancodeFromKey(SDL_Keycode key);
const char * SDL_GetScancodeName(SDL_Scancode scancode);
SDL_Scancode SDL_GetScancodeFromName(const char *name);
const char * SDL_GetKeyName(SDL_Keycode key);
SDL_Keycode SDL_GetKeyFromName(const char *name);
void SDL_StartTextInput(void);
SDL_bool SDL_IsTextInputActive(void);
void SDL_StopTextInput(void);
void SDL_SetTextInputRect(SDL_Rect *rect);
SDL_bool SDL_HasScreenKeyboardSupport(void);
SDL_bool SDL_IsScreenKeyboardShown(SDL_Window *window);
typedef struct SDL_Cursor SDL_Cursor;
typedef enum
{
    SDL_SYSTEM_CURSOR_ARROW,
    SDL_SYSTEM_CURSOR_IBEAM,
    SDL_SYSTEM_CURSOR_WAIT,
    SDL_SYSTEM_CURSOR_CROSSHAIR,
    SDL_SYSTEM_CURSOR_WAITARROW,
    SDL_SYSTEM_CURSOR_SIZENWSE,
    SDL_SYSTEM_CURSOR_SIZENESW,
    SDL_SYSTEM_CURSOR_SIZEWE,
    SDL_SYSTEM_CURSOR_SIZENS,
    SDL_SYSTEM_CURSOR_SIZEALL,
    SDL_SYSTEM_CURSOR_NO,
    SDL_SYSTEM_CURSOR_HAND,
    SDL_NUM_SYSTEM_CURSORS
} SDL_SystemCursor;
typedef enum
{
    SDL_MOUSEWHEEL_NORMAL,
    SDL_MOUSEWHEEL_FLIPPED
} SDL_MouseWheelDirection;
SDL_Window * SDL_GetMouseFocus(void);
Uint32 SDL_GetMouseState(int *x, int *y);
Uint32 SDL_GetGlobalMouseState(int *x, int *y);
Uint32 SDL_GetRelativeMouseState(int *x, int *y);
void SDL_WarpMouseInWindow(SDL_Window * window,
                                                   int x, int y);
int SDL_WarpMouseGlobal(int x, int y);
int SDL_SetRelativeMouseMode(SDL_bool enabled);
int SDL_CaptureMouse(SDL_bool enabled);
SDL_bool SDL_GetRelativeMouseMode(void);
SDL_Cursor * SDL_CreateCursor(const Uint8 * data,
                                                     const Uint8 * mask,
                                                     int w, int h, int hot_x,
                                                     int hot_y);
SDL_Cursor * SDL_CreateColorCursor(SDL_Surface *surface,
                                                          int hot_x,
                                                          int hot_y);
SDL_Cursor * SDL_CreateSystemCursor(SDL_SystemCursor id);
void SDL_SetCursor(SDL_Cursor * cursor);
SDL_Cursor * SDL_GetCursor(void);
SDL_Cursor * SDL_GetDefaultCursor(void);
void SDL_FreeCursor(SDL_Cursor * cursor);
int SDL_ShowCursor(int toggle);
struct _SDL_Joystick;
typedef struct _SDL_Joystick SDL_Joystick;
typedef struct {
    Uint8 data[16];
} SDL_JoystickGUID;
typedef Sint32 SDL_JoystickID;
typedef enum
{
    SDL_JOYSTICK_POWER_UNKNOWN = -1,
    SDL_JOYSTICK_POWER_EMPTY,
    SDL_JOYSTICK_POWER_LOW,
    SDL_JOYSTICK_POWER_MEDIUM,
    SDL_JOYSTICK_POWER_FULL,
    SDL_JOYSTICK_POWER_WIRED,
    SDL_JOYSTICK_POWER_MAX
} SDL_JoystickPowerLevel;
int SDL_NumJoysticks(void);
const char * SDL_JoystickNameForIndex(int device_index);
SDL_Joystick * SDL_JoystickOpen(int device_index);
SDL_Joystick * SDL_JoystickFromInstanceID(SDL_JoystickID joyid);
const char * SDL_JoystickName(SDL_Joystick * joystick);
SDL_JoystickGUID SDL_JoystickGetDeviceGUID(int device_index);
SDL_JoystickGUID SDL_JoystickGetGUID(SDL_Joystick * joystick);
void SDL_JoystickGetGUIDString(SDL_JoystickGUID guid, char *pszGUID, int cbGUID);
SDL_JoystickGUID SDL_JoystickGetGUIDFromString(const char *pchGUID);
SDL_bool SDL_JoystickGetAttached(SDL_Joystick * joystick);
SDL_JoystickID SDL_JoystickInstanceID(SDL_Joystick * joystick);
int SDL_JoystickNumAxes(SDL_Joystick * joystick);
int SDL_JoystickNumBalls(SDL_Joystick * joystick);
int SDL_JoystickNumHats(SDL_Joystick * joystick);
int SDL_JoystickNumButtons(SDL_Joystick * joystick);
void SDL_JoystickUpdate(void);
int SDL_JoystickEventState(int state);
Sint16 SDL_JoystickGetAxis(SDL_Joystick * joystick,
                                                   int axis);
Uint8 SDL_JoystickGetHat(SDL_Joystick * joystick,
                                                 int hat);
int SDL_JoystickGetBall(SDL_Joystick * joystick,
                                                int ball, int *dx, int *dy);
Uint8 SDL_JoystickGetButton(SDL_Joystick * joystick,
                                                    int button);
void SDL_JoystickClose(SDL_Joystick * joystick);
SDL_JoystickPowerLevel SDL_JoystickCurrentPowerLevel(SDL_Joystick * joystick);
struct _SDL_GameController;
typedef struct _SDL_GameController SDL_GameController;
typedef enum
{
    SDL_CONTROLLER_BINDTYPE_NONE = 0,
    SDL_CONTROLLER_BINDTYPE_BUTTON,
    SDL_CONTROLLER_BINDTYPE_AXIS,
    SDL_CONTROLLER_BINDTYPE_HAT
} SDL_GameControllerBindType;
typedef struct SDL_GameControllerButtonBind
{
    SDL_GameControllerBindType bindType;
    union
    {
        int button;
        int axis;
        struct {
            int hat;
            int hat_mask;
        } hat;
    } value;
} SDL_GameControllerButtonBind;
int SDL_GameControllerAddMappingsFromRW( SDL_RWops * rw, int freerw );
int SDL_GameControllerAddMapping( const char* mappingString );
char * SDL_GameControllerMappingForGUID( SDL_JoystickGUID guid );
char * SDL_GameControllerMapping( SDL_GameController * gamecontroller );
SDL_bool SDL_IsGameController(int joystick_index);
const char * SDL_GameControllerNameForIndex(int joystick_index);
SDL_GameController * SDL_GameControllerOpen(int joystick_index);
SDL_GameController * SDL_GameControllerFromInstanceID(SDL_JoystickID joyid);
const char * SDL_GameControllerName(SDL_GameController *gamecontroller);
SDL_bool SDL_GameControllerGetAttached(SDL_GameController *gamecontroller);
SDL_Joystick * SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller);
int SDL_GameControllerEventState(int state);
void SDL_GameControllerUpdate(void);
typedef enum
{
    SDL_CONTROLLER_AXIS_INVALID = -1,
    SDL_CONTROLLER_AXIS_LEFTX,
    SDL_CONTROLLER_AXIS_LEFTY,
    SDL_CONTROLLER_AXIS_RIGHTX,
    SDL_CONTROLLER_AXIS_RIGHTY,
    SDL_CONTROLLER_AXIS_TRIGGERLEFT,
    SDL_CONTROLLER_AXIS_TRIGGERRIGHT,
    SDL_CONTROLLER_AXIS_MAX
} SDL_GameControllerAxis;
SDL_GameControllerAxis SDL_GameControllerGetAxisFromString(const char *pchString);
const char* SDL_GameControllerGetStringForAxis(SDL_GameControllerAxis axis);
SDL_GameControllerButtonBind
SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,
                                 SDL_GameControllerAxis axis);
Sint16
SDL_GameControllerGetAxis(SDL_GameController *gamecontroller,
                          SDL_GameControllerAxis axis);
typedef enum
{
    SDL_CONTROLLER_BUTTON_INVALID = -1,
    SDL_CONTROLLER_BUTTON_A,
    SDL_CONTROLLER_BUTTON_B,
    SDL_CONTROLLER_BUTTON_X,
    SDL_CONTROLLER_BUTTON_Y,
    SDL_CONTROLLER_BUTTON_BACK,
    SDL_CONTROLLER_BUTTON_GUIDE,
    SDL_CONTROLLER_BUTTON_START,
    SDL_CONTROLLER_BUTTON_LEFTSTICK,
    SDL_CONTROLLER_BUTTON_RIGHTSTICK,
    SDL_CONTROLLER_BUTTON_LEFTSHOULDER,
    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER,
    SDL_CONTROLLER_BUTTON_DPAD_UP,
    SDL_CONTROLLER_BUTTON_DPAD_DOWN,
    SDL_CONTROLLER_BUTTON_DPAD_LEFT,
    SDL_CONTROLLER_BUTTON_DPAD_RIGHT,
    SDL_CONTROLLER_BUTTON_MAX
} SDL_GameControllerButton;
SDL_GameControllerButton SDL_GameControllerGetButtonFromString(const char *pchString);
const char* SDL_GameControllerGetStringForButton(SDL_GameControllerButton button);
SDL_GameControllerButtonBind
SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,
                                   SDL_GameControllerButton button);
Uint8 SDL_GameControllerGetButton(SDL_GameController *gamecontroller,
                                                          SDL_GameControllerButton button);
void SDL_GameControllerClose(SDL_GameController *gamecontroller);
typedef Sint64 SDL_TouchID;
typedef Sint64 SDL_FingerID;
typedef struct SDL_Finger
{
    SDL_FingerID id;
    float x;
    float y;
    float pressure;
} SDL_Finger;
int SDL_GetNumTouchDevices(void);
SDL_TouchID SDL_GetTouchDevice(int index);
int SDL_GetNumTouchFingers(SDL_TouchID touchID);
SDL_Finger * SDL_GetTouchFinger(SDL_TouchID touchID, int index);
typedef Sint64 SDL_GestureID;
int SDL_RecordGesture(SDL_TouchID touchId);
int SDL_SaveAllDollarTemplates(SDL_RWops *dst);
int SDL_SaveDollarTemplate(SDL_GestureID gestureId,SDL_RWops *dst);
int SDL_LoadDollarTemplates(SDL_TouchID touchId, SDL_RWops *src);
typedef enum
{
    SDL_FIRSTEVENT = 0,
    SDL_QUIT = 0x100,
    SDL_APP_TERMINATING,
    SDL_APP_LOWMEMORY,
    SDL_APP_WILLENTERBACKGROUND,
    SDL_APP_DIDENTERBACKGROUND,
    SDL_APP_WILLENTERFOREGROUND,
    SDL_APP_DIDENTERFOREGROUND,
    SDL_WINDOWEVENT = 0x200,
    SDL_SYSWMEVENT,
    SDL_KEYDOWN = 0x300,
    SDL_KEYUP,
    SDL_TEXTEDITING,
    SDL_TEXTINPUT,
    SDL_KEYMAPCHANGED,
    SDL_MOUSEMOTION = 0x400,
    SDL_MOUSEBUTTONDOWN,
    SDL_MOUSEBUTTONUP,
    SDL_MOUSEWHEEL,
    SDL_JOYAXISMOTION = 0x600,
    SDL_JOYBALLMOTION,
    SDL_JOYHATMOTION,
    SDL_JOYBUTTONDOWN,
    SDL_JOYBUTTONUP,
    SDL_JOYDEVICEADDED,
    SDL_JOYDEVICEREMOVED,
    SDL_CONTROLLERAXISMOTION = 0x650,
    SDL_CONTROLLERBUTTONDOWN,
    SDL_CONTROLLERBUTTONUP,
    SDL_CONTROLLERDEVICEADDED,
    SDL_CONTROLLERDEVICEREMOVED,
    SDL_CONTROLLERDEVICEREMAPPED,
    SDL_FINGERDOWN = 0x700,
    SDL_FINGERUP,
    SDL_FINGERMOTION,
    SDL_DOLLARGESTURE = 0x800,
    SDL_DOLLARRECORD,
    SDL_MULTIGESTURE,
    SDL_CLIPBOARDUPDATE = 0x900,
    SDL_DROPFILE = 0x1000,
    SDL_DROPTEXT,
    SDL_DROPBEGIN,
    SDL_DROPCOMPLETE,
    SDL_AUDIODEVICEADDED = 0x1100,
    SDL_AUDIODEVICEREMOVED,
    SDL_RENDER_TARGETS_RESET = 0x2000,
    SDL_RENDER_DEVICE_RESET,
    SDL_USEREVENT = 0x8000,
    SDL_LASTEVENT = 0xFFFF
} SDL_EventType;
typedef struct SDL_CommonEvent
{
    Uint32 type;
    Uint32 timestamp;
} SDL_CommonEvent;
typedef struct SDL_WindowEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint8 event;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint32 data1;
    Sint32 data2;
} SDL_WindowEvent;
typedef struct SDL_KeyboardEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint8 state;
    Uint8 repeat;
    Uint8 padding2;
    Uint8 padding3;
    SDL_Keysym keysym;
} SDL_KeyboardEvent;
typedef struct SDL_TextEditingEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    char text[(32)];
    Sint32 start;
    Sint32 length;
} SDL_TextEditingEvent;
typedef struct SDL_TextInputEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    char text[(32)];
} SDL_TextInputEvent;
typedef struct SDL_MouseMotionEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint32 which;
    Uint32 state;
    Sint32 x;
    Sint32 y;
    Sint32 xrel;
    Sint32 yrel;
} SDL_MouseMotionEvent;
typedef struct SDL_MouseButtonEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint32 which;
    Uint8 button;
    Uint8 state;
    Uint8 clicks;
    Uint8 padding1;
    Sint32 x;
    Sint32 y;
} SDL_MouseButtonEvent;
typedef struct SDL_MouseWheelEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint32 which;
    Sint32 x;
    Sint32 y;
    Uint32 direction;
} SDL_MouseWheelEvent;
typedef struct SDL_JoyAxisEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 axis;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint16 value;
    Uint16 padding4;
} SDL_JoyAxisEvent;
typedef struct SDL_JoyBallEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 ball;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint16 xrel;
    Sint16 yrel;
} SDL_JoyBallEvent;
typedef struct SDL_JoyHatEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 hat;
    Uint8 value;
    Uint8 padding1;
    Uint8 padding2;
} SDL_JoyHatEvent;
typedef struct SDL_JoyButtonEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 button;
    Uint8 state;
    Uint8 padding1;
    Uint8 padding2;
} SDL_JoyButtonEvent;
typedef struct SDL_JoyDeviceEvent
{
    Uint32 type;
    Uint32 timestamp;
    Sint32 which;
} SDL_JoyDeviceEvent;
typedef struct SDL_ControllerAxisEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 axis;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint16 value;
    Uint16 padding4;
} SDL_ControllerAxisEvent;
typedef struct SDL_ControllerButtonEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 button;
    Uint8 state;
    Uint8 padding1;
    Uint8 padding2;
} SDL_ControllerButtonEvent;
typedef struct SDL_ControllerDeviceEvent
{
    Uint32 type;
    Uint32 timestamp;
    Sint32 which;
} SDL_ControllerDeviceEvent;
typedef struct SDL_AudioDeviceEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 which;
    Uint8 iscapture;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
} SDL_AudioDeviceEvent;
typedef struct SDL_TouchFingerEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_TouchID touchId;
    SDL_FingerID fingerId;
    float x;
    float y;
    float dx;
    float dy;
    float pressure;
} SDL_TouchFingerEvent;
typedef struct SDL_MultiGestureEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_TouchID touchId;
    float dTheta;
    float dDist;
    float x;
    float y;
    Uint16 numFingers;
    Uint16 padding;
} SDL_MultiGestureEvent;
typedef struct SDL_DollarGestureEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_TouchID touchId;
    SDL_GestureID gestureId;
    Uint32 numFingers;
    float error;
    float x;
    float y;
} SDL_DollarGestureEvent;
typedef struct SDL_DropEvent
{
    Uint32 type;
    Uint32 timestamp;
    char *file;
    Uint32 windowID;
} SDL_DropEvent;
typedef struct SDL_QuitEvent
{
    Uint32 type;
    Uint32 timestamp;
} SDL_QuitEvent;
typedef struct SDL_OSEvent
{
    Uint32 type;
    Uint32 timestamp;
} SDL_OSEvent;
typedef struct SDL_UserEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Sint32 code;
    void *data1;
    void *data2;
} SDL_UserEvent;
struct SDL_SysWMmsg;
typedef struct SDL_SysWMmsg SDL_SysWMmsg;
typedef struct SDL_SysWMEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_SysWMmsg *msg;
} SDL_SysWMEvent;
typedef union SDL_Event
{
    Uint32 type;
    SDL_CommonEvent common;
    SDL_WindowEvent window;
    SDL_KeyboardEvent key;
    SDL_TextEditingEvent edit;
    SDL_TextInputEvent text;
    SDL_MouseMotionEvent motion;
    SDL_MouseButtonEvent button;
    SDL_MouseWheelEvent wheel;
    SDL_JoyAxisEvent jaxis;
    SDL_JoyBallEvent jball;
    SDL_JoyHatEvent jhat;
    SDL_JoyButtonEvent jbutton;
    SDL_JoyDeviceEvent jdevice;
    SDL_ControllerAxisEvent caxis;
    SDL_ControllerButtonEvent cbutton;
    SDL_ControllerDeviceEvent cdevice;
    SDL_AudioDeviceEvent adevice;
    SDL_QuitEvent quit;
    SDL_UserEvent user;
    SDL_SysWMEvent syswm;
    SDL_TouchFingerEvent tfinger;
    SDL_MultiGestureEvent mgesture;
    SDL_DollarGestureEvent dgesture;
    SDL_DropEvent drop;
    Uint8 padding[56];
} SDL_Event;
void SDL_PumpEvents(void);
typedef enum
{
    SDL_ADDEVENT,
    SDL_PEEKEVENT,
    SDL_GETEVENT
} SDL_eventaction;
int SDL_PeepEvents(SDL_Event * events, int numevents,
                                           SDL_eventaction action,
                                           Uint32 minType, Uint32 maxType);
SDL_bool SDL_HasEvent(Uint32 type);
SDL_bool SDL_HasEvents(Uint32 minType, Uint32 maxType);
void SDL_FlushEvent(Uint32 type);
void SDL_FlushEvents(Uint32 minType, Uint32 maxType);
int SDL_PollEvent(SDL_Event * event);
int SDL_WaitEvent(SDL_Event * event);
int SDL_WaitEventTimeout(SDL_Event * event,
                                                 int timeout);
int SDL_PushEvent(SDL_Event * event);
typedef int ( * SDL_EventFilter) (void *userdata, SDL_Event * event);
void SDL_SetEventFilter(SDL_EventFilter filter,
                                                void *userdata);
SDL_bool SDL_GetEventFilter(SDL_EventFilter * filter,
                                                    void **userdata);
void SDL_AddEventWatch(SDL_EventFilter filter,
                                               void *userdata);
void SDL_DelEventWatch(SDL_EventFilter filter,
                                               void *userdata);
void SDL_FilterEvents(SDL_EventFilter filter,
                                              void *userdata);
Uint8 SDL_EventState(Uint32 type, int state);
Uint32 SDL_RegisterEvents(int numevents);
char * SDL_GetBasePath(void);
char * SDL_GetPrefPath(const char *org, const char *app);
struct _SDL_Haptic;
typedef struct _SDL_Haptic SDL_Haptic;
typedef struct SDL_HapticDirection
{
    Uint8 type;
    Sint32 dir[3];
} SDL_HapticDirection;
typedef struct SDL_HapticConstant
{
    Uint16 type;
    SDL_HapticDirection direction;
    Uint32 length;
    Uint16 delay;
    Uint16 button;
    Uint16 interval;
    Sint16 level;
    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticConstant;
typedef struct SDL_HapticPeriodic
{
    Uint16 type;
    SDL_HapticDirection direction;
    Uint32 length;
    Uint16 delay;
    Uint16 button;
    Uint16 interval;
    Uint16 period;
    Sint16 magnitude;
    Sint16 offset;
    Uint16 phase;
    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticPeriodic;
typedef struct SDL_HapticCondition
{
    Uint16 type;
    SDL_HapticDirection direction;
    Uint32 length;
    Uint16 delay;
    Uint16 button;
    Uint16 interval;
    Uint16 right_sat[3];
    Uint16 left_sat[3];
    Sint16 right_coeff[3];
    Sint16 left_coeff[3];
    Uint16 deadband[3];
    Sint16 center[3];
} SDL_HapticCondition;
typedef struct SDL_HapticRamp
{
    Uint16 type;
    SDL_HapticDirection direction;
    Uint32 length;
    Uint16 delay;
    Uint16 button;
    Uint16 interval;
    Sint16 start;
    Sint16 end;
    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticRamp;
typedef struct SDL_HapticLeftRight
{
    Uint16 type;
    Uint32 length;
    Uint16 large_magnitude;
    Uint16 small_magnitude;
} SDL_HapticLeftRight;
typedef struct SDL_HapticCustom
{
    Uint16 type;
    SDL_HapticDirection direction;
    Uint32 length;
    Uint16 delay;
    Uint16 button;
    Uint16 interval;
    Uint8 channels;
    Uint16 period;
    Uint16 samples;
    Uint16 *data;
    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticCustom;
typedef union SDL_HapticEffect
{
    Uint16 type;
    SDL_HapticConstant constant;
    SDL_HapticPeriodic periodic;
    SDL_HapticCondition condition;
    SDL_HapticRamp ramp;
    SDL_HapticLeftRight leftright;
    SDL_HapticCustom custom;
} SDL_HapticEffect;
int SDL_NumHaptics(void);
const char * SDL_HapticName(int device_index);
SDL_Haptic * SDL_HapticOpen(int device_index);
int SDL_HapticOpened(int device_index);
int SDL_HapticIndex(SDL_Haptic * haptic);
int SDL_MouseIsHaptic(void);
SDL_Haptic * SDL_HapticOpenFromMouse(void);
int SDL_JoystickIsHaptic(SDL_Joystick * joystick);
SDL_Haptic * SDL_HapticOpenFromJoystick(SDL_Joystick *
                                                               joystick);
void SDL_HapticClose(SDL_Haptic * haptic);
int SDL_HapticNumEffects(SDL_Haptic * haptic);
int SDL_HapticNumEffectsPlaying(SDL_Haptic * haptic);
unsigned int SDL_HapticQuery(SDL_Haptic * haptic);
int SDL_HapticNumAxes(SDL_Haptic * haptic);
int SDL_HapticEffectSupported(SDL_Haptic * haptic,
                                                      SDL_HapticEffect *
                                                      effect);
int SDL_HapticNewEffect(SDL_Haptic * haptic,
                                                SDL_HapticEffect * effect);
int SDL_HapticUpdateEffect(SDL_Haptic * haptic,
                                                   int effect,
                                                   SDL_HapticEffect * data);
int SDL_HapticRunEffect(SDL_Haptic * haptic,
                                                int effect,
                                                Uint32 iterations);
int SDL_HapticStopEffect(SDL_Haptic * haptic,
                                                 int effect);
void SDL_HapticDestroyEffect(SDL_Haptic * haptic,
                                                     int effect);
int SDL_HapticGetEffectStatus(SDL_Haptic * haptic,
                                                      int effect);
int SDL_HapticSetGain(SDL_Haptic * haptic, int gain);
int SDL_HapticSetAutocenter(SDL_Haptic * haptic,
                                                    int autocenter);
int SDL_HapticPause(SDL_Haptic * haptic);
int SDL_HapticUnpause(SDL_Haptic * haptic);
int SDL_HapticStopAll(SDL_Haptic * haptic);
int SDL_HapticRumbleSupported(SDL_Haptic * haptic);
int SDL_HapticRumbleInit(SDL_Haptic * haptic);
int SDL_HapticRumblePlay(SDL_Haptic * haptic, float strength, Uint32 length );
int SDL_HapticRumbleStop(SDL_Haptic * haptic);
typedef enum
{
    SDL_HINT_DEFAULT,
    SDL_HINT_NORMAL,
    SDL_HINT_OVERRIDE
} SDL_HintPriority;
SDL_bool SDL_SetHintWithPriority(const char *name,
                                                         const char *value,
                                                         SDL_HintPriority priority);
SDL_bool SDL_SetHint(const char *name,
                                             const char *value);
const char * SDL_GetHint(const char *name);
SDL_bool SDL_GetHintBoolean(const char *name, SDL_bool default_value);
typedef void (*SDL_HintCallback)(void *userdata, const char *name, const char *oldValue, const char *newValue);
void SDL_AddHintCallback(const char *name,
                                                 SDL_HintCallback callback,
                                                 void *userdata);
void SDL_DelHintCallback(const char *name,
                                                 SDL_HintCallback callback,
                                                 void *userdata);
void SDL_ClearHints(void);
void * SDL_LoadObject(const char *sofile);
void * SDL_LoadFunction(void *handle,
                                               const char *name);
void SDL_UnloadObject(void *handle);
enum
{
    SDL_LOG_CATEGORY_APPLICATION,
    SDL_LOG_CATEGORY_ERROR,
    SDL_LOG_CATEGORY_ASSERT,
    SDL_LOG_CATEGORY_SYSTEM,
    SDL_LOG_CATEGORY_AUDIO,
    SDL_LOG_CATEGORY_VIDEO,
    SDL_LOG_CATEGORY_RENDER,
    SDL_LOG_CATEGORY_INPUT,
    SDL_LOG_CATEGORY_TEST,
    SDL_LOG_CATEGORY_RESERVED1,
    SDL_LOG_CATEGORY_RESERVED2,
    SDL_LOG_CATEGORY_RESERVED3,
    SDL_LOG_CATEGORY_RESERVED4,
    SDL_LOG_CATEGORY_RESERVED5,
    SDL_LOG_CATEGORY_RESERVED6,
    SDL_LOG_CATEGORY_RESERVED7,
    SDL_LOG_CATEGORY_RESERVED8,
    SDL_LOG_CATEGORY_RESERVED9,
    SDL_LOG_CATEGORY_RESERVED10,
    SDL_LOG_CATEGORY_CUSTOM
};
typedef enum
{
    SDL_LOG_PRIORITY_VERBOSE = 1,
    SDL_LOG_PRIORITY_DEBUG,
    SDL_LOG_PRIORITY_INFO,
    SDL_LOG_PRIORITY_WARN,
    SDL_LOG_PRIORITY_ERROR,
    SDL_LOG_PRIORITY_CRITICAL,
    SDL_NUM_LOG_PRIORITIES
} SDL_LogPriority;
void SDL_LogSetAllPriority(SDL_LogPriority priority);
void SDL_LogSetPriority(int category,
                                                SDL_LogPriority priority);
SDL_LogPriority SDL_LogGetPriority(int category);
void SDL_LogResetPriorities(void);
void SDL_Log( const char *fmt, ...) __attribute__ (( format( __printf__, 1, 1 +1 )));
void SDL_LogVerbose(int category, const char *fmt, ...) __attribute__ (( format( __printf__, 2, 2 +1 )));
void SDL_LogDebug(int category, const char *fmt, ...) __attribute__ (( format( __printf__, 2, 2 +1 )));
void SDL_LogInfo(int category, const char *fmt, ...) __attribute__ (( format( __printf__, 2, 2 +1 )));
void SDL_LogWarn(int category, const char *fmt, ...) __attribute__ (( format( __printf__, 2, 2 +1 )));
void SDL_LogError(int category, const char *fmt, ...) __attribute__ (( format( __printf__, 2, 2 +1 )));
void SDL_LogCritical(int category, const char *fmt, ...) __attribute__ (( format( __printf__, 2, 2 +1 )));
void SDL_LogMessage(int category,
                                            SDL_LogPriority priority,
                                                                     const char *fmt, ...) __attribute__ (( format( __printf__, 3, 3 +1 )));
void SDL_LogMessageV(int category,
                                             SDL_LogPriority priority,
                                             const char *fmt, va_list ap);
typedef void (*SDL_LogOutputFunction)(void *userdata, int category, SDL_LogPriority priority, const char *message);
void SDL_LogGetOutputFunction(SDL_LogOutputFunction *callback, void **userdata);
void SDL_LogSetOutputFunction(SDL_LogOutputFunction callback, void *userdata);
typedef enum
{
    SDL_MESSAGEBOX_ERROR = 0x00000010,
    SDL_MESSAGEBOX_WARNING = 0x00000020,
    SDL_MESSAGEBOX_INFORMATION = 0x00000040
} SDL_MessageBoxFlags;
typedef enum
{
    SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001,
    SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002
} SDL_MessageBoxButtonFlags;
typedef struct
{
    Uint32 flags;
    int buttonid;
    const char * text;
} SDL_MessageBoxButtonData;
typedef struct
{
    Uint8 r, g, b;
} SDL_MessageBoxColor;
typedef enum
{
    SDL_MESSAGEBOX_COLOR_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_TEXT,
    SDL_MESSAGEBOX_COLOR_BUTTON_BORDER,
    SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED,
    SDL_MESSAGEBOX_COLOR_MAX
} SDL_MessageBoxColorType;
typedef struct
{
    SDL_MessageBoxColor colors[SDL_MESSAGEBOX_COLOR_MAX];
} SDL_MessageBoxColorScheme;
typedef struct
{
    Uint32 flags;
    SDL_Window *window;
    const char *title;
    const char *message;
    int numbuttons;
    const SDL_MessageBoxButtonData *buttons;
    const SDL_MessageBoxColorScheme *colorScheme;
} SDL_MessageBoxData;
int SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid);
int SDL_ShowSimpleMessageBox(Uint32 flags, const char *title, const char *message, SDL_Window *window);
typedef enum
{
    SDL_POWERSTATE_UNKNOWN,
    SDL_POWERSTATE_ON_BATTERY,
    SDL_POWERSTATE_NO_BATTERY,
    SDL_POWERSTATE_CHARGING,
    SDL_POWERSTATE_CHARGED
} SDL_PowerState;
SDL_PowerState SDL_GetPowerInfo(int *secs, int *pct);
typedef enum
{
    SDL_RENDERER_SOFTWARE = 0x00000001,
    SDL_RENDERER_ACCELERATED = 0x00000002,
    SDL_RENDERER_PRESENTVSYNC = 0x00000004,
    SDL_RENDERER_TARGETTEXTURE = 0x00000008
} SDL_RendererFlags;
typedef struct SDL_RendererInfo
{
    const char *name;
    Uint32 flags;
    Uint32 num_texture_formats;
    Uint32 texture_formats[16];
    int max_texture_width;
    int max_texture_height;
} SDL_RendererInfo;
typedef enum
{
    SDL_TEXTUREACCESS_STATIC,
    SDL_TEXTUREACCESS_STREAMING,
    SDL_TEXTUREACCESS_TARGET
} SDL_TextureAccess;
typedef enum
{
    SDL_TEXTUREMODULATE_NONE = 0x00000000,
    SDL_TEXTUREMODULATE_COLOR = 0x00000001,
    SDL_TEXTUREMODULATE_ALPHA = 0x00000002
} SDL_TextureModulate;
typedef enum
{
    SDL_FLIP_NONE = 0x00000000,
    SDL_FLIP_HORIZONTAL = 0x00000001,
    SDL_FLIP_VERTICAL = 0x00000002
} SDL_RendererFlip;
struct SDL_Renderer;
typedef struct SDL_Renderer SDL_Renderer;
struct SDL_Texture;
typedef struct SDL_Texture SDL_Texture;
int SDL_GetNumRenderDrivers(void);
int SDL_GetRenderDriverInfo(int index,
                                                    SDL_RendererInfo * info);
int SDL_CreateWindowAndRenderer(
                                int width, int height, Uint32 window_flags,
                                SDL_Window **window, SDL_Renderer **renderer);
SDL_Renderer * SDL_CreateRenderer(SDL_Window * window,
                                               int index, Uint32 flags);
SDL_Renderer * SDL_CreateSoftwareRenderer(SDL_Surface * surface);
SDL_Renderer * SDL_GetRenderer(SDL_Window * window);
int SDL_GetRendererInfo(SDL_Renderer * renderer,
                                                SDL_RendererInfo * info);
int SDL_GetRendererOutputSize(SDL_Renderer * renderer,
                                                      int *w, int *h);
SDL_Texture * SDL_CreateTexture(SDL_Renderer * renderer,
                                                        Uint32 format,
                                                        int access, int w,
                                                        int h);
SDL_Texture * SDL_CreateTextureFromSurface(SDL_Renderer * renderer, SDL_Surface * surface);
int SDL_QueryTexture(SDL_Texture * texture,
                                             Uint32 * format, int *access,
                                             int *w, int *h);
int SDL_SetTextureColorMod(SDL_Texture * texture,
                                                   Uint8 r, Uint8 g, Uint8 b);
int SDL_GetTextureColorMod(SDL_Texture * texture,
                                                   Uint8 * r, Uint8 * g,
                                                   Uint8 * b);
int SDL_SetTextureAlphaMod(SDL_Texture * texture,
                                                   Uint8 alpha);
int SDL_GetTextureAlphaMod(SDL_Texture * texture,
                                                   Uint8 * alpha);
int SDL_SetTextureBlendMode(SDL_Texture * texture,
                                                    SDL_BlendMode blendMode);
int SDL_GetTextureBlendMode(SDL_Texture * texture,
                                                    SDL_BlendMode *blendMode);
int SDL_UpdateTexture(SDL_Texture * texture,
                                              const SDL_Rect * rect,
                                              const void *pixels, int pitch);
int SDL_UpdateYUVTexture(SDL_Texture * texture,
                                                 const SDL_Rect * rect,
                                                 const Uint8 *Yplane, int Ypitch,
                                                 const Uint8 *Uplane, int Upitch,
                                                 const Uint8 *Vplane, int Vpitch);
int SDL_LockTexture(SDL_Texture * texture,
                                            const SDL_Rect * rect,
                                            void **pixels, int *pitch);
void SDL_UnlockTexture(SDL_Texture * texture);
SDL_bool SDL_RenderTargetSupported(SDL_Renderer *renderer);
int SDL_SetRenderTarget(SDL_Renderer *renderer,
                                                SDL_Texture *texture);
SDL_Texture * SDL_GetRenderTarget(SDL_Renderer *renderer);
int SDL_RenderSetLogicalSize(SDL_Renderer * renderer, int w, int h);
void SDL_RenderGetLogicalSize(SDL_Renderer * renderer, int *w, int *h);
int SDL_RenderSetIntegerScale(SDL_Renderer * renderer,
                                                      SDL_bool enable);
SDL_bool SDL_RenderGetIntegerScale(SDL_Renderer * renderer);
int SDL_RenderSetViewport(SDL_Renderer * renderer,
                                                  const SDL_Rect * rect);
void SDL_RenderGetViewport(SDL_Renderer * renderer,
                                                   SDL_Rect * rect);
int SDL_RenderSetClipRect(SDL_Renderer * renderer,
                                                  const SDL_Rect * rect);
void SDL_RenderGetClipRect(SDL_Renderer * renderer,
                                                   SDL_Rect * rect);
SDL_bool SDL_RenderIsClipEnabled(SDL_Renderer * renderer);
int SDL_RenderSetScale(SDL_Renderer * renderer,
                                               float scaleX, float scaleY);
void SDL_RenderGetScale(SDL_Renderer * renderer,
                                               float *scaleX, float *scaleY);
int SDL_SetRenderDrawColor(SDL_Renderer * renderer,
                                           Uint8 r, Uint8 g, Uint8 b,
                                           Uint8 a);
int SDL_GetRenderDrawColor(SDL_Renderer * renderer,
                                           Uint8 * r, Uint8 * g, Uint8 * b,
                                           Uint8 * a);
int SDL_SetRenderDrawBlendMode(SDL_Renderer * renderer,
                                                       SDL_BlendMode blendMode);
int SDL_GetRenderDrawBlendMode(SDL_Renderer * renderer,
                                                       SDL_BlendMode *blendMode);
int SDL_RenderClear(SDL_Renderer * renderer);
int SDL_RenderDrawPoint(SDL_Renderer * renderer,
                                                int x, int y);
int SDL_RenderDrawPoints(SDL_Renderer * renderer,
                                                 const SDL_Point * points,
                                                 int count);
int SDL_RenderDrawLine(SDL_Renderer * renderer,
                                               int x1, int y1, int x2, int y2);
int SDL_RenderDrawLines(SDL_Renderer * renderer,
                                                const SDL_Point * points,
                                                int count);
int SDL_RenderDrawRect(SDL_Renderer * renderer,
                                               const SDL_Rect * rect);
int SDL_RenderDrawRects(SDL_Renderer * renderer,
                                                const SDL_Rect * rects,
                                                int count);
int SDL_RenderFillRect(SDL_Renderer * renderer,
                                               const SDL_Rect * rect);
int SDL_RenderFillRects(SDL_Renderer * renderer,
                                                const SDL_Rect * rects,
                                                int count);
int SDL_RenderCopy(SDL_Renderer * renderer,
                                           SDL_Texture * texture,
                                           const SDL_Rect * srcrect,
                                           const SDL_Rect * dstrect);
int SDL_RenderCopyEx(SDL_Renderer * renderer,
                                           SDL_Texture * texture,
                                           const SDL_Rect * srcrect,
                                           const SDL_Rect * dstrect,
                                           const double angle,
                                           const SDL_Point *center,
                                           const SDL_RendererFlip flip);
int SDL_RenderReadPixels(SDL_Renderer * renderer,
                                                 const SDL_Rect * rect,
                                                 Uint32 format,
                                                 void *pixels, int pitch);
void SDL_RenderPresent(SDL_Renderer * renderer);
void SDL_DestroyTexture(SDL_Texture * texture);
void SDL_DestroyRenderer(SDL_Renderer * renderer);
int SDL_GL_BindTexture(SDL_Texture *texture, float *texw, float *texh);
int SDL_GL_UnbindTexture(SDL_Texture *texture);
Uint32 SDL_GetTicks(void);
Uint64 SDL_GetPerformanceCounter(void);
Uint64 SDL_GetPerformanceFrequency(void);
void SDL_Delay(Uint32 ms);
typedef Uint32 ( * SDL_TimerCallback) (Uint32 interval, void *param);
typedef int SDL_TimerID;
SDL_TimerID SDL_AddTimer(Uint32 interval,
                                                 SDL_TimerCallback callback,
                                                 void *param);
SDL_bool SDL_RemoveTimer(SDL_TimerID id);
typedef struct SDL_version
{
    Uint8 major;
    Uint8 minor;
    Uint8 patch;
} SDL_version;
void SDL_GetVersion(SDL_version * ver);
const char * SDL_GetRevision(void);
int SDL_GetRevisionNumber(void);
int SDL_Init(Uint32 flags);
int SDL_InitSubSystem(Uint32 flags);
void SDL_QuitSubSystem(Uint32 flags);
Uint32 SDL_WasInit(Uint32 flags);
void SDL_Quit(void);
enum {
    SDL_INIT_TIMER          = 0x00000001,
	SDL_INIT_AUDIO          = 0x00000010,
	SDL_INIT_VIDEO          = 0x00000020,
	SDL_INIT_JOYSTICK       = 0x00000200,
	SDL_INIT_HAPTIC         = 0x00001000,
	SDL_INIT_GAMECONTROLLER = 0x00002000,
	SDL_INIT_EVENTS         = 0x00004000,
	SDL_INIT_NOPARACHUTE    = 0x00100000,
    AUDIO_U8        = 0x0008,
	AUDIO_S8        = 0x8008,
	AUDIO_U16LSB    = 0x0010,
	AUDIO_S16LSB    = 0x8010,
	AUDIO_U16MSB    = 0x1010,
	AUDIO_S16MSB    = 0x9010,
	AUDIO_U16       = 0x0010,
	AUDIO_S16       = 0x8010,
	SDL_WINDOWPOS_UNDEFINED_MASK = 0x1FFF0000,
	SDL_WINDOWPOS_CENTERED_MASK = 0x2FFF0000
};


]])

sdl = ffi.load(lwlgl.libs.sdl[2])

SDL_WINDOWPOS_UNDEFINED_DISPLAY = function(x)
    return require("bit").bor(sdl.SDL_WINDOWPOS_UNDEFINED_MASK, x)
end

SDL_WINDOWPOS_ISUNDEFINED = function(x)
    return require("bit").band(x, 0xFFFF0000) == sdl.SDL_WINDOWPOS_UNDEFINED_MASK
end

SDL_WINDOWPOS_ISCENTERED = function(x)
    return require("bit").band(x, 0xFFFF0000) == sdl.SDL_WINDOWPOS_CENTERED_MASK
end

SDL_WINDOWPOS_CENTERED_DISPLAY = function(x)
	return require("bit").bor(sdl.SDL_WINDOWPOS_CENTERED_MASK, x)
end

SDL_WINDOWPOS_CENTERED = SDL_WINDOWPOS_CENTERED_DISPLAY(0)
SDL_WINDOWPOS_UNDEFINED = SDL_WINDOWPOS_UNDEFINED_DISPLAY(0)

SDL_INIT_EVERYTHING = bor(
                sdl.SDL_INIT_TIMER, sdl.SDL_INIT_AUDIO, sdl.SDL_INIT_VIDEO, sdl.SDL_INIT_EVENTS,
                sdl.SDL_INIT_JOYSTICK, sdl.SDL_INIT_HAPTIC, sdl.SDL_INIT_GAMECONTROLLER
            )
            
end

function load_sdl_sound()

ffi.cdef([[
typedef enum
{
    SOUND_SAMPLEFLAG_NONE = 0,


    SOUND_SAMPLEFLAG_CANSEEK = 1,


    SOUND_SAMPLEFLAG_EOF = 1 << 29,
    SOUND_SAMPLEFLAG_ERROR = 1 << 30,
    SOUND_SAMPLEFLAG_EAGAIN = 1 << 31
} Sound_SampleFlags;
typedef struct
{
    Uint16 format;
    Uint8 channels;
    Uint32 rate;
} Sound_AudioInfo;
typedef struct
{
    const char **extensions;
    const char *description;
    const char *author;
    const char *url;
} Sound_DecoderInfo;
typedef struct
{
    void *opaque;
    const Sound_DecoderInfo *decoder;
    Sound_AudioInfo desired;
    Sound_AudioInfo actual;
    void *buffer;
    Uint32 buffer_size;
    Sound_SampleFlags flags;
} Sound_Sample;
typedef struct
{
    int major;
    int minor;
    int patch;
} Sound_Version;
            void Sound_GetLinkedVersion(Sound_Version *ver);
            int Sound_Init(void);
            int Sound_Quit(void);
            const Sound_DecoderInfo ** Sound_AvailableDecoders(void);
            const char * Sound_GetError(void);
            void Sound_ClearError(void);
            Sound_Sample * Sound_NewSample(SDL_RWops *rw,
                                                   const char *ext,
                                                   Sound_AudioInfo *desired,
                                                   Uint32 bufferSize);
            Sound_Sample * Sound_NewSampleFromFile(const char *fname,
                                                      Sound_AudioInfo *desired,
                                                      Uint32 bufferSize);
            void Sound_FreeSample(Sound_Sample *sample);
            int Sound_SetBufferSize(Sound_Sample *sample,
                                            Uint32 new_size);
            Uint32 Sound_Decode(Sound_Sample *sample);
            Uint32 Sound_DecodeAll(Sound_Sample *sample);
            int Sound_Rewind(Sound_Sample *sample);
            int Sound_Seek(Sound_Sample *sample, Uint32 ms);
]])

sdl_sound = ffi.load(lwlgl.libs.sdl_sound[2])

end

function load_vulkan()

vulkan_core = [[// vk | Vulkan

/*
** Copyright (c) 2015-2016 The Khronos Group Inc.
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
*/

typedef uint32_t VkFlags;
typedef uint32_t VkBool32;
typedef uint64_t VkDeviceSize;
typedef uint32_t VkSampleMask;

VK_DEFINE_HANDLE(VkInstance)
VK_DEFINE_HANDLE(VkPhysicalDevice)
VK_DEFINE_HANDLE(VkDevice)
VK_DEFINE_HANDLE(VkQueue)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkSemaphore)
VK_DEFINE_HANDLE(VkCommandBuffer)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkFence)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDeviceMemory)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkBuffer)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkImage)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkEvent)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkQueryPool)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkBufferView)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkImageView)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkShaderModule)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkPipelineCache)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkPipelineLayout)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkRenderPass)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkPipeline)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDescriptorSetLayout)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkSampler)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDescriptorPool)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDescriptorSet)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkFramebuffer)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkCommandPool)

//static const float VK_LOD_CLAMP_NONE = 1000.0f;
//static const uint64_t VK_WHOLE_SIZE  = (~0ULL);
static const uint32_t VK_API_VERSION = VK_MAKE_VERSION(1, 0, 3);
static const uint32_t VK_REMAINING_MIP_LEVELS  =         (~0U);
static const uint32_t VK_REMAINING_ARRAY_LAYERS =         (~0U);
static const uint32_t VK_ATTACHMENT_UNUSED =             (~0U);
static const uint32_t VK_QUEUE_FAMILY_IGNORED =          (~0U);
static const uint32_t VK_SUBPASS_EXTERNAL =              (~0U);

enum {
  VK_TRUE                           = 1,
  VK_FALSE                          = 0,
  VK_MAX_PHYSICAL_DEVICE_NAME_SIZE  = 256,
  VK_UUID_SIZE                      = 16,
  VK_MAX_MEMORY_TYPES               = 32,
  VK_MAX_MEMORY_HEAPS               = 16,
  VK_MAX_EXTENSION_NAME_SIZE        = 256,
  VK_MAX_DESCRIPTION_SIZE           = 256,
};

typedef enum VkPipelineCacheHeaderVersion {
    VK_PIPELINE_CACHE_HEADER_VERSION_ONE = 1,
    VK_PIPELINE_CACHE_HEADER_VERSION_BEGIN_RANGE = VK_PIPELINE_CACHE_HEADER_VERSION_ONE,
    VK_PIPELINE_CACHE_HEADER_VERSION_END_RANGE = VK_PIPELINE_CACHE_HEADER_VERSION_ONE,
    VK_PIPELINE_CACHE_HEADER_VERSION_RANGE_SIZE = (VK_PIPELINE_CACHE_HEADER_VERSION_ONE - VK_PIPELINE_CACHE_HEADER_VERSION_ONE + 1),
    VK_PIPELINE_CACHE_HEADER_VERSION_MAX_ENUM = 0x7FFFFFFF
} VkPipelineCacheHeaderVersion;

typedef enum VkResult {
    VK_SUCCESS = 0,
    VK_NOT_READY = 1,
    VK_TIMEOUT = 2,
    VK_EVENT_SET = 3,
    VK_EVENT_RESET = 4,
    VK_INCOMPLETE = 5,
    VK_ERROR_OUT_OF_HOST_MEMORY = -1,
    VK_ERROR_OUT_OF_DEVICE_MEMORY = -2,
    VK_ERROR_INITIALIZATION_FAILED = -3,
    VK_ERROR_DEVICE_LOST = -4,
    VK_ERROR_MEMORY_MAP_FAILED = -5,
    VK_ERROR_LAYER_NOT_PRESENT = -6,
    VK_ERROR_EXTENSION_NOT_PRESENT = -7,
    VK_ERROR_FEATURE_NOT_PRESENT = -8,
    VK_ERROR_INCOMPATIBLE_DRIVER = -9,
    VK_ERROR_TOO_MANY_OBJECTS = -10,
    VK_ERROR_FORMAT_NOT_SUPPORTED = -11,
    VK_ERROR_FRAGMENTED_POOL = -12,
    VK_ERROR_SURFACE_LOST_KHR = -1000000000,
    VK_ERROR_NATIVE_WINDOW_IN_USE_KHR = -1000000001,
    VK_SUBOPTIMAL_KHR = 1000001003,
    VK_ERROR_OUT_OF_DATE_KHR = -1000001004,
    VK_ERROR_INCOMPATIBLE_DISPLAY_KHR = -1000003001,
    VK_ERROR_VALIDATION_FAILED_EXT = -1000011001,
    VK_ERROR_INVALID_SHADER_NV = -1000012000,
    VK_RESULT_BEGIN_RANGE = VK_ERROR_FRAGMENTED_POOL,
    VK_RESULT_END_RANGE = VK_INCOMPLETE,
    VK_RESULT_RANGE_SIZE = (VK_INCOMPLETE - VK_ERROR_FRAGMENTED_POOL + 1),
    VK_RESULT_MAX_ENUM = 0x7FFFFFFF
} VkResult;

typedef enum VkStructureType {
    VK_STRUCTURE_TYPE_APPLICATION_INFO = 0,
    VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO = 1,
    VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO = 2,
    VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO = 3,
    VK_STRUCTURE_TYPE_SUBMIT_INFO = 4,
    VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO = 5,
    VK_STRUCTURE_TYPE_MAPPED_MEMORY_RANGE = 6,
    VK_STRUCTURE_TYPE_BIND_SPARSE_INFO = 7,
    VK_STRUCTURE_TYPE_FENCE_CREATE_INFO = 8,
    VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO = 9,
    VK_STRUCTURE_TYPE_EVENT_CREATE_INFO = 10,
    VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO = 11,
    VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO = 12,
    VK_STRUCTURE_TYPE_BUFFER_VIEW_CREATE_INFO = 13,
    VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO = 14,
    VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO = 15,
    VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO = 16,
    VK_STRUCTURE_TYPE_PIPELINE_CACHE_CREATE_INFO = 17,
    VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO = 18,
    VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO = 19,
    VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO = 20,
    VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO = 21,
    VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO = 22,
    VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO = 23,
    VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO = 24,
    VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO = 25,
    VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO = 26,
    VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO = 27,
    VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO = 28,
    VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO = 29,
    VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO = 30,
    VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO = 31,
    VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO = 32,
    VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO = 33,
    VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO = 34,
    VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET = 35,
    VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET = 36,
    VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO = 37,
    VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO = 38,
    VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO = 39,
    VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO = 40,
    VK_STRUCTURE_TYPE_COMMAND_BUFFER_INHERITANCE_INFO = 41,
    VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO = 42,
    VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO = 43,
    VK_STRUCTURE_TYPE_BUFFER_MEMORY_BARRIER = 44,
    VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER = 45,
    VK_STRUCTURE_TYPE_MEMORY_BARRIER = 46,
    VK_STRUCTURE_TYPE_LOADER_INSTANCE_CREATE_INFO = 47,
    VK_STRUCTURE_TYPE_LOADER_DEVICE_CREATE_INFO = 48,
    VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR = 1000001000,
    VK_STRUCTURE_TYPE_PRESENT_INFO_KHR = 1000001001,
    VK_STRUCTURE_TYPE_DISPLAY_MODE_CREATE_INFO_KHR = 1000002000,
    VK_STRUCTURE_TYPE_DISPLAY_SURFACE_CREATE_INFO_KHR = 1000002001,
    VK_STRUCTURE_TYPE_DISPLAY_PRESENT_INFO_KHR = 1000003000,
    VK_STRUCTURE_TYPE_XLIB_SURFACE_CREATE_INFO_KHR = 1000004000,
    VK_STRUCTURE_TYPE_XCB_SURFACE_CREATE_INFO_KHR = 1000005000,
    VK_STRUCTURE_TYPE_WAYLAND_SURFACE_CREATE_INFO_KHR = 1000006000,
    VK_STRUCTURE_TYPE_MIR_SURFACE_CREATE_INFO_KHR = 1000007000,
    VK_STRUCTURE_TYPE_ANDROID_SURFACE_CREATE_INFO_KHR = 1000008000,
    VK_STRUCTURE_TYPE_WIN32_SURFACE_CREATE_INFO_KHR = 1000009000,
    VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT = 1000011000,
    VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD = 1000018000,
    VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_NAME_INFO_EXT = 1000022000,
    VK_STRUCTURE_TYPE_DEBUG_MARKER_OBJECT_TAG_INFO_EXT = 1000022001,
    VK_STRUCTURE_TYPE_DEBUG_MARKER_MARKER_INFO_EXT = 1000022002,
    VK_STRUCTURE_TYPE_DEDICATED_ALLOCATION_IMAGE_CREATE_INFO_NV = 1000026000,
    VK_STRUCTURE_TYPE_DEDICATED_ALLOCATION_BUFFER_CREATE_INFO_NV = 1000026001,
    VK_STRUCTURE_TYPE_DEDICATED_ALLOCATION_MEMORY_ALLOCATE_INFO_NV = 1000026002,
    VK_STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO_NV = 1000056000,
    VK_STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO_NV = 1000056001,
    VK_STRUCTURE_TYPE_IMPORT_MEMORY_WIN32_HANDLE_INFO_NV = 1000057000,
    VK_STRUCTURE_TYPE_EXPORT_MEMORY_WIN32_HANDLE_INFO_NV = 1000057001,
    VK_STRUCTURE_TYPE_WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_NV = 1000058000,
    VK_STRUCTURE_TYPE_VALIDATION_FLAGS_EXT = 1000061000,
    VK_STRUCTURE_TYPE_OBJECT_TABLE_CREATE_INFO_NVX = 1000086000,
    VK_STRUCTURE_TYPE_INDIRECT_COMMANDS_LAYOUT_CREATE_INFO_NVX = 1000086001,
    VK_STRUCTURE_TYPE_CMD_PROCESS_COMMANDS_INFO_NVX = 1000086002,
    VK_STRUCTURE_TYPE_CMD_RESERVE_SPACE_FOR_COMMANDS_INFO_NVX = 1000086003,
    VK_STRUCTURE_TYPE_DEVICE_GENERATED_COMMANDS_LIMITS_NVX = 1000086004,
    VK_STRUCTURE_TYPE_DEVICE_GENERATED_COMMANDS_FEATURES_NVX = 1000086005,
    VK_STRUCTURE_TYPE_BEGIN_RANGE = VK_STRUCTURE_TYPE_APPLICATION_INFO,
    VK_STRUCTURE_TYPE_END_RANGE = VK_STRUCTURE_TYPE_LOADER_DEVICE_CREATE_INFO,
    VK_STRUCTURE_TYPE_RANGE_SIZE = (VK_STRUCTURE_TYPE_LOADER_DEVICE_CREATE_INFO - VK_STRUCTURE_TYPE_APPLICATION_INFO + 1),
    VK_STRUCTURE_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkStructureType;

typedef enum VkSystemAllocationScope {
    VK_SYSTEM_ALLOCATION_SCOPE_COMMAND = 0,
    VK_SYSTEM_ALLOCATION_SCOPE_OBJECT = 1,
    VK_SYSTEM_ALLOCATION_SCOPE_CACHE = 2,
    VK_SYSTEM_ALLOCATION_SCOPE_DEVICE = 3,
    VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE = 4,
    VK_SYSTEM_ALLOCATION_SCOPE_BEGIN_RANGE = VK_SYSTEM_ALLOCATION_SCOPE_COMMAND,
    VK_SYSTEM_ALLOCATION_SCOPE_END_RANGE = VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE,
    VK_SYSTEM_ALLOCATION_SCOPE_RANGE_SIZE = (VK_SYSTEM_ALLOCATION_SCOPE_INSTANCE - VK_SYSTEM_ALLOCATION_SCOPE_COMMAND + 1),
    VK_SYSTEM_ALLOCATION_SCOPE_MAX_ENUM = 0x7FFFFFFF
} VkSystemAllocationScope;

typedef enum VkInternalAllocationType {
    VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE = 0,
    VK_INTERNAL_ALLOCATION_TYPE_BEGIN_RANGE = VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE,
    VK_INTERNAL_ALLOCATION_TYPE_END_RANGE = VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE,
    VK_INTERNAL_ALLOCATION_TYPE_RANGE_SIZE = (VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE - VK_INTERNAL_ALLOCATION_TYPE_EXECUTABLE + 1),
    VK_INTERNAL_ALLOCATION_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkInternalAllocationType;

typedef enum VkFormat {
    VK_FORMAT_UNDEFINED = 0,
    VK_FORMAT_R4G4_UNORM_PACK8 = 1,
    VK_FORMAT_R4G4B4A4_UNORM_PACK16 = 2,
    VK_FORMAT_B4G4R4A4_UNORM_PACK16 = 3,
    VK_FORMAT_R5G6B5_UNORM_PACK16 = 4,
    VK_FORMAT_B5G6R5_UNORM_PACK16 = 5,
    VK_FORMAT_R5G5B5A1_UNORM_PACK16 = 6,
    VK_FORMAT_B5G5R5A1_UNORM_PACK16 = 7,
    VK_FORMAT_A1R5G5B5_UNORM_PACK16 = 8,
    VK_FORMAT_R8_UNORM = 9,
    VK_FORMAT_R8_SNORM = 10,
    VK_FORMAT_R8_USCALED = 11,
    VK_FORMAT_R8_SSCALED = 12,
    VK_FORMAT_R8_UINT = 13,
    VK_FORMAT_R8_SINT = 14,
    VK_FORMAT_R8_SRGB = 15,
    VK_FORMAT_R8G8_UNORM = 16,
    VK_FORMAT_R8G8_SNORM = 17,
    VK_FORMAT_R8G8_USCALED = 18,
    VK_FORMAT_R8G8_SSCALED = 19,
    VK_FORMAT_R8G8_UINT = 20,
    VK_FORMAT_R8G8_SINT = 21,
    VK_FORMAT_R8G8_SRGB = 22,
    VK_FORMAT_R8G8B8_UNORM = 23,
    VK_FORMAT_R8G8B8_SNORM = 24,
    VK_FORMAT_R8G8B8_USCALED = 25,
    VK_FORMAT_R8G8B8_SSCALED = 26,
    VK_FORMAT_R8G8B8_UINT = 27,
    VK_FORMAT_R8G8B8_SINT = 28,
    VK_FORMAT_R8G8B8_SRGB = 29,
    VK_FORMAT_B8G8R8_UNORM = 30,
    VK_FORMAT_B8G8R8_SNORM = 31,
    VK_FORMAT_B8G8R8_USCALED = 32,
    VK_FORMAT_B8G8R8_SSCALED = 33,
    VK_FORMAT_B8G8R8_UINT = 34,
    VK_FORMAT_B8G8R8_SINT = 35,
    VK_FORMAT_B8G8R8_SRGB = 36,
    VK_FORMAT_R8G8B8A8_UNORM = 37,
    VK_FORMAT_R8G8B8A8_SNORM = 38,
    VK_FORMAT_R8G8B8A8_USCALED = 39,
    VK_FORMAT_R8G8B8A8_SSCALED = 40,
    VK_FORMAT_R8G8B8A8_UINT = 41,
    VK_FORMAT_R8G8B8A8_SINT = 42,
    VK_FORMAT_R8G8B8A8_SRGB = 43,
    VK_FORMAT_B8G8R8A8_UNORM = 44,
    VK_FORMAT_B8G8R8A8_SNORM = 45,
    VK_FORMAT_B8G8R8A8_USCALED = 46,
    VK_FORMAT_B8G8R8A8_SSCALED = 47,
    VK_FORMAT_B8G8R8A8_UINT = 48,
    VK_FORMAT_B8G8R8A8_SINT = 49,
    VK_FORMAT_B8G8R8A8_SRGB = 50,
    VK_FORMAT_A8B8G8R8_UNORM_PACK32 = 51,
    VK_FORMAT_A8B8G8R8_SNORM_PACK32 = 52,
    VK_FORMAT_A8B8G8R8_USCALED_PACK32 = 53,
    VK_FORMAT_A8B8G8R8_SSCALED_PACK32 = 54,
    VK_FORMAT_A8B8G8R8_UINT_PACK32 = 55,
    VK_FORMAT_A8B8G8R8_SINT_PACK32 = 56,
    VK_FORMAT_A8B8G8R8_SRGB_PACK32 = 57,
    VK_FORMAT_A2R10G10B10_UNORM_PACK32 = 58,
    VK_FORMAT_A2R10G10B10_SNORM_PACK32 = 59,
    VK_FORMAT_A2R10G10B10_USCALED_PACK32 = 60,
    VK_FORMAT_A2R10G10B10_SSCALED_PACK32 = 61,
    VK_FORMAT_A2R10G10B10_UINT_PACK32 = 62,
    VK_FORMAT_A2R10G10B10_SINT_PACK32 = 63,
    VK_FORMAT_A2B10G10R10_UNORM_PACK32 = 64,
    VK_FORMAT_A2B10G10R10_SNORM_PACK32 = 65,
    VK_FORMAT_A2B10G10R10_USCALED_PACK32 = 66,
    VK_FORMAT_A2B10G10R10_SSCALED_PACK32 = 67,
    VK_FORMAT_A2B10G10R10_UINT_PACK32 = 68,
    VK_FORMAT_A2B10G10R10_SINT_PACK32 = 69,
    VK_FORMAT_R16_UNORM = 70,
    VK_FORMAT_R16_SNORM = 71,
    VK_FORMAT_R16_USCALED = 72,
    VK_FORMAT_R16_SSCALED = 73,
    VK_FORMAT_R16_UINT = 74,
    VK_FORMAT_R16_SINT = 75,
    VK_FORMAT_R16_SFLOAT = 76,
    VK_FORMAT_R16G16_UNORM = 77,
    VK_FORMAT_R16G16_SNORM = 78,
    VK_FORMAT_R16G16_USCALED = 79,
    VK_FORMAT_R16G16_SSCALED = 80,
    VK_FORMAT_R16G16_UINT = 81,
    VK_FORMAT_R16G16_SINT = 82,
    VK_FORMAT_R16G16_SFLOAT = 83,
    VK_FORMAT_R16G16B16_UNORM = 84,
    VK_FORMAT_R16G16B16_SNORM = 85,
    VK_FORMAT_R16G16B16_USCALED = 86,
    VK_FORMAT_R16G16B16_SSCALED = 87,
    VK_FORMAT_R16G16B16_UINT = 88,
    VK_FORMAT_R16G16B16_SINT = 89,
    VK_FORMAT_R16G16B16_SFLOAT = 90,
    VK_FORMAT_R16G16B16A16_UNORM = 91,
    VK_FORMAT_R16G16B16A16_SNORM = 92,
    VK_FORMAT_R16G16B16A16_USCALED = 93,
    VK_FORMAT_R16G16B16A16_SSCALED = 94,
    VK_FORMAT_R16G16B16A16_UINT = 95,
    VK_FORMAT_R16G16B16A16_SINT = 96,
    VK_FORMAT_R16G16B16A16_SFLOAT = 97,
    VK_FORMAT_R32_UINT = 98,
    VK_FORMAT_R32_SINT = 99,
    VK_FORMAT_R32_SFLOAT = 100,
    VK_FORMAT_R32G32_UINT = 101,
    VK_FORMAT_R32G32_SINT = 102,
    VK_FORMAT_R32G32_SFLOAT = 103,
    VK_FORMAT_R32G32B32_UINT = 104,
    VK_FORMAT_R32G32B32_SINT = 105,
    VK_FORMAT_R32G32B32_SFLOAT = 106,
    VK_FORMAT_R32G32B32A32_UINT = 107,
    VK_FORMAT_R32G32B32A32_SINT = 108,
    VK_FORMAT_R32G32B32A32_SFLOAT = 109,
    VK_FORMAT_R64_UINT = 110,
    VK_FORMAT_R64_SINT = 111,
    VK_FORMAT_R64_SFLOAT = 112,
    VK_FORMAT_R64G64_UINT = 113,
    VK_FORMAT_R64G64_SINT = 114,
    VK_FORMAT_R64G64_SFLOAT = 115,
    VK_FORMAT_R64G64B64_UINT = 116,
    VK_FORMAT_R64G64B64_SINT = 117,
    VK_FORMAT_R64G64B64_SFLOAT = 118,
    VK_FORMAT_R64G64B64A64_UINT = 119,
    VK_FORMAT_R64G64B64A64_SINT = 120,
    VK_FORMAT_R64G64B64A64_SFLOAT = 121,
    VK_FORMAT_B10G11R11_UFLOAT_PACK32 = 122,
    VK_FORMAT_E5B9G9R9_UFLOAT_PACK32 = 123,
    VK_FORMAT_D16_UNORM = 124,
    VK_FORMAT_X8_D24_UNORM_PACK32 = 125,
    VK_FORMAT_D32_SFLOAT = 126,
    VK_FORMAT_S8_UINT = 127,
    VK_FORMAT_D16_UNORM_S8_UINT = 128,
    VK_FORMAT_D24_UNORM_S8_UINT = 129,
    VK_FORMAT_D32_SFLOAT_S8_UINT = 130,
    VK_FORMAT_BC1_RGB_UNORM_BLOCK = 131,
    VK_FORMAT_BC1_RGB_SRGB_BLOCK = 132,
    VK_FORMAT_BC1_RGBA_UNORM_BLOCK = 133,
    VK_FORMAT_BC1_RGBA_SRGB_BLOCK = 134,
    VK_FORMAT_BC2_UNORM_BLOCK = 135,
    VK_FORMAT_BC2_SRGB_BLOCK = 136,
    VK_FORMAT_BC3_UNORM_BLOCK = 137,
    VK_FORMAT_BC3_SRGB_BLOCK = 138,
    VK_FORMAT_BC4_UNORM_BLOCK = 139,
    VK_FORMAT_BC4_SNORM_BLOCK = 140,
    VK_FORMAT_BC5_UNORM_BLOCK = 141,
    VK_FORMAT_BC5_SNORM_BLOCK = 142,
    VK_FORMAT_BC6H_UFLOAT_BLOCK = 143,
    VK_FORMAT_BC6H_SFLOAT_BLOCK = 144,
    VK_FORMAT_BC7_UNORM_BLOCK = 145,
    VK_FORMAT_BC7_SRGB_BLOCK = 146,
    VK_FORMAT_ETC2_R8G8B8_UNORM_BLOCK = 147,
    VK_FORMAT_ETC2_R8G8B8_SRGB_BLOCK = 148,
    VK_FORMAT_ETC2_R8G8B8A1_UNORM_BLOCK = 149,
    VK_FORMAT_ETC2_R8G8B8A1_SRGB_BLOCK = 150,
    VK_FORMAT_ETC2_R8G8B8A8_UNORM_BLOCK = 151,
    VK_FORMAT_ETC2_R8G8B8A8_SRGB_BLOCK = 152,
    VK_FORMAT_EAC_R11_UNORM_BLOCK = 153,
    VK_FORMAT_EAC_R11_SNORM_BLOCK = 154,
    VK_FORMAT_EAC_R11G11_UNORM_BLOCK = 155,
    VK_FORMAT_EAC_R11G11_SNORM_BLOCK = 156,
    VK_FORMAT_ASTC_4x4_UNORM_BLOCK = 157,
    VK_FORMAT_ASTC_4x4_SRGB_BLOCK = 158,
    VK_FORMAT_ASTC_5x4_UNORM_BLOCK = 159,
    VK_FORMAT_ASTC_5x4_SRGB_BLOCK = 160,
    VK_FORMAT_ASTC_5x5_UNORM_BLOCK = 161,
    VK_FORMAT_ASTC_5x5_SRGB_BLOCK = 162,
    VK_FORMAT_ASTC_6x5_UNORM_BLOCK = 163,
    VK_FORMAT_ASTC_6x5_SRGB_BLOCK = 164,
    VK_FORMAT_ASTC_6x6_UNORM_BLOCK = 165,
    VK_FORMAT_ASTC_6x6_SRGB_BLOCK = 166,
    VK_FORMAT_ASTC_8x5_UNORM_BLOCK = 167,
    VK_FORMAT_ASTC_8x5_SRGB_BLOCK = 168,
    VK_FORMAT_ASTC_8x6_UNORM_BLOCK = 169,
    VK_FORMAT_ASTC_8x6_SRGB_BLOCK = 170,
    VK_FORMAT_ASTC_8x8_UNORM_BLOCK = 171,
    VK_FORMAT_ASTC_8x8_SRGB_BLOCK = 172,
    VK_FORMAT_ASTC_10x5_UNORM_BLOCK = 173,
    VK_FORMAT_ASTC_10x5_SRGB_BLOCK = 174,
    VK_FORMAT_ASTC_10x6_UNORM_BLOCK = 175,
    VK_FORMAT_ASTC_10x6_SRGB_BLOCK = 176,
    VK_FORMAT_ASTC_10x8_UNORM_BLOCK = 177,
    VK_FORMAT_ASTC_10x8_SRGB_BLOCK = 178,
    VK_FORMAT_ASTC_10x10_UNORM_BLOCK = 179,
    VK_FORMAT_ASTC_10x10_SRGB_BLOCK = 180,
    VK_FORMAT_ASTC_12x10_UNORM_BLOCK = 181,
    VK_FORMAT_ASTC_12x10_SRGB_BLOCK = 182,
    VK_FORMAT_ASTC_12x12_UNORM_BLOCK = 183,
    VK_FORMAT_ASTC_12x12_SRGB_BLOCK = 184,
    VK_FORMAT_PVRTC1_2BPP_UNORM_BLOCK_IMG = 1000054000,
    VK_FORMAT_PVRTC1_4BPP_UNORM_BLOCK_IMG = 1000054001,
    VK_FORMAT_PVRTC2_2BPP_UNORM_BLOCK_IMG = 1000054002,
    VK_FORMAT_PVRTC2_4BPP_UNORM_BLOCK_IMG = 1000054003,
    VK_FORMAT_PVRTC1_2BPP_SRGB_BLOCK_IMG = 1000054004,
    VK_FORMAT_PVRTC1_4BPP_SRGB_BLOCK_IMG = 1000054005,
    VK_FORMAT_PVRTC2_2BPP_SRGB_BLOCK_IMG = 1000054006,
    VK_FORMAT_PVRTC2_4BPP_SRGB_BLOCK_IMG = 1000054007,
    VK_FORMAT_BEGIN_RANGE = VK_FORMAT_UNDEFINED,
    VK_FORMAT_END_RANGE = VK_FORMAT_ASTC_12x12_SRGB_BLOCK,
    VK_FORMAT_RANGE_SIZE = (VK_FORMAT_ASTC_12x12_SRGB_BLOCK - VK_FORMAT_UNDEFINED + 1),
    VK_FORMAT_MAX_ENUM = 0x7FFFFFFF
} VkFormat;

typedef enum VkImageType {
    VK_IMAGE_TYPE_1D = 0,
    VK_IMAGE_TYPE_2D = 1,
    VK_IMAGE_TYPE_3D = 2,
    VK_IMAGE_TYPE_BEGIN_RANGE = VK_IMAGE_TYPE_1D,
    VK_IMAGE_TYPE_END_RANGE = VK_IMAGE_TYPE_3D,
    VK_IMAGE_TYPE_RANGE_SIZE = (VK_IMAGE_TYPE_3D - VK_IMAGE_TYPE_1D + 1),
    VK_IMAGE_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkImageType;

typedef enum VkImageTiling {
    VK_IMAGE_TILING_OPTIMAL = 0,
    VK_IMAGE_TILING_LINEAR = 1,
    VK_IMAGE_TILING_BEGIN_RANGE = VK_IMAGE_TILING_OPTIMAL,
    VK_IMAGE_TILING_END_RANGE = VK_IMAGE_TILING_LINEAR,
    VK_IMAGE_TILING_RANGE_SIZE = (VK_IMAGE_TILING_LINEAR - VK_IMAGE_TILING_OPTIMAL + 1),
    VK_IMAGE_TILING_MAX_ENUM = 0x7FFFFFFF
} VkImageTiling;

typedef enum VkPhysicalDeviceType {
    VK_PHYSICAL_DEVICE_TYPE_OTHER = 0,
    VK_PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU = 1,
    VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU = 2,
    VK_PHYSICAL_DEVICE_TYPE_VIRTUAL_GPU = 3,
    VK_PHYSICAL_DEVICE_TYPE_CPU = 4,
    VK_PHYSICAL_DEVICE_TYPE_BEGIN_RANGE = VK_PHYSICAL_DEVICE_TYPE_OTHER,
    VK_PHYSICAL_DEVICE_TYPE_END_RANGE = VK_PHYSICAL_DEVICE_TYPE_CPU,
    VK_PHYSICAL_DEVICE_TYPE_RANGE_SIZE = (VK_PHYSICAL_DEVICE_TYPE_CPU - VK_PHYSICAL_DEVICE_TYPE_OTHER + 1),
    VK_PHYSICAL_DEVICE_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkPhysicalDeviceType;

typedef enum VkQueryType {
    VK_QUERY_TYPE_OCCLUSION = 0,
    VK_QUERY_TYPE_PIPELINE_STATISTICS = 1,
    VK_QUERY_TYPE_TIMESTAMP = 2,
    VK_QUERY_TYPE_BEGIN_RANGE = VK_QUERY_TYPE_OCCLUSION,
    VK_QUERY_TYPE_END_RANGE = VK_QUERY_TYPE_TIMESTAMP,
    VK_QUERY_TYPE_RANGE_SIZE = (VK_QUERY_TYPE_TIMESTAMP - VK_QUERY_TYPE_OCCLUSION + 1),
    VK_QUERY_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkQueryType;

typedef enum VkSharingMode {
    VK_SHARING_MODE_EXCLUSIVE = 0,
    VK_SHARING_MODE_CONCURRENT = 1,
    VK_SHARING_MODE_BEGIN_RANGE = VK_SHARING_MODE_EXCLUSIVE,
    VK_SHARING_MODE_END_RANGE = VK_SHARING_MODE_CONCURRENT,
    VK_SHARING_MODE_RANGE_SIZE = (VK_SHARING_MODE_CONCURRENT - VK_SHARING_MODE_EXCLUSIVE + 1),
    VK_SHARING_MODE_MAX_ENUM = 0x7FFFFFFF
} VkSharingMode;

typedef enum VkImageLayout {
    VK_IMAGE_LAYOUT_UNDEFINED = 0,
    VK_IMAGE_LAYOUT_GENERAL = 1,
    VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL = 2,
    VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL = 3,
    VK_IMAGE_LAYOUT_DEPTH_STENCIL_READ_ONLY_OPTIMAL = 4,
    VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL = 5,
    VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL = 6,
    VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL = 7,
    VK_IMAGE_LAYOUT_PREINITIALIZED = 8,
    VK_IMAGE_LAYOUT_PRESENT_SRC_KHR = 1000001002,
    VK_IMAGE_LAYOUT_BEGIN_RANGE = VK_IMAGE_LAYOUT_UNDEFINED,
    VK_IMAGE_LAYOUT_END_RANGE = VK_IMAGE_LAYOUT_PREINITIALIZED,
    VK_IMAGE_LAYOUT_RANGE_SIZE = (VK_IMAGE_LAYOUT_PREINITIALIZED - VK_IMAGE_LAYOUT_UNDEFINED + 1),
    VK_IMAGE_LAYOUT_MAX_ENUM = 0x7FFFFFFF
} VkImageLayout;

typedef enum VkImageViewType {
    VK_IMAGE_VIEW_TYPE_1D = 0,
    VK_IMAGE_VIEW_TYPE_2D = 1,
    VK_IMAGE_VIEW_TYPE_3D = 2,
    VK_IMAGE_VIEW_TYPE_CUBE = 3,
    VK_IMAGE_VIEW_TYPE_1D_ARRAY = 4,
    VK_IMAGE_VIEW_TYPE_2D_ARRAY = 5,
    VK_IMAGE_VIEW_TYPE_CUBE_ARRAY = 6,
    VK_IMAGE_VIEW_TYPE_BEGIN_RANGE = VK_IMAGE_VIEW_TYPE_1D,
    VK_IMAGE_VIEW_TYPE_END_RANGE = VK_IMAGE_VIEW_TYPE_CUBE_ARRAY,
    VK_IMAGE_VIEW_TYPE_RANGE_SIZE = (VK_IMAGE_VIEW_TYPE_CUBE_ARRAY - VK_IMAGE_VIEW_TYPE_1D + 1),
    VK_IMAGE_VIEW_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkImageViewType;

typedef enum VkComponentSwizzle {
    VK_COMPONENT_SWIZZLE_IDENTITY = 0,
    VK_COMPONENT_SWIZZLE_ZERO = 1,
    VK_COMPONENT_SWIZZLE_ONE = 2,
    VK_COMPONENT_SWIZZLE_R = 3,
    VK_COMPONENT_SWIZZLE_G = 4,
    VK_COMPONENT_SWIZZLE_B = 5,
    VK_COMPONENT_SWIZZLE_A = 6,
    VK_COMPONENT_SWIZZLE_BEGIN_RANGE = VK_COMPONENT_SWIZZLE_IDENTITY,
    VK_COMPONENT_SWIZZLE_END_RANGE = VK_COMPONENT_SWIZZLE_A,
    VK_COMPONENT_SWIZZLE_RANGE_SIZE = (VK_COMPONENT_SWIZZLE_A - VK_COMPONENT_SWIZZLE_IDENTITY + 1),
    VK_COMPONENT_SWIZZLE_MAX_ENUM = 0x7FFFFFFF
} VkComponentSwizzle;

typedef enum VkVertexInputRate {
    VK_VERTEX_INPUT_RATE_VERTEX = 0,
    VK_VERTEX_INPUT_RATE_INSTANCE = 1,
    VK_VERTEX_INPUT_RATE_BEGIN_RANGE = VK_VERTEX_INPUT_RATE_VERTEX,
    VK_VERTEX_INPUT_RATE_END_RANGE = VK_VERTEX_INPUT_RATE_INSTANCE,
    VK_VERTEX_INPUT_RATE_RANGE_SIZE = (VK_VERTEX_INPUT_RATE_INSTANCE - VK_VERTEX_INPUT_RATE_VERTEX + 1),
    VK_VERTEX_INPUT_RATE_MAX_ENUM = 0x7FFFFFFF
} VkVertexInputRate;

typedef enum VkPrimitiveTopology {
    VK_PRIMITIVE_TOPOLOGY_POINT_LIST = 0,
    VK_PRIMITIVE_TOPOLOGY_LINE_LIST = 1,
    VK_PRIMITIVE_TOPOLOGY_LINE_STRIP = 2,
    VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST = 3,
    VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP = 4,
    VK_PRIMITIVE_TOPOLOGY_TRIANGLE_FAN = 5,
    VK_PRIMITIVE_TOPOLOGY_LINE_LIST_WITH_ADJACENCY = 6,
    VK_PRIMITIVE_TOPOLOGY_LINE_STRIP_WITH_ADJACENCY = 7,
    VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST_WITH_ADJACENCY = 8,
    VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP_WITH_ADJACENCY = 9,
    VK_PRIMITIVE_TOPOLOGY_PATCH_LIST = 10,
    VK_PRIMITIVE_TOPOLOGY_BEGIN_RANGE = VK_PRIMITIVE_TOPOLOGY_POINT_LIST,
    VK_PRIMITIVE_TOPOLOGY_END_RANGE = VK_PRIMITIVE_TOPOLOGY_PATCH_LIST,
    VK_PRIMITIVE_TOPOLOGY_RANGE_SIZE = (VK_PRIMITIVE_TOPOLOGY_PATCH_LIST - VK_PRIMITIVE_TOPOLOGY_POINT_LIST + 1),
    VK_PRIMITIVE_TOPOLOGY_MAX_ENUM = 0x7FFFFFFF
} VkPrimitiveTopology;

typedef enum VkPolygonMode {
    VK_POLYGON_MODE_FILL = 0,
    VK_POLYGON_MODE_LINE = 1,
    VK_POLYGON_MODE_POINT = 2,
    VK_POLYGON_MODE_BEGIN_RANGE = VK_POLYGON_MODE_FILL,
    VK_POLYGON_MODE_END_RANGE = VK_POLYGON_MODE_POINT,
    VK_POLYGON_MODE_RANGE_SIZE = (VK_POLYGON_MODE_POINT - VK_POLYGON_MODE_FILL + 1),
    VK_POLYGON_MODE_MAX_ENUM = 0x7FFFFFFF
} VkPolygonMode;

typedef enum VkFrontFace {
    VK_FRONT_FACE_COUNTER_CLOCKWISE = 0,
    VK_FRONT_FACE_CLOCKWISE = 1,
    VK_FRONT_FACE_BEGIN_RANGE = VK_FRONT_FACE_COUNTER_CLOCKWISE,
    VK_FRONT_FACE_END_RANGE = VK_FRONT_FACE_CLOCKWISE,
    VK_FRONT_FACE_RANGE_SIZE = (VK_FRONT_FACE_CLOCKWISE - VK_FRONT_FACE_COUNTER_CLOCKWISE + 1),
    VK_FRONT_FACE_MAX_ENUM = 0x7FFFFFFF
} VkFrontFace;

typedef enum VkCompareOp {
    VK_COMPARE_OP_NEVER = 0,
    VK_COMPARE_OP_LESS = 1,
    VK_COMPARE_OP_EQUAL = 2,
    VK_COMPARE_OP_LESS_OR_EQUAL = 3,
    VK_COMPARE_OP_GREATER = 4,
    VK_COMPARE_OP_NOT_EQUAL = 5,
    VK_COMPARE_OP_GREATER_OR_EQUAL = 6,
    VK_COMPARE_OP_ALWAYS = 7,
    VK_COMPARE_OP_BEGIN_RANGE = VK_COMPARE_OP_NEVER,
    VK_COMPARE_OP_END_RANGE = VK_COMPARE_OP_ALWAYS,
    VK_COMPARE_OP_RANGE_SIZE = (VK_COMPARE_OP_ALWAYS - VK_COMPARE_OP_NEVER + 1),
    VK_COMPARE_OP_MAX_ENUM = 0x7FFFFFFF
} VkCompareOp;

typedef enum VkStencilOp {
    VK_STENCIL_OP_KEEP = 0,
    VK_STENCIL_OP_ZERO = 1,
    VK_STENCIL_OP_REPLACE = 2,
    VK_STENCIL_OP_INCREMENT_AND_CLAMP = 3,
    VK_STENCIL_OP_DECREMENT_AND_CLAMP = 4,
    VK_STENCIL_OP_INVERT = 5,
    VK_STENCIL_OP_INCREMENT_AND_WRAP = 6,
    VK_STENCIL_OP_DECREMENT_AND_WRAP = 7,
    VK_STENCIL_OP_BEGIN_RANGE = VK_STENCIL_OP_KEEP,
    VK_STENCIL_OP_END_RANGE = VK_STENCIL_OP_DECREMENT_AND_WRAP,
    VK_STENCIL_OP_RANGE_SIZE = (VK_STENCIL_OP_DECREMENT_AND_WRAP - VK_STENCIL_OP_KEEP + 1),
    VK_STENCIL_OP_MAX_ENUM = 0x7FFFFFFF
} VkStencilOp;

typedef enum VkLogicOp {
    VK_LOGIC_OP_CLEAR = 0,
    VK_LOGIC_OP_AND = 1,
    VK_LOGIC_OP_AND_REVERSE = 2,
    VK_LOGIC_OP_COPY = 3,
    VK_LOGIC_OP_AND_INVERTED = 4,
    VK_LOGIC_OP_NO_OP = 5,
    VK_LOGIC_OP_XOR = 6,
    VK_LOGIC_OP_OR = 7,
    VK_LOGIC_OP_NOR = 8,
    VK_LOGIC_OP_EQUIVALENT = 9,
    VK_LOGIC_OP_INVERT = 10,
    VK_LOGIC_OP_OR_REVERSE = 11,
    VK_LOGIC_OP_COPY_INVERTED = 12,
    VK_LOGIC_OP_OR_INVERTED = 13,
    VK_LOGIC_OP_NAND = 14,
    VK_LOGIC_OP_SET = 15,
    VK_LOGIC_OP_BEGIN_RANGE = VK_LOGIC_OP_CLEAR,
    VK_LOGIC_OP_END_RANGE = VK_LOGIC_OP_SET,
    VK_LOGIC_OP_RANGE_SIZE = (VK_LOGIC_OP_SET - VK_LOGIC_OP_CLEAR + 1),
    VK_LOGIC_OP_MAX_ENUM = 0x7FFFFFFF
} VkLogicOp;

typedef enum VkBlendFactor {
    VK_BLEND_FACTOR_ZERO = 0,
    VK_BLEND_FACTOR_ONE = 1,
    VK_BLEND_FACTOR_SRC_COLOR = 2,
    VK_BLEND_FACTOR_ONE_MINUS_SRC_COLOR = 3,
    VK_BLEND_FACTOR_DST_COLOR = 4,
    VK_BLEND_FACTOR_ONE_MINUS_DST_COLOR = 5,
    VK_BLEND_FACTOR_SRC_ALPHA = 6,
    VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA = 7,
    VK_BLEND_FACTOR_DST_ALPHA = 8,
    VK_BLEND_FACTOR_ONE_MINUS_DST_ALPHA = 9,
    VK_BLEND_FACTOR_CONSTANT_COLOR = 10,
    VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_COLOR = 11,
    VK_BLEND_FACTOR_CONSTANT_ALPHA = 12,
    VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_ALPHA = 13,
    VK_BLEND_FACTOR_SRC_ALPHA_SATURATE = 14,
    VK_BLEND_FACTOR_SRC1_COLOR = 15,
    VK_BLEND_FACTOR_ONE_MINUS_SRC1_COLOR = 16,
    VK_BLEND_FACTOR_SRC1_ALPHA = 17,
    VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA = 18,
    VK_BLEND_FACTOR_BEGIN_RANGE = VK_BLEND_FACTOR_ZERO,
    VK_BLEND_FACTOR_END_RANGE = VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA,
    VK_BLEND_FACTOR_RANGE_SIZE = (VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA - VK_BLEND_FACTOR_ZERO + 1),
    VK_BLEND_FACTOR_MAX_ENUM = 0x7FFFFFFF
} VkBlendFactor;

typedef enum VkBlendOp {
    VK_BLEND_OP_ADD = 0,
    VK_BLEND_OP_SUBTRACT = 1,
    VK_BLEND_OP_REVERSE_SUBTRACT = 2,
    VK_BLEND_OP_MIN = 3,
    VK_BLEND_OP_MAX = 4,
    VK_BLEND_OP_BEGIN_RANGE = VK_BLEND_OP_ADD,
    VK_BLEND_OP_END_RANGE = VK_BLEND_OP_MAX,
    VK_BLEND_OP_RANGE_SIZE = (VK_BLEND_OP_MAX - VK_BLEND_OP_ADD + 1),
    VK_BLEND_OP_MAX_ENUM = 0x7FFFFFFF
} VkBlendOp;

typedef enum VkDynamicState {
    VK_DYNAMIC_STATE_VIEWPORT = 0,
    VK_DYNAMIC_STATE_SCISSOR = 1,
    VK_DYNAMIC_STATE_LINE_WIDTH = 2,
    VK_DYNAMIC_STATE_DEPTH_BIAS = 3,
    VK_DYNAMIC_STATE_BLEND_CONSTANTS = 4,
    VK_DYNAMIC_STATE_DEPTH_BOUNDS = 5,
    VK_DYNAMIC_STATE_STENCIL_COMPARE_MASK = 6,
    VK_DYNAMIC_STATE_STENCIL_WRITE_MASK = 7,
    VK_DYNAMIC_STATE_STENCIL_REFERENCE = 8,
    VK_DYNAMIC_STATE_BEGIN_RANGE = VK_DYNAMIC_STATE_VIEWPORT,
    VK_DYNAMIC_STATE_END_RANGE = VK_DYNAMIC_STATE_STENCIL_REFERENCE,
    VK_DYNAMIC_STATE_RANGE_SIZE = (VK_DYNAMIC_STATE_STENCIL_REFERENCE - VK_DYNAMIC_STATE_VIEWPORT + 1),
    VK_DYNAMIC_STATE_MAX_ENUM = 0x7FFFFFFF
} VkDynamicState;

typedef enum VkFilter {
    VK_FILTER_NEAREST = 0,
    VK_FILTER_LINEAR = 1,
    VK_FILTER_CUBIC_IMG = 1000015000,
    VK_FILTER_BEGIN_RANGE = VK_FILTER_NEAREST,
    VK_FILTER_END_RANGE = VK_FILTER_LINEAR,
    VK_FILTER_RANGE_SIZE = (VK_FILTER_LINEAR - VK_FILTER_NEAREST + 1),
    VK_FILTER_MAX_ENUM = 0x7FFFFFFF
} VkFilter;

typedef enum VkSamplerMipmapMode {
    VK_SAMPLER_MIPMAP_MODE_NEAREST = 0,
    VK_SAMPLER_MIPMAP_MODE_LINEAR = 1,
    VK_SAMPLER_MIPMAP_MODE_BEGIN_RANGE = VK_SAMPLER_MIPMAP_MODE_NEAREST,
    VK_SAMPLER_MIPMAP_MODE_END_RANGE = VK_SAMPLER_MIPMAP_MODE_LINEAR,
    VK_SAMPLER_MIPMAP_MODE_RANGE_SIZE = (VK_SAMPLER_MIPMAP_MODE_LINEAR - VK_SAMPLER_MIPMAP_MODE_NEAREST + 1),
    VK_SAMPLER_MIPMAP_MODE_MAX_ENUM = 0x7FFFFFFF
} VkSamplerMipmapMode;

typedef enum VkSamplerAddressMode {
    VK_SAMPLER_ADDRESS_MODE_REPEAT = 0,
    VK_SAMPLER_ADDRESS_MODE_MIRRORED_REPEAT = 1,
    VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE = 2,
    VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER = 3,
    VK_SAMPLER_ADDRESS_MODE_MIRROR_CLAMP_TO_EDGE = 4,
    VK_SAMPLER_ADDRESS_MODE_BEGIN_RANGE = VK_SAMPLER_ADDRESS_MODE_REPEAT,
    VK_SAMPLER_ADDRESS_MODE_END_RANGE = VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER,
    VK_SAMPLER_ADDRESS_MODE_RANGE_SIZE = (VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER - VK_SAMPLER_ADDRESS_MODE_REPEAT + 1),
    VK_SAMPLER_ADDRESS_MODE_MAX_ENUM = 0x7FFFFFFF
} VkSamplerAddressMode;

typedef enum VkBorderColor {
    VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK = 0,
    VK_BORDER_COLOR_INT_TRANSPARENT_BLACK = 1,
    VK_BORDER_COLOR_FLOAT_OPAQUE_BLACK = 2,
    VK_BORDER_COLOR_INT_OPAQUE_BLACK = 3,
    VK_BORDER_COLOR_FLOAT_OPAQUE_WHITE = 4,
    VK_BORDER_COLOR_INT_OPAQUE_WHITE = 5,
    VK_BORDER_COLOR_BEGIN_RANGE = VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK,
    VK_BORDER_COLOR_END_RANGE = VK_BORDER_COLOR_INT_OPAQUE_WHITE,
    VK_BORDER_COLOR_RANGE_SIZE = (VK_BORDER_COLOR_INT_OPAQUE_WHITE - VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK + 1),
    VK_BORDER_COLOR_MAX_ENUM = 0x7FFFFFFF
} VkBorderColor;

typedef enum VkDescriptorType {
    VK_DESCRIPTOR_TYPE_SAMPLER = 0,
    VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER = 1,
    VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE = 2,
    VK_DESCRIPTOR_TYPE_STORAGE_IMAGE = 3,
    VK_DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER = 4,
    VK_DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER = 5,
    VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER = 6,
    VK_DESCRIPTOR_TYPE_STORAGE_BUFFER = 7,
    VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC = 8,
    VK_DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC = 9,
    VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT = 10,
    VK_DESCRIPTOR_TYPE_BEGIN_RANGE = VK_DESCRIPTOR_TYPE_SAMPLER,
    VK_DESCRIPTOR_TYPE_END_RANGE = VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT,
    VK_DESCRIPTOR_TYPE_RANGE_SIZE = (VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT - VK_DESCRIPTOR_TYPE_SAMPLER + 1),
    VK_DESCRIPTOR_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkDescriptorType;

typedef enum VkAttachmentLoadOp {
    VK_ATTACHMENT_LOAD_OP_LOAD = 0,
    VK_ATTACHMENT_LOAD_OP_CLEAR = 1,
    VK_ATTACHMENT_LOAD_OP_DONT_CARE = 2,
    VK_ATTACHMENT_LOAD_OP_BEGIN_RANGE = VK_ATTACHMENT_LOAD_OP_LOAD,
    VK_ATTACHMENT_LOAD_OP_END_RANGE = VK_ATTACHMENT_LOAD_OP_DONT_CARE,
    VK_ATTACHMENT_LOAD_OP_RANGE_SIZE = (VK_ATTACHMENT_LOAD_OP_DONT_CARE - VK_ATTACHMENT_LOAD_OP_LOAD + 1),
    VK_ATTACHMENT_LOAD_OP_MAX_ENUM = 0x7FFFFFFF
} VkAttachmentLoadOp;

typedef enum VkAttachmentStoreOp {
    VK_ATTACHMENT_STORE_OP_STORE = 0,
    VK_ATTACHMENT_STORE_OP_DONT_CARE = 1,
    VK_ATTACHMENT_STORE_OP_BEGIN_RANGE = VK_ATTACHMENT_STORE_OP_STORE,
    VK_ATTACHMENT_STORE_OP_END_RANGE = VK_ATTACHMENT_STORE_OP_DONT_CARE,
    VK_ATTACHMENT_STORE_OP_RANGE_SIZE = (VK_ATTACHMENT_STORE_OP_DONT_CARE - VK_ATTACHMENT_STORE_OP_STORE + 1),
    VK_ATTACHMENT_STORE_OP_MAX_ENUM = 0x7FFFFFFF
} VkAttachmentStoreOp;

typedef enum VkPipelineBindPoint {
    VK_PIPELINE_BIND_POINT_GRAPHICS = 0,
    VK_PIPELINE_BIND_POINT_COMPUTE = 1,
    VK_PIPELINE_BIND_POINT_BEGIN_RANGE = VK_PIPELINE_BIND_POINT_GRAPHICS,
    VK_PIPELINE_BIND_POINT_END_RANGE = VK_PIPELINE_BIND_POINT_COMPUTE,
    VK_PIPELINE_BIND_POINT_RANGE_SIZE = (VK_PIPELINE_BIND_POINT_COMPUTE - VK_PIPELINE_BIND_POINT_GRAPHICS + 1),
    VK_PIPELINE_BIND_POINT_MAX_ENUM = 0x7FFFFFFF
} VkPipelineBindPoint;

typedef enum VkCommandBufferLevel {
    VK_COMMAND_BUFFER_LEVEL_PRIMARY = 0,
    VK_COMMAND_BUFFER_LEVEL_SECONDARY = 1,
    VK_COMMAND_BUFFER_LEVEL_BEGIN_RANGE = VK_COMMAND_BUFFER_LEVEL_PRIMARY,
    VK_COMMAND_BUFFER_LEVEL_END_RANGE = VK_COMMAND_BUFFER_LEVEL_SECONDARY,
    VK_COMMAND_BUFFER_LEVEL_RANGE_SIZE = (VK_COMMAND_BUFFER_LEVEL_SECONDARY - VK_COMMAND_BUFFER_LEVEL_PRIMARY + 1),
    VK_COMMAND_BUFFER_LEVEL_MAX_ENUM = 0x7FFFFFFF
} VkCommandBufferLevel;

typedef enum VkIndexType {
    VK_INDEX_TYPE_UINT16 = 0,
    VK_INDEX_TYPE_UINT32 = 1,
    VK_INDEX_TYPE_BEGIN_RANGE = VK_INDEX_TYPE_UINT16,
    VK_INDEX_TYPE_END_RANGE = VK_INDEX_TYPE_UINT32,
    VK_INDEX_TYPE_RANGE_SIZE = (VK_INDEX_TYPE_UINT32 - VK_INDEX_TYPE_UINT16 + 1),
    VK_INDEX_TYPE_MAX_ENUM = 0x7FFFFFFF
} VkIndexType;

typedef enum VkSubpassContents {
    VK_SUBPASS_CONTENTS_INLINE = 0,
    VK_SUBPASS_CONTENTS_SECONDARY_COMMAND_BUFFERS = 1,
    VK_SUBPASS_CONTENTS_BEGIN_RANGE = VK_SUBPASS_CONTENTS_INLINE,
    VK_SUBPASS_CONTENTS_END_RANGE = VK_SUBPASS_CONTENTS_SECONDARY_COMMAND_BUFFERS,
    VK_SUBPASS_CONTENTS_RANGE_SIZE = (VK_SUBPASS_CONTENTS_SECONDARY_COMMAND_BUFFERS - VK_SUBPASS_CONTENTS_INLINE + 1),
    VK_SUBPASS_CONTENTS_MAX_ENUM = 0x7FFFFFFF
} VkSubpassContents;

typedef VkFlags VkInstanceCreateFlags;

typedef enum VkFormatFeatureFlagBits {
    VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT = 0x00000001,
    VK_FORMAT_FEATURE_STORAGE_IMAGE_BIT = 0x00000002,
    VK_FORMAT_FEATURE_STORAGE_IMAGE_ATOMIC_BIT = 0x00000004,
    VK_FORMAT_FEATURE_UNIFORM_TEXEL_BUFFER_BIT = 0x00000008,
    VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT = 0x00000010,
    VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_ATOMIC_BIT = 0x00000020,
    VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT = 0x00000040,
    VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT = 0x00000080,
    VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BLEND_BIT = 0x00000100,
    VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT = 0x00000200,
    VK_FORMAT_FEATURE_BLIT_SRC_BIT = 0x00000400,
    VK_FORMAT_FEATURE_BLIT_DST_BIT = 0x00000800,
    VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_LINEAR_BIT = 0x00001000,
    VK_FORMAT_FEATURE_SAMPLED_IMAGE_FILTER_CUBIC_BIT_IMG = 0x00002000,
    VK_FORMAT_FEATURE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkFormatFeatureFlagBits;
typedef VkFlags VkFormatFeatureFlags;

typedef enum VkImageUsageFlagBits {
    VK_IMAGE_USAGE_TRANSFER_SRC_BIT = 0x00000001,
    VK_IMAGE_USAGE_TRANSFER_DST_BIT = 0x00000002,
    VK_IMAGE_USAGE_SAMPLED_BIT = 0x00000004,
    VK_IMAGE_USAGE_STORAGE_BIT = 0x00000008,
    VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT = 0x00000010,
    VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT = 0x00000020,
    VK_IMAGE_USAGE_TRANSIENT_ATTACHMENT_BIT = 0x00000040,
    VK_IMAGE_USAGE_INPUT_ATTACHMENT_BIT = 0x00000080,
    VK_IMAGE_USAGE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkImageUsageFlagBits;
typedef VkFlags VkImageUsageFlags;

typedef enum VkImageCreateFlagBits {
    VK_IMAGE_CREATE_SPARSE_BINDING_BIT = 0x00000001,
    VK_IMAGE_CREATE_SPARSE_RESIDENCY_BIT = 0x00000002,
    VK_IMAGE_CREATE_SPARSE_ALIASED_BIT = 0x00000004,
    VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT = 0x00000008,
    VK_IMAGE_CREATE_CUBE_COMPATIBLE_BIT = 0x00000010,
    VK_IMAGE_CREATE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkImageCreateFlagBits;
typedef VkFlags VkImageCreateFlags;

typedef enum VkSampleCountFlagBits {
    VK_SAMPLE_COUNT_1_BIT = 0x00000001,
    VK_SAMPLE_COUNT_2_BIT = 0x00000002,
    VK_SAMPLE_COUNT_4_BIT = 0x00000004,
    VK_SAMPLE_COUNT_8_BIT = 0x00000008,
    VK_SAMPLE_COUNT_16_BIT = 0x00000010,
    VK_SAMPLE_COUNT_32_BIT = 0x00000020,
    VK_SAMPLE_COUNT_64_BIT = 0x00000040,
    VK_SAMPLE_COUNT_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkSampleCountFlagBits;
typedef VkFlags VkSampleCountFlags;

typedef enum VkQueueFlagBits {
    VK_QUEUE_GRAPHICS_BIT = 0x00000001,
    VK_QUEUE_COMPUTE_BIT = 0x00000002,
    VK_QUEUE_TRANSFER_BIT = 0x00000004,
    VK_QUEUE_SPARSE_BINDING_BIT = 0x00000008,
    VK_QUEUE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkQueueFlagBits;
typedef VkFlags VkQueueFlags;

typedef enum VkMemoryPropertyFlagBits {
    VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT = 0x00000001,
    VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT = 0x00000002,
    VK_MEMORY_PROPERTY_HOST_COHERENT_BIT = 0x00000004,
    VK_MEMORY_PROPERTY_HOST_CACHED_BIT = 0x00000008,
    VK_MEMORY_PROPERTY_LAZILY_ALLOCATED_BIT = 0x00000010,
    VK_MEMORY_PROPERTY_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkMemoryPropertyFlagBits;
typedef VkFlags VkMemoryPropertyFlags;

typedef enum VkMemoryHeapFlagBits {
    VK_MEMORY_HEAP_DEVICE_LOCAL_BIT = 0x00000001,
    VK_MEMORY_HEAP_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkMemoryHeapFlagBits;
typedef VkFlags VkMemoryHeapFlags;
typedef VkFlags VkDeviceCreateFlags;
typedef VkFlags VkDeviceQueueCreateFlags;

typedef enum VkPipelineStageFlagBits {
    VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT = 0x00000001,
    VK_PIPELINE_STAGE_DRAW_INDIRECT_BIT = 0x00000002,
    VK_PIPELINE_STAGE_VERTEX_INPUT_BIT = 0x00000004,
    VK_PIPELINE_STAGE_VERTEX_SHADER_BIT = 0x00000008,
    VK_PIPELINE_STAGE_TESSELLATION_CONTROL_SHADER_BIT = 0x00000010,
    VK_PIPELINE_STAGE_TESSELLATION_EVALUATION_SHADER_BIT = 0x00000020,
    VK_PIPELINE_STAGE_GEOMETRY_SHADER_BIT = 0x00000040,
    VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT = 0x00000080,
    VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT = 0x00000100,
    VK_PIPELINE_STAGE_LATE_FRAGMENT_TESTS_BIT = 0x00000200,
    VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT = 0x00000400,
    VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT = 0x00000800,
    VK_PIPELINE_STAGE_TRANSFER_BIT = 0x00001000,
    VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT = 0x00002000,
    VK_PIPELINE_STAGE_HOST_BIT = 0x00004000,
    VK_PIPELINE_STAGE_ALL_GRAPHICS_BIT = 0x00008000,
    VK_PIPELINE_STAGE_ALL_COMMANDS_BIT = 0x00010000,
    VK_PIPELINE_STAGE_COMMAND_PROCESS_BIT_NVX = 0x00020000,
    VK_PIPELINE_STAGE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkPipelineStageFlagBits;
typedef VkFlags VkPipelineStageFlags;
typedef VkFlags VkMemoryMapFlags;

typedef enum VkImageAspectFlagBits {
    VK_IMAGE_ASPECT_COLOR_BIT = 0x00000001,
    VK_IMAGE_ASPECT_DEPTH_BIT = 0x00000002,
    VK_IMAGE_ASPECT_STENCIL_BIT = 0x00000004,
    VK_IMAGE_ASPECT_METADATA_BIT = 0x00000008,
    VK_IMAGE_ASPECT_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkImageAspectFlagBits;
typedef VkFlags VkImageAspectFlags;

typedef enum VkSparseImageFormatFlagBits {
    VK_SPARSE_IMAGE_FORMAT_SINGLE_MIPTAIL_BIT = 0x00000001,
    VK_SPARSE_IMAGE_FORMAT_ALIGNED_MIP_SIZE_BIT = 0x00000002,
    VK_SPARSE_IMAGE_FORMAT_NONSTANDARD_BLOCK_SIZE_BIT = 0x00000004,
    VK_SPARSE_IMAGE_FORMAT_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkSparseImageFormatFlagBits;
typedef VkFlags VkSparseImageFormatFlags;

typedef enum VkSparseMemoryBindFlagBits {
    VK_SPARSE_MEMORY_BIND_METADATA_BIT = 0x00000001,
    VK_SPARSE_MEMORY_BIND_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkSparseMemoryBindFlagBits;
typedef VkFlags VkSparseMemoryBindFlags;

typedef enum VkFenceCreateFlagBits {
    VK_FENCE_CREATE_SIGNALED_BIT = 0x00000001,
    VK_FENCE_CREATE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkFenceCreateFlagBits;
typedef VkFlags VkFenceCreateFlags;
typedef VkFlags VkSemaphoreCreateFlags;
typedef VkFlags VkEventCreateFlags;
typedef VkFlags VkQueryPoolCreateFlags;

typedef enum VkQueryPipelineStatisticFlagBits {
    VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT = 0x00000001,
    VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT = 0x00000002,
    VK_QUERY_PIPELINE_STATISTIC_VERTEX_SHADER_INVOCATIONS_BIT = 0x00000004,
    VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_INVOCATIONS_BIT = 0x00000008,
    VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_PRIMITIVES_BIT = 0x00000010,
    VK_QUERY_PIPELINE_STATISTIC_CLIPPING_INVOCATIONS_BIT = 0x00000020,
    VK_QUERY_PIPELINE_STATISTIC_CLIPPING_PRIMITIVES_BIT = 0x00000040,
    VK_QUERY_PIPELINE_STATISTIC_FRAGMENT_SHADER_INVOCATIONS_BIT = 0x00000080,
    VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_CONTROL_SHADER_PATCHES_BIT = 0x00000100,
    VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_EVALUATION_SHADER_INVOCATIONS_BIT = 0x00000200,
    VK_QUERY_PIPELINE_STATISTIC_COMPUTE_SHADER_INVOCATIONS_BIT = 0x00000400,
    VK_QUERY_PIPELINE_STATISTIC_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkQueryPipelineStatisticFlagBits;
typedef VkFlags VkQueryPipelineStatisticFlags;

typedef enum VkQueryResultFlagBits {
    VK_QUERY_RESULT_64_BIT = 0x00000001,
    VK_QUERY_RESULT_WAIT_BIT = 0x00000002,
    VK_QUERY_RESULT_WITH_AVAILABILITY_BIT = 0x00000004,
    VK_QUERY_RESULT_PARTIAL_BIT = 0x00000008,
    VK_QUERY_RESULT_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkQueryResultFlagBits;
typedef VkFlags VkQueryResultFlags;

typedef enum VkBufferCreateFlagBits {
    VK_BUFFER_CREATE_SPARSE_BINDING_BIT = 0x00000001,
    VK_BUFFER_CREATE_SPARSE_RESIDENCY_BIT = 0x00000002,
    VK_BUFFER_CREATE_SPARSE_ALIASED_BIT = 0x00000004,
    VK_BUFFER_CREATE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkBufferCreateFlagBits;
typedef VkFlags VkBufferCreateFlags;

typedef enum VkBufferUsageFlagBits {
    VK_BUFFER_USAGE_TRANSFER_SRC_BIT = 0x00000001,
    VK_BUFFER_USAGE_TRANSFER_DST_BIT = 0x00000002,
    VK_BUFFER_USAGE_UNIFORM_TEXEL_BUFFER_BIT = 0x00000004,
    VK_BUFFER_USAGE_STORAGE_TEXEL_BUFFER_BIT = 0x00000008,
    VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT = 0x00000010,
    VK_BUFFER_USAGE_STORAGE_BUFFER_BIT = 0x00000020,
    VK_BUFFER_USAGE_INDEX_BUFFER_BIT = 0x00000040,
    VK_BUFFER_USAGE_VERTEX_BUFFER_BIT = 0x00000080,
    VK_BUFFER_USAGE_INDIRECT_BUFFER_BIT = 0x00000100,
    VK_BUFFER_USAGE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkBufferUsageFlagBits;
typedef VkFlags VkBufferUsageFlags;
typedef VkFlags VkBufferViewCreateFlags;
typedef VkFlags VkImageViewCreateFlags;
typedef VkFlags VkShaderModuleCreateFlags;
typedef VkFlags VkPipelineCacheCreateFlags;

typedef enum VkPipelineCreateFlagBits {
    VK_PIPELINE_CREATE_DISABLE_OPTIMIZATION_BIT = 0x00000001,
    VK_PIPELINE_CREATE_ALLOW_DERIVATIVES_BIT = 0x00000002,
    VK_PIPELINE_CREATE_DERIVATIVE_BIT = 0x00000004,
    VK_PIPELINE_CREATE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkPipelineCreateFlagBits;
typedef VkFlags VkPipelineCreateFlags;
typedef VkFlags VkPipelineShaderStageCreateFlags;

typedef enum VkShaderStageFlagBits {
    VK_SHADER_STAGE_VERTEX_BIT = 0x00000001,
    VK_SHADER_STAGE_TESSELLATION_CONTROL_BIT = 0x00000002,
    VK_SHADER_STAGE_TESSELLATION_EVALUATION_BIT = 0x00000004,
    VK_SHADER_STAGE_GEOMETRY_BIT = 0x00000008,
    VK_SHADER_STAGE_FRAGMENT_BIT = 0x00000010,
    VK_SHADER_STAGE_COMPUTE_BIT = 0x00000020,
    VK_SHADER_STAGE_ALL_GRAPHICS = 0x0000001F,
    VK_SHADER_STAGE_ALL = 0x7FFFFFFF,
    VK_SHADER_STAGE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkShaderStageFlagBits;
typedef VkFlags VkPipelineVertexInputStateCreateFlags;
typedef VkFlags VkPipelineInputAssemblyStateCreateFlags;
typedef VkFlags VkPipelineTessellationStateCreateFlags;
typedef VkFlags VkPipelineViewportStateCreateFlags;
typedef VkFlags VkPipelineRasterizationStateCreateFlags;

typedef enum VkCullModeFlagBits {
    VK_CULL_MODE_NONE = 0,
    VK_CULL_MODE_FRONT_BIT = 0x00000001,
    VK_CULL_MODE_BACK_BIT = 0x00000002,
    VK_CULL_MODE_FRONT_AND_BACK = 0x00000003,
    VK_CULL_MODE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkCullModeFlagBits;
typedef VkFlags VkCullModeFlags;
typedef VkFlags VkPipelineMultisampleStateCreateFlags;
typedef VkFlags VkPipelineDepthStencilStateCreateFlags;
typedef VkFlags VkPipelineColorBlendStateCreateFlags;

typedef enum VkColorComponentFlagBits {
    VK_COLOR_COMPONENT_R_BIT = 0x00000001,
    VK_COLOR_COMPONENT_G_BIT = 0x00000002,
    VK_COLOR_COMPONENT_B_BIT = 0x00000004,
    VK_COLOR_COMPONENT_A_BIT = 0x00000008,
    VK_COLOR_COMPONENT_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkColorComponentFlagBits;
typedef VkFlags VkColorComponentFlags;
typedef VkFlags VkPipelineDynamicStateCreateFlags;
typedef VkFlags VkPipelineLayoutCreateFlags;
typedef VkFlags VkShaderStageFlags;
typedef VkFlags VkSamplerCreateFlags;
typedef VkFlags VkDescriptorSetLayoutCreateFlags;

typedef enum VkDescriptorPoolCreateFlagBits {
    VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT = 0x00000001,
    VK_DESCRIPTOR_POOL_CREATE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkDescriptorPoolCreateFlagBits;
typedef VkFlags VkDescriptorPoolCreateFlags;
typedef VkFlags VkDescriptorPoolResetFlags;
typedef VkFlags VkFramebufferCreateFlags;
typedef VkFlags VkRenderPassCreateFlags;

typedef enum VkAttachmentDescriptionFlagBits {
    VK_ATTACHMENT_DESCRIPTION_MAY_ALIAS_BIT = 0x00000001,
    VK_ATTACHMENT_DESCRIPTION_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkAttachmentDescriptionFlagBits;
typedef VkFlags VkAttachmentDescriptionFlags;
typedef VkFlags VkSubpassDescriptionFlags;

typedef enum VkAccessFlagBits {
    VK_ACCESS_INDIRECT_COMMAND_READ_BIT = 0x00000001,
    VK_ACCESS_INDEX_READ_BIT = 0x00000002,
    VK_ACCESS_VERTEX_ATTRIBUTE_READ_BIT = 0x00000004,
    VK_ACCESS_UNIFORM_READ_BIT = 0x00000008,
    VK_ACCESS_INPUT_ATTACHMENT_READ_BIT = 0x00000010,
    VK_ACCESS_SHADER_READ_BIT = 0x00000020,
    VK_ACCESS_SHADER_WRITE_BIT = 0x00000040,
    VK_ACCESS_COLOR_ATTACHMENT_READ_BIT = 0x00000080,
    VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT = 0x00000100,
    VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT = 0x00000200,
    VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT = 0x00000400,
    VK_ACCESS_TRANSFER_READ_BIT = 0x00000800,
    VK_ACCESS_TRANSFER_WRITE_BIT = 0x00001000,
    VK_ACCESS_HOST_READ_BIT = 0x00002000,
    VK_ACCESS_HOST_WRITE_BIT = 0x00004000,
    VK_ACCESS_MEMORY_READ_BIT = 0x00008000,
    VK_ACCESS_MEMORY_WRITE_BIT = 0x00010000,
    VK_ACCESS_COMMAND_PROCESS_READ_BIT_NVX = 0x00020000,
    VK_ACCESS_COMMAND_PROCESS_WRITE_BIT_NVX = 0x00040000,
    VK_ACCESS_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkAccessFlagBits;
typedef VkFlags VkAccessFlags;

typedef enum VkDependencyFlagBits {
    VK_DEPENDENCY_BY_REGION_BIT = 0x00000001,
    VK_DEPENDENCY_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkDependencyFlagBits;
typedef VkFlags VkDependencyFlags;

typedef enum VkCommandPoolCreateFlagBits {
    VK_COMMAND_POOL_CREATE_TRANSIENT_BIT = 0x00000001,
    VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT = 0x00000002,
    VK_COMMAND_POOL_CREATE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkCommandPoolCreateFlagBits;
typedef VkFlags VkCommandPoolCreateFlags;

typedef enum VkCommandPoolResetFlagBits {
    VK_COMMAND_POOL_RESET_RELEASE_RESOURCES_BIT = 0x00000001,
    VK_COMMAND_POOL_RESET_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkCommandPoolResetFlagBits;
typedef VkFlags VkCommandPoolResetFlags;

typedef enum VkCommandBufferUsageFlagBits {
    VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT = 0x00000001,
    VK_COMMAND_BUFFER_USAGE_RENDER_PASS_CONTINUE_BIT = 0x00000002,
    VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT = 0x00000004,
    VK_COMMAND_BUFFER_USAGE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkCommandBufferUsageFlagBits;
typedef VkFlags VkCommandBufferUsageFlags;

typedef enum VkQueryControlFlagBits {
    VK_QUERY_CONTROL_PRECISE_BIT = 0x00000001,
    VK_QUERY_CONTROL_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkQueryControlFlagBits;
typedef VkFlags VkQueryControlFlags;

typedef enum VkCommandBufferResetFlagBits {
    VK_COMMAND_BUFFER_RESET_RELEASE_RESOURCES_BIT = 0x00000001,
    VK_COMMAND_BUFFER_RESET_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkCommandBufferResetFlagBits;
typedef VkFlags VkCommandBufferResetFlags;

typedef enum VkStencilFaceFlagBits {
    VK_STENCIL_FACE_FRONT_BIT = 0x00000001,
    VK_STENCIL_FACE_BACK_BIT = 0x00000002,
    VK_STENCIL_FRONT_AND_BACK = 0x00000003,
    VK_STENCIL_FACE_FLAG_BITS_MAX_ENUM = 0x7FFFFFFF
} VkStencilFaceFlagBits;
typedef VkFlags VkStencilFaceFlags;

typedef void* (VKAPI_PTR *PFN_vkAllocationFunction)(
    void*                                       pUserData,
    size_t                                      size,
    size_t                                      alignment,
    VkSystemAllocationScope                     allocationScope);

typedef void* (VKAPI_PTR *PFN_vkReallocationFunction)(
    void*                                       pUserData,
    void*                                       pOriginal,
    size_t                                      size,
    size_t                                      alignment,
    VkSystemAllocationScope                     allocationScope);

typedef void (VKAPI_PTR *PFN_vkFreeFunction)(
    void*                                       pUserData,
    void*                                       pMemory);

typedef void (VKAPI_PTR *PFN_vkInternalAllocationNotification)(
    void*                                       pUserData,
    size_t                                      size,
    VkInternalAllocationType                    allocationType,
    VkSystemAllocationScope                     allocationScope);

typedef void (VKAPI_PTR *PFN_vkInternalFreeNotification)(
    void*                                       pUserData,
    size_t                                      size,
    VkInternalAllocationType                    allocationType,
    VkSystemAllocationScope                     allocationScope);

typedef void (VKAPI_PTR *PFN_vkVoidFunction)(void);

typedef struct VkApplicationInfo {
    VkStructureType    sType;
    const void*        pNext;
    const char*        pApplicationName;
    uint32_t           applicationVersion;
    const char*        pEngineName;
    uint32_t           engineVersion;
    uint32_t           apiVersion;
} VkApplicationInfo;

typedef struct VkInstanceCreateInfo {
    VkStructureType             sType;
    const void*                 pNext;
    VkInstanceCreateFlags       flags;
    const VkApplicationInfo*    pApplicationInfo;
    uint32_t                    enabledLayerCount;
    const char* const*          ppEnabledLayerNames;
    uint32_t                    enabledExtensionCount;
    const char* const*          ppEnabledExtensionNames;
} VkInstanceCreateInfo;

typedef struct VkAllocationCallbacks {
    void*                                   pUserData;
    PFN_vkAllocationFunction                pfnAllocation;
    PFN_vkReallocationFunction              pfnReallocation;
    PFN_vkFreeFunction                      pfnFree;
    PFN_vkInternalAllocationNotification    pfnInternalAllocation;
    PFN_vkInternalFreeNotification          pfnInternalFree;
} VkAllocationCallbacks;

typedef struct VkPhysicalDeviceFeatures {
    VkBool32    robustBufferAccess;
    VkBool32    fullDrawIndexUint32;
    VkBool32    imageCubeArray;
    VkBool32    independentBlend;
    VkBool32    geometryShader;
    VkBool32    tessellationShader;
    VkBool32    sampleRateShading;
    VkBool32    dualSrcBlend;
    VkBool32    logicOp;
    VkBool32    multiDrawIndirect;
    VkBool32    drawIndirectFirstInstance;
    VkBool32    depthClamp;
    VkBool32    depthBiasClamp;
    VkBool32    fillModeNonSolid;
    VkBool32    depthBounds;
    VkBool32    wideLines;
    VkBool32    largePoints;
    VkBool32    alphaToOne;
    VkBool32    multiViewport;
    VkBool32    samplerAnisotropy;
    VkBool32    textureCompressionETC2;
    VkBool32    textureCompressionASTC_LDR;
    VkBool32    textureCompressionBC;
    VkBool32    occlusionQueryPrecise;
    VkBool32    pipelineStatisticsQuery;
    VkBool32    vertexPipelineStoresAndAtomics;
    VkBool32    fragmentStoresAndAtomics;
    VkBool32    shaderTessellationAndGeometryPointSize;
    VkBool32    shaderImageGatherExtended;
    VkBool32    shaderStorageImageExtendedFormats;
    VkBool32    shaderStorageImageMultisample;
    VkBool32    shaderStorageImageReadWithoutFormat;
    VkBool32    shaderStorageImageWriteWithoutFormat;
    VkBool32    shaderUniformBufferArrayDynamicIndexing;
    VkBool32    shaderSampledImageArrayDynamicIndexing;
    VkBool32    shaderStorageBufferArrayDynamicIndexing;
    VkBool32    shaderStorageImageArrayDynamicIndexing;
    VkBool32    shaderClipDistance;
    VkBool32    shaderCullDistance;
    VkBool32    shaderFloat64;
    VkBool32    shaderInt64;
    VkBool32    shaderInt16;
    VkBool32    shaderResourceResidency;
    VkBool32    shaderResourceMinLod;
    VkBool32    sparseBinding;
    VkBool32    sparseResidencyBuffer;
    VkBool32    sparseResidencyImage2D;
    VkBool32    sparseResidencyImage3D;
    VkBool32    sparseResidency2Samples;
    VkBool32    sparseResidency4Samples;
    VkBool32    sparseResidency8Samples;
    VkBool32    sparseResidency16Samples;
    VkBool32    sparseResidencyAliased;
    VkBool32    variableMultisampleRate;
    VkBool32    inheritedQueries;
} VkPhysicalDeviceFeatures;

typedef struct VkFormatProperties {
    VkFormatFeatureFlags    linearTilingFeatures;
    VkFormatFeatureFlags    optimalTilingFeatures;
    VkFormatFeatureFlags    bufferFeatures;
} VkFormatProperties;

typedef struct VkExtent3D {
    uint32_t    width;
    uint32_t    height;
    uint32_t    depth;
} VkExtent3D;

typedef struct VkImageFormatProperties {
    VkExtent3D            maxExtent;
    uint32_t              maxMipLevels;
    uint32_t              maxArrayLayers;
    VkSampleCountFlags    sampleCounts;
    VkDeviceSize          maxResourceSize;
} VkImageFormatProperties;

typedef struct VkPhysicalDeviceLimits {
    uint32_t              maxImageDimension1D;
    uint32_t              maxImageDimension2D;
    uint32_t              maxImageDimension3D;
    uint32_t              maxImageDimensionCube;
    uint32_t              maxImageArrayLayers;
    uint32_t              maxTexelBufferElements;
    uint32_t              maxUniformBufferRange;
    uint32_t              maxStorageBufferRange;
    uint32_t              maxPushConstantsSize;
    uint32_t              maxMemoryAllocationCount;
    uint32_t              maxSamplerAllocationCount;
    VkDeviceSize          bufferImageGranularity;
    VkDeviceSize          sparseAddressSpaceSize;
    uint32_t              maxBoundDescriptorSets;
    uint32_t              maxPerStageDescriptorSamplers;
    uint32_t              maxPerStageDescriptorUniformBuffers;
    uint32_t              maxPerStageDescriptorStorageBuffers;
    uint32_t              maxPerStageDescriptorSampledImages;
    uint32_t              maxPerStageDescriptorStorageImages;
    uint32_t              maxPerStageDescriptorInputAttachments;
    uint32_t              maxPerStageResources;
    uint32_t              maxDescriptorSetSamplers;
    uint32_t              maxDescriptorSetUniformBuffers;
    uint32_t              maxDescriptorSetUniformBuffersDynamic;
    uint32_t              maxDescriptorSetStorageBuffers;
    uint32_t              maxDescriptorSetStorageBuffersDynamic;
    uint32_t              maxDescriptorSetSampledImages;
    uint32_t              maxDescriptorSetStorageImages;
    uint32_t              maxDescriptorSetInputAttachments;
    uint32_t              maxVertexInputAttributes;
    uint32_t              maxVertexInputBindings;
    uint32_t              maxVertexInputAttributeOffset;
    uint32_t              maxVertexInputBindingStride;
    uint32_t              maxVertexOutputComponents;
    uint32_t              maxTessellationGenerationLevel;
    uint32_t              maxTessellationPatchSize;
    uint32_t              maxTessellationControlPerVertexInputComponents;
    uint32_t              maxTessellationControlPerVertexOutputComponents;
    uint32_t              maxTessellationControlPerPatchOutputComponents;
    uint32_t              maxTessellationControlTotalOutputComponents;
    uint32_t              maxTessellationEvaluationInputComponents;
    uint32_t              maxTessellationEvaluationOutputComponents;
    uint32_t              maxGeometryShaderInvocations;
    uint32_t              maxGeometryInputComponents;
    uint32_t              maxGeometryOutputComponents;
    uint32_t              maxGeometryOutputVertices;
    uint32_t              maxGeometryTotalOutputComponents;
    uint32_t              maxFragmentInputComponents;
    uint32_t              maxFragmentOutputAttachments;
    uint32_t              maxFragmentDualSrcAttachments;
    uint32_t              maxFragmentCombinedOutputResources;
    uint32_t              maxComputeSharedMemorySize;
    uint32_t              maxComputeWorkGroupCount[3];
    uint32_t              maxComputeWorkGroupInvocations;
    uint32_t              maxComputeWorkGroupSize[3];
    uint32_t              subPixelPrecisionBits;
    uint32_t              subTexelPrecisionBits;
    uint32_t              mipmapPrecisionBits;
    uint32_t              maxDrawIndexedIndexValue;
    uint32_t              maxDrawIndirectCount;
    float                 maxSamplerLodBias;
    float                 maxSamplerAnisotropy;
    uint32_t              maxViewports;
    uint32_t              maxViewportDimensions[2];
    float                 viewportBoundsRange[2];
    uint32_t              viewportSubPixelBits;
    size_t                minMemoryMapAlignment;
    VkDeviceSize          minTexelBufferOffsetAlignment;
    VkDeviceSize          minUniformBufferOffsetAlignment;
    VkDeviceSize          minStorageBufferOffsetAlignment;
    int32_t               minTexelOffset;
    uint32_t              maxTexelOffset;
    int32_t               minTexelGatherOffset;
    uint32_t              maxTexelGatherOffset;
    float                 minInterpolationOffset;
    float                 maxInterpolationOffset;
    uint32_t              subPixelInterpolationOffsetBits;
    uint32_t              maxFramebufferWidth;
    uint32_t              maxFramebufferHeight;
    uint32_t              maxFramebufferLayers;
    VkSampleCountFlags    framebufferColorSampleCounts;
    VkSampleCountFlags    framebufferDepthSampleCounts;
    VkSampleCountFlags    framebufferStencilSampleCounts;
    VkSampleCountFlags    framebufferNoAttachmentsSampleCounts;
    uint32_t              maxColorAttachments;
    VkSampleCountFlags    sampledImageColorSampleCounts;
    VkSampleCountFlags    sampledImageIntegerSampleCounts;
    VkSampleCountFlags    sampledImageDepthSampleCounts;
    VkSampleCountFlags    sampledImageStencilSampleCounts;
    VkSampleCountFlags    storageImageSampleCounts;
    uint32_t              maxSampleMaskWords;
    VkBool32              timestampComputeAndGraphics;
    float                 timestampPeriod;
    uint32_t              maxClipDistances;
    uint32_t              maxCullDistances;
    uint32_t              maxCombinedClipAndCullDistances;
    uint32_t              discreteQueuePriorities;
    float                 pointSizeRange[2];
    float                 lineWidthRange[2];
    float                 pointSizeGranularity;
    float                 lineWidthGranularity;
    VkBool32              strictLines;
    VkBool32              standardSampleLocations;
    VkDeviceSize          optimalBufferCopyOffsetAlignment;
    VkDeviceSize          optimalBufferCopyRowPitchAlignment;
    VkDeviceSize          nonCoherentAtomSize;
} VkPhysicalDeviceLimits;

typedef struct VkPhysicalDeviceSparseProperties {
    VkBool32    residencyStandard2DBlockShape;
    VkBool32    residencyStandard2DMultisampleBlockShape;
    VkBool32    residencyStandard3DBlockShape;
    VkBool32    residencyAlignedMipSize;
    VkBool32    residencyNonResidentStrict;
} VkPhysicalDeviceSparseProperties;

typedef struct VkPhysicalDeviceProperties {
    uint32_t                            apiVersion;
    uint32_t                            driverVersion;
    uint32_t                            vendorID;
    uint32_t                            deviceID;
    VkPhysicalDeviceType                deviceType;
    char                                deviceName[VK_MAX_PHYSICAL_DEVICE_NAME_SIZE];
    uint8_t                             pipelineCacheUUID[VK_UUID_SIZE];
    VkPhysicalDeviceLimits              limits;
    VkPhysicalDeviceSparseProperties    sparseProperties;
} VkPhysicalDeviceProperties;

typedef struct VkQueueFamilyProperties {
    VkQueueFlags    queueFlags;
    uint32_t        queueCount;
    uint32_t        timestampValidBits;
    VkExtent3D      minImageTransferGranularity;
} VkQueueFamilyProperties;

typedef struct VkMemoryType {
    VkMemoryPropertyFlags    propertyFlags;
    uint32_t                 heapIndex;
} VkMemoryType;

typedef struct VkMemoryHeap {
    VkDeviceSize         size;
    VkMemoryHeapFlags    flags;
} VkMemoryHeap;

typedef struct VkPhysicalDeviceMemoryProperties {
    uint32_t        memoryTypeCount;
    VkMemoryType    memoryTypes[VK_MAX_MEMORY_TYPES];
    uint32_t        memoryHeapCount;
    VkMemoryHeap    memoryHeaps[VK_MAX_MEMORY_HEAPS];
} VkPhysicalDeviceMemoryProperties;

typedef struct VkDeviceQueueCreateInfo {
    VkStructureType             sType;
    const void*                 pNext;
    VkDeviceQueueCreateFlags    flags;
    uint32_t                    queueFamilyIndex;
    uint32_t                    queueCount;
    const float*                pQueuePriorities;
} VkDeviceQueueCreateInfo;

typedef struct VkDeviceCreateInfo {
    VkStructureType                    sType;
    const void*                        pNext;
    VkDeviceCreateFlags                flags;
    uint32_t                           queueCreateInfoCount;
    const VkDeviceQueueCreateInfo*     pQueueCreateInfos;
    uint32_t                           enabledLayerCount;
    const char* const*                 ppEnabledLayerNames;
    uint32_t                           enabledExtensionCount;
    const char* const*                 ppEnabledExtensionNames;
    const VkPhysicalDeviceFeatures*    pEnabledFeatures;
} VkDeviceCreateInfo;

typedef struct VkExtensionProperties {
    char        extensionName[VK_MAX_EXTENSION_NAME_SIZE];
    uint32_t    specVersion;
} VkExtensionProperties;

typedef struct VkLayerProperties {
    char        layerName[VK_MAX_EXTENSION_NAME_SIZE];
    uint32_t    specVersion;
    uint32_t    implementationVersion;
    char        description[VK_MAX_DESCRIPTION_SIZE];
} VkLayerProperties;

typedef struct VkSubmitInfo {
    VkStructureType                sType;
    const void*                    pNext;
    uint32_t                       waitSemaphoreCount;
    const VkSemaphore*             pWaitSemaphores;
    const VkPipelineStageFlags*    pWaitDstStageMask;
    uint32_t                       commandBufferCount;
    const VkCommandBuffer*         pCommandBuffers;
    uint32_t                       signalSemaphoreCount;
    const VkSemaphore*             pSignalSemaphores;
} VkSubmitInfo;

typedef struct VkMemoryAllocateInfo {
    VkStructureType    sType;
    const void*        pNext;
    VkDeviceSize       allocationSize;
    uint32_t           memoryTypeIndex;
} VkMemoryAllocateInfo;

typedef struct VkMappedMemoryRange {
    VkStructureType    sType;
    const void*        pNext;
    VkDeviceMemory     memory;
    VkDeviceSize       offset;
    VkDeviceSize       size;
} VkMappedMemoryRange;

typedef struct VkMemoryRequirements {
    VkDeviceSize    size;
    VkDeviceSize    alignment;
    uint32_t        memoryTypeBits;
} VkMemoryRequirements;

typedef struct VkSparseImageFormatProperties {
    VkImageAspectFlags          aspectMask;
    VkExtent3D                  imageGranularity;
    VkSparseImageFormatFlags    flags;
} VkSparseImageFormatProperties;

typedef struct VkSparseImageMemoryRequirements {
    VkSparseImageFormatProperties    formatProperties;
    uint32_t                         imageMipTailFirstLod;
    VkDeviceSize                     imageMipTailSize;
    VkDeviceSize                     imageMipTailOffset;
    VkDeviceSize                     imageMipTailStride;
} VkSparseImageMemoryRequirements;

typedef struct VkSparseMemoryBind {
    VkDeviceSize               resourceOffset;
    VkDeviceSize               size;
    VkDeviceMemory             memory;
    VkDeviceSize               memoryOffset;
    VkSparseMemoryBindFlags    flags;
} VkSparseMemoryBind;

typedef struct VkSparseBufferMemoryBindInfo {
    VkBuffer                     buffer;
    uint32_t                     bindCount;
    const VkSparseMemoryBind*    pBinds;
} VkSparseBufferMemoryBindInfo;

typedef struct VkSparseImageOpaqueMemoryBindInfo {
    VkImage                      image;
    uint32_t                     bindCount;
    const VkSparseMemoryBind*    pBinds;
} VkSparseImageOpaqueMemoryBindInfo;

typedef struct VkImageSubresource {
    VkImageAspectFlags    aspectMask;
    uint32_t              mipLevel;
    uint32_t              arrayLayer;
} VkImageSubresource;

typedef struct VkOffset3D {
    int32_t    x;
    int32_t    y;
    int32_t    z;
} VkOffset3D;

typedef struct VkSparseImageMemoryBind {
    VkImageSubresource         subresource;
    VkOffset3D                 offset;
    VkExtent3D                 extent;
    VkDeviceMemory             memory;
    VkDeviceSize               memoryOffset;
    VkSparseMemoryBindFlags    flags;
} VkSparseImageMemoryBind;

typedef struct VkSparseImageMemoryBindInfo {
    VkImage                           image;
    uint32_t                          bindCount;
    const VkSparseImageMemoryBind*    pBinds;
} VkSparseImageMemoryBindInfo;

typedef struct VkBindSparseInfo {
    VkStructureType                             sType;
    const void*                                 pNext;
    uint32_t                                    waitSemaphoreCount;
    const VkSemaphore*                          pWaitSemaphores;
    uint32_t                                    bufferBindCount;
    const VkSparseBufferMemoryBindInfo*         pBufferBinds;
    uint32_t                                    imageOpaqueBindCount;
    const VkSparseImageOpaqueMemoryBindInfo*    pImageOpaqueBinds;
    uint32_t                                    imageBindCount;
    const VkSparseImageMemoryBindInfo*          pImageBinds;
    uint32_t                                    signalSemaphoreCount;
    const VkSemaphore*                          pSignalSemaphores;
} VkBindSparseInfo;

typedef struct VkFenceCreateInfo {
    VkStructureType       sType;
    const void*           pNext;
    VkFenceCreateFlags    flags;
} VkFenceCreateInfo;

typedef struct VkSemaphoreCreateInfo {
    VkStructureType           sType;
    const void*               pNext;
    VkSemaphoreCreateFlags    flags;
} VkSemaphoreCreateInfo;

typedef struct VkEventCreateInfo {
    VkStructureType       sType;
    const void*           pNext;
    VkEventCreateFlags    flags;
} VkEventCreateInfo;

typedef struct VkQueryPoolCreateInfo {
    VkStructureType                  sType;
    const void*                      pNext;
    VkQueryPoolCreateFlags           flags;
    VkQueryType                      queryType;
    uint32_t                         queryCount;
    VkQueryPipelineStatisticFlags    pipelineStatistics;
} VkQueryPoolCreateInfo;

typedef struct VkBufferCreateInfo {
    VkStructureType        sType;
    const void*            pNext;
    VkBufferCreateFlags    flags;
    VkDeviceSize           size;
    VkBufferUsageFlags     usage;
    VkSharingMode          sharingMode;
    uint32_t               queueFamilyIndexCount;
    const uint32_t*        pQueueFamilyIndices;
} VkBufferCreateInfo;

typedef struct VkBufferViewCreateInfo {
    VkStructureType            sType;
    const void*                pNext;
    VkBufferViewCreateFlags    flags;
    VkBuffer                   buffer;
    VkFormat                   format;
    VkDeviceSize               offset;
    VkDeviceSize               range;
} VkBufferViewCreateInfo;

typedef struct VkImageCreateInfo {
    VkStructureType          sType;
    const void*              pNext;
    VkImageCreateFlags       flags;
    VkImageType              imageType;
    VkFormat                 format;
    VkExtent3D               extent;
    uint32_t                 mipLevels;
    uint32_t                 arrayLayers;
    VkSampleCountFlagBits    samples;
    VkImageTiling            tiling;
    VkImageUsageFlags        usage;
    VkSharingMode            sharingMode;
    uint32_t                 queueFamilyIndexCount;
    const uint32_t*          pQueueFamilyIndices;
    VkImageLayout            initialLayout;
} VkImageCreateInfo;

typedef struct VkSubresourceLayout {
    VkDeviceSize    offset;
    VkDeviceSize    size;
    VkDeviceSize    rowPitch;
    VkDeviceSize    arrayPitch;
    VkDeviceSize    depthPitch;
} VkSubresourceLayout;

typedef struct VkComponentMapping {
    VkComponentSwizzle    r;
    VkComponentSwizzle    g;
    VkComponentSwizzle    b;
    VkComponentSwizzle    a;
} VkComponentMapping;

typedef struct VkImageSubresourceRange {
    VkImageAspectFlags    aspectMask;
    uint32_t              baseMipLevel;
    uint32_t              levelCount;
    uint32_t              baseArrayLayer;
    uint32_t              layerCount;
} VkImageSubresourceRange;

typedef struct VkImageViewCreateInfo {
    VkStructureType            sType;
    const void*                pNext;
    VkImageViewCreateFlags     flags;
    VkImage                    image;
    VkImageViewType            viewType;
    VkFormat                   format;
    VkComponentMapping         components;
    VkImageSubresourceRange    subresourceRange;
} VkImageViewCreateInfo;

typedef struct VkShaderModuleCreateInfo {
    VkStructureType              sType;
    const void*                  pNext;
    VkShaderModuleCreateFlags    flags;
    size_t                       codeSize;
    const uint32_t*              pCode;
} VkShaderModuleCreateInfo;

typedef struct VkPipelineCacheCreateInfo {
    VkStructureType               sType;
    const void*                   pNext;
    VkPipelineCacheCreateFlags    flags;
    size_t                        initialDataSize;
    const void*                   pInitialData;
} VkPipelineCacheCreateInfo;

typedef struct VkSpecializationMapEntry {
    uint32_t    constantID;
    uint32_t    offset;
    size_t      size;
} VkSpecializationMapEntry;

typedef struct VkSpecializationInfo {
    uint32_t                           mapEntryCount;
    const VkSpecializationMapEntry*    pMapEntries;
    size_t                             dataSize;
    const void*                        pData;
} VkSpecializationInfo;

typedef struct VkPipelineShaderStageCreateInfo {
    VkStructureType                     sType;
    const void*                         pNext;
    VkPipelineShaderStageCreateFlags    flags;
    VkShaderStageFlagBits               stage;
    VkShaderModule                      module;
    const char*                         pName;
    const VkSpecializationInfo*         pSpecializationInfo;
} VkPipelineShaderStageCreateInfo;

typedef struct VkVertexInputBindingDescription {
    uint32_t             binding;
    uint32_t             stride;
    VkVertexInputRate    inputRate;
} VkVertexInputBindingDescription;

typedef struct VkVertexInputAttributeDescription {
    uint32_t    location;
    uint32_t    binding;
    VkFormat    format;
    uint32_t    offset;
} VkVertexInputAttributeDescription;

typedef struct VkPipelineVertexInputStateCreateInfo {
    VkStructureType                             sType;
    const void*                                 pNext;
    VkPipelineVertexInputStateCreateFlags       flags;
    uint32_t                                    vertexBindingDescriptionCount;
    const VkVertexInputBindingDescription*      pVertexBindingDescriptions;
    uint32_t                                    vertexAttributeDescriptionCount;
    const VkVertexInputAttributeDescription*    pVertexAttributeDescriptions;
} VkPipelineVertexInputStateCreateInfo;

typedef struct VkPipelineInputAssemblyStateCreateInfo {
    VkStructureType                            sType;
    const void*                                pNext;
    VkPipelineInputAssemblyStateCreateFlags    flags;
    VkPrimitiveTopology                        topology;
    VkBool32                                   primitiveRestartEnable;
} VkPipelineInputAssemblyStateCreateInfo;

typedef struct VkPipelineTessellationStateCreateInfo {
    VkStructureType                           sType;
    const void*                               pNext;
    VkPipelineTessellationStateCreateFlags    flags;
    uint32_t                                  patchControlPoints;
} VkPipelineTessellationStateCreateInfo;

typedef struct VkViewport {
    float    x;
    float    y;
    float    width;
    float    height;
    float    minDepth;
    float    maxDepth;
} VkViewport;

typedef struct VkOffset2D {
    int32_t    x;
    int32_t    y;
} VkOffset2D;

typedef struct VkExtent2D {
    uint32_t    width;
    uint32_t    height;
} VkExtent2D;

typedef struct VkRect2D {
    VkOffset2D    offset;
    VkExtent2D    extent;
} VkRect2D;

typedef struct VkPipelineViewportStateCreateInfo {
    VkStructureType                       sType;
    const void*                           pNext;
    VkPipelineViewportStateCreateFlags    flags;
    uint32_t                              viewportCount;
    const VkViewport*                     pViewports;
    uint32_t                              scissorCount;
    const VkRect2D*                       pScissors;
} VkPipelineViewportStateCreateInfo;

typedef struct VkPipelineRasterizationStateCreateInfo {
    VkStructureType                            sType;
    const void*                                pNext;
    VkPipelineRasterizationStateCreateFlags    flags;
    VkBool32                                   depthClampEnable;
    VkBool32                                   rasterizerDiscardEnable;
    VkPolygonMode                              polygonMode;
    VkCullModeFlags                            cullMode;
    VkFrontFace                                frontFace;
    VkBool32                                   depthBiasEnable;
    float                                      depthBiasConstantFactor;
    float                                      depthBiasClamp;
    float                                      depthBiasSlopeFactor;
    float                                      lineWidth;
} VkPipelineRasterizationStateCreateInfo;

typedef struct VkPipelineMultisampleStateCreateInfo {
    VkStructureType                          sType;
    const void*                              pNext;
    VkPipelineMultisampleStateCreateFlags    flags;
    VkSampleCountFlagBits                    rasterizationSamples;
    VkBool32                                 sampleShadingEnable;
    float                                    minSampleShading;
    const VkSampleMask*                      pSampleMask;
    VkBool32                                 alphaToCoverageEnable;
    VkBool32                                 alphaToOneEnable;
} VkPipelineMultisampleStateCreateInfo;

typedef struct VkStencilOpState {
    VkStencilOp    failOp;
    VkStencilOp    passOp;
    VkStencilOp    depthFailOp;
    VkCompareOp    compareOp;
    uint32_t       compareMask;
    uint32_t       writeMask;
    uint32_t       reference;
} VkStencilOpState;

typedef struct VkPipelineDepthStencilStateCreateInfo {
    VkStructureType                           sType;
    const void*                               pNext;
    VkPipelineDepthStencilStateCreateFlags    flags;
    VkBool32                                  depthTestEnable;
    VkBool32                                  depthWriteEnable;
    VkCompareOp                               depthCompareOp;
    VkBool32                                  depthBoundsTestEnable;
    VkBool32                                  stencilTestEnable;
    VkStencilOpState                          front;
    VkStencilOpState                          back;
    float                                     minDepthBounds;
    float                                     maxDepthBounds;
} VkPipelineDepthStencilStateCreateInfo;

typedef struct VkPipelineColorBlendAttachmentState {
    VkBool32                 blendEnable;
    VkBlendFactor            srcColorBlendFactor;
    VkBlendFactor            dstColorBlendFactor;
    VkBlendOp                colorBlendOp;
    VkBlendFactor            srcAlphaBlendFactor;
    VkBlendFactor            dstAlphaBlendFactor;
    VkBlendOp                alphaBlendOp;
    VkColorComponentFlags    colorWriteMask;
} VkPipelineColorBlendAttachmentState;

typedef struct VkPipelineColorBlendStateCreateInfo {
    VkStructureType                               sType;
    const void*                                   pNext;
    VkPipelineColorBlendStateCreateFlags          flags;
    VkBool32                                      logicOpEnable;
    VkLogicOp                                     logicOp;
    uint32_t                                      attachmentCount;
    const VkPipelineColorBlendAttachmentState*    pAttachments;
    float                                         blendConstants[4];
} VkPipelineColorBlendStateCreateInfo;

typedef struct VkPipelineDynamicStateCreateInfo {
    VkStructureType                      sType;
    const void*                          pNext;
    VkPipelineDynamicStateCreateFlags    flags;
    uint32_t                             dynamicStateCount;
    const VkDynamicState*                pDynamicStates;
} VkPipelineDynamicStateCreateInfo;

typedef struct VkGraphicsPipelineCreateInfo {
    VkStructureType                                  sType;
    const void*                                      pNext;
    VkPipelineCreateFlags                            flags;
    uint32_t                                         stageCount;
    const VkPipelineShaderStageCreateInfo*           pStages;
    const VkPipelineVertexInputStateCreateInfo*      pVertexInputState;
    const VkPipelineInputAssemblyStateCreateInfo*    pInputAssemblyState;
    const VkPipelineTessellationStateCreateInfo*     pTessellationState;
    const VkPipelineViewportStateCreateInfo*         pViewportState;
    const VkPipelineRasterizationStateCreateInfo*    pRasterizationState;
    const VkPipelineMultisampleStateCreateInfo*      pMultisampleState;
    const VkPipelineDepthStencilStateCreateInfo*     pDepthStencilState;
    const VkPipelineColorBlendStateCreateInfo*       pColorBlendState;
    const VkPipelineDynamicStateCreateInfo*          pDynamicState;
    VkPipelineLayout                                 layout;
    VkRenderPass                                     renderPass;
    uint32_t                                         subpass;
    VkPipeline                                       basePipelineHandle;
    int32_t                                          basePipelineIndex;
} VkGraphicsPipelineCreateInfo;

typedef struct VkComputePipelineCreateInfo {
    VkStructureType                    sType;
    const void*                        pNext;
    VkPipelineCreateFlags              flags;
    VkPipelineShaderStageCreateInfo    stage;
    VkPipelineLayout                   layout;
    VkPipeline                         basePipelineHandle;
    int32_t                            basePipelineIndex;
} VkComputePipelineCreateInfo;

typedef struct VkPushConstantRange {
    VkShaderStageFlags    stageFlags;
    uint32_t              offset;
    uint32_t              size;
} VkPushConstantRange;

typedef struct VkPipelineLayoutCreateInfo {
    VkStructureType                 sType;
    const void*                     pNext;
    VkPipelineLayoutCreateFlags     flags;
    uint32_t                        setLayoutCount;
    const VkDescriptorSetLayout*    pSetLayouts;
    uint32_t                        pushConstantRangeCount;
    const VkPushConstantRange*      pPushConstantRanges;
} VkPipelineLayoutCreateInfo;

typedef struct VkSamplerCreateInfo {
    VkStructureType         sType;
    const void*             pNext;
    VkSamplerCreateFlags    flags;
    VkFilter                magFilter;
    VkFilter                minFilter;
    VkSamplerMipmapMode     mipmapMode;
    VkSamplerAddressMode    addressModeU;
    VkSamplerAddressMode    addressModeV;
    VkSamplerAddressMode    addressModeW;
    float                   mipLodBias;
    VkBool32                anisotropyEnable;
    float                   maxAnisotropy;
    VkBool32                compareEnable;
    VkCompareOp             compareOp;
    float                   minLod;
    float                   maxLod;
    VkBorderColor           borderColor;
    VkBool32                unnormalizedCoordinates;
} VkSamplerCreateInfo;

typedef struct VkDescriptorSetLayoutBinding {
    uint32_t              binding;
    VkDescriptorType      descriptorType;
    uint32_t              descriptorCount;
    VkShaderStageFlags    stageFlags;
    const VkSampler*      pImmutableSamplers;
} VkDescriptorSetLayoutBinding;

typedef struct VkDescriptorSetLayoutCreateInfo {
    VkStructureType                        sType;
    const void*                            pNext;
    VkDescriptorSetLayoutCreateFlags       flags;
    uint32_t                               bindingCount;
    const VkDescriptorSetLayoutBinding*    pBindings;
} VkDescriptorSetLayoutCreateInfo;

typedef struct VkDescriptorPoolSize {
    VkDescriptorType    type;
    uint32_t            descriptorCount;
} VkDescriptorPoolSize;

typedef struct VkDescriptorPoolCreateInfo {
    VkStructureType                sType;
    const void*                    pNext;
    VkDescriptorPoolCreateFlags    flags;
    uint32_t                       maxSets;
    uint32_t                       poolSizeCount;
    const VkDescriptorPoolSize*    pPoolSizes;
} VkDescriptorPoolCreateInfo;

typedef struct VkDescriptorSetAllocateInfo {
    VkStructureType                 sType;
    const void*                     pNext;
    VkDescriptorPool                descriptorPool;
    uint32_t                        descriptorSetCount;
    const VkDescriptorSetLayout*    pSetLayouts;
} VkDescriptorSetAllocateInfo;

typedef struct VkDescriptorImageInfo {
    VkSampler        sampler;
    VkImageView      imageView;
    VkImageLayout    imageLayout;
} VkDescriptorImageInfo;

typedef struct VkDescriptorBufferInfo {
    VkBuffer        buffer;
    VkDeviceSize    offset;
    VkDeviceSize    range;
} VkDescriptorBufferInfo;

typedef struct VkWriteDescriptorSet {
    VkStructureType                  sType;
    const void*                      pNext;
    VkDescriptorSet                  dstSet;
    uint32_t                         dstBinding;
    uint32_t                         dstArrayElement;
    uint32_t                         descriptorCount;
    VkDescriptorType                 descriptorType;
    const VkDescriptorImageInfo*     pImageInfo;
    const VkDescriptorBufferInfo*    pBufferInfo;
    const VkBufferView*              pTexelBufferView;
} VkWriteDescriptorSet;

typedef struct VkCopyDescriptorSet {
    VkStructureType    sType;
    const void*        pNext;
    VkDescriptorSet    srcSet;
    uint32_t           srcBinding;
    uint32_t           srcArrayElement;
    VkDescriptorSet    dstSet;
    uint32_t           dstBinding;
    uint32_t           dstArrayElement;
    uint32_t           descriptorCount;
} VkCopyDescriptorSet;

typedef struct VkFramebufferCreateInfo {
    VkStructureType             sType;
    const void*                 pNext;
    VkFramebufferCreateFlags    flags;
    VkRenderPass                renderPass;
    uint32_t                    attachmentCount;
    const VkImageView*          pAttachments;
    uint32_t                    width;
    uint32_t                    height;
    uint32_t                    layers;
} VkFramebufferCreateInfo;

typedef struct VkAttachmentDescription {
    VkAttachmentDescriptionFlags    flags;
    VkFormat                        format;
    VkSampleCountFlagBits           samples;
    VkAttachmentLoadOp              loadOp;
    VkAttachmentStoreOp             storeOp;
    VkAttachmentLoadOp              stencilLoadOp;
    VkAttachmentStoreOp             stencilStoreOp;
    VkImageLayout                   initialLayout;
    VkImageLayout                   finalLayout;
} VkAttachmentDescription;

typedef struct VkAttachmentReference {
    uint32_t         attachment;
    VkImageLayout    layout;
} VkAttachmentReference;

typedef struct VkSubpassDescription {
    VkSubpassDescriptionFlags       flags;
    VkPipelineBindPoint             pipelineBindPoint;
    uint32_t                        inputAttachmentCount;
    const VkAttachmentReference*    pInputAttachments;
    uint32_t                        colorAttachmentCount;
    const VkAttachmentReference*    pColorAttachments;
    const VkAttachmentReference*    pResolveAttachments;
    const VkAttachmentReference*    pDepthStencilAttachment;
    uint32_t                        preserveAttachmentCount;
    const uint32_t*                 pPreserveAttachments;
} VkSubpassDescription;

typedef struct VkSubpassDependency {
    uint32_t                srcSubpass;
    uint32_t                dstSubpass;
    VkPipelineStageFlags    srcStageMask;
    VkPipelineStageFlags    dstStageMask;
    VkAccessFlags           srcAccessMask;
    VkAccessFlags           dstAccessMask;
    VkDependencyFlags       dependencyFlags;
} VkSubpassDependency;

typedef struct VkRenderPassCreateInfo {
    VkStructureType                   sType;
    const void*                       pNext;
    VkRenderPassCreateFlags           flags;
    uint32_t                          attachmentCount;
    const VkAttachmentDescription*    pAttachments;
    uint32_t                          subpassCount;
    const VkSubpassDescription*       pSubpasses;
    uint32_t                          dependencyCount;
    const VkSubpassDependency*        pDependencies;
} VkRenderPassCreateInfo;

typedef struct VkCommandPoolCreateInfo {
    VkStructureType             sType;
    const void*                 pNext;
    VkCommandPoolCreateFlags    flags;
    uint32_t                    queueFamilyIndex;
} VkCommandPoolCreateInfo;

typedef struct VkCommandBufferAllocateInfo {
    VkStructureType         sType;
    const void*             pNext;
    VkCommandPool           commandPool;
    VkCommandBufferLevel    level;
    uint32_t                commandBufferCount;
} VkCommandBufferAllocateInfo;

typedef struct VkCommandBufferInheritanceInfo {
    VkStructureType                  sType;
    const void*                      pNext;
    VkRenderPass                     renderPass;
    uint32_t                         subpass;
    VkFramebuffer                    framebuffer;
    VkBool32                         occlusionQueryEnable;
    VkQueryControlFlags              queryFlags;
    VkQueryPipelineStatisticFlags    pipelineStatistics;
} VkCommandBufferInheritanceInfo;

typedef struct VkCommandBufferBeginInfo {
    VkStructureType                          sType;
    const void*                              pNext;
    VkCommandBufferUsageFlags                flags;
    const VkCommandBufferInheritanceInfo*    pInheritanceInfo;
} VkCommandBufferBeginInfo;

typedef struct VkBufferCopy {
    VkDeviceSize    srcOffset;
    VkDeviceSize    dstOffset;
    VkDeviceSize    size;
} VkBufferCopy;

typedef struct VkImageSubresourceLayers {
    VkImageAspectFlags    aspectMask;
    uint32_t              mipLevel;
    uint32_t              baseArrayLayer;
    uint32_t              layerCount;
} VkImageSubresourceLayers;

typedef struct VkImageCopy {
    VkImageSubresourceLayers    srcSubresource;
    VkOffset3D                  srcOffset;
    VkImageSubresourceLayers    dstSubresource;
    VkOffset3D                  dstOffset;
    VkExtent3D                  extent;
} VkImageCopy;

typedef struct VkImageBlit {
    VkImageSubresourceLayers    srcSubresource;
    VkOffset3D                  srcOffsets[2];
    VkImageSubresourceLayers    dstSubresource;
    VkOffset3D                  dstOffsets[2];
} VkImageBlit;

typedef struct VkBufferImageCopy {
    VkDeviceSize                bufferOffset;
    uint32_t                    bufferRowLength;
    uint32_t                    bufferImageHeight;
    VkImageSubresourceLayers    imageSubresource;
    VkOffset3D                  imageOffset;
    VkExtent3D                  imageExtent;
} VkBufferImageCopy;

typedef union VkClearColorValue {
    float       float32[4];
    int32_t     int32[4];
    uint32_t    uint32[4];
} VkClearColorValue;

typedef struct VkClearDepthStencilValue {
    float       depth;
    uint32_t    stencil;
} VkClearDepthStencilValue;

typedef union VkClearValue {
    VkClearColorValue           color;
    VkClearDepthStencilValue    depthStencil;
} VkClearValue;

typedef struct VkClearAttachment {
    VkImageAspectFlags    aspectMask;
    uint32_t              colorAttachment;
    VkClearValue          clearValue;
} VkClearAttachment;

typedef struct VkClearRect {
    VkRect2D    rect;
    uint32_t    baseArrayLayer;
    uint32_t    layerCount;
} VkClearRect;

typedef struct VkImageResolve {
    VkImageSubresourceLayers    srcSubresource;
    VkOffset3D                  srcOffset;
    VkImageSubresourceLayers    dstSubresource;
    VkOffset3D                  dstOffset;
    VkExtent3D                  extent;
} VkImageResolve;

typedef struct VkMemoryBarrier {
    VkStructureType    sType;
    const void*        pNext;
    VkAccessFlags      srcAccessMask;
    VkAccessFlags      dstAccessMask;
} VkMemoryBarrier;

typedef struct VkBufferMemoryBarrier {
    VkStructureType    sType;
    const void*        pNext;
    VkAccessFlags      srcAccessMask;
    VkAccessFlags      dstAccessMask;
    uint32_t           srcQueueFamilyIndex;
    uint32_t           dstQueueFamilyIndex;
    VkBuffer           buffer;
    VkDeviceSize       offset;
    VkDeviceSize       size;
} VkBufferMemoryBarrier;

typedef struct VkImageMemoryBarrier {
    VkStructureType            sType;
    const void*                pNext;
    VkAccessFlags              srcAccessMask;
    VkAccessFlags              dstAccessMask;
    VkImageLayout              oldLayout;
    VkImageLayout              newLayout;
    uint32_t                   srcQueueFamilyIndex;
    uint32_t                   dstQueueFamilyIndex;
    VkImage                    image;
    VkImageSubresourceRange    subresourceRange;
} VkImageMemoryBarrier;

typedef struct VkRenderPassBeginInfo {
    VkStructureType        sType;
    const void*            pNext;
    VkRenderPass           renderPass;
    VkFramebuffer          framebuffer;
    VkRect2D               renderArea;
    uint32_t               clearValueCount;
    const VkClearValue*    pClearValues;
} VkRenderPassBeginInfo;

typedef struct VkDispatchIndirectCommand {
    uint32_t    x;
    uint32_t    y;
    uint32_t    z;
} VkDispatchIndirectCommand;

typedef struct VkDrawIndexedIndirectCommand {
    uint32_t    indexCount;
    uint32_t    instanceCount;
    uint32_t    firstIndex;
    int32_t     vertexOffset;
    uint32_t    firstInstance;
} VkDrawIndexedIndirectCommand;

typedef struct VkDrawIndirectCommand {
    uint32_t    vertexCount;
    uint32_t    instanceCount;
    uint32_t    firstVertex;
    uint32_t    firstInstance;
} VkDrawIndirectCommand;


typedef VkResult (VKAPI_PTR *PFN_vkCreateInstance)(const VkInstanceCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkInstance* pInstance);
typedef void (VKAPI_PTR *PFN_vkDestroyInstance)(VkInstance instance, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkEnumeratePhysicalDevices)(VkInstance instance, uint32_t* pPhysicalDeviceCount, VkPhysicalDevice* pPhysicalDevices);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceFeatures)(VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures* pFeatures);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceFormatProperties)(VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties* pFormatProperties);
typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceImageFormatProperties)(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkImageFormatProperties* pImageFormatProperties);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceProperties)(VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties* pProperties);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceQueueFamilyProperties)(VkPhysicalDevice physicalDevice, uint32_t* pQueueFamilyPropertyCount, VkQueueFamilyProperties* pQueueFamilyProperties);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceMemoryProperties)(VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties* pMemoryProperties);
typedef PFN_vkVoidFunction (VKAPI_PTR *PFN_vkGetInstanceProcAddr)(VkInstance instance, const char* pName);
typedef PFN_vkVoidFunction (VKAPI_PTR *PFN_vkGetDeviceProcAddr)(VkDevice device, const char* pName);
typedef VkResult (VKAPI_PTR *PFN_vkCreateDevice)(VkPhysicalDevice physicalDevice, const VkDeviceCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkDevice* pDevice);
typedef void (VKAPI_PTR *PFN_vkDestroyDevice)(VkDevice device, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkEnumerateInstanceExtensionProperties)(const char* pLayerName, uint32_t* pPropertyCount, VkExtensionProperties* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkEnumerateDeviceExtensionProperties)(VkPhysicalDevice physicalDevice, const char* pLayerName, uint32_t* pPropertyCount, VkExtensionProperties* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkEnumerateInstanceLayerProperties)(uint32_t* pPropertyCount, VkLayerProperties* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkEnumerateDeviceLayerProperties)(VkPhysicalDevice physicalDevice, uint32_t* pPropertyCount, VkLayerProperties* pProperties);
typedef void (VKAPI_PTR *PFN_vkGetDeviceQueue)(VkDevice device, uint32_t queueFamilyIndex, uint32_t queueIndex, VkQueue* pQueue);
typedef VkResult (VKAPI_PTR *PFN_vkQueueSubmit)(VkQueue queue, uint32_t submitCount, const VkSubmitInfo* pSubmits, VkFence fence);
typedef VkResult (VKAPI_PTR *PFN_vkQueueWaitIdle)(VkQueue queue);
typedef VkResult (VKAPI_PTR *PFN_vkDeviceWaitIdle)(VkDevice device);
typedef VkResult (VKAPI_PTR *PFN_vkAllocateMemory)(VkDevice device, const VkMemoryAllocateInfo* pAllocateInfo, const VkAllocationCallbacks* pAllocator, VkDeviceMemory* pMemory);
typedef void (VKAPI_PTR *PFN_vkFreeMemory)(VkDevice device, VkDeviceMemory memory, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkMapMemory)(VkDevice device, VkDeviceMemory memory, VkDeviceSize offset, VkDeviceSize size, VkMemoryMapFlags flags, void** ppData);
typedef void (VKAPI_PTR *PFN_vkUnmapMemory)(VkDevice device, VkDeviceMemory memory);
typedef VkResult (VKAPI_PTR *PFN_vkFlushMappedMemoryRanges)(VkDevice device, uint32_t memoryRangeCount, const VkMappedMemoryRange* pMemoryRanges);
typedef VkResult (VKAPI_PTR *PFN_vkInvalidateMappedMemoryRanges)(VkDevice device, uint32_t memoryRangeCount, const VkMappedMemoryRange* pMemoryRanges);
typedef void (VKAPI_PTR *PFN_vkGetDeviceMemoryCommitment)(VkDevice device, VkDeviceMemory memory, VkDeviceSize* pCommittedMemoryInBytes);
typedef VkResult (VKAPI_PTR *PFN_vkBindBufferMemory)(VkDevice device, VkBuffer buffer, VkDeviceMemory memory, VkDeviceSize memoryOffset);
typedef VkResult (VKAPI_PTR *PFN_vkBindImageMemory)(VkDevice device, VkImage image, VkDeviceMemory memory, VkDeviceSize memoryOffset);
typedef void (VKAPI_PTR *PFN_vkGetBufferMemoryRequirements)(VkDevice device, VkBuffer buffer, VkMemoryRequirements* pMemoryRequirements);
typedef void (VKAPI_PTR *PFN_vkGetImageMemoryRequirements)(VkDevice device, VkImage image, VkMemoryRequirements* pMemoryRequirements);
typedef void (VKAPI_PTR *PFN_vkGetImageSparseMemoryRequirements)(VkDevice device, VkImage image, uint32_t* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements* pSparseMemoryRequirements);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceSparseImageFormatProperties)(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkSampleCountFlagBits samples, VkImageUsageFlags usage, VkImageTiling tiling, uint32_t* pPropertyCount, VkSparseImageFormatProperties* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkQueueBindSparse)(VkQueue queue, uint32_t bindInfoCount, const VkBindSparseInfo* pBindInfo, VkFence fence);
typedef VkResult (VKAPI_PTR *PFN_vkCreateFence)(VkDevice device, const VkFenceCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkFence* pFence);
typedef void (VKAPI_PTR *PFN_vkDestroyFence)(VkDevice device, VkFence fence, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkResetFences)(VkDevice device, uint32_t fenceCount, const VkFence* pFences);
typedef VkResult (VKAPI_PTR *PFN_vkGetFenceStatus)(VkDevice device, VkFence fence);
typedef VkResult (VKAPI_PTR *PFN_vkWaitForFences)(VkDevice device, uint32_t fenceCount, const VkFence* pFences, VkBool32 waitAll, uint64_t timeout);
typedef VkResult (VKAPI_PTR *PFN_vkCreateSemaphore)(VkDevice device, const VkSemaphoreCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSemaphore* pSemaphore);
typedef void (VKAPI_PTR *PFN_vkDestroySemaphore)(VkDevice device, VkSemaphore semaphore, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateEvent)(VkDevice device, const VkEventCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkEvent* pEvent);
typedef void (VKAPI_PTR *PFN_vkDestroyEvent)(VkDevice device, VkEvent event, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkGetEventStatus)(VkDevice device, VkEvent event);
typedef VkResult (VKAPI_PTR *PFN_vkSetEvent)(VkDevice device, VkEvent event);
typedef VkResult (VKAPI_PTR *PFN_vkResetEvent)(VkDevice device, VkEvent event);
typedef VkResult (VKAPI_PTR *PFN_vkCreateQueryPool)(VkDevice device, const VkQueryPoolCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkQueryPool* pQueryPool);
typedef void (VKAPI_PTR *PFN_vkDestroyQueryPool)(VkDevice device, VkQueryPool queryPool, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkGetQueryPoolResults)(VkDevice device, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount, size_t dataSize, void* pData, VkDeviceSize stride, VkQueryResultFlags flags);
typedef VkResult (VKAPI_PTR *PFN_vkCreateBuffer)(VkDevice device, const VkBufferCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkBuffer* pBuffer);
typedef void (VKAPI_PTR *PFN_vkDestroyBuffer)(VkDevice device, VkBuffer buffer, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateBufferView)(VkDevice device, const VkBufferViewCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkBufferView* pView);
typedef void (VKAPI_PTR *PFN_vkDestroyBufferView)(VkDevice device, VkBufferView bufferView, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateImage)(VkDevice device, const VkImageCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkImage* pImage);
typedef void (VKAPI_PTR *PFN_vkDestroyImage)(VkDevice device, VkImage image, const VkAllocationCallbacks* pAllocator);
typedef void (VKAPI_PTR *PFN_vkGetImageSubresourceLayout)(VkDevice device, VkImage image, const VkImageSubresource* pSubresource, VkSubresourceLayout* pLayout);
typedef VkResult (VKAPI_PTR *PFN_vkCreateImageView)(VkDevice device, const VkImageViewCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkImageView* pView);
typedef void (VKAPI_PTR *PFN_vkDestroyImageView)(VkDevice device, VkImageView imageView, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateShaderModule)(VkDevice device, const VkShaderModuleCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkShaderModule* pShaderModule);
typedef void (VKAPI_PTR *PFN_vkDestroyShaderModule)(VkDevice device, VkShaderModule shaderModule, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreatePipelineCache)(VkDevice device, const VkPipelineCacheCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkPipelineCache* pPipelineCache);
typedef void (VKAPI_PTR *PFN_vkDestroyPipelineCache)(VkDevice device, VkPipelineCache pipelineCache, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkGetPipelineCacheData)(VkDevice device, VkPipelineCache pipelineCache, size_t* pDataSize, void* pData);
typedef VkResult (VKAPI_PTR *PFN_vkMergePipelineCaches)(VkDevice device, VkPipelineCache dstCache, uint32_t srcCacheCount, const VkPipelineCache* pSrcCaches);
typedef VkResult (VKAPI_PTR *PFN_vkCreateGraphicsPipelines)(VkDevice device, VkPipelineCache pipelineCache, uint32_t createInfoCount, const VkGraphicsPipelineCreateInfo* pCreateInfos, const VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines);
typedef VkResult (VKAPI_PTR *PFN_vkCreateComputePipelines)(VkDevice device, VkPipelineCache pipelineCache, uint32_t createInfoCount, const VkComputePipelineCreateInfo* pCreateInfos, const VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines);
typedef void (VKAPI_PTR *PFN_vkDestroyPipeline)(VkDevice device, VkPipeline pipeline, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreatePipelineLayout)(VkDevice device, const VkPipelineLayoutCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkPipelineLayout* pPipelineLayout);
typedef void (VKAPI_PTR *PFN_vkDestroyPipelineLayout)(VkDevice device, VkPipelineLayout pipelineLayout, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateSampler)(VkDevice device, const VkSamplerCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSampler* pSampler);
typedef void (VKAPI_PTR *PFN_vkDestroySampler)(VkDevice device, VkSampler sampler, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateDescriptorSetLayout)(VkDevice device, const VkDescriptorSetLayoutCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkDescriptorSetLayout* pSetLayout);
typedef void (VKAPI_PTR *PFN_vkDestroyDescriptorSetLayout)(VkDevice device, VkDescriptorSetLayout descriptorSetLayout, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateDescriptorPool)(VkDevice device, const VkDescriptorPoolCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkDescriptorPool* pDescriptorPool);
typedef void (VKAPI_PTR *PFN_vkDestroyDescriptorPool)(VkDevice device, VkDescriptorPool descriptorPool, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkResetDescriptorPool)(VkDevice device, VkDescriptorPool descriptorPool, VkDescriptorPoolResetFlags flags);
typedef VkResult (VKAPI_PTR *PFN_vkAllocateDescriptorSets)(VkDevice device, const VkDescriptorSetAllocateInfo* pAllocateInfo, VkDescriptorSet* pDescriptorSets);
typedef VkResult (VKAPI_PTR *PFN_vkFreeDescriptorSets)(VkDevice device, VkDescriptorPool descriptorPool, uint32_t descriptorSetCount, const VkDescriptorSet* pDescriptorSets);
typedef void (VKAPI_PTR *PFN_vkUpdateDescriptorSets)(VkDevice device, uint32_t descriptorWriteCount, const VkWriteDescriptorSet* pDescriptorWrites, uint32_t descriptorCopyCount, const VkCopyDescriptorSet* pDescriptorCopies);
typedef VkResult (VKAPI_PTR *PFN_vkCreateFramebuffer)(VkDevice device, const VkFramebufferCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkFramebuffer* pFramebuffer);
typedef void (VKAPI_PTR *PFN_vkDestroyFramebuffer)(VkDevice device, VkFramebuffer framebuffer, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateRenderPass)(VkDevice device, const VkRenderPassCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkRenderPass* pRenderPass);
typedef void (VKAPI_PTR *PFN_vkDestroyRenderPass)(VkDevice device, VkRenderPass renderPass, const VkAllocationCallbacks* pAllocator);
typedef void (VKAPI_PTR *PFN_vkGetRenderAreaGranularity)(VkDevice device, VkRenderPass renderPass, VkExtent2D* pGranularity);
typedef VkResult (VKAPI_PTR *PFN_vkCreateCommandPool)(VkDevice device, const VkCommandPoolCreateInfo* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkCommandPool* pCommandPool);
typedef void (VKAPI_PTR *PFN_vkDestroyCommandPool)(VkDevice device, VkCommandPool commandPool, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkResetCommandPool)(VkDevice device, VkCommandPool commandPool, VkCommandPoolResetFlags flags);
typedef VkResult (VKAPI_PTR *PFN_vkAllocateCommandBuffers)(VkDevice device, const VkCommandBufferAllocateInfo* pAllocateInfo, VkCommandBuffer* pCommandBuffers);
typedef void (VKAPI_PTR *PFN_vkFreeCommandBuffers)(VkDevice device, VkCommandPool commandPool, uint32_t commandBufferCount, const VkCommandBuffer* pCommandBuffers);
typedef VkResult (VKAPI_PTR *PFN_vkBeginCommandBuffer)(VkCommandBuffer commandBuffer, const VkCommandBufferBeginInfo* pBeginInfo);
typedef VkResult (VKAPI_PTR *PFN_vkEndCommandBuffer)(VkCommandBuffer commandBuffer);
typedef VkResult (VKAPI_PTR *PFN_vkResetCommandBuffer)(VkCommandBuffer commandBuffer, VkCommandBufferResetFlags flags);
typedef void (VKAPI_PTR *PFN_vkCmdBindPipeline)(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline);
typedef void (VKAPI_PTR *PFN_vkCmdSetViewport)(VkCommandBuffer commandBuffer, uint32_t firstViewport, uint32_t viewportCount, const VkViewport* pViewports);
typedef void (VKAPI_PTR *PFN_vkCmdSetScissor)(VkCommandBuffer commandBuffer, uint32_t firstScissor, uint32_t scissorCount, const VkRect2D* pScissors);
typedef void (VKAPI_PTR *PFN_vkCmdSetLineWidth)(VkCommandBuffer commandBuffer, float lineWidth);
typedef void (VKAPI_PTR *PFN_vkCmdSetDepthBias)(VkCommandBuffer commandBuffer, float depthBiasConstantFactor, float depthBiasClamp, float depthBiasSlopeFactor);
typedef void (VKAPI_PTR *PFN_vkCmdSetBlendConstants)(VkCommandBuffer commandBuffer, const float blendConstants[4]);
typedef void (VKAPI_PTR *PFN_vkCmdSetDepthBounds)(VkCommandBuffer commandBuffer, float minDepthBounds, float maxDepthBounds);
typedef void (VKAPI_PTR *PFN_vkCmdSetStencilCompareMask)(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32_t compareMask);
typedef void (VKAPI_PTR *PFN_vkCmdSetStencilWriteMask)(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32_t writeMask);
typedef void (VKAPI_PTR *PFN_vkCmdSetStencilReference)(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32_t reference);
typedef void (VKAPI_PTR *PFN_vkCmdBindDescriptorSets)(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32_t firstSet, uint32_t descriptorSetCount, const VkDescriptorSet* pDescriptorSets, uint32_t dynamicOffsetCount, const uint32_t* pDynamicOffsets);
typedef void (VKAPI_PTR *PFN_vkCmdBindIndexBuffer)(VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, VkIndexType indexType);
typedef void (VKAPI_PTR *PFN_vkCmdBindVertexBuffers)(VkCommandBuffer commandBuffer, uint32_t firstBinding, uint32_t bindingCount, const VkBuffer* pBuffers, const VkDeviceSize* pOffsets);
typedef void (VKAPI_PTR *PFN_vkCmdDraw)(VkCommandBuffer commandBuffer, uint32_t vertexCount, uint32_t instanceCount, uint32_t firstVertex, uint32_t firstInstance);
typedef void (VKAPI_PTR *PFN_vkCmdDrawIndexed)(VkCommandBuffer commandBuffer, uint32_t indexCount, uint32_t instanceCount, uint32_t firstIndex, int32_t vertexOffset, uint32_t firstInstance);
typedef void (VKAPI_PTR *PFN_vkCmdDrawIndirect)(VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, uint32_t drawCount, uint32_t stride);
typedef void (VKAPI_PTR *PFN_vkCmdDrawIndexedIndirect)(VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, uint32_t drawCount, uint32_t stride);
typedef void (VKAPI_PTR *PFN_vkCmdDispatch)(VkCommandBuffer commandBuffer, uint32_t x, uint32_t y, uint32_t z);
typedef void (VKAPI_PTR *PFN_vkCmdDispatchIndirect)(VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset);
typedef void (VKAPI_PTR *PFN_vkCmdCopyBuffer)(VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkBuffer dstBuffer, uint32_t regionCount, const VkBufferCopy* pRegions);
typedef void (VKAPI_PTR *PFN_vkCmdCopyImage)(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const VkImageCopy* pRegions);
typedef void (VKAPI_PTR *PFN_vkCmdBlitImage)(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const VkImageBlit* pRegions, VkFilter filter);
typedef void (VKAPI_PTR *PFN_vkCmdCopyBufferToImage)(VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const VkBufferImageCopy* pRegions);
typedef void (VKAPI_PTR *PFN_vkCmdCopyImageToBuffer)(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkBuffer dstBuffer, uint32_t regionCount, const VkBufferImageCopy* pRegions);
typedef void (VKAPI_PTR *PFN_vkCmdUpdateBuffer)(VkCommandBuffer commandBuffer, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize dataSize, const void* pData);
typedef void (VKAPI_PTR *PFN_vkCmdFillBuffer)(VkCommandBuffer commandBuffer, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize size, uint32_t data);
typedef void (VKAPI_PTR *PFN_vkCmdClearColorImage)(VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, const VkClearColorValue* pColor, uint32_t rangeCount, const VkImageSubresourceRange* pRanges);
typedef void (VKAPI_PTR *PFN_vkCmdClearDepthStencilImage)(VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, const VkClearDepthStencilValue* pDepthStencil, uint32_t rangeCount, const VkImageSubresourceRange* pRanges);
typedef void (VKAPI_PTR *PFN_vkCmdClearAttachments)(VkCommandBuffer commandBuffer, uint32_t attachmentCount, const VkClearAttachment* pAttachments, uint32_t rectCount, const VkClearRect* pRects);
typedef void (VKAPI_PTR *PFN_vkCmdResolveImage)(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32_t regionCount, const VkImageResolve* pRegions);
typedef void (VKAPI_PTR *PFN_vkCmdSetEvent)(VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask);
typedef void (VKAPI_PTR *PFN_vkCmdResetEvent)(VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask);
typedef void (VKAPI_PTR *PFN_vkCmdWaitEvents)(VkCommandBuffer commandBuffer, uint32_t eventCount, const VkEvent* pEvents, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, uint32_t memoryBarrierCount, const VkMemoryBarrier* pMemoryBarriers, uint32_t bufferMemoryBarrierCount, const VkBufferMemoryBarrier* pBufferMemoryBarriers, uint32_t imageMemoryBarrierCount, const VkImageMemoryBarrier* pImageMemoryBarriers);
typedef void (VKAPI_PTR *PFN_vkCmdPipelineBarrier)(VkCommandBuffer commandBuffer, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, VkDependencyFlags dependencyFlags, uint32_t memoryBarrierCount, const VkMemoryBarrier* pMemoryBarriers, uint32_t bufferMemoryBarrierCount, const VkBufferMemoryBarrier* pBufferMemoryBarriers, uint32_t imageMemoryBarrierCount, const VkImageMemoryBarrier* pImageMemoryBarriers);
typedef void (VKAPI_PTR *PFN_vkCmdBeginQuery)(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t query, VkQueryControlFlags flags);
typedef void (VKAPI_PTR *PFN_vkCmdEndQuery)(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t query);
typedef void (VKAPI_PTR *PFN_vkCmdResetQueryPool)(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount);
typedef void (VKAPI_PTR *PFN_vkCmdWriteTimestamp)(VkCommandBuffer commandBuffer, VkPipelineStageFlagBits pipelineStage, VkQueryPool queryPool, uint32_t query);
typedef void (VKAPI_PTR *PFN_vkCmdCopyQueryPoolResults)(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32_t firstQuery, uint32_t queryCount, VkBuffer dstBuffer, VkDeviceSize dstOffset, VkDeviceSize stride, VkQueryResultFlags flags);
typedef void (VKAPI_PTR *PFN_vkCmdPushConstants)(VkCommandBuffer commandBuffer, VkPipelineLayout layout, VkShaderStageFlags stageFlags, uint32_t offset, uint32_t size, const void* pValues);
typedef void (VKAPI_PTR *PFN_vkCmdBeginRenderPass)(VkCommandBuffer commandBuffer, const VkRenderPassBeginInfo* pRenderPassBegin, VkSubpassContents contents);
typedef void (VKAPI_PTR *PFN_vkCmdNextSubpass)(VkCommandBuffer commandBuffer, VkSubpassContents contents);
typedef void (VKAPI_PTR *PFN_vkCmdEndRenderPass)(VkCommandBuffer commandBuffer);
typedef void (VKAPI_PTR *PFN_vkCmdExecuteCommands)(VkCommandBuffer commandBuffer, uint32_t commandBufferCount, const VkCommandBuffer* pCommandBuffers);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateInstance(
    const VkInstanceCreateInfo*                 pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkInstance*                                 pInstance);

VKAPI_ATTR void VKAPI_CALL vkDestroyInstance(
    VkInstance                                  instance,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkEnumeratePhysicalDevices(
    VkInstance                                  instance,
    uint32_t*                                   pPhysicalDeviceCount,
    VkPhysicalDevice*                           pPhysicalDevices);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceFeatures(
    VkPhysicalDevice                            physicalDevice,
    VkPhysicalDeviceFeatures*                   pFeatures);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceFormatProperties(
    VkPhysicalDevice                            physicalDevice,
    VkFormat                                    format,
    VkFormatProperties*                         pFormatProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceImageFormatProperties(
    VkPhysicalDevice                            physicalDevice,
    VkFormat                                    format,
    VkImageType                                 type,
    VkImageTiling                               tiling,
    VkImageUsageFlags                           usage,
    VkImageCreateFlags                          flags,
    VkImageFormatProperties*                    pImageFormatProperties);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceProperties(
    VkPhysicalDevice                            physicalDevice,
    VkPhysicalDeviceProperties*                 pProperties);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceQueueFamilyProperties(
    VkPhysicalDevice                            physicalDevice,
    uint32_t*                                   pQueueFamilyPropertyCount,
    VkQueueFamilyProperties*                    pQueueFamilyProperties);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceMemoryProperties(
    VkPhysicalDevice                            physicalDevice,
    VkPhysicalDeviceMemoryProperties*           pMemoryProperties);

VKAPI_ATTR PFN_vkVoidFunction VKAPI_CALL vkGetInstanceProcAddr(
    VkInstance                                  instance,
    const char*                                 pName);

VKAPI_ATTR PFN_vkVoidFunction VKAPI_CALL vkGetDeviceProcAddr(
    VkDevice                                    device,
    const char*                                 pName);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateDevice(
    VkPhysicalDevice                            physicalDevice,
    const VkDeviceCreateInfo*                   pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkDevice*                                   pDevice);

VKAPI_ATTR void VKAPI_CALL vkDestroyDevice(
    VkDevice                                    device,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkEnumerateInstanceExtensionProperties(
    const char*                                 pLayerName,
    uint32_t*                                   pPropertyCount,
    VkExtensionProperties*                      pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkEnumerateDeviceExtensionProperties(
    VkPhysicalDevice                            physicalDevice,
    const char*                                 pLayerName,
    uint32_t*                                   pPropertyCount,
    VkExtensionProperties*                      pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkEnumerateInstanceLayerProperties(
    uint32_t*                                   pPropertyCount,
    VkLayerProperties*                          pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkEnumerateDeviceLayerProperties(
    VkPhysicalDevice                            physicalDevice,
    uint32_t*                                   pPropertyCount,
    VkLayerProperties*                          pProperties);

VKAPI_ATTR void VKAPI_CALL vkGetDeviceQueue(
    VkDevice                                    device,
    uint32_t                                    queueFamilyIndex,
    uint32_t                                    queueIndex,
    VkQueue*                                    pQueue);

VKAPI_ATTR VkResult VKAPI_CALL vkQueueSubmit(
    VkQueue                                     queue,
    uint32_t                                    submitCount,
    const VkSubmitInfo*                         pSubmits,
    VkFence                                     fence);

VKAPI_ATTR VkResult VKAPI_CALL vkQueueWaitIdle(
    VkQueue                                     queue);

VKAPI_ATTR VkResult VKAPI_CALL vkDeviceWaitIdle(
    VkDevice                                    device);

VKAPI_ATTR VkResult VKAPI_CALL vkAllocateMemory(
    VkDevice                                    device,
    const VkMemoryAllocateInfo*                 pAllocateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkDeviceMemory*                             pMemory);

VKAPI_ATTR void VKAPI_CALL vkFreeMemory(
    VkDevice                                    device,
    VkDeviceMemory                              memory,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkMapMemory(
    VkDevice                                    device,
    VkDeviceMemory                              memory,
    VkDeviceSize                                offset,
    VkDeviceSize                                size,
    VkMemoryMapFlags                            flags,
    void**                                      ppData);

VKAPI_ATTR void VKAPI_CALL vkUnmapMemory(
    VkDevice                                    device,
    VkDeviceMemory                              memory);

VKAPI_ATTR VkResult VKAPI_CALL vkFlushMappedMemoryRanges(
    VkDevice                                    device,
    uint32_t                                    memoryRangeCount,
    const VkMappedMemoryRange*                  pMemoryRanges);

VKAPI_ATTR VkResult VKAPI_CALL vkInvalidateMappedMemoryRanges(
    VkDevice                                    device,
    uint32_t                                    memoryRangeCount,
    const VkMappedMemoryRange*                  pMemoryRanges);

VKAPI_ATTR void VKAPI_CALL vkGetDeviceMemoryCommitment(
    VkDevice                                    device,
    VkDeviceMemory                              memory,
    VkDeviceSize*                               pCommittedMemoryInBytes);

VKAPI_ATTR VkResult VKAPI_CALL vkBindBufferMemory(
    VkDevice                                    device,
    VkBuffer                                    buffer,
    VkDeviceMemory                              memory,
    VkDeviceSize                                memoryOffset);

VKAPI_ATTR VkResult VKAPI_CALL vkBindImageMemory(
    VkDevice                                    device,
    VkImage                                     image,
    VkDeviceMemory                              memory,
    VkDeviceSize                                memoryOffset);

VKAPI_ATTR void VKAPI_CALL vkGetBufferMemoryRequirements(
    VkDevice                                    device,
    VkBuffer                                    buffer,
    VkMemoryRequirements*                       pMemoryRequirements);

VKAPI_ATTR void VKAPI_CALL vkGetImageMemoryRequirements(
    VkDevice                                    device,
    VkImage                                     image,
    VkMemoryRequirements*                       pMemoryRequirements);

VKAPI_ATTR void VKAPI_CALL vkGetImageSparseMemoryRequirements(
    VkDevice                                    device,
    VkImage                                     image,
    uint32_t*                                   pSparseMemoryRequirementCount,
    VkSparseImageMemoryRequirements*            pSparseMemoryRequirements);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceSparseImageFormatProperties(
    VkPhysicalDevice                            physicalDevice,
    VkFormat                                    format,
    VkImageType                                 type,
    VkSampleCountFlagBits                       samples,
    VkImageUsageFlags                           usage,
    VkImageTiling                               tiling,
    uint32_t*                                   pPropertyCount,
    VkSparseImageFormatProperties*              pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkQueueBindSparse(
    VkQueue                                     queue,
    uint32_t                                    bindInfoCount,
    const VkBindSparseInfo*                     pBindInfo,
    VkFence                                     fence);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateFence(
    VkDevice                                    device,
    const VkFenceCreateInfo*                    pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkFence*                                    pFence);

VKAPI_ATTR void VKAPI_CALL vkDestroyFence(
    VkDevice                                    device,
    VkFence                                     fence,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkResetFences(
    VkDevice                                    device,
    uint32_t                                    fenceCount,
    const VkFence*                              pFences);

VKAPI_ATTR VkResult VKAPI_CALL vkGetFenceStatus(
    VkDevice                                    device,
    VkFence                                     fence);

VKAPI_ATTR VkResult VKAPI_CALL vkWaitForFences(
    VkDevice                                    device,
    uint32_t                                    fenceCount,
    const VkFence*                              pFences,
    VkBool32                                    waitAll,
    uint64_t                                    timeout);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateSemaphore(
    VkDevice                                    device,
    const VkSemaphoreCreateInfo*                pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSemaphore*                                pSemaphore);

VKAPI_ATTR void VKAPI_CALL vkDestroySemaphore(
    VkDevice                                    device,
    VkSemaphore                                 semaphore,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateEvent(
    VkDevice                                    device,
    const VkEventCreateInfo*                    pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkEvent*                                    pEvent);

VKAPI_ATTR void VKAPI_CALL vkDestroyEvent(
    VkDevice                                    device,
    VkEvent                                     event,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkGetEventStatus(
    VkDevice                                    device,
    VkEvent                                     event);

VKAPI_ATTR VkResult VKAPI_CALL vkSetEvent(
    VkDevice                                    device,
    VkEvent                                     event);

VKAPI_ATTR VkResult VKAPI_CALL vkResetEvent(
    VkDevice                                    device,
    VkEvent                                     event);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateQueryPool(
    VkDevice                                    device,
    const VkQueryPoolCreateInfo*                pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkQueryPool*                                pQueryPool);

VKAPI_ATTR void VKAPI_CALL vkDestroyQueryPool(
    VkDevice                                    device,
    VkQueryPool                                 queryPool,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkGetQueryPoolResults(
    VkDevice                                    device,
    VkQueryPool                                 queryPool,
    uint32_t                                    firstQuery,
    uint32_t                                    queryCount,
    size_t                                      dataSize,
    void*                                       pData,
    VkDeviceSize                                stride,
    VkQueryResultFlags                          flags);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateBuffer(
    VkDevice                                    device,
    const VkBufferCreateInfo*                   pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkBuffer*                                   pBuffer);

VKAPI_ATTR void VKAPI_CALL vkDestroyBuffer(
    VkDevice                                    device,
    VkBuffer                                    buffer,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateBufferView(
    VkDevice                                    device,
    const VkBufferViewCreateInfo*               pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkBufferView*                               pView);

VKAPI_ATTR void VKAPI_CALL vkDestroyBufferView(
    VkDevice                                    device,
    VkBufferView                                bufferView,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateImage(
    VkDevice                                    device,
    const VkImageCreateInfo*                    pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkImage*                                    pImage);

VKAPI_ATTR void VKAPI_CALL vkDestroyImage(
    VkDevice                                    device,
    VkImage                                     image,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR void VKAPI_CALL vkGetImageSubresourceLayout(
    VkDevice                                    device,
    VkImage                                     image,
    const VkImageSubresource*                   pSubresource,
    VkSubresourceLayout*                        pLayout);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateImageView(
    VkDevice                                    device,
    const VkImageViewCreateInfo*                pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkImageView*                                pView);

VKAPI_ATTR void VKAPI_CALL vkDestroyImageView(
    VkDevice                                    device,
    VkImageView                                 imageView,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateShaderModule(
    VkDevice                                    device,
    const VkShaderModuleCreateInfo*             pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkShaderModule*                             pShaderModule);

VKAPI_ATTR void VKAPI_CALL vkDestroyShaderModule(
    VkDevice                                    device,
    VkShaderModule                              shaderModule,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreatePipelineCache(
    VkDevice                                    device,
    const VkPipelineCacheCreateInfo*            pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkPipelineCache*                            pPipelineCache);

VKAPI_ATTR void VKAPI_CALL vkDestroyPipelineCache(
    VkDevice                                    device,
    VkPipelineCache                             pipelineCache,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPipelineCacheData(
    VkDevice                                    device,
    VkPipelineCache                             pipelineCache,
    size_t*                                     pDataSize,
    void*                                       pData);

VKAPI_ATTR VkResult VKAPI_CALL vkMergePipelineCaches(
    VkDevice                                    device,
    VkPipelineCache                             dstCache,
    uint32_t                                    srcCacheCount,
    const VkPipelineCache*                      pSrcCaches);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateGraphicsPipelines(
    VkDevice                                    device,
    VkPipelineCache                             pipelineCache,
    uint32_t                                    createInfoCount,
    const VkGraphicsPipelineCreateInfo*         pCreateInfos,
    const VkAllocationCallbacks*                pAllocator,
    VkPipeline*                                 pPipelines);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateComputePipelines(
    VkDevice                                    device,
    VkPipelineCache                             pipelineCache,
    uint32_t                                    createInfoCount,
    const VkComputePipelineCreateInfo*          pCreateInfos,
    const VkAllocationCallbacks*                pAllocator,
    VkPipeline*                                 pPipelines);

VKAPI_ATTR void VKAPI_CALL vkDestroyPipeline(
    VkDevice                                    device,
    VkPipeline                                  pipeline,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreatePipelineLayout(
    VkDevice                                    device,
    const VkPipelineLayoutCreateInfo*           pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkPipelineLayout*                           pPipelineLayout);

VKAPI_ATTR void VKAPI_CALL vkDestroyPipelineLayout(
    VkDevice                                    device,
    VkPipelineLayout                            pipelineLayout,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateSampler(
    VkDevice                                    device,
    const VkSamplerCreateInfo*                  pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSampler*                                  pSampler);

VKAPI_ATTR void VKAPI_CALL vkDestroySampler(
    VkDevice                                    device,
    VkSampler                                   sampler,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateDescriptorSetLayout(
    VkDevice                                    device,
    const VkDescriptorSetLayoutCreateInfo*      pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkDescriptorSetLayout*                      pSetLayout);

VKAPI_ATTR void VKAPI_CALL vkDestroyDescriptorSetLayout(
    VkDevice                                    device,
    VkDescriptorSetLayout                       descriptorSetLayout,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateDescriptorPool(
    VkDevice                                    device,
    const VkDescriptorPoolCreateInfo*           pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkDescriptorPool*                           pDescriptorPool);

VKAPI_ATTR void VKAPI_CALL vkDestroyDescriptorPool(
    VkDevice                                    device,
    VkDescriptorPool                            descriptorPool,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkResetDescriptorPool(
    VkDevice                                    device,
    VkDescriptorPool                            descriptorPool,
    VkDescriptorPoolResetFlags                  flags);

VKAPI_ATTR VkResult VKAPI_CALL vkAllocateDescriptorSets(
    VkDevice                                    device,
    const VkDescriptorSetAllocateInfo*          pAllocateInfo,
    VkDescriptorSet*                            pDescriptorSets);

VKAPI_ATTR VkResult VKAPI_CALL vkFreeDescriptorSets(
    VkDevice                                    device,
    VkDescriptorPool                            descriptorPool,
    uint32_t                                    descriptorSetCount,
    const VkDescriptorSet*                      pDescriptorSets);

VKAPI_ATTR void VKAPI_CALL vkUpdateDescriptorSets(
    VkDevice                                    device,
    uint32_t                                    descriptorWriteCount,
    const VkWriteDescriptorSet*                 pDescriptorWrites,
    uint32_t                                    descriptorCopyCount,
    const VkCopyDescriptorSet*                  pDescriptorCopies);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateFramebuffer(
    VkDevice                                    device,
    const VkFramebufferCreateInfo*              pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkFramebuffer*                              pFramebuffer);

VKAPI_ATTR void VKAPI_CALL vkDestroyFramebuffer(
    VkDevice                                    device,
    VkFramebuffer                               framebuffer,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateRenderPass(
    VkDevice                                    device,
    const VkRenderPassCreateInfo*               pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkRenderPass*                               pRenderPass);

VKAPI_ATTR void VKAPI_CALL vkDestroyRenderPass(
    VkDevice                                    device,
    VkRenderPass                                renderPass,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR void VKAPI_CALL vkGetRenderAreaGranularity(
    VkDevice                                    device,
    VkRenderPass                                renderPass,
    VkExtent2D*                                 pGranularity);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateCommandPool(
    VkDevice                                    device,
    const VkCommandPoolCreateInfo*              pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkCommandPool*                              pCommandPool);

VKAPI_ATTR void VKAPI_CALL vkDestroyCommandPool(
    VkDevice                                    device,
    VkCommandPool                               commandPool,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkResetCommandPool(
    VkDevice                                    device,
    VkCommandPool                               commandPool,
    VkCommandPoolResetFlags                     flags);

VKAPI_ATTR VkResult VKAPI_CALL vkAllocateCommandBuffers(
    VkDevice                                    device,
    const VkCommandBufferAllocateInfo*          pAllocateInfo,
    VkCommandBuffer*                            pCommandBuffers);

VKAPI_ATTR void VKAPI_CALL vkFreeCommandBuffers(
    VkDevice                                    device,
    VkCommandPool                               commandPool,
    uint32_t                                    commandBufferCount,
    const VkCommandBuffer*                      pCommandBuffers);

VKAPI_ATTR VkResult VKAPI_CALL vkBeginCommandBuffer(
    VkCommandBuffer                             commandBuffer,
    const VkCommandBufferBeginInfo*             pBeginInfo);

VKAPI_ATTR VkResult VKAPI_CALL vkEndCommandBuffer(
    VkCommandBuffer                             commandBuffer);

VKAPI_ATTR VkResult VKAPI_CALL vkResetCommandBuffer(
    VkCommandBuffer                             commandBuffer,
    VkCommandBufferResetFlags                   flags);

VKAPI_ATTR void VKAPI_CALL vkCmdBindPipeline(
    VkCommandBuffer                             commandBuffer,
    VkPipelineBindPoint                         pipelineBindPoint,
    VkPipeline                                  pipeline);

VKAPI_ATTR void VKAPI_CALL vkCmdSetViewport(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    firstViewport,
    uint32_t                                    viewportCount,
    const VkViewport*                           pViewports);

VKAPI_ATTR void VKAPI_CALL vkCmdSetScissor(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    firstScissor,
    uint32_t                                    scissorCount,
    const VkRect2D*                             pScissors);

VKAPI_ATTR void VKAPI_CALL vkCmdSetLineWidth(
    VkCommandBuffer                             commandBuffer,
    float                                       lineWidth);

VKAPI_ATTR void VKAPI_CALL vkCmdSetDepthBias(
    VkCommandBuffer                             commandBuffer,
    float                                       depthBiasConstantFactor,
    float                                       depthBiasClamp,
    float                                       depthBiasSlopeFactor);

VKAPI_ATTR void VKAPI_CALL vkCmdSetBlendConstants(
    VkCommandBuffer                             commandBuffer,
    const float                                 blendConstants[4]);

VKAPI_ATTR void VKAPI_CALL vkCmdSetDepthBounds(
    VkCommandBuffer                             commandBuffer,
    float                                       minDepthBounds,
    float                                       maxDepthBounds);

VKAPI_ATTR void VKAPI_CALL vkCmdSetStencilCompareMask(
    VkCommandBuffer                             commandBuffer,
    VkStencilFaceFlags                          faceMask,
    uint32_t                                    compareMask);

VKAPI_ATTR void VKAPI_CALL vkCmdSetStencilWriteMask(
    VkCommandBuffer                             commandBuffer,
    VkStencilFaceFlags                          faceMask,
    uint32_t                                    writeMask);

VKAPI_ATTR void VKAPI_CALL vkCmdSetStencilReference(
    VkCommandBuffer                             commandBuffer,
    VkStencilFaceFlags                          faceMask,
    uint32_t                                    reference);

VKAPI_ATTR void VKAPI_CALL vkCmdBindDescriptorSets(
    VkCommandBuffer                             commandBuffer,
    VkPipelineBindPoint                         pipelineBindPoint,
    VkPipelineLayout                            layout,
    uint32_t                                    firstSet,
    uint32_t                                    descriptorSetCount,
    const VkDescriptorSet*                      pDescriptorSets,
    uint32_t                                    dynamicOffsetCount,
    const uint32_t*                             pDynamicOffsets);

VKAPI_ATTR void VKAPI_CALL vkCmdBindIndexBuffer(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    buffer,
    VkDeviceSize                                offset,
    VkIndexType                                 indexType);

VKAPI_ATTR void VKAPI_CALL vkCmdBindVertexBuffers(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    firstBinding,
    uint32_t                                    bindingCount,
    const VkBuffer*                             pBuffers,
    const VkDeviceSize*                         pOffsets);

VKAPI_ATTR void VKAPI_CALL vkCmdDraw(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    vertexCount,
    uint32_t                                    instanceCount,
    uint32_t                                    firstVertex,
    uint32_t                                    firstInstance);

VKAPI_ATTR void VKAPI_CALL vkCmdDrawIndexed(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    indexCount,
    uint32_t                                    instanceCount,
    uint32_t                                    firstIndex,
    int32_t                                     vertexOffset,
    uint32_t                                    firstInstance);

VKAPI_ATTR void VKAPI_CALL vkCmdDrawIndirect(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    buffer,
    VkDeviceSize                                offset,
    uint32_t                                    drawCount,
    uint32_t                                    stride);

VKAPI_ATTR void VKAPI_CALL vkCmdDrawIndexedIndirect(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    buffer,
    VkDeviceSize                                offset,
    uint32_t                                    drawCount,
    uint32_t                                    stride);

VKAPI_ATTR void VKAPI_CALL vkCmdDispatch(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    x,
    uint32_t                                    y,
    uint32_t                                    z);

VKAPI_ATTR void VKAPI_CALL vkCmdDispatchIndirect(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    buffer,
    VkDeviceSize                                offset);

VKAPI_ATTR void VKAPI_CALL vkCmdCopyBuffer(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    srcBuffer,
    VkBuffer                                    dstBuffer,
    uint32_t                                    regionCount,
    const VkBufferCopy*                         pRegions);

VKAPI_ATTR void VKAPI_CALL vkCmdCopyImage(
    VkCommandBuffer                             commandBuffer,
    VkImage                                     srcImage,
    VkImageLayout                               srcImageLayout,
    VkImage                                     dstImage,
    VkImageLayout                               dstImageLayout,
    uint32_t                                    regionCount,
    const VkImageCopy*                          pRegions);

VKAPI_ATTR void VKAPI_CALL vkCmdBlitImage(
    VkCommandBuffer                             commandBuffer,
    VkImage                                     srcImage,
    VkImageLayout                               srcImageLayout,
    VkImage                                     dstImage,
    VkImageLayout                               dstImageLayout,
    uint32_t                                    regionCount,
    const VkImageBlit*                          pRegions,
    VkFilter                                    filter);

VKAPI_ATTR void VKAPI_CALL vkCmdCopyBufferToImage(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    srcBuffer,
    VkImage                                     dstImage,
    VkImageLayout                               dstImageLayout,
    uint32_t                                    regionCount,
    const VkBufferImageCopy*                    pRegions);

VKAPI_ATTR void VKAPI_CALL vkCmdCopyImageToBuffer(
    VkCommandBuffer                             commandBuffer,
    VkImage                                     srcImage,
    VkImageLayout                               srcImageLayout,
    VkBuffer                                    dstBuffer,
    uint32_t                                    regionCount,
    const VkBufferImageCopy*                    pRegions);

VKAPI_ATTR void VKAPI_CALL vkCmdUpdateBuffer(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    dstBuffer,
    VkDeviceSize                                dstOffset,
    VkDeviceSize                                dataSize,
    const void*                                 pData);

VKAPI_ATTR void VKAPI_CALL vkCmdFillBuffer(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    dstBuffer,
    VkDeviceSize                                dstOffset,
    VkDeviceSize                                size,
    uint32_t                                    data);

VKAPI_ATTR void VKAPI_CALL vkCmdClearColorImage(
    VkCommandBuffer                             commandBuffer,
    VkImage                                     image,
    VkImageLayout                               imageLayout,
    const VkClearColorValue*                    pColor,
    uint32_t                                    rangeCount,
    const VkImageSubresourceRange*              pRanges);

VKAPI_ATTR void VKAPI_CALL vkCmdClearDepthStencilImage(
    VkCommandBuffer                             commandBuffer,
    VkImage                                     image,
    VkImageLayout                               imageLayout,
    const VkClearDepthStencilValue*             pDepthStencil,
    uint32_t                                    rangeCount,
    const VkImageSubresourceRange*              pRanges);

VKAPI_ATTR void VKAPI_CALL vkCmdClearAttachments(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    attachmentCount,
    const VkClearAttachment*                    pAttachments,
    uint32_t                                    rectCount,
    const VkClearRect*                          pRects);

VKAPI_ATTR void VKAPI_CALL vkCmdResolveImage(
    VkCommandBuffer                             commandBuffer,
    VkImage                                     srcImage,
    VkImageLayout                               srcImageLayout,
    VkImage                                     dstImage,
    VkImageLayout                               dstImageLayout,
    uint32_t                                    regionCount,
    const VkImageResolve*                       pRegions);

VKAPI_ATTR void VKAPI_CALL vkCmdSetEvent(
    VkCommandBuffer                             commandBuffer,
    VkEvent                                     event,
    VkPipelineStageFlags                        stageMask);

VKAPI_ATTR void VKAPI_CALL vkCmdResetEvent(
    VkCommandBuffer                             commandBuffer,
    VkEvent                                     event,
    VkPipelineStageFlags                        stageMask);

VKAPI_ATTR void VKAPI_CALL vkCmdWaitEvents(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    eventCount,
    const VkEvent*                              pEvents,
    VkPipelineStageFlags                        srcStageMask,
    VkPipelineStageFlags                        dstStageMask,
    uint32_t                                    memoryBarrierCount,
    const VkMemoryBarrier*                      pMemoryBarriers,
    uint32_t                                    bufferMemoryBarrierCount,
    const VkBufferMemoryBarrier*                pBufferMemoryBarriers,
    uint32_t                                    imageMemoryBarrierCount,
    const VkImageMemoryBarrier*                 pImageMemoryBarriers);

VKAPI_ATTR void VKAPI_CALL vkCmdPipelineBarrier(
    VkCommandBuffer                             commandBuffer,
    VkPipelineStageFlags                        srcStageMask,
    VkPipelineStageFlags                        dstStageMask,
    VkDependencyFlags                           dependencyFlags,
    uint32_t                                    memoryBarrierCount,
    const VkMemoryBarrier*                      pMemoryBarriers,
    uint32_t                                    bufferMemoryBarrierCount,
    const VkBufferMemoryBarrier*                pBufferMemoryBarriers,
    uint32_t                                    imageMemoryBarrierCount,
    const VkImageMemoryBarrier*                 pImageMemoryBarriers);

VKAPI_ATTR void VKAPI_CALL vkCmdBeginQuery(
    VkCommandBuffer                             commandBuffer,
    VkQueryPool                                 queryPool,
    uint32_t                                    query,
    VkQueryControlFlags                         flags);

VKAPI_ATTR void VKAPI_CALL vkCmdEndQuery(
    VkCommandBuffer                             commandBuffer,
    VkQueryPool                                 queryPool,
    uint32_t                                    query);

VKAPI_ATTR void VKAPI_CALL vkCmdResetQueryPool(
    VkCommandBuffer                             commandBuffer,
    VkQueryPool                                 queryPool,
    uint32_t                                    firstQuery,
    uint32_t                                    queryCount);

VKAPI_ATTR void VKAPI_CALL vkCmdWriteTimestamp(
    VkCommandBuffer                             commandBuffer,
    VkPipelineStageFlagBits                     pipelineStage,
    VkQueryPool                                 queryPool,
    uint32_t                                    query);

VKAPI_ATTR void VKAPI_CALL vkCmdCopyQueryPoolResults(
    VkCommandBuffer                             commandBuffer,
    VkQueryPool                                 queryPool,
    uint32_t                                    firstQuery,
    uint32_t                                    queryCount,
    VkBuffer                                    dstBuffer,
    VkDeviceSize                                dstOffset,
    VkDeviceSize                                stride,
    VkQueryResultFlags                          flags);

VKAPI_ATTR void VKAPI_CALL vkCmdPushConstants(
    VkCommandBuffer                             commandBuffer,
    VkPipelineLayout                            layout,
    VkShaderStageFlags                          stageFlags,
    uint32_t                                    offset,
    uint32_t                                    size,
    const void*                                 pValues);

VKAPI_ATTR void VKAPI_CALL vkCmdBeginRenderPass(
    VkCommandBuffer                             commandBuffer,
    const VkRenderPassBeginInfo*                pRenderPassBegin,
    VkSubpassContents                           contents);

VKAPI_ATTR void VKAPI_CALL vkCmdNextSubpass(
    VkCommandBuffer                             commandBuffer,
    VkSubpassContents                           contents);

VKAPI_ATTR void VKAPI_CALL vkCmdEndRenderPass(
    VkCommandBuffer                             commandBuffer);

VKAPI_ATTR void VKAPI_CALL vkCmdExecuteCommands(
    VkCommandBuffer                             commandBuffer,
    uint32_t                                    commandBufferCount,
    const VkCommandBuffer*                      pCommandBuffers);
#endif

#define VK_KHR_surface 1
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkSurfaceKHR)

#define VK_KHR_SURFACE_SPEC_VERSION       25
#define VK_KHR_SURFACE_EXTENSION_NAME     "VK_KHR_surface"
#define VK_COLORSPACE_SRGB_NONLINEAR_KHR  VK_COLOR_SPACE_SRGB_NONLINEAR_KHR


typedef enum VkColorSpaceKHR {
    VK_COLOR_SPACE_SRGB_NONLINEAR_KHR = 0,
    VK_COLOR_SPACE_BEGIN_RANGE_KHR = VK_COLOR_SPACE_SRGB_NONLINEAR_KHR,
    VK_COLOR_SPACE_END_RANGE_KHR = VK_COLOR_SPACE_SRGB_NONLINEAR_KHR,
    VK_COLOR_SPACE_RANGE_SIZE_KHR = (VK_COLOR_SPACE_SRGB_NONLINEAR_KHR - VK_COLOR_SPACE_SRGB_NONLINEAR_KHR + 1),
    VK_COLOR_SPACE_MAX_ENUM_KHR = 0x7FFFFFFF
} VkColorSpaceKHR;

typedef enum VkPresentModeKHR {
    VK_PRESENT_MODE_IMMEDIATE_KHR = 0,
    VK_PRESENT_MODE_MAILBOX_KHR = 1,
    VK_PRESENT_MODE_FIFO_KHR = 2,
    VK_PRESENT_MODE_FIFO_RELAXED_KHR = 3,
    VK_PRESENT_MODE_BEGIN_RANGE_KHR = VK_PRESENT_MODE_IMMEDIATE_KHR,
    VK_PRESENT_MODE_END_RANGE_KHR = VK_PRESENT_MODE_FIFO_RELAXED_KHR,
    VK_PRESENT_MODE_RANGE_SIZE_KHR = (VK_PRESENT_MODE_FIFO_RELAXED_KHR - VK_PRESENT_MODE_IMMEDIATE_KHR + 1),
    VK_PRESENT_MODE_MAX_ENUM_KHR = 0x7FFFFFFF
} VkPresentModeKHR;


typedef enum VkSurfaceTransformFlagBitsKHR {
    VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR = 0x00000001,
    VK_SURFACE_TRANSFORM_ROTATE_90_BIT_KHR = 0x00000002,
    VK_SURFACE_TRANSFORM_ROTATE_180_BIT_KHR = 0x00000004,
    VK_SURFACE_TRANSFORM_ROTATE_270_BIT_KHR = 0x00000008,
    VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_BIT_KHR = 0x00000010,
    VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_90_BIT_KHR = 0x00000020,
    VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_180_BIT_KHR = 0x00000040,
    VK_SURFACE_TRANSFORM_HORIZONTAL_MIRROR_ROTATE_270_BIT_KHR = 0x00000080,
    VK_SURFACE_TRANSFORM_INHERIT_BIT_KHR = 0x00000100,
    VK_SURFACE_TRANSFORM_FLAG_BITS_MAX_ENUM_KHR = 0x7FFFFFFF
} VkSurfaceTransformFlagBitsKHR;
typedef VkFlags VkSurfaceTransformFlagsKHR;

typedef enum VkCompositeAlphaFlagBitsKHR {
    VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR = 0x00000001,
    VK_COMPOSITE_ALPHA_PRE_MULTIPLIED_BIT_KHR = 0x00000002,
    VK_COMPOSITE_ALPHA_POST_MULTIPLIED_BIT_KHR = 0x00000004,
    VK_COMPOSITE_ALPHA_INHERIT_BIT_KHR = 0x00000008,
    VK_COMPOSITE_ALPHA_FLAG_BITS_MAX_ENUM_KHR = 0x7FFFFFFF
} VkCompositeAlphaFlagBitsKHR;
typedef VkFlags VkCompositeAlphaFlagsKHR;

typedef struct VkSurfaceCapabilitiesKHR {
    uint32_t                         minImageCount;
    uint32_t                         maxImageCount;
    VkExtent2D                       currentExtent;
    VkExtent2D                       minImageExtent;
    VkExtent2D                       maxImageExtent;
    uint32_t                         maxImageArrayLayers;
    VkSurfaceTransformFlagsKHR       supportedTransforms;
    VkSurfaceTransformFlagBitsKHR    currentTransform;
    VkCompositeAlphaFlagsKHR         supportedCompositeAlpha;
    VkImageUsageFlags                supportedUsageFlags;
} VkSurfaceCapabilitiesKHR;

typedef struct VkSurfaceFormatKHR {
    VkFormat           format;
    VkColorSpaceKHR    colorSpace;
} VkSurfaceFormatKHR;


typedef void (VKAPI_PTR *PFN_vkDestroySurfaceKHR)(VkInstance instance, VkSurfaceKHR surface, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceSurfaceSupportKHR)(VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, VkSurfaceKHR surface, VkBool32* pSupported);
typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR)(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, VkSurfaceCapabilitiesKHR* pSurfaceCapabilities);
typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceSurfaceFormatsKHR)(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32_t* pSurfaceFormatCount, VkSurfaceFormatKHR* pSurfaceFormats);
typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceSurfacePresentModesKHR)(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32_t* pPresentModeCount, VkPresentModeKHR* pPresentModes);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR void VKAPI_CALL vkDestroySurfaceKHR(
    VkInstance                                  instance,
    VkSurfaceKHR                                surface,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceSurfaceSupportKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    queueFamilyIndex,
    VkSurfaceKHR                                surface,
    VkBool32*                                   pSupported);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceSurfaceCapabilitiesKHR(
    VkPhysicalDevice                            physicalDevice,
    VkSurfaceKHR                                surface,
    VkSurfaceCapabilitiesKHR*                   pSurfaceCapabilities);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceSurfaceFormatsKHR(
    VkPhysicalDevice                            physicalDevice,
    VkSurfaceKHR                                surface,
    uint32_t*                                   pSurfaceFormatCount,
    VkSurfaceFormatKHR*                         pSurfaceFormats);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceSurfacePresentModesKHR(
    VkPhysicalDevice                            physicalDevice,
    VkSurfaceKHR                                surface,
    uint32_t*                                   pPresentModeCount,
    VkPresentModeKHR*                           pPresentModes);
#endif

#define VK_KHR_swapchain 1
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkSwapchainKHR)

#define VK_KHR_SWAPCHAIN_SPEC_VERSION     68
#define VK_KHR_SWAPCHAIN_EXTENSION_NAME   "VK_KHR_swapchain"

typedef VkFlags VkSwapchainCreateFlagsKHR;

typedef struct VkSwapchainCreateInfoKHR {
    VkStructureType                  sType;
    const void*                      pNext;
    VkSwapchainCreateFlagsKHR        flags;
    VkSurfaceKHR                     surface;
    uint32_t                         minImageCount;
    VkFormat                         imageFormat;
    VkColorSpaceKHR                  imageColorSpace;
    VkExtent2D                       imageExtent;
    uint32_t                         imageArrayLayers;
    VkImageUsageFlags                imageUsage;
    VkSharingMode                    imageSharingMode;
    uint32_t                         queueFamilyIndexCount;
    const uint32_t*                  pQueueFamilyIndices;
    VkSurfaceTransformFlagBitsKHR    preTransform;
    VkCompositeAlphaFlagBitsKHR      compositeAlpha;
    VkPresentModeKHR                 presentMode;
    VkBool32                         clipped;
    VkSwapchainKHR                   oldSwapchain;
} VkSwapchainCreateInfoKHR;

typedef struct VkPresentInfoKHR {
    VkStructureType          sType;
    const void*              pNext;
    uint32_t                 waitSemaphoreCount;
    const VkSemaphore*       pWaitSemaphores;
    uint32_t                 swapchainCount;
    const VkSwapchainKHR*    pSwapchains;
    const uint32_t*          pImageIndices;
    VkResult*                pResults;
} VkPresentInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateSwapchainKHR)(VkDevice device, const VkSwapchainCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSwapchainKHR* pSwapchain);
typedef void (VKAPI_PTR *PFN_vkDestroySwapchainKHR)(VkDevice device, VkSwapchainKHR swapchain, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkGetSwapchainImagesKHR)(VkDevice device, VkSwapchainKHR swapchain, uint32_t* pSwapchainImageCount, VkImage* pSwapchainImages);
typedef VkResult (VKAPI_PTR *PFN_vkAcquireNextImageKHR)(VkDevice device, VkSwapchainKHR swapchain, uint64_t timeout, VkSemaphore semaphore, VkFence fence, uint32_t* pImageIndex);
typedef VkResult (VKAPI_PTR *PFN_vkQueuePresentKHR)(VkQueue queue, const VkPresentInfoKHR* pPresentInfo);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateSwapchainKHR(
    VkDevice                                    device,
    const VkSwapchainCreateInfoKHR*             pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSwapchainKHR*                             pSwapchain);

VKAPI_ATTR void VKAPI_CALL vkDestroySwapchainKHR(
    VkDevice                                    device,
    VkSwapchainKHR                              swapchain,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkGetSwapchainImagesKHR(
    VkDevice                                    device,
    VkSwapchainKHR                              swapchain,
    uint32_t*                                   pSwapchainImageCount,
    VkImage*                                    pSwapchainImages);

VKAPI_ATTR VkResult VKAPI_CALL vkAcquireNextImageKHR(
    VkDevice                                    device,
    VkSwapchainKHR                              swapchain,
    uint64_t                                    timeout,
    VkSemaphore                                 semaphore,
    VkFence                                     fence,
    uint32_t*                                   pImageIndex);

VKAPI_ATTR VkResult VKAPI_CALL vkQueuePresentKHR(
    VkQueue                                     queue,
    const VkPresentInfoKHR*                     pPresentInfo);
#endif

#define VK_KHR_display 1
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDisplayKHR)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDisplayModeKHR)

#define VK_KHR_DISPLAY_SPEC_VERSION       21
#define VK_KHR_DISPLAY_EXTENSION_NAME     "VK_KHR_display"


typedef enum VkDisplayPlaneAlphaFlagBitsKHR {
    VK_DISPLAY_PLANE_ALPHA_OPAQUE_BIT_KHR = 0x00000001,
    VK_DISPLAY_PLANE_ALPHA_GLOBAL_BIT_KHR = 0x00000002,
    VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_BIT_KHR = 0x00000004,
    VK_DISPLAY_PLANE_ALPHA_PER_PIXEL_PREMULTIPLIED_BIT_KHR = 0x00000008,
    VK_DISPLAY_PLANE_ALPHA_FLAG_BITS_MAX_ENUM_KHR = 0x7FFFFFFF
} VkDisplayPlaneAlphaFlagBitsKHR;
typedef VkFlags VkDisplayPlaneAlphaFlagsKHR;
typedef VkFlags VkDisplayModeCreateFlagsKHR;
typedef VkFlags VkDisplaySurfaceCreateFlagsKHR;

typedef struct VkDisplayPropertiesKHR {
    VkDisplayKHR                  display;
    const char*                   displayName;
    VkExtent2D                    physicalDimensions;
    VkExtent2D                    physicalResolution;
    VkSurfaceTransformFlagsKHR    supportedTransforms;
    VkBool32                      planeReorderPossible;
    VkBool32                      persistentContent;
} VkDisplayPropertiesKHR;

typedef struct VkDisplayModeParametersKHR {
    VkExtent2D    visibleRegion;
    uint32_t      refreshRate;
} VkDisplayModeParametersKHR;

typedef struct VkDisplayModePropertiesKHR {
    VkDisplayModeKHR              displayMode;
    VkDisplayModeParametersKHR    parameters;
} VkDisplayModePropertiesKHR;

typedef struct VkDisplayModeCreateInfoKHR {
    VkStructureType                sType;
    const void*                    pNext;
    VkDisplayModeCreateFlagsKHR    flags;
    VkDisplayModeParametersKHR     parameters;
} VkDisplayModeCreateInfoKHR;

typedef struct VkDisplayPlaneCapabilitiesKHR {
    VkDisplayPlaneAlphaFlagsKHR    supportedAlpha;
    VkOffset2D                     minSrcPosition;
    VkOffset2D                     maxSrcPosition;
    VkExtent2D                     minSrcExtent;
    VkExtent2D                     maxSrcExtent;
    VkOffset2D                     minDstPosition;
    VkOffset2D                     maxDstPosition;
    VkExtent2D                     minDstExtent;
    VkExtent2D                     maxDstExtent;
} VkDisplayPlaneCapabilitiesKHR;

typedef struct VkDisplayPlanePropertiesKHR {
    VkDisplayKHR    currentDisplay;
    uint32_t        currentStackIndex;
} VkDisplayPlanePropertiesKHR;

typedef struct VkDisplaySurfaceCreateInfoKHR {
    VkStructureType                   sType;
    const void*                       pNext;
    VkDisplaySurfaceCreateFlagsKHR    flags;
    VkDisplayModeKHR                  displayMode;
    uint32_t                          planeIndex;
    uint32_t                          planeStackIndex;
    VkSurfaceTransformFlagBitsKHR     transform;
    float                             globalAlpha;
    VkDisplayPlaneAlphaFlagBitsKHR    alphaMode;
    VkExtent2D                        imageExtent;
} VkDisplaySurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceDisplayPropertiesKHR)(VkPhysicalDevice physicalDevice, uint32_t* pPropertyCount, VkDisplayPropertiesKHR* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceDisplayPlanePropertiesKHR)(VkPhysicalDevice physicalDevice, uint32_t* pPropertyCount, VkDisplayPlanePropertiesKHR* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkGetDisplayPlaneSupportedDisplaysKHR)(VkPhysicalDevice physicalDevice, uint32_t planeIndex, uint32_t* pDisplayCount, VkDisplayKHR* pDisplays);
typedef VkResult (VKAPI_PTR *PFN_vkGetDisplayModePropertiesKHR)(VkPhysicalDevice physicalDevice, VkDisplayKHR display, uint32_t* pPropertyCount, VkDisplayModePropertiesKHR* pProperties);
typedef VkResult (VKAPI_PTR *PFN_vkCreateDisplayModeKHR)(VkPhysicalDevice physicalDevice, VkDisplayKHR display, const VkDisplayModeCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkDisplayModeKHR* pMode);
typedef VkResult (VKAPI_PTR *PFN_vkGetDisplayPlaneCapabilitiesKHR)(VkPhysicalDevice physicalDevice, VkDisplayModeKHR mode, uint32_t planeIndex, VkDisplayPlaneCapabilitiesKHR* pCapabilities);
typedef VkResult (VKAPI_PTR *PFN_vkCreateDisplayPlaneSurfaceKHR)(VkInstance instance, const VkDisplaySurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceDisplayPropertiesKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t*                                   pPropertyCount,
    VkDisplayPropertiesKHR*                     pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceDisplayPlanePropertiesKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t*                                   pPropertyCount,
    VkDisplayPlanePropertiesKHR*                pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkGetDisplayPlaneSupportedDisplaysKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    planeIndex,
    uint32_t*                                   pDisplayCount,
    VkDisplayKHR*                               pDisplays);

VKAPI_ATTR VkResult VKAPI_CALL vkGetDisplayModePropertiesKHR(
    VkPhysicalDevice                            physicalDevice,
    VkDisplayKHR                                display,
    uint32_t*                                   pPropertyCount,
    VkDisplayModePropertiesKHR*                 pProperties);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateDisplayModeKHR(
    VkPhysicalDevice                            physicalDevice,
    VkDisplayKHR                                display,
    const VkDisplayModeCreateInfoKHR*           pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkDisplayModeKHR*                           pMode);

VKAPI_ATTR VkResult VKAPI_CALL vkGetDisplayPlaneCapabilitiesKHR(
    VkPhysicalDevice                            physicalDevice,
    VkDisplayModeKHR                            mode,
    uint32_t                                    planeIndex,
    VkDisplayPlaneCapabilitiesKHR*              pCapabilities);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateDisplayPlaneSurfaceKHR(
    VkInstance                                  instance,
    const VkDisplaySurfaceCreateInfoKHR*        pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);
#endif

#define VK_KHR_display_swapchain 1
#define VK_KHR_DISPLAY_SWAPCHAIN_SPEC_VERSION 9
#define VK_KHR_DISPLAY_SWAPCHAIN_EXTENSION_NAME "VK_KHR_display_swapchain"

typedef struct VkDisplayPresentInfoKHR {
    VkStructureType    sType;
    const void*        pNext;
    VkRect2D           srcRect;
    VkRect2D           dstRect;
    VkBool32           persistent;
} VkDisplayPresentInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateSharedSwapchainsKHR)(VkDevice device, uint32_t swapchainCount, const VkSwapchainCreateInfoKHR* pCreateInfos, const VkAllocationCallbacks* pAllocator, VkSwapchainKHR* pSwapchains);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateSharedSwapchainsKHR(
    VkDevice                                    device,
    uint32_t                                    swapchainCount,
    const VkSwapchainCreateInfoKHR*             pCreateInfos,
    const VkAllocationCallbacks*                pAllocator,
    VkSwapchainKHR*                             pSwapchains);
#endif

#ifdef VK_USE_PLATFORM_XLIB_KHR
#define VK_KHR_xlib_surface 1
#include <X11/Xlib.h>

#define VK_KHR_XLIB_SURFACE_SPEC_VERSION  6
#define VK_KHR_XLIB_SURFACE_EXTENSION_NAME "VK_KHR_xlib_surface"

typedef VkFlags VkXlibSurfaceCreateFlagsKHR;

typedef struct VkXlibSurfaceCreateInfoKHR {
    VkStructureType                sType;
    const void*                    pNext;
    VkXlibSurfaceCreateFlagsKHR    flags;
    Display*                       dpy;
    Window                         window;
} VkXlibSurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateXlibSurfaceKHR)(VkInstance instance, const VkXlibSurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
typedef VkBool32 (VKAPI_PTR *PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR)(VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, Display* dpy, VisualID visualID);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateXlibSurfaceKHR(
    VkInstance                                  instance,
    const VkXlibSurfaceCreateInfoKHR*           pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);

VKAPI_ATTR VkBool32 VKAPI_CALL vkGetPhysicalDeviceXlibPresentationSupportKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    queueFamilyIndex,
    Display*                                    dpy,
    VisualID                                    visualID);
#endif
#endif /* VK_USE_PLATFORM_XLIB_KHR */

#ifdef VK_USE_PLATFORM_XCB_KHR
#define VK_KHR_xcb_surface 1
#include <xcb/xcb.h>

#define VK_KHR_XCB_SURFACE_SPEC_VERSION   6
#define VK_KHR_XCB_SURFACE_EXTENSION_NAME "VK_KHR_xcb_surface"

typedef VkFlags VkXcbSurfaceCreateFlagsKHR;

typedef struct VkXcbSurfaceCreateInfoKHR {
    VkStructureType               sType;
    const void*                   pNext;
    VkXcbSurfaceCreateFlagsKHR    flags;
    xcb_connection_t*             connection;
    xcb_window_t                  window;
} VkXcbSurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateXcbSurfaceKHR)(VkInstance instance, const VkXcbSurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
typedef VkBool32 (VKAPI_PTR *PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR)(VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, xcb_connection_t* connection, xcb_visualid_t visual_id);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateXcbSurfaceKHR(
    VkInstance                                  instance,
    const VkXcbSurfaceCreateInfoKHR*            pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);

VKAPI_ATTR VkBool32 VKAPI_CALL vkGetPhysicalDeviceXcbPresentationSupportKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    queueFamilyIndex,
    xcb_connection_t*                           connection,
    xcb_visualid_t                              visual_id);
#endif
#endif /* VK_USE_PLATFORM_XCB_KHR */

#ifdef VK_USE_PLATFORM_WAYLAND_KHR
#define VK_KHR_wayland_surface 1
#include <wayland-client.h>

#define VK_KHR_WAYLAND_SURFACE_SPEC_VERSION 5
#define VK_KHR_WAYLAND_SURFACE_EXTENSION_NAME "VK_KHR_wayland_surface"

typedef VkFlags VkWaylandSurfaceCreateFlagsKHR;

typedef struct VkWaylandSurfaceCreateInfoKHR {
    VkStructureType                   sType;
    const void*                       pNext;
    VkWaylandSurfaceCreateFlagsKHR    flags;
    struct wl_display*                display;
    struct wl_surface*                surface;
} VkWaylandSurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateWaylandSurfaceKHR)(VkInstance instance, const VkWaylandSurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
typedef VkBool32 (VKAPI_PTR *PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR)(VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, struct wl_display* display);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateWaylandSurfaceKHR(
    VkInstance                                  instance,
    const VkWaylandSurfaceCreateInfoKHR*        pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);

VKAPI_ATTR VkBool32 VKAPI_CALL vkGetPhysicalDeviceWaylandPresentationSupportKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    queueFamilyIndex,
    struct wl_display*                          display);
#endif
#endif /* VK_USE_PLATFORM_WAYLAND_KHR */

#ifdef VK_USE_PLATFORM_MIR_KHR
#define VK_KHR_mir_surface 1
#include <mir_toolkit/client_types.h>

#define VK_KHR_MIR_SURFACE_SPEC_VERSION   4
#define VK_KHR_MIR_SURFACE_EXTENSION_NAME "VK_KHR_mir_surface"

typedef VkFlags VkMirSurfaceCreateFlagsKHR;

typedef struct VkMirSurfaceCreateInfoKHR {
    VkStructureType               sType;
    const void*                   pNext;
    VkMirSurfaceCreateFlagsKHR    flags;
    MirConnection*                connection;
    MirSurface*                   mirSurface;
} VkMirSurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateMirSurfaceKHR)(VkInstance instance, const VkMirSurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
typedef VkBool32 (VKAPI_PTR *PFN_vkGetPhysicalDeviceMirPresentationSupportKHR)(VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex, MirConnection* connection);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateMirSurfaceKHR(
    VkInstance                                  instance,
    const VkMirSurfaceCreateInfoKHR*            pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);

VKAPI_ATTR VkBool32 VKAPI_CALL vkGetPhysicalDeviceMirPresentationSupportKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    queueFamilyIndex,
    MirConnection*                              connection);
#endif
#endif /* VK_USE_PLATFORM_MIR_KHR */

#ifdef VK_USE_PLATFORM_ANDROID_KHR
#define VK_KHR_android_surface 1
#include <android/native_window.h>

#define VK_KHR_ANDROID_SURFACE_SPEC_VERSION 6
#define VK_KHR_ANDROID_SURFACE_EXTENSION_NAME "VK_KHR_android_surface"

typedef VkFlags VkAndroidSurfaceCreateFlagsKHR;

typedef struct VkAndroidSurfaceCreateInfoKHR {
    VkStructureType                   sType;
    const void*                       pNext;
    VkAndroidSurfaceCreateFlagsKHR    flags;
    ANativeWindow*                    window;
} VkAndroidSurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateAndroidSurfaceKHR)(VkInstance instance, const VkAndroidSurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateAndroidSurfaceKHR(
    VkInstance                                  instance,
    const VkAndroidSurfaceCreateInfoKHR*        pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);
#endif
#endif /* VK_USE_PLATFORM_ANDROID_KHR */

#ifdef VK_USE_PLATFORM_WIN32_KHR
#define VK_KHR_win32_surface 1
#include <windows.h>

#define VK_KHR_WIN32_SURFACE_SPEC_VERSION 5
#define VK_KHR_WIN32_SURFACE_EXTENSION_NAME "VK_KHR_win32_surface"

typedef VkFlags VkWin32SurfaceCreateFlagsKHR;

typedef struct VkWin32SurfaceCreateInfoKHR {
    VkStructureType                 sType;
    const void*                     pNext;
    VkWin32SurfaceCreateFlagsKHR    flags;
    HINSTANCE                       hinstance;
    HWND                            hwnd;
} VkWin32SurfaceCreateInfoKHR;


typedef VkResult (VKAPI_PTR *PFN_vkCreateWin32SurfaceKHR)(VkInstance instance, const VkWin32SurfaceCreateInfoKHR* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
typedef VkBool32 (VKAPI_PTR *PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR)(VkPhysicalDevice physicalDevice, uint32_t queueFamilyIndex);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateWin32SurfaceKHR(
    VkInstance                                  instance,
    const VkWin32SurfaceCreateInfoKHR*          pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkSurfaceKHR*                               pSurface);

VKAPI_ATTR VkBool32 VKAPI_CALL vkGetPhysicalDeviceWin32PresentationSupportKHR(
    VkPhysicalDevice                            physicalDevice,
    uint32_t                                    queueFamilyIndex);
#endif
#endif /* VK_USE_PLATFORM_WIN32_KHR */
]]

vulkan_extensions = [[

#define VK_KHR_sampler_mirror_clamp_to_edge 1
#define VK_KHR_SAMPLER_MIRROR_CLAMP_TO_EDGE_SPEC_VERSION 1
#define VK_KHR_SAMPLER_MIRROR_CLAMP_TO_EDGE_EXTENSION_NAME "VK_KHR_sampler_mirror_clamp_to_edge"

#define VK_EXT_debug_report 1
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkDebugReportCallbackEXT)

#define VK_EXT_DEBUG_REPORT_SPEC_VERSION  4
#define VK_EXT_DEBUG_REPORT_EXTENSION_NAME "VK_EXT_debug_report"
#define VK_STRUCTURE_TYPE_DEBUG_REPORT_CREATE_INFO_EXT VK_STRUCTURE_TYPE_DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT


typedef enum VkDebugReportObjectTypeEXT {
    VK_DEBUG_REPORT_OBJECT_TYPE_UNKNOWN_EXT = 0,
    VK_DEBUG_REPORT_OBJECT_TYPE_INSTANCE_EXT = 1,
    VK_DEBUG_REPORT_OBJECT_TYPE_PHYSICAL_DEVICE_EXT = 2,
    VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_EXT = 3,
    VK_DEBUG_REPORT_OBJECT_TYPE_QUEUE_EXT = 4,
    VK_DEBUG_REPORT_OBJECT_TYPE_SEMAPHORE_EXT = 5,
    VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_BUFFER_EXT = 6,
    VK_DEBUG_REPORT_OBJECT_TYPE_FENCE_EXT = 7,
    VK_DEBUG_REPORT_OBJECT_TYPE_DEVICE_MEMORY_EXT = 8,
    VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_EXT = 9,
    VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_EXT = 10,
    VK_DEBUG_REPORT_OBJECT_TYPE_EVENT_EXT = 11,
    VK_DEBUG_REPORT_OBJECT_TYPE_QUERY_POOL_EXT = 12,
    VK_DEBUG_REPORT_OBJECT_TYPE_BUFFER_VIEW_EXT = 13,
    VK_DEBUG_REPORT_OBJECT_TYPE_IMAGE_VIEW_EXT = 14,
    VK_DEBUG_REPORT_OBJECT_TYPE_SHADER_MODULE_EXT = 15,
    VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_CACHE_EXT = 16,
    VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_LAYOUT_EXT = 17,
    VK_DEBUG_REPORT_OBJECT_TYPE_RENDER_PASS_EXT = 18,
    VK_DEBUG_REPORT_OBJECT_TYPE_PIPELINE_EXT = 19,
    VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_LAYOUT_EXT = 20,
    VK_DEBUG_REPORT_OBJECT_TYPE_SAMPLER_EXT = 21,
    VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_POOL_EXT = 22,
    VK_DEBUG_REPORT_OBJECT_TYPE_DESCRIPTOR_SET_EXT = 23,
    VK_DEBUG_REPORT_OBJECT_TYPE_FRAMEBUFFER_EXT = 24,
    VK_DEBUG_REPORT_OBJECT_TYPE_COMMAND_POOL_EXT = 25,
    VK_DEBUG_REPORT_OBJECT_TYPE_SURFACE_KHR_EXT = 26,
    VK_DEBUG_REPORT_OBJECT_TYPE_SWAPCHAIN_KHR_EXT = 27,
    VK_DEBUG_REPORT_OBJECT_TYPE_DEBUG_REPORT_EXT = 28,
    VK_DEBUG_REPORT_OBJECT_TYPE_DISPLAY_KHR_EXT = 29,
    VK_DEBUG_REPORT_OBJECT_TYPE_DISPLAY_MODE_KHR_EXT = 30,
    VK_DEBUG_REPORT_OBJECT_TYPE_OBJECT_TABLE_NVX_EXT = 31,
    VK_DEBUG_REPORT_OBJECT_TYPE_INDIRECT_COMMANDS_LAYOUT_NVX_EXT = 32,
    VK_DEBUG_REPORT_OBJECT_TYPE_BEGIN_RANGE_EXT = VK_DEBUG_REPORT_OBJECT_TYPE_UNKNOWN_EXT,
    VK_DEBUG_REPORT_OBJECT_TYPE_END_RANGE_EXT = VK_DEBUG_REPORT_OBJECT_TYPE_INDIRECT_COMMANDS_LAYOUT_NVX_EXT,
    VK_DEBUG_REPORT_OBJECT_TYPE_RANGE_SIZE_EXT = (VK_DEBUG_REPORT_OBJECT_TYPE_INDIRECT_COMMANDS_LAYOUT_NVX_EXT - VK_DEBUG_REPORT_OBJECT_TYPE_UNKNOWN_EXT + 1),
    VK_DEBUG_REPORT_OBJECT_TYPE_MAX_ENUM_EXT = 0x7FFFFFFF
} VkDebugReportObjectTypeEXT;

typedef enum VkDebugReportErrorEXT {
    VK_DEBUG_REPORT_ERROR_NONE_EXT = 0,
    VK_DEBUG_REPORT_ERROR_CALLBACK_REF_EXT = 1,
    VK_DEBUG_REPORT_ERROR_BEGIN_RANGE_EXT = VK_DEBUG_REPORT_ERROR_NONE_EXT,
    VK_DEBUG_REPORT_ERROR_END_RANGE_EXT = VK_DEBUG_REPORT_ERROR_CALLBACK_REF_EXT,
    VK_DEBUG_REPORT_ERROR_RANGE_SIZE_EXT = (VK_DEBUG_REPORT_ERROR_CALLBACK_REF_EXT - VK_DEBUG_REPORT_ERROR_NONE_EXT + 1),
    VK_DEBUG_REPORT_ERROR_MAX_ENUM_EXT = 0x7FFFFFFF
} VkDebugReportErrorEXT;


typedef enum VkDebugReportFlagBitsEXT {
    VK_DEBUG_REPORT_INFORMATION_BIT_EXT = 0x00000001,
    VK_DEBUG_REPORT_WARNING_BIT_EXT = 0x00000002,
    VK_DEBUG_REPORT_PERFORMANCE_WARNING_BIT_EXT = 0x00000004,
    VK_DEBUG_REPORT_ERROR_BIT_EXT = 0x00000008,
    VK_DEBUG_REPORT_DEBUG_BIT_EXT = 0x00000010,
    VK_DEBUG_REPORT_FLAG_BITS_MAX_ENUM_EXT = 0x7FFFFFFF
} VkDebugReportFlagBitsEXT;
typedef VkFlags VkDebugReportFlagsEXT;

typedef VkBool32 (VKAPI_PTR *PFN_vkDebugReportCallbackEXT)(
    VkDebugReportFlagsEXT                       flags,
    VkDebugReportObjectTypeEXT                  objectType,
    uint64_t                                    object,
    size_t                                      location,
    int32_t                                     messageCode,
    const char*                                 pLayerPrefix,
    const char*                                 pMessage,
    void*                                       pUserData);


typedef struct VkDebugReportCallbackCreateInfoEXT {
    VkStructureType                 sType;
    const void*                     pNext;
    VkDebugReportFlagsEXT           flags;
    PFN_vkDebugReportCallbackEXT    pfnCallback;
    void*                           pUserData;
} VkDebugReportCallbackCreateInfoEXT;


typedef VkResult (VKAPI_PTR *PFN_vkCreateDebugReportCallbackEXT)(VkInstance instance, const VkDebugReportCallbackCreateInfoEXT* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkDebugReportCallbackEXT* pCallback);
typedef void (VKAPI_PTR *PFN_vkDestroyDebugReportCallbackEXT)(VkInstance instance, VkDebugReportCallbackEXT callback, const VkAllocationCallbacks* pAllocator);
typedef void (VKAPI_PTR *PFN_vkDebugReportMessageEXT)(VkInstance instance, VkDebugReportFlagsEXT flags, VkDebugReportObjectTypeEXT objectType, uint64_t object, size_t location, int32_t messageCode, const char* pLayerPrefix, const char* pMessage);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkCreateDebugReportCallbackEXT(
    VkInstance                                  instance,
    const VkDebugReportCallbackCreateInfoEXT*   pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkDebugReportCallbackEXT*                   pCallback);

VKAPI_ATTR void VKAPI_CALL vkDestroyDebugReportCallbackEXT(
    VkInstance                                  instance,
    VkDebugReportCallbackEXT                    callback,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR void VKAPI_CALL vkDebugReportMessageEXT(
    VkInstance                                  instance,
    VkDebugReportFlagsEXT                       flags,
    VkDebugReportObjectTypeEXT                  objectType,
    uint64_t                                    object,
    size_t                                      location,
    int32_t                                     messageCode,
    const char*                                 pLayerPrefix,
    const char*                                 pMessage);
#endif

#define VK_NV_glsl_shader 1
#define VK_NV_GLSL_SHADER_SPEC_VERSION    1
#define VK_NV_GLSL_SHADER_EXTENSION_NAME  "VK_NV_glsl_shader"


#define VK_IMG_filter_cubic 1
#define VK_IMG_FILTER_CUBIC_SPEC_VERSION  1
#define VK_IMG_FILTER_CUBIC_EXTENSION_NAME "VK_IMG_filter_cubic"


#define VK_AMD_rasterization_order 1
#define VK_AMD_RASTERIZATION_ORDER_SPEC_VERSION 1
#define VK_AMD_RASTERIZATION_ORDER_EXTENSION_NAME "VK_AMD_rasterization_order"


typedef enum VkRasterizationOrderAMD {
    VK_RASTERIZATION_ORDER_STRICT_AMD = 0,
    VK_RASTERIZATION_ORDER_RELAXED_AMD = 1,
    VK_RASTERIZATION_ORDER_BEGIN_RANGE_AMD = VK_RASTERIZATION_ORDER_STRICT_AMD,
    VK_RASTERIZATION_ORDER_END_RANGE_AMD = VK_RASTERIZATION_ORDER_RELAXED_AMD,
    VK_RASTERIZATION_ORDER_RANGE_SIZE_AMD = (VK_RASTERIZATION_ORDER_RELAXED_AMD - VK_RASTERIZATION_ORDER_STRICT_AMD + 1),
    VK_RASTERIZATION_ORDER_MAX_ENUM_AMD = 0x7FFFFFFF
} VkRasterizationOrderAMD;

typedef struct VkPipelineRasterizationStateRasterizationOrderAMD {
    VkStructureType            sType;
    const void*                pNext;
    VkRasterizationOrderAMD    rasterizationOrder;
} VkPipelineRasterizationStateRasterizationOrderAMD;



#define VK_AMD_shader_trinary_minmax 1
#define VK_AMD_SHADER_TRINARY_MINMAX_SPEC_VERSION 1
#define VK_AMD_SHADER_TRINARY_MINMAX_EXTENSION_NAME "VK_AMD_shader_trinary_minmax"


#define VK_AMD_shader_explicit_vertex_parameter 1
#define VK_AMD_SHADER_EXPLICIT_VERTEX_PARAMETER_SPEC_VERSION 1
#define VK_AMD_SHADER_EXPLICIT_VERTEX_PARAMETER_EXTENSION_NAME "VK_AMD_shader_explicit_vertex_parameter"


#define VK_EXT_debug_marker 1
#define VK_EXT_DEBUG_MARKER_SPEC_VERSION  3
#define VK_EXT_DEBUG_MARKER_EXTENSION_NAME "VK_EXT_debug_marker"

typedef struct VkDebugMarkerObjectNameInfoEXT {
    VkStructureType               sType;
    const void*                   pNext;
    VkDebugReportObjectTypeEXT    objectType;
    uint64_t                      object;
    const char*                   pObjectName;
} VkDebugMarkerObjectNameInfoEXT;

typedef struct VkDebugMarkerObjectTagInfoEXT {
    VkStructureType               sType;
    const void*                   pNext;
    VkDebugReportObjectTypeEXT    objectType;
    uint64_t                      object;
    uint64_t                      tagName;
    size_t                        tagSize;
    const void*                   pTag;
} VkDebugMarkerObjectTagInfoEXT;

typedef struct VkDebugMarkerMarkerInfoEXT {
    VkStructureType    sType;
    const void*        pNext;
    const char*        pMarkerName;
    float              color[4];
} VkDebugMarkerMarkerInfoEXT;


typedef VkResult (VKAPI_PTR *PFN_vkDebugMarkerSetObjectTagEXT)(VkDevice device, VkDebugMarkerObjectTagInfoEXT* pTagInfo);
typedef VkResult (VKAPI_PTR *PFN_vkDebugMarkerSetObjectNameEXT)(VkDevice device, VkDebugMarkerObjectNameInfoEXT* pNameInfo);
typedef void (VKAPI_PTR *PFN_vkCmdDebugMarkerBeginEXT)(VkCommandBuffer commandBuffer, VkDebugMarkerMarkerInfoEXT* pMarkerInfo);
typedef void (VKAPI_PTR *PFN_vkCmdDebugMarkerEndEXT)(VkCommandBuffer commandBuffer);
typedef void (VKAPI_PTR *PFN_vkCmdDebugMarkerInsertEXT)(VkCommandBuffer commandBuffer, VkDebugMarkerMarkerInfoEXT* pMarkerInfo);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkDebugMarkerSetObjectTagEXT(
    VkDevice                                    device,
    VkDebugMarkerObjectTagInfoEXT*              pTagInfo);

VKAPI_ATTR VkResult VKAPI_CALL vkDebugMarkerSetObjectNameEXT(
    VkDevice                                    device,
    VkDebugMarkerObjectNameInfoEXT*             pNameInfo);

VKAPI_ATTR void VKAPI_CALL vkCmdDebugMarkerBeginEXT(
    VkCommandBuffer                             commandBuffer,
    VkDebugMarkerMarkerInfoEXT*                 pMarkerInfo);

VKAPI_ATTR void VKAPI_CALL vkCmdDebugMarkerEndEXT(
    VkCommandBuffer                             commandBuffer);

VKAPI_ATTR void VKAPI_CALL vkCmdDebugMarkerInsertEXT(
    VkCommandBuffer                             commandBuffer,
    VkDebugMarkerMarkerInfoEXT*                 pMarkerInfo);
#endif

#define VK_AMD_gcn_shader 1
#define VK_AMD_GCN_SHADER_SPEC_VERSION    1
#define VK_AMD_GCN_SHADER_EXTENSION_NAME  "VK_AMD_gcn_shader"


#define VK_NV_dedicated_allocation 1
#define VK_NV_DEDICATED_ALLOCATION_SPEC_VERSION 1
#define VK_NV_DEDICATED_ALLOCATION_EXTENSION_NAME "VK_NV_dedicated_allocation"

typedef struct VkDedicatedAllocationImageCreateInfoNV {
    VkStructureType    sType;
    const void*        pNext;
    VkBool32           dedicatedAllocation;
} VkDedicatedAllocationImageCreateInfoNV;

typedef struct VkDedicatedAllocationBufferCreateInfoNV {
    VkStructureType    sType;
    const void*        pNext;
    VkBool32           dedicatedAllocation;
} VkDedicatedAllocationBufferCreateInfoNV;

typedef struct VkDedicatedAllocationMemoryAllocateInfoNV {
    VkStructureType    sType;
    const void*        pNext;
    VkImage            image;
    VkBuffer           buffer;
} VkDedicatedAllocationMemoryAllocateInfoNV;



#define VK_AMD_draw_indirect_count 1
#define VK_AMD_DRAW_INDIRECT_COUNT_SPEC_VERSION 1
#define VK_AMD_DRAW_INDIRECT_COUNT_EXTENSION_NAME "VK_AMD_draw_indirect_count"

typedef void (VKAPI_PTR *PFN_vkCmdDrawIndirectCountAMD)(VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, VkBuffer countBuffer, VkDeviceSize countBufferOffset, uint32_t maxDrawCount, uint32_t stride);
typedef void (VKAPI_PTR *PFN_vkCmdDrawIndexedIndirectCountAMD)(VkCommandBuffer commandBuffer, VkBuffer buffer, VkDeviceSize offset, VkBuffer countBuffer, VkDeviceSize countBufferOffset, uint32_t maxDrawCount, uint32_t stride);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR void VKAPI_CALL vkCmdDrawIndirectCountAMD(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    buffer,
    VkDeviceSize                                offset,
    VkBuffer                                    countBuffer,
    VkDeviceSize                                countBufferOffset,
    uint32_t                                    maxDrawCount,
    uint32_t                                    stride);

VKAPI_ATTR void VKAPI_CALL vkCmdDrawIndexedIndirectCountAMD(
    VkCommandBuffer                             commandBuffer,
    VkBuffer                                    buffer,
    VkDeviceSize                                offset,
    VkBuffer                                    countBuffer,
    VkDeviceSize                                countBufferOffset,
    uint32_t                                    maxDrawCount,
    uint32_t                                    stride);
#endif

#define VK_AMD_negative_viewport_height 1
#define VK_AMD_NEGATIVE_VIEWPORT_HEIGHT_SPEC_VERSION 1
#define VK_AMD_NEGATIVE_VIEWPORT_HEIGHT_EXTENSION_NAME "VK_AMD_negative_viewport_height"


#define VK_AMD_gpu_shader_half_float 1
#define VK_AMD_GPU_SHADER_HALF_FLOAT_SPEC_VERSION 1
#define VK_AMD_GPU_SHADER_HALF_FLOAT_EXTENSION_NAME "VK_AMD_gpu_shader_half_float"


#define VK_AMD_shader_ballot 1
#define VK_AMD_SHADER_BALLOT_SPEC_VERSION 1
#define VK_AMD_SHADER_BALLOT_EXTENSION_NAME "VK_AMD_shader_ballot"


#define VK_IMG_format_pvrtc 1
#define VK_IMG_FORMAT_PVRTC_SPEC_VERSION  1
#define VK_IMG_FORMAT_PVRTC_EXTENSION_NAME "VK_IMG_format_pvrtc"


#define VK_NV_external_memory_capabilities 1
#define VK_NV_EXTERNAL_MEMORY_CAPABILITIES_SPEC_VERSION 1
#define VK_NV_EXTERNAL_MEMORY_CAPABILITIES_EXTENSION_NAME "VK_NV_external_memory_capabilities"


typedef enum VkExternalMemoryHandleTypeFlagBitsNV {
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_BIT_NV = 0x00000001,
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT_NV = 0x00000002,
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_IMAGE_BIT_NV = 0x00000004,
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_D3D11_IMAGE_KMT_BIT_NV = 0x00000008,
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_FLAG_BITS_MAX_ENUM_NV = 0x7FFFFFFF
} VkExternalMemoryHandleTypeFlagBitsNV;
typedef VkFlags VkExternalMemoryHandleTypeFlagsNV;

typedef enum VkExternalMemoryFeatureFlagBitsNV {
    VK_EXTERNAL_MEMORY_FEATURE_DEDICATED_ONLY_BIT_NV = 0x00000001,
    VK_EXTERNAL_MEMORY_FEATURE_EXPORTABLE_BIT_NV = 0x00000002,
    VK_EXTERNAL_MEMORY_FEATURE_IMPORTABLE_BIT_NV = 0x00000004,
    VK_EXTERNAL_MEMORY_FEATURE_FLAG_BITS_MAX_ENUM_NV = 0x7FFFFFFF
} VkExternalMemoryFeatureFlagBitsNV;
typedef VkFlags VkExternalMemoryFeatureFlagsNV;

typedef struct VkExternalImageFormatPropertiesNV {
    VkImageFormatProperties              imageFormatProperties;
    VkExternalMemoryFeatureFlagsNV       externalMemoryFeatures;
    VkExternalMemoryHandleTypeFlagsNV    exportFromImportedHandleTypes;
    VkExternalMemoryHandleTypeFlagsNV    compatibleHandleTypes;
} VkExternalImageFormatPropertiesNV;


typedef VkResult (VKAPI_PTR *PFN_vkGetPhysicalDeviceExternalImageFormatPropertiesNV)(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkExternalMemoryHandleTypeFlagsNV externalHandleType, VkExternalImageFormatPropertiesNV* pExternalImageFormatProperties);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkGetPhysicalDeviceExternalImageFormatPropertiesNV(
    VkPhysicalDevice                            physicalDevice,
    VkFormat                                    format,
    VkImageType                                 type,
    VkImageTiling                               tiling,
    VkImageUsageFlags                           usage,
    VkImageCreateFlags                          flags,
    VkExternalMemoryHandleTypeFlagsNV           externalHandleType,
    VkExternalImageFormatPropertiesNV*          pExternalImageFormatProperties);
#endif

#define VK_NV_external_memory 1
#define VK_NV_EXTERNAL_MEMORY_SPEC_VERSION 1
#define VK_NV_EXTERNAL_MEMORY_EXTENSION_NAME "VK_NV_external_memory"

typedef struct VkExternalMemoryImageCreateInfoNV {
    VkStructureType                      sType;
    const void*                          pNext;
    VkExternalMemoryHandleTypeFlagsNV    handleTypes;
} VkExternalMemoryImageCreateInfoNV;

typedef struct VkExportMemoryAllocateInfoNV {
    VkStructureType                      sType;
    const void*                          pNext;
    VkExternalMemoryHandleTypeFlagsNV    handleTypes;
} VkExportMemoryAllocateInfoNV;



#ifdef VK_USE_PLATFORM_WIN32_KHR
#define VK_NV_external_memory_win32 1
#define VK_NV_EXTERNAL_MEMORY_WIN32_SPEC_VERSION 1
#define VK_NV_EXTERNAL_MEMORY_WIN32_EXTENSION_NAME "VK_NV_external_memory_win32"

typedef struct VkImportMemoryWin32HandleInfoNV {
    VkStructureType                      sType;
    const void*                          pNext;
    VkExternalMemoryHandleTypeFlagsNV    handleType;
    HANDLE                               handle;
} VkImportMemoryWin32HandleInfoNV;

typedef struct VkExportMemoryWin32HandleInfoNV {
    VkStructureType               sType;
    const void*                   pNext;
    const SECURITY_ATTRIBUTES*    pAttributes;
    DWORD                         dwAccess;
} VkExportMemoryWin32HandleInfoNV;


typedef VkResult (VKAPI_PTR *PFN_vkGetMemoryWin32HandleNV)(VkDevice device, VkDeviceMemory memory, VkExternalMemoryHandleTypeFlagsNV handleType, HANDLE* pHandle);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR VkResult VKAPI_CALL vkGetMemoryWin32HandleNV(
    VkDevice                                    device,
    VkDeviceMemory                              memory,
    VkExternalMemoryHandleTypeFlagsNV           handleType,
    HANDLE*                                     pHandle);
#endif
#endif /* VK_USE_PLATFORM_WIN32_KHR */

#ifdef VK_USE_PLATFORM_WIN32_KHR
#define VK_NV_win32_keyed_mutex 1
#define VK_NV_WIN32_KEYED_MUTEX_SPEC_VERSION 1
#define VK_NV_WIN32_KEYED_MUTEX_EXTENSION_NAME "VK_NV_win32_keyed_mutex"

typedef struct VkWin32KeyedMutexAcquireReleaseInfoNV {
    VkStructureType          sType;
    const void*              pNext;
    uint32_t                 acquireCount;
    const VkDeviceMemory*    pAcquireSyncs;
    const uint64_t*          pAcquireKeys;
    const uint32_t*          pAcquireTimeoutMilliseconds;
    uint32_t                 releaseCount;
    const VkDeviceMemory*    pReleaseSyncs;
    const uint64_t*          pReleaseKeys;
} VkWin32KeyedMutexAcquireReleaseInfoNV;


#endif /* VK_USE_PLATFORM_WIN32_KHR */

#define VK_EXT_validation_flags 1
#define VK_EXT_VALIDATION_FLAGS_SPEC_VERSION 1
#define VK_EXT_VALIDATION_FLAGS_EXTENSION_NAME "VK_EXT_validation_flags"


typedef enum VkValidationCheckEXT {
    VK_VALIDATION_CHECK_ALL_EXT = 0,
    VK_VALIDATION_CHECK_BEGIN_RANGE_EXT = VK_VALIDATION_CHECK_ALL_EXT,
    VK_VALIDATION_CHECK_END_RANGE_EXT = VK_VALIDATION_CHECK_ALL_EXT,
    VK_VALIDATION_CHECK_RANGE_SIZE_EXT = (VK_VALIDATION_CHECK_ALL_EXT - VK_VALIDATION_CHECK_ALL_EXT + 1),
    VK_VALIDATION_CHECK_MAX_ENUM_EXT = 0x7FFFFFFF
} VkValidationCheckEXT;

typedef struct VkValidationFlagsEXT {
    VkStructureType          sType;
    const void*              pNext;
    uint32_t                 disabledValidationCheckCount;
    VkValidationCheckEXT*    pDisabledValidationChecks;
} VkValidationFlagsEXT;



#define VK_NVX_device_generated_commands 1
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkObjectTableNVX)
VK_DEFINE_NON_DISPATCHABLE_HANDLE(VkIndirectCommandsLayoutNVX)

#define VK_NVX_DEVICE_GENERATED_COMMANDS_SPEC_VERSION 1
#define VK_NVX_DEVICE_GENERATED_COMMANDS_EXTENSION_NAME "VK_NVX_device_generated_commands"


typedef enum VkIndirectCommandsTokenTypeNVX {
    VK_INDIRECT_COMMANDS_TOKEN_PIPELINE_NVX = 0,
    VK_INDIRECT_COMMANDS_TOKEN_DESCRIPTOR_SET_NVX = 1,
    VK_INDIRECT_COMMANDS_TOKEN_INDEX_BUFFER_NVX = 2,
    VK_INDIRECT_COMMANDS_TOKEN_VERTEX_BUFFER_NVX = 3,
    VK_INDIRECT_COMMANDS_TOKEN_PUSH_CONSTANT_NVX = 4,
    VK_INDIRECT_COMMANDS_TOKEN_DRAW_INDEXED_NVX = 5,
    VK_INDIRECT_COMMANDS_TOKEN_DRAW_NVX = 6,
    VK_INDIRECT_COMMANDS_TOKEN_DISPATCH_NVX = 7,
    VK_INDIRECT_COMMANDS_TOKEN_TYPE_BEGIN_RANGE_NVX = VK_INDIRECT_COMMANDS_TOKEN_PIPELINE_NVX,
    VK_INDIRECT_COMMANDS_TOKEN_TYPE_END_RANGE_NVX = VK_INDIRECT_COMMANDS_TOKEN_DISPATCH_NVX,
    VK_INDIRECT_COMMANDS_TOKEN_TYPE_RANGE_SIZE_NVX = (VK_INDIRECT_COMMANDS_TOKEN_DISPATCH_NVX - VK_INDIRECT_COMMANDS_TOKEN_PIPELINE_NVX + 1),
    VK_INDIRECT_COMMANDS_TOKEN_TYPE_MAX_ENUM_NVX = 0x7FFFFFFF
} VkIndirectCommandsTokenTypeNVX;

typedef enum VkObjectEntryTypeNVX {
    VK_OBJECT_ENTRY_DESCRIPTOR_SET_NVX = 0,
    VK_OBJECT_ENTRY_PIPELINE_NVX = 1,
    VK_OBJECT_ENTRY_INDEX_BUFFER_NVX = 2,
    VK_OBJECT_ENTRY_VERTEX_BUFFER_NVX = 3,
    VK_OBJECT_ENTRY_PUSH_CONSTANT_NVX = 4,
    VK_OBJECT_ENTRY_TYPE_BEGIN_RANGE_NVX = VK_OBJECT_ENTRY_DESCRIPTOR_SET_NVX,
    VK_OBJECT_ENTRY_TYPE_END_RANGE_NVX = VK_OBJECT_ENTRY_PUSH_CONSTANT_NVX,
    VK_OBJECT_ENTRY_TYPE_RANGE_SIZE_NVX = (VK_OBJECT_ENTRY_PUSH_CONSTANT_NVX - VK_OBJECT_ENTRY_DESCRIPTOR_SET_NVX + 1),
    VK_OBJECT_ENTRY_TYPE_MAX_ENUM_NVX = 0x7FFFFFFF
} VkObjectEntryTypeNVX;


typedef enum VkIndirectCommandsLayoutUsageFlagBitsNVX {
    VK_INDIRECT_COMMANDS_LAYOUT_USAGE_UNORDERED_SEQUENCES_BIT_NVX = 0x00000001,
    VK_INDIRECT_COMMANDS_LAYOUT_USAGE_SPARSE_SEQUENCES_BIT_NVX = 0x00000002,
    VK_INDIRECT_COMMANDS_LAYOUT_USAGE_EMPTY_EXECUTIONS_BIT_NVX = 0x00000004,
    VK_INDIRECT_COMMANDS_LAYOUT_USAGE_INDEXED_SEQUENCES_BIT_NVX = 0x00000008,
    VK_INDIRECT_COMMANDS_LAYOUT_USAGE_FLAG_BITS_MAX_ENUM_NVX = 0x7FFFFFFF
} VkIndirectCommandsLayoutUsageFlagBitsNVX;
typedef VkFlags VkIndirectCommandsLayoutUsageFlagsNVX;

typedef enum VkObjectEntryUsageFlagBitsNVX {
    VK_OBJECT_ENTRY_USAGE_GRAPHICS_BIT_NVX = 0x00000001,
    VK_OBJECT_ENTRY_USAGE_COMPUTE_BIT_NVX = 0x00000002,
    VK_OBJECT_ENTRY_USAGE_FLAG_BITS_MAX_ENUM_NVX = 0x7FFFFFFF
} VkObjectEntryUsageFlagBitsNVX;
typedef VkFlags VkObjectEntryUsageFlagsNVX;

typedef struct VkDeviceGeneratedCommandsFeaturesNVX {
    VkStructureType    sType;
    const void*        pNext;
    VkBool32           computeBindingPointSupport;
} VkDeviceGeneratedCommandsFeaturesNVX;

typedef struct VkDeviceGeneratedCommandsLimitsNVX {
    VkStructureType    sType;
    const void*        pNext;
    uint32_t           maxIndirectCommandsLayoutTokenCount;
    uint32_t           maxObjectEntryCounts;
    uint32_t           minSequenceCountBufferOffsetAlignment;
    uint32_t           minSequenceIndexBufferOffsetAlignment;
    uint32_t           minCommandsTokenBufferOffsetAlignment;
} VkDeviceGeneratedCommandsLimitsNVX;

typedef struct VkIndirectCommandsTokenNVX {
    VkIndirectCommandsTokenTypeNVX    tokenType;
    VkBuffer                          buffer;
    VkDeviceSize                      offset;
} VkIndirectCommandsTokenNVX;

typedef struct VkIndirectCommandsLayoutTokenNVX {
    VkIndirectCommandsTokenTypeNVX    tokenType;
    uint32_t                          bindingUnit;
    uint32_t                          dynamicCount;
    uint32_t                          divisor;
} VkIndirectCommandsLayoutTokenNVX;

typedef struct VkIndirectCommandsLayoutCreateInfoNVX {
    VkStructureType                            sType;
    const void*                                pNext;
    VkPipelineBindPoint                        pipelineBindPoint;
    VkIndirectCommandsLayoutUsageFlagsNVX      flags;
    uint32_t                                   tokenCount;
    const VkIndirectCommandsLayoutTokenNVX*    pTokens;
} VkIndirectCommandsLayoutCreateInfoNVX;

typedef struct VkCmdProcessCommandsInfoNVX {
    VkStructureType                      sType;
    const void*                          pNext;
    VkObjectTableNVX                     objectTable;
    VkIndirectCommandsLayoutNVX          indirectCommandsLayout;
    uint32_t                             indirectCommandsTokenCount;
    const VkIndirectCommandsTokenNVX*    pIndirectCommandsTokens;
    uint32_t                             maxSequencesCount;
    VkCommandBuffer                      targetCommandBuffer;
    VkBuffer                             sequencesCountBuffer;
    VkDeviceSize                         sequencesCountOffset;
    VkBuffer                             sequencesIndexBuffer;
    VkDeviceSize                         sequencesIndexOffset;
} VkCmdProcessCommandsInfoNVX;

typedef struct VkCmdReserveSpaceForCommandsInfoNVX {
    VkStructureType                sType;
    const void*                    pNext;
    VkObjectTableNVX               objectTable;
    VkIndirectCommandsLayoutNVX    indirectCommandsLayout;
    uint32_t                       maxSequencesCount;
} VkCmdReserveSpaceForCommandsInfoNVX;

typedef struct VkObjectTableCreateInfoNVX {
    VkStructureType                      sType;
    const void*                          pNext;
    uint32_t                             objectCount;
    const VkObjectEntryTypeNVX*          pObjectEntryTypes;
    const uint32_t*                      pObjectEntryCounts;
    const VkObjectEntryUsageFlagsNVX*    pObjectEntryUsageFlags;
    uint32_t                             maxUniformBuffersPerDescriptor;
    uint32_t                             maxStorageBuffersPerDescriptor;
    uint32_t                             maxStorageImagesPerDescriptor;
    uint32_t                             maxSampledImagesPerDescriptor;
    uint32_t                             maxPipelineLayouts;
} VkObjectTableCreateInfoNVX;

typedef struct VkObjectTableEntryNVX {
    VkObjectEntryTypeNVX          type;
    VkObjectEntryUsageFlagsNVX    flags;
} VkObjectTableEntryNVX;

typedef struct VkObjectTablePipelineEntryNVX {
    VkObjectEntryTypeNVX          type;
    VkObjectEntryUsageFlagsNVX    flags;
    VkPipeline                    pipeline;
} VkObjectTablePipelineEntryNVX;

typedef struct VkObjectTableDescriptorSetEntryNVX {
    VkObjectEntryTypeNVX          type;
    VkObjectEntryUsageFlagsNVX    flags;
    VkPipelineLayout              pipelineLayout;
    VkDescriptorSet               descriptorSet;
} VkObjectTableDescriptorSetEntryNVX;

typedef struct VkObjectTableVertexBufferEntryNVX {
    VkObjectEntryTypeNVX          type;
    VkObjectEntryUsageFlagsNVX    flags;
    VkBuffer                      buffer;
} VkObjectTableVertexBufferEntryNVX;

typedef struct VkObjectTableIndexBufferEntryNVX {
    VkObjectEntryTypeNVX          type;
    VkObjectEntryUsageFlagsNVX    flags;
    VkBuffer                      buffer;
} VkObjectTableIndexBufferEntryNVX;

typedef struct VkObjectTablePushConstantEntryNVX {
    VkObjectEntryTypeNVX          type;
    VkObjectEntryUsageFlagsNVX    flags;
    VkPipelineLayout              pipelineLayout;
    VkShaderStageFlags            stageFlags;
} VkObjectTablePushConstantEntryNVX;


typedef void (VKAPI_PTR *PFN_vkCmdProcessCommandsNVX)(VkCommandBuffer commandBuffer, const VkCmdProcessCommandsInfoNVX* pProcessCommandsInfo);
typedef void (VKAPI_PTR *PFN_vkCmdReserveSpaceForCommandsNVX)(VkCommandBuffer commandBuffer, const VkCmdReserveSpaceForCommandsInfoNVX* pReserveSpaceInfo);
typedef VkResult (VKAPI_PTR *PFN_vkCreateIndirectCommandsLayoutNVX)(VkDevice device, const VkIndirectCommandsLayoutCreateInfoNVX* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkIndirectCommandsLayoutNVX* pIndirectCommandsLayout);
typedef void (VKAPI_PTR *PFN_vkDestroyIndirectCommandsLayoutNVX)(VkDevice device, VkIndirectCommandsLayoutNVX indirectCommandsLayout, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkCreateObjectTableNVX)(VkDevice device, const VkObjectTableCreateInfoNVX* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkObjectTableNVX* pObjectTable);
typedef void (VKAPI_PTR *PFN_vkDestroyObjectTableNVX)(VkDevice device, VkObjectTableNVX objectTable, const VkAllocationCallbacks* pAllocator);
typedef VkResult (VKAPI_PTR *PFN_vkRegisterObjectsNVX)(VkDevice device, VkObjectTableNVX objectTable, uint32_t objectCount, const VkObjectTableEntryNVX* const*    ppObjectTableEntries, const uint32_t* pObjectIndices);
typedef VkResult (VKAPI_PTR *PFN_vkUnregisterObjectsNVX)(VkDevice device, VkObjectTableNVX objectTable, uint32_t objectCount, const VkObjectEntryTypeNVX* pObjectEntryTypes, const uint32_t* pObjectIndices);
typedef void (VKAPI_PTR *PFN_vkGetPhysicalDeviceGeneratedCommandsPropertiesNVX)(VkPhysicalDevice physicalDevice, VkDeviceGeneratedCommandsFeaturesNVX* pFeatures, VkDeviceGeneratedCommandsLimitsNVX* pLimits);

#ifndef VK_NO_PROTOTYPES
VKAPI_ATTR void VKAPI_CALL vkCmdProcessCommandsNVX(
    VkCommandBuffer                             commandBuffer,
    const VkCmdProcessCommandsInfoNVX*          pProcessCommandsInfo);

VKAPI_ATTR void VKAPI_CALL vkCmdReserveSpaceForCommandsNVX(
    VkCommandBuffer                             commandBuffer,
    const VkCmdReserveSpaceForCommandsInfoNVX*  pReserveSpaceInfo);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateIndirectCommandsLayoutNVX(
    VkDevice                                    device,
    const VkIndirectCommandsLayoutCreateInfoNVX* pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkIndirectCommandsLayoutNVX*                pIndirectCommandsLayout);

VKAPI_ATTR void VKAPI_CALL vkDestroyIndirectCommandsLayoutNVX(
    VkDevice                                    device,
    VkIndirectCommandsLayoutNVX                 indirectCommandsLayout,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkCreateObjectTableNVX(
    VkDevice                                    device,
    const VkObjectTableCreateInfoNVX*           pCreateInfo,
    const VkAllocationCallbacks*                pAllocator,
    VkObjectTableNVX*                           pObjectTable);

VKAPI_ATTR void VKAPI_CALL vkDestroyObjectTableNVX(
    VkDevice                                    device,
    VkObjectTableNVX                            objectTable,
    const VkAllocationCallbacks*                pAllocator);

VKAPI_ATTR VkResult VKAPI_CALL vkRegisterObjectsNVX(
    VkDevice                                    device,
    VkObjectTableNVX                            objectTable,
    uint32_t                                    objectCount,
    const VkObjectTableEntryNVX* const*         ppObjectTableEntries,
    const uint32_t*                             pObjectIndices);

VKAPI_ATTR VkResult VKAPI_CALL vkUnregisterObjectsNVX(
    VkDevice                                    device,
    VkObjectTableNVX                            objectTable,
    uint32_t                                    objectCount,
    const VkObjectEntryTypeNVX*                 pObjectEntryTypes,
    const uint32_t*                             pObjectIndices);

VKAPI_ATTR void VKAPI_CALL vkGetPhysicalDeviceGeneratedCommandsPropertiesNVX(
    VkPhysicalDevice                            physicalDevice,
    VkDeviceGeneratedCommandsFeaturesNVX*       pFeatures,
    VkDeviceGeneratedCommandsLimitsNVX*         pLimits);
#endif
]]



--[[
#define VK_MAKE_VERSION(major, minor, patch) \
    ((major << 22) | (minor << 12) | patch)

// Vulkan API version supported by this file
#define VK_DEFINE_HANDLE(object) typedef struct object##_T* object;
#define VK_DEFINE_NON_DISPATCHABLE_HANDLE(object) typedef uint64_t object;

//static const float VK_LOD_CLAMP_NONE = 1000.0f;
//static const uint64_t VK_WHOLE_SIZE  = (~0ULL);
]]

vulkan_headers = {
  core = vulkan_core,
  extensions = vulkan_extensions,
  gsubplatforms = function(str, sub)
    return str:gsub("#ifdef VK_USE_PLATFORM_.-#endif /%* VK_USE_PLATFORM_.- */", sub)
  end,
  cleanup = function(str)
    return str 
    :gsub("VKAPI_PTR", "VKAPI_CALL")
    :gsub("VKAPI_CALL",ffi.os == "Windows" and "__stdcall" or "")
    :gsub("VKAPI_ATTR", "")
    :gsub("#[^\r\n]+", "")
    :gsub("VK_DEFINE_HANDLE(%b())",                  function(cap) return "typedef struct "..cap:sub(2,-2).."_T* "..cap:sub(2,-2)..";" end)
    :gsub("VK_DEFINE_NON_DISPATCHABLE_HANDLE(%b())", function(cap) return "typedef uint64_t "..cap:sub(2,-2)..";" end)
    :gsub("VK_MAKE_VERSION(%b())",                   
      function(cap) major,minor,patch = cap:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)"); 
        return bit.bor( bit.lshift(tonumber(major),22), bit.lshift(tonumber(minor),12), tonumber(patch)) 
      end)
  end,
}

-- Load all
vulkan_core       = vulkan_headers.cleanup(vulkan_headers.gsubplatforms(vulkan_headers.core, ""))
vulkan_extensions = vulkan_headers.cleanup(vulkan_headers.gsubplatforms(vulkan_headers.extensions, ""))

ffi.cdef (vulkan_core)
ffi.cdef (vulkan_extensions)

vk = ffi.load(lwlgl.libs.vulkan[2])

-- Utilities
vku = {
    VK_LOD_CLAMP_NONE = 1000.0,
    VK_WHOLE_SIZE     = 0xFFFFFFFFFFFFFFFFULL
}

structEnums = {}
structTypes = vulkan_headers.core:match("VkStructureType {(.-)}")

structTypes:gsub("VK_STRUCTURE_TYPE_([%w_]+)", function(cap) 
  name = "Vk"
  isExt = {
    KHR = true, 
    EXT = true, 
    NV  = true, 
    NVX = true, 
    AMD = true,
    IMG = true
  }
  cap:gsub("(%w+)",function(word) 
      name = name..(isExt[word] and word or (word:sub(1,1)..word:lower():sub(2,-1)))
  end)
  structEnums[name] = vk["VK_STRUCTURE_TYPE_"..cap]
end)

function vku.getStructEnum(name)
  return structEnums[name]
end

function vku.newStruct(name)
  str = ffi.new(name, 0)
  str.sType = structEnums[name] or 0
  
  return str
end

function vku.fillStruct(ref)
  typ = tostring(ref):match("cdata<struct ([%w_]+)")
  assert(typ)
  enum = structEnums[typ]
  if (enum) then
    ffi.fill(ref, ffi.sizeof(typ))
    ref.sType = enum
  end
end

function vku.loadExtensions(getfunc, pfnstring)
  extstring = (pfnstring or vkheaders.gsubplatforms(vkheaders.extensions, ""))
    :gsub("VKAPI_PTR", "VKAPI_CALL")
    :gsub("VKAPI_CALL",ffi.os == "Windows" and "__stdcall" or "")
    :gsub("VKAPI_ATTR", "")
  
  extfuncs = {}
  for name in extstring:gmatch("%*PFN_(vk[%w_]+)") do
    fn = ffi.cast("PFN_"..name, getfunc(name))
    if (fn ~= nil) then
      extfuncs[name] = fn
    end
  end
  return extfuncs
end

end

function load_devil()

ffi.cdef([[
typedef unsigned int ILenum;
typedef unsigned char ILboolean;
typedef unsigned int ILbitfield;
typedef signed char ILbyte;
typedef signed short ILshort;
typedef int ILint;
typedef size_t ILsizei;
typedef unsigned char ILubyte;
typedef unsigned short ILushort;
typedef unsigned int ILuint;
typedef float ILfloat;
typedef float ILclampf;
typedef double ILdouble;
typedef double ILclampd;

typedef long long int ILint64;
typedef long long unsigned int ILuint64;

typedef void* ILHANDLE;
typedef void ( *fCloseRProc)(ILHANDLE);
typedef ILboolean ( *fEofProc) (ILHANDLE);
typedef ILint ( *fGetcProc) (ILHANDLE);
typedef ILHANDLE ( *fOpenRProc) (char const *);
typedef ILint ( *fReadProc) (void*, ILuint, ILuint, ILHANDLE);
typedef ILint ( *fSeekRProc) (ILHANDLE, ILint, ILint);
typedef ILint ( *fTellRProc) (ILHANDLE);

typedef void ( *fCloseWProc)(ILHANDLE);
typedef ILHANDLE ( *fOpenWProc) (char const *);
typedef ILint ( *fPutcProc) (ILubyte, ILHANDLE);
typedef ILint ( *fSeekWProc) (ILHANDLE, ILint, ILint);
typedef ILint ( *fTellWProc) (ILHANDLE);
typedef ILint ( *fWriteProc) (const void*, ILuint, ILuint, ILHANDLE);

typedef void* ( *mAlloc)(const ILsizei);
typedef void ( *mFree) (const void* const);

typedef ILenum ( *IL_LOADPROC)(char const *);
typedef ILenum ( *IL_SAVEPROC)(char const *);

extern ILboolean ilActiveFace(ILuint Number);
extern ILboolean ilActiveImage(ILuint Number);
extern ILboolean ilActiveLayer(ILuint Number);
extern ILboolean ilActiveMipmap(ILuint Number);
extern ILboolean ilApplyPal(char const * FileName);
extern ILboolean ilApplyProfile(char* InProfile, char* OutProfile);
extern void ilBindImage(ILuint Image);
extern ILboolean ilBlit(ILuint Source, ILint DestX, ILint DestY, ILint DestZ, ILuint SrcX, ILuint SrcY, ILuint SrcZ, ILuint Width, ILuint Height, ILuint Depth);
extern ILboolean ilClampNTSC(void);
extern void ilClearColour(ILclampf Red, ILclampf Green, ILclampf Blue, ILclampf Alpha);
extern ILboolean ilClearImage(void);
extern ILuint ilCloneCurImage(void);
extern ILubyte* ilCompressDXT(ILubyte *Data, ILuint Width, ILuint Height, ILuint Depth, ILenum DXTCFormat, ILuint *DXTCSize);
extern ILboolean ilCompressFunc(ILenum Mode);
extern ILboolean ilConvertImage(ILenum DestFormat, ILenum DestType);
extern ILboolean ilConvertPal(ILenum DestFormat);
extern ILboolean ilCopyImage(ILuint Src);
extern ILuint ilCopyPixels(ILuint XOff, ILuint YOff, ILuint ZOff, ILuint Width, ILuint Height, ILuint Depth, ILenum Format, ILenum Type, void *Data);
extern ILuint ilCreateSubImage(ILenum Type, ILuint Num);
extern ILboolean ilDefaultImage(void);
extern void ilDeleteImage(const ILuint Num);
extern void ilDeleteImages(ILsizei Num, const ILuint *Images);
extern ILenum ilDetermineType(char const * FileName);
extern ILenum ilDetermineTypeF(ILHANDLE File);
extern ILenum ilDetermineTypeL(const void *Lump, ILuint Size);
extern ILboolean ilDisable(ILenum Mode);
extern ILboolean ilDxtcDataToImage(void);
extern ILboolean ilDxtcDataToSurface(void);
extern ILboolean ilEnable(ILenum Mode);
extern void ilFlipSurfaceDxtcData(void);
extern ILboolean ilFormatFunc(ILenum Mode);
extern void ilGenImages(ILsizei Num, ILuint *Images);
extern ILuint ilGenImage(void);
extern ILubyte* ilGetAlpha(ILenum Type);
extern ILboolean ilGetBoolean(ILenum Mode);
extern void ilGetBooleanv(ILenum Mode, ILboolean *Param);
extern ILubyte* ilGetData(void);
extern ILuint ilGetDXTCData(void *Buffer, ILuint BufferSize, ILenum DXTCFormat);
extern ILenum ilGetError(void);
extern ILint ilGetInteger(ILenum Mode);
extern void ilGetIntegerv(ILenum Mode, ILint *Param);
extern ILuint ilGetLumpPos(void);
extern ILubyte* ilGetPalette(void);
extern char const * ilGetString(ILenum StringName);
extern void ilHint(ILenum Target, ILenum Mode);
extern ILboolean ilInvertSurfaceDxtcDataAlpha(void);
extern void ilInit(void);
extern ILboolean ilImageToDxtcData(ILenum Format);
extern ILboolean ilIsDisabled(ILenum Mode);
extern ILboolean ilIsEnabled(ILenum Mode);
extern ILboolean ilIsImage(ILuint Image);
extern ILboolean ilIsValid(ILenum Type, char const * FileName);
extern ILboolean ilIsValidF(ILenum Type, ILHANDLE File);
extern ILboolean ilIsValidL(ILenum Type, void *Lump, ILuint Size);
extern void ilKeyColour(ILclampf Red, ILclampf Green, ILclampf Blue, ILclampf Alpha);
extern ILboolean ilLoad(ILenum Type, char const * FileName);
extern ILboolean ilLoadF(ILenum Type, ILHANDLE File);
extern ILboolean ilLoadImage(char const * FileName);
extern ILboolean ilLoadL(ILenum Type, const void *Lump, ILuint Size);
extern ILboolean ilLoadPal(char const * FileName);
extern void ilModAlpha(ILdouble AlphaValue);
extern ILboolean ilOriginFunc(ILenum Mode);
extern ILboolean ilOverlayImage(ILuint Source, ILint XCoord, ILint YCoord, ILint ZCoord);
extern void ilPopAttrib(void);
extern void ilPushAttrib(ILuint Bits);
extern void ilRegisterFormat(ILenum Format);
extern ILboolean ilRegisterLoad(char const * Ext, IL_LOADPROC Load);
extern ILboolean ilRegisterMipNum(ILuint Num);
extern ILboolean ilRegisterNumFaces(ILuint Num);
extern ILboolean ilRegisterNumImages(ILuint Num);
extern void ilRegisterOrigin(ILenum Origin);
extern void ilRegisterPal(void *Pal, ILuint Size, ILenum Type);
extern ILboolean ilRegisterSave(char const * Ext, IL_SAVEPROC Save);
extern void ilRegisterType(ILenum Type);
extern ILboolean ilRemoveLoad(char const * Ext);
extern ILboolean ilRemoveSave(char const * Ext);
extern void ilResetMemory(void);
extern void ilResetRead(void);
extern void ilResetWrite(void);
extern ILboolean ilSave(ILenum Type, char const * FileName);
extern ILuint ilSaveF(ILenum Type, ILHANDLE File);
extern ILboolean ilSaveImage(char const * FileName);
extern ILuint ilSaveL(ILenum Type, void *Lump, ILuint Size);
extern ILboolean ilSavePal(char const * FileName);
extern ILboolean ilSetAlpha(ILdouble AlphaValue);
extern ILboolean ilSetData(void *Data);
extern ILboolean ilSetDuration(ILuint Duration);
extern void ilSetInteger(ILenum Mode, ILint Param);
extern void ilSetMemory(mAlloc, mFree);
extern void ilSetPixels(ILint XOff, ILint YOff, ILint ZOff, ILuint Width, ILuint Height, ILuint Depth, ILenum Format, ILenum Type, void *Data);
extern void ilSetRead(fOpenRProc, fCloseRProc, fEofProc, fGetcProc, fReadProc, fSeekRProc, fTellRProc);
extern void ilSetString(ILenum Mode, const char *String);
extern void ilSetWrite(fOpenWProc, fCloseWProc, fPutcProc, fSeekWProc, fTellWProc, fWriteProc);
extern void ilShutDown(void);
extern ILboolean ilSurfaceToDxtcData(ILenum Format);
extern ILboolean ilTexImage(ILuint Width, ILuint Height, ILuint Depth, ILubyte NumChannels, ILenum Format, ILenum Type, void *Data);
extern ILboolean ilTexImageDxtc(ILint w, ILint h, ILint d, ILenum DxtFormat, const ILubyte* data);
extern ILenum ilTypeFromExt(char const * FileName);
extern ILboolean ilTypeFunc(ILenum Mode);
extern ILboolean ilLoadData(char const * FileName, ILuint Width, ILuint Height, ILuint Depth, ILubyte Bpp);
extern ILboolean ilLoadDataF(ILHANDLE File, ILuint Width, ILuint Height, ILuint Depth, ILubyte Bpp);
extern ILboolean ilLoadDataL(void *Lump, ILuint Size, ILuint Width, ILuint Height, ILuint Depth, ILubyte Bpp);
extern ILboolean ilSaveData(char const * FileName);
typedef struct ILinfo
{
 ILuint Id;
 ILubyte *Data;
 ILuint Width;
 ILuint Height;
 ILuint Depth;
 ILubyte Bpp;
 ILuint SizeOfData;
 ILenum Format;
 ILenum Type;
 ILenum Origin;
 ILubyte *Palette;
 ILenum PalType;
 ILuint PalSize;
 ILenum CubeFlags;
 ILuint NumNext;
 ILuint NumMips;
 ILuint NumLayers;
} ILinfo;

typedef struct ILpointf {
 ILfloat x;
 ILfloat y;
} ILpointf;

typedef struct ILpointi {
 ILint x;
 ILint y;
} ILpointi;

enum {
	CLAMP_HALF		= 1,
	CLAMP_FLOATS	= 1,
	CLAMP_DOUBLES	= 1,
	IL_FALSE			= 0,
	IL_TRUE				= 1,
	IL_COLOUR_INDEX     = 0x1900,
	IL_COLOR_INDEX      = 0x1900,
	IL_ALPHA			= 0x1906,
	IL_RGB              = 0x1907,
	IL_RGBA             = 0x1908,
	IL_BGR              = 0x80E0,
	IL_BGRA             = 0x80E1,
	IL_LUMINANCE        = 0x1909,
	IL_LUMINANCE_ALPHA  = 0x190A,
	IL_BYTE           = 0x1400,
	IL_UNSIGNED_BYTE  = 0x1401,
	IL_SHORT          = 0x1402,
	IL_UNSIGNED_SHORT = 0x1403,
	IL_INT            = 0x1404,
	IL_UNSIGNED_INT   = 0x1405,
	IL_FLOAT          = 0x1406,
	IL_DOUBLE         = 0x140A,
	IL_HALF           = 0x140B,
	IL_VENDOR   = 0x1F00,
	IL_LOAD_EXT = 0x1F01,
	IL_SAVE_EXT = 0x1F02,
	// IL-specific #define's
	IL_VERSION_1_8_0 = 1,
	IL_VERSION       = 180,
	IL_ORIGIN_BIT          = 0x00000001,
	IL_FILE_BIT            = 0x00000002,
	IL_PAL_BIT             = 0x00000004,
	IL_FORMAT_BIT          = 0x00000008,
	IL_TYPE_BIT            = 0x00000010,
	IL_COMPRESS_BIT        = 0x00000020,
	IL_LOADFAIL_BIT        = 0x00000040,
	IL_FORMAT_SPECIFIC_BIT = 0x00000080,
	IL_ALL_ATTRIB_BITS     = 0x000FFFFF,
	IL_PAL_NONE   = 0x0400,
	IL_PAL_RGB24  = 0x0401,
	IL_PAL_RGB32  = 0x0402,
	IL_PAL_RGBA32 = 0x0403,
	IL_PAL_BGR24  = 0x0404,
	IL_PAL_BGR32  = 0x0405,
	IL_PAL_BGRA32 = 0x0406,
	IL_TYPE_UNKNOWN = 0x0000,
	IL_BMP          = 0x0420,  // Microsoft Windows Bitmap - .bmp extension
	IL_CUT          = 0x0421,  // Dr. Halo - .cut extension
	IL_DOOM         = 0x0422,  // DooM walls - no specific extension
	IL_DOOM_FLAT    = 0x0423,  // DooM flats - no specific extension
	IL_ICO          = 0x0424,  // Microsoft Windows Icons and Cursors - .ico and .cur extensions
	IL_JPG          = 0x0425,  // JPEG - .jpg, .jpe and .jpeg extensions
	IL_JFIF         = 0x0425,
	IL_ILBM         = 0x0426,  // Amiga IFF (FORM ILBM) - .iff, .ilbm, .lbm extensions
	IL_PCD          = 0x0427,  // Kodak PhotoCD - .pcd extension
	IL_PCX          = 0x0428,  // ZSoft PCX - .pcx extension
	IL_PIC          = 0x0429,  // PIC - .pic extension
	IL_PNG          = 0x042A,  // Portable Network Graphics - .png extension
	IL_PNM          = 0x042B,  // Portable Any Map - .pbm, .pgm, .ppm and .pnm extensions
	IL_SGI          = 0x042C,  // Silicon Graphics - .sgi, .bw, .rgb and .rgba extensions
	IL_TGA          = 0x042D,  // TrueVision Targa File - .tga, .vda, .icb and .vst extensions
	IL_TIF          = 0x042E,  // Tagged Image File Format - .tif and .tiff extensions
	IL_CHEAD        = 0x042F,  // C-Style Header - .h extension
	IL_RAW          = 0x0430,  // Raw Image Data - any extension
	IL_MDL          = 0x0431,  // Half-Life Model Texture - .mdl extension
	IL_WAL          = 0x0432,  // Quake 2 Texture - .wal extension
	IL_LIF          = 0x0434,  // Homeworld Texture - .lif extension
	IL_MNG          = 0x0435,  // Multiple-image Network Graphics - .mng extension
	IL_JNG          = 0x0435,
	IL_GIF          = 0x0436,  // Graphics Interchange Format - .gif extension
	IL_DDS          = 0x0437,  // DirectDraw Surface - .dds extension
	IL_DCX          = 0x0438,  // ZSoft Multi-PCX - .dcx extension
	IL_PSD          = 0x0439,  // Adobe PhotoShop - .psd extension
	IL_EXIF         = 0x043A,
	IL_PSP          = 0x043B,  // PaintShop Pro - .psp extension
	IL_PIX          = 0x043C,  // PIX - .pix extension
	IL_PXR          = 0x043D,  // Pixar - .pxr extension
	IL_XPM          = 0x043E,  // X Pixel Map - .xpm extension
	IL_HDR          = 0x043F,  // Radiance High Dynamic Range - .hdr extension
	IL_ICNS			= 0x0440,  // Macintosh Icon - .icns extension
	IL_JP2			= 0x0441,  // Jpeg 2000 - .jp2 extension
	IL_EXR			= 0x0442,  // OpenEXR - .exr extension
	IL_WDP			= 0x0443,  // Microsoft HD Photo - .wdp and .hdp extension
	IL_VTF			= 0x0444,  // Valve Texture Format - .vtf extension
	IL_WBMP			= 0x0445,  // Wireless Bitmap - .wbmp extension
	IL_SUN			= 0x0446,  // Sun Raster - .sun, .ras, .rs, .im1, .im8, .im24 and .im32 extensions
	IL_IFF			= 0x0447,  // Interchange File Format - .iff extension
	IL_TPL			= 0x0448,  // Gamecube Texture - .tpl extension
	IL_FITS			= 0x0449,  // Flexible Image Transport System - .fit and .fits extensions
	IL_DICOM		= 0x044A,  // Digital Imaging and Communications in Medicine (DICOM) - .dcm and .dicom extensions
	IL_IWI			= 0x044B,  // Call of Duty Infinity Ward Image - .iwi extension
	IL_BLP			= 0x044C,  // Blizzard Texture Format - .blp extension
	IL_FTX			= 0x044D,  // Heavy Metal: FAKK2 Texture - .ftx extension
	IL_ROT			= 0x044E,  // Homeworld 2 - Relic Texture - .rot extension
	IL_TEXTURE		= 0x044F,  // Medieval II: Total War Texture - .texture extension
	IL_DPX			= 0x0450,  // Digital Picture Exchange - .dpx extension
	IL_UTX			= 0x0451,  // Unreal (and Unreal Tournament) Texture - .utx extension
	IL_MP3			= 0x0452,  // MPEG-1 Audio Layer 3 - .mp3 extension
	IL_KTX			= 0x0453,  // Khronos Texture - .ktx extension
	IL_JASC_PAL     = 0x0475,  // PaintShop Pro Palette
	IL_NO_ERROR             = 0x0000,
	IL_INVALID_ENUM         = 0x0501,
	IL_OUT_OF_MEMORY        = 0x0502,
	IL_FORMAT_NOT_SUPPORTED = 0x0503,
	IL_INTERNAL_ERROR       = 0x0504,
	IL_INVALID_VALUE        = 0x0505,
	IL_ILLEGAL_OPERATION    = 0x0506,
	IL_ILLEGAL_FILE_VALUE   = 0x0507,
	IL_INVALID_FILE_HEADER  = 0x0508,
	IL_INVALID_PARAM        = 0x0509,
	IL_COULD_NOT_OPEN_FILE  = 0x050A,
	IL_INVALID_EXTENSION    = 0x050B,
	IL_FILE_ALREADY_EXISTS  = 0x050C,
	IL_OUT_FORMAT_SAME      = 0x050D,
	IL_STACK_OVERFLOW       = 0x050E,
	IL_STACK_UNDERFLOW      = 0x050F,
	IL_INVALID_CONVERSION   = 0x0510,
	IL_BAD_DIMENSIONS       = 0x0511,
	IL_FILE_READ_ERROR      = 0x0512,  // 05/12/2002: Addition by Sam.
	IL_FILE_WRITE_ERROR     = 0x0512,
	IL_LIB_GIF_ERROR  = 0x05E1,
	IL_LIB_JPEG_ERROR = 0x05E2,
	IL_LIB_PNG_ERROR  = 0x05E3,
	IL_LIB_TIFF_ERROR = 0x05E4,
	IL_LIB_MNG_ERROR  = 0x05E5,
	IL_LIB_JP2_ERROR  = 0x05E6,
	IL_LIB_EXR_ERROR  = 0x05E7,
	IL_UNKNOWN_ERROR  = 0x05FF,
	IL_ORIGIN_SET        = 0x0600,
	IL_ORIGIN_LOWER_LEFT = 0x0601,
	IL_ORIGIN_UPPER_LEFT = 0x0602,
	IL_ORIGIN_MODE       = 0x0603,
	IL_FORMAT_SET  = 0x0610,
	IL_FORMAT_MODE = 0x0611,
	IL_TYPE_SET    = 0x0612,
	IL_TYPE_MODE   = 0x0613,
	IL_FILE_OVERWRITE	= 0x0620,
	IL_FILE_MODE		= 0x0621,
	IL_CONV_PAL			= 0x0630,
	IL_DEFAULT_ON_FAIL	= 0x0632,
	IL_USE_KEY_COLOUR	= 0x0635,
	IL_USE_KEY_COLOR	= 0x0635,
	IL_BLIT_BLEND		= 0x0636,
	IL_SAVE_INTERLACED	= 0x0639,
	IL_INTERLACE_MODE	= 0x063A,
	IL_QUANTIZATION_MODE = 0x0640,
	IL_WU_QUANT          = 0x0641,
	IL_NEU_QUANT         = 0x0642,
	IL_NEU_QUANT_SAMPLE  = 0x0643,
	IL_MAX_QUANT_INDEXS  = 0x0644, //XIX : ILint : Maximum number of colors to reduce to, default of 256. and has a range of 2-256
	IL_MAX_QUANT_INDICES = 0x0644, // Redefined, since the above #define is misspelled
	IL_FASTEST          = 0x0660,
	IL_LESS_MEM         = 0x0661,
	IL_DONT_CARE        = 0x0662,
	IL_MEM_SPEED_HINT   = 0x0665,
	IL_USE_COMPRESSION  = 0x0666,
	IL_NO_COMPRESSION   = 0x0667,
	IL_COMPRESSION_HINT = 0x0668,
	IL_NVIDIA_COMPRESS	= 0x0670,
	IL_SQUISH_COMPRESS	= 0x0671,
	IL_SUB_NEXT   = 0x0680,
	IL_SUB_MIPMAP = 0x0681,
	IL_SUB_LAYER  = 0x0682,
	IL_COMPRESS_MODE = 0x0700,
	IL_COMPRESS_NONE = 0x0701,
	IL_COMPRESS_RLE  = 0x0702,
	IL_COMPRESS_LZO  = 0x0703,
	IL_COMPRESS_ZLIB = 0x0704,
	IL_TGA_CREATE_STAMP        = 0x0710,
	IL_JPG_QUALITY             = 0x0711,
	IL_PNG_INTERLACE           = 0x0712,
	IL_TGA_RLE                 = 0x0713,
	IL_BMP_RLE                 = 0x0714,
	IL_SGI_RLE                 = 0x0715,
	IL_TGA_ID_STRING           = 0x0717,
	IL_TGA_AUTHNAME_STRING     = 0x0718,
	IL_TGA_AUTHCOMMENT_STRING  = 0x0719,
	IL_PNG_AUTHNAME_STRING     = 0x071A,
	IL_PNG_TITLE_STRING        = 0x071B,
	IL_PNG_DESCRIPTION_STRING  = 0x071C,
	IL_TIF_DESCRIPTION_STRING  = 0x071D,
	IL_TIF_HOSTCOMPUTER_STRING = 0x071E,
	IL_TIF_DOCUMENTNAME_STRING = 0x071F,
	IL_TIF_AUTHNAME_STRING     = 0x0720,
	IL_JPG_SAVE_FORMAT         = 0x0721,
	IL_CHEAD_HEADER_STRING     = 0x0722,
	IL_PCD_PICNUM              = 0x0723,
	IL_PNG_ALPHA_INDEX = 0x0724, // currently has no effect!
	IL_JPG_PROGRESSIVE         = 0x0725,
	IL_VTF_COMP                = 0x0726,
	IL_DXTC_FORMAT      = 0x0705,
	IL_DXT1             = 0x0706,
	IL_DXT2             = 0x0707,
	IL_DXT3             = 0x0708,
	IL_DXT4             = 0x0709,
	IL_DXT5             = 0x070A,
	IL_DXT_NO_COMP      = 0x070B,
	IL_KEEP_DXTC_DATA   = 0x070C,
	IL_DXTC_DATA_FORMAT = 0x070D,
	IL_3DC              = 0x070E,
	IL_RXGB             = 0x070F,
	IL_ATI1N            = 0x0710,
	IL_DXT1A            = 0x0711, // Normally the same as IL_DXT1, except for nVidia Texture Tools.
	IL_CUBEMAP_POSITIVEX = 0x00000400,
	IL_CUBEMAP_NEGATIVEX = 0x00000800,
	IL_CUBEMAP_POSITIVEY = 0x00001000,
	IL_CUBEMAP_NEGATIVEY = 0x00002000,
	IL_CUBEMAP_POSITIVEZ = 0x00004000,
	IL_CUBEMAP_NEGATIVEZ = 0x00008000,
	IL_SPHEREMAP         = 0x00010000,
	IL_VERSION_NUM           = 0x0DE2,
	IL_IMAGE_WIDTH           = 0x0DE4,
	IL_IMAGE_HEIGHT          = 0x0DE5,
	IL_IMAGE_DEPTH           = 0x0DE6,
	IL_IMAGE_SIZE_OF_DATA    = 0x0DE7,
	IL_IMAGE_BYTES_PER_PIXEL = 0x0DE8,
	IL_IMAGE_BPP             = 0x0DE8,
	IL_IMAGE_BITS_PER_PIXEL  = 0x0DE9,
	IL_IMAGE_FORMAT          = 0x0DEA,
	IL_IMAGE_TYPE            = 0x0DEB,
	IL_PALETTE_TYPE          = 0x0DEC,
	IL_PALETTE_SIZE          = 0x0DED,
	IL_PALETTE_BPP           = 0x0DEE,
	IL_PALETTE_NUM_COLS      = 0x0DEF,
	IL_PALETTE_BASE_TYPE     = 0x0DF0,
	IL_NUM_FACES             = 0x0DE1,
	IL_NUM_IMAGES            = 0x0DF1,
	IL_NUM_MIPMAPS           = 0x0DF2,
	IL_NUM_LAYERS            = 0x0DF3,
	IL_ACTIVE_IMAGE          = 0x0DF4,
	IL_ACTIVE_MIPMAP         = 0x0DF5,
	IL_ACTIVE_LAYER          = 0x0DF6,
	IL_ACTIVE_FACE           = 0x0E00,
	IL_CUR_IMAGE             = 0x0DF7,
	IL_IMAGE_DURATION        = 0x0DF8,
	IL_IMAGE_PLANESIZE       = 0x0DF9,
	IL_IMAGE_BPC             = 0x0DFA,
	IL_IMAGE_OFFX            = 0x0DFB,
	IL_IMAGE_OFFY            = 0x0DFC,
	IL_IMAGE_CUBEFLAGS       = 0x0DFD,
	IL_IMAGE_ORIGIN          = 0x0DFE,
	IL_IMAGE_CHANNELS        = 0x0DFF,
	IL_SEEK_SET	= 0,
	IL_SEEK_CUR	= 1,
	IL_SEEK_END	= 2,
	IL_EOF		= -1
};
]])

il = ffi.load(lwlgl.libs.freetype[2])

end

function load_freetype()

ffi.cdef([[

// config/ftconfig.h ---------------------------------------------------------

typedef signed short   FT_Int16;
typedef unsigned short FT_UInt16;
typedef signed int     FT_Int32;
typedef unsigned int   FT_UInt32;
typedef int            FT_Fast;
typedef unsigned int   FT_UFast;

// fttypes.h -----------------------------------------------------------------

typedef unsigned char  FT_Bool;
typedef signed short   FT_FWord;
typedef unsigned short FT_UFWord;
typedef signed char    FT_Char;
typedef unsigned char  FT_Byte;
typedef const FT_Byte* FT_Bytes;
typedef FT_UInt32      FT_Tag;
typedef char           FT_String;
typedef signed short   FT_Short;
typedef unsigned short FT_UShort;
typedef signed int     FT_Int;
typedef unsigned int   FT_UInt;
typedef signed long    FT_Long;
typedef unsigned long  FT_ULong;
typedef signed short   FT_F2Dot14;
typedef signed long    FT_F26Dot6;
typedef signed long    FT_Fixed;
typedef int            FT_Error;
typedef void*          FT_Pointer;
typedef size_t         FT_Offset;
typedef ptrdiff_t      FT_PtrDist;

typedef struct FT_UnitVector_ {
	FT_F2Dot14 x;
	FT_F2Dot14 y;
} FT_UnitVector;

typedef struct FT_Matrix_ {
	FT_Fixed xx, xy;
	FT_Fixed yx, yy;
} FT_Matrix;

typedef struct FT_Data_ {
	const FT_Byte* pointer;
	FT_Int length;
} FT_Data;

typedef void (*FT_Generic_Finalizer)( void* object );

typedef struct FT_Generic_ {
	void* data;
	FT_Generic_Finalizer finalizer;
} FT_Generic;

typedef struct FT_ListNodeRec_* FT_ListNode;
typedef struct FT_ListRec_* FT_List;

typedef struct FT_ListNodeRec_ {
	FT_ListNode prev;
	FT_ListNode next;
	void* data;
} FT_ListNodeRec;

typedef struct FT_ListRec_ {
	FT_ListNode head;
	FT_ListNode tail;
} FT_ListRec;

// ftsystem.h ----------------------------------------------------------------

typedef struct FT_MemoryRec_* FT_Memory;

typedef void* (*FT_Alloc_Func)   ( FT_Memory memory, long size );
typedef void  (*FT_Free_Func)    ( FT_Memory memory, void* block );
typedef void* (*FT_Realloc_Func) ( FT_Memory memory, long cur_size, long new_size, void* block );

struct FT_MemoryRec_ {
	void* user;
	FT_Alloc_Func alloc;
	FT_Free_Func free;
	FT_Realloc_Func realloc;
};

typedef struct FT_StreamRec_* FT_Stream;

typedef union FT_StreamDesc_ {
	long value;
	void* pointer;
} FT_StreamDesc;

typedef unsigned long (*FT_Stream_IoFunc)(
	FT_Stream stream,
	unsigned long offset,
	unsigned char* buffer,
	unsigned long count );

typedef void (*FT_Stream_CloseFunc)( FT_Stream stream );

typedef struct FT_StreamRec_ {
	unsigned char* base;
	unsigned long size;
	unsigned long pos;
	FT_StreamDesc descriptor;
	FT_StreamDesc pathname;
	FT_Stream_IoFunc read;
	FT_Stream_CloseFunc close;
	FT_Memory memory;
	unsigned char* cursor;
	unsigned char* limit;
} FT_StreamRec;

// ftimage.h -----------------------------------------------------------------

typedef signed long FT_Pos;

typedef struct FT_Vector_ {
	FT_Pos x;
	FT_Pos y;
} FT_Vector;

typedef struct FT_BBox_ {
	FT_Pos xMin, yMin;
	FT_Pos xMax, yMax;
} FT_BBox;

typedef enum FT_Pixel_Mode_ {
	FT_PIXEL_MODE_NONE = 0,
	FT_PIXEL_MODE_MONO,
	FT_PIXEL_MODE_GRAY,
	FT_PIXEL_MODE_GRAY2,
	FT_PIXEL_MODE_GRAY4,
	FT_PIXEL_MODE_LCD,
	FT_PIXEL_MODE_LCD_V,
	FT_PIXEL_MODE_BGRA,
} FT_Pixel_Mode;

typedef struct FT_Bitmap_ {
	unsigned int rows;
	unsigned int width;
	int pitch;
	unsigned char* buffer;
	unsigned short num_grays;
	unsigned char pixel_mode;
	unsigned char palette_mode;
	void* palette;
} FT_Bitmap;

typedef struct FT_Outline_ {
	short n_contours;
	short n_points;
	FT_Vector* points;
	char* tags;
	short* contours;
	int flags;
} FT_Outline;

enum {
	FT_OUTLINE_CONTOURS_MAX = 32767,
	FT_OUTLINE_POINTS_MAX = 32767,
	FT_OUTLINE_NONE      = 0x0,
	FT_OUTLINE_OWNER     = 0x1,
	FT_OUTLINE_EVEN_ODD_FILL = 0x2,
	FT_OUTLINE_REVERSE_FILL = 0x4,
	FT_OUTLINE_IGNORE_DROPOUTS = 0x8,
	FT_OUTLINE_SMART_DROPOUTS = 0x10,
	FT_OUTLINE_INCLUDE_STUBS = 0x20,
	FT_OUTLINE_HIGH_PRECISION = 0x100,
	FT_OUTLINE_SINGLE_PASS = 0x200,
};

enum {
	FT_CURVE_TAG_ON      = 1,
	FT_CURVE_TAG_CONIC   = 0,
	FT_CURVE_TAG_CUBIC   = 2,
	FT_CURVE_TAG_HAS_SCANMODE = 4,
	FT_CURVE_TAG_TOUCH_X = 8,
	FT_CURVE_TAG_TOUCH_Y = 16,
	FT_CURVE_TAG_TOUCH_BOTH = ( FT_CURVE_TAG_TOUCH_X | FT_CURVE_TAG_TOUCH_Y ),
};

typedef int (*FT_Outline_MoveToFunc) ( const FT_Vector* to, void* user );
typedef int (*FT_Outline_LineToFunc) ( const FT_Vector* to, void* user );
typedef int (*FT_Outline_ConicToFunc)( const FT_Vector* control, const FT_Vector* to, void* user );
typedef int (*FT_Outline_CubicToFunc)( const FT_Vector* control1, const FT_Vector* control2, const FT_Vector* to, void* user );

typedef struct FT_Outline_Funcs_ {
	FT_Outline_MoveToFunc move_to;
	FT_Outline_LineToFunc line_to;
	FT_Outline_ConicToFunc conic_to;
	FT_Outline_CubicToFunc cubic_to;
	int shift;
	FT_Pos delta;
} FT_Outline_Funcs;

typedef enum FT_Glyph_Format_ {
	 FT_GLYPH_FORMAT_NONE = ( ( (unsigned long)0 << 24 ) | ( (unsigned long)0 << 16 ) | ( (unsigned long)0 << 8 ) | (unsigned long)0 ),
	 FT_GLYPH_FORMAT_COMPOSITE = ( ( (unsigned long)'c' << 24 ) | ( (unsigned long)'o' << 16 ) | ( (unsigned long)'m' << 8 ) | (unsigned long)'p' ),
	 FT_GLYPH_FORMAT_BITMAP = ( ( (unsigned long)'b' << 24 ) | ( (unsigned long)'i' << 16 ) | ( (unsigned long)'t' << 8 ) | (unsigned long)'s' ),
	 FT_GLYPH_FORMAT_OUTLINE = ( ( (unsigned long)'o' << 24 ) | ( (unsigned long)'u' << 16 ) | ( (unsigned long)'t' << 8 ) | (unsigned long)'l' ),
	 FT_GLYPH_FORMAT_PLOTTER = ( ( (unsigned long)'p' << 24 ) | ( (unsigned long)'l' << 16 ) | ( (unsigned long)'o' << 8 ) | (unsigned long)'t' )
} FT_Glyph_Format;

typedef struct FT_RasterRec_* FT_Raster;

typedef struct FT_Span_ {
	short x;
	unsigned short len;
	unsigned char coverage;
} FT_Span;

typedef void (*FT_SpanFunc)( int y, int count, const FT_Span* spans, void* user );
typedef int  (*FT_Raster_BitTest_Func)( int y, int x, void* user );
typedef void (*FT_Raster_BitSet_Func)( int y, int x, void* user );

enum {
	FT_RASTER_FLAG_DEFAULT = 0x0,
	FT_RASTER_FLAG_AA    = 0x1,
	FT_RASTER_FLAG_DIRECT = 0x2,
	FT_RASTER_FLAG_CLIP  = 0x4,
};

typedef struct FT_Raster_Params_ {
	const FT_Bitmap* target;
	const void* source;
	int flags;
	FT_SpanFunc gray_spans;
	FT_SpanFunc black_spans;
	FT_Raster_BitTest_Func bit_test;
	FT_Raster_BitSet_Func bit_set;
	void* user;
	FT_BBox clip_box;
} FT_Raster_Params;

typedef int  (*FT_Raster_NewFunc)( void* memory, FT_Raster* raster );
typedef void (*FT_Raster_DoneFunc)( FT_Raster raster );

typedef void (*FT_Raster_ResetFunc)( FT_Raster raster,
	unsigned char* pool_base,
	unsigned long pool_size );

typedef int  (*FT_Raster_SetModeFunc)( FT_Raster raster,
	unsigned long mode,
	void* args );

typedef int (*FT_Raster_RenderFunc)( FT_Raster raster,
	const FT_Raster_Params* params );

typedef struct FT_Raster_Funcs_ {
	FT_Glyph_Format glyph_format;
	FT_Raster_NewFunc raster_new;
	FT_Raster_ResetFunc raster_reset;
	FT_Raster_SetModeFunc raster_set_mode;
	FT_Raster_RenderFunc raster_render;
	FT_Raster_DoneFunc raster_done;
} FT_Raster_Funcs;

// freetype.h ----------------------------------------------------------------

typedef struct FT_Glyph_Metrics_ {
	FT_Pos width;
	FT_Pos height;
	FT_Pos horiBearingX;
	FT_Pos horiBearingY;
	FT_Pos horiAdvance;
	FT_Pos vertBearingX;
	FT_Pos vertBearingY;
	FT_Pos vertAdvance;
} FT_Glyph_Metrics;

typedef struct FT_Bitmap_Size_ {
	FT_Short height;
	FT_Short width;
	FT_Pos size;
	FT_Pos x_ppem;
	FT_Pos y_ppem;
} FT_Bitmap_Size;

typedef struct FT_LibraryRec_ *FT_Library;
typedef struct FT_ModuleRec_* FT_Module;
typedef struct FT_DriverRec_* FT_Driver;
typedef struct FT_RendererRec_* FT_Renderer;
typedef struct FT_FaceRec_* FT_Face;
typedef struct FT_SizeRec_* FT_Size;
typedef struct FT_GlyphSlotRec_* FT_GlyphSlot;
typedef struct FT_CharMapRec_* FT_CharMap;

typedef enum FT_Encoding_ {
	FT_ENCODING_NONE = ( ( (FT_UInt32)(0) << 24 ) | ( (FT_UInt32)(0) << 16 ) | ( (FT_UInt32)(0) << 8 ) | (FT_UInt32)(0) ),
	FT_ENCODING_MS_SYMBOL = ( ( (FT_UInt32)('s') << 24 ) | ( (FT_UInt32)('y') << 16 ) | ( (FT_UInt32)('m') << 8 ) | (FT_UInt32)('b') ),
	FT_ENCODING_UNICODE = ( ( (FT_UInt32)('u') << 24 ) | ( (FT_UInt32)('n') << 16 ) | ( (FT_UInt32)('i') << 8 ) | (FT_UInt32)('c') ),
	FT_ENCODING_SJIS = ( ( (FT_UInt32)('s') << 24 ) | ( (FT_UInt32)('j') << 16 ) | ( (FT_UInt32)('i') << 8 ) | (FT_UInt32)('s') ),
	FT_ENCODING_PRC = ( ( (FT_UInt32)('g') << 24 ) | ( (FT_UInt32)('b') << 16 ) | ( (FT_UInt32)(' ') << 8 ) | (FT_UInt32)(' ') ),
	FT_ENCODING_BIG5 = ( ( (FT_UInt32)('b') << 24 ) | ( (FT_UInt32)('i') << 16 ) | ( (FT_UInt32)('g') << 8 ) | (FT_UInt32)('5') ),
	FT_ENCODING_WANSUNG = ( ( (FT_UInt32)('w') << 24 ) | ( (FT_UInt32)('a') << 16 ) | ( (FT_UInt32)('n') << 8 ) | (FT_UInt32)('s') ),
	FT_ENCODING_JOHAB = ( ( (FT_UInt32)('j') << 24 ) | ( (FT_UInt32)('o') << 16 ) | ( (FT_UInt32)('h') << 8 ) | (FT_UInt32)('a') ),
	FT_ENCODING_GB2312 = FT_ENCODING_PRC,
	FT_ENCODING_MS_SJIS = FT_ENCODING_SJIS,
	FT_ENCODING_MS_GB2312 = FT_ENCODING_PRC,
	FT_ENCODING_MS_BIG5 = FT_ENCODING_BIG5,
	FT_ENCODING_MS_WANSUNG = FT_ENCODING_WANSUNG,
	FT_ENCODING_MS_JOHAB = FT_ENCODING_JOHAB,
	FT_ENCODING_ADOBE_STANDARD = ( ( (FT_UInt32)('A') << 24 ) | ( (FT_UInt32)('D') << 16 ) | ( (FT_UInt32)('O') << 8 ) | (FT_UInt32)('B') ),
	FT_ENCODING_ADOBE_EXPERT = ( ( (FT_UInt32)('A') << 24 ) | ( (FT_UInt32)('D') << 16 ) | ( (FT_UInt32)('B') << 8 ) | (FT_UInt32)('E') ),
	FT_ENCODING_ADOBE_CUSTOM = ( ( (FT_UInt32)('A') << 24 ) | ( (FT_UInt32)('D') << 16 ) | ( (FT_UInt32)('B') << 8 ) | (FT_UInt32)('C') ),
	FT_ENCODING_ADOBE_LATIN_1 = ( ( (FT_UInt32)('l') << 24 ) | ( (FT_UInt32)('a') << 16 ) | ( (FT_UInt32)('t') << 8 ) | (FT_UInt32)('1') ),
	FT_ENCODING_OLD_LATIN_2 = ( ( (FT_UInt32)('l') << 24 ) | ( (FT_UInt32)('a') << 16 ) | ( (FT_UInt32)('t') << 8 ) | (FT_UInt32)('2') ),
	FT_ENCODING_APPLE_ROMAN = ( ( (FT_UInt32)('a') << 24 ) | ( (FT_UInt32)('r') << 16 ) | ( (FT_UInt32)('m') << 8 ) | (FT_UInt32)('n') )
} FT_Encoding;

typedef struct FT_CharMapRec_ {
	FT_Face face;
	union {
		FT_Encoding encoding;
		char _encoding_str[4];
	};
	FT_UShort platform_id;
	FT_UShort encoding_id;
} FT_CharMapRec;

typedef struct FT_Face_InternalRec_* FT_Face_Internal;

typedef struct FT_FaceRec_ {
	FT_Long num_faces;
	FT_Long face_index;
	FT_Long face_flags;
	FT_Long style_flags;
	FT_Long num_glyphs;
	FT_String* family_name;
	FT_String* style_name;
	FT_Int num_fixed_sizes;
	FT_Bitmap_Size* available_sizes;
	FT_Int num_charmaps;
	FT_CharMap* charmaps;
	FT_Generic generic;
	FT_BBox bbox;
	FT_UShort units_per_EM;
	FT_Short ascender;
	FT_Short descender;
	FT_Short height;
	FT_Short max_advance_width;
	FT_Short max_advance_height;
	FT_Short underline_position;
	FT_Short underline_thickness;
	FT_GlyphSlot glyph;
	FT_Size size;
	FT_CharMap charmap;
	FT_Driver driver;
	FT_Memory memory;
	FT_Stream stream;
	FT_ListRec sizes_list;
	FT_Generic autohint;
	void* extensions;
	FT_Face_Internal internal;
} FT_FaceRec;

enum {
	FT_FACE_FLAG_SCALABLE         = ( 1 << 0 ),
	FT_FACE_FLAG_FIXED_SIZES      = ( 1 << 1 ),
	FT_FACE_FLAG_FIXED_WIDTH      = ( 1 << 2 ),
	FT_FACE_FLAG_SFNT             = ( 1 << 3 ),
	FT_FACE_FLAG_HORIZONTAL       = ( 1 << 4 ),
	FT_FACE_FLAG_VERTICAL         = ( 1 << 5 ),
	FT_FACE_FLAG_KERNING          = ( 1 << 6 ),
	FT_FACE_FLAG_FAST_GLYPHS      = ( 1 << 7 ),
	FT_FACE_FLAG_MULTIPLE_MASTERS = ( 1 << 8 ),
	FT_FACE_FLAG_GLYPH_NAMES      = ( 1 << 9 ),
	FT_FACE_FLAG_EXTERNAL_STREAM  = ( 1 << 10 ),
	FT_FACE_FLAG_HINTER           = ( 1 << 11 ),
	FT_FACE_FLAG_CID_KEYED        = ( 1 << 12 ),
	FT_FACE_FLAG_TRICKY           = ( 1 << 13 ),
	FT_FACE_FLAG_COLOR            = ( 1 << 14 ),
	FT_FACE_FLAG_VARIATION        = ( 1 << 15 ),
};

enum {
	FT_STYLE_FLAG_ITALIC = ( 1 << 0 ),
	FT_STYLE_FLAG_BOLD   = ( 1 << 1 ),
};

typedef struct FT_Size_InternalRec_* FT_Size_Internal;

typedef struct FT_Size_Metrics_ {
	FT_UShort x_ppem;
	FT_UShort y_ppem;
	FT_Fixed x_scale;
	FT_Fixed y_scale;
	FT_Pos ascender;
	FT_Pos descender;
	FT_Pos height;
	FT_Pos max_advance;
} FT_Size_Metrics;

typedef struct FT_SizeRec_ {
	FT_Face face;
	FT_Generic generic;
	FT_Size_Metrics metrics;
	FT_Size_Internal internal;
} FT_SizeRec;

typedef struct FT_SubGlyphRec_* FT_SubGlyph;
typedef struct FT_Slot_InternalRec_* FT_Slot_Internal;

typedef struct FT_GlyphSlotRec_ {
	FT_Library library;
	FT_Face face;
	FT_GlyphSlot next;
	FT_UInt reserved;
	FT_Generic generic;
	FT_Glyph_Metrics metrics;
	FT_Fixed linearHoriAdvance;
	FT_Fixed linearVertAdvance;
	FT_Vector advance;
	FT_Glyph_Format format;
	FT_Bitmap bitmap;
	FT_Int bitmap_left;
	FT_Int bitmap_top;
	FT_Outline outline;
	FT_UInt num_subglyphs;
	FT_SubGlyph subglyphs;
	void* control_data;
	long control_len;
	FT_Pos lsb_delta;
	FT_Pos rsb_delta;
	void* other;
	FT_Slot_Internal internal;
} FT_GlyphSlotRec;

FT_Error FT_Init_FreeType( FT_Library *alibrary );
FT_Error FT_Done_FreeType( FT_Library library );

enum {
	FT_OPEN_MEMORY       = 0x1,
	FT_OPEN_STREAM       = 0x2,
	FT_OPEN_PATHNAME     = 0x4,
	FT_OPEN_DRIVER       = 0x8,
	FT_OPEN_PARAMS       = 0x10,
};

typedef struct FT_Parameter_ {
	FT_ULong tag;
	FT_Pointer data;
} FT_Parameter;

typedef struct FT_Open_Args_ {
	FT_UInt flags;
	const FT_Byte* memory_base;
	FT_Long memory_size;
	FT_String* pathname;
	FT_Stream stream;
	FT_Module driver;
	FT_Int num_params;
	FT_Parameter* params;
} FT_Open_Args;

FT_Error
FT_New_Face(
	FT_Library library,
	const char* filepathname,
	FT_Long face_index,
	FT_Face *aface );

FT_Error
FT_New_Memory_Face(
	FT_Library library,
	const FT_Byte* file_base,
	FT_Long file_size,
	FT_Long face_index,
	FT_Face *aface );

FT_Error
FT_Open_Face(
	FT_Library library,
	const FT_Open_Args* args,
	FT_Long face_index,
	FT_Face *aface );

FT_Error FT_Attach_File   ( FT_Face face, const char* filepathname );
FT_Error FT_Attach_Stream ( FT_Face face, FT_Open_Args* parameters );

FT_Error FT_Reference_Face ( FT_Face face );
FT_Error FT_Done_Face      ( FT_Face face );

FT_Error FT_Select_Size    ( FT_Face face, FT_Int strike_index );

typedef enum FT_Size_Request_Type_ {
	FT_SIZE_REQUEST_TYPE_NOMINAL,
	FT_SIZE_REQUEST_TYPE_REAL_DIM,
	FT_SIZE_REQUEST_TYPE_BBOX,
	FT_SIZE_REQUEST_TYPE_CELL,
	FT_SIZE_REQUEST_TYPE_SCALES,
	FT_SIZE_REQUEST_TYPE_MAX
} FT_Size_Request_Type;

typedef struct FT_Size_RequestRec_ {
	FT_Size_Request_Type type;
	FT_Long width;
	FT_Long height;
	FT_UInt horiResolution;
	FT_UInt vertResolution;
} FT_Size_RequestRec;

typedef struct FT_Size_RequestRec_ *FT_Size_Request;

FT_Error
FT_Request_Size(
	FT_Face face,
	FT_Size_Request req );

FT_Error
FT_Set_Char_Size(
	FT_Face face,
	FT_F26Dot6 char_width,
	FT_F26Dot6 char_height,
	FT_UInt horz_resolution,
	FT_UInt vert_resolution );

FT_Error
FT_Set_Pixel_Sizes(
	FT_Face face,
	FT_UInt pixel_width,
	FT_UInt pixel_height );

FT_Error
FT_Load_Glyph(
	FT_Face face,
	FT_UInt glyph_index,
	FT_Int32 load_flags );

FT_Error
FT_Load_Char(
	FT_Face face,
	FT_ULong char_code,
	FT_Int32 load_flags );

enum {
	FT_LOAD_DEFAULT          = 0x0,
	FT_LOAD_NO_SCALE         = ( 1 << 0 ),
	FT_LOAD_NO_HINTING       = ( 1 << 1 ),
	FT_LOAD_RENDER           = ( 1 << 2 ),
	FT_LOAD_NO_BITMAP        = ( 1 << 3 ),
	FT_LOAD_VERTICAL_LAYOUT  = ( 1 << 4 ),
	FT_LOAD_FORCE_AUTOHINT   = ( 1 << 5 ),
	FT_LOAD_CROP_BITMAP      = ( 1 << 6 ), // ignored, deprecated
	FT_LOAD_PEDANTIC         = ( 1 << 7 ),
	FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH = ( 1 << 9 ),  // ignored, deprecated
	FT_LOAD_NO_RECURSE       = ( 1 << 10 ),
	FT_LOAD_IGNORE_TRANSFORM = ( 1 << 11 ),
	FT_LOAD_MONOCHROME       = ( 1 << 12 ),
	FT_LOAD_LINEAR_DESIGN    = ( 1 << 13 ),
	FT_LOAD_NO_AUTOHINT      = ( 1 << 15 ),
	FT_LOAD_COLOR            = ( 1 << 20 ),
	FT_LOAD_COMPUTE_METRICS  = ( 1 << 21 ),
	FT_LOAD_BITMAP_METRICS_ONLY = ( 1 << 22 ),
	FT_LOAD_ADVANCE_ONLY     = ( 1 << 8 ),
	FT_LOAD_SBITS_ONLY       = ( 1 << 14 ),
};

typedef enum FT_Render_Mode_ {
	FT_RENDER_MODE_NORMAL = 0,
	FT_RENDER_MODE_LIGHT,
	FT_RENDER_MODE_MONO,
	FT_RENDER_MODE_LCD,
	FT_RENDER_MODE_LCD_V,
	FT_RENDER_MODE_MAX
} FT_Render_Mode;

enum {
	FT_LOAD_TARGET_NORMAL = (FT_RENDER_MODE_NORMAL & 15) << 16,
	FT_LOAD_TARGET_LIGHT  = (FT_RENDER_MODE_LIGHT & 15) << 16,
	FT_LOAD_TARGET_MONO   = (FT_RENDER_MODE_MONO & 15) << 16,
	FT_LOAD_TARGET_LCD    = (FT_RENDER_MODE_LCD & 15) << 16,
	FT_LOAD_TARGET_LCD_V  = (FT_RENDER_MODE_LCD_V & 15) << 16
};

void FT_Set_Transform( FT_Face face, FT_Matrix* matrix, FT_Vector* delta );

FT_Error FT_Render_Glyph( FT_GlyphSlot slot, FT_Render_Mode render_mode );

typedef enum FT_Kerning_Mode_ {
	FT_KERNING_DEFAULT = 0,
	FT_KERNING_UNFITTED,
	FT_KERNING_UNSCALED
} FT_Kerning_Mode;

FT_Error
FT_Get_Kerning(
	FT_Face face,
	FT_UInt left_glyph,
	FT_UInt right_glyph,
	FT_UInt kern_mode,
	FT_Vector *akerning );

FT_Error
FT_Get_Track_Kerning(
	FT_Face face,
	FT_Fixed point_size,
	FT_Int degree,
	FT_Fixed* akerning );

FT_Error
FT_Get_Glyph_Name(
	FT_Face face,
	FT_UInt glyph_index,
	FT_Pointer buffer,
	FT_UInt buffer_max );

const char* FT_Get_Postscript_Name( FT_Face face );

FT_Error FT_Select_Charmap( FT_Face face, FT_Encoding encoding );
FT_Error FT_Set_Charmap( FT_Face face, FT_CharMap charmap );
FT_Int   FT_Get_Charmap_Index( FT_CharMap charmap );
FT_UInt  FT_Get_Char_Index( FT_Face face, FT_ULong charcode );
FT_ULong FT_Get_First_Char( FT_Face face, FT_UInt *agindex );
FT_ULong FT_Get_Next_Char( FT_Face face, FT_ULong char_code, FT_UInt *agindex );

FT_Error FT_Face_Properties( FT_Face face, FT_UInt num_properties, FT_Parameter* properties );
FT_UInt  FT_Get_Name_Index( FT_Face face, FT_String* glyph_name );

enum {
	FT_SUBGLYPH_FLAG_ARGS_ARE_WORDS = 1,
	FT_SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES = 2,
	FT_SUBGLYPH_FLAG_ROUND_XY_TO_GRID = 4,
	FT_SUBGLYPH_FLAG_SCALE = 8,
	FT_SUBGLYPH_FLAG_XY_SCALE = 0x40,
	FT_SUBGLYPH_FLAG_2X2 = 0x80,
	FT_SUBGLYPH_FLAG_USE_MY_METRICS = 0x200,
};

FT_Error
FT_Get_SubGlyph_Info( FT_GlyphSlot glyph,
	FT_UInt sub_index,
	FT_Int *p_index,
	FT_UInt *p_flags,
	FT_Int *p_arg1,
	FT_Int *p_arg2,
	FT_Matrix *p_transform );

enum {
	FT_FSTYPE_INSTALLABLE_EMBEDDING = 0x0000,
	FT_FSTYPE_RESTRICTED_LICENSE_EMBEDDING = 0x0002,
	FT_FSTYPE_PREVIEW_AND_PRINT_EMBEDDING = 0x0004,
	FT_FSTYPE_EDITABLE_EMBEDDING = 0x0008,
	FT_FSTYPE_NO_SUBSETTING = 0x0100,
	FT_FSTYPE_BITMAP_EMBEDDING_ONLY = 0x0200,
};

FT_UShort  FT_Get_FSType_Flags ( FT_Face face );

FT_UInt    FT_Face_GetCharVariantIndex     ( FT_Face face, FT_ULong charcode, FT_ULong variantSelector );
FT_Int     FT_Face_GetCharVariantIsDefault ( FT_Face face, FT_ULong charcode, FT_ULong variantSelector );
FT_UInt32* FT_Face_GetVariantSelectors     ( FT_Face face );
FT_UInt32* FT_Face_GetVariantsOfChar       ( FT_Face face, FT_ULong charcode );
FT_UInt32* FT_Face_GetCharsOfVariant       ( FT_Face face, FT_ULong variantSelector );

FT_Long  FT_MulDiv( FT_Long a, FT_Long b, FT_Long c );
FT_Long  FT_MulFix( FT_Long a, FT_Long b );
FT_Long  FT_DivFix( FT_Long a, FT_Long b );
FT_Fixed FT_RoundFix( FT_Fixed a );
FT_Fixed FT_CeilFix( FT_Fixed a );
FT_Fixed FT_FloorFix( FT_Fixed a );

void FT_Vector_Transform( FT_Vector* vec, const FT_Matrix* matrix );

void FT_Library_Version( FT_Library library,
	FT_Int *amajor,
	FT_Int *aminor,
	FT_Int *apatch );

FT_Bool FT_Face_CheckTrueTypePatents( FT_Face face );
FT_Bool FT_Face_SetUnpatentedHinting( FT_Face face, FT_Bool value );

// ftbitmap.h ----------------------------------------------------------------

void     FT_Bitmap_Init     (FT_Bitmap *abitmap);
void     FT_Bitmap_New      (FT_Bitmap *abitmap);
FT_Error FT_Bitmap_Copy     (FT_Library library, const FT_Bitmap *source, FT_Bitmap *target);
FT_Error FT_Bitmap_Embolden (FT_Library library, FT_Bitmap* bitmap, FT_Pos xStrength, FT_Pos yStrength);
FT_Error FT_Bitmap_Convert  (FT_Library library, const FT_Bitmap *source, FT_Bitmap *target, FT_Int alignment);
FT_Error FT_GlyphSlot_Own_Bitmap (FT_GlyphSlot slot);
FT_Error FT_Bitmap_Done     (FT_Library library, FT_Bitmap *bitmap);

// ftglyph.h -----------------------------------------------------------------

typedef struct FT_Glyph_Class_ FT_Glyph_Class;
typedef struct FT_GlyphRec_* FT_Glyph;
typedef struct FT_GlyphRec_ {
	FT_Library library;
	const FT_Glyph_Class* clazz;
	FT_Glyph_Format format;
	FT_Vector advance;
} FT_GlyphRec;

typedef struct FT_BitmapGlyphRec_* FT_BitmapGlyph;
typedef struct FT_BitmapGlyphRec_ {
	FT_GlyphRec root;
	FT_Int left;
	FT_Int top;
	FT_Bitmap bitmap;
} FT_BitmapGlyphRec;

typedef struct FT_OutlineGlyphRec_* FT_OutlineGlyph;
typedef struct FT_OutlineGlyphRec_ {
	FT_GlyphRec root;
	FT_Outline outline;
} FT_OutlineGlyphRec;

FT_Error FT_Get_Glyph       ( FT_GlyphSlot slot, FT_Glyph *aglyph );
FT_Error FT_Glyph_Copy      ( FT_Glyph source, FT_Glyph *target );
FT_Error FT_Glyph_Transform ( FT_Glyph glyph, FT_Matrix* matrix, FT_Vector* delta );

typedef enum FT_Glyph_BBox_Mode_ {
	FT_GLYPH_BBOX_UNSCALED = 0,
	FT_GLYPH_BBOX_SUBPIXELS = 0,
	FT_GLYPH_BBOX_GRIDFIT = 1,
	FT_GLYPH_BBOX_TRUNCATE = 2,
	FT_GLYPH_BBOX_PIXELS = 3
} FT_Glyph_BBox_Mode;

void     FT_Glyph_Get_CBox  ( FT_Glyph glyph, FT_UInt bbox_mode, FT_BBox *acbox );
FT_Error FT_Glyph_To_Bitmap ( FT_Glyph* the_glyph, FT_Render_Mode render_mode, FT_Vector* origin, FT_Bool destroy );
void     FT_Done_Glyph      ( FT_Glyph glyph );

void     FT_Matrix_Multiply ( const FT_Matrix* a, FT_Matrix* b );
FT_Error FT_Matrix_Invert   ( FT_Matrix* matrix );

// ftoutln.h -----------------------------------------------------------------

FT_Error FT_Outline_Decompose     ( FT_Outline* outline, const FT_Outline_Funcs* func_interface, void* user );
FT_Error FT_Outline_New           ( FT_Library library, FT_UInt numPoints, FT_Int numContours, FT_Outline *anoutline );
FT_Error FT_Outline_New_Internal  ( FT_Memory memory, FT_UInt numPoints, FT_Int numContours, FT_Outline *anoutline );
FT_Error FT_Outline_Done          ( FT_Library library, FT_Outline* outline );
FT_Error FT_Outline_Done_Internal ( FT_Memory memory, FT_Outline* outline );
FT_Error FT_Outline_Check         ( FT_Outline* outline );
void     FT_Outline_Get_CBox      ( const FT_Outline* outline, FT_BBox *acbox );
void     FT_Outline_Translate     ( const FT_Outline* outline, FT_Pos xOffset, FT_Pos yOffset );
FT_Error FT_Outline_Copy          ( const FT_Outline* source, FT_Outline *target );
void     FT_Outline_Transform     ( const FT_Outline* outline, const FT_Matrix* matrix );
FT_Error FT_Outline_Embolden      ( FT_Outline* outline, FT_Pos strength );
FT_Error FT_Outline_EmboldenXY    ( FT_Outline* outline, FT_Pos xstrength, FT_Pos ystrength );
void     FT_Outline_Reverse       ( FT_Outline* outline );
FT_Error FT_Outline_Get_Bitmap    ( FT_Library library, FT_Outline* outline, const FT_Bitmap *abitmap );
FT_Error FT_Outline_Render        ( FT_Library library, FT_Outline* outline, FT_Raster_Params* params );

typedef enum FT_Orientation_ {
	FT_ORIENTATION_TRUETYPE = 0,
	FT_ORIENTATION_POSTSCRIPT = 1,
	FT_ORIENTATION_FILL_RIGHT = FT_ORIENTATION_TRUETYPE,
	FT_ORIENTATION_FILL_LEFT = FT_ORIENTATION_POSTSCRIPT,
	FT_ORIENTATION_NONE
} FT_Orientation;

FT_Orientation FT_Outline_Get_Orientation( FT_Outline* outline );

// ftmodapi.h ----------------------------------------------------------------

enum {
	FT_MODULE_FONT_DRIVER = 1,
	FT_MODULE_RENDERER   = 2,
	FT_MODULE_HINTER     = 4,
	FT_MODULE_STYLER     = 8,
	FT_MODULE_DRIVER_SCALABLE = 0x100,
	FT_MODULE_DRIVER_NO_OUTLINES = 0x200,
	FT_MODULE_DRIVER_HAS_HINTER = 0x400,
	FT_MODULE_DRIVER_HINTS_LIGHTLY = 0x800,
};
typedef FT_Pointer FT_Module_Interface;
typedef FT_Error (*FT_Module_Constructor)( FT_Module module );
typedef void     (*FT_Module_Destructor)( FT_Module module );
typedef FT_Module_Interface(*FT_Module_Requester)(
	FT_Module module,
	const char* name );

typedef struct FT_Module_Class_ {
	FT_ULong module_flags;
	FT_Long module_size;
	const FT_String* module_name;
	FT_Fixed module_version;
	FT_Fixed module_requires;
	const void* module_interface;
	FT_Module_Constructor module_init;
	FT_Module_Destructor module_done;
	FT_Module_Requester get_interface;
} FT_Module_Class;

FT_Error  FT_Add_Module   ( FT_Library library, const FT_Module_Class* clazz );
FT_Module FT_Get_Module   ( FT_Library library, const char* module_name );
FT_Error  FT_Remove_Module( FT_Library library, FT_Module module );

FT_Error FT_Property_Set(
	FT_Library library,
	const FT_String* module_name,
	const FT_String* property_name,
	const void* value );

FT_Error FT_Property_Get(
	FT_Library library,
	const FT_String* module_name,
	const FT_String* property_name,
	void* value );

void FT_Set_Default_Properties( FT_Library library );

FT_Error FT_Reference_Library ( FT_Library library );
FT_Error FT_New_Library       ( FT_Memory memory, FT_Library *alibrary );
FT_Error FT_Done_Library      ( FT_Library library );

typedef void (*FT_DebugHook_Func)( void* arg );

void FT_Set_Debug_Hook(
	FT_Library library,
	FT_UInt hook_index,
	FT_DebugHook_Func debug_hook );

void FT_Add_Default_Modules(
	FT_Library library );

typedef enum FT_TrueTypeEngineType_ {
	FT_TRUETYPE_ENGINE_TYPE_NONE = 0,
	FT_TRUETYPE_ENGINE_TYPE_UNPATENTED,
	FT_TRUETYPE_ENGINE_TYPE_PATENTED
} FT_TrueTypeEngineType;

FT_TrueTypeEngineType FT_Get_TrueType_Engine_Type(
	FT_Library library );

// ftcache.h -----------------------------------------------------------------

typedef FT_Pointer FTC_FaceID;

typedef FT_Error (*FTC_Face_Requester)(
	FTC_FaceID face_id,
	FT_Library library,
	FT_Pointer req_data,
	FT_Face* aface );

typedef struct FTC_ManagerRec_* FTC_Manager;
typedef struct FTC_NodeRec_* FTC_Node;

FT_Error FTC_Manager_New(
	FT_Library library,
	FT_UInt max_faces,
	FT_UInt max_sizes,
	FT_ULong max_bytes,
	FTC_Face_Requester requester,
	FT_Pointer req_data,
	FTC_Manager *amanager );

void FTC_Manager_Reset( FTC_Manager manager );
void FTC_Manager_Done( FTC_Manager manager );

FT_Error FTC_Manager_LookupFace(
	FTC_Manager manager,
	FTC_FaceID face_id,
	FT_Face *aface );

typedef struct FTC_ScalerRec_ {
	FTC_FaceID face_id;
	FT_UInt width;
	FT_UInt height;
	FT_Int pixel;
	FT_UInt x_res;
	FT_UInt y_res;
} FTC_ScalerRec;

typedef struct FTC_ScalerRec_* FTC_Scaler;

FT_Error FTC_Manager_LookupSize(
	FTC_Manager manager,
	FTC_Scaler scaler,
	FT_Size *asize );

void FTC_Node_Unref(
	FTC_Node node,
	FTC_Manager manager );

void FTC_Manager_RemoveFaceID(
	FTC_Manager manager,
	FTC_FaceID face_id );

typedef struct FTC_CMapCacheRec_* FTC_CMapCache;

FT_Error FTC_CMapCache_New(
	FTC_Manager manager,
	FTC_CMapCache *acache );

FT_UInt FTC_CMapCache_Lookup(
	FTC_CMapCache cache,
	FTC_FaceID face_id,
	FT_Int cmap_index,
	FT_UInt32 char_code );

typedef struct FTC_ImageTypeRec_ {
	FTC_FaceID face_id;
	FT_UInt width;
	FT_UInt height;
	FT_Int32 flags;
} FTC_ImageTypeRec;

typedef struct FTC_ImageTypeRec_* FTC_ImageType;

typedef struct FTC_ImageCacheRec_* FTC_ImageCache;

FT_Error FTC_ImageCache_New(
	FTC_Manager manager,
	FTC_ImageCache *acache );

FT_Error FTC_ImageCache_Lookup(
	FTC_ImageCache cache,
	FTC_ImageType type,
	FT_UInt gindex,
	FT_Glyph *aglyph,
	FTC_Node *anode );

FT_Error FTC_ImageCache_LookupScaler(
	FTC_ImageCache cache,
	FTC_Scaler scaler,
	FT_ULong load_flags,
	FT_UInt gindex,
	FT_Glyph *aglyph,
	FTC_Node *anode );

typedef struct FTC_SBitRec_* FTC_SBit;
typedef struct FTC_SBitRec_ {
	FT_Byte width;
	FT_Byte height;
	FT_Char left;
	FT_Char top;
	FT_Byte format;
	FT_Byte max_grays;
	FT_Short pitch;
	FT_Char xadvance;
	FT_Char yadvance;
	FT_Byte* buffer;
} FTC_SBitRec;

typedef struct FTC_SBitCacheRec_* FTC_SBitCache;

FT_Error FTC_SBitCache_New(
	FTC_Manager manager,
	FTC_SBitCache *acache );

FT_Error FTC_SBitCache_Lookup(
	FTC_SBitCache cache,
	FTC_ImageType type,
	FT_UInt gindex,
	FTC_SBit *sbit,
	FTC_Node *anode );

FT_Error FTC_SBitCache_LookupScaler(
	FTC_SBitCache cache,
	FTC_Scaler scaler,
	FT_ULong load_flags,
	FT_UInt gindex,
	FTC_SBit *sbit,
	FTC_Node *anode );

// ftstroke.h ----------------------------------------------------------------

typedef struct FT_StrokerRec_* FT_Stroker;
typedef enum FT_Stroker_LineJoin_ {
	FT_STROKER_LINEJOIN_ROUND = 0,
	FT_STROKER_LINEJOIN_BEVEL = 1,
	FT_STROKER_LINEJOIN_MITER_VARIABLE = 2,
	FT_STROKER_LINEJOIN_MITER = FT_STROKER_LINEJOIN_MITER_VARIABLE,
	FT_STROKER_LINEJOIN_MITER_FIXED = 3
} FT_Stroker_LineJoin;

typedef enum FT_Stroker_LineCap_ {
	FT_STROKER_LINECAP_BUTT = 0,
	FT_STROKER_LINECAP_ROUND,
	FT_STROKER_LINECAP_SQUARE
} FT_Stroker_LineCap;

typedef enum FT_StrokerBorder_ {
	FT_STROKER_BORDER_LEFT = 0,
	FT_STROKER_BORDER_RIGHT
} FT_StrokerBorder;

FT_StrokerBorder FT_Outline_GetInsideBorder(
	FT_Outline* outline );

FT_StrokerBorder FT_Outline_GetOutsideBorder(
	FT_Outline* outline );

FT_Error FT_Stroker_New(
	FT_Library library,
	FT_Stroker *astroker );

void FT_Stroker_Set(
	FT_Stroker stroker,
	FT_Fixed radius,
	FT_Stroker_LineCap line_cap,
	FT_Stroker_LineJoin line_join,
	FT_Fixed miter_limit );

void FT_Stroker_Rewind(
	FT_Stroker stroker );

FT_Error FT_Stroker_ParseOutline(
	FT_Stroker stroker,
	FT_Outline* outline,
	FT_Bool opened );

FT_Error FT_Stroker_BeginSubPath(
	FT_Stroker stroker,
	FT_Vector* to,
	FT_Bool open );

FT_Error FT_Stroker_EndSubPath(
	FT_Stroker stroker );

FT_Error FT_Stroker_LineTo(
	FT_Stroker stroker,
	FT_Vector* to );

FT_Error FT_Stroker_ConicTo(
	FT_Stroker stroker,
	FT_Vector* control,
	FT_Vector* to );

FT_Error FT_Stroker_CubicTo(
	FT_Stroker stroker,
	FT_Vector* control1,
	FT_Vector* control2,
	FT_Vector* to );

FT_Error FT_Stroker_GetBorderCounts(
	FT_Stroker stroker,
	FT_StrokerBorder border,
	FT_UInt *anum_points,
	FT_UInt *anum_contours );

void FT_Stroker_ExportBorder(
	FT_Stroker stroker,
	FT_StrokerBorder border,
	FT_Outline* outline );

FT_Error FT_Stroker_GetCounts(
	FT_Stroker stroker,
	FT_UInt *anum_points,
	FT_UInt *anum_contours );

void FT_Stroker_Export(
	FT_Stroker stroker,
	FT_Outline* outline );

void FT_Stroker_Done( FT_Stroker stroker );

FT_Error FT_Glyph_Stroke(
	FT_Glyph *pglyph,
	FT_Stroker stroker,
	FT_Bool destroy );

FT_Error FT_Glyph_StrokeBorder(
	FT_Glyph *pglyph,
	FT_Stroker stroker,
	FT_Bool inside,
	FT_Bool destroy );
	
]])

ft = ffi.load(lwlgl.libs.freetype[2])

freetype = {ft = ft}
setmetatable(freetype, freetype)

-- Utilities
Error_Names = {
	[0x01] = 'Cannot Open Resource',
	[0x02] = 'Unknown File Format',
	[0x03] = 'Invalid File Format',
	[0x04] = 'Invalid Version',
	[0x05] = 'Lower Module Version',
	[0x06] = 'Invalid Argument',
	[0x07] = 'Unimplemented Feature',
	[0x08] = 'Invalid Table',
	[0x09] = 'Invalid Offset',
	[0x0A] = 'Array Too Large',
	[0x10] = 'Invalid Glyph Index',
	[0x11] = 'Invalid Character Code',
	[0x12] = 'Invalid Glyph Format',
	[0x13] = 'Cannot Render Glyph',
	[0x14] = 'Invalid Outline',
	[0x15] = 'Invalid Composite',
	[0x16] = 'Too Many Hints',
	[0x17] = 'Invalid Pixel Size',
	[0x20] = 'Invalid Handle',
	[0x21] = 'Invalid Library Handle',
	[0x22] = 'Invalid Driver Handle',
	[0x23] = 'Invalid Face Handle',
	[0x24] = 'Invalid Size Handle',
	[0x25] = 'Invalid Slot Handle',
	[0x26] = 'Invalid CharMap Handle',
	[0x27] = 'Invalid Cache Handle',
	[0x28] = 'Invalid Stream Handle',
	[0x30] = 'Too Many Drivers',
	[0x31] = 'Too Many Extensions',
	[0x40] = 'Out Of Memory',
	[0x41] = 'Unlisted Object',
	[0x51] = 'Cannot Open Stream',
	[0x52] = 'Invalid Stream Seek',
	[0x53] = 'Invalid Stream Skip',
	[0x54] = 'Invalid Stream Read',
	[0x55] = 'Invalid Stream Operation',
	[0x56] = 'Invalid Frame Operation',
	[0x57] = 'Nested Frame Access',
	[0x58] = 'Invalid Frame Read',
	[0x60] = 'Raster Uninitialized',
	[0x61] = 'Raster Corrupted',
	[0x62] = 'Raster Overflow',
	[0x63] = 'Raster Negative Height',
	[0x70] = 'Too Many Caches',
	[0x80] = 'Invalid Opcode',
	[0x81] = 'Too Few Arguments',
	[0x82] = 'Stack Overflow',
	[0x83] = 'Code Overflow',
	[0x84] = 'Bad Argument',
	[0x85] = 'Divide By Zero',
	[0x86] = 'Invalid Reference',
	[0x87] = 'Debug OpCode',
	[0x88] = 'ENDF In Exec Stream',
	[0x89] = 'Nested DEFS',
	[0x8A] = 'Invalid CodeRange',
	[0x8B] = 'Execution Too Long',
	[0x8C] = 'Too Many Function Defs',
	[0x8D] = 'Too Many Instruction Defs',
	[0x8E] = 'Table Missing',
	[0x8F] = 'Horiz Header Missing',
	[0x90] = 'Locations Missing',
	[0x91] = 'Name Table Missing',
	[0x92] = 'CMap Table Missing',
	[0x93] = 'Hmtx Table Missing',
	[0x94] = 'Post Table Missing',
	[0x95] = 'Invalid Horiz Metrics',
	[0x96] = 'Invalid CharMap Format',
	[0x97] = 'Invalid PPem',
	[0x98] = 'Invalid Vert Metrics',
	[0x99] = 'Could Not Find Context',
	[0x9A] = 'Invalid Post Table Format',
	[0x9B] = 'Invalid Post Table',
	[0xA0] = 'Syntax Error',
	[0xA1] = 'Stack Underflow',
	[0xA2] = 'Ignore',
	[0xA3] = 'No Unicode Glyph Name',
	[0xB0] = 'Missing Startfont Field',
	[0xB1] = 'Missing Font Field',
	[0xB2] = 'Missing Size Field',
	[0xB3] = 'Missing Fontboundingbox Field',
	[0xB4] = 'Missing Chars Field',
	[0xB5] = 'Missing Startchar Field',
	[0xB6] = 'Missing Encoding Field',
	[0xB7] = 'Missing Bbx Field',
	[0xB8] = 'Bbx Too Big',
	[0xB9] = 'Corrupted Font Header',
	[0xBA] = 'Corrupted Font Glyphs',
}

function checkz(result)
	if result == 0 then return end
	error(string.format('freetype error %d: %s', result,
		Error_Names[result] or '<unknown error>'), 2)
end

function nonzero(ret)
	return ret ~= 0 and ret or nil
end

function ptr(p)
	return p ~= nil and p or nil
end

function freetype.tag_tostring(i)
	i = tonumber(i)
	return
		string.char(bit.band(bit.rshift(i, 24), 0xff)) ..
		string.char(bit.band(bit.rshift(i, 16), 0xff)) ..
		string.char(bit.band(bit.rshift(i,  8), 0xff)) ..
		string.char(bit.band(bit.rshift(i,  0), 0xff))
end

function freetype.tag(s)
	if type(s) == 'string' then
		return s:byte(1) * 2^24 + s:byte(2) * 2^16 + s:byte(3) * 2^8 + s:byte(4)
	else
		return s
	end
end

--wrappers

function freetype.new()
	library = ffi.new'FT_Library[1]'
	checkz(ft.FT_Init_FreeType(library))
	return library[0]
end
freetype.__call = freetype.new

lib = {} -- FT_Library methods

function lib.version(library)
	v = ffi.new'FT_Int[3]'
	ft.FT_Library_Version(library, v, v+1, v+2)
	return v[0], v[1], v[2]
end

function lib.free(library)
	checkz(ft.FT_Done_FreeType(library))
end

function lib.face(library, filename, face_index)
	face = ffi.new'FT_Face[1]'
	checkz(ft.FT_New_Face(library, filename, face_index or 0, face))
	return face[0]
end

function lib.memory_face(library, data, size, face_index)
	face = ffi.new'FT_Face[1]'
	checkz(ft.FT_New_Memory_Face(library, data, size, face_index or 0, face))
	return face[0]
end

--TODO: construct FT_Args
function lib.open_face(library, args, face_index)
	face = ffi.new'FT_Face[1]'
	checkz(ft.FT_Open_Face(library, args, face_index or 0, face))
	return face[0]
end

function lib.ref(lib)
	checkz(ft.FT_Reference_Library(lib))
end

face = {} --FT_Face methods

face.set_transform = ft.FT_Set_Transform
face.char_index = ft.FT_Get_Char_Index
--face.fstype_flags = ft.FT_Get_FSType_Flags --fstype stripped (needs type1)

function face.ref(face)
	checkz(ft.FT_Reference_Face(face))
end

function face.attach_file(face, filepathname)
	checkz(ft.FT_Attach_File(face, filepathname))
end

--TODO: construct FT_Args
function face.attach_stream(face, parameters)
	checkz(ft.FT_Attach_Stream(face, parameters))
end

function face.free(face)
	ffi.gc(face, nil)
	checkz(ft.FT_Done_Face(face))
end

function face.select_size(face, strike_index)
	checkz(ft.FT_Select_Size(face, strike_index))
end

function face.request_size(face, req)
	req = req or ffi.new'FT_Size_Request'
	checkz(ft.FT_Request_Size(face, req))
	return req
end

function face.set_char_size(face, char_width, char_height, horz_resolution, vert_resolution)
	checkz(ft.FT_Set_Char_Size(face, char_width, char_height or 0, horz_resolution or 0, vert_resolution or 0))
end

function face.set_pixel_sizes(face, pixel_width, pixel_height)
	checkz(ft.FT_Set_Pixel_Sizes(face, pixel_width, pixel_height or 0))
end

function face.load_glyph(face, glyph_index, load_flags) --FT_LOAD_*
	checkz(ft.FT_Load_Glyph(face, glyph_index, load_flags or 0))
end

function face.load_char(face, char_code, load_flags) --FT_LOAD_*
	checkz(ft.FT_Load_Char(face, char_code, load_flags))
end

function face.kerning(face, left_glyph, right_glyph, kern_mode, kerning) --FT_KERNING_*
	kerning = kerning or ffi.new'FT_Vector'
	checkz(ft.FT_Get_Kerning(face, left_glyph, right_glyph, kern_mode, kerning))
	return kerning
end

function face.track_kerning(face, point_size, degree, kerning)
	kerning = kerning or ffi.new'FT_Vector'
	checkz(ft.FT_Get_Track_Kerning(face, point_size, degree, kerning))
	return kerning
end

function face.glyph_name(face, glyph_index, buffer, buffer_max)
	buffer = buffer or ffi.new('uint8_t[?]', buffer_max or 64)
	ret = ft.FT_Get_Glyph_Name(face, glyph_index, buffer, buffer_max)
	return ret ~= 0 and ffi.string(buffer) or nil
end

function face.postscript_name(face)
	name = ft.FT_Get_Postscript_Name(face)
	return name ~= nil and ffi.string(name) or nil
end

function face.select_charmap(face, encoding)
	if type(encoding) == 'string' then
		encoding =
			  (encoding:byte(1) or 32) * 2^24
			+ (encoding:byte(2) or 32) * 2^16
			+ (encoding:byte(3) or 32) * 2^8
			+ (encoding:byte(4) or 32)
	end
	checkz(ft.FT_Select_Charmap(face, encoding))
end

function face.set_charmap(face, charmap)
	checkz(ft.FT_Set_Charmap(face, charmap))
end

charmap = {}

function charmap.index(charmap)
	ret = ft.FT_Get_Charmap_Index(charmap)
	assert(ret ~= -1, 'invalid charmap')
	return ret
end

function charmap.encoding_str(charmap)
	return string.reverse(ffi.string(charmap._encoding_str, 4))
end

face.first_char = ft.FT_Get_First_Char
face.next_char = ft.FT_Get_Next_Char

function face.chars(face) --returns iterator<charcode, glyph_index>
	gindex = ffi.new'FT_UInt[1]'
	return function(_, charcode)
		if not charcode then
			charcode = ft.FT_Get_First_Char(face, gindex)
		else
			charcode = ft.FT_Get_Next_Char(face, charcode, gindex)
		end
		if gindex[0] == 0 then return end
		return charcode, gindex[0]
	end
end

function face.char_count(face)
	gindex = ffi.new'FT_UInt[1]'
	charcode = ft.FT_Get_First_Char(face, gindex)
	n = 0
	while gindex[0] ~= 0 do
		n = n + 1
		charcode = ft.FT_Get_Next_Char(face, charcode, gindex)
	end
	return n
end

function face.name_index(face, glyph_name)
	return nonzero(ft.FT_Get_Name_Index(face, glyph_name))
end

function face.char_variant_index(face, charcode, variantSelector)
	return nonzero(ft.FT_Face_GetCharVariantIndex(face, charcode, variantSelector))
end

function face.char_variant_is_default(face, charcode, variantSelector)
	ret = ft.FT_Face_GetCharVariantIsDefault(face, charcode, variantSelector)
	if ret == -1 then return nil end
	return ret == 1 --1 if found in the standard (Unicode) cmap, 0 if found in the variation selector cmap
end

function face.variant_selectors(face)
	return ptr(ft.FT_Face_GetVariantSelectors(face))
end

function face.variants_of_char(face, charcode)
	return ptr(ft.FT_Face_GetVariantsOfChar(face, charcode))
end

function face.chars_of_variant(face, variantSelector)
	return ptr(ft.FT_Face_GetCharsOfVariant(face, variantSelector))
end

--ftbitmap.h

function lib.bitmap(library)
	bitmap = ffi.new'FT_Bitmap'
	ft.FT_Bitmap_New(bitmap)
	return bitmap
end

function lib.free_bitmap(library, bitmap)
	checkz(ft.FT_Bitmap_Done(library, bitmap))
end

function lib.copy_bitmap(library, source, target)
	checkz(ft.FT_Bitmap_Copy(library, source, target))
end

function lib.embolden_bitmap(library, bitmap, xStrength, yStrength)
	checkz(ft.FT_Bitmap_Embolden(library, bitmap, xStrength, yStrength))
end

function lib.convert_bitmap(library, source, target, alignment)
	checkz(ft.FT_Bitmap_Convert(library, source, target, alignment))
end

slot = {} --FT_GlyphSlot methods

function slot.render(slot, render_mode) --FT_RENDER_*
	checkz(ft.FT_Render_Glyph(slot, render_mode or 0))
end

function slot.subglyph_info(glyph, sub_index, p_index, p_flags, p_arg1, p_arg2, p_transform)
	p_index = p_index or ffi.new'FT_Int[1]'
	p_flags = p_flags or ffi.new'FT_UInt[1]'
	p_arg1  = p_arg1  or ffi.new'FT_Int[1]'
	p_arg2  = p_arg2  or ffi.new'FT_Int[1]'
	p_transform = p_transform or ffi.new'FT_Matrix'
	checkz(ft.FT_Get_SubGlyph_Info(glyph, sub_index, p_index, p_flags, p_arg1, p_arg2, p_transform))
	return
		p_index[0], p_flags[0], p_arg1[0], p_arg2[0], p_transform
end

function slot.own_bitmap(slot)
	checkz(ft.FT_GlyphSlot_Own_Bitmap(slot))
end

--ftglyph.h

function slot.glyph(slot, glyph)
	glyph = glyph or ffi.new'FT_Glyph[1]'
	checkz(ft.FT_Get_Glyph(slot, glyph))
	return glyph[0]
end

glyph = {}

function glyph.copy(source, target)
	target = target or ffi.new'FT_Glyph[1]'
	checkz(ft.FT_Glyph_Copy(source, target))
	return target[0]
end

function glyph.transform(glyph, matrix, delta)
	checkz(ft.FT_Glyph_Transform(glyph, matrix, delta))
	return glyph
end

function glyph.to_bitmap(glyph, render_mode, origin, destroy)
	if destroy == nil then destroy = true end
	pglyph = ffi.new('FT_Glyph[1]', glyph)
	checkz(ft.FT_Glyph_To_Bitmap(pglyph, render_mode or 0, origin, destroy))
	return pglyph[0]
end

glyph.cbox = ft.FT_Glyph_Get_CBox
glyph.free = ft.FT_Done_Glyph

function glyph.as_bitmap(glyph)
	assert(glyph.format == ft.FT_GLYPH_FORMAT_BITMAP)
	return ffi.cast('FT_BitmapGlyph', glyph)
end

function glyph.as_outline(glyph)
	assert(glyph.format == ft.FT_GLYPH_FORMAT_OUTLINE)
	return ffi.cast('FT_OutlineGlyph', glyph)
end

--ftoutln.h

function lib.outline(library, numPoints, numContours)
	numPoints = numPoints or 0xFFFF
	numContours = math.min(math.max(numContours or numPoints, 0), 0xFFFF)
	outline = ffi.new'FT_Outline[1]'
	checkz(ft.FT_Outline_New(library, numPoints, numContours, outline))
	return outline[0]
end

outline = {} --FT_Outline methods

outline.translate = ft.FT_Outline_Translate
outline.transform = ft.FT_Outline_Transform
outline.orientation = ft.FT_Outline_Get_Orientation

function lib.free_outline(library, outline)
	checkz(ft.FT_Outline_Done(library, outline))
end

function outline.decompose(outline, func_interface, userdata)
	checkz(ft.FT_Outline_Decompose(outline, func_interface, userdata))
end

function outline.check(outline)
	checkz(ft.FT_Outline_Check(outline))
end

function outline.cbox(outline, cbox)
	cbox = cbox or ffi.new'FT_BBox'
	checkz(ft.FT_Outline_Get_CBox(outline, cbox))
	return cbox
end

function outline.copy(source, target)
	checkz(ft.FT_Outline_Copy(source, target))
	return target
end

function outline.embolden(outline, xstrength, ystrength)
	if ystrength then
		checkz(ft.FT_Outline_EmboldenXY(outline, xstrength, ystrength))
	else
		checkz(ft.FT_Outline_Embolden(outline, xstrength))
	end
end

function outline.reverse(outline)
	checkz(ft.FT_Outline_Reverse(outline))
end

function lib.get_outline_bitmap(library, outline, bitmap)
	checkz(ft.FT_Outline_Get_Bitmap(library, outline, bitmap))
	return bitmap
end

function lib.render_outline(library, outline, params)
	checkz(ft.FT_Outline_Render(library, outline, params))
end

--matrix methods not included in freetype

matrix = {}

function matrix:reset(...)
	self.xx, self.yx, self.xy, self.yy = 64, 0, 0, 64
	return self
end

function matrix:rotate(a)
	s = math.sin(a) * 64
	c = math.cos(a) * 64
	self.xx, self.yx, self.xy, self.yy =
		 c * self.xx + s * self.xy,
		 c * self.yx + s * self.yy,
		-s * self.xx + c * self.xy,
		-s * self.yx + c * self.yy
	return self
end

--methods

ffi.metatype('struct FT_LibraryRec_', {__index = lib})
ffi.metatype('struct FT_FaceRec_', {__index = face})
ffi.metatype('struct FT_GlyphSlotRec_', {__index = slot})
ffi.metatype('struct FT_GlyphRec_', {__index = glyph})
ffi.metatype('struct FT_CharMapRec_', {__index = charmap})
ffi.metatype('struct FT_Outline_', {__index = outline})
ffi.metatype('struct FT_Matrix_', {__index = matrix})

end

function load_al()

ffi.cdef([[

// al.h
enum {
       AL_INVALID = -1,
       AL_ILLEGAL_ENUM = 0xA002,
       AL_ILLEGAL_COMMAND = 0xA004,
	   AL_VERSION_1_0 = 1,
       AL_VERSION_1_1 = 1
};

typedef char ALboolean;
typedef char ALchar;
typedef signed char ALbyte;
typedef unsigned char ALubyte;
typedef short ALshort;
typedef unsigned short ALushort;
typedef int ALint;
typedef unsigned int ALuint;
typedef int ALsizei;
typedef int ALenum;
typedef float ALfloat;
typedef double ALdouble;
typedef void ALvoid;

enum {
     AL_NONE                                  = 0,
     AL_FALSE                                 = 0,
     AL_TRUE                                  = 1,
     AL_NO_ERROR                              = 0,
     AL_SOURCE_RELATIVE                       = 0x202,
     AL_CONE_INNER_ANGLE                      = 0x1001,
     AL_CONE_OUTER_ANGLE                      = 0x1002,
     AL_PITCH                                 = 0x1003,
     AL_POSITION                              = 0x1004,
     AL_DIRECTION                             = 0x1005,
     AL_VELOCITY                              = 0x1006,
     AL_LOOPING                               = 0x1007,
     AL_BUFFER                                = 0x1009,
     AL_GAIN                                  = 0x100A,
     AL_MIN_GAIN                              = 0x100D,
     AL_MAX_GAIN                              = 0x100E,
     AL_ORIENTATION                           = 0x100F,
     AL_SOURCE_STATE                          = 0x1010,
     AL_INITIAL                               = 0x1011,
     AL_PLAYING                               = 0x1012,
     AL_PAUSED                                = 0x1013,
     AL_STOPPED                               = 0x1014,
     AL_BUFFERS_QUEUED                        = 0x1015,
     AL_BUFFERS_PROCESSED                     = 0x1016,
     AL_REFERENCE_DISTANCE                    = 0x1020,
     AL_ROLLOFF_FACTOR                        = 0x1021,
     AL_CONE_OUTER_GAIN                       = 0x1022,
     AL_MAX_DISTANCE                          = 0x1023,
     AL_SEC_OFFSET                            = 0x1024,
     AL_SAMPLE_OFFSET                         = 0x1025,
     AL_BYTE_OFFSET                           = 0x1026,
     AL_SOURCE_TYPE                           = 0x1027,
     AL_STATIC                                = 0x1028,
     AL_STREAMING                             = 0x1029,
     AL_UNDETERMINED                          = 0x1030,
     AL_FORMAT_MONO8                          = 0x1100,
     AL_FORMAT_MONO16                         = 0x1101,
     AL_FORMAT_STEREO8                        = 0x1102,
     AL_FORMAT_STEREO16                       = 0x1103,
     AL_FREQUENCY                             = 0x2001,
     AL_BITS                                  = 0x2002,
     AL_CHANNELS                              = 0x2003,
     AL_SIZE                                  = 0x2004,
     AL_UNUSED                                = 0x2010,
     AL_PENDING                               = 0x2011,
     AL_PROCESSED                             = 0x2012,
     AL_INVALID_NAME                          = 0xA001,
     AL_INVALID_ENUM                          = 0xA002,
     AL_INVALID_VALUE                         = 0xA003,
     AL_INVALID_OPERATION                     = 0xA004,
     AL_OUT_OF_MEMORY                         = 0xA005,
     AL_VENDOR                                = 0xB001,
     AL_VERSION                               = 0xB002,
     AL_RENDERER                              = 0xB003,
     AL_EXTENSIONS                            = 0xB004,
     AL_DOPPLER_FACTOR                        = 0xC000
};

extern void  alDopplerFactor(ALfloat value);
enum { AL_DOPPLER_VELOCITY = 0xC001 };

extern void  alDopplerVelocity(ALfloat value);
enum { AL_SPEED_OF_SOUND = 0xC003 };

extern void  alSpeedOfSound(ALfloat value);
enum { AL_DISTANCE_MODEL = 0xD000 };

extern void  alDistanceModel(ALenum distanceModel);
enum {
    AL_INVERSE_DISTANCE = 0xD001,
    AL_INVERSE_DISTANCE_CLAMPED = 0xD002,
    AL_LINEAR_DISTANCE = 0xD003,
    AL_LINEAR_DISTANCE_CLAMPED = 0xD004,
    AL_EXPONENT_DISTANCE = 0xD005,
    AL_EXPONENT_DISTANCE_CLAMPED = 0xD006
};

extern void  alEnable(ALenum capability);
extern void  alDisable(ALenum capability);
extern ALboolean  alIsEnabled(ALenum capability);
extern const ALchar*  alGetString(ALenum param);
extern void  alGetBooleanv(ALenum param, ALboolean *values);
extern void  alGetIntegerv(ALenum param, ALint *values);
extern void  alGetFloatv(ALenum param, ALfloat *values);
extern void  alGetDoublev(ALenum param, ALdouble *values);
extern ALboolean  alGetBoolean(ALenum param);
extern ALint  alGetInteger(ALenum param);
extern ALfloat  alGetFloat(ALenum param);
extern ALdouble  alGetDouble(ALenum param);
extern ALenum  alGetError(void);
extern ALboolean  alIsExtensionPresent(const ALchar *extname);
extern void*  alGetProcAddress(const ALchar *fname);
extern ALenum  alGetEnumValue(const ALchar *ename);
extern void  alListenerf(ALenum param, ALfloat value);
extern void  alListener3f(ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
extern void  alListenerfv(ALenum param, const ALfloat *values);
extern void  alListeneri(ALenum param, ALint value);
extern void  alListener3i(ALenum param, ALint value1, ALint value2, ALint value3);
extern void  alListeneriv(ALenum param, const ALint *values);
extern void  alGetListenerf(ALenum param, ALfloat *value);
extern void  alGetListener3f(ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
extern void  alGetListenerfv(ALenum param, ALfloat *values);
extern void  alGetListeneri(ALenum param, ALint *value);
extern void  alGetListener3i(ALenum param, ALint *value1, ALint *value2, ALint *value3);
extern void  alGetListeneriv(ALenum param, ALint *values);
extern void  alGenSources(ALsizei n, ALuint *sources);
extern void  alDeleteSources(ALsizei n, const ALuint *sources);
extern ALboolean  alIsSource(ALuint source);
extern void  alSourcef(ALuint source, ALenum param, ALfloat value);
extern void  alSource3f(ALuint source, ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
extern void  alSourcefv(ALuint source, ALenum param, const ALfloat *values);
extern void  alSourcei(ALuint source, ALenum param, ALint value);
extern void  alSource3i(ALuint source, ALenum param, ALint value1, ALint value2, ALint value3);
extern void  alSourceiv(ALuint source, ALenum param, const ALint *values);
extern void  alGetSourcef(ALuint source, ALenum param, ALfloat *value);
extern void  alGetSource3f(ALuint source, ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
extern void  alGetSourcefv(ALuint source, ALenum param, ALfloat *values);
extern void  alGetSourcei(ALuint source,  ALenum param, ALint *value);
extern void  alGetSource3i(ALuint source, ALenum param, ALint *value1, ALint *value2, ALint *value3);
extern void  alGetSourceiv(ALuint source,  ALenum param, ALint *values);
extern void  alSourcePlayv(ALsizei n, const ALuint *sources);
extern void  alSourceStopv(ALsizei n, const ALuint *sources);
extern void  alSourceRewindv(ALsizei n, const ALuint *sources);
extern void  alSourcePausev(ALsizei n, const ALuint *sources);
extern void  alSourcePlay(ALuint source);
extern void  alSourceStop(ALuint source);
extern void  alSourceRewind(ALuint source);
extern void  alSourcePause(ALuint source);
extern void  alSourceQueueBuffers(ALuint source, ALsizei nb, const ALuint *buffers);
extern void  alSourceUnqueueBuffers(ALuint source, ALsizei nb, ALuint *buffers);
extern void  alGenBuffers(ALsizei n, ALuint *buffers);
extern void  alDeleteBuffers(ALsizei n, const ALuint *buffers);
extern ALboolean  alIsBuffer(ALuint buffer);
extern void  alBufferData(ALuint buffer, ALenum format, const ALvoid *data, ALsizei size, ALsizei freq);
extern void  alBufferf(ALuint buffer, ALenum param, ALfloat value);
extern void  alBuffer3f(ALuint buffer, ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
extern void  alBufferfv(ALuint buffer, ALenum param, const ALfloat *values);
extern void  alBufferi(ALuint buffer, ALenum param, ALint value);
extern void  alBuffer3i(ALuint buffer, ALenum param, ALint value1, ALint value2, ALint value3);
extern void  alBufferiv(ALuint buffer, ALenum param, const ALint *values);
extern void  alGetBufferf(ALuint buffer, ALenum param, ALfloat *value);
extern void  alGetBuffer3f(ALuint buffer, ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
extern void  alGetBufferfv(ALuint buffer, ALenum param, ALfloat *values);
extern void  alGetBufferi(ALuint buffer, ALenum param, ALint *value);
extern void  alGetBuffer3i(ALuint buffer, ALenum param, ALint *value1, ALint *value2, ALint *value3);
extern void  alGetBufferiv(ALuint buffer, ALenum param, ALint *values);
typedef void          ( *LPALENABLE)(ALenum capability);
typedef void          ( *LPALDISABLE)(ALenum capability);
typedef ALboolean     ( *LPALISENABLED)(ALenum capability);
typedef const ALchar* ( *LPALGETSTRING)(ALenum param);
typedef void          ( *LPALGETBOOLEANV)(ALenum param, ALboolean *values);
typedef void          ( *LPALGETINTEGERV)(ALenum param, ALint *values);
typedef void          ( *LPALGETFLOATV)(ALenum param, ALfloat *values);
typedef void          ( *LPALGETDOUBLEV)(ALenum param, ALdouble *values);
typedef ALboolean     ( *LPALGETBOOLEAN)(ALenum param);
typedef ALint         ( *LPALGETINTEGER)(ALenum param);
typedef ALfloat       ( *LPALGETFLOAT)(ALenum param);
typedef ALdouble      ( *LPALGETDOUBLE)(ALenum param);
typedef ALenum        ( *LPALGETERROR)(void);
typedef ALboolean     ( *LPALISEXTENSIONPRESENT)(const ALchar *extname);
typedef void*         ( *LPALGETPROCADDRESS)(const ALchar *fname);
typedef ALenum        ( *LPALGETENUMVALUE)(const ALchar *ename);
typedef void          ( *LPALLISTENERF)(ALenum param, ALfloat value);
typedef void          ( *LPALLISTENER3F)(ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
typedef void          ( *LPALLISTENERFV)(ALenum param, const ALfloat *values);
typedef void          ( *LPALLISTENERI)(ALenum param, ALint value);
typedef void          ( *LPALLISTENER3I)(ALenum param, ALint value1, ALint value2, ALint value3);
typedef void          ( *LPALLISTENERIV)(ALenum param, const ALint *values);
typedef void          ( *LPALGETLISTENERF)(ALenum param, ALfloat *value);
typedef void          ( *LPALGETLISTENER3F)(ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
typedef void          ( *LPALGETLISTENERFV)(ALenum param, ALfloat *values);
typedef void          ( *LPALGETLISTENERI)(ALenum param, ALint *value);
typedef void          ( *LPALGETLISTENER3I)(ALenum param, ALint *value1, ALint *value2, ALint *value3);
typedef void          ( *LPALGETLISTENERIV)(ALenum param, ALint *values);
typedef void          ( *LPALGENSOURCES)(ALsizei n, ALuint *sources);
typedef void          ( *LPALDELETESOURCES)(ALsizei n, const ALuint *sources);
typedef ALboolean     ( *LPALISSOURCE)(ALuint source);
typedef void          ( *LPALSOURCEF)(ALuint source, ALenum param, ALfloat value);
typedef void          ( *LPALSOURCE3F)(ALuint source, ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
typedef void          ( *LPALSOURCEFV)(ALuint source, ALenum param, const ALfloat *values);
typedef void          ( *LPALSOURCEI)(ALuint source, ALenum param, ALint value);
typedef void          ( *LPALSOURCE3I)(ALuint source, ALenum param, ALint value1, ALint value2, ALint value3);
typedef void          ( *LPALSOURCEIV)(ALuint source, ALenum param, const ALint *values);
typedef void          ( *LPALGETSOURCEF)(ALuint source, ALenum param, ALfloat *value);
typedef void          ( *LPALGETSOURCE3F)(ALuint source, ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
typedef void          ( *LPALGETSOURCEFV)(ALuint source, ALenum param, ALfloat *values);
typedef void          ( *LPALGETSOURCEI)(ALuint source, ALenum param, ALint *value);
typedef void          ( *LPALGETSOURCE3I)(ALuint source, ALenum param, ALint *value1, ALint *value2, ALint *value3);
typedef void          ( *LPALGETSOURCEIV)(ALuint source, ALenum param, ALint *values);
typedef void          ( *LPALSOURCEPLAYV)(ALsizei n, const ALuint *sources);
typedef void          ( *LPALSOURCESTOPV)(ALsizei n, const ALuint *sources);
typedef void          ( *LPALSOURCEREWINDV)(ALsizei n, const ALuint *sources);
typedef void          ( *LPALSOURCEPAUSEV)(ALsizei n, const ALuint *sources);
typedef void          ( *LPALSOURCEPLAY)(ALuint source);
typedef void          ( *LPALSOURCESTOP)(ALuint source);
typedef void          ( *LPALSOURCEREWIND)(ALuint source);
typedef void          ( *LPALSOURCEPAUSE)(ALuint source);
typedef void          ( *LPALSOURCEQUEUEBUFFERS)(ALuint source, ALsizei nb, const ALuint *buffers);
typedef void          ( *LPALSOURCEUNQUEUEBUFFERS)(ALuint source, ALsizei nb, ALuint *buffers);
typedef void          ( *LPALGENBUFFERS)(ALsizei n, ALuint *buffers);
typedef void          ( *LPALDELETEBUFFERS)(ALsizei n, const ALuint *buffers);
typedef ALboolean     ( *LPALISBUFFER)(ALuint buffer);
typedef void          ( *LPALBUFFERDATA)(ALuint buffer, ALenum format, const ALvoid *data, ALsizei size, ALsizei freq);
typedef void          ( *LPALBUFFERF)(ALuint buffer, ALenum param, ALfloat value);
typedef void          ( *LPALBUFFER3F)(ALuint buffer, ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
typedef void          ( *LPALBUFFERFV)(ALuint buffer, ALenum param, const ALfloat *values);
typedef void          ( *LPALBUFFERI)(ALuint buffer, ALenum param, ALint value);
typedef void          ( *LPALBUFFER3I)(ALuint buffer, ALenum param, ALint value1, ALint value2, ALint value3);
typedef void          ( *LPALBUFFERIV)(ALuint buffer, ALenum param, const ALint *values);
typedef void          ( *LPALGETBUFFERF)(ALuint buffer, ALenum param, ALfloat *value);
typedef void          ( *LPALGETBUFFER3F)(ALuint buffer, ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
typedef void          ( *LPALGETBUFFERFV)(ALuint buffer, ALenum param, ALfloat *values);
typedef void          ( *LPALGETBUFFERI)(ALuint buffer, ALenum param, ALint *value);
typedef void          ( *LPALGETBUFFER3I)(ALuint buffer, ALenum param, ALint *value1, ALint *value2, ALint *value3);
typedef void          ( *LPALGETBUFFERIV)(ALuint buffer, ALenum param, ALint *values);
typedef void          ( *LPALDOPPLERFACTOR)(ALfloat value);
typedef void          ( *LPALDOPPLERVELOCITY)(ALfloat value);
typedef void          ( *LPALSPEEDOFSOUND)(ALfloat value);
typedef void          ( *LPALDISTANCEMODEL)(ALenum distanceModel);

// alc.h
enum {
    ALC_INVALID                  = 0,
    ALC_VERSION_0_1              = 1
};

typedef struct ALCdevice_struct ALCdevice;
typedef struct ALCcontext_struct ALCcontext;
typedef char ALCboolean;
typedef char ALCchar;
typedef signed char ALCbyte;
typedef unsigned char ALCubyte;
typedef short ALCshort;
typedef unsigned short ALCushort;
typedef int ALCint;
typedef unsigned int ALCuint;
typedef int ALCsizei;
typedef int ALCenum;
typedef float ALCfloat;
typedef double ALCdouble;
typedef void ALCvoid;

enum {
    ALC_FALSE                                = 0,
    ALC_TRUE                                 = 1,
    ALC_FREQUENCY                            = 0x1007,
    ALC_REFRESH                              = 0x1008,
    ALC_SYNC                                 = 0x1009,
    ALC_MONO_SOURCES                         = 0x1010,
    ALC_STEREO_SOURCES                       = 0x1011,
    ALC_NO_ERROR                             = 0,
    ALC_INVALID_DEVICE                       = 0xA001,
    ALC_INVALID_CONTEXT                      = 0xA002,
    ALC_INVALID_ENUM                         = 0xA003,
    ALC_INVALID_VALUE                        = 0xA004,
    ALC_OUT_OF_MEMORY                        = 0xA005,
    ALC_MAJOR_VERSION                        = 0x1000,
    ALC_MINOR_VERSION                        = 0x1001,
    ALC_ATTRIBUTES_SIZE                      = 0x1002,
    ALC_ALL_ATTRIBUTES                       = 0x1003,
    ALC_DEFAULT_DEVICE_SPECIFIER             = 0x1004,
    ALC_DEVICE_SPECIFIER                     = 0x1005,
    ALC_EXTENSIONS                           = 0x1006,
    ALC_EXT_CAPTURE                          = 1,
    ALC_CAPTURE_DEVICE_SPECIFIER             = 0x310,
    ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER     = 0x311,
    ALC_CAPTURE_SAMPLES                      = 0x312,
    ALC_ENUMERATE_ALL_EXT                    = 1,
    ALC_DEFAULT_ALL_DEVICES_SPECIFIER        = 0x1012,
    ALC_ALL_DEVICES_SPECIFIER                = 0x1013
};

ALCcontext* alcCreateContext(ALCdevice *device, const ALCint* attrlist);
ALCboolean  alcMakeContextCurrent(ALCcontext *context);
void        alcProcessContext(ALCcontext *context);
void        alcSuspendContext(ALCcontext *context);
void        alcDestroyContext(ALCcontext *context);
ALCcontext* alcGetCurrentContext(void);
ALCdevice*  alcGetContextsDevice(ALCcontext *context);
ALCdevice* alcOpenDevice(const ALCchar *devicename);
ALCboolean alcCloseDevice(ALCdevice *device);
ALCenum alcGetError(ALCdevice *device);
ALCboolean alcIsExtensionPresent(ALCdevice *device, const ALCchar *extname);
void*      alcGetProcAddress(ALCdevice *device, const ALCchar *funcname);
ALCenum    alcGetEnumValue(ALCdevice *device, const ALCchar *enumname);
const ALCchar* alcGetString(ALCdevice *device, ALCenum param);
void           alcGetIntegerv(ALCdevice *device, ALCenum param, ALCsizei size, ALCint *values);
ALCdevice* alcCaptureOpenDevice(const ALCchar *devicename, ALCuint frequency, ALCenum format, ALCsizei buffersize);
ALCboolean alcCaptureCloseDevice(ALCdevice *device);
void       alcCaptureStart(ALCdevice *device);
void       alcCaptureStop(ALCdevice *device);
void       alcCaptureSamples(ALCdevice *device, ALCvoid *buffer, ALCsizei samples);

typedef ALCcontext*    (*LPALCCREATECONTEXT)(ALCdevice *device, const ALCint *attrlist);
typedef ALCboolean     (*LPALCMAKECONTEXTCURRENT)(ALCcontext *context);
typedef void           (*LPALCPROCESSCONTEXT)(ALCcontext *context);
typedef void           (*LPALCSUSPENDCONTEXT)(ALCcontext *context);
typedef void           (*LPALCDESTROYCONTEXT)(ALCcontext *context);
typedef ALCcontext*    (*LPALCGETCURRENTCONTEXT)(void);
typedef ALCdevice*     (*LPALCGETCONTEXTSDEVICE)(ALCcontext *context);
typedef ALCdevice*     (*LPALCOPENDEVICE)(const ALCchar *devicename);
typedef ALCboolean     (*LPALCCLOSEDEVICE)(ALCdevice *device);
typedef ALCenum        (*LPALCGETERROR)(ALCdevice *device);
typedef ALCboolean     (*LPALCISEXTENSIONPRESENT)(ALCdevice *device, const ALCchar *extname);
typedef void*          (*LPALCGETPROCADDRESS)(ALCdevice *device, const ALCchar *funcname);
typedef ALCenum        (*LPALCGETENUMVALUE)(ALCdevice *device, const ALCchar *enumname);
typedef const ALCchar* (*LPALCGETSTRING)(ALCdevice *device, ALCenum param);
typedef void           (*LPALCGETINTEGERV)(ALCdevice *device, ALCenum param, ALCsizei size, ALCint *values);
typedef ALCdevice*     (*LPALCCAPTUREOPENDEVICE)(const ALCchar *devicename, ALCuint frequency, ALCenum format, ALCsizei buffersize);
typedef ALCboolean     (*LPALCCAPTURECLOSEDEVICE)(ALCdevice *device);
typedef void           (*LPALCCAPTURESTART)(ALCdevice *device);
typedef void           (*LPALCCAPTURESTOP)(ALCdevice *device);
typedef void           (*LPALCCAPTURESAMPLES)(ALCdevice *device, ALCvoid *buffer, ALCsizei samples);

]])

al = ffi.load(lwlgl.libs.al[2])

end

function load_cl()

ffi.cdef([[

enum {
  CL_SUCCESS                                   = 0,
  CL_DEVICE_NOT_FOUND                          = -1,
  CL_DEVICE_NOT_AVAILABLE                      = -2,
  CL_COMPILER_NOT_AVAILABLE                    = -3,
  CL_MEM_OBJECT_ALLOCATION_FAILURE             = -4,
  CL_OUT_OF_RESOURCES                          = -5,
  CL_OUT_OF_HOST_MEMORY                        = -6,
  CL_PROFILING_INFO_NOT_AVAILABLE              = -7,
  CL_MEM_COPY_OVERLAP                          = -8,
  CL_IMAGE_FORMAT_MISMATCH                     = -9,
  CL_IMAGE_FORMAT_NOT_SUPPORTED                = -10,
  CL_BUILD_PROGRAM_FAILURE                     = -11,
  CL_MAP_FAILURE                               = -12,
  CL_MISALIGNED_SUB_BUFFER_OFFSET              = -13,
  CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14,
  CL_INVALID_VALUE                             = -30,
  CL_INVALID_DEVICE_TYPE                       = -31,
  CL_INVALID_PLATFORM                          = -32,
  CL_INVALID_DEVICE                            = -33,
  CL_INVALID_CONTEXT                           = -34,
  CL_INVALID_QUEUE_PROPERTIES                  = -35,
  CL_INVALID_COMMAND_QUEUE                     = -36,
  CL_INVALID_HOST_PTR                          = -37,
  CL_INVALID_MEM_OBJECT                        = -38,
  CL_INVALID_IMAGE_FORMAT_DESCRIPTOR           = -39,
  CL_INVALID_IMAGE_SIZE                        = -40,
  CL_INVALID_SAMPLER                           = -41,
  CL_INVALID_BINARY                            = -42,
  CL_INVALID_BUILD_OPTIONS                     = -43,
  CL_INVALID_PROGRAM                           = -44,
  CL_INVALID_PROGRAM_EXECUTABLE                = -45,
  CL_INVALID_KERNEL_NAME                       = -46,
  CL_INVALID_KERNEL_DEFINITION                 = -47,
  CL_INVALID_KERNEL                            = -48,
  CL_INVALID_ARG_INDEX                         = -49,
  CL_INVALID_ARG_VALUE                         = -50,
  CL_INVALID_ARG_SIZE                          = -51,
  CL_INVALID_KERNEL_ARGS                       = -52,
  CL_INVALID_WORK_DIMENSION                    = -53,
  CL_INVALID_WORK_GROUP_SIZE                   = -54,
  CL_INVALID_WORK_ITEM_SIZE                    = -55,
  CL_INVALID_GLOBAL_OFFSET                     = -56,
  CL_INVALID_EVENT_WAIT_LIST                   = -57,
  CL_INVALID_EVENT                             = -58,
  CL_INVALID_OPERATION                         = -59,
  CL_INVALID_GL_OBJECT                         = -60,
  CL_INVALID_BUFFER_SIZE                       = -61,
  CL_INVALID_MIP_LEVEL                         = -62,
  CL_INVALID_GLOBAL_WORK_SIZE                  = -63,
  CL_INVALID_PROPERTY                          = -64,
  CL_VERSION_1_0                               = 1,
  CL_VERSION_1_1                               = 1,
  CL_FALSE                                     = 0,
  CL_TRUE                                      = 1,
  CL_PLATFORM_PROFILE                          = 0x0900,
  CL_PLATFORM_VERSION                          = 0x0901,
  CL_PLATFORM_NAME                             = 0x0902,
  CL_PLATFORM_VENDOR                           = 0x0903,
  CL_PLATFORM_EXTENSIONS                       = 0x0904,
  CL_DEVICE_TYPE_DEFAULT                       = 0x01,
  CL_DEVICE_TYPE_CPU                           = 0x02,
  CL_DEVICE_TYPE_GPU                           = 0x04,
  CL_DEVICE_TYPE_ACCELERATOR                   = 0x08,
  CL_DEVICE_TYPE_ALL                           = 0xFFFFFFFF,
  CL_DEVICE_TYPE                               = 0x1000,
  CL_DEVICE_VENDOR_ID                          = 0x1001,
  CL_DEVICE_MAX_COMPUTE_UNITS                  = 0x1002,
  CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS           = 0x1003,
  CL_DEVICE_MAX_WORK_GROUP_SIZE                = 0x1004,
  CL_DEVICE_MAX_WORK_ITEM_SIZES                = 0x1005,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR        = 0x1006,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT       = 0x1007,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT         = 0x1008,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG        = 0x1009,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT       = 0x100A,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE      = 0x100B,
  CL_DEVICE_MAX_CLOCK_FREQUENCY                = 0x100C,
  CL_DEVICE_ADDRESS_BITS                       = 0x100D,
  CL_DEVICE_MAX_READ_IMAGE_ARGS                = 0x100E,
  CL_DEVICE_MAX_WRITE_IMAGE_ARGS               = 0x100F,
  CL_DEVICE_MAX_MEM_ALLOC_SIZE                 = 0x1010,
  CL_DEVICE_IMAGE2D_MAX_WIDTH                  = 0x1011,
  CL_DEVICE_IMAGE2D_MAX_HEIGHT                 = 0x1012,
  CL_DEVICE_IMAGE3D_MAX_WIDTH                  = 0x1013,
  CL_DEVICE_IMAGE3D_MAX_HEIGHT                 = 0x1014,
  CL_DEVICE_IMAGE3D_MAX_DEPTH                  = 0x1015,
  CL_DEVICE_IMAGE_SUPPORT                      = 0x1016,
  CL_DEVICE_MAX_PARAMETER_SIZE                 = 0x1017,
  CL_DEVICE_MAX_SAMPLERS                       = 0x1018,
  CL_DEVICE_MEM_BASE_ADDR_ALIGN                = 0x1019,
  CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE           = 0x101A,
  CL_DEVICE_SINGLE_FP_CONFIG                   = 0x101B,
  CL_DEVICE_GLOBAL_MEM_CACHE_TYPE              = 0x101C,
  CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE          = 0x101D,
  CL_DEVICE_GLOBAL_MEM_CACHE_SIZE              = 0x101E,
  CL_DEVICE_GLOBAL_MEM_SIZE                    = 0x101F,
  CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE           = 0x1020,
  CL_DEVICE_MAX_CONSTANT_ARGS                  = 0x1021,
  CL_DEVICE_LOCAL_MEM_TYPE                     = 0x1022,
  CL_DEVICE_LOCAL_MEM_SIZE                     = 0x1023,
  CL_DEVICE_ERROR_CORRECTION_SUPPORT           = 0x1024,
  CL_DEVICE_PROFILING_TIMER_RESOLUTION         = 0x1025,
  CL_DEVICE_ENDIAN_LITTLE                      = 0x1026,
  CL_DEVICE_AVAILABLE                          = 0x1027,
  CL_DEVICE_COMPILER_AVAILABLE                 = 0x1028,
  CL_DEVICE_EXECUTION_CAPABILITIES             = 0x1029,
  CL_DEVICE_QUEUE_PROPERTIES                   = 0x102A,
  CL_DEVICE_NAME                               = 0x102B,
  CL_DEVICE_VENDOR                             = 0x102C,
  CL_DRIVER_VERSION                            = 0x102D,
  CL_DEVICE_DRIVER_VERSION                     = CL_DRIVER_VERSION,
  CL_DEVICE_PROFILE                            = 0x102E,
  CL_DEVICE_VERSION                            = 0x102F,
  CL_DEVICE_EXTENSIONS                         = 0x1030,
  CL_DEVICE_PLATFORM                           = 0x1031,
  CL_DEVICE_DOUBLE_FP_CONFIG                   = 0x1032,
  CL_DEVICE_HALF_FP_CONFIG                     = 0x1033,
  CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF        = 0x1034,
  CL_DEVICE_HOST_UNIFIED_MEMORY                = 0x1035,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR           = 0x1036,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT          = 0x1037,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_INT            = 0x1038,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG           = 0x1039,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT          = 0x103A,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE         = 0x103B,
  CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF           = 0x103C,
  CL_DEVICE_OPENCL_C_VERSION                   = 0x103D,
  CL_FP_DENORM                                 = 0x01,
  CL_FP_INF_NAN                                = 0x02,
  CL_FP_ROUND_TO_NEAREST                       = 0x04,
  CL_FP_ROUND_TO_ZERO                          = 0x08,
  CL_FP_ROUND_TO_INF                           = 0x10,
  CL_FP_FMA                                    = 0x20,
  CL_FP_SOFT_FLOAT                             = 0x40, 
  CL_NONE                                      = 0x0,
  CL_READ_ONLY_CACHE                           = 0x1,
  CL_READ_WRITE_CACHE                          = 0x2,
  CL_                                    = 0x1,
  CL_GLOBAL                                    = 0x2,
  CL_EXEC_KERNEL                               = 0x1,
  CL_EXEC_NATIVE_KERNEL                        = 0x2,
  CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE       = 0x1,
  CL_QUEUE_PROFILING_ENABLE                    = 0x2,
  CL_CONTEXT_REFERENCE_COUNT                   = 0x1080,
  CL_CONTEXT_DEVICES                           = 0x1081,
  CL_CONTEXT_PROPERTIES                        = 0x1082,
  CL_CONTEXT_NUM_DEVICES                       = 0x1083,
  CL_CONTEXT_PLATFORM                          = 0x1084,
  CL_QUEUE_CONTEXT                             = 0x1090,
  CL_QUEUE_DEVICE                              = 0x1091,
  CL_QUEUE_REFERENCE_COUNT                     = 0x1092,
  CL_QUEUE_PROPERTIES                          = 0x1093,
  CL_MEM_READ_WRITE                            = 0x01,
  CL_MEM_WRITE_ONLY                            = 0x02,
  CL_MEM_READ_ONLY                             = 0x04,
  CL_MEM_USE_HOST_PTR                          = 0x08,
  CL_MEM_ALLOC_HOST_PTR                        = 0x10,
  CL_MEM_COPY_HOST_PTR                         = 0x20,
  CL_R                                         = 0x10B0,
  CL_A                                         = 0x10B1,
  CL_RG                                        = 0x10B2,
  CL_RA                                        = 0x10B3,
  CL_RGB                                       = 0x10B4,
  CL_RGBA                                      = 0x10B5,
  CL_BGRA                                      = 0x10B6,
  CL_ARGB                                      = 0x10B7,
  CL_INTENSITY                                 = 0x10B8,
  CL_LUMINANCE                                 = 0x10B9,
  CL_Rx                                        = 0x10BA,
  CL_RGx                                       = 0x10BB,
  CL_RGBx                                      = 0x10BC,
  CL_SNORM_INT8                                = 0x10D0,
  CL_SNORM_INT16                               = 0x10D1,
  CL_UNORM_INT8                                = 0x10D2,
  CL_UNORM_INT16                               = 0x10D3,
  CL_UNORM_SHORT_565                           = 0x10D4,
  CL_UNORM_SHORT_555                           = 0x10D5,
  CL_UNORM_INT_101010                          = 0x10D6,
  CL_SIGNED_INT8                               = 0x10D7,
  CL_SIGNED_INT16                              = 0x10D8,
  CL_SIGNED_INT32                              = 0x10D9,
  CL_UNSIGNED_INT8                             = 0x10DA,
  CL_UNSIGNED_INT16                            = 0x10DB,
  CL_UNSIGNED_INT32                            = 0x10DC,
  CL_HALF_FLOAT                                = 0x10DD,
  CL_FLOAT                                     = 0x10DE,
  CL_MEM_OBJECT_BUFFER                         = 0x10F0,
  CL_MEM_OBJECT_IMAGE2D                        = 0x10F1,
  CL_MEM_OBJECT_IMAGE3D                        = 0x10F2,
  CL_MEM_TYPE                                  = 0x1100,
  CL_MEM_FLAGS                                 = 0x1101,
  CL_MEM_SIZE                                  = 0x1102,
  CL_MEM_HOST_PTR                              = 0x1103,
  CL_MEM_MAP_COUNT                             = 0x1104,
  CL_MEM_REFERENCE_COUNT                       = 0x1105,
  CL_MEM_CONTEXT                               = 0x1106,
  CL_MEM_ASSOCIATED_MEMOBJECT                  = 0x1107,
  CL_MEM_OFFSET                                = 0x1108,
  CL_IMAGE_FORMAT                              = 0x1110,
  CL_IMAGE_ELEMENT_SIZE                        = 0x1111,
  CL_IMAGE_ROW_PITCH                           = 0x1112,
  CL_IMAGE_SLICE_PITCH                         = 0x1113,
  CL_IMAGE_WIDTH                               = 0x1114,
  CL_IMAGE_HEIGHT                              = 0x1115,
  CL_IMAGE_DEPTH                               = 0x1116,
  CL_ADDRESS_NONE                              = 0x1130,
  CL_ADDRESS_CLAMP_TO_EDGE                     = 0x1131,
  CL_ADDRESS_CLAMP                             = 0x1132,
  CL_ADDRESS_REPEAT                            = 0x1133,
  CL_ADDRESS_MIRRORED_REPEAT                   = 0x1134,
  CL_FILTER_NEAREST                            = 0x1140,
  CL_FILTER_LINEAR                             = 0x1141,
  CL_SAMPLER_REFERENCE_COUNT                   = 0x1150,
  CL_SAMPLER_CONTEXT                           = 0x1151,
  CL_SAMPLER_NORMALIZED_COORDS                 = 0x1152,
  CL_SAMPLER_ADDRESSING_MODE                   = 0x1153,
  CL_SAMPLER_FILTER_MODE                       = 0x1154,
  CL_MAP_READ                                  = 0x01,
  CL_MAP_WRITE                                 = 0x02,
  CL_PROGRAM_REFERENCE_COUNT                   = 0x1160,
  CL_PROGRAM_CONTEXT                           = 0x1161,
  CL_PROGRAM_NUM_DEVICES                       = 0x1162,
  CL_PROGRAM_DEVICES                           = 0x1163,
  CL_PROGRAM_SOURCE                            = 0x1164,
  CL_PROGRAM_BINARY_SIZES                      = 0x1165,
  CL_PROGRAM_BINARIES                          = 0x1166,
  CL_PROGRAM_BUILD_STATUS                      = 0x1181,
  CL_PROGRAM_BUILD_OPTIONS                     = 0x1182,
  CL_PROGRAM_BUILD_LOG                         = 0x1183,
  CL_BUILD_SUCCESS                             = 0,
  CL_BUILD_NONE                                = -1,
  CL_BUILD_ERROR                               = -2,
  CL_BUILD_IN_PROGRESS                         = -3,
  CL_KERNEL_FUNCTION_NAME                      = 0x1190,
  CL_KERNEL_NUM_ARGS                           = 0x1191,
  CL_KERNEL_REFERENCE_COUNT                    = 0x1192,
  CL_KERNEL_CONTEXT                            = 0x1193,
  CL_KERNEL_PROGRAM                            = 0x1194,
  CL_KERNEL_WORK_GROUP_SIZE                    = 0x11B0,
  CL_KERNEL_COMPILE_WORK_GROUP_SIZE            = 0x11B1,
  CL_KERNEL_LOCAL_MEM_SIZE                     = 0x11B2,
  CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x11B3,
  CL_KERNEL_PRIVATE_MEM_SIZE                   = 0x11B4,
  CL_EVENT_COMMAND_QUEUE                       = 0x11D0,
  CL_EVENT_COMMAND_TYPE                        = 0x11D1,
  CL_EVENT_REFERENCE_COUNT                     = 0x11D2,
  CL_EVENT_COMMAND_EXECUTION_STATUS            = 0x11D3,
  CL_EVENT_CONTEXT                             = 0x11D4,
  CL_COMMAND_NDRANGE_KERNEL                    = 0x11F0,
  CL_COMMAND_TASK                              = 0x11F1,
  CL_COMMAND_NATIVE_KERNEL                     = 0x11F2,
  CL_COMMAND_READ_BUFFER                       = 0x11F3,
  CL_COMMAND_WRITE_BUFFER                      = 0x11F4,
  CL_COMMAND_COPY_BUFFER                       = 0x11F5,
  CL_COMMAND_READ_IMAGE                        = 0x11F6,
  CL_COMMAND_WRITE_IMAGE                       = 0x11F7,
  CL_COMMAND_COPY_IMAGE                        = 0x11F8,
  CL_COMMAND_COPY_IMAGE_TO_BUFFER              = 0x11F9,
  CL_COMMAND_COPY_BUFFER_TO_IMAGE              = 0x11FA,
  CL_COMMAND_MAP_BUFFER                        = 0x11FB,
  CL_COMMAND_MAP_IMAGE                         = 0x11FC,
  CL_COMMAND_UNMAP_MEM_OBJECT                  = 0x11FD,
  CL_COMMAND_MARKER                            = 0x11FE,
  CL_COMMAND_ACQUIRE_GL_OBJECTS                = 0x11FF,
  CL_COMMAND_RELEASE_GL_OBJECTS                = 0x1200,
  CL_COMMAND_READ_BUFFER_RECT                  = 0x1201,
  CL_COMMAND_WRITE_BUFFER_RECT                 = 0x1202,
  CL_COMMAND_COPY_BUFFER_RECT                  = 0x1203,
  CL_COMMAND_USER                              = 0x1204,
  CL_COMPLETE                                  = 0x0,
  CL_RUNNING                                   = 0x1,
  CL_SUBMITTED                                 = 0x2,
  CL_QUEUED                                    = 0x3,
  CL_BUFFER_CREATE_TYPE_REGION                 = 0x1220,
  CL_PROFILING_COMMAND_QUEUED                  = 0x1280,
  CL_PROFILING_COMMAND_SUBMIT                  = 0x1281,
  CL_PROFILING_COMMAND_START                   = 0x1282,
  CL_PROFILING_COMMAND_END                     = 0x1283
};

typedef signed char               int8_t;
typedef short                     int16_t;
typedef int                       int32_t;
typedef long long                 int64_t;
typedef unsigned char             uint8_t;
typedef unsigned short            uint16_t;
typedef unsigned int              uint32_t;
typedef unsigned long long        uint64_t;
typedef int8_t                    int_least8_t;
typedef int16_t                   int_least16_t;
typedef int32_t                   int_least32_t;
typedef int64_t                   int_least64_t;
typedef uint8_t                   uint_least8_t;
typedef uint16_t                  uint_least16_t;
typedef uint32_t                  uint_least32_t;
typedef uint64_t                  uint_least64_t;
typedef int8_t                    int_fast8_t;
typedef int16_t                   int_fast16_t;
typedef int32_t                   int_fast32_t;
typedef int64_t                   int_fast64_t;
typedef uint8_t                   uint_fast8_t;
typedef uint16_t                  uint_fast16_t;
typedef uint32_t                  uint_fast32_t;
typedef uint64_t                  uint_fast64_t;
typedef long                      intptr_t;
typedef unsigned long             uintptr_t;
typedef long int                  intmax_t;
typedef long unsigned int         uintmax_t;
typedef int8_t                    cl_char;
typedef uint8_t                   cl_uchar;
typedef long int                  ptrdiff_t;
typedef long unsigned int         size_t;
typedef int                       wchar_t;
typedef int16_t                   cl_short        __attribute__((aligned(2)));
typedef uint16_t                  cl_ushort       __attribute__((aligned(2)));
typedef int32_t                   cl_int          __attribute__((aligned(4)));
typedef uint32_t                  cl_uint         __attribute__((aligned(4)));
typedef int64_t                   cl_long         __attribute__((aligned(8)));
typedef uint64_t                  cl_ulong        __attribute__((aligned(8)));
typedef uint16_t                  cl_half         __attribute__((aligned(2)));
typedef float                     cl_float        __attribute__((aligned(4)));
typedef double                    cl_double       __attribute__((aligned(8)));
typedef int8_t                    cl_char2[2]     __attribute__((aligned(2)));
typedef int8_t                    cl_char4[4]     __attribute__((aligned(4)));
typedef int8_t                    cl_char8[8]     __attribute__((aligned(8)));
typedef int8_t                    cl_char16[16]   __attribute__((aligned(16)));
typedef uint8_t                   cl_uchar2[2]    __attribute__((aligned(2)));
typedef uint8_t                   cl_uchar4[4]    __attribute__((aligned(4)));
typedef uint8_t                   cl_uchar8[8]    __attribute__((aligned(8)));
typedef uint8_t                   cl_uchar16[16]  __attribute__((aligned(16)));
typedef int16_t                   cl_short2[2]    __attribute__((aligned(4)));
typedef int16_t                   cl_short4[4]    __attribute__((aligned(8)));
typedef int16_t                   cl_short8[8]    __attribute__((aligned(16)));
typedef int16_t                   cl_short16[16]  __attribute__((aligned(32)));
typedef uint16_t                  cl_ushort2[2]   __attribute__((aligned(4)));
typedef uint16_t                  cl_ushort4[4]   __attribute__((aligned(8)));
typedef uint16_t                  cl_ushort8[8]   __attribute__((aligned(16)));
typedef uint16_t                  cl_ushort16[16] __attribute__((aligned(32)));
typedef int32_t                   cl_int2[2]      __attribute__((aligned(8)));
typedef int32_t                   cl_int4[4]      __attribute__((aligned(16)));
typedef int32_t                   cl_int8[8]      __attribute__((aligned(32)));
typedef int32_t                   cl_int16[16]    __attribute__((aligned(64)));
typedef uint32_t                  cl_uint2[2]     __attribute__((aligned(8)));
typedef uint32_t                  cl_uint4[4]     __attribute__((aligned(16)));
typedef uint32_t                  cl_uint8[8]     __attribute__((aligned(32)));
typedef uint32_t                  cl_uint16[16]   __attribute__((aligned(64)));
typedef int64_t                   cl_long2[2]     __attribute__((aligned(16)));
typedef int64_t                   cl_long4[4]     __attribute__((aligned(32)));
typedef int64_t                   cl_long8[8]     __attribute__((aligned(64)));
typedef int64_t                   cl_long16[16]   __attribute__((aligned(128)));
typedef uint64_t                  cl_ulong2[2]    __attribute__((aligned(16)));
typedef uint64_t                  cl_ulong4[4]    __attribute__((aligned(32)));
typedef uint64_t                  cl_ulong8[8]    __attribute__((aligned(64)));
typedef uint64_t                  cl_ulong16[16]  __attribute__((aligned(128)));
typedef float                     cl_float2[2]    __attribute__((aligned(8)));
typedef float                     cl_float4[4]    __attribute__((aligned(16)));
typedef float                     cl_float8[8]    __attribute__((aligned(32)));
typedef float                     cl_float16[16]  __attribute__((aligned(64)));
typedef double                    cl_double2[2]   __attribute__((aligned(16)));
typedef double                    cl_double4[4]   __attribute__((aligned(32)));
typedef double                    cl_double8[8]   __attribute__((aligned(64)));
typedef double                    cl_double16[16] __attribute__((aligned(128)));
typedef struct _cl_platform_id*   cl_platform_id;
typedef struct _cl_device_id*     cl_device_id;
typedef struct _cl_context*       cl_context;
typedef struct _cl_command_queue* cl_command_queue;
typedef struct _cl_mem*           cl_mem;
typedef struct _cl_program*       cl_program;
typedef struct _cl_kernel*        cl_kernel;
typedef struct _cl_event*         cl_event;
typedef struct _cl_sampler*       cl_sampler;
typedef cl_uint                   cl_bool;
typedef cl_ulong                  cl_bitfield;
typedef cl_bitfield               cl_device_type;
typedef cl_uint                   cl_platform_info;
typedef cl_uint                   cl_device_info;
typedef cl_bitfield               cl_device_address_info;
typedef cl_bitfield               cl_device_fp_config;
typedef cl_uint                   cl_device_mem_cache_type;
typedef cl_uint                   cl_device_local_mem_type;
typedef cl_bitfield               cl_device_exec_capabilities;
typedef cl_bitfield               cl_command_queue_properties;
typedef intptr_t                  cl_context_properties;
typedef cl_uint                   cl_context_info;
typedef cl_uint                   cl_command_queue_info;
typedef cl_uint                   cl_channel_order;
typedef cl_uint                   cl_channel_type;
typedef cl_bitfield               cl_mem_flags;
typedef cl_uint                   cl_mem_object_type;
typedef cl_uint                   cl_mem_info;
typedef cl_uint                   cl_image_info;
typedef cl_uint                   cl_addressing_mode;
typedef cl_uint                   cl_filter_mode;
typedef cl_uint                   cl_sampler_info;
typedef cl_bitfield               cl_map_flags;
typedef cl_uint                   cl_program_info;
typedef cl_uint                   cl_program_build_info;
typedef cl_int                    cl_build_status;
typedef cl_uint                   cl_kernel_info;
typedef cl_uint                   cl_kernel_work_group_info;
typedef cl_uint                   cl_event_info;
typedef cl_uint                   cl_command_type;
typedef cl_uint                   cl_profiling_info;

typedef struct _cl_image_format {
  cl_channel_order image_channel_order;
  cl_channel_type  image_channel_data_type;
} cl_image_format;

cl_int           clGetPlatformIDs(              cl_uint, cl_platform_id *, cl_uint *);
cl_int           clGetPlatformInfo(             cl_platform_id, cl_platform_info, size_t, void *, size_t *);
cl_int           clGetDeviceIDs(                cl_platform_id, cl_device_type, cl_uint, cl_device_id *, cl_uint *);
cl_int           clGetDeviceInfo(               cl_device_id,   cl_device_info, size_t, void *, size_t *);
cl_context       clCreateContext(               const cl_context_properties *, cl_uint, const cl_device_id *, void (*pfn_notify)(const char *, const void *, size_t, void *), void *, cl_int *);
cl_context       clCreateContextFromType(       const cl_context_properties *, cl_device_type, void (*pfn_notify)(const char *, const void *, size_t, void *), void *, cl_int *);
cl_int           clRetainContext(               cl_context );
cl_int           clReleaseContext(              cl_context );
cl_int           clGetContextInfo(              cl_context, cl_context_info, size_t, void *, size_t *);
cl_command_queue clCreateCommandQueue(          cl_context, cl_device_id, cl_command_queue_properties, cl_int *);
cl_int           clRetainCommandQueue(          cl_command_queue );
cl_int           clReleaseCommandQueue(         cl_command_queue );
cl_int           clGetCommandQueueInfo(         cl_command_queue, cl_command_queue_info, size_t, void *, size_t * );
cl_int           clSetCommandQueueProperty(     cl_command_queue, cl_command_queue_properties, cl_bool, cl_command_queue_properties * ); // DEPRECATED in 1.1
cl_mem           clCreateBuffer(                cl_context, cl_mem_flags, size_t, void *, cl_int *);
cl_mem           clCreateImage2D(               cl_context, cl_mem_flags, const cl_image_format *, size_t, size_t, size_t, void *, cl_int * );
cl_mem           clCreateImage3D(               cl_context, cl_mem_flags, const cl_image_format *, size_t, size_t, size_t, size_t, size_t, void *, cl_int *);
cl_int           clRetainMemObject(             cl_mem );
cl_int           clReleaseMemObject(            cl_mem );
cl_int           clGetSupportedImageFormats(    cl_context, cl_mem_flags, cl_mem_object_type, cl_uint, cl_image_format *, cl_uint *);
cl_int           clGetMemObjectInfo(            cl_mem, cl_mem_info, size_t, void *, size_t * );
cl_int           clGetImageInfo(                cl_mem, cl_image_info, size_t, void *, size_t * );
cl_sampler       clCreateSampler(               cl_context, cl_bool, cl_addressing_mode, cl_filter_mode, cl_int * );
cl_int           clRetainSampler(               cl_sampler );
cl_int           clReleaseSampler(              cl_sampler );
cl_int           clGetSamplerInfo(              cl_sampler, cl_sampler_info, size_t, void *, size_t * );
cl_program       clCreateProgramWithSource(     cl_context, cl_uint, const char **, const size_t *, cl_int * );
cl_program       clCreateProgramWithBinary(     cl_context, cl_uint, const cl_device_id *, const size_t *, const unsigned char **, cl_int *, cl_int * );
cl_int           clRetainProgram(               cl_program );
cl_int           clReleaseProgram(              cl_program );
cl_int           clBuildProgram(                cl_program, cl_uint, const cl_device_id *, const char *, void (*pfn_notify)(cl_program, void *), void * );
cl_int           clUnloadCompiler(              void );
cl_int           clGetProgramInfo(              cl_program, cl_program_info, size_t, void *, size_t * );
cl_int           clGetProgramBuildInfo(         cl_program, cl_device_id, cl_program_build_info, size_t, void *, size_t *);
cl_kernel        clCreateKernel(                cl_program, const char *, cl_int *);
cl_int           clCreateKernelsInProgram(      cl_program, cl_uint, cl_kernel *, cl_uint * );
cl_int           clRetainKernel(                cl_kernel );
cl_int           clReleaseKernel(               cl_kernel );
cl_int           clSetKernelArg(                cl_kernel, cl_uint, size_t, const void *);
cl_int           clGetKernelInfo(               cl_kernel, cl_kernel_info, size_t, void *, size_t * );
cl_int           clGetKernelWorkGroupInfo(      cl_kernel, cl_device_id, cl_kernel_work_group_info, size_t, void *, size_t * );
cl_int           clWaitForEvents(               cl_uint, const cl_event * );
cl_int           clGetEventInfo(                cl_event, cl_event_info, size_t, void *, size_t * );
cl_int           clRetainEvent(                 cl_event );
cl_int           clReleaseEvent(                cl_event );
cl_int           clGetEventProfilingInfo(       cl_event, cl_profiling_info, size_t, void *, size_t * );
cl_int           clFlush(                       cl_command_queue );
cl_int           clFinish(                      cl_command_queue );
cl_int           clEnqueueReadBuffer(           cl_command_queue, cl_mem, cl_bool, size_t, size_t, void *, cl_uint, const cl_event *, cl_event * );
cl_int           clEnqueueWriteBuffer(          cl_command_queue, cl_mem, cl_bool, size_t, size_t, const void *, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueCopyBuffer(           cl_command_queue, cl_mem, cl_mem, size_t, size_t, size_t, cl_uint, const cl_event *, cl_event * );
cl_int           clEnqueueReadImage(            cl_command_queue, cl_mem, cl_bool, const size_t *, const size_t *, size_t, size_t, void *, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueWriteImage(           cl_command_queue, cl_mem, cl_bool, const size_t *, const size_t *, size_t, size_t, const void *, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueCopyImage(            cl_command_queue, cl_mem, cl_mem, const size_t *, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event * );
cl_int           clEnqueueCopyImageToBuffer(    cl_command_queue, cl_mem, cl_mem, const size_t *, const size_t *, size_t, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueCopyBufferToImage(    cl_command_queue, cl_mem, cl_mem, size_t, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event *);
void*            clEnqueueMapBuffer(            cl_command_queue, cl_mem, cl_bool, cl_map_flags, size_t, size_t, cl_uint, const cl_event *, cl_event *, cl_int *);
void*            clEnqueueMapImage(             cl_command_queue, cl_mem, cl_bool, cl_map_flags, const size_t *, const size_t *, size_t *, size_t *, cl_uint, const cl_event *, cl_event *, cl_int *);
cl_int           clEnqueueUnmapMemObject(       cl_command_queue, cl_mem, void *, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueNDRangeKernel(        cl_command_queue, cl_kernel, cl_uint, const size_t *, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueTask(                 cl_command_queue, cl_kernel, cl_uint, const cl_event *, cl_event *);
cl_int           clEnqueueNativeKernel(         cl_command_queue, void (*user_func)(void *), void*, size_t, cl_uint, const cl_mem*, const void**, cl_uint, const cl_event*, cl_event*);
cl_int           clEnqueueMarker(               cl_command_queue, cl_event *);
cl_int           clEnqueueWaitForEvents(        cl_command_queue, cl_uint, const cl_event*);
cl_int           clEnqueueBarrier(              cl_command_queue);
void*            clGetExtensionFunctionAddress( const char* );
]])

ffi.cdef([[
enum {
  cl_APPLE_SetMemObjectDestructor             = 1,
  cl_APPLE_ContextLoggingFunctions            = 1,
  cl_khr_icd                                  = 1,
  cl_amd_device_memory_flags                  = 1,
  cl_amd_atomic_counters                      = 1,
  cl_ext_device_fission                       = 1,
};
enum {
  CL_PLATFORM_ICD_SUFFIX_KHR                  = 0x0920,
  CL_PLATFORM_NOT_FOUND_KHR                   = -1001,
  CL_DEVICE_COMPUTE_CAPABILITY_MAJOR_NV       = 0x4000,
  CL_DEVICE_COMPUTE_CAPABILITY_MINOR_NV       = 0x4001,
  CL_DEVICE_REGISTERS_PER_BLOCK_NV            = 0x4002,
  CL_DEVICE_WARP_SIZE_NV                      = 0x4003,
  CL_DEVICE_GPU_OVERLAP_NV                    = 0x4004,
  CL_DEVICE_KERNEL_EXEC_TIMEOUT_NV            = 0x4005,
  CL_DEVICE_INTEGRATED_MEMORY_NV              = 0x4006,
  CL_MEM_USE_PERSISTENT_MEM_AMD               = 1 << 6,
  CL_DEVICE_PROFILING_TIMER_OFFSET_AMD        = 0x4036,
  CL_CONTEXT_OFFLINE_DEVICES_AMD              = 0x403F,
  CL_INVALID_COUNTER_AMD                      = -10000,
  CL_DEVICE_MAX_ATOMIC_COUNTERS_AMD           = 0x10000,
  CL_COUNTER_INC_ONLY_AMD                     = 1 << 0,
  CL_COUNTER_DEC_ONLY_AMD                     = 1 << 1,
  CL_COUNTER_FLAGS_AMD                        = 0x10001,
  CL_COUNTER_REFERENCE_COUNT_AMD              = 0x10002,
  CL_COUNTER_CONTEXT_AMD                      = 0x10003,
  CL_COMMAND_READ_COUNTER_AMD                 = 0x10004,
  CL_COMMAND_WRITE_COUNTER_AMD                = 0x10005,
  CL_DEVICE_PARTITION_EQUALLY_EXT             = 0x4050,
  CL_DEVICE_PARTITION_BY_COUNTS_EXT           = 0x4051,
  CL_DEVICE_PARTITION_BY_NAMES_EXT            = 0x4052,
  CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN_EXT  = 0x4053,
  CL_DEVICE_PARENT_DEVICE_EXT                 = 0x4054,
  CL_DEVICE_PARTITION_TYPES_EXT               = 0x4055,
  CL_DEVICE_AFFINITY_DOMAINS_EXT              = 0x4056,
  CL_DEVICE_REFERENCE_COUNT_EXT               = 0x4057,
  CL_DEVICE_PARTITION_STYLE_EXT               = 0x4058,
  CL_DEVICE_PARTITION_FAILED_EXT              = -1057,
  CL_INVALID_PARTITION_COUNT_EXT              = -1058,
  CL_INVALID_PARTITION_NAME_EXT               = -1059,
  CL_AFFINITY_DOMAIN_L1_CACHE_EXT             = 0x1,
  CL_AFFINITY_DOMAIN_L2_CACHE_EXT             = 0x2,
  CL_AFFINITY_DOMAIN_L3_CACHE_EXT             = 0x3,
  CL_AFFINITY_DOMAIN_L4_CACHE_EXT             = 0x4,
  CL_AFFINITY_DOMAIN_NUMA_EXT                 = 0x10,
  CL_AFFINITY_DOMAIN_NEXT_FISSIONABLE_EXT     = 0x100,
  CL_PROPERTIES_LIST_END_EXT                  = 0,
  CL_PARTITION_BY_COUNTS_LIST_END_EXT         = 0,
  CL_PARTITION_BY_NAMES_LIST_END_EXT          = -1,
};

typedef struct _cl_counter_amd* cl_counter_amd;
typedef cl_bitfield             cl_counter_flags_amd;
typedef cl_uint                 cl_counter_info_amd;
typedef cl_ulong                cl_device_partition_property_ext;

typedef cl_int         (* clIcdGetPlatformIDsKHR_fn)(   cl_uint, cl_platform_id *, cl_uint *);
typedef cl_counter_amd (* clCreateCounterAMD_fn)(       cl_context,     cl_counter_flags_amd, cl_uint, cl_int * );
typedef cl_int         (* clGetCounterInfoAMD_fn)(      cl_counter_amd, cl_counter_info_amd, size_t, void *, size_t * );
typedef cl_int         (* clRetainCounterAMD_fn)(       cl_counter_amd  );
typedef cl_int         (* clReleaseCounterAMD_fn)(      cl_counter_amd  );
typedef cl_int         (* clEnqueueReadCounterAMD_fn)(  cl_command_queue, cl_counter_amd, cl_bool, cl_uint *, cl_uint, const cl_event *, cl_event * );
typedef cl_int         (* clEnqueueWriteCounterAMD_fn)( cl_command_queue, cl_counter_amd, cl_bool, cl_uint, cl_uint, const cl_event *, cl_event * );
typedef cl_int         (* clReleaseDeviceEXT_fn)(       cl_device_id );
typedef cl_int         (* clRetainDeviceEXT_fn)(        cl_device_id );
typedef cl_int         (* clCreateSubDevicesEXT_fn)(    cl_device_id, const cl_device_partition_property_ext*, cl_uint, cl_device_id*, cl_uint *);

cl_int clSetMemObjectDestructorAPPLE( cl_mem, void (* )( cl_mem, void* ), void* );
void   clLogMessagesToSystemLogAPPLE( const char *, const void *, size_t, void* );
void   clLogMessagesToStdoutAPPLE(    const char *, const void *, size_t, void* );
void   clLogMessagesToStderrAPPLE(    const char *, const void *, size_t, void* );
cl_int clIcdGetPlatformIDsKHR(        cl_uint, cl_platform_id *, cl_uint * );
cl_int clReleaseDeviceEXT(            cl_device_id );
cl_int clRetainDeviceEXT(             cl_device_id );
cl_int clCreateSubDevicesEXT(         cl_device_id, const cl_device_partition_property_ext*, cl_uint, cl_device_id *, cl_uint *);

]])

ffi.cdef([[

typedef unsigned int     cl_GLuint;
typedef int              cl_GLint;
typedef unsigned int     cl_GLenum;
typedef cl_uint          cl_gl_object_type;
typedef cl_uint          cl_gl_texture_info;
typedef cl_uint          cl_gl_platform_info;
typedef cl_uint          cl_gl_context_info;
typedef struct __GLsync* cl_GLsync;
typedef cl_int        (* clGetGLContextInfoKHR_fn)( const cl_context_properties *, cl_gl_context_info, size_t, void *, size_t * );
    
enum {
  cl_khr_gl_sharing                      = 1,
  CL_GL_OBJECT_BUFFER                    = 0x2000,
  CL_GL_OBJECT_TEXTURE2D                 = 0x2001,
  CL_GL_OBJECT_TEXTURE3D                 = 0x2002,
  CL_GL_OBJECT_RENDERBUFFER              = 0x2003,
  CL_GL_TEXTURE_TARGET                   = 0x2004,
  CL_GL_MIPMAP_LEVEL                     = 0x2005,  
  CL_INVALID_GL_SHAREGROUP_REFERENCE_KHR = -1000,
  CL_CURRENT_DEVICE_FOR_GL_CONTEXT_KHR   = 0x2006,
  CL_DEVICES_FOR_GL_CONTEXT_KHR          = 0x2007,
  CL_GL_CONTEXT_KHR                      = 0x2008,
  CL_EGL_DISPLAY_KHR                     = 0x2009,
  CL_GLX_DISPLAY_KHR                     = 0x200A,
  CL_WGL_HDC_KHR                         = 0x200B,
  CL_CGL_SHAREGROUP_KHR                  = 0x200C,
  CL_COMMAND_GL_FENCE_SYNC_OBJECT_KHR    = 0x200D,
};

cl_mem   clCreateFromGLBuffer(       cl_context, cl_mem_flags, cl_GLuint, int *);
cl_mem   clCreateFromGLTexture2D(    cl_context, cl_mem_flags, cl_GLenum, cl_GLint, cl_GLuint, cl_int *);
cl_mem   clCreateFromGLTexture3D(    cl_context, cl_mem_flags, cl_GLenum, cl_GLint, cl_GLuint, cl_int *);
cl_mem   clCreateFromGLRenderbuffer( cl_context, cl_mem_flags, cl_GLuint, cl_int *);
cl_int   clGetGLObjectInfo(          cl_mem, cl_gl_object_type*, cl_GLuint *);
cl_int   clGetGLTextureInfo(         cl_mem, cl_gl_texture_info, size_t, void *, size_t *);
cl_int   clEnqueueAcquireGLObjects(  cl_command_queue, cl_uint, const cl_mem *, cl_uint, const cl_event *, cl_event *);
cl_int   clEnqueueReleaseGLObjects(  cl_command_queue, cl_uint, const cl_mem *, cl_uint, const cl_event *, cl_event *);
cl_int   clGetGLContextInfoKHR(      const cl_context_properties*, cl_gl_context_info, size_t, void *, size_t *);
cl_event clCreateEventFromGLsyncKHR( cl_context, cl_GLsync, cl_int * );

]])

cl = ffi.load(lwlgl.libs.cl[2])

end

function load_physicsfs()

ffi.cdef([[

typedef unsigned char PHYSFS_uint8;
typedef signed char PHYSFS_sint8;
typedef unsigned short PHYSFS_uint16;
typedef signed short PHYSFS_sint16;
typedef unsigned int PHYSFS_uint32;
typedef signed int PHYSFS_sint32;
typedef unsigned long long PHYSFS_uint64;
typedef signed long long PHYSFS_sint64;
typedef int PHYSFS_dummy_uint8[(sizeof(PHYSFS_uint8) == 1) * 2 - 1];
typedef int PHYSFS_dummy_sint8[(sizeof(PHYSFS_sint8) == 1) * 2 - 1];
typedef int PHYSFS_dummy_uint16[(sizeof(PHYSFS_uint16) == 2) * 2 - 1];
typedef int PHYSFS_dummy_sint16[(sizeof(PHYSFS_sint16) == 2) * 2 - 1];
typedef int PHYSFS_dummy_uint32[(sizeof(PHYSFS_uint32) == 4) * 2 - 1];
typedef int PHYSFS_dummy_sint32[(sizeof(PHYSFS_sint32) == 4) * 2 - 1];

typedef int PHYSFS_dummy_uint64[(sizeof(PHYSFS_uint64) == 8) * 2 - 1];
typedef int PHYSFS_dummy_sint64[(sizeof(PHYSFS_sint64) == 8) * 2 - 1];
typedef struct PHYSFS_File
{
    void *opaque;
} PHYSFS_File;
typedef struct PHYSFS_ArchiveInfo
{
    const char *extension;
    const char *description;
    const char *author;
    const char *url;
} PHYSFS_ArchiveInfo;
typedef struct PHYSFS_Version
{
    PHYSFS_uint8 major;
    PHYSFS_uint8 minor;
    PHYSFS_uint8 patch;
} PHYSFS_Version;
void PHYSFS_getLinkedVersion(PHYSFS_Version *ver);
int PHYSFS_init(const char *argv0);
int PHYSFS_deinit(void);
const PHYSFS_ArchiveInfo **PHYSFS_supportedArchiveTypes(void);
void PHYSFS_freeList(void *listVar);
const char *PHYSFS_getLastError(void);
const char *PHYSFS_getDirSeparator(void);
void PHYSFS_permitSymbolicLinks(int allow);
char **PHYSFS_getCdRomDirs(void);
const char *PHYSFS_getBaseDir(void);
const char *PHYSFS_getUserDir(void);
const char *PHYSFS_getWriteDir(void);
int PHYSFS_setWriteDir(const char *newDir);
int PHYSFS_addToSearchPath(const char *newDir, int appendToPath);
int PHYSFS_removeFromSearchPath(const char *oldDir);
char **PHYSFS_getSearchPath(void);
int PHYSFS_setSaneConfig(const char *organization,
                                    const char *appName,
                                    const char *archiveExt,
                                    int includeCdRoms,
                                    int archivesFirst);
int PHYSFS_mkdir(const char *dirName);
int PHYSFS_delete(const char *filename);
const char *PHYSFS_getRealDir(const char *filename);
char **PHYSFS_enumerateFiles(const char *dir);
int PHYSFS_exists(const char *fname);
int PHYSFS_isDirectory(const char *fname);
int PHYSFS_isSymbolicLink(const char *fname);
PHYSFS_sint64 PHYSFS_getLastModTime(const char *filename);
PHYSFS_File *PHYSFS_openWrite(const char *filename);
PHYSFS_File *PHYSFS_openAppend(const char *filename);
PHYSFS_File *PHYSFS_openRead(const char *filename);
int PHYSFS_close(PHYSFS_File *handle);
PHYSFS_sint64 PHYSFS_read(PHYSFS_File *handle,
                                     void *buffer,
                                     PHYSFS_uint32 objSize,
                                     PHYSFS_uint32 objCount);
PHYSFS_sint64 PHYSFS_write(PHYSFS_File *handle,
                                      const void *buffer,
                                      PHYSFS_uint32 objSize,
                                      PHYSFS_uint32 objCount);
int PHYSFS_eof(PHYSFS_File *handle);
PHYSFS_sint64 PHYSFS_tell(PHYSFS_File *handle);
int PHYSFS_seek(PHYSFS_File *handle, PHYSFS_uint64 pos);
PHYSFS_sint64 PHYSFS_fileLength(PHYSFS_File *handle);
int PHYSFS_setBuffer(PHYSFS_File *handle, PHYSFS_uint64 bufsize);
int PHYSFS_flush(PHYSFS_File *handle);
PHYSFS_sint16 PHYSFS_swapSLE16(PHYSFS_sint16 val);
PHYSFS_uint16 PHYSFS_swapULE16(PHYSFS_uint16 val);
PHYSFS_sint32 PHYSFS_swapSLE32(PHYSFS_sint32 val);
PHYSFS_uint32 PHYSFS_swapULE32(PHYSFS_uint32 val);
PHYSFS_sint64 PHYSFS_swapSLE64(PHYSFS_sint64 val);
PHYSFS_uint64 PHYSFS_swapULE64(PHYSFS_uint64 val);
PHYSFS_sint16 PHYSFS_swapSBE16(PHYSFS_sint16 val);
PHYSFS_uint16 PHYSFS_swapUBE16(PHYSFS_uint16 val);
PHYSFS_sint32 PHYSFS_swapSBE32(PHYSFS_sint32 val);
PHYSFS_uint32 PHYSFS_swapUBE32(PHYSFS_uint32 val);
PHYSFS_sint64 PHYSFS_swapSBE64(PHYSFS_sint64 val);
PHYSFS_uint64 PHYSFS_swapUBE64(PHYSFS_uint64 val);
int PHYSFS_readSLE16(PHYSFS_File *file, PHYSFS_sint16 *val);
int PHYSFS_readULE16(PHYSFS_File *file, PHYSFS_uint16 *val);
int PHYSFS_readSBE16(PHYSFS_File *file, PHYSFS_sint16 *val);
int PHYSFS_readUBE16(PHYSFS_File *file, PHYSFS_uint16 *val);
int PHYSFS_readSLE32(PHYSFS_File *file, PHYSFS_sint32 *val);
int PHYSFS_readULE32(PHYSFS_File *file, PHYSFS_uint32 *val);
int PHYSFS_readSBE32(PHYSFS_File *file, PHYSFS_sint32 *val);
int PHYSFS_readUBE32(PHYSFS_File *file, PHYSFS_uint32 *val);
int PHYSFS_readSLE64(PHYSFS_File *file, PHYSFS_sint64 *val);
int PHYSFS_readULE64(PHYSFS_File *file, PHYSFS_uint64 *val);
int PHYSFS_readSBE64(PHYSFS_File *file, PHYSFS_sint64 *val);
int PHYSFS_readUBE64(PHYSFS_File *file, PHYSFS_uint64 *val);
int PHYSFS_writeSLE16(PHYSFS_File *file, PHYSFS_sint16 val);
int PHYSFS_writeULE16(PHYSFS_File *file, PHYSFS_uint16 val);
int PHYSFS_writeSBE16(PHYSFS_File *file, PHYSFS_sint16 val);
int PHYSFS_writeUBE16(PHYSFS_File *file, PHYSFS_uint16 val);
int PHYSFS_writeSLE32(PHYSFS_File *file, PHYSFS_sint32 val);
int PHYSFS_writeULE32(PHYSFS_File *file, PHYSFS_uint32 val);
int PHYSFS_writeSBE32(PHYSFS_File *file, PHYSFS_sint32 val);
int PHYSFS_writeUBE32(PHYSFS_File *file, PHYSFS_uint32 val);
int PHYSFS_writeSLE64(PHYSFS_File *file, PHYSFS_sint64 val);
int PHYSFS_writeULE64(PHYSFS_File *file, PHYSFS_uint64 val);
int PHYSFS_writeSBE64(PHYSFS_File *file, PHYSFS_sint64 val);
int PHYSFS_writeUBE64(PHYSFS_File *file, PHYSFS_uint64 val);
int PHYSFS_isInit(void);
int PHYSFS_symbolicLinksPermitted(void);
typedef struct PHYSFS_Allocator
{
    int (*Init)(void);
    void (*Deinit)(void);
    void *(*Malloc)(PHYSFS_uint64);
    void *(*Realloc)(void *, PHYSFS_uint64);
    void (*Free)(void *);
} PHYSFS_Allocator;
int PHYSFS_setAllocator(const PHYSFS_Allocator *allocator);
int PHYSFS_mount(const char *newDir, const char *mountPoint, int appendToPath);
const char *PHYSFS_getMountPoint(const char *dir);
typedef void (*PHYSFS_StringCallback)(void *data, const char *str);
typedef void (*PHYSFS_EnumFilesCallback)(void *data, const char *origdir,
                                         const char *fname);
void PHYSFS_getCdRomDirsCallback(PHYSFS_StringCallback c, void *d);
void PHYSFS_getSearchPathCallback(PHYSFS_StringCallback c, void *d);
void PHYSFS_enumerateFilesCallback(const char *dir,
                                              PHYSFS_EnumFilesCallback c,
                                              void *d);
void PHYSFS_utf8FromUcs4(const PHYSFS_uint32 *src, char *dst,
                                    PHYSFS_uint64 len);
void PHYSFS_utf8ToUcs4(const char *src, PHYSFS_uint32 *dst,
                                  PHYSFS_uint64 len);
void PHYSFS_utf8FromUcs2(const PHYSFS_uint16 *src, char *dst,
                                    PHYSFS_uint64 len);
void PHYSFS_utf8ToUcs2(const char *src, PHYSFS_uint16 *dst,
                                  PHYSFS_uint64 len);
void PHYSFS_utf8FromLatin1(const char *src, char *dst,
                                  PHYSFS_uint64 len);
								  
]])

physfs = ffi.load(lwlgl.libs.physicsfs[2])

end

function load_chipmunk()

ffi.cdef([[









          void cpMessage(const char *condition, const char *file, int line, int isError, int isHardError, const char *message, ...);






 typedef double cpFloat;
static inline cpFloat cpfmax(cpFloat a, cpFloat b)
{
 return (a > b) ? a : b;
}


static inline cpFloat cpfmin(cpFloat a, cpFloat b)
{
 return (a < b) ? a : b;
}


static inline cpFloat cpfabs(cpFloat f)
{
 return (f < 0) ? -f : f;
}


static inline cpFloat cpfclamp(cpFloat f, cpFloat min, cpFloat max)
{
 return cpfmin(cpfmax(f, min), max);
}


static inline cpFloat cpfclamp01(cpFloat f)
{
 return cpfmax(0.0f, cpfmin(f, 1.0f));
}




static inline cpFloat cpflerp(cpFloat f1, cpFloat f2, cpFloat t)
{
 return f1*(1.0f - t) + f2*t;
}


static inline cpFloat cpflerpconst(cpFloat f1, cpFloat f2, cpFloat d)
{
 return f1 + cpfclamp(f2 - f1, -d, d);
}





 typedef uintptr_t cpHashValue;




typedef uint32_t cpCollisionID;






 typedef unsigned char cpBool;
 typedef void * cpDataPointer;






 typedef uintptr_t cpCollisionType;






 typedef uintptr_t cpGroup;






 typedef unsigned int cpBitmask;






 typedef unsigned int cpTimestamp;
 typedef struct cpVect{cpFloat x,y;} cpVect;






 typedef struct cpTransform {
  cpFloat a, b, c, d, tx, ty;
 } cpTransform;



typedef struct cpMat2x2 {

 cpFloat a, b, c, d;
} cpMat2x2;
typedef struct cpArray cpArray;
typedef struct cpHashSet cpHashSet;

typedef struct cpBody cpBody;

typedef struct cpShape cpShape;
typedef struct cpCircleShape cpCircleShape;
typedef struct cpSegmentShape cpSegmentShape;
typedef struct cpPolyShape cpPolyShape;

typedef struct cpConstraint cpConstraint;
typedef struct cpPinJoint cpPinJoint;
typedef struct cpSlideJoint cpSlideJoint;
typedef struct cpPivotJoint cpPivotJoint;
typedef struct cpGrooveJoint cpGrooveJoint;
typedef struct cpDampedSpring cpDampedSpring;
typedef struct cpDampedRotarySpring cpDampedRotarySpring;
typedef struct cpRotaryLimitJoint cpRotaryLimitJoint;
typedef struct cpRatchetJoint cpRatchetJoint;
typedef struct cpGearJoint cpGearJoint;
typedef struct cpSimpleMotorJoint cpSimpleMotorJoint;

typedef struct cpCollisionHandler cpCollisionHandler;
typedef struct cpContactPointSet cpContactPointSet;
typedef struct cpArbiter cpArbiter;

typedef struct cpSpace cpSpace;


// static const cpVect cpvzero = {0.0f,0.0f};


static inline cpVect cpv(const cpFloat x, const cpFloat y)
{
 cpVect v = {x, y};
 return v;
}


static inline cpBool cpveql(const cpVect v1, const cpVect v2)
{
 return (v1.x == v2.x && v1.y == v2.y);
}


static inline cpVect cpvadd(const cpVect v1, const cpVect v2)
{
 return cpv(v1.x + v2.x, v1.y + v2.y);
}


static inline cpVect cpvsub(const cpVect v1, const cpVect v2)
{
 return cpv(v1.x - v2.x, v1.y - v2.y);
}


static inline cpVect cpvneg(const cpVect v)
{
 return cpv(-v.x, -v.y);
}


static inline cpVect cpvmult(const cpVect v, const cpFloat s)
{
 return cpv(v.x*s, v.y*s);
}


static inline cpFloat cpvdot(const cpVect v1, const cpVect v2)
{
 return v1.x*v2.x + v1.y*v2.y;
}




static inline cpFloat cpvcross(const cpVect v1, const cpVect v2)
{
 return v1.x*v2.y - v1.y*v2.x;
}


static inline cpVect cpvperp(const cpVect v)
{
 return cpv(-v.y, v.x);
}


static inline cpVect cpvrperp(const cpVect v)
{
 return cpv(v.y, -v.x);
}


static inline cpVect cpvproject(const cpVect v1, const cpVect v2)
{
 return cpvmult(v2, cpvdot(v1, v2)/cpvdot(v2, v2));
}


static inline cpVect cpvforangle(const cpFloat a)
{
 return cpv(cos(a), sin(a));
}


static inline cpFloat cpvtoangle(const cpVect v)
{
 return atan2(v.y, v.x);
}


static inline cpVect cpvrotate(const cpVect v1, const cpVect v2)
{
 return cpv(v1.x*v2.x - v1.y*v2.y, v1.x*v2.y + v1.y*v2.x);
}


static inline cpVect cpvunrotate(const cpVect v1, const cpVect v2)
{
 return cpv(v1.x*v2.x + v1.y*v2.y, v1.y*v2.x - v1.x*v2.y);
}


static inline cpFloat cpvlengthsq(const cpVect v)
{
 return cpvdot(v, v);
}


static inline cpFloat cpvlength(const cpVect v)
{
 return sqrt(cpvdot(v, v));
}


static inline cpVect cpvlerp(const cpVect v1, const cpVect v2, const cpFloat t)
{
 return cpvadd(cpvmult(v1, 1.0f - t), cpvmult(v2, t));
}


static inline cpVect cpvnormalize(const cpVect v)
{

 return cpvmult(v, 1.0f/(cpvlength(v) + DBL_MIN));
}


static inline cpVect
cpvslerp(const cpVect v1, const cpVect v2, const cpFloat t)
{
 cpFloat dot = cpvdot(cpvnormalize(v1), cpvnormalize(v2));
 cpFloat omega = acos(cpfclamp(dot, -1.0f, 1.0f));

 if(omega < 1e-3){

  return cpvlerp(v1, v2, t);
 } else {
  cpFloat denom = 1.0f/sin(omega);
  return cpvadd(cpvmult(v1, sin((1.0f - t)*omega)*denom), cpvmult(v2, sin(t*omega)*denom));
 }
}


static inline cpVect
cpvslerpconst(const cpVect v1, const cpVect v2, const cpFloat a)
{
 cpFloat dot = cpvdot(cpvnormalize(v1), cpvnormalize(v2));
 cpFloat omega = acos(cpfclamp(dot, -1.0f, 1.0f));

 return cpvslerp(v1, v2, cpfmin(a, omega)/omega);
}


static inline cpVect cpvclamp(const cpVect v, const cpFloat len)
{
 return (cpvdot(v,v) > len*len) ? cpvmult(cpvnormalize(v), len) : v;
}


static inline cpVect cpvlerpconst(cpVect v1, cpVect v2, cpFloat d)
{
 return cpvadd(v1, cpvclamp(cpvsub(v2, v1), d));
}


static inline cpFloat cpvdist(const cpVect v1, const cpVect v2)
{
 return cpvlength(cpvsub(v1, v2));
}


static inline cpFloat cpvdistsq(const cpVect v1, const cpVect v2)
{
 return cpvlengthsq(cpvsub(v1, v2));
}


static inline cpBool cpvnear(const cpVect v1, const cpVect v2, const cpFloat dist)
{
 return cpvdistsq(v1, v2) < dist*dist;
}
static inline cpMat2x2
cpMat2x2New(cpFloat a, cpFloat b, cpFloat c, cpFloat d)
{
 cpMat2x2 m = {a, b, c, d};
 return m;
}

static inline cpVect
cpMat2x2Transform(cpMat2x2 m, cpVect v)
{
 return cpv(v.x*m.a + v.y*m.b, v.x*m.c + v.y*m.d);
}
typedef struct cpBB{
 cpFloat l, b, r ,t;
} cpBB;


static inline cpBB cpBBNew(const cpFloat l, const cpFloat b, const cpFloat r, const cpFloat t)
{
 cpBB bb = {l, b, r, t};
 return bb;
}


static inline cpBB
cpBBNewForExtents(const cpVect c, const cpFloat hw, const cpFloat hh)
{
 return cpBBNew(c.x - hw, c.y - hh, c.x + hw, c.y + hh);
}


static inline cpBB cpBBNewForCircle(const cpVect p, const cpFloat r)
{
 return cpBBNewForExtents(p, r, r);
}


static inline cpBool cpBBIntersects(const cpBB a, const cpBB b)
{
 return (a.l <= b.r && b.l <= a.r && a.b <= b.t && b.b <= a.t);
}


static inline cpBool cpBBContainsBB(const cpBB bb, const cpBB other)
{
 return (bb.l <= other.l && bb.r >= other.r && bb.b <= other.b && bb.t >= other.t);
}


static inline cpBool cpBBContainsVect(const cpBB bb, const cpVect v)
{
 return (bb.l <= v.x && bb.r >= v.x && bb.b <= v.y && bb.t >= v.y);
}


static inline cpBB cpBBMerge(const cpBB a, const cpBB b){
 return cpBBNew(
  cpfmin(a.l, b.l),
  cpfmin(a.b, b.b),
  cpfmax(a.r, b.r),
  cpfmax(a.t, b.t)
 );
}


static inline cpBB cpBBExpand(const cpBB bb, const cpVect v){
 return cpBBNew(
  cpfmin(bb.l, v.x),
  cpfmin(bb.b, v.y),
  cpfmax(bb.r, v.x),
  cpfmax(bb.t, v.y)
 );
}


static inline cpVect
cpBBCenter(cpBB bb)
{
 return cpvlerp(cpv(bb.l, bb.b), cpv(bb.r, bb.t), 0.5f);
}


static inline cpFloat cpBBArea(cpBB bb)
{
 return (bb.r - bb.l)*(bb.t - bb.b);
}


static inline cpFloat cpBBMergedArea(cpBB a, cpBB b)
{
 return (cpfmax(a.r, b.r) - cpfmin(a.l, b.l))*(cpfmax(a.t, b.t) - cpfmin(a.b, b.b));
}


static inline cpFloat cpBBSegmentQuery(cpBB bb, cpVect a, cpVect b)
{
 cpFloat idx = 1.0f/(b.x - a.x);



 cpFloat tx1 = (bb.l == a.x ? -(__builtin_inf()) : (bb.l - a.x)*idx);
 cpFloat tx2 = (bb.r == a.x ? (__builtin_inf()) : (bb.r - a.x)*idx);
 cpFloat txmin = cpfmin(tx1, tx2);
 cpFloat txmax = cpfmax(tx1, tx2);

 cpFloat idy = 1.0f/(b.y - a.y);
 cpFloat ty1 = (bb.b == a.y ? -(__builtin_inf()) : (bb.b - a.y)*idy);
 cpFloat ty2 = (bb.t == a.y ? (__builtin_inf()) : (bb.t - a.y)*idy);



 cpFloat tymin = cpfmin(ty1, ty2);
 cpFloat tymax = cpfmax(ty1, ty2);

 if(tymin <= txmax && txmin <= tymax){
  cpFloat min = cpfmax(txmin, tymin);
  cpFloat max = cpfmin(txmax, tymax);

  if(0.0 <= max && min <= 1.0) return cpfmax(min, 0.0);
 }

 return (__builtin_inf());
}


static inline cpBool cpBBIntersectsSegment(cpBB bb, cpVect a, cpVect b)
{
 return (cpBBSegmentQuery(bb, a, b) != (__builtin_inf()));
}


static inline cpVect
cpBBClampVect(const cpBB bb, const cpVect v)
{
 return cpv(cpfclamp(v.x, bb.l, bb.r), cpfclamp(v.y, bb.b, bb.t));
}


static inline cpVect
cpBBWrapVect(const cpBB bb, const cpVect v)
{
 cpFloat dx = cpfabs(bb.r - bb.l);
 cpFloat modx = fmod(v.x - bb.l, dx);
 cpFloat x = (modx > 0.0f) ? modx : modx + dx;

 cpFloat dy = cpfabs(bb.t - bb.b);
 cpFloat mody = fmod(v.y - bb.b, dy);
 cpFloat y = (mody > 0.0f) ? mody : mody + dy;

 return cpv(x + bb.l, y + bb.b);
}


static inline cpBB
cpBBOffset(const cpBB bb, const cpVect v)
{
 return cpBBNew(
  bb.l + v.x,
  bb.b + v.y,
  bb.r + v.x,
  bb.t + v.y
 );
}
// static const cpTransform cpTransformIdentity = {1.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f};





static inline cpTransform
cpTransformNew(cpFloat a, cpFloat b, cpFloat c, cpFloat d, cpFloat tx, cpFloat ty)
{
 cpTransform t = {a, b, c, d, tx, ty};
 return t;
}


static inline cpTransform
cpTransformNewTranspose(cpFloat a, cpFloat c, cpFloat tx, cpFloat b, cpFloat d, cpFloat ty)
{
 cpTransform t = {a, b, c, d, tx, ty};
 return t;
}


static inline cpTransform
cpTransformInverse(cpTransform t)
{
  cpFloat inv_det = 1.0/(t.a*t.d - t.c*t.b);
  return cpTransformNewTranspose(
     t.d*inv_det, -t.c*inv_det, (t.c*t.ty - t.tx*t.d)*inv_det,
    -t.b*inv_det, t.a*inv_det, (t.tx*t.b - t.a*t.ty)*inv_det
  );
}


static inline cpTransform
cpTransformMult(cpTransform t1, cpTransform t2)
{
  return cpTransformNewTranspose(
    t1.a*t2.a + t1.c*t2.b, t1.a*t2.c + t1.c*t2.d, t1.a*t2.tx + t1.c*t2.ty + t1.tx,
    t1.b*t2.a + t1.d*t2.b, t1.b*t2.c + t1.d*t2.d, t1.b*t2.tx + t1.d*t2.ty + t1.ty
  );
}


static inline cpVect
cpTransformPoint(cpTransform t, cpVect p)
{
  return cpv(t.a*p.x + t.c*p.y + t.tx, t.b*p.x + t.d*p.y + t.ty);
}


static inline cpVect
cpTransformVect(cpTransform t, cpVect v)
{
  return cpv(t.a*v.x + t.c*v.y, t.b*v.x + t.d*v.y);
}


static inline cpBB
cpTransformbBB(cpTransform t, cpBB bb)
{
 cpVect center = cpBBCenter(bb);
 cpFloat hw = (bb.r - bb.l)*0.5;
 cpFloat hh = (bb.t - bb.b)*0.5;

 cpFloat a = t.a*hw, b = t.c*hh, d = t.b*hw, e = t.d*hh;
 cpFloat hw_max = cpfmax(cpfabs(a + b), cpfabs(a - b));
 cpFloat hh_max = cpfmax(cpfabs(d + e), cpfabs(d - e));
 return cpBBNewForExtents(cpTransformPoint(t, center), hw_max, hh_max);
}


static inline cpTransform
cpTransformTranslate(cpVect translate)
{
  return cpTransformNewTranspose(
    1.0, 0.0, translate.x,
    0.0, 1.0, translate.y
  );
}


static inline cpTransform
cpTransformScale(cpFloat scaleX, cpFloat scaleY)
{
 return cpTransformNewTranspose(
  scaleX, 0.0, 0.0,
     0.0, scaleY, 0.0
 );
}


static inline cpTransform
cpTransformRotate(cpFloat radians)
{
 cpVect rot = cpvforangle(radians);
 return cpTransformNewTranspose(
  rot.x, -rot.y, 0.0,
  rot.y, rot.x, 0.0
 );
}


static inline cpTransform
cpTransformRigid(cpVect translate, cpFloat radians)
{
 cpVect rot = cpvforangle(radians);
 return cpTransformNewTranspose(
  rot.x, -rot.y, translate.x,
  rot.y, rot.x, translate.y
 );
}


static inline cpTransform
cpTransformRigidInverse(cpTransform t)
{
  return cpTransformNewTranspose(
     t.d, -t.c, (t.c*t.ty - t.tx*t.d),
    -t.b, t.a, (t.tx*t.b - t.a*t.ty)
  );
}




static inline cpTransform
cpTransformWrap(cpTransform outer, cpTransform inner)
{
  return cpTransformMult(cpTransformInverse(outer), cpTransformMult(inner, outer));
}

static inline cpTransform
cpTransformWrapInverse(cpTransform outer, cpTransform inner)
{
  return cpTransformMult(outer, cpTransformMult(inner, cpTransformInverse(outer)));
}

static inline cpTransform
cpTransformOrtho(cpBB bb)
{
  return cpTransformNewTranspose(
    2.0/(bb.r - bb.l), 0.0, -(bb.r + bb.l)/(bb.r - bb.l),
    0.0, 2.0/(bb.t - bb.b), -(bb.t + bb.b)/(bb.t - bb.b)
  );
}

static inline cpTransform
cpTransformBoneScale(cpVect v0, cpVect v1)
{
  cpVect d = cpvsub(v1, v0);
  return cpTransformNewTranspose(
    d.x, -d.y, v0.x,
    d.y, d.x, v0.y
  );
}

static inline cpTransform
cpTransformAxialScale(cpVect axis, cpVect pivot, cpFloat scale)
{
  cpFloat A = axis.x*axis.y*(scale - 1.0);
  cpFloat B = cpvdot(axis, pivot)*(1.0 - scale);

  return cpTransformNewTranspose(
    scale*axis.x*axis.x + axis.y*axis.y, A, axis.x*B,
    A, axis.x*axis.x + scale*axis.y*axis.y, axis.y*B
  );
}
typedef cpBB (*cpSpatialIndexBBFunc)(void *obj);

typedef void (*cpSpatialIndexIteratorFunc)(void *obj, void *data);

typedef cpCollisionID (*cpSpatialIndexQueryFunc)(void *obj1, void *obj2, cpCollisionID id, void *data);

typedef cpFloat (*cpSpatialIndexSegmentQueryFunc)(void *obj1, void *obj2, void *data);


typedef struct cpSpatialIndexClass cpSpatialIndexClass;
typedef struct cpSpatialIndex cpSpatialIndex;


struct cpSpatialIndex {
 cpSpatialIndexClass *klass;

 cpSpatialIndexBBFunc bbfunc;

 cpSpatialIndex *staticIndex, *dynamicIndex;
};




typedef struct cpSpaceHash cpSpaceHash;


          cpSpaceHash* cpSpaceHashAlloc(void);

          cpSpatialIndex* cpSpaceHashInit(cpSpaceHash *hash, cpFloat celldim, int numcells, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);

          cpSpatialIndex* cpSpaceHashNew(cpFloat celldim, int cells, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);





          void cpSpaceHashResize(cpSpaceHash *hash, cpFloat celldim, int numcells);



typedef struct cpBBTree cpBBTree;


          cpBBTree* cpBBTreeAlloc(void);

          cpSpatialIndex* cpBBTreeInit(cpBBTree *tree, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);

          cpSpatialIndex* cpBBTreeNew(cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);


          void cpBBTreeOptimize(cpSpatialIndex *index);



typedef cpVect (*cpBBTreeVelocityFunc)(void *obj);

          void cpBBTreeSetVelocityFunc(cpSpatialIndex *index, cpBBTreeVelocityFunc func);



typedef struct cpSweep1D cpSweep1D;


          cpSweep1D* cpSweep1DAlloc(void);

          cpSpatialIndex* cpSweep1DInit(cpSweep1D *sweep, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);

          cpSpatialIndex* cpSweep1DNew(cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);



typedef void (*cpSpatialIndexDestroyImpl)(cpSpatialIndex *index);

typedef int (*cpSpatialIndexCountImpl)(cpSpatialIndex *index);
typedef void (*cpSpatialIndexEachImpl)(cpSpatialIndex *index, cpSpatialIndexIteratorFunc func, void *data);

typedef cpBool (*cpSpatialIndexContainsImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef void (*cpSpatialIndexInsertImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef void (*cpSpatialIndexRemoveImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);

typedef void (*cpSpatialIndexReindexImpl)(cpSpatialIndex *index);
typedef void (*cpSpatialIndexReindexObjectImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef void (*cpSpatialIndexReindexQueryImpl)(cpSpatialIndex *index, cpSpatialIndexQueryFunc func, void *data);

typedef void (*cpSpatialIndexQueryImpl)(cpSpatialIndex *index, void *obj, cpBB bb, cpSpatialIndexQueryFunc func, void *data);
typedef void (*cpSpatialIndexSegmentQueryImpl)(cpSpatialIndex *index, void *obj, cpVect a, cpVect b, cpFloat t_exit, cpSpatialIndexSegmentQueryFunc func, void *data);

struct cpSpatialIndexClass {
 cpSpatialIndexDestroyImpl destroy;

 cpSpatialIndexCountImpl count;
 cpSpatialIndexEachImpl each;

 cpSpatialIndexContainsImpl contains;
 cpSpatialIndexInsertImpl insert;
 cpSpatialIndexRemoveImpl remove;

 cpSpatialIndexReindexImpl reindex;
 cpSpatialIndexReindexObjectImpl reindexObject;
 cpSpatialIndexReindexQueryImpl reindexQuery;

 cpSpatialIndexQueryImpl query;
 cpSpatialIndexSegmentQueryImpl segmentQuery;
};


void cpSpatialIndexFree(cpSpatialIndex *index);

void cpSpatialIndexCollideStatic(cpSpatialIndex *dynamicIndex, cpSpatialIndex *staticIndex, cpSpatialIndexQueryFunc func, void *data);


static inline void cpSpatialIndexDestroy(cpSpatialIndex *index)
{
 if(index->klass) index->klass->destroy(index);
}


static inline int cpSpatialIndexCount(cpSpatialIndex *index)
{
 return index->klass->count(index);
}


static inline void cpSpatialIndexEach(cpSpatialIndex *index, cpSpatialIndexIteratorFunc func, void *data)
{
 index->klass->each(index, func, data);
}



static inline cpBool cpSpatialIndexContains(cpSpatialIndex *index, void *obj, cpHashValue hashid)
{
 return index->klass->contains(index, obj, hashid);
}



static inline void cpSpatialIndexInsert(cpSpatialIndex *index, void *obj, cpHashValue hashid)
{
 index->klass->insert(index, obj, hashid);
}



static inline void cpSpatialIndexRemove(cpSpatialIndex *index, void *obj, cpHashValue hashid)
{
 index->klass->remove(index, obj, hashid);
}


static inline void cpSpatialIndexReindex(cpSpatialIndex *index)
{
 index->klass->reindex(index);
}


static inline void cpSpatialIndexReindexObject(cpSpatialIndex *index, void *obj, cpHashValue hashid)
{
 index->klass->reindexObject(index, obj, hashid);
}


static inline void cpSpatialIndexQuery(cpSpatialIndex *index, void *obj, cpBB bb, cpSpatialIndexQueryFunc func, void *data)
{
 index->klass->query(index, obj, bb, func, data);
}


static inline void cpSpatialIndexSegmentQuery(cpSpatialIndex *index, void *obj, cpVect a, cpVect b, cpFloat t_exit, cpSpatialIndexSegmentQueryFunc func, void *data)
{
 index->klass->segmentQuery(index, obj, a, b, t_exit, func, data);
}




static inline void cpSpatialIndexReindexQuery(cpSpatialIndex *index, cpSpatialIndexQueryFunc func, void *data)
{
 index->klass->reindexQuery(index, func, data);
}

          cpFloat cpArbiterGetRestitution(const cpArbiter *arb);

          void cpArbiterSetRestitution(cpArbiter *arb, cpFloat restitution);

          cpFloat cpArbiterGetFriction(const cpArbiter *arb);

          void cpArbiterSetFriction(cpArbiter *arb, cpFloat friction);


          cpVect cpArbiterGetSurfaceVelocity(cpArbiter *arb);



          void cpArbiterSetSurfaceVelocity(cpArbiter *arb, cpVect vr);


          cpDataPointer cpArbiterGetUserData(const cpArbiter *arb);


          void cpArbiterSetUserData(cpArbiter *arb, cpDataPointer userData);



          cpVect cpArbiterTotalImpulse(const cpArbiter *arb);


          cpFloat cpArbiterTotalKE(const cpArbiter *arb);



          cpBool cpArbiterIgnore(cpArbiter *arb);




          void cpArbiterGetShapes(const cpArbiter *arb, cpShape **a, cpShape **b);







          void cpArbiterGetBodies(const cpArbiter *arb, cpBody **a, cpBody **b);





struct cpContactPointSet {

 int count;


 cpVect normal;


 struct {

  cpVect pointA, pointB;


  cpFloat distance;
 } points[2];
};


          cpContactPointSet cpArbiterGetContactPointSet(const cpArbiter *arb);



          void cpArbiterSetContactPointSet(cpArbiter *arb, cpContactPointSet *set);


          cpBool cpArbiterIsFirstContact(const cpArbiter *arb);

          cpBool cpArbiterIsRemoval(const cpArbiter *arb);


          int cpArbiterGetCount(const cpArbiter *arb);

          cpVect cpArbiterGetNormal(const cpArbiter *arb);

          cpVect cpArbiterGetPointA(const cpArbiter *arb, int i);

          cpVect cpArbiterGetPointB(const cpArbiter *arb, int i);

          cpFloat cpArbiterGetDepth(const cpArbiter *arb, int i);



          cpBool cpArbiterCallWildcardBeginA(cpArbiter *arb, cpSpace *space);


          cpBool cpArbiterCallWildcardBeginB(cpArbiter *arb, cpSpace *space);



          cpBool cpArbiterCallWildcardPreSolveA(cpArbiter *arb, cpSpace *space);


          cpBool cpArbiterCallWildcardPreSolveB(cpArbiter *arb, cpSpace *space);


          void cpArbiterCallWildcardPostSolveA(cpArbiter *arb, cpSpace *space);

          void cpArbiterCallWildcardPostSolveB(cpArbiter *arb, cpSpace *space);


          void cpArbiterCallWildcardSeparateA(cpArbiter *arb, cpSpace *space);

          void cpArbiterCallWildcardSeparateB(cpArbiter *arb, cpSpace *space);

typedef enum cpBodyType {


 CP_BODY_TYPE_DYNAMIC,




 CP_BODY_TYPE_KINEMATIC,



 CP_BODY_TYPE_STATIC,
} cpBodyType;


typedef void (*cpBodyVelocityFunc)(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt);

typedef void (*cpBodyPositionFunc)(cpBody *body, cpFloat dt);


          cpBody* cpBodyAlloc(void);

          cpBody* cpBodyInit(cpBody *body, cpFloat mass, cpFloat moment);

          cpBody* cpBodyNew(cpFloat mass, cpFloat moment);


          cpBody* cpBodyNewKinematic(void);

          cpBody* cpBodyNewStatic(void);


          void cpBodyDestroy(cpBody *body);

          void cpBodyFree(cpBody *body);



          void cpBodyActivate(cpBody *body);

          void cpBodyActivateStatic(cpBody *body, cpShape *filter);


          void cpBodySleep(cpBody *body);

          void cpBodySleepWithGroup(cpBody *body, cpBody *group);


          cpBool cpBodyIsSleeping(const cpBody *body);


          cpBodyType cpBodyGetType(cpBody *body);

          void cpBodySetType(cpBody *body, cpBodyType type);


          cpSpace* cpBodyGetSpace(const cpBody *body);


          cpFloat cpBodyGetMass(const cpBody *body);

          void cpBodySetMass(cpBody *body, cpFloat m);


          cpFloat cpBodyGetMoment(const cpBody *body);

          void cpBodySetMoment(cpBody *body, cpFloat i);


          cpVect cpBodyGetPosition(const cpBody *body);

          void cpBodySetPosition(cpBody *body, cpVect pos);


          cpVect cpBodyGetCenterOfGravity(const cpBody *body);

          void cpBodySetCenterOfGravity(cpBody *body, cpVect cog);


          cpVect cpBodyGetVelocity(const cpBody *body);

          void cpBodySetVelocity(cpBody *body, cpVect velocity);


          cpVect cpBodyGetForce(const cpBody *body);

          void cpBodySetForce(cpBody *body, cpVect force);


          cpFloat cpBodyGetAngle(const cpBody *body);

          void cpBodySetAngle(cpBody *body, cpFloat a);


          cpFloat cpBodyGetAngularVelocity(const cpBody *body);

          void cpBodySetAngularVelocity(cpBody *body, cpFloat angularVelocity);


          cpFloat cpBodyGetTorque(const cpBody *body);

          void cpBodySetTorque(cpBody *body, cpFloat torque);


          cpVect cpBodyGetRotation(const cpBody *body);


          cpDataPointer cpBodyGetUserData(const cpBody *body);

          void cpBodySetUserData(cpBody *body, cpDataPointer userData);


          void cpBodySetVelocityUpdateFunc(cpBody *body, cpBodyVelocityFunc velocityFunc);


          void cpBodySetPositionUpdateFunc(cpBody *body, cpBodyPositionFunc positionFunc);


          void cpBodyUpdateVelocity(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt);

          void cpBodyUpdatePosition(cpBody *body, cpFloat dt);


          cpVect cpBodyLocalToWorld(const cpBody *body, const cpVect point);

          cpVect cpBodyWorldToLocal(const cpBody *body, const cpVect point);


          void cpBodyApplyForceAtWorldPoint(cpBody *body, cpVect force, cpVect point);

          void cpBodyApplyForceAtLocalPoint(cpBody *body, cpVect force, cpVect point);


          void cpBodyApplyImpulseAtWorldPoint(cpBody *body, cpVect impulse, cpVect point);

          void cpBodyApplyImpulseAtLocalPoint(cpBody *body, cpVect impulse, cpVect point);


          cpVect cpBodyGetVelocityAtWorldPoint(const cpBody *body, cpVect point);

          cpVect cpBodyGetVelocityAtLocalPoint(const cpBody *body, cpVect point);


          cpFloat cpBodyKineticEnergy(const cpBody *body);


typedef void (*cpBodyShapeIteratorFunc)(cpBody *body, cpShape *shape, void *data);

          void cpBodyEachShape(cpBody *body, cpBodyShapeIteratorFunc func, void *data);


typedef void (*cpBodyConstraintIteratorFunc)(cpBody *body, cpConstraint *constraint, void *data);

          void cpBodyEachConstraint(cpBody *body, cpBodyConstraintIteratorFunc func, void *data);


typedef void (*cpBodyArbiterIteratorFunc)(cpBody *body, cpArbiter *arbiter, void *data);

          void cpBodyEachArbiter(cpBody *body, cpBodyArbiterIteratorFunc func, void *data);
typedef struct cpPointQueryInfo {

 const cpShape *shape;

 cpVect point;

 cpFloat distance;


 cpVect gradient;
} cpPointQueryInfo;


typedef struct cpSegmentQueryInfo {

 const cpShape *shape;

 cpVect point;

 cpVect normal;

 cpFloat alpha;
} cpSegmentQueryInfo;


typedef struct cpShapeFilter {


 cpGroup group;


 cpBitmask categories;


 cpBitmask mask;
} cpShapeFilter;


// static const cpShapeFilter CP_SHAPE_FILTER_ALL = {((cpGroup)0), (~(cpBitmask)0), (~(cpBitmask)0)};

// static const cpShapeFilter CP_SHAPE_FILTER_NONE = {((cpGroup)0), ~(~(cpBitmask)0), ~(~(cpBitmask)0)};


static inline cpShapeFilter
cpShapeFilterNew(cpGroup group, cpBitmask categories, cpBitmask mask)
{
 cpShapeFilter filter = {group, categories, mask};
 return filter;
}


          void cpShapeDestroy(cpShape *shape);

          void cpShapeFree(cpShape *shape);


          cpBB cpShapeCacheBB(cpShape *shape);

          cpBB cpShapeUpdate(cpShape *shape, cpTransform transform);



          cpFloat cpShapePointQuery(const cpShape *shape, cpVect p, cpPointQueryInfo *out);


          cpBool cpShapeSegmentQuery(const cpShape *shape, cpVect a, cpVect b, cpFloat radius, cpSegmentQueryInfo *info);


          cpContactPointSet cpShapesCollide(const cpShape *a, const cpShape *b);


          cpSpace* cpShapeGetSpace(const cpShape *shape);


          cpBody* cpShapeGetBody(const cpShape *shape);


          void cpShapeSetBody(cpShape *shape, cpBody *body);


cpFloat cpShapeGetMass(cpShape *shape);

          void cpShapeSetMass(cpShape *shape, cpFloat mass);


          cpFloat cpShapeGetDensity(cpShape *shape);

          void cpShapeSetDensity(cpShape *shape, cpFloat density);


          cpFloat cpShapeGetMoment(cpShape *shape);

          cpFloat cpShapeGetArea(cpShape *shape);

          cpVect cpShapeGetCenterOfGravity(cpShape *shape);


          cpBB cpShapeGetBB(const cpShape *shape);


          cpBool cpShapeGetSensor(const cpShape *shape);

          void cpShapeSetSensor(cpShape *shape, cpBool sensor);


          cpFloat cpShapeGetElasticity(const cpShape *shape);

          void cpShapeSetElasticity(cpShape *shape, cpFloat elasticity);


          cpFloat cpShapeGetFriction(const cpShape *shape);

          void cpShapeSetFriction(cpShape *shape, cpFloat friction);


          cpVect cpShapeGetSurfaceVelocity(const cpShape *shape);

          void cpShapeSetSurfaceVelocity(cpShape *shape, cpVect surfaceVelocity);


          cpDataPointer cpShapeGetUserData(const cpShape *shape);

          void cpShapeSetUserData(cpShape *shape, cpDataPointer userData);


          cpCollisionType cpShapeGetCollisionType(const cpShape *shape);

          void cpShapeSetCollisionType(cpShape *shape, cpCollisionType collisionType);


          cpShapeFilter cpShapeGetFilter(const cpShape *shape);

          void cpShapeSetFilter(cpShape *shape, cpShapeFilter filter);






          cpCircleShape* cpCircleShapeAlloc(void);

          cpCircleShape* cpCircleShapeInit(cpCircleShape *circle, cpBody *body, cpFloat radius, cpVect offset);

          cpShape* cpCircleShapeNew(cpBody *body, cpFloat radius, cpVect offset);


          cpVect cpCircleShapeGetOffset(const cpShape *shape);

          cpFloat cpCircleShapeGetRadius(const cpShape *shape);





          cpSegmentShape* cpSegmentShapeAlloc(void);

          cpSegmentShape* cpSegmentShapeInit(cpSegmentShape *seg, cpBody *body, cpVect a, cpVect b, cpFloat radius);

          cpShape* cpSegmentShapeNew(cpBody *body, cpVect a, cpVect b, cpFloat radius);


          void cpSegmentShapeSetNeighbors(cpShape *shape, cpVect prev, cpVect next);


          cpVect cpSegmentShapeGetA(const cpShape *shape);

          cpVect cpSegmentShapeGetB(const cpShape *shape);

          cpVect cpSegmentShapeGetNormal(const cpShape *shape);

          cpFloat cpSegmentShapeGetRadius(const cpShape *shape);
          cpPolyShape* cpPolyShapeAlloc(void);


          cpPolyShape* cpPolyShapeInit(cpPolyShape *poly, cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius);


          cpPolyShape* cpPolyShapeInitRaw(cpPolyShape *poly, cpBody *body, int count, const cpVect *verts, cpFloat radius);


          cpShape* cpPolyShapeNew(cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius);


          cpShape* cpPolyShapeNewRaw(cpBody *body, int count, const cpVect *verts, cpFloat radius);


          cpPolyShape* cpBoxShapeInit(cpPolyShape *poly, cpBody *body, cpFloat width, cpFloat height, cpFloat radius);

          cpPolyShape* cpBoxShapeInit2(cpPolyShape *poly, cpBody *body, cpBB box, cpFloat radius);

          cpShape* cpBoxShapeNew(cpBody *body, cpFloat width, cpFloat height, cpFloat radius);

          cpShape* cpBoxShapeNew2(cpBody *body, cpBB box, cpFloat radius);


          int cpPolyShapeGetCount(const cpShape *shape);

          cpVect cpPolyShapeGetVert(const cpShape *shape, int index);

          cpFloat cpPolyShapeGetRadius(const cpShape *shape);

typedef void (*cpConstraintPreSolveFunc)(cpConstraint *constraint, cpSpace *space);

typedef void (*cpConstraintPostSolveFunc)(cpConstraint *constraint, cpSpace *space);


          void cpConstraintDestroy(cpConstraint *constraint);

          void cpConstraintFree(cpConstraint *constraint);


          cpSpace* cpConstraintGetSpace(const cpConstraint *constraint);


          cpBody* cpConstraintGetBodyA(const cpConstraint *constraint);


          cpBody* cpConstraintGetBodyB(const cpConstraint *constraint);


          cpFloat cpConstraintGetMaxForce(const cpConstraint *constraint);

          void cpConstraintSetMaxForce(cpConstraint *constraint, cpFloat maxForce);


          cpFloat cpConstraintGetErrorBias(const cpConstraint *constraint);



          void cpConstraintSetErrorBias(cpConstraint *constraint, cpFloat errorBias);


          cpFloat cpConstraintGetMaxBias(const cpConstraint *constraint);

          void cpConstraintSetMaxBias(cpConstraint *constraint, cpFloat maxBias);


          cpBool cpConstraintGetCollideBodies(const cpConstraint *constraint);

          void cpConstraintSetCollideBodies(cpConstraint *constraint, cpBool collideBodies);


          cpConstraintPreSolveFunc cpConstraintGetPreSolveFunc(const cpConstraint *constraint);

          void cpConstraintSetPreSolveFunc(cpConstraint *constraint, cpConstraintPreSolveFunc preSolveFunc);


          cpConstraintPostSolveFunc cpConstraintGetPostSolveFunc(const cpConstraint *constraint);

          void cpConstraintSetPostSolveFunc(cpConstraint *constraint, cpConstraintPostSolveFunc postSolveFunc);


          cpDataPointer cpConstraintGetUserData(const cpConstraint *constraint);

          void cpConstraintSetUserData(cpConstraint *constraint, cpDataPointer userData);


          cpFloat cpConstraintGetImpulse(cpConstraint *constraint);


          cpBool cpConstraintIsPinJoint(const cpConstraint *constraint);


          cpPinJoint* cpPinJointAlloc(void);

          cpPinJoint* cpPinJointInit(cpPinJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);

          cpConstraint* cpPinJointNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);


          cpVect cpPinJointGetAnchorA(const cpConstraint *constraint);

          void cpPinJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);


          cpVect cpPinJointGetAnchorB(const cpConstraint *constraint);

          void cpPinJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);


          cpFloat cpPinJointGetDist(const cpConstraint *constraint);

          void cpPinJointSetDist(cpConstraint *constraint, cpFloat dist);
          cpBool cpConstraintIsSlideJoint(const cpConstraint *constraint);


          cpSlideJoint* cpSlideJointAlloc(void);

          cpSlideJoint* cpSlideJointInit(cpSlideJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat min, cpFloat max);

          cpConstraint* cpSlideJointNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat min, cpFloat max);


          cpVect cpSlideJointGetAnchorA(const cpConstraint *constraint);

          void cpSlideJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);


          cpVect cpSlideJointGetAnchorB(const cpConstraint *constraint);

          void cpSlideJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);


          cpFloat cpSlideJointGetMin(const cpConstraint *constraint);

          void cpSlideJointSetMin(cpConstraint *constraint, cpFloat min);


          cpFloat cpSlideJointGetMax(const cpConstraint *constraint);

          void cpSlideJointSetMax(cpConstraint *constraint, cpFloat max);
          cpBool cpConstraintIsPivotJoint(const cpConstraint *constraint);


          cpPivotJoint* cpPivotJointAlloc(void);

          cpPivotJoint* cpPivotJointInit(cpPivotJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);

          cpConstraint* cpPivotJointNew(cpBody *a, cpBody *b, cpVect pivot);

          cpConstraint* cpPivotJointNew2(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);


          cpVect cpPivotJointGetAnchorA(const cpConstraint *constraint);

          void cpPivotJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);


          cpVect cpPivotJointGetAnchorB(const cpConstraint *constraint);

          void cpPivotJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
          cpBool cpConstraintIsGrooveJoint(const cpConstraint *constraint);


          cpGrooveJoint* cpGrooveJointAlloc(void);

          cpGrooveJoint* cpGrooveJointInit(cpGrooveJoint *joint, cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchorB);

          cpConstraint* cpGrooveJointNew(cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchorB);


          cpVect cpGrooveJointGetGrooveA(const cpConstraint *constraint);

          void cpGrooveJointSetGrooveA(cpConstraint *constraint, cpVect grooveA);


          cpVect cpGrooveJointGetGrooveB(const cpConstraint *constraint);

          void cpGrooveJointSetGrooveB(cpConstraint *constraint, cpVect grooveB);


          cpVect cpGrooveJointGetAnchorB(const cpConstraint *constraint);

          void cpGrooveJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
          cpBool cpConstraintIsDampedSpring(const cpConstraint *constraint);


typedef cpFloat (*cpDampedSpringForceFunc)(cpConstraint *spring, cpFloat dist);


          cpDampedSpring* cpDampedSpringAlloc(void);

          cpDampedSpring* cpDampedSpringInit(cpDampedSpring *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat restLength, cpFloat stiffness, cpFloat damping);

          cpConstraint* cpDampedSpringNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat restLength, cpFloat stiffness, cpFloat damping);


          cpVect cpDampedSpringGetAnchorA(const cpConstraint *constraint);

          void cpDampedSpringSetAnchorA(cpConstraint *constraint, cpVect anchorA);


          cpVect cpDampedSpringGetAnchorB(const cpConstraint *constraint);

          void cpDampedSpringSetAnchorB(cpConstraint *constraint, cpVect anchorB);


          cpFloat cpDampedSpringGetRestLength(const cpConstraint *constraint);

          void cpDampedSpringSetRestLength(cpConstraint *constraint, cpFloat restLength);


          cpFloat cpDampedSpringGetStiffness(const cpConstraint *constraint);

          void cpDampedSpringSetStiffness(cpConstraint *constraint, cpFloat stiffness);


          cpFloat cpDampedSpringGetDamping(const cpConstraint *constraint);

          void cpDampedSpringSetDamping(cpConstraint *constraint, cpFloat damping);


          cpDampedSpringForceFunc cpDampedSpringGetSpringForceFunc(const cpConstraint *constraint);

          void cpDampedSpringSetSpringForceFunc(cpConstraint *constraint, cpDampedSpringForceFunc springForceFunc);
          cpBool cpConstraintIsDampedRotarySpring(const cpConstraint *constraint);


typedef cpFloat (*cpDampedRotarySpringTorqueFunc)(struct cpConstraint *spring, cpFloat relativeAngle);


          cpDampedRotarySpring* cpDampedRotarySpringAlloc(void);

          cpDampedRotarySpring* cpDampedRotarySpringInit(cpDampedRotarySpring *joint, cpBody *a, cpBody *b, cpFloat restAngle, cpFloat stiffness, cpFloat damping);

          cpConstraint* cpDampedRotarySpringNew(cpBody *a, cpBody *b, cpFloat restAngle, cpFloat stiffness, cpFloat damping);


          cpFloat cpDampedRotarySpringGetRestAngle(const cpConstraint *constraint);

          void cpDampedRotarySpringSetRestAngle(cpConstraint *constraint, cpFloat restAngle);


          cpFloat cpDampedRotarySpringGetStiffness(const cpConstraint *constraint);

          void cpDampedRotarySpringSetStiffness(cpConstraint *constraint, cpFloat stiffness);


          cpFloat cpDampedRotarySpringGetDamping(const cpConstraint *constraint);

          void cpDampedRotarySpringSetDamping(cpConstraint *constraint, cpFloat damping);


          cpDampedRotarySpringTorqueFunc cpDampedRotarySpringGetSpringTorqueFunc(const cpConstraint *constraint);

          void cpDampedRotarySpringSetSpringTorqueFunc(cpConstraint *constraint, cpDampedRotarySpringTorqueFunc springTorqueFunc);
          cpBool cpConstraintIsRotaryLimitJoint(const cpConstraint *constraint);


          cpRotaryLimitJoint* cpRotaryLimitJointAlloc(void);

          cpRotaryLimitJoint* cpRotaryLimitJointInit(cpRotaryLimitJoint *joint, cpBody *a, cpBody *b, cpFloat min, cpFloat max);

          cpConstraint* cpRotaryLimitJointNew(cpBody *a, cpBody *b, cpFloat min, cpFloat max);


          cpFloat cpRotaryLimitJointGetMin(const cpConstraint *constraint);

          void cpRotaryLimitJointSetMin(cpConstraint *constraint, cpFloat min);


          cpFloat cpRotaryLimitJointGetMax(const cpConstraint *constraint);

          void cpRotaryLimitJointSetMax(cpConstraint *constraint, cpFloat max);
          cpBool cpConstraintIsRatchetJoint(const cpConstraint *constraint);


          cpRatchetJoint* cpRatchetJointAlloc(void);

          cpRatchetJoint* cpRatchetJointInit(cpRatchetJoint *joint, cpBody *a, cpBody *b, cpFloat phase, cpFloat ratchet);

          cpConstraint* cpRatchetJointNew(cpBody *a, cpBody *b, cpFloat phase, cpFloat ratchet);


          cpFloat cpRatchetJointGetAngle(const cpConstraint *constraint);

          void cpRatchetJointSetAngle(cpConstraint *constraint, cpFloat angle);


          cpFloat cpRatchetJointGetPhase(const cpConstraint *constraint);

          void cpRatchetJointSetPhase(cpConstraint *constraint, cpFloat phase);


          cpFloat cpRatchetJointGetRatchet(const cpConstraint *constraint);

          void cpRatchetJointSetRatchet(cpConstraint *constraint, cpFloat ratchet);
          cpBool cpConstraintIsGearJoint(const cpConstraint *constraint);


          cpGearJoint* cpGearJointAlloc(void);

          cpGearJoint* cpGearJointInit(cpGearJoint *joint, cpBody *a, cpBody *b, cpFloat phase, cpFloat ratio);

          cpConstraint* cpGearJointNew(cpBody *a, cpBody *b, cpFloat phase, cpFloat ratio);


          cpFloat cpGearJointGetPhase(const cpConstraint *constraint);

          void cpGearJointSetPhase(cpConstraint *constraint, cpFloat phase);


          cpFloat cpGearJointGetRatio(const cpConstraint *constraint);

          void cpGearJointSetRatio(cpConstraint *constraint, cpFloat ratio);
typedef struct cpSimpleMotor cpSimpleMotor;


          cpBool cpConstraintIsSimpleMotor(const cpConstraint *constraint);


          cpSimpleMotor* cpSimpleMotorAlloc(void);

          cpSimpleMotor* cpSimpleMotorInit(cpSimpleMotor *joint, cpBody *a, cpBody *b, cpFloat rate);

          cpConstraint* cpSimpleMotorNew(cpBody *a, cpBody *b, cpFloat rate);


          cpFloat cpSimpleMotorGetRate(const cpConstraint *constraint);

          void cpSimpleMotorSetRate(cpConstraint *constraint, cpFloat rate);

typedef cpBool (*cpCollisionBeginFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);


typedef cpBool (*cpCollisionPreSolveFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);

typedef void (*cpCollisionPostSolveFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);

typedef void (*cpCollisionSeparateFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);



struct cpCollisionHandler {


 const cpCollisionType typeA;


 const cpCollisionType typeB;

 cpCollisionBeginFunc beginFunc;


 cpCollisionPreSolveFunc preSolveFunc;


 cpCollisionPostSolveFunc postSolveFunc;

 cpCollisionSeparateFunc separateFunc;

 cpDataPointer userData;
};







          cpSpace* cpSpaceAlloc(void);

          cpSpace* cpSpaceInit(cpSpace *space);

          cpSpace* cpSpaceNew(void);


          void cpSpaceDestroy(cpSpace *space);

          void cpSpaceFree(cpSpace *space);





          int cpSpaceGetIterations(const cpSpace *space);
          void cpSpaceSetIterations(cpSpace *space, int iterations);


          cpVect cpSpaceGetGravity(const cpSpace *space);
          void cpSpaceSetGravity(cpSpace *space, cpVect gravity);





          cpFloat cpSpaceGetDamping(const cpSpace *space);
          void cpSpaceSetDamping(cpSpace *space, cpFloat damping);



          cpFloat cpSpaceGetIdleSpeedThreshold(const cpSpace *space);
          void cpSpaceSetIdleSpeedThreshold(cpSpace *space, cpFloat idleSpeedThreshold);




          cpFloat cpSpaceGetSleepTimeThreshold(const cpSpace *space);
          void cpSpaceSetSleepTimeThreshold(cpSpace *space, cpFloat sleepTimeThreshold);





          cpFloat cpSpaceGetCollisionSlop(const cpSpace *space);
          void cpSpaceSetCollisionSlop(cpSpace *space, cpFloat collisionSlop);




          cpFloat cpSpaceGetCollisionBias(const cpSpace *space);
          void cpSpaceSetCollisionBias(cpSpace *space, cpFloat collisionBias);



          cpTimestamp cpSpaceGetCollisionPersistence(const cpSpace *space);
          void cpSpaceSetCollisionPersistence(cpSpace *space, cpTimestamp collisionPersistence);




          cpDataPointer cpSpaceGetUserData(const cpSpace *space);
          void cpSpaceSetUserData(cpSpace *space, cpDataPointer userData);



          cpBody* cpSpaceGetStaticBody(const cpSpace *space);



          cpFloat cpSpaceGetCurrentTimeStep(const cpSpace *space);


          cpBool cpSpaceIsLocked(cpSpace *space);





          cpCollisionHandler *cpSpaceAddDefaultCollisionHandler(cpSpace *space);


          cpCollisionHandler *cpSpaceAddCollisionHandler(cpSpace *space, cpCollisionType a, cpCollisionType b);

          cpCollisionHandler *cpSpaceAddWildcardHandler(cpSpace *space, cpCollisionType type);






          cpShape* cpSpaceAddShape(cpSpace *space, cpShape *shape);

          cpBody* cpSpaceAddBody(cpSpace *space, cpBody *body);

          cpConstraint* cpSpaceAddConstraint(cpSpace *space, cpConstraint *constraint);


          void cpSpaceRemoveShape(cpSpace *space, cpShape *shape);

          void cpSpaceRemoveBody(cpSpace *space, cpBody *body);

          void cpSpaceRemoveConstraint(cpSpace *space, cpConstraint *constraint);


          cpBool cpSpaceContainsShape(cpSpace *space, cpShape *shape);

          cpBool cpSpaceContainsBody(cpSpace *space, cpBody *body);

          cpBool cpSpaceContainsConstraint(cpSpace *space, cpConstraint *constraint);




typedef void (*cpPostStepFunc)(cpSpace *space, void *key, void *data);




          cpBool cpSpaceAddPostStepCallback(cpSpace *space, cpPostStepFunc func, void *key, void *data);
typedef void (*cpSpacePointQueryFunc)(cpShape *shape, cpVect point, cpFloat distance, cpVect gradient, void *data);

          void cpSpacePointQuery(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpSpacePointQueryFunc func, void *data);

          cpShape *cpSpacePointQueryNearest(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpPointQueryInfo *out);


typedef void (*cpSpaceSegmentQueryFunc)(cpShape *shape, cpVect point, cpVect normal, cpFloat alpha, void *data);

          void cpSpaceSegmentQuery(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSpaceSegmentQueryFunc func, void *data);

          cpShape *cpSpaceSegmentQueryFirst(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSegmentQueryInfo *out);


typedef void (*cpSpaceBBQueryFunc)(cpShape *shape, void *data);


          void cpSpaceBBQuery(cpSpace *space, cpBB bb, cpShapeFilter filter, cpSpaceBBQueryFunc func, void *data);


typedef void (*cpSpaceShapeQueryFunc)(cpShape *shape, cpContactPointSet *points, void *data);

          cpBool cpSpaceShapeQuery(cpSpace *space, cpShape *shape, cpSpaceShapeQueryFunc func, void *data);





typedef void (*cpSpaceBodyIteratorFunc)(cpBody *body, void *data);

          void cpSpaceEachBody(cpSpace *space, cpSpaceBodyIteratorFunc func, void *data);


typedef void (*cpSpaceShapeIteratorFunc)(cpShape *shape, void *data);

          void cpSpaceEachShape(cpSpace *space, cpSpaceShapeIteratorFunc func, void *data);


typedef void (*cpSpaceConstraintIteratorFunc)(cpConstraint *constraint, void *data);

          void cpSpaceEachConstraint(cpSpace *space, cpSpaceConstraintIteratorFunc func, void *data);





          void cpSpaceReindexStatic(cpSpace *space);

          void cpSpaceReindexShape(cpSpace *space, cpShape *shape);

          void cpSpaceReindexShapesForBody(cpSpace *space, cpBody *body);


          void cpSpaceUseSpatialHash(cpSpace *space, cpFloat dim, int count);





          void cpSpaceStep(cpSpace *space, cpFloat dt);







typedef struct cpSpaceDebugColor {
 float r, g, b, a;
} cpSpaceDebugColor;


typedef void (*cpSpaceDebugDrawCircleImpl)(cpVect pos, cpFloat angle, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data);

typedef void (*cpSpaceDebugDrawSegmentImpl)(cpVect a, cpVect b, cpSpaceDebugColor color, cpDataPointer data);

typedef void (*cpSpaceDebugDrawFatSegmentImpl)(cpVect a, cpVect b, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data);

typedef void (*cpSpaceDebugDrawPolygonImpl)(int count, const cpVect *verts, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data);

typedef void (*cpSpaceDebugDrawDotImpl)(cpFloat size, cpVect pos, cpSpaceDebugColor color, cpDataPointer data);

typedef cpSpaceDebugColor (*cpSpaceDebugDrawColorForShapeImpl)(cpShape *shape, cpDataPointer data);

typedef enum cpSpaceDebugDrawFlags {
 CP_SPACE_DEBUG_DRAW_SHAPES = 1<<0,
 CP_SPACE_DEBUG_DRAW_CONSTRAINTS = 1<<1,
 CP_SPACE_DEBUG_DRAW_COLLISION_POINTS = 1<<2,
} cpSpaceDebugDrawFlags;


typedef struct cpSpaceDebugDrawOptions {

 cpSpaceDebugDrawCircleImpl drawCircle;

 cpSpaceDebugDrawSegmentImpl drawSegment;

 cpSpaceDebugDrawFatSegmentImpl drawFatSegment;

 cpSpaceDebugDrawPolygonImpl drawPolygon;

 cpSpaceDebugDrawDotImpl drawDot;


 cpSpaceDebugDrawFlags flags;

 cpSpaceDebugColor shapeOutlineColor;

 cpSpaceDebugDrawColorForShapeImpl colorForShape;

 cpSpaceDebugColor constraintColor;

 cpSpaceDebugColor collisionPointColor;


 cpDataPointer data;
} cpSpaceDebugDrawOptions;


          void cpSpaceDebugDraw(cpSpace *space, cpSpaceDebugDrawOptions *options);







          extern const char *cpVersionString;



          cpFloat cpMomentForCircle(cpFloat m, cpFloat r1, cpFloat r2, cpVect offset);



          cpFloat cpAreaForCircle(cpFloat r1, cpFloat r2);



          cpFloat cpMomentForSegment(cpFloat m, cpVect a, cpVect b, cpFloat radius);


          cpFloat cpAreaForSegment(cpVect a, cpVect b, cpFloat radius);


          cpFloat cpMomentForPoly(cpFloat m, int count, const cpVect *verts, cpVect offset, cpFloat radius);



          cpFloat cpAreaForPoly(const int count, const cpVect *verts, cpFloat radius);


          cpVect cpCentroidForPoly(const int count, const cpVect *verts);


          cpFloat cpMomentForBox(cpFloat m, cpFloat width, cpFloat height);


          cpFloat cpMomentForBox2(cpFloat m, cpBB box);





          int cpConvexHull(int count, const cpVect *verts, cpVect *result, int *first, cpFloat tol);
static inline cpVect
cpClosetPointOnSegment(const cpVect p, const cpVect a, const cpVect b)
{
 cpVect delta = cpvsub(a, b);
 cpFloat t = cpfclamp01(cpvdot(delta, cpvsub(p, b))/cpvlengthsq(delta));
 return cpvadd(b, cpvmult(delta, t));
}







// void cpSpaceEachBody_b(cpSpace *space, void (^block)(cpBody *body));
// void cpSpaceEachShape_b(cpSpace *space, void (^block)(cpShape *shape));
// void cpSpaceEachConstraint_b(cpSpace *space, void (^block)(cpConstraint *constraint));

// void cpBodyEachShape_b(cpBody *body, void (^block)(cpShape *shape));
// void cpBodyEachConstraint_b(cpBody *body, void (^block)(cpConstraint *constraint));
// void cpBodyEachArbiter_b(cpBody *body, void (^block)(cpArbiter *arbiter));

// typedef void (^cpSpacePointQueryBlock)(cpShape *shape, cpVect point, cpFloat distance, cpVect gradient);
// void cpSpacePointQuery_b(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpSpacePointQueryBlock block);

// typedef void (^cpSpaceSegmentQueryBlock)(cpShape *shape, cpVect point, cpVect normal, cpFloat alpha);
// void cpSpaceSegmentQuery_b(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSpaceSegmentQueryBlock block);

// typedef void (^cpSpaceBBQueryBlock)(cpShape *shape);
// void cpSpaceBBQuery_b(cpSpace *space, cpBB bb, cpShapeFilter filter, cpSpaceBBQueryBlock block);

// typedef void (^cpSpaceShapeQueryBlock)(cpShape *shape, cpContactPointSet *points);
// cpBool cpSpaceShapeQuery_b(cpSpace *space, cpShape *shape, cpSpaceShapeQueryBlock block);


]])

chipmunk = ffi.load(lwlgl.libs.chipmunk[2])

end

function load_assimp()

ffi.cdef([[




    typedef float ai_real;
    typedef signed int ai_int;
    typedef unsigned int ai_uint;



struct aiVector3D {
    ai_real x, y, z;
};



struct aiVector2D {
    ai_real x, y;
};




struct aiColor4D {
    ai_real r, g, b, a;
};
struct aiMatrix3x3 {
    ai_real a1, a2, a3;
    ai_real b1, b2, b3;
    ai_real c1, c2, c3;
};
struct aiMatrix4x4 {
    ai_real a1, a2, a3, a4;
    ai_real b1, b2, b3, b4;
    ai_real c1, c2, c3, c4;
    ai_real d1, d2, d3, d4;
};
struct aiQuaternion {
    ai_real w, x, y, z;
};
struct aiPlane
{
    ai_real a,b,c,d;
};




struct aiRay
{
    struct aiVector3D pos, dir;
};




struct aiColor3D
{
    ai_real r, g, b;
};
struct aiString
{
    size_t length;


    char data[1024];
} ;






typedef enum aiReturn
{

    aiReturn_SUCCESS = 0x0,


    aiReturn_FAILURE = -0x1,




    aiReturn_OUTOFMEMORY = -0x3,




    _AI_ENFORCE_ENUM_SIZE = 0x7fffffff


} aiReturn;
enum aiOrigin
{

    aiOrigin_SET = 0x0,


    aiOrigin_CUR = 0x1,


    aiOrigin_END = 0x2,




    _AI_ORIGIN_ENFORCE_ENUM_SIZE = 0x7fffffff


};






enum aiDefaultLogStream
{

    aiDefaultLogStream_FILE = 0x1,


    aiDefaultLogStream_STDOUT = 0x2,


    aiDefaultLogStream_STDERR = 0x4,




    aiDefaultLogStream_DEBUGGER = 0x8,




    _AI_DLS_ENFORCE_ENUM_SIZE = 0x7fffffff

};
struct aiMemoryInfo
{
    unsigned int textures;


    unsigned int materials;


    unsigned int meshes;


    unsigned int nodes;


    unsigned int animations;


    unsigned int cameras;


    unsigned int lights;


    unsigned int total;
};














struct aiScene;
struct aiNode;
struct aiMaterial;
struct aiTexture;
struct aiCamera;
struct aiLight;
struct aiMetadata;
struct aiBone;
struct aiMesh;
struct aiAnimation;
struct aiNodeAnim;



struct aiVectorKey
{

    double mTime;


    struct aiVector3D mValue;
};




struct aiQuatKey
{

    double mTime;


    struct aiQuaternion mValue;
};



struct aiMeshKey
{

    double mTime;





    unsigned int mValue;
};



struct aiMeshMorphKey
{

    double mTime;


    unsigned int *mValues;
    double *mWeights;


    unsigned int mNumValuesAndWeights;
};





enum aiAnimBehaviour
{

    aiAnimBehaviour_DEFAULT = 0x0,


    aiAnimBehaviour_CONSTANT = 0x1,



    aiAnimBehaviour_LINEAR = 0x2,





    aiAnimBehaviour_REPEAT = 0x3,




    _aiAnimBehaviour_Force32Bit = 2147483647

};
struct aiNodeAnim {


    struct aiString mNodeName;


    unsigned int mNumPositionKeys;






    struct aiVectorKey* mPositionKeys;


    unsigned int mNumRotationKeys;







    struct aiQuatKey* mRotationKeys;


    unsigned int mNumScalingKeys;






    struct aiVectorKey* mScalingKeys;






    enum aiAnimBehaviour mPreState;






    enum aiAnimBehaviour mPostState;
};







struct aiMeshAnim
{




    struct aiString mName;


    unsigned int mNumKeys;


    struct aiMeshKey* mKeys;
};



struct aiMeshMorphAnim
{




    struct aiString mName;


    unsigned int mNumKeys;


    struct aiMeshMorphKey* mKeys;
};




struct aiAnimation {



    struct aiString mName;


    double mDuration;


    double mTicksPerSecond;



    unsigned int mNumChannels;



    struct aiNodeAnim** mChannels;




    unsigned int mNumMeshChannels;



    struct aiMeshAnim** mMeshChannels;



    unsigned int mNumMorphMeshChannels;



    struct aiMeshMorphAnim **mMorphMeshChannels;
};
struct aiCamera
{






    struct aiString mName;






    struct aiVector3D mPosition;
    struct aiVector3D mUp;
    struct aiVector3D mLookAt;
    float mHorizontalFOV;






    float mClipPlaneNear;
    float mClipPlaneFar;
    float mAspect;
};
struct aiScene;
struct aiFileIO;






struct aiExportFormatDesc
{



    const char* id;



    const char* description;


    const char* fileExtension;
};






size_t aiGetExportFormatCount(void);
const struct aiExportFormatDesc* aiGetExportFormatDescription( size_t pIndex);






void aiReleaseExportFormatDescription( const struct aiExportFormatDesc *desc );
void aiCopyScene(const struct aiScene* pIn,
    struct aiScene** pOut);




void aiFreeScene(const struct aiScene* pIn);
aiReturn aiExportScene( const struct aiScene* pScene,
    const char* pFormatId,
    const char* pFileName,
    unsigned int pPreprocessing);
aiReturn aiExportSceneEx( const struct aiScene* pScene,
    const char* pFormatId,
    const char* pFileName,
    struct aiFileIO* pIO,
    unsigned int pPreprocessing );
struct aiExportDataBlob
{

    size_t size;


    void* data;
    struct aiString name;


    struct aiExportDataBlob * next;
};
const struct aiExportDataBlob* aiExportSceneToBlob( const struct aiScene* pScene, const char* pFormatId, unsigned int pPreprocessing );







void aiReleaseExportBlob( const struct aiExportDataBlob* pData );
struct aiFileIO;
struct aiFile;


typedef size_t (*aiFileWriteProc) (struct aiFile*, const char*, size_t, size_t);
typedef size_t (*aiFileReadProc) (struct aiFile*, char*, size_t,size_t);
typedef size_t (*aiFileTellProc) (struct aiFile*);
typedef void (*aiFileFlushProc) (struct aiFile*);
typedef enum aiReturn (*aiFileSeek) (struct aiFile*, size_t, enum aiOrigin);


typedef struct aiFile* (*aiFileOpenProc) (struct aiFileIO*, const char*, const char*);
typedef void (*aiFileCloseProc) (struct aiFileIO*, struct aiFile*);


typedef char* aiUserData;
struct aiFileIO
{


    aiFileOpenProc OpenProc;



    aiFileCloseProc CloseProc;


    aiUserData UserData;
};
struct aiFile
{

    aiFileReadProc ReadProc;


    aiFileWriteProc WriteProc;




    aiFileTellProc TellProc;




    aiFileTellProc FileSizeProc;




    aiFileSeek SeekProc;



    aiFileFlushProc FlushProc;



    aiUserData UserData;
};
enum aiImporterFlags
{


    aiImporterFlags_SupportTextFlavour = 0x1,



    aiImporterFlags_SupportBinaryFlavour = 0x2,



    aiImporterFlags_SupportCompressedFlavour = 0x4,





    aiImporterFlags_LimitedSupport = 0x8,





    aiImporterFlags_Experimental = 0x10
};
struct aiImporterDesc
{

    const char* mName;


    const char* mAuthor;


    const char* mMaintainer;


    const char* mComments;



    unsigned int mFlags;




    unsigned int mMinMajor;
    unsigned int mMinMinor;







    unsigned int mMaxMajor;
    unsigned int mMaxMinor;
    const char* mFileExtensions;
};







const struct aiImporterDesc* aiGetImporterDesc( const char *extension );





struct aiScene;
struct aiFileIO;
typedef void (*aiLogStreamCallback)(const char* , char* );
struct aiLogStream
{

    aiLogStreamCallback callback;


    char* user;
};
struct aiPropertyStore { char sentinel; };


typedef int aiBool;
const struct aiScene* aiImportFile(
    const char* pFile,
    unsigned int pFlags);
const struct aiScene* aiImportFileEx(
    const char* pFile,
    unsigned int pFlags,
    struct aiFileIO* pFS);
const struct aiScene* aiImportFileExWithProperties(
    const char* pFile,
    unsigned int pFlags,
    struct aiFileIO* pFS,
    const struct aiPropertyStore* pProps);
const struct aiScene* aiImportFileFromMemory(
    const char* pBuffer,
    unsigned int pLength,
    unsigned int pFlags,
    const char* pHint);
const struct aiScene* aiImportFileFromMemoryWithProperties(
    const char* pBuffer,
    unsigned int pLength,
    unsigned int pFlags,
    const char* pHint,
    const struct aiPropertyStore* pProps);
const struct aiScene* aiApplyPostProcessing(
    const struct aiScene* pScene,
    unsigned int pFlags);
struct aiLogStream aiGetPredefinedLogStream(
    enum aiDefaultLogStream pStreams,
    const char* file);
void aiAttachLogStream(
    const struct aiLogStream* stream);
void aiEnableVerboseLogging(aiBool d);
enum aiReturn aiDetachLogStream(
    const struct aiLogStream* stream);
void aiDetachAllLogStreams(void);







void aiReleaseImport(
    const struct aiScene* pScene);
const char* aiGetErrorString(void);
aiBool aiIsExtensionSupported(
    const char* szExtension);
void aiGetExtensionList(
    struct aiString* szOut);






void aiGetMemoryRequirements(
    const struct aiScene* pIn,
    struct aiMemoryInfo* in);
struct aiPropertyStore* aiCreatePropertyStore(void);





void aiReleasePropertyStore(struct aiPropertyStore* p);
void aiSetImportPropertyInteger(
    struct aiPropertyStore* store,
    const char* szName,
    int value);
void aiSetImportPropertyFloat(
    struct aiPropertyStore* store,
    const char* szName,
    ai_real value);
void aiSetImportPropertyString(
    struct aiPropertyStore* store,
    const char* szName,
    const struct aiString* st);
void aiSetImportPropertyMatrix(
    struct aiPropertyStore* store,
    const char* szName,
    const struct aiMatrix4x4* mat);







void aiCreateQuaternionFromMatrix(
    struct aiQuaternion* quat,
    const struct aiMatrix3x3* mat);
void aiDecomposeMatrix(
    const struct aiMatrix4x4* mat,
    struct aiVector3D* scaling,
    struct aiQuaternion* rotation,
    struct aiVector3D* position);





void aiTransposeMatrix4(
    struct aiMatrix4x4* mat);





void aiTransposeMatrix3(
    struct aiMatrix3x3* mat);






void aiTransformVecByMatrix3(
    struct aiVector3D* vec,
    const struct aiMatrix3x3* mat);






void aiTransformVecByMatrix4(
    struct aiVector3D* vec,
    const struct aiMatrix4x4* mat);






void aiMultiplyMatrix4(
    struct aiMatrix4x4* dst,
    const struct aiMatrix4x4* src);






void aiMultiplyMatrix3(
    struct aiMatrix3x3* dst,
    const struct aiMatrix3x3* src);





void aiIdentityMatrix3(
    struct aiMatrix3x3* mat);





void aiIdentityMatrix4(
    struct aiMatrix4x4* mat);





size_t aiGetImportFormatCount(void);
const struct aiImporterDesc* aiGetImportFormatDescription( size_t pIndex);




enum aiLightSourceType
{
    aiLightSource_UNDEFINED = 0x0,




    aiLightSource_DIRECTIONAL = 0x1,




    aiLightSource_POINT = 0x2,





    aiLightSource_SPOT = 0x3,






    aiLightSource_AMBIENT = 0x4,




    aiLightSource_AREA = 0x5,





    _aiLightSource_Force32Bit = 2147483647

};
struct aiLight
{






    struct aiString mName;





    enum aiLightSourceType mType;






    struct aiVector3D mPosition;







    struct aiVector3D mDirection;







    struct aiVector3D mUp;
    float mAttenuationConstant;
    float mAttenuationLinear;
    float mAttenuationQuadratic;







    struct aiColor3D mColorDiffuse;







    struct aiColor3D mColorSpecular;
    struct aiColor3D mColorAmbient;







    float mAngleInnerCone;
    float mAngleOuterCone;


    struct aiVector2D mSize;
};
enum aiTextureOp
{

    aiTextureOp_Multiply = 0x0,


    aiTextureOp_Add = 0x1,


    aiTextureOp_Subtract = 0x2,


    aiTextureOp_Divide = 0x3,


    aiTextureOp_SmoothAdd = 0x4,


    aiTextureOp_SignedAdd = 0x5,



    _aiTextureOp_Force32Bit = 2147483647

};






enum aiTextureMapMode
{


    aiTextureMapMode_Wrap = 0x0,




    aiTextureMapMode_Clamp = 0x1,




    aiTextureMapMode_Decal = 0x3,




    aiTextureMapMode_Mirror = 0x2,


    _aiTextureMapMode_Force32Bit = 2147483647

};
enum aiTextureMapping
{






    aiTextureMapping_UV = 0x0,


    aiTextureMapping_SPHERE = 0x1,


    aiTextureMapping_CYLINDER = 0x2,


    aiTextureMapping_BOX = 0x3,


    aiTextureMapping_PLANE = 0x4,


    aiTextureMapping_OTHER = 0x5,



    _aiTextureMapping_Force32Bit = 2147483647

};
enum aiTextureType
{






    aiTextureType_NONE = 0x0,






    aiTextureType_DIFFUSE = 0x1,




    aiTextureType_SPECULAR = 0x2,




    aiTextureType_AMBIENT = 0x3,




    aiTextureType_EMISSIVE = 0x4,






    aiTextureType_HEIGHT = 0x5,







    aiTextureType_NORMALS = 0x6,
    aiTextureType_SHININESS = 0x7,






    aiTextureType_OPACITY = 0x8,






    aiTextureType_DISPLACEMENT = 0x9,
    aiTextureType_LIGHTMAP = 0xA,






    aiTextureType_REFLECTION = 0xB,







    aiTextureType_UNKNOWN = 0xC,



    _aiTextureType_Force32Bit = 2147483647

};
enum aiShadingMode
{



    aiShadingMode_Flat = 0x1,



    aiShadingMode_Gouraud = 0x2,



    aiShadingMode_Phong = 0x3,



    aiShadingMode_Blinn = 0x4,





    aiShadingMode_Toon = 0x5,






    aiShadingMode_OrenNayar = 0x6,






    aiShadingMode_Minnaert = 0x7,





    aiShadingMode_CookTorrance = 0x8,



    aiShadingMode_NoShading = 0x9,



    aiShadingMode_Fresnel = 0xa,



    _aiShadingMode_Force32Bit = 2147483647

};
enum aiTextureFlags
{


    aiTextureFlags_Invert = 0x1,
    aiTextureFlags_UseAlpha = 0x2,






    aiTextureFlags_IgnoreAlpha = 0x4,


      _aiTextureFlags_Force32Bit = 2147483647

};
enum aiBlendMode
{






    aiBlendMode_Default = 0x0,
    aiBlendMode_Additive = 0x1,





    _aiBlendMode_Force32Bit = 2147483647

};



struct aiUVTransform
{




    struct aiVector2D mTranslation;





    struct aiVector2D mScaling;







    ai_real mRotation;
} __attribute__((__packed__));








enum aiPropertyTypeInfo
{






    aiPTI_Float = 0x1,







    aiPTI_Double = 0x2,






    aiPTI_String = 0x3,







    aiPTI_Integer = 0x4,




    aiPTI_Buffer = 0x5,






     _aiPTI_Force32Bit = 2147483647

};
struct aiMaterialProperty
{



    struct aiString mKey;





    unsigned int mSemantic;




    unsigned int mIndex;




    unsigned int mDataLength;
    enum aiPropertyTypeInfo mType;




    char* mData;
};
struct aiMaterial

{
    struct aiMaterialProperty** mProperties;


    unsigned int mNumProperties;


    unsigned int mNumAllocated;
};
enum aiReturn aiGetMaterialProperty(
    const struct aiMaterial* pMat,
    const char* pKey,
    unsigned int type,
    unsigned int index,
    const struct aiMaterialProperty** pPropOut);
enum aiReturn aiGetMaterialFloatArray(
    const struct aiMaterial* pMat,
    const char* pKey,
    unsigned int type,
    unsigned int index,
    ai_real* pOut,
    unsigned int* pMax);
enum aiReturn aiGetMaterialIntegerArray(const struct aiMaterial* pMat,
     const char* pKey,
     unsigned int type,
     unsigned int index,
     int* pOut,
     unsigned int* pMax);
enum aiReturn aiGetMaterialColor(const struct aiMaterial* pMat,
    const char* pKey,
    unsigned int type,
    unsigned int index,
    struct aiColor4D* pOut);







enum aiReturn aiGetMaterialUVTransform(const struct aiMaterial* pMat,
    const char* pKey,
    unsigned int type,
    unsigned int index,
    struct aiUVTransform* pOut);







enum aiReturn aiGetMaterialString(const struct aiMaterial* pMat,
    const char* pKey,
    unsigned int type,
    unsigned int index,
    struct aiString* pOut);
unsigned int aiGetMaterialTextureCount(const struct aiMaterial* pMat,
    enum aiTextureType type);
enum aiReturn aiGetMaterialTexture(const struct aiMaterial* mat,
    enum aiTextureType type,
    unsigned int index,
    struct aiString* path,
    enum aiTextureMapping* mapping ,
    unsigned int* uvindex ,
    ai_real* blend ,
    enum aiTextureOp* op ,
    enum aiTextureMapMode* mapmode ,
    unsigned int* flags );






















































struct aiFace
{


    unsigned int mNumIndices;


    unsigned int* mIndices;
};





struct aiVertexWeight
{

    unsigned int mVertexId;



    float mWeight;
};
struct aiBone
{

    struct aiString mName;



    unsigned int mNumWeights;


    struct aiVertexWeight* mWeights;


    struct aiMatrix4x4 mOffsetMatrix;
};
enum aiPrimitiveType
{





    aiPrimitiveType_POINT = 0x1,






    aiPrimitiveType_LINE = 0x2,





    aiPrimitiveType_TRIANGLE = 0x4,
    aiPrimitiveType_POLYGON = 0x8,






    _aiPrimitiveType_Force32Bit = 2147483647

};
struct aiAnimMesh
{






    struct aiVector3D* mVertices;


    struct aiVector3D* mNormals;


    struct aiVector3D* mTangents;


    struct aiVector3D* mBitangents;


    struct aiColor4D* mColors[0x8];


    struct aiVector3D* mTextureCoords[0x8];
    unsigned int mNumVertices;




    float mWeight;
};




enum aiMorphingMethod
{

    aiMorphingMethod_VERTEX_BLEND = 0x1,


    aiMorphingMethod_MORPH_NORMALIZED = 0x2,


    aiMorphingMethod_MORPH_RELATIVE = 0x3,





    _aiMorphingMethod_Force32Bit = 2147483647

};
struct aiMesh
{





    unsigned int mPrimitiveTypes;





    unsigned int mNumVertices;





    unsigned int mNumFaces;





    struct aiVector3D* mVertices;
    struct aiVector3D* mNormals;
    struct aiVector3D* mTangents;
    struct aiVector3D* mBitangents;






    struct aiColor4D* mColors[0x8];





    struct aiVector3D* mTextureCoords[0x8];
    unsigned int mNumUVComponents[0x8];







    struct aiFace* mFaces;




    unsigned int mNumBones;





    struct aiBone** mBones;






    unsigned int mMaterialIndex;
    struct aiString mName;



    unsigned int mNumAnimMeshes;





    struct aiAnimMesh** mAnimMeshes;




    unsigned int mMethod;
};








typedef enum aiMetadataType {
    AI_BOOL = 0,
    AI_INT32 = 1,
    AI_UINT64 = 2,
    AI_FLOAT = 3,
    AI_DOUBLE = 4,
    AI_AISTRING = 5,
    AI_AIVECTOR3D = 6,


    FORCE_32BIT = 2147483647

} aiMetadataType;
struct aiMetadataEntry {
    aiMetadataType mType;
    void* mData;
};
struct aiMetadata {

    unsigned int mNumProperties;


    struct aiString* mKeys;



    struct aiMetadataEntry* mValues;
};
enum aiPostProcessSteps
{
    aiProcess_CalcTangentSpace = 0x1,
    aiProcess_JoinIdenticalVertices = 0x2,
    aiProcess_MakeLeftHanded = 0x4,
    aiProcess_Triangulate = 0x8,
    aiProcess_RemoveComponent = 0x10,
    aiProcess_GenNormals = 0x20,
    aiProcess_GenSmoothNormals = 0x40,
    aiProcess_SplitLargeMeshes = 0x80,
    aiProcess_PreTransformVertices = 0x100,
    aiProcess_LimitBoneWeights = 0x200,
    aiProcess_ValidateDataStructure = 0x400,
    aiProcess_ImproveCacheLocality = 0x800,
    aiProcess_RemoveRedundantMaterials = 0x1000,
    aiProcess_FixInfacingNormals = 0x2000,
    aiProcess_SortByPType = 0x8000,
    aiProcess_FindDegenerates = 0x10000,
    aiProcess_FindInvalidData = 0x20000,
    aiProcess_GenUVCoords = 0x40000,
    aiProcess_TransformUVCoords = 0x80000,
    aiProcess_FindInstances = 0x100000,
    aiProcess_OptimizeMeshes = 0x200000,
    aiProcess_OptimizeGraph = 0x400000,
    aiProcess_FlipUVs = 0x800000,
    aiProcess_FlipWindingOrder = 0x1000000,





    aiProcess_SplitByBoneCount = 0x2000000,
    aiProcess_Debone = 0x4000000,
    aiProcess_GlobalScale = 0x8000000




};








struct aiTexel
{
    unsigned char b,g,r,a;
} __attribute__((__packed__));


struct aiTexture
{






    unsigned int mWidth;






    unsigned int mHeight;
    char achFormatHint[9];
    struct aiTexel* pcData;
};
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wattributes"
struct aiNode
{
    struct aiString mName;


    struct aiMatrix4x4 mTransformation;


    struct aiNode* mParent;


    unsigned int mNumChildren;


    struct aiNode** mChildren;


    unsigned int mNumMeshes;




    unsigned int* mMeshes;






    struct aiMetadata* mMetaData;
};


#pragma GCC diagnostic pop
struct aiScene
{





    unsigned int mFlags;
    struct aiNode* mRootNode;


    unsigned int mNumMeshes;
    struct aiMesh** mMeshes;


    unsigned int mNumMaterials;
    struct aiMaterial** mMaterials;


    unsigned int mNumAnimations;






    struct aiAnimation** mAnimations;


    unsigned int mNumTextures;







    struct aiTexture** mTextures;




    unsigned int mNumLights;






    struct aiLight** mLights;




    unsigned int mNumCameras;
    struct aiCamera** mCameras;
    char* mPrivate;


};






const char* aiGetLegalString (void);






unsigned int aiGetVersionMinor (void);






unsigned int aiGetVersionMajor (void);






unsigned int aiGetVersionRevision (void);
unsigned int aiGetCompileFlags (void);

]])

assimp = ffi.load(lwlgl.libs.assimp[2])

end

function load_collision()

-- Written by Rabia Alhaffar in 2/August/2020
-- Collision detection library,Feel free to use it without problems!
math = require("math")

collision = {

    rect = function(r1, r2)
        return r1.x < r2.x + r2.w and r1.x + r1.w > r2.x and r1.y < r2.y + r2.h and r1.y + r1.h > r2.y
    end,
	
    circle = function(c1, c2)
        return math.sqrt((c1.x - c2.x * c1.x - c2.x) + (c1.y + c2.y * c1.y + c2.y)) < c1.r + c2.r
    end,
	
    circle_rect = function(c, r)
        if math.abs(c.x - r.x - r.w / 2) > (r.w / 2 + c.r) or math.abs(c.y - r.y - r.h / 2) > (r.h / 2 + c.r) then return false end
        if math.abs(c.x - r.x - r.w / 2) <= (r.w / 2) or math.abs(c.y - r.y - r.h / 2) <= (r.h / 2) then return true end
        return math.abs(c.x - r.x - r.w / 2) - r.w / 2 * math.abs(c.x - r.x - r.w / 2) - r.w / 2 + abs(r.y - c.y - r.h / 2) - r.h / 2 * abs(c.y - r.y - r.h / 2) - r.h / 2 <= math.pow(c.r, 2)
    end,
	
    circle_line = function(c, l)
        dist = 0
        u = ((c.x - l.x1) * (l.x2 - l.x1) + (c.y - l.y1) * (l.y2 - l.y1)) / ((l.y2 - l.y1) * (l.y2 - l.y1) + (l.x2 - l.x1) * (l.x2 - l.x1))
        if u >= 0 and u <= 1 then
            dist = math.pow((l.x1 + (l.x2 - l.x1) * u - c.x), 2) + math.pow((l.y1 + (l.y2 - l.y1) * u - c.y), 2)
        else
            if u < 0 then
                dist = math.pow((l.x1 - c.x), 2) + math.pow((l.y1 - c.y), 2)
            else
                dist = math.pow((l.x2 - c.x), 2) + math.pow((l.y2 - c.y), 2)
		    end
	    end
        return dist < math.pow(c.r, 2)
	end,

    cube = function(c1, c2)
        if math.abs(c1.x - c2.x) < c1.s + c2.s then
            if math.abs(c1.y - c2.y) < c1.s + c2.s then
                if math.abs(c1.z - c2.z) < c1.s + c2.s then
                    return true
				end
			end
        else
            return false
		end
	end,
	
    cuboid = function(c1, c2)
        if math.abs(c1.x - c2.x) < c1.w + c2.w then
            if math.abs(c1.y - c2.y) < c1.h + c2.h then
                if math.abs(c1.z - c2.z) < c1.l + c2.l then
                    return true
				end
			end
        else
            return false
		end
    end,

    sphere = function(s1, s2)
        d = math.sqrt((s1.x - s2.x) * (s1.x - s2.x) + (s1.y - s2.y) * (s1.y - s2.y) + (s1.z - s2.z) * (s1.z - s2.z))
        return d < (s1.size + s2.size)
	end,
	
    sphere_cube = function(s, c)

        if math.abs(s.x - c.x) >= (c.w + s.size) then return false end
        if math.abs(s.y - c.y) >= (c.h + s.size) then return false end
        if math.abs(s.z - c.z) >= (c.l + s.size) then return false end

        if math.abs(s.x - c.x) < c.w then return true end 
        if math.abs(s.y - c.y) < c.h then return true end
        if math.abs(s.z - c.z) < c.l then return true end

        d = ((math.abs(s.x - c.x) - c.w) * (math.abs(s.x - c.x) - c.w)) + ((math.abs(s.y - c.y) - c.h) * (math.abs(s.y - c.y) - c.h)) + ((math.abs(s.z - c.z) - c.l) * (math.abs(s.z - c.z) - c.l))

        return d < math.pow(s.size, 2)
    end
}

end

lwlgl.init = function()
    load_gl()
    load_glu()
    load_glut()
    load_sdl()
    load_sdl_sound()
    load_vulkan()
    load_devil()
    load_freetype()
    load_al()
    load_cl()
    load_physicsfs()
    load_chipmunk()
    load_assimp()
    load_collision()
end