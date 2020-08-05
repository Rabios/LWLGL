-- https://github.com/Planimeter/lphysicsfs
-- LuaJIT FFI bindings for PhysicsFS by Planimeter on GitHub
--[[

MIT License

Copyright (c) 2017 Planimeter

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]
dofile("lwlgl.lua")
ffi = require("ffi")

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