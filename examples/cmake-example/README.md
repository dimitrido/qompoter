# CMake Example with Qompoter

This example demonstrates how to use Qompoter to manage dependencies in a CMake-based C++/Qt project.

## Example Structure

This example contains:
- `my-library/` - A sample library package with CMake support
- `my-project/` - A sample project that depends on the library using Qompoter

## How to Use This Example

### 1. Prepare the Library Package

The library (`my-library/`) has the following structure:
```
my-library/
├── cmake/
│   └── MyLibraryConfig.cmake    # CMake package configuration
├── include/
│   └── mylibrary.h               # Public headers
├── src/
│   └── mylibrary.cpp             # Implementation
├── qompoter.json                 # Qompoter metadata
└── qompoter.pri                  # QMake configuration (for QMake users)
```

The key file for CMake integration is `cmake/MyLibraryConfig.cmake`, which defines how CMake can find and use the library.

### 2. Set Up the Consumer Project

The project (`my-project/`) uses Qompoter to fetch dependencies:

```bash
cd my-project
qompoter update
```

This downloads the library into `vendor/` and generates `vendor/vendor.cmake`.

### 3. Build the Project

```bash
cd my-project
mkdir build && cd build
cmake ..
make
./my-app
```

## Key Files

### Library's CMake Configuration (`my-library/cmake/MyLibraryConfig.cmake`)

This file tells CMake where to find the library's headers and how to link against it:

```cmake
get_filename_component(MYLIBRARY_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(MYLIBRARY_ROOT_DIR "${MYLIBRARY_CMAKE_DIR}/.." ABSOLUTE)

# Define the library target
add_library(MyLibrary INTERFACE)
target_include_directories(MyLibrary INTERFACE "${MYLIBRARY_ROOT_DIR}/include")

# For projects that need to link against a built library, you would use:
# set(MYLIBRARY_LIBRARIES "${MYLIBRARY_ROOT_DIR}/lib/libmylibrary.a")
# Or if it's a header-only library, nothing extra is needed
```

### Project's CMakeLists.txt

The project includes `vendor/vendor.cmake` and uses `find_package()`:

```cmake
cmake_minimum_required(VERSION 3.10)
project(MyApp)

# Include vendor.cmake to add all dependencies
include(vendor/vendor.cmake)

# Find the library
find_package(MyLibrary REQUIRED)

# Create executable
add_executable(my-app src/main.cpp)

# Link against the library
target_link_libraries(my-app PRIVATE MyLibrary)
```

## Creating Your Own CMake Package

To make your library compatible with Qompoter's CMake support:

1. Create a `cmake/` directory at the root of your package
2. Add a `<PackageName>Config.cmake` file that:
   - Defines where your headers are located
   - Specifies how to link against your library
   - Sets up any necessary include directories or compile definitions

Example minimal configuration:

```cmake
# Get the directory where this file is located
get_filename_component(MYPACKAGE_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(MYPACKAGE_ROOT_DIR "${MYPACKAGE_CMAKE_DIR}/.." ABSOLUTE)

# Define your package (adjust based on your needs)
add_library(MyPackage INTERFACE)
target_include_directories(MyPackage INTERFACE "${MYPACKAGE_ROOT_DIR}/include")

# If you have a pre-built library, add:
# set(MYPACKAGE_LIBRARIES "${MYPACKAGE_ROOT_DIR}/lib/libmypackage.a")
# Or for a CMake target:
# add_library(MyPackage STATIC IMPORTED)
# set_target_properties(MyPackage PROPERTIES
#     IMPORTED_LOCATION "${MYPACKAGE_ROOT_DIR}/lib/libmypackage.a"
#     INTERFACE_INCLUDE_DIRECTORIES "${MYPACKAGE_ROOT_DIR}/include"
# )
```

## Notes

- The package name in `find_package()` should match the prefix of your `*Config.cmake` file
- Qompoter only adds packages with a `cmake/` directory to `CMAKE_PREFIX_PATH`
- Use `qompoter refresh-vendor-cmake` to regenerate `vendor.cmake` after manual changes
