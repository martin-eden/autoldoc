return
  function(file_name, mode, no_errors)
    assert_string(file_name)
    mode = mode or 'rb'
    assert_string(mode)
    local f_object, err_msg = io.open(file_name, mode)
    if not f_object and not no_errors then
      error(err_msg, 2)
    end
    return f_object
  end