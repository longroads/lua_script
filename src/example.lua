function main()
  require "lua_script"
  
  local script_name = "script_example"
  local result,outFileName = lua_script:scan_file(script_name)
  if not result then 
    logerror("failed to scan file:"..script_name)
    return
  end
  
  lua_script:execute(outFileName)
end
main()