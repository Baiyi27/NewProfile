#[=======================================================================[.rst:
FindClangTool
-------------

The module defines the following variables:

``clangToolExe``
  Path to the specified clang tool command-line client.
``clangToolFound``
  True if the specified clang tool command-line client was found.
``clangToolVersionString``
  The version of the specified clang tool found.

.. versionadded:: 3.14
  The module defines the following ``IMPORTED`` targets (when
  :prop_gbl:`CMAKE_ROLE` is ``PROJECT``):

``ClangTool::ClangTool``
  Executable of the specified clang tool command-line client.

``ClangTool::ClangTool``
  Executable of the specified clang tool command-line client.

Example usage:

.. code-block:: cmake

   set(CLANG_TOOL_NAME clang-format)
   find_package(ClangTool REQUIRED)
   if(clangToolFound)
        message("${ClangTool_NAME} found: ${clangToolExe}")
   endif()
#]=======================================================================]

if(NOT DEFINED CLANG_TOOL_NAME)
    message(FATAL_ERROR "CLANG_TOOL_NAME variable not specified. Use set(CLANG_TOOL_NAME <tool-name>) before find_package(ClangTool REQUIRED)")
endif()

set(clangToolNames ${CLANG_TOOL_NAME})

# Prefer .cmd variants on Windows unless running in a Makefile
# in the MSYS shell.
if(CMAKE_HOST_WIN32)
    if(NOT CMAKE_GENERATOR MATCHES "MSYS")
        set(clangToolNames ${CLANG_TOOL_NAME}.exe ${CLANG_TOOL_NAME})

        # VSCode C/C++ extension search path for Windows
        file(GLOB vscodeClangToolsPath
            "$ENV{USERPROFILE}/.vscode/extensions/ms-vscode.cpptools-*/LLVM/bin"
        )
    endif()
endif()

# First search the PATH and specific locations for the specified clang tool.
find_program(clangToolExe
    NAMES ${clangToolNames}
    PATHS ${vscodeClangToolsPath}
    DOC "${CLANG_TOOL_NAME} command line client"
)

if(CMAKE_HOST_WIN32)
    # Now look for installations in Clang/ directories under typical installation
    # prefixes on Windows.  Exclude PATH from this search because VS 2017's
    # command prompt happens to have a PATH entry with a Clang/ subdirectory
    # containing a minimal clang not meant for general use.
    find_program(clangToolExe
        NAMES ${clangToolNames}
        PATH_SUFFIXES Clang/bin
        NO_SYSTEM_ENVIRONMENT_PATH
        DOC "${CLANG_TOOL_NAME} command line client"
    )
endif()

mark_as_advanced(clangToolExe)

unset(clangToolNames)

set(clangToolFound FALSE)

if(clangToolExe)
    set(clangToolFound TRUE)
endif()

if(clangToolExe)
    set(doClangToolVersionCheck TRUE)
    get_property(clangToolVersionProp GLOBAL
        PROPERTY _CMAKE_FindClangTool_${CLANG_TOOL_NAME}_VERSION
    )

    if(clangToolVersionProp)
        list(GET clangToolVersionProp 0 clangToolExe)
        list(GET clangToolVersionProp 1 clangToolVersion)

        if(clangToolExe STREQUAL clangToolExe AND NOT clangToolVersion STREQUAL "")
            set(clangToolVersionString "${clangToolVersion}")
            set(doClangToolVersionCheck FALSE)
        endif()

        unset(clangToolExe)
        unset(clangToolVersion)
    endif()

    unset(clangToolVersionProp)

    if(doClangToolVersionCheck)
        execute_process(COMMAND ${clangToolExe} --version
            OUTPUT_VARIABLE clangToolVersion
            ERROR_QUIET
            OUTPUT_STRIP_TRAILING_WHITESPACE)

        if(clangToolVersion MATCHES "^${CLANG_TOOL_NAME} version [0-9]")
            string(REPLACE "${CLANG_TOOL_NAME} version " "" clangToolVersionString "${clangToolVersion}")
            set_property(GLOBAL PROPERTY _CMAKE_FindClangTool_${CLANG_TOOL_NAME}_VERSION
                "${clangToolExe};${clangToolVersionString}"
            )
        endif()

        unset(clangToolVersion)
    endif()

    unset(doClangToolVersionCheck)

    get_property(findClangToolRole GLOBAL PROPERTY CMAKE_ROLE)

    if(findClangToolRole STREQUAL "PROJECT")
        if(NOT TARGET ClangTool::ClangTool)
            add_executable(ClangTool::ClangTool IMPORTED)
            set_property(TARGET ClangTool::ClangTool PROPERTY IMPORTED_LOCATION "${clangToolExe}")
        endif()
    endif()

    unset(findClangToolRole)
endif()

# Ensure CMake can find the standard module
include(${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake)

find_package_handle_standard_args(ClangTool
    REQUIRED_VARS clangToolExe
    VERSION_VAR clangToolVersionString)
