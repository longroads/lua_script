script_exec = {}
local vardefs = {}

local handlers = {}
--handle_vardef,handle_function,handle_condition

local function get_func_var_result(value)
  local valueType = type(value)
  if valueType == "number" then
    return value
  elseif valueType == "string" then
    local varVal = vardefs[value]
    if not varVal then
      logerror("get_func_var_result failed, var value not found:"..value)
      return false
    end
    return varVal
  elseif valueType == "table" then
    if value.type == GLOBAL.SCRIPT_TYPE_FUCNTION then
      local result = handlers.handle_function(value)
      if result ~= false then
        return result
      else
        logerror("get_func_var_result handle_function failed")
        return false
      end
    else
      logerror("get_func_var_result, table can only support function:"..value.type)
      return false
    end
  else
    logerror("get_func_var_result failed,valueType:"..valueType)
    return false
  end
  return false
end

function handlers.handle_vardef(vardef)
  local key = vardef.var_key
  local valToDef = vardef.var_value
  local value = get_func_var_result(valToDef)
  if value then
    vardefs[key] = value
  end
  return true
end

function handlers.handle_function(func)
  local funcName = func.func_name
  local funcArgs = func.func_args
  local handleFunc = GLOBAL.get_function(funcName)
  if (not handleFunc) then
    logerror("handle_function failed,handleFunc not found:"..funcName)
    return false
  end
  return handleFunc(funcArgs)
end

local function compare_func(leftVal,rightVal,compare)
  if compare == ">" then
    return leftVal > rightVal
  elseif compare == "<" then
    return leftVal < rightVal
  elseif compare == ">=" then
    return leftVal >= rightVal
  elseif compare == "<=" then
    return leftVal <= rightVal
  elseif compare == "==" then
    return leftVal == rightVal
  elseif compare == "=/=" then
    return leftVal ~= rightVal
  else
    logerror("compare error for invalid op:"..compare)
  end
  return false
end

local function get_condition_item_result(condItem)
  local leftVal = get_func_var_result(condItem.left_param)
  local compare = condItem.compare
  local rightVal = get_func_var_result(condItem.right_param)
  return compare_func(leftVal,rightVal,compare)
end

local function get_condition_combine_result(condition)
  local out_logic = condition.out_logic
  local in_logic = condition.in_logic
  local in_result = false
  if in_logic == "&&" then in_result = true end
  
  for k,v in ipairs(condition) do
    local result = true
    if v.type == GLOBAL.SCRIPT_TYPE_CONDITION_ITEM then
      result = get_condition_item_result(v)
    elseif v.type == GLOBAL.SCRIPT_TYPE_CONDITION_COMBINE then
      local rc,subResult = get_condition_combine_result(v)
      if not rc then return false end
      result = subResult
    else
      logerror("get_condition_result failed,condition k:"..k)
      return false
    end
    
    if result and in_logic == "||" then
      in_result = true
      break;
    elseif not result and in_logic == "&&" then
      in_result = false
      break
    end
  end
  
  if out_logic == "!" then 
    return true, not in_result
  end
  return true, in_result
end

local function hanle_sub_statement(subStatement)
  if not subStatement then return true end
  local handleResult = false
  for k,v in ipairs(subStatement) do
    if v.type == GLOBAL.SCRIPT_TYPE_FUCNTION then
      handleResult = handlers.handle_function(v)
    elseif v.type == GLOBAL.SCRIPT_TYPE_CONDITION then
      handleResult = handlers.handle_condition(v)
    elseif v.type == GLOBAL.SCRIPT_TYPE_VARDEF then
      handleResult = handlers.handle_vardef(v)
    end
    if not handleResult then
      logerror("hanle_sub_statement failed for type:"..v.type.." at key:"..k)
      return false
    end
  end
  return true
end

function handlers.handle_condition(cond)
  local condition = cond.condition
  local true_statement = cond.true_statement
  local false_statement = cond.false_statement
  local rc,condResult = get_condition_combine_result(condition)
  if not rc then 
    logerror("get_condition_combine_result failed")
    return false
  end
  
  local subResult = false
  if condResult then
    subResult = hanle_sub_statement(cond.true_statement)
  else
    subResult = hanle_sub_statement(cond.false_statement)
  end
  
  return subResult
end


function script_exec.execute(protoLuaFile)
  vardefs = {}
  
  local scriptTab = require(protoLuaFile)
  if type(scriptTab) ~= "table" then
    logerror("Invalid script luatab file!!!!"..protoLuaFile)
    return false
  end
  
  for k,v in ipairs(scriptTab) do
    if not v then 
      logerror("Invalid script tablua file!!!!"..protoLuaFile.." at key:"..k)
      return false
    end
    
    local handleResult = false
    if v.type == GLOBAL.SCRIPT_TYPE_VARDEF then
      handleResult = handlers.handle_vardef(v)
    elseif v.type == GLOBAL.SCRIPT_TYPE_FUCNTION then
      handleResult = handlers.handle_function(v)
    elseif v.type == GLOBAL.SCRIPT_TYPE_CONDITION then
      handleResult = handlers.handle_condition(v)
    end
    
    if handleResult == false then
      logerror("Invalid script tablua item type:"..v.type.." at key:"..k)
      return false
    end
  end
  return true
end
