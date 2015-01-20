utils = {}

function utils.read_from_file(fileName)
  local f = io.open(fileName, "r")
  local str = f:read("*all")
  f:close()
  return str
end

function utils.write_to_file(fileName,str)
  local f = io.open(fileName, "w")
  f:write(str)
  f:close()
end

function utils.current_dir()
  local obj=io.popen("cd")
  local path=obj:read("*all")
  obj:close()
  path = path:sub(1,-2)
  return path.."\\"
end