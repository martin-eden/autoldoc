local get_comments = request('get_comments')
local get_function_params = request('get_function_params')
local create_ldoc_comment = request('create_ldoc_comment')

local process
process =
  function(node)
    if not is_table(node) then
      return
    end

    if (node.type == 'local_statement') then
      return
    end

    if (node.type == 'named_function') then
      local start = 1
      while node[start] and (node[start] ~= 'function') do
        start = start + 1
      end
      assert(node[start] == 'function')
      local comments = get_comments(node, 1, start - 1)
      local comments_block = table.concat(comments)
      local is_ldoc_comment
      is_ldoc_comment = comments[1] and (comments[1]:sub(1, 3) == '---')

      if is_ldoc_comment then
        -- This is first stage, no futher processing.
        -- print('is_ldoc_comment')
        -- print(comments_block)
      else
        -- Use existing comments as header for ldoc comment.
        -- print('not is_ldoc_comment')
        -- print(comments_block)

        local params = get_function_params(node)
        local ldoc_comment = create_ldoc_comment(comments_block, params)
        -- print(ldoc_comment)

        -- Skip leading whitespaces.
        local start = 1
        while
          (node[start].type == 'whitespace') and
          (node[start][1].type ~= 'comment')
        do
          start = start + 1
        end
        -- Delete existing comments and insert generated comment.
        while (node[start] ~= 'function') do
          table.remove(node, start)
        end
        table.insert(node, start, ldoc_comment)
      end

    end

    for i = 1, #node do
      process(node[i])
    end
  end

return process

--[[
  {
    type = 'named_function',
    {
      type = 'whitespace',
      '\x0A\x0A',
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-------------------------------------------------------------------------------\x0A',
      },
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-- Removes spaces from the begining and end of a given string, considering the\x0A',
      },
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-- string is inside a lua comment.\x0A',
      },
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-- @param s string to be trimmed\x0A',
      },
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-- @return trimmed string\x0A',
      },
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-- @see trim\x0A',
      },
    },
    {
      type = 'whitespace',
      {
        type = 'comment',
        '-- @see string.gsub\x0A',
      },
    },
    {
      type = 'whitespace',
      '\x0A',
    },
    'function',

]]
