script_funcs = {}

------------------------------------------------------
function script_funcs.varfunc1(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
------------------------------------------------------
function script_funcs.cond1(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.cond2(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.cond3(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.cond4(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
------------------------------------------------------
function script_funcs.sub_true_func1(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.sub_true_func2(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.sub_false_func1(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.sub_false_func2(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
------------------------------------------------------
function script_funcs.func1(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end
function script_funcs.func2(args)
  local param1 = args[1]
  local param2 = args[2]
  if type(param1) == "number" and type(param2) == "number" then
    return param1 + param2
  end
  return false
end

------------------------------------------------------
for k,v in pairs(script_funcs) do
  GLOBAL.reg_function(k,v)
end

return script_funcs