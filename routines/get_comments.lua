return
  function(node, start, finish)
    local result = {}

    for i = start, finish do
      if (node[i].type == 'whitespace') and (node[i][1].type == 'comment') then
        result[#result + 1] = node[i][1][1]
      end
    end

    return result
  end

--[[
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
]]
