class Yammer::Client

  URL = 'https://www.yammer.com'

  attr_accessor :access_token

  def initialize(options={})
    options.assert_has_keys(:consumer, :access) unless options.has_key?(:config)

    if options[:config]
      config              = YAML.load(open(options[:config]))
      options[:consumer]  = config['consumer'].symbolize_keys
      options[:access]    = config['access'].symbolize_keys
    end

    consumer = OAuth::Consumer.new(options[:consumer][:key], options[:consumer][:secret], :site => options[:site] || URL)
    @access_token = OAuth::AccessToken.new(consumer, options[:access][:token], options[:access][:secret])
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

  def post_message(body, reply_id=nil, attachments=[])
    if attachments.size > 20
      raise ArgumentError "Yammer prevents more than 20 attachments to a single message" 
    end

    encoded_attachments = attachments.inject({}) do |hsh, attachment|
    end

    post_opts = {:body => body, :reply_id => reply_id}.compact
    raise post_opts.inspect
    @access_token.post "/api/v1/messages", post_opts
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

  def encode attachment(attachment)
    
  end

end
