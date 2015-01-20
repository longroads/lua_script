1. 根据以前游戏中脚本逻辑修改而成，可解析类似如下的脚本

<pre><code>
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
</pre></code>

2. 词法分析跟基于Anaminus/luatext（https://github.com/Anaminus/luatext），Thanks a lot!!!

