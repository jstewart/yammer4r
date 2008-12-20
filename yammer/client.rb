class Yammer::Client
  
   URL = 'https://www.yammer.com'
  
  def initialize
    config = YAML.load(open('oauth.yml'))
    @consumer = OAuth::Consumer.new(config['consumer']['key'],config['consumer']['secret'],:site => URL)
    @token = config['access']['token']
    @secret = config['access']['secret']
    @access_token = OAuth::AccessToken.new(@consumer,@token,@secret)
  end
  
  # { "message_type"=>"update", 
  #   "created_at"=>"2008/12/19 20:43:48 +0000", 
  #   "body"=>{"plain"=>"@sgoldberg Steve returned his laptop so I have another Macbook Pro in the office.", 
  #            "parsed"=>"[[user:131808]] Steve returned his laptop so I have another Macbook Pro in the office."}, 
  #   "client_type"=>"Web", 
  #   "system_message"=>false, 
  #   "url"=>"https://www.yammer.com/api/v1/messages/1672420", 
  #   "id"=>1672420, 
  #   "thread_id"=>1672420, 
  #   "sender_type"=>"user", 
  #   "sender_id"=>131802, 
  #   "replied_to_id"=>nil, 
  #   "web_url"=>"https://www.yammer.com/messages/1672420", 
  #   "attachments"=>[], 
  #   "client_url"=>nil }
  
  def messages
    response = @access_token.get '/api/v1/messages.json'
    JSON.parse(response.body)['messages'].map do |m|
      Yammer::Message.new(m)
    end
  end
  
end