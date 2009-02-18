module Yammer
  class Client

    def initialize(options={})
      options.assert_has_keys(:consumer, :access) unless options.has_key?(:config)
      
      @yammer_host = options.delete(:yammer_host) || "yammer.com"

      if options[:config]
        config              = YAML.load(open(options[:config]))
        options[:consumer]  = config['consumer'].symbolize_keys
        options[:access]    = config['access'].symbolize_keys
      end

      consumer = OAuth::Consumer.new(options[:consumer][:key], options[:consumer][:secret], :site => "https://#{@yammer_host}")
      @access_token = OAuth::AccessToken.new(consumer, options[:access][:token], options[:access][:secret])
    end

    def messages(action = :all, params = nil)
      http_method = (action == :new ? :post : :get)
      url = case action
                 when :all:
                   "/api/v1/messages.json"
                 when :sent, :received, :following:
                   "/api/v1/messages/#{action}.json"
                 when :new
                   raise "Not implemented"
                 when :from_user, :tagged_with, :in_thread
                   raise "Not implemented"
                 else
                   raise ArgumentError, "Invalid messaging action: #{action}"
                 end

      response = handle_response(@access_token.send(http_method, url))
       
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

    def handle_response(response)
      # TODO: Write classes for exceptions
      case response.code
        when '200'
          response
        when '400'
          raise "400 Bad request"
        when '401'
          raise  "Authentication failed. Check your username and password"
        when '503'
          raise "503: Service Unavailable"
        else
          raise "Error. HTTP Response #{response.code}"
        end   
    end

  end
end
