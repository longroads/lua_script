local luatext = require 'luatext'
script_parse = {}

function ToString(obj)
  local t = type(obj)
  if t == 'table' then
    local s = '{'
    local k = next(obj)
    if not k then s = '{}' end
    while k do
      if type(k) == 'number' then
        s = s..ToString(obj[k])
      elseif type(k) == 'string' then
        s = s..k.."="..ToString(obj[k])
      else
        s = s..ToString(k).."="..ToString(obj[k])
      end
      k = next(obj, k)
      s = s..(k and "," or "}")
    end
    return s
  elseif t == 'string' then
    return "'"..obj.."'"
  else
    return tostring(obj)
  end
end


local CommandParser = luatext.MakeParser([[
  <compare> := `>` | `<` | `==` | `>=` | `<=`;
  <arithmetic> := `+` | `-` | `*` | `/`;
  <logic> := `&&` | `||` | `!`;
  
  <arg> := <the_function> | <number> | <word> ;
  <args> := {[]}( <arg> ) 
            [ ( `,` {[]}(<arg>) )* ];
  
  <the_function_raw> := {func_name}(<word>) `(` {func_args}(<args>) `)`;
  <the_function> := {trans_the_function()} (<the_function_raw>) ;
  
  <the_condition_compare_item1_raw> := `(` {left_param}(<arg>) {compare}(<compare>) {right_param}(<arg>) `)`;
  <the_condition_compare_item2_raw> := {left_param}(<arg>) {compare}(<compare>) {right_param}(<arg>);
  <the_condition_logic_item_raw> := {out_logic}([<logic>]) `(` {[]}(<the_condition_combine>) 
                                                               [({in_logic}(<logic>) {[]}(<the_condition_combine>))*]
                                                           `)`; 
  
  <the_condition_compare_item> := {trans_condition_compare_item()}(<the_condition_compare_item1_raw> | <the_condition_compare_item2_raw>);
  <the_condition_logic_item> := {trans_condition_logic_item()}(<the_condition_logic_item_raw>);
  <the_condition_combine> := <the_condition_logic_item> | <the_condition_compare_item>;
  
  <the_if_condition_raw> := `if` {condition}(<the_condition_combine>)  
                            `{` {true_statement[]}(<statement>)* `}`;
  <the_if_else_condition_raw> := `if` {condition}(<the_condition_combine>) 
                                 `{` {true_statement[]}(<statement>)* `}` `else` 
                                 `{` {false_statement[]}(<statement>)* `}`;
  <the_total_condition> := {trans_the_condition()} (<the_if_else_condition_raw> | <the_if_condition_raw>);
  
  <the_var_define_raw> := {var_key}(<word>) `=` {var_value}(<arg>);
  <the_var_define> := {trans_the_var_define()}(<the_var_define_raw>);
  
  <statement> := <the_total_condition>|<the_function> | <the_var_define>;
  
  <script> :=  {[]}(<statement>)*;
  
  <exe> := 
    !Bad script~~~!
    {exe_script()}(<script>)
    ;
]])
local output_file = ""

local output_header = "local scriptTab = \n"
local output_footer = "\nreturn scriptTab\n"

local CommandActions = {
  exe_script = function(Script)
    local str = dump(Script)
--    log("exe_script:\n", str)
    str = output_header..str..output_footer
    utils.write_to_file(output_file,str)
  end,
  trans_the_function = function(func)
    func["type"] = GLOBAL.SCRIPT_TYPE_FUCNTION
    return func
  end,
--  trans_the_condition = function(cond)
--    cond["type_base"] = "the_condition"
--    return cond
--  end,
  trans_condition_logic_item = function(item)
    item["type"] = GLOBAL.SCRIPT_TYPE_CONDITION_COMBINE
    return item
  end,
  trans_condition_compare_item = function(item)
    item["type"] = GLOBAL.SCRIPT_TYPE_CONDITION_ITEM
    return item
  end,
  trans_the_condition = function(item)
    item["type"] = GLOBAL.SCRIPT_TYPE_CONDITION
    return item
  end,
  trans_the_var_define = function(item)
    item["type"] = GLOBAL.SCRIPT_TYPE_VARDEF
    return item
  end
}

--while true do
--  io.write("> ")
--  local str = io.read()
--  local st, err = pcall(function()
--    CommandParser('exe', str, CommandActions)
--  end)
--  if err then
--    log("\tError: "..err)
--  end
--end


function script_parse.Parse(protoFile,protoTableFile)
  --utils.read_from_file("./abc.txt","abcd")
  output_file = protoTableFile..".lua"
  local str = utils.read_from_file(protoFile)

  local restr, err = pcall(function()
    CommandParser('exe', str, CommandActions)
  end)
  if err then
    logerror("\tError: "..err)
    return false
  end
  return true
end
