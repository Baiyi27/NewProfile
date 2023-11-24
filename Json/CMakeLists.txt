#/*-------Date:2023/05/26/21:04-------*/
#/*--- UpDate:2023/11/24/14:07 ---*/
cmake_minimum_required(VERSION 3.25)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)

set(CommonFlags "-Os -Wall -Wextra")
# set(CMAKE_C_FLAGS "${CommonFlags} -Werror=implicit-function-declaration")

set(Debug TRUE)

if(Debug AND LINUX)

    set(WonUnused " -Wno-unused-variable -Wno-unused-but-set-variable")
    string(APPEND CommonFlags ${WonUnused})
    # message(!!!${CommonFlags})
elseif(Debug AND WIN32)

    string(APPEND CommonFlags " -Wno-unused-variable")
    # message(%%${CommonFlags})
    
endif()

project(MyDriSO)
# set obj name
set(projectName dirSharedObject)

set(libraries pthread)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
#message(!!!!!${CMAKE_CURRENT_SOURCE_DIR}/include)


# Specifies the path of the dynamic library to be linked
#link_directories(${PROJECT_SOURCE_DIR}/bin)

# Collect C or CPP files in the current directory
file(GLOB objFiles ${CMAKE_CURRENT_SOURCE_DIR}/src/*.c*)
#message(file: ${sourceFiles})

# Add the source files to be compiled
add_library(${projectName} SHARED ${objFiles})

set(CMAKE_C_FLAGS "${CommonFlags} -Werror=implicit-function-declaration")
set(CMAKE_CXX_FLAGS "${CommonFlags}")

message(${CMAKE_C_FLAGS})
#add_library(${projectName} STATIC ${sourceFiles})

if(WIN32)
    list(APPEND libraries
        ws2_32
        wsock32
    )

endif()

# Set compilation options
# target_compile_options(${projectName} PRIVATE ${compileOptions})

#set link libraries
target_link_libraries(${projectName} PRIVATE ${libraries})

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
        set(TARGET_PATHS "D:/Kinco/Kinco DTools V4.2.0/lib/plc" "D:/Kinco/Kinco_debug/lib/plc")
    endif()
else()
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/kplc*")
        set(TARGET_PATHS "/home/lyj/Prolib.lnk/")
    else()
        set(TARGET_PATHS "/home/lyj/Dtoolslib.lnk/" "/home/lyj/DebugDtoolslib.lnk/")
    endif()
endif()

#Update`Ge` files
file(GLOB geFile ${PROJECT_SOURCE_DIR}/lib/${DRV_NAME}.ge)
# message(!!!!!!!!!!!${geFile})
# message(***********${TARGET_PATHS})

# Install the library file and ge files to the target paths
foreach(TARGET_PATH ${TARGET_PATHS})
    install(FILES "$<TARGET_FILE:${projectName}>" DESTINATION ${TARGET_PATH})
    install(FILES ${geFile} DESTINATION ${TARGET_PATH})
endforeach()
#upDate:2023/11/14/14:11 
