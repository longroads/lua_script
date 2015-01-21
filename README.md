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

####文件列表
script_parser.lua： 脚本解析
script_exec.lua：解析后执行处理
script_funcs.lua： 所需函数定义文件
global.lua：全局定义
dump.lua：脚本解析后[写文件方法](http://blog.csdn.net/lixianlin/article/details/24739499)

script_proto.txt: 脚本例子
script_proto_parsed.lua： 脚本例子解析后输出文件
mainTest.lua：例子运行入口


####基于[Anaminus/luatext](https://github.com/Anaminus/luatext)，Thanks a lot!!!

