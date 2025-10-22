cmake_minimum_required(VERSION 3.4.1)
set(CMAKE_VERBOSE_MAKEFILE on)

file(GLOB rnoh_ido_SRC CONFIGURE_DEPENDS *.cpp)
add_library(rnoh_ido SHARED ${rnoh_ido_SRC})
target_include_directories(rnoh_ido PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(rnoh_ido PUBLIC rnoh)