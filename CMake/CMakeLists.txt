## /*---Date:2023/05/26/21:04---*/
## /*--- UpDate:2023/12/26/14:46 ---*/
cmake_minimum_required(VERSION 3.25)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)

set(CommonFlags "-Os -Wall")
# set(CMAKE_C_FLAGS "${CommonFlags} -Werror=implicit-function-declaration")

# set(Debug TRUE)

if(Debug)
    set(WonUnused " -Wextra -Wno-unused-variable -Wno-unused-but-set-variable")
    string(APPEND CommonFlags ${WonUnused})

    message(!!!${CommonFlags})
# elseif(Debug AND WIN32)

#     string(APPEND CommonFlags " -Wno-unused-variable -Wno-unused-but-set-variable")
#     # message(%%${CommonFlags})
    
endif()

## set obj name
project(DynamicLibrary)

## Collect C or CPP files in the current directory
file(GLOB_RECURSE objFiles src/*.c*)
# file(GLOB_RECURSE objHeaders include/*.h)
# message(file: ${sourceFiles})

## Add the source files to be compiled
add_library(${PROJECT_NAME} SHARED ${objFiles})
# add_library(${PROJECT_NAME} STATIC ${sourceFiles})

## Specifies the path of the dynamic library to be linked
#link_directories(${PROJECT_SOURCE_DIR}/bin)

target_include_directories(
    ${PROJECT_NAME} PUBLIC  
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>  
    $<INSTALL_INTERFACE:include>  
)
#message(!!!!!${CMAKE_CURRENT_SOURCE_DIR}/include)

set(CMAKE_C_FLAGS "${CommonFlags} -Werror=implicit-function-declaration")
set(CMAKE_CXX_FLAGS "${CommonFlags}")

# message(${CMAKE_C_FLAGS})

set(linkLibs pthread)

if(WIN32)
    list(APPEND linkLibs
        ws2_32
        wsock32
    )
endif()

## Set compilation options
# target_compile_options(${PROJECT_NAME} PRIVATE ${compileOptions})

## set link libraries
target_link_libraries(${PROJECT_NAME} PRIVATE ${linkLibs})

## Get the current directory name
get_filename_component(driverName ${PROJECT_SOURCE_DIR} NAME)

## Set the output Shared Object file name
set_target_properties(
    ${PROJECT_NAME} PROPERTIES
    PUBLIC_HEADER "${objHeaders}"
    PREFIX ""
    OUTPUT_NAME "${driverName}"
)

## set  default install path
set(installPath ${PROJECT_SOURCE_DIR}/lib)

install(
    TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${installPath}
    LIBRARY DESTINATION ${installPath}
    # ARCHIVE DESTINATION ${installPath}
    PUBLIC_HEADER DESTINATION ${installPath}/include
)

## Determine the installation path in the operating system environment
if(WIN32)
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/kplc*") # Find files starting with 'kplc'
        set(targetPaths "D:/Test/bin/lib/plc")
    else()
        set(targetPaths "D:/Kinco/Kinco DTools V4.2.0/lib/plc" "D:/Kinco/Kinco_debug/lib/plc")
    endif()
else()
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/kplc*")
        set(targetPaths "/home/lyj/Prolib.lnk/")
    else()
        set(targetPaths "/home/lyj/Dtoolslib.lnk/" "/home/lyj/DebugDtoolslib.lnk/")
    endif()
endif()

## Update`Ge` files
file(GLOB geFile ${PROJECT_SOURCE_DIR}/lib/${driverName}.ge)
# message(!!!!!!!!!!!${geFile})
# message(***********${targetPaths})

## Install the library file and ge files to the target paths
foreach(targetPath ${targetPaths})
    install(FILES "$<TARGET_FILE:${PROJECT_NAME}>" DESTINATION ${targetPath})
    install(FILES ${geFile} DESTINATION ${targetPath})
endforeach()

