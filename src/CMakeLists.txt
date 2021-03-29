# Format source files
format_source_files(
    RECURSE true
    FILE_GLOB_LIST
        "*.cpp"
        "*.cc"
        "*.h"
        "*.hpp"
)

# Add the library subdirectories
add_subdirectory(utils)

# The executable to be built, which serves as the entrypoint for your program
add_executable(${PROJECT_NAME}
    main.cpp
)

# Link the libraries from subdirectories to the project executable
#USER-TODO: Reference the libraries built from subdirectories here
target_link_libraries(${PROJECT_NAME}
    _utils
)