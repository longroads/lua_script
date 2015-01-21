##Lua Script
根据以前游戏中脚本逻辑修改而成。
生成Lua脚本逻辑，并进行执行。

####脚本例子

```
a = 10
b = varfunc1(1,2)
if ( cond1(1,2) > a && (cond2(3,4) > b || cond3(5,6) > a) && cond4(7,8) > b ) {
	sub_true_func1(3,4)
	sub_true_func2(4,5)
}
else
{
	sub_false_func1(6,7)
	sub_false_func2(8,9)
}
func1(4, 5)
func2(5,4)
```

####使用方式
主要分为三步：
```
  -- 加载接口文件
  require "lua_script"

  -- 设置脚本文件，执行生成lua代码
  local script_name = "script_example"
  local result,outFileName = lua_script:scan_file(script_name)
  
  -- 执行脚本文件
  lua_script:execute(outFileName)
```

一般脚本生成lua之后进行编译和打包，运行时加载后执行脚本即可。

####文件列表
```
lua_script.lua:接口文件

script_parser.lua： 脚本解析
script_exec.lua：解析后执行处理
script_funcs.lua： 所需函数定义文件
global.lua：全局定义
dump.lua：脚本解析后[写文件方法](http://blog.csdn.net/lixianlin/article/details/24739499)

script_example.script: 脚本例子
script_example_out.lua： 脚本例子解析后输出文件
example.lua：使用例子
```

####基于[Anaminus/luatext](https://github.com/Anaminus/luatext)，Thanks a lot!!!

