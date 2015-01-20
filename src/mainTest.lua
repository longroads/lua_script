function main()
  require "global"
  require "luatext"
  require "dump"
  require "utils"
--  parser = luatext.MakeParser(definition)
--  parser(rule, input, actions)

  require "script_funcs"
  local script_parse = require 'script_parser'
  local script_exec = require 'script_exec'
  local protoFile = "src/script_proto.txt"
  local protoLuaFileName = "script_proto_parsed"
  local protoLuaFile = "src/"..protoLuaFileName..".lua"
  local parseReult = script_parse.Parse(protoFile,protoLuaFile)
  if parseReult == false then 
    logerror("Error! parse proto failed!!!")  
    return
  end
  local execResult = script_exec.execute(protoLuaFileName)
  if execResult == false then 
    logerror("Error! exec proto failed!!!")  
    return
  end
  log("success!!")
end
main()