return
  {
    f_in_name = '',
    f_out_name = '',

    init = request('init'),
    run = request('run'),

    load = request('!.file.text_file_as_string'),
    parse = request('!.formats.lua_table_code.load'),
    compile = request('compile'),
    save = request('!.string.save_to_file'),

    say = request('say'),
    get_state_str = request('get_state_str'),
    error = request('error'),
  }
