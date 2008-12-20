require 'yammer'

yammer = Yammer::Client.new
puts yammer.messages.inspect