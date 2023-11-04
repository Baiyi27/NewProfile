#/*-------Date:2023/05/26/21:04-------*/
#/*-------UpDate:2023/07/11/20:14-------*/
cmake_minimum_required(VERSION 3.25)

set(CMAKE_CXX_STANDARD 14)

project(MyDriSO)
# set obj name
set(projectName dirSharedObject)

set(compileOptions
    -lpthread
    -O3
    #-fdiagnostics-color=auto
    #-Wall
)
set(libraries pthread)

set(warnAppended FALSE)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
#message(!!!!!${CMAKE_CURRENT_SOURCE_DIR}/include)

# Specifies the path of the dynamic library to be linked
#link_directories(${PROJECT_SOURCE_DIR}/bin)

# Collect C or CPP files in the current directory
file(GLOB sourceFiles ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c*)
#message(file: ${sourceFiles})

#set RELATIVE_PATH and check if  C file exists Add compile parameters

foreach(singleFile ${sourceFiles})
    file(RELATIVE_PATH relativePathFiles ${CMAKE_CURRENT_SOURCE_DIR} ${singleFile})
    list(APPEND objFiles ${relativePathFiles})
    get_filename_component(extension ${singleFile} EXT)
    if(extension STREQUAL ".c" AND NOT warnAppended)
        #message(!---!${sourceFiles})
        list(APPEND compileOptions -Werror=implicit-function-declaration)
        set(warnAppended TRUE)
    endif()
endforeach()

# Add the source files to be compiled
add_library(${projectName} SHARED ${objFiles})

#add_library(${projectName} SHARED ${sourceFiles})

if(WIN32)
    list(APPEND libraries
        ws2_32
    )
    list(APPEND compileOptions -Wall)
    #message(!!WIN32: ${compileOptions})
endif()

message(ALLCOMOPT: ${compileOptions})

# Set compilation options
target_compile_options(${projectName} PRIVATE ${compileOptions})

#set link libraries
target_link_libraries(${projectName} PRIVATE ${libraries})

# set(LIBRARY_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/lib")
# message(STATUS "**OUT_PATH ${LIBRARY_OUTPUT_PATH}")

# Get the current directory name
get_filename_component(DRV_NAME ${PROJECT_SOURCE_DIR} NAME)
# Set the output Shared Object file name
set_target_properties(${projectName} PROPERTIES
    PREFIX ""
    OUTPUT_NAME "${DRV_NAME}"
)

install(TARGETS ${projectName} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/lib)

# Determine the installation path in the operating system environment
if(WIN32)
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/kplc*") # Find files starting with 'kplc'
        set(TARGET_PATHS "D:/Test/bin/lib/plc")
    else()
        set(TARGET_PATHS "D:/Kinco/Kinco DTools V4.1.0/lib/plc" "D:/Kinco/Kinco_debug/lib/plc")
    endif()
else()
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/kplc*")
        set(TARGET_PATHS "/home/lyj/Prolib.lnk/")
    else()
        set(TARGET_PATHS "/home/lyj/Dtoolslib.lnk/" "/home/lyj/DebugDtoolslib.lnk/")
    endif()
endif()

# Install the library files to the target paths
foreach(TARGET_PATH ${TARGET_PATHS})
    install(FILES "$<TARGET_FILE:${projectName}>" DESTINATION ${TARGET_PATH})
endforeach()

# Determine if the lib directory exists and delete the. a file in it
