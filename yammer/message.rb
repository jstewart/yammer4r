# <message>
#   <id>1102</id>
#   <url>https://www.yammer.com/api/v1/messages/1102</url>
#   <web-url>https://www.yammer.com/messages/1102</web-url>
#   <replied-to-id>1101</replied-to-id>
#   <thread-id>1101</thread-id>
#   <body>
#     <plain>I love #yammer.</plain>
#     <parsed>I love [[tag:1000]].</parsed>
#   </body>
#   <message-type>update</message-type>
#   <client-type>web</client-type>
#   <sender-id>1002</sender-id>
#   <sender-type>user</sender-type>
#   <created-at>2008-09-12T17:35:43Z</created-at>
# </message>

class Yammer::Message
  
  def initialize(m)
    @id = m['id']
  end
  
end