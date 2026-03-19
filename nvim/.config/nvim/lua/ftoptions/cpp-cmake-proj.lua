-- ~/.config/nvim/lua/config/cpp-cmake-project.lua

vim.api.nvim_create_user_command("CppCmakeProj", function()
  local project_name = vim.fn.input("Enter C++ CMake project name: ")

  if project_name == "" then
    print("❌ Project name cannot be empty")
    return
  end

  local root = project_name

  -- directories
  local dirs = {
    root .. "/src",
    root .. "/build",
  }

  for _, dir in ipairs(dirs) do
    vim.fn.mkdir(dir, "p")
  end

  ---

  local main_cpp = [[
#include <iostream>

int main() {
std::cout << "Hello, CMake C++ Project!" << std::endl;
return 0;
}
]]

  local f = io.open(root .. "/src/main.cpp", "w")
  if f then
    f:write(main_cpp)
    f:close()
  end

  ---

  local cmake_file = [[
cmake_minimum_required(VERSION 3.10)

project(]] .. project_name .. [[)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

add_executable(]] .. project_name .. [[ src/main.cpp)
]]

  local f2 = io.open(root .. "/CMakeLists.txt", "w")
  if f2 then
    f2:write(cmake_file)
    f2:close()
  end

  ---

  local readme = [[

# ]] .. project_name .. [[

Minimal C++ project using **CMake**.

## Project Structure

```
]] .. project_name .. [[
├── src
│   └── main.cpp
├── build
└── CMakeLists.txt
```

## Requirements

* C++ compiler (g++ or clang++)
* CMake

Check installation:

```bash
g++ --version
cmake --version
```

## Build Instructions

From the project root:

```bash
cmake -B build -S .
```

This generates build files inside the `build/` directory.

Compile:

```bash
cmake --build build
```

## Run

```
./build/]] .. project_name .. [[
```

## Clean Build

Remove build directory:

```
rm -rf build
```

Then rebuild:

```
cmake -B build -S .
cmake --build build
```

## Notes

* `src/` contains source files
* `build/` contains compiled artifacts
* `CMakeLists.txt` defines build configuration

This structure scales well when adding libraries, tests, or multiple executables.
]]

  local f3 = io.open(root .. "/README.md", "w")
  if f3 then
    f3:write(readme)
    f3:close()
  end

  print("✅ CMake C++ project created: " .. project_name)
end, {})
