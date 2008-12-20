require 'yammer'

# Create a new Yammer Client
yammer = Yammer::Client.new

# Get all messages
messages = yammer.messages
puts messages.size
puts messages.last.inspect

# Print out all the users
yammer.users.each do |u|
  puts "#{u.name} - #{u.me?}"
end



