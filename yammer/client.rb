class Yammer::Client
  
   URL = 'https://www.yammer.com'
   
   attr_reader :access_token
  
  def initialize
    config = YAML.load(open('oauth.yml'))
    @consumer = OAuth::Consumer.new(config['consumer']['key'],config['consumer']['secret'],:site => URL)
    @token = config['access']['token']
    @secret = config['access']['secret']
    @access_token = OAuth::AccessToken.new(@consumer,@token,@secret)
  end
  
  def messages(action = :all)
    response = case action
      when :all:
      @access_token.get "/api/v1/messages.json"
      when :sent, :received, :following:
      @access_token.get "/api/v1/messages/#{action}.json"
      else
      raise ArgumentError, "Invalid messaging action: #{action}"
    end
    parsed_response = JSON.parse(response.body)
    older_available = parsed_response['meta']['older_available']
    ml = parsed_response['messages'].map do |m|
      Yammer::Message.new(m)
    end
    Yammer::MessageList.new(ml, older_available, self)
  end
  
  def users
    response = @access_token.get "/api/v1/users.json"
    JSON.parse(response.body).map do |u|
      Yammer::User.new(u, self)
    end
  end
  
  def user(id)
    response = @access_token.get "/api/v1/users/#{id}.json"
    u = JSON.parse(response.body)
    Yammer::User.new(u, self)
  end
  
  def me
    @me ||= current_user
  end
  
  private
  def current_user
    response = @access_token.get "/api/v1/users/current.json"
    u = JSON.parse(response.body)
    Yammer::User.new(u, self)
  end
  
end