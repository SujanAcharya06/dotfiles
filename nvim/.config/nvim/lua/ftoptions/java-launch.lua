-- Command to create a Java launch.json boilerplate
vim.api.nvim_create_user_command("JavaLaunchInit", function()
  local launch_dir = ".vscode"
  local launch_file = launch_dir .. "/launch.json"

  -- Make .vscode directory if missing
  vim.fn.mkdir(launch_dir, "p")

  -- Boilerplate JSON for Java debugging
  local boilerplate = [[
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Debug Current File",
      "request": "launch",
      "mainClass": "${fileBasenameNoExtension}",
      "cwd": "${fileDirname}",
      "preLaunchTask": "compile-java"
    }
  ],
  "tasks": {
    "label": "compile-java",
    "type": "shell",
    "command": "javac -g ${file}"
  }
}
]]

  -- Write the file
  local f = io.open(launch_file, "w")
  if f then
    f:write(boilerplate)
    f:close()
    print("✅ Java launch.json created at " .. launch_file)
  else
    print("❌ Failed to create " .. launch_file)
  end
end, {})
