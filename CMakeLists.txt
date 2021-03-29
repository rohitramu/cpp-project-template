cmake_minimum_required(VERSION 3.13)

#
# Include custom CMake modules
#
add_subdirectory(cmake)

#
# Make sure environment variables are set correctly
#

# # PROJECT_NAME
# if (NOT DEFINED ENV{PROJECT_NAME})
#     message(FATAL_ERROR "Environment variable \"PROJECT_NAME\" must be set.")
# endif()
# # BUILD_OUTPUT_BIN_DIR
# if (NOT DEFINED ENV{BUILD_OUTPUT_BIN_DIR})
#     message(FATAL_ERROR "Environment variable \"BUILD_OUTPUT_BIN_DIR\" must be set.")
# endif()
# # BUILD_OUTPUT_LIB_DIR
# if (NOT DEFINED ENV{BUILD_OUTPUT_LIB_DIR})
#     message(FATAL_ERROR "Environment variable \"BUILD_OUTPUT_LIB_DIR\" must be set.")
# endif()
# # BUILD_CONFIGURATION
# if (NOT DEFINED ENV{BUILD_CONFIGURATION})
#     message(FATAL_ERROR "Environment variable \"BUILD_CONFIGURATION\" must be set.")
# endif()

#
# Setup compiler features
#
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_BUILD_TYPE ${BUILD_CONFIGURATION})
set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_C_COMPILER "clang")

#
# Setup the project
#
#project($ENV{PROJECT_NAME} CXX)
project(hello CXX)
message(STATUS "Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "Compiler C++: ${CMAKE_CXX_COMPILER}")

#
# Setup the build output directories
#
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY $ENV{BUILD_OUTPUT_LIB_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY $ENV{BUILD_OUTPUT_LIB_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY $ENV{BUILD_OUTPUT_BIN_DIR})

#
# Setup compiler command line options
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

# Make the compiler verbose if required
#set(CMAKE_VERBOSE_MAKEFILE:BOOL ON)

#
# Include top-level code references
#
include_directories(src)
add_subdirectory(src)