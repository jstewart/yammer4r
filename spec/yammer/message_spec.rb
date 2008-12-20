require File.join(File.dirname(__FILE__), '..', 'spec_helper')
 
describe Yammer::Client, "#message" do
  before(:each) do
    @twitter = client_context
    @message = 'This is my unique message'
    @uris = Twitter::Client.class_eval("@@STATUS_URIS")
    @options = {:id => 666666}
    @request = mas_net_http_get(:basic_auth => nil)
    @response = mas_net_http_response(:success, '{}')
    @connection = mas_net_http(@response)
    @float = 43.3434
    @status = Twitter::Status.new(:id => 2349343)
    @source = Twitter::Client.class_eval("@@defaults[:source]")
  end
 
  it "should return nil if nil is passed as value argument for :get case" do
    status = @twitter.status(:get, nil)
    status.should be_nil
  end

end