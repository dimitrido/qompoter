# MyLibrary CMake Package Configuration File
#
# This file is used by CMake's find_package() command to locate and configure MyLibrary
# when it's installed via Qompoter in the vendor directory.

# Get the directory where this config file is located
get_filename_component(MYLIBRARY_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Get the root directory of the package (one level up from cmake/)
get_filename_component(MYLIBRARY_ROOT_DIR "${MYLIBRARY_CMAKE_DIR}/.." ABSOLUTE)

# Provide information about the package location
set(MYLIBRARY_INCLUDE_DIR "${MYLIBRARY_ROOT_DIR}/include")
set(MYLIBRARY_SOURCE_DIR "${MYLIBRARY_ROOT_DIR}/src")

# Define an INTERFACE library target
# This is suitable for header-only libraries or when sources need to be compiled by the consumer
add_library(MyLibrary INTERFACE)

# Specify the include directories
target_include_directories(MyLibrary INTERFACE "${MYLIBRARY_INCLUDE_DIR}")

# If you have source files that need to be compiled, add them like this:
target_sources(MyLibrary INTERFACE "${MYLIBRARY_SOURCE_DIR}/mylibrary.cpp")

# Alternative: If you have a pre-built static or shared library, use this instead:
# add_library(MyLibrary STATIC IMPORTED)
# set_target_properties(MyLibrary PROPERTIES
#     IMPORTED_LOCATION "${MYLIBRARY_ROOT_DIR}/lib/libmylibrary.a"
#     INTERFACE_INCLUDE_DIRECTORIES "${MYLIBRARY_INCLUDE_DIR}"
# )

# Mark the package as found
set(MyLibrary_FOUND TRUE)

# Optional: Print debug information
message(STATUS "Found MyLibrary: ${MYLIBRARY_ROOT_DIR}")
