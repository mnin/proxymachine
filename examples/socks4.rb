proxy do |data|
  return  if data.size < 9
  v, c, port, o1, o2, o3, o4, user = data.unpack("CCnC4a*")
  return { :close => "\0\x5b\0\0\0\0\0\0" }  if v != 4 or c != 1
  return if !idx = user.index("\0")
  {
    :remote => "#{[o1,o2,o3,o4]*'.'}:#{port}",
    :reply => "\0\x5a\0\0\0\0\0\0",
    :data => data[idx+9..-1]
  }
end
