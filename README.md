# minetest-engine-luk3yx

This is a mostly unmaintained fork of an older up to dated version of Minetest
(0.4.17.1) to add features and bugfixes from 5.0.0 before 5.0.0 was officially
released and most servers were still on 0.4.17.1. Its pretty stable and know to work, 
but isnot official also is not bug free, does not recieve support and is only for 
modern OS's that cannot connect to older servers 0.4 versions.


description
---------------

This repository is only as historical reference. A minetest 0.4.18.3 version is  build 
from this sources, mostly most of the 5.0.0 improvements were added! any mod from 
the 5.X series will be compatible with this.

A [Minetest](https://github.com/minetest/minetest) fork with backported features
and bugfixes from 5.0.0. Most of them documented here: https://github.com/minetest/minetest/pull/6746/commits 
the sources were forked as new repo from https://github.com/luk3yx/minetest

Minetest is copyright © 2010-2019 by Perttu Ahola (know as celeron55)
and contributors (see source file comments and the [version control log])

[version control log]: https://github.com/minetest/minetest/graphs/contributors

In case you downloaded the source code:
---------------------------------------

If you downloaded this Minetest Engine source code in which this file is
contained, you probably want to download the Minetest game backported (check minenux project) 
or the original (https://github.com/minetest/minetest_game/tree/stable-0.4) too.

In any case, is you use this sources must also use the backported one or the mientest minenux game for 0.4.

Table of Contents
------------------

1. [Further Documentation](#further-documentation)
2. [Default Controls](#default-controls)
3. [Paths](#paths)
4. [Configuration File](#configuration-file)
5. [Command-line Options](#command-line-options)
6. [Compiling](#compiling)
7. [Docker](#docker-stock-minetest)
8. [Version Scheme](#version-scheme)


Further documentation (on "stock" Minetest)
----------------------
- Website: http://minetest.net/ DONT ASK FOR THIS SOURCES THERE!
- Wiki: http://wiki.minetest.net/ PRETTY BASED ON LAST SOURCES
- Developer wiki: http://dev.minetest.net/ DONT ASK FOR THIS SOURCES THERE!
- Forum: http://forum.minetest.net/ DONT ASK FOR THIS SOURCES THERE!
- GitHub: https://github.com/minetest/minetest/ DONT ASK FOR THIS SOURCES THERE!
- [doc/](doc/) directory of source distribution PRETTY BASED ON LAST SOURCES

Default controls
----------------
All controls are re-bindable using settings.
Some can be changed in the key config dialog in the settings tab.

| Button                        | Action                                                         |
|-------------------------------|----------------------------------------------------------------|
| Move mouse                    | Look around                                                    |
| W, A, S, D                    | Move                                                           |
| Space                         | Jump/move up                                                   |
| Shift                         | Sneak/move down                                                |
| Q                             | Drop itemstack                                                 |
| Shift + Q                     | Drop single item                                               |
| Left mouse button             | Dig/punch/take item                                            |
| Right mouse button            | Place/use                                                      |
| Shift + right mouse button    | Build (without using)                                          |
| I                             | Inventory menu                                                 |
| Mouse wheel                   | Select item                                                    |
| 0-9                           | Select item                                                    |
| Z                             | Zoom (needs zoom privilege)                                    |
| T                             | Chat                                                           |
| /                             | Command                                                        |
| Esc                           | Pause menu/abort/exit (pauses only singleplayer game)          |
| R                             | Enable/disable full range view                                 |
| +                             | Increase view range                                            |
| -                             | Decrease view range                                            |
| K                             | Enable/disable fly mode (needs fly privilege)                  |
| L                             | Enable/disable pitch move mode                                 |
| J                             | Enable/disable fast mode (needs fast privilege)                |
| H                             | Enable/disable noclip mode (needs noclip privilege)            |
| E                             | Move fast in fast mode                                         |
| F1                            | Hide/show HUD                                                  |
| F2                            | Hide/show chat                                                 |
| F3                            | Disable/enable fog                                             |
| F4                            | Disable/enable camera update (Mapblocks are not updated anymore when disabled, disabled in release builds)  |
| F5                            | Cycle through debug information screens                        |
| F6                            | Cycle through profiler info screens                            |
| F7                            | Cycle through camera modes                                     |
| F9                            | Cycle through minimap modes                                    |
| Shift + F9                    | Change minimap orientation                                     |
| F10                           | Show/hide console                                              |
| F12                           | Take screenshot                                                |

Paths
-----

Locations:

* `bin`   - Compiled binaries to execute program
* `share` - Distributed read-only data
* `user`  - User-created modifiable data

Where each location is on each platform:

* Windows:
    * bin   = `bin`
    * share = `.`
    * user  = `.`
* Linux:
    * `bin`   = `/usr/bin`
    * `share` = `/usr/share/minetest`
    * `user`  = `~/.minetest`
* macOS:
    * `bin`   = `Contents/MacOS`
    * `share` = `Contents/Resources`
    * `user`  = `Contents/User OR ~/Library/Application Support/minetest`

Worlds can be found as separate directory in: `user/worlds/`

Configuration file:
-------------------
- Default location:
    `/etc/minetest/minetest.conf`
- For `RUN_IN_PLACE` It is created by Minetest at first run:
    `user/minetest.conf`
- A specific file can be specified on the command line:
    `--config <path-to-file>`
- A run-in-place build will look for the configuration file in
    `bin/../minetest.conf` and also `bin/../../minetest.conf`

Command-line options:
---------------------
- Use `--help`

Compiling
---------

This compilation requires GIT.

#### Dependencies

| Dependency | Version | Original | Commentary |
|------------|---------|----------|------------|
| GCC        | 4.9+    | 4.5+     | Can be replaced with Clang 3.4+ |
| CMake      | 2.6+    | 2.6+     |            |
| Irrlicht   | 1.8.1+  | 1.7.3+   |            |
| SQLite3    | 3.0+    | 3.0+     |            |
| LuaJIT     | 2.0+    | 2.0+     | Bundled Lua 5.1 is used if not present |
| GMP        | 5.0.0+  | 4.9.9    | Bundled mini-GMP is used if not present |
| JsonCPP    | 1.0.0+  | 1.0.0+   | Bundled JsonCPP is used if not present |

#### Download

Download source (this is the URL to the latest of source repository, which might not work at all times) using Git:

    git clone --depth 1 https://github.com/luk3yx/minetest.git
    cd minetest

Download minetest_game (otherwise only the "Minimal development test" game is available) using Git:

    git clone --depth 1 https://github.com/luk3yx/minetest_game.git games/minetest_game

Download source, without using Git:

    wget https://github.com/luk3yx/minetest/archive/master.tar.gz
    tar xf master.tar.gz
    cd minetest-master

Download minetest_game, without using Git:

    cd games/
    wget https://github.com/luk3yx/minetest_game/archive/master.tar.gz
    tar xf master.tar.gz
    mv minetest_game-master minetest_game
    cd ..

#### Build

Build a version that runs directly from the source directory:

    cmake . -DRUN_IN_PLACE=TRUE
    make -j <number of processors>

Run it:

    ./bin/minetest

- Use `cmake . -LH` to see all CMake options and their current state
- If you want to install it system-wide (or are making a distribution package),
  you will want to use `-DRUN_IN_PLACE=FALSE`
- You can build a bare server by specifying `-DBUILD_SERVER=TRUE`
- You can disable the client build by specifying `-DBUILD_CLIENT=FALSE`
- You can select between Release and Debug build by `-DCMAKE_BUILD_TYPE=<Debug or Release>`
  - Debug build is slower, but gives much more useful output in a debugger
- If you build a bare server, you don't need to have Irrlicht installed.
  - In that case use `-DIRRLICHT_SOURCE_DIR=/the/irrlicht/source`

### CMake options

General options and their default values:

    BUILD_CLIENT=TRUE          - Build Minetest client
    BUILD_SERVER=FALSE         - Build Minetest server
    CMAKE_BUILD_TYPE=Release   - Type of build (Release vs. Debug)
        Release                - Release build
        Debug                  - Debug build
        SemiDebug              - Partially optimized debug build
        RelWithDebInfo         - Release build with debug information
        MinSizeRel             - Release build with -Os passed to compiler to make executable as small as possible
    ENABLE_CURL=ON             - Build with cURL; Enables use of online mod repo, public serverlist and remote media fetching via http
    ENABLE_CURSES=ON           - Build with (n)curses; Enables a server side terminal (command line option: --terminal)
    ENABLE_FREETYPE=ON         - Build with FreeType2; Allows using TTF fonts
    ENABLE_GETTEXT=ON          - Build with Gettext; Allows using translations
    ENABLE_GLES=OFF            - Search for Open GLES headers & libraries and use them
    ENABLE_LEVELDB=ON          - Build with LevelDB; Enables use of LevelDB map backend
    ENABLE_POSTGRESQL=ON       - Build with libpq; Enables use of PostgreSQL map backend (PostgreSQL 9.5 or greater recommended)
    ENABLE_REDIS=ON            - Build with libhiredis; Enables use of Redis map backend
    ENABLE_SPATIAL=ON          - Build with LibSpatial; Speeds up AreaStores
    ENABLE_SOUND=ON            - Build with OpenAL, libogg & libvorbis; in-game sounds
    ENABLE_LUAJIT=ON           - Build with LuaJIT (much faster than non-JIT Lua)
    ENABLE_SYSTEM_GMP=ON       - Use GMP from system (much faster than bundled mini-gmp)
    ENABLE_SYSTEM_JSONCPP=OFF  - Use JsonCPP from system
    OPENGL_GL_PREFERENCE=LEGACY - Linux client build only; See CMake Policy CMP0072 for reference
    RUN_IN_PLACE=FALSE         - Create a portable install (worlds, settings etc. in current directory)
    USE_GPROF=FALSE            - Enable profiling using GProf
    VERSION_EXTRA=             - Text to append to version (e.g. VERSION_EXTRA=foobar -> Minetest 0.4.9-foobar)

Library specific options:

    BZIP2_INCLUDE_DIR               - Linux only; directory where bzlib.h is located
    BZIP2_LIBRARY                   - Linux only; path to libbz2.a/libbz2.so
    CURL_DLL                        - Only if building with cURL on Windows; path to libcurl.dll
    CURL_INCLUDE_DIR                - Only if building with cURL; directory where curl.h is located
    CURL_LIBRARY                    - Only if building with cURL; path to libcurl.a/libcurl.so/libcurl.lib
    EGL_INCLUDE_DIR                 - Only if building with GLES; directory that contains egl.h
    EGL_LIBRARY                     - Only if building with GLES; path to libEGL.a/libEGL.so
    FREETYPE_INCLUDE_DIR_freetype2  - Only if building with FreeType 2; directory that contains an freetype directory with files such as ftimage.h in it
    FREETYPE_INCLUDE_DIR_ft2build   - Only if building with FreeType 2; directory that contains ft2build.h
    FREETYPE_LIBRARY                - Only if building with FreeType 2; path to libfreetype.a/libfreetype.so/freetype.lib
    FREETYPE_DLL                    - Only if building with FreeType 2 on Windows; path to libfreetype.dll
    GETTEXT_DLL                     - Only when building with gettext on Windows; path to libintl3.dll
    GETTEXT_ICONV_DLL               - Only when building with gettext on Windows; path to libiconv2.dll
    GETTEXT_INCLUDE_DIR             - Only when building with gettext; directory that contains iconv.h
    GETTEXT_LIBRARY                 - Only when building with gettext on Windows; path to libintl.dll.a
    GETTEXT_MSGFMT                  - Only when building with gettext; path to msgfmt/msgfmt.exe
    IRRLICHT_DLL                    - Only on Windows; path to Irrlicht.dll
    IRRLICHT_INCLUDE_DIR            - Directory that contains IrrCompileConfig.h
    IRRLICHT_LIBRARY                - Path to libIrrlicht.a/libIrrlicht.so/libIrrlicht.dll.a/Irrlicht.lib
    LEVELDB_INCLUDE_DIR             - Only when building with LevelDB; directory that contains db.h
    LEVELDB_LIBRARY                 - Only when building with LevelDB; path to libleveldb.a/libleveldb.so/libleveldb.dll.a
    LEVELDB_DLL                     - Only when building with LevelDB on Windows; path to libleveldb.dll
    PostgreSQL_INCLUDE_DIR          - Only when building with PostgreSQL; directory that contains libpq-fe.h
    POSTGRESQL_LIBRARY              - Only when building with PostgreSQL; path to libpq.a/libpq.so
    REDIS_INCLUDE_DIR               - Only when building with Redis; directory that contains hiredis.h
    REDIS_LIBRARY                   - Only when building with Redis; path to libhiredis.a/libhiredis.so
    SPATIAL_INCLUDE_DIR             - Only when building with LibSpatial; directory that contains spatialindex/SpatialIndex.h
    SPATIAL_LIBRARY                 - Only when building with LibSpatial; path to libspatialindex_c.so/spatialindex-32.lib
    LUA_INCLUDE_DIR                 - Only if you want to use LuaJIT; directory where luajit.h is located
    LUA_LIBRARY                     - Only if you want to use LuaJIT; path to libluajit.a/libluajit.so
    MINGWM10_DLL                    - Only if compiling with MinGW; path to mingwm10.dll
    OGG_DLL                         - Only if building with sound on Windows; path to libogg.dll
    OGG_INCLUDE_DIR                 - Only if building with sound; directory that contains an ogg directory which contains ogg.h
    OGG_LIBRARY                     - Only if building with sound; path to libogg.a/libogg.so/libogg.dll.a
    OPENAL_DLL                      - Only if building with sound on Windows; path to OpenAL32.dll
    OPENAL_INCLUDE_DIR              - Only if building with sound; directory where al.h is located
    OPENAL_LIBRARY                  - Only if building with sound; path to libopenal.a/libopenal.so/OpenAL32.lib
    OPENGLES2_INCLUDE_DIR           - Only if building with GLES; directory that contains gl2.h
    OPENGLES2_LIBRARY               - Only if building with GLES; path to libGLESv2.a/libGLESv2.so
    SQLITE3_INCLUDE_DIR             - Directory that contains sqlite3.h
    SQLITE3_LIBRARY                 - Path to libsqlite3.a/libsqlite3.so/sqlite3.lib
    VORBISFILE_DLL                  - Only if building with sound on Windows; path to libvorbisfile-3.dll
    VORBISFILE_LIBRARY              - Only if building with sound; path to libvorbisfile.a/libvorbisfile.so/libvorbisfile.dll.a
    VORBIS_DLL                      - Only if building with sound on Windows; path to libvorbis-0.dll
    VORBIS_INCLUDE_DIR              - Only if building with sound; directory that contains a directory vorbis with vorbisenc.h inside
    VORBIS_LIBRARY                  - Only if building with sound; path to libvorbis.a/libvorbis.so/libvorbis.dll.a
    XXF86VM_LIBRARY                 - Only on Linux; path to libXXf86vm.a/libXXf86vm.so
    ZLIB_DLL                        - Only on Windows; path to zlib1.dll
    ZLIBWAPI_DLL                    - Only on Windows; path to zlibwapi.dll
    ZLIB_INCLUDE_DIR                - Directory that contains zlib.h
    ZLIB_LIBRARY                    - Path to libz.a/libz.so/zlibwapi.lib


Docker ("stock" Minetest)
------
Minetest provides Minetest server docker images using the Gitlab mirror registry.

Images are built on each commit and available using the following tag scheme:

* `registry.gitlab.com/minetest/minetest/server:latest` (latest build)
* `registry.gitlab.com/minetest/minetest/server:<branch/tag>` (current branch or current tag)
* `registry.gitlab.com/minetest/minetest/server:<commit-id>` (current commit id)

If you want to test it on a docker server, you can easily run:

	sudo docker run registry.gitlab.com/minetest/minetest/server:<docker tag>

If you want to use it in a production environment you should use volumes bound to the docker host
to persist data and modify the configuration:

	sudo docker create -v /home/minetest/data/:/var/lib/minetest/ -v /home/minetest/conf/:/etc/minetest/ registry.gitlab.com/minetest/minetest/server:master

Data will be written to `/home/minetest/data` on the host, and configuration will be read from `/home/minetest/conf/minetest.conf`.

Note: If you don't understand the previous commands, please read the official Docker documentation before use.

You can also host your minetest server inside a Kubernetes cluster. See our example implementation in `misc/kubernetes.yml`.


Version scheme
--------------

Minetest uses `major.minor.patch` since 5.0.0-dev, but minetest-engine-luk3yx 
currently uses `0.4.major.minor`, as was on minetest 0.4.

Minetest from MinenuX VenenuX project uses `mayor.minor.patch` as 0.4 becomes MT4.

