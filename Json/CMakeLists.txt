#/*-------Date:2023/05/26/21:04-------*/
#/*--- UpDate:2023/11/28/10:54 ---*/
cmake_minimum_required(VERSION 3.25)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)

set(CommonFlags "-Os -Wall -Wextra")
# set(CMAKE_C_FLAGS "${CommonFlags} -Werror=implicit-function-declaration")

# set(Debug TRUE)
set(Debug FALSE)

if(Debug)
    set(WonUnused " -Wno-unused-variable -Wno-unused-but-set-variable")
    string(APPEND CommonFlags ${WonUnused})

    # message(!!!${CommonFlags})
# elseif(Debug AND WIN32)

#     string(APPEND CommonFlags " -Wno-unused-variable -Wno-unused-but-set-variable")
#     # message(%%${CommonFlags})
    
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

# message(${CMAKE_C_FLAGS})
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
get_filename_component(driverName ${PROJECT_SOURCE_DIR} NAME)

# Set the output Shared Object file name
set_target_properties(${projectName} PROPERTIES
    PREFIX ""
    OUTPUT_NAME "${driverName}"
)

install(TARGETS ${projectName} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/lib)

# Determine the installation path in the operating system environment
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

#Update`Ge` files
file(GLOB geFile ${PROJECT_SOURCE_DIR}/lib/${driverName}.ge)
# message(!!!!!!!!!!!${geFile})
# message(***********${targetPaths})

# Install the library file and ge files to the target paths
foreach(targetPath ${targetPaths})
    install(FILES "$<TARGET_FILE:${projectName}>" DESTINATION ${targetPath})
    install(FILES ${geFile} DESTINATION ${targetPath})
endforeach()

