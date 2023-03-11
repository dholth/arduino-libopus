# Create an INTERFACE library for our C module.
add_library(usermod_opus INTERFACE)

# Add our source files to the lib
target_sources(usermod_opus INTERFACE
    # ${CMAKE_CURRENT_LIST_DIR}/opusmodule.c
    ${CMAKE_CURRENT_LIST_DIR}/oggzmodule.c
)

# Add the current directory as an include directory.
target_include_directories(usermod_opus INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}
)

add_compile_definitions(INCLUDE_STDINT_H HAVE_CONFIG_H ARDUINO)

# opus
set(OPUS_FIXED_POINT ON)
set(OPUS_DISABLE_FLOAT_API ON)
set(OPUS_DISABLE_EXAMPLES ON)
set(OPUS_DISABLE_DOCS ON)

# opusfile
set(OP_DISABLE_HTTP ON)
set(OP_DISABLE_FLOAT_API ON)
set(OP_FIXED_POINT ON)
set(OP_DISABLE_EXAMPLES ON)
set(OP_DISABLE_DOCS ON)
set(OP_HAVE_LIBM OFF)


## adapted from top-level CMakeLists.txt

# lots of warnings and all warnings as errors
## add_compile_options(-Wall -Wextra )
set(CMAKE_CXX_STANDARD 17)

file(GLOB_RECURSE SRC_LIST_C CONFIGURE_DEPENDS  "${CMAKE_CURRENT_LIST_DIR}/../../src/*.c" )

# define libraries
add_library (arduino_libopus ${SRC_LIST_C})

# prevent compile errors
target_compile_options(arduino_libopus PRIVATE -DARDUINO)

# define location for header files
target_include_directories(arduino_libopus PUBLIC ${CMAKE_CURRENT_LIST_DIR}/../../src  )

## back to micropython land


# set_property(TARGET opusfile PROPERTY C_STANDARD 99)

# target_include_directories(opusfile PUBLIC $<BUILD_INTERFACE:${arduino_libopus_SOURCE_DIR}/src>)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE usermod_opus arduino_libopus)
