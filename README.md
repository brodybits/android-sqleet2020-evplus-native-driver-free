# android-sqlite-sqleet-evplus-ext-native-driver-free build (with evplus-ext user defined functions)

Provides a native build of SQLeet (<https://github.com/resilar/sqleet>) with an optimized JSON-based data interface and a workaround for large SELECT results, with a low-level API for Cordova SQLite evplus plugin versions.

Based on:

- [`storesafe/android-sqlite-evplus-ext-native-driver-free`](https://github.com/storesafe/android-sqlite-evplus-ext-native-driver-free)
- [`storesafe/android-sqlite-evcore-native-driver-free`](https://github.com/storesafe/android-sqlite-evcore-native-driver-free)
- [`liteglue/Android-sqlite-native-driver`](https://github.com/liteglue/Android-sqlite-native-driver).

by Christopher J. Brody aka Chris Brody mailto: <chris@brody.consulting>

License: GPL v3 (<https://www.gnu.org/licenses/gpl-3.0.txt>) or commercial license options

## About

Android-sqlite-evplus-ext-native-driver-free provides:
- single `EVPlusNativeDriver` class with native Java interface to the needed C functions
- automatic build for major _supported_ Android targets (~~`armeabi`,~~ `armeabi-v7a`, `x86`, `x86_64`, `arm64-v8a`) that is accessible from the native Java interface, with the following user defined functions:
  - `REGEXP` integrated from [brodybits / sqlite3-regexp-cached](https://github.com/brodybits/sqlite3-regexp-cached) (based on <http://git.altlinux.org/people/at/packages/?p=sqlite3-pcre.git> by Alexey Tourbin, public domain)
  - `BASE64` integrated from [brodybits / sqlite3-base64](https://github.com/brodybits/sqlite3-base64), using [brodybits / libb64-encode](https://github.com/brodybits/libb64-encode) (based on <http://libb64.sourceforge.net/> by Chris Venter, public domain)

This is accomplished by using [GlueGen](http://jogamp.org/gluegen/www/) around the C module.

Minimum API level: _android-21 (Android 5.0)_

**NOTE:** This project references multiple subprojects, which may be resolved by: $ `make init` (as described below).

**WARNING:** The reference handles that are returned by the `EVPlusNativeDriver` library functions are raw C pointer values (with `0x100000000` added). If someone uses a reference handle that is not valid, or no longer valid with the `EVPlusNativeDriver` library the behavior is undefined (may crash, for example). It is NOT recommended to use this API directly unless you really understand how this library works internally.

~~**BUILD NOTICE:** `android-ndk` pre-17 is needed since this project still supports the deprecated `armeabi` target CPU.~~

See the following reference for installing older `android-ndk` cask using Homebrew: <https://www.jverdeyen.be/mac/downgrade-brew-cask-application/>

To install `android-ndk` version `r16b`, for example:

```sh
brew cask install https://raw.githubusercontent.com/Homebrew/homebrew-cask/4570652dc6a3a8f7fd2be1053dd43547a2c78e26/Casks/android-ndk.rb
```

Note that `homebrew-cask` seems to have restored maintenance of the `android-ndk` cask, as discussed in [`Homebrew/homebrew-cask#58883`](https://github.com/Homebrew/homebrew-cask/issues/58883).

See also for some historical `android-ndk` cask information:

- https://github.com/Homebrew/homebrew-cask/commits/master/Casks/android-ndk.rb
- https://github.com/Homebrew/homebrew-cask/commits/5e9f77552aef2ffa29efe8a9b916d89686b96c7f/Casks/android-ndk.rb
- https://github.com/Homebrew/homebrew-cask/blob/5e9f77552aef2ffa29efe8a9b916d89686b96c7f/Casks/android-ndk.rb

## SQLite build information

### SQLite version

    3.32.3

### SQLite build flags

- `-DSQLITE_THREADSAFE=1`
- `-DSQLITE_DEFAULT_SYNCHRONOUS=3`
- `-DSQLITE_DEFAULT_MEMSTATUS=0`
- `-DSQLITE_OMIT_DECLTYPE`
- `-DSQLITE_OMIT_DEPRECATED`
- `-DSQLITE_OMIT_PROGRESS_CALLBACK`
- `-DSQLITE_OMIT_SHARED_CACHE`
- `-DSQLITE_TEMP_STORE=2`
- `-DSQLITE_OMIT_LOAD_EXTENSION`
- `-DSQLITE_ENABLE_FTS3`
- `-DSQLITE_ENABLE_FTS3_PARENTHESIS`
- `-DSQLITE_ENABLE_FTS4`
- `-DSQLITE_ENABLE_FTS5`
- `-DSQLITE_ENABLE_RTREE`
- `-DSQLITE_ENABLE_JSON1`

New stable default page size and cache size (<https://sqlite.org/pgszchng2016.html>):

- `-DSQLITE_DEFAULT_PAGE_SIZE=4096`
- `-DSQLITE_DEFAULT_CACHE_SIZE=-2000`

## Dependencies

- SQLite (<https://sqlite.org/>) - public domain
- [brodybits / sqlite3-regexp-cached](https://github.com/brodybits/sqlite3-regexp-cached) - based on <http://git.altlinux.org/people/at/packages/?p=sqlite3-pcre.git> by Alexey Tourbin, public domain
- [brodybits / sqlite3-base64](https://github.com/brodybits/sqlite3-base64) - Unlicense (public domain) ref: <http://unlicense.org/>
- [brodybits / libb64-encode](https://github.com/brodybits/libb64-encode) - based on <http://libb64.sourceforge.net/> by Chris Venter, public domain

## For future consideration

- Support direct query of BLOB type

__FUTURE TBD/TODO:__

- Automatic AAR build
- Document this project (again, perhaps in a blog post)
- Some more SQLite API functions will be needed to rebuild the native sqlcipher library to replace the native libraries in the [@sqlcipher / android-database-sqlcipher](https://github.com/sqlcipher/android-database-sqlcipher) ([SQLCipher for Android](https://www.zetetic.net/sqlcipher/sqlcipher-for-android/)) project.

# Building

## Normal build

Initialize with the subproject references:

$ `make init`

Then to build:

$ `make`

## Regenerage Java & C glue code

$ `make regen`
