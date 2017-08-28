local get_name =
  function(node)
    assert(node.type == 'name')
    for i = 1, #node do
      if is_string(node[i]) then
        return node[i]
      end
    end
  end

local get_params =
  function(node)
    local result = {}

    local name_list, vararg

    for i = 1, #node do
      if (node[i].type == 'name_list') then
        name_list = node[i]
      elseif (node[i].type == 'vararg') then
        vararg = node[i]
        break
      end
    end

    if name_list then
      for i = 1, #name_list do
        if (name_list[i].type == 'name') then
          result[#result + 1] = get_name(name_list[i])
        end
      end
    end

    if vararg then
      result[#result + 1] = '...'
    end

    return result
  end

return
  function(node)
    assert(node.type == 'named_function')

    local params_rec
    for i = 1, #node do
      if (node[i].type == 'function_params') then
        params_rec = node[i]
        break
      end
    end
    assert(params_rec)

    local result
    result = get_params(params_rec)

    return result
  end

--[[
  'function',
  {
    type = 'dot_list',
    {
      type = 'name',
      {
        type = 'whitespace',
        ' ',
      },
      'M',
    },
    '.',
    {
      type = 'name',
      'lock',
    },
  },
  {
    type = 'function_params',
    '(',
    {
      type = 'name_list',
      {
        type = 'name',
        't',
      },
      ',',
      {
        type = 'name',
        {
          type = 'whitespace',
          ' ',
        },
        'k',
      },
      ',',
      {
        type = 'name',
        {
          type = 'whitespace',
          ' ',
        },
        'v',
      },
    },
    ',',
    {
      type = 'vararg',
      {
        type = 'whitespace',
        ' ',
      },
      '...',
    },
    ')',
  },

]]
