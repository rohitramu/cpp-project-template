# Simple C++ Project Template

- [About](#about)
- [One-time setup](#one-time-setup)
- [Developer workflow](#developer-workflow)
  - [Adding libraries](#adding-libraries)
  - [Choosing a build configuration](#choosing-a-build-configuration)
  - [Changing the default code style](#changing-the-default-code-style)
- [Building and running your code](#building-and-running-your-code)
  - [1. Configure the build system](#1-configure-the-build-system)
  - [2. Build your code](#2-build-your-code)
  - [3. Run your code](#3-run-your-code)
- [Required tools](#required-tools)
  - [All platforms](#all-platforms)
  - [Windows](#windows)

## About

This is a basic template for a C++ project.  It follows a simple folder structure and contains
build scripts which work in both Windows and Unix environments, provided that the
[required tools](#required-tools) are correctly installed.

## One-time setup

1. Download and install the [required tools](#Required-tools).
2. Make sure the installed tools are in your system path.
3. Find and update the `USER-TODO` statements (search for the string `USER-TODO:` recursively from the project root).

## Developer workflow

1. Open a new PowerShell Core terminal in the project's root directory.
2. Run the [`./init.ps1` command](#initps1).
3. Write some code.  See [Adding libraries](#adding-libraries) to learn how to create libraries and
   break up your program into modules.
4. Run the [`build` command](#build).
5. Run the [`run` command](#run) to call the built executable.
6. If required, call the [`clean` command](#clean) to remove both the generated build system and the
   output files (i.e. the built executable and libraries).

### Adding libraries

1. Create a directory under the `src` folder.  Give it the same name as the library you are creating.
2. Create both your `*.h` header files and `*.cpp` (or `*.cc`) implementation files in this directory.
3. Create a `CMakeLists.txt` file in the library directory, with the following content:

    ```cmake
    # Add implementations in this directory to the library (headers are automatically detected).
    add_library(_<your library's name>
        <file 1>.cpp
        <file 2>.cpp
    )
    ```

    NOTE: Don't forget the leading underscore in the name - this makes for cleaner output filenames.

4. At the begining of the parent directory's `CMakeLists.txt`, add a reference to each subdirectory
   that contains a library:

   ```cmake
    # Add subdirectories which contain libraries
    add_subdirectory(<your library's name>)
    add_subdirectory(<your other library's name>)
   ```

5. Tell the build system that your libraries need to be linked when building the output executable:

    ```cmake
    # Link the libraries from subdirectories to the project executable
    target_link_libraries(${PROJECT_NAME}
        _<your library's name>
        _<your other library's name>
    )
    ```

    NOTE: Again, don't forget the leading underscore in the name - it needs to match the name that
    was given in step 3.

### Choosing a build configuration

By default, the configuration is set to `Debug`.  To use a different build configuration
(e.g. `Release`), provide the string as an argument to the [init](#initps1) script:

```powershell
./init.ps1 'Release'
```

The project can be initialized as many times as you need to, so this is a convenient way to try out
different build configurations.
Environment variables and output paths will change when you change the build configuration, so existing
builds will not be affected by commands, e.g. [`clean`](#clean).

### Changing the default code style

A code formatter is automatically run each time the [build command](#build) is called.  It is a
good idea to also integrate this build command into your git hooks and/or CI/CD pipelines so that
all pushed code will follow your chosen code style rules.

The `.clang-format` file in the project root can be used for configuring the default formatter.
See the [clang-format documentation](https://releases.llvm.org/3.7.1/tools/docs/ClangFormatStyleOptions.html)
for more information about configuration options.

## Building and running your code

Other build systems may be used, but in the interest of keeping this simple and flexible, I will use
Ninja in these instructions.

### 1. Configure the build system

```shell
# You can use a different folder name instead of ".build".
# If you know what you are doing, you can use a different generator.
# Note that the build step will be different in this case.
cmake -B ".build" -G Ninja
```

### 2. Build your code

```shell
# Use the same folder name that you used in step 1.
ninja -C ".build"
```

### 3. Run your code

```shell
# Run the executable found in the ".out" folder (change the name to your project name).
./.out/hello
```

## Required tools

### All platforms

[CMake](https://github.com/Kitware/CMake/releases):
For generating a build system on/for any platform.
NOTE: Use the provided GitHub link, not the official CMake site for download.

[Ninja](https://github.com/ninja-build/ninja/releases):
For building the project using the generated build system and selected toolchain.

### Windows

[LLVM](https://github.com/llvm/llvm-project/releases):
For Clang tools (clang++, clang-format, clang-tidy).

[MinGW-w64](https://www.mingw-w64.org/downloads):
The toolchain to use for compilation of sources.
