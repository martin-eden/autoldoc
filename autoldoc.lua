require('workshop.base')

local get_ast = request('!.lua.code.get_ast')

local process_named_functions = request('routines.process_named_functions')

local parse =
  function(s)
    local ast = get_ast(s)
    process_named_functions(ast)
    return ast
  end

local compile = request('!.struc.compile')

local convert = request('!.file.convert')

convert(
  {
    f_in_name = arg[1],
    f_out_name = arg[2],
    parse = parse,
    compile = compile,
  }
)

-- local create_deploy_script = request('!.formats.deploy_script.interface').save_script
-- create_deploy_script()
