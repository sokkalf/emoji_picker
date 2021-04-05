def weechat_init
  Weechat.register('emoji_picker', 'Christian Lønaas <christian.lonaas@ugle-z.no>', '0.1', 'MIT', 'Emoji picker', '', '')
  Weechat.hook_command('emoji', 'Emojipicker', '', '', '', 'emoji_picker', '')
  return Weechat::WEECHAT_RC_OK
end

def emoji_picker(data, buffer, args)
  em=(%x{cat /home/sokkalf/emojis.txt | fzf-tmux -d25% --tiebreak=index}&.split&.first || "")
  pos = Weechat.buffer_get_integer(Weechat.current_buffer, 'input_pos')
  current_input = Weechat.buffer_get_string(Weechat.current_buffer, 'input')
  Weechat.buffer_set(Weechat.current_buffer, 'input',  current_input.insert(pos.to_i, em))
  Weechat.buffer_set(Weechat.current_buffer, 'input_pos', (pos + 1).to_s)
  return Weechat::WEECHAT_RC_OK
end
