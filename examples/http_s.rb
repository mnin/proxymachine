proxy do |data|
  p data
  if data =~ /^CONNECT (.+):([0-9]+)?(.*)\r\n/
    remote = "#{$1}:#{$2.to_i||443}"
    { :remote => remote,
      :reply => "HTTP/1.0 200 Connection established\r\nProxy-agent: Netscape-Proxy/1.1\r\n\r\n",
      :data => '' }
  elsif data =~ /\r\nHost: (.+):?(.+)?\r\n/
    remote = "#{$1}:#{$2||80}"
    { :remote => remote }
  else
    { :noop => true }
  end 
end

# proxyfilter do |data|
#   data.gsub('abc', 'def')
# end
