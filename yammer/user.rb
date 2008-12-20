class Yammer::User
  
  attr_reader :id, :url, :web_url, :name, :full_name, :mugshot_url, 
              :job_title, :location, :stats, :contact,
              :hire_date, :birth_date, :network_name, :full_user
 
  def initialize(u, c)
    @client = c
    @id = u['id']
    @url = u['url']
    @web_url = u['web_url']
    @name = u['name']
    @full_name = u['full_name']
    @mugshot_url = u['mugshot_url']
    @job_title = u['job_title']
    # These attributes will be nil when User is a reference
    @network_id = u['network_id']
    @location = u['location']
    @stats = u['stats']
    @contact = u['contact']
    @hire_date = u['hire_date']
    @birth_date = u['birth_date']
    @network_name = u['network_name']
  end
  
  def network_id
    get_full_user unless @network_id
    @network_id
  end
  
  def location
    get_full_user unless @location
    @location
  end
  
  def stats
    get_full_user unless @stats
    @stats
  end
  
  def contact
    get_full_user unless @contact
    @contact
  end
  
  def hire_date
    get_full_user unless @hire_date
    @hire_date
  end
  
  def birth_date
    get_full_user unless @birth_date
    @birth_date
  end
  
  def network_name
    get_full_user unless @network_name
    @network_name
  end
  
  def me?
    @id == @client.me.id
  end
  
  private
  def get_full_user
    response = @client.access_token.get "/api/v1/users/#{id}.json"
    u = JSON.parse(response.body)
    initialize(u, @client)
  end
  
end