lua_script = {}

function lua_script:scan_file(fileName)
  require "global"
  require "luatext"
  require "dump"
  require "utils"
  require 'script_parser'
  
  local fullFileName = fileName..".script"
  local outLuaFile = fileName.."_out"
  
  local parseReult = script_parse.Parse(fullFileName,outLuaFile)
  if parseReult == false then 
    logerror("Error! parse proto failed!!!fileName:"..fileName)  
    return false
  end
  log("scan_file success:"..fileName)
  return true,outLuaFile
end


function lua_script:execute(luaFileName)
  require "script_exec"
  require "script_funcs"
  local execResult = script_exec.execute(luaFileName)
  if execResult == false then 
    logerror("Error! exec lua file failed!!!luaFileName:"..luaFileName)  
    return
  end
  log("execute lua file success!!:"..luaFileName)
end


return lua_script