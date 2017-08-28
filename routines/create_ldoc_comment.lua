local trim_linefeed = request('!.string.trim_linefeed')

local default_descr = '-- <place description here>'

return
  function(header, params)
    assert_string(header)
    assert_table(params)

    if (header == '') then
      header = default_descr
    end
    header = trim_linefeed(header)

    local result = {}

    result[#result + 1] = '---'
    result[#result + 1] = header
    for i = 1, #params do
      local param_desc
      param_desc = ('-- @param %s'):format(params[i])
      result[#result + 1] = param_desc
    end
    result[#result + 1] = ''

    result = table.concat(result, '\n')

    return result
  end
