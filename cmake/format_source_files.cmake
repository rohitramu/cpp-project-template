function(format_source_files)
    # Parse arguments
    set(options RECURSE)
    set(oneValueArgs)
    set(multiValueArgs FILE_GLOB_LIST)
    cmake_parse_arguments("ARG" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # Validate arguments
    if (NOT DEFINED ARG_FILE_GLOB_LIST)
        message(FATAL_ERROR "The function \"format_source_files()\" requires the argument \"ARG_FILE_GLOB_LIST\"")
    endif()

    set(GLOB_TYPE "")
    if (ARG_RECURSE)
        string(APPEND GLOB_TYPE "_RECURSE")
    endif()

    file("GLOB${GLOB_TYPE}" SOURCE_FILE_LIST ${ARG_FILE_GLOB_LIST})

    find_program(CLANG_FORMAT_PROGRAM "clang-format")
    foreach(SOURCE_FILE ${SOURCE_FILE_LIST})
        file(TO_NATIVE_PATH "${SOURCE_FILE}" SOURCE_FILE)
        message(STATUS "[FORMAT] ${SOURCE_FILE}")
        execute_process(
            RESULT_VARIABLE FORMAT_RESULT_CODE
            OUTPUT_VARIABLE FORMAT_OUTPUT
            OUTPUT_STRIP_TRAILING_WHITESPACE
            COMMAND ${CLANG_FORMAT_PROGRAM}
                "-i" # In-place format (i.e. format file, don"t output to console)
                "-style=file" # Get style rules from ".clang-format" file in root
                "${SOURCE_FILE}" # File path
        )

        if (FORMAT_OUTPUT)
            message("${FORMAT_OUTPUT}")
        endif()

        if (${FORMAT_RESULT_CODE})
            message(FATAL_ERROR "Failed with error code: ${FORMAT_RESULT_CODE}")
        endif()
    endforeach()
endfunction()
