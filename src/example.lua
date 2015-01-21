function main()
  -- 加载接口文件
  require "lua_script"
  
  -- 设置脚本文件名
  local script_name = "script_example"
  
  -- 处理脚本文件，生成lua代码
  local result,outFileName = lua_script:scan_file(script_name)
  if not result then 
    logerror("failed to scan file:"..script_name)
    return
  end
  
  -- 执行脚本文件
  lua_script:execute(outFileName)
end
main()