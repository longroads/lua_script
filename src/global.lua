GLOBAL = {}

GLOBAL.SCRIPT_TYPE_VARDEF = "vardef"
GLOBAL.SCRIPT_TYPE_FUCNTION = "function"
GLOBAL.SCRIPT_TYPE_CONDITION = "condition"
GLOBAL.SCRIPT_TYPE_CONDITION_COMBINE = "cond_combine"
GLOBAL.SCRIPT_TYPE_CONDITION_ITEM = "cond_item"

GLOBALFUNC = {}
GLOBAL.GLOBALFUNC = GLOBALFUNC

function GLOBAL.reg_function(name,func)
  GLOBALFUNC[name] = func
end
function GLOBAL.get_function(name)
  return GLOBALFUNC[name]
end


function log(...)
  print(...)
end

function logerror(...)
  print(...)
end


return GLOBAL