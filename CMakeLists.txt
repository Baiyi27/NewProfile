#/*-------Date:2023/05/30/21:04-------*/
#/*-------UpDate:2023/05/31/15:47-------*/
cmake_minimum_required(VERSION 3.25)

project(MyDriSO)
# set obj name
set(projectName driSharedObject)

# Get the current directory name
get_filename_component(DRV_NAME "${CMAKE_CURRENT_SOURCE_DIR}" NAME)

# Collect C or CPP files in the current directory
file(GLOB sourceFile *.c*)
#message(STATUS "cfile: ${sourceFile}")

# Find files starting with 'kplc'
file(GLOB KPLC_FILES kplc*)
#message(STATUS "kplcfile: ${KPLC_FILES}")

#set RELATIVE_PATH
foreach(singleFile ${sourceFile})
    #message(for ::::${singleFile})
    file(RELATIVE_PATH  relativeFiles  ${CMAKE_CURRENT_SOURCE_DIR} ${singleFile})
    list(APPEND objFiles ${relativeFiles})
endforeach()

# Add the source files to be compiled
add_library(${projectName} SHARED ${objFiles})

#add_library(${projectName} SHARED ${sourceFile})

# Set compilation options
if(WIN32)
    target_compile_options(${projectName} PRIVATE
        -lpthread
        -O3
        #-Werror=implicit-function-declaration
        -Wall
        -lws2_32 
    )
    target_link_libraries(${projectName} ws2_32)
else()
    target_compile_options(${projectName} PRIVATE
        -lpthread
        -O3
        -fdiagnostics-color=auto
        -Werror=implicit-function-declaration
        -Wall
    )
endif()
set(LIBRARY_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/lib")
#message(STATUS "**OUT_PATH ${LIBRARY_OUTPUT_PATH}")

# Set the output Shared Object file name
set_target_properties(${projectName} PROPERTIES
    PREFIX ""
    OUTPUT_NAME "${DRV_NAME}"
)

install(TARGETS ${projectName}  DESTINATION  ${CMAKE_CURRENT_SOURCE_DIR}/lib)
# Determine the installation path in the operating system environment

if(WIN32)
    if(KPLC_FILES)
        set(TARGET_PATHS "D:/Test/bin/lib/plc")
    else()
        set(TARGET_PATHS "D:/Kinco/Kinco DTools V4.1.0/lib/plc" "D:/Kinco/Kinco_debug/lib/plc")
        foreach(TARGET_PATH ${TARGET_PATHS})
            #message("!!!!Windows Path: ${TARGET_PATH}")
            install(FILES "lib/${DRV_NAME}.dll" DESTINATION ${TARGET_PATH})
        endforeach()
    endif()
else()
    if(KPLC_FILES)
        set(TARGET_PATHS "/home/lyj/Prolib.lnk/")
    else()
        set(TARGET_PATHS "/home/lyj/Dtoolslib.lnk/" "/home/lyj/DebugDtoolslib.lnk/")
        foreach(TARGET_PATH ${TARGET_PATHS})
            #message("!!!!Linux Path: ${TARGET_PATH}")
            install(FILES "lib/${DRV_NAME}.so" DESTINATION  ${TARGET_PATH})
        endforeach()
    endif()
endif()

# Determine if the lib directory exists and delete the. a file in it
