# minetest-engine-luk3yx

This is a minetest 0.4 with includes features from 5.0.0 branch, like new api and 
loading of mods up to date.

description
---------------

This repository is a minetest 0.4.18.3 version; it build from this sources, mostly 
most of the 5.0.0 improvements were added! any mod from 
the 5.X series will be compatible with this.

A [Minetest](https://github.com/minetest/minetest) fork with backported features
and bugfixes from 5.0.0. Most of them documented here: https://github.com/minetest/minetest/pull/6746/commits 
the sources were forked as new repo from https://github.com/luk3yx/minetest 
of the stable-0.4-backport branch.

In case you downloaded the source code:
---------------------------------------

To generated a program from this files you need two things:

1. Compile this sources, check the section [Compiling](#compiling) of this file.
2. Download the gameid for this folk, chek the section [Engine vs Gameid](#engine-vs-gameid)

This is a mostly unmaintained fork of an older up to dated version of Minetest
(0.4.17.1) to add features and bugfixes from 5.0.0 before 5.0.0 was officially
released and most servers were still on 0.4.17.1. Its pretty stable and know to work, 
but is not official also is not bug free, does not have support and is only for 
those OS's that cannot connect to older servers 0.4 versions or cannot build a 5.X version.

Table of Contents
------------------

1. [Further Documentation](#further-documentation)
1. [Engine vs Gameid](#engine-vs-gameid)
4. [Configuration File](#configuration-file)
5. [Command-line Options](#command-line-options)
3. [Paths](#paths)
2. [Default Controls](#default-controls)
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
- Minenux: https://codeberg.org/minenux Similar project DONT ASK TO SUPPORT THERE!

Engine vs Gameid
----------------

Minetest is a game, is composed of two artifact, the engine (the program 
that is generated from this sources) and the Gameid (the data files and logic 
for play minetest).

This sources and project only generated a program when [compiling](#compiling), 
each release of a minetest engine needs their corresponding "`minetest_game`" .. for this 
special sources you must those only **compatibles like those**:

* minetest game 0.4.17 from https://github.com/minetest/minetest_game/tree/stable-0.4
* minetest improved 0.4.17 from https://codeberg.org/minenux/minetest-game-minetest/src/branch/stable-0.4
* minetest luk3yx 0.4.18 from https://gitlab.com/minenux/minetest-game-luk3yx/-/tree/stable-4.1
* minetest4 4.0.18 minenux from https://codeberg.org/minenux/minetest-game-minetest/src/branch/stable-4.0

Configuration files:
-------------------

Its named `minetest.conf` and depending of the type of build of the running 
program minetest (the `RUN_IN_PLACE`, check [compiling](#compiling) section), 
the loction are at:

- Default location if you compiles as integrated in the OS:
    `/etc/minetest/minetest.conf` or `<DESTDIR>/etc/minetest/minetest.conf`
- Otherwise For `RUN_IN_PLACE` It is created by Minetest at first run at:
    `user/minetest.conf` or `bin/../minetest.conf` and also `bin/../../minetest.conf`
- A specific file can be specified on the command line:
    `--config <path-to-file>`

Command-line options:
---------------------

Use `--help` and also consult the manpage at [doc/minetest.6](doc/minetest.6) 
or run `man minetest` if you have installed the program game (either or not of the gameid)

Paths
-----

Locations:

* `bin`   - Compiled binaries to execute program
* `share` - Distributed read-only data
* `user`  - User-created modifiable data

Where each location is on each platform:

* Other OS's or **with** `RUN_IN_PLACE` build of the program:
    * bin   = `bin`
    * share = `.`
    * user  = `.`
    * worlds = `worlds`
* Linux but **without** `RUN_IN_PLACE` build of the program:
    * `bin`   = `/usr/bin`
    * `share` = `/usr/share/minetest`
    * `user`  = `~/.minetest`
    * `worlds` = `~/.minetest/worlds/`
* MacOS using Brew builds:
    * `bin`   = `Contents/MacOS`
    * `share` = `Contents/Resources`
    * `user`  = `Contents/User` or `~/Library/Application Support/minetest`
    * `worlds` = `~/Library/Application Support/minetest/worlds`

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

Compiling
---------

If you used directly this repository, so then compilation requires GIT installed and network available.

#### Dependencies

| Dependency | Version | Original | Commentary |
|------------|---------|----------|------------|
| GCC        | 4.9+    | 4.5+     | Can be replaced with Clang 3.4+ |
| CMake      | 3.1+    | 2.6+     |            |
| Irrlicht   | 1.8.1+  | 1.7.3+   |            |
| SQLite3    | 3.0+    | 3.0+     |            |
| LuaJIT     | 2.0+    | 2.0+     | Bundled Lua 5.1 is used if not present |
| GMP        | 5.0.0+  | 4.9.9    | Bundled mini-GMP is used if not present |
| JsonCPP    | 1.0.0+  | 1.0.0+   | Bundled JsonCPP is used if not present |

#### Download

This is an archived project so there's only one way to download sources, by git usage, 
download source, by example this is original at https://github.com/luk3yx/minetest.git and
download minetest_game (otherwise only the "Minimal development test" game is available), 
of course if you already have the sources downloaded you can bypass and skip these steps:

```
cd ~
mkdir -p ~/Devel
cd ~/Devel
git clone --depth 1 https://github.com/minenux/minetest-engine-luk3yx
cd ~/Devel/minetest
git clone --depth 1 https://github.com/luk3yx/minetest_game.git games/minetest_game
```

#### Build

As we said there's two buid types, the "RUN_IN_PLACE" and the integrated into the OS, 
so to build a version that runs directly from the source directory or any DESTDIR directory 
where the binary compiled program minetest are.. just do:

    cmake . -DRUN_IN_PLACE=TRUE
    make -j <number of processors>

And later you can run it (RUN_IN_PLACE mode) as:

    ./bin/minetest

For other ways to compile, remove the RUN_IN_PLACE set and check these others options:

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

Original oficial Minetest provides Minetest server docker images using the Gitlab mirror registry, but
today those are not availables.. 

Images are built on each commit and available using the following tag scheme:

* `registry.gitlab.com/minetest/minetest/server:latest` (latest build)
* `registry.gitlab.com/minetest/minetest/server:<branch/tag>` (current branch or current tag)
* `registry.gitlab.com/minetest/minetest/server:<commit-id>` (current commit id)

If you want to test it on a docker server, you can easily run:
`docker run registry.gitlab.com/minetest/minetest/server:<docker tag>`

If you want to use it in a production environment you should use volumes bound to the docker host
to persist data and modify the configuration:

	sudo docker create -v /home/minetest/data/:/var/lib/minetest/ -v /home/minetest/conf/:/etc/minetest/ registry.gitlab.com/minetest/minetest/server:master

Data will be written to `/home/minetest/data` on the host, and configuration will be read from `/home/minetest/conf/minetest.conf`.

You can also host your minetest server inside a Kubernetes cluster. See our example implementation in `misc/kubernetes.yml`.


Version scheme
--------------

Minetest uses `major.minor.patch` since 5.0.0-dev, but minetest-engine-luk3yx 
currently uses `0.4.major.minor`, as was on minetest 0.4.

Minetest from MinenuX VenenuX project uses `mayor.minor.patch` as 0.4 becomes MT4.

## LICENSE

Minetest is copyright © 2010-2019 by Perttu Ahola (know as celeron55)
and contributors (see source file comments and the [version control log])

[Contributions]: https://github.com/minetest/minetest/graphs/contributors
