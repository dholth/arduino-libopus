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

include(${CMAKE_CURRENT_LIST_DIR}/../../CMakeLists.txt)

# set_property(TARGET opusfile PROPERTY C_STANDARD 99)

# target_include_directories(opusfile PUBLIC $<BUILD_INTERFACE:${arduino_libopus_SOURCE_DIR}/src>)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE usermod_opus)
