cmake_minimum_required(VERSION 3.13)

#
# Set project-wide variables.
#

# Project name.
# USER-TODO: Update project name.  Other variables can also be modified here or via command line.
set(BUILD_PROJECT_NAME "hello" CACHE STRING "The project name.")

# Sets build configuration to Debug or Release.
set(BUILD_DEBUG ON CACHE BOOL "If enabled, builds with the 'Debug' configuration, otherwise builds with the 'Release' configuration." FORCE)
if (BUILD_DEBUG)
    set(BUILD_CONFIGURATION "Debug")
else()
    set(BUILD_CONFIGURATION "Release")
endif()

# Make the compiler verbose if required.
set(CMAKE_VERBOSE_MAKEFILE OFF CACHE BOOL "Enables verbose compiler logs." FORCE)

#
# Include custom CMake modules.
#
add_subdirectory(custom_cmake_modules)

#
# Setup compiler features.
#
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_BUILD_TYPE ${BUILD_CONFIGURATION})
set(CMAKE_CXX_COMPILER "g++")
set(CMAKE_C_COMPILER "gcc")

#
# Setup the project.
#
project(${BUILD_PROJECT_NAME} CXX)
message(STATUS "Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "Compiler C++: ${CMAKE_CXX_COMPILER}")

#
# Setup the build output directories.
#
set(BUILD_OUTPUT_DEFAULT_DIR "${PROJECT_SOURCE_DIR}/.out" CACHE PATH "The default output directory.  This can be overridden with BUILD_OUTPUT_BIN_DIR and BUILD_OUTPUT_LIB_DIR.")
set(BUILD_OUTPUT_BIN_DIR "${BUILD_OUTPUT_DEFAULT_DIR}" CACHE PATH "The binary output directory.")
set(BUILD_OUTPUT_LIB_DIR "${BUILD_OUTPUT_DEFAULT_DIR}/lib" CACHE PATH "The library output directory.")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${BUILD_OUTPUT_LIB_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BUILD_OUTPUT_LIB_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BUILD_OUTPUT_BIN_DIR})
set(CMAKE_PDB_OUTPUT_DIRECTORY ${BUILD_OUTPUT_BIN_DIR})

#
# Setup compiler command line options.
# https://stackoverflow.com/questions/5088460/flags-to-enable-thorough-and-verbose-g-warnings
#
add_compile_options(
    "-Wall" "-Wextra" "-Wpedantic" "-Werror"
    "-Wdisabled-optimization"
    "-Wfloat-equal"
    "-Wold-style-cast"
    "-Wswitch-default"
    "-Wzero-as-null-pointer-constant"
    "-Wuseless-cast"
)

#
# Include top-level code references
#
include_directories(src)
add_subdirectory(src)
