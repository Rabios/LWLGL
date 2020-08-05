# API

### Bindings variables

> NOTES: See getting started page here if you don't know how to use LWLGL

Here are the variables you can call functions from

```lua
-- OpenGL
gl                           -- OpenGL bindings variable
glu                          -- GLU bindings variable
glut                         -- GLUT bindings variable

-- OpenAL
al                           -- OpenAL bindings variable

-- Vulkan
vk                           -- Vulkan bindings variable

-- SDL 2
sdl                          -- SDL2 bindings variable
sdl_sound                    -- SDL_sound bindings variable

-- Other
assimp                       -- Assimp bindings variable
chipmunk                     -- Chipmunk bindings variable
il                           -- DevIL bindings variable
ft                           -- FreeType bindings variable
physfs                       --
cl                           -- OpenCL bindings variable
```

### LWLGL

> NOTES: Don't care about source code load directory if you use build,Only care about dll load path (Second value in each directory array table).

```lua
-- Variables
UINT64_MAX                          -- 0xFFFFFFFFFFFFFFFFULL
MAX_COORD                           -- GLU_TESS_MAX_COORD (9.9999999999999998e+149)
SDL_INIT_EVERYTHING                 -- Same as SDL_INIT_EVERYTHING in C
SDL_WINDOWPOS_CENTERED              -- Same as SDL_WINDOWPOS_CENTERED in C
SDL_WINDOWPOS_UNDEFINED             -- Same as SDL_WINDOWPOS_UNDEFINED in C
SDL_WINDOWPOS_ISCENTERED(x)         -- Same as SDL_WINDOWPOS_ISCENTERED(X)
SDL_WINDOWPOS_ISUNDEFINED(x)        -- Same as SDL_WINDOWPOS_ISUNDEFINED(X)
SDL_WINDOWPOS_CENTERED_DISPLAY(x)   -- Same as SDL_WINDOWPOS_CENTERED_DISPLAY
SDL_WINDOWPOS_UNDEFINED_DISPLAY(x)  -- Same as SDL_WINDOWPOS_UNDEFINED_DISPLAY

-- LWLGL
lwlgl = {
    version = "v0.0.1",                                        -- Version
	author = "Rabia Alhaffar",                                 -- Author
	libs = {
	    -- Directories
	    gl = { "gl.lua", "bin/opengl32" },                     -- OpenGL load directory (source, dll)
		glu = { "glu.lua", "bin/glu32" },                      -- GLU load directory (source, dll)
		glut = { "glut.lua", "bin/freeglut" },                 -- GLUT load directory (source, dll)
		sdl = { "sdl2.lua", "bin/SDL2" },                      -- SDL 2 load directory (source, dll)
		sdl_sound = { "sdl_sound.lua", "bin/SDL_sound" },      -- SDL_sound load directory (source, dll)
		vulkan = { "vulkan.lua", "bin/vulkan-1" },             -- Vulkan load directory (source, dll)
		devil = { "devil.lua", "bin/DevIL" },                  -- DevIL load directory (source, dll)
		freetype = { "freetype.lua", "bin/freetype" },         -- FreeType load directory (source, dll)
		al = { "al.lua", "bin/OpenAL32" },                     -- OpenAL load directory (source, dll)
		cl = { "cl.lua", "bin/OpenCL" },                       -- OpenCL load directory (source, dll)
		physicsfs = { "physicsfs.lua", "bin/physfs" },         -- PhysicsFS load directory (source, dll)
		chipmunk = { "chipmunk.lua", "bin/chipmunk" },         -- Chipmunk load directory (source, dll)
		assimp = { "assimp.lua", "bin/assimp" }                -- Assimp load directory (source, dll)
	}
}

lwlgl.init()           -- Initialize LWLGL and loads all libs from paths
glut_init()            -- Initializes GLUT,You need to do it before using GLUT

-- Loading libs functions
-- NOTES: Use lwlgl.init() to load all of them if you don't want to waste lines of code loading libs.
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
```

### Vulkan utilities API

```lua
vku.VK_LOD_CLAMP_NONE = 1000.0
vku.VK_WHOLE_SIZE     = 0xFFFFFFFFFFFFFFFFULL
vku.getStructEnum(name)                -- Gets struct enum name
vku.newStruct(name)                    -- Creates new struct with name
vku.fillStruct(ref)                    -- Fills struct
vku.loadExtensions(getfunc, pfnstring) -- Loads vulkan extensions
```


### FreeType utilities API

```lua
-- Errors names
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

-- API wrap
freetype.tag_tostring(i)
freetype.tag(s)
freetype.new()
lib.version(library)
lib.free(library)
lib.face(library, filename, face_index)
lib.memory_face(library, data, size, face_index)
lib.open_face(library, args, face_index)
lib.ref(lib)
face.set_transform -- Same as FT_Set_Transform in C
face.char_index    -- Same as FT_Get_Char_Index in C
face.ref(face)
face.attach_file(face, filepathname)
face.attach_stream(face, parameters)
face.free(face)
face.select_size(face, strike_index)
face.request_size(face, req)
face.set_char_size(face, char_width, char_height, horz_resolution, vert_resolution)
face.set_pixel_sizes(face, pixel_width, pixel_height)
face.load_glyph(face, glyph_index, load_flags)
face.load_char(face, char_code, load_flags)
face.kerning(face, left_glyph, right_glyph, kern_mode, kerning)
face.track_kerning(face, point_size, degree, kerning)
face.glyph_name(face, glyph_index, buffer, buffer_max)
face.postscript_name(face)
face.select_charmap(face, encoding)
face.set_charmap(face, charmap)
charmap.index(charmap)
charmap.encoding_str(charmap)
face.first_char -- Same as FT_Get_First_Char in C
face.next_char  -- Same as FT_Get_Next_Char in C
face.chars(face)
face.char_count(face)
face.name_index(face, glyph_name)
face.char_variant_index(face, charcode, variantSelector)
face.char_variant_is_default(face, charcode, variantSelector)
face.variant_selectors(face)
face.variants_of_char(face, charcode)
face.chars_of_variant(face, variantSelector)
lib.bitmap(library)
lib.free_bitmap(library, bitmap)
lib.copy_bitmap(library, source, target)
lib.embolden_bitmap(library, bitmap, xStrength, yStrength)
lib.convert_bitmap(library, source, target, alignment)
slot.render(slot, render_mode)
slot.subglyph_info(glyph, sub_index, p_index, p_flags, p_arg1, p_arg2, p_transform)
slot.own_bitmap(slot)
slot.glyph(slot, glyph)
glyph.copy(source, target)
glyph.transform(glyph, matrix, delta)
glyph.to_bitmap(glyph, render_mode, origin, destroy)
glyph.cbox        -- Same as FT_Glyph_Get_CBox in C
glyph.free        -- Same as FT_Done_Glyph in C
glyph.as_bitmap(glyph)
glyph.as_outline(glyph)
lib.outline(library, numPoints, numContours)
outline.translate     -- Same as FT_Outline_Translate in C
outline.transform     -- Same as FT_Outline_Transform in C
outline.orientation   -- Same as FT_Outline_Get_Orientation in C
lib.free_outline(library, outline)
outline.decompose(outline, func_interface, userdata)
outline.check(outline)
outline.cbox(outline, cbox)
outline.copy(source, target)
outline.embolden(outline, xstrength, ystrength)
outline.reverse(outline)
lib.get_outline_bitmap(library, outline, bitmap)
lib.render_outline(library, outline, params)
-- matrix methods not included in freetype
matrix.reset()
matrix.rotate(angle)
```

### Collision library API

```lua

collision.rect(r1, r2)          -- Checks collision between 2 rectangles
collision.circle(c1, c2)        -- Checks collision between 2 circles
collision.circle_rect(c, r)     -- Checks collision between circle and rectangle
collision.circle_line(c, l)     -- Checks collision between circle and line
collision.cube(c1, c2)          -- Checks collision between 2 cubes
collision.cuboid(c1, c2)        -- Checks collision between 2 cuboids
collision.sphere(s1, s2)        -- Checks collision between 2 spheres
collision.sphere_cube(s, c)     -- Checks collision between sphere and cube

```

Example of use:

```lua
dofile("lwlgl.lua")
lwlgl.init()

r1 = { x = 100, y = 100, w = 50, h = 50 }
r2 = { x = 125, y = 125, w = 50, h = 50 }

if collision.rect(r1, r2) then print("collision!") end
```
