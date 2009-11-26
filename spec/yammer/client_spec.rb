require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'ostruct'

describe Yammer::Client do
  
  it "can be created" do
    Yammer::Client.new(:consumer => {}, :access => {}).should_not be_nil
  end
  
  context "users" do
    
    before(:each) do
      @mock_access_token = mock(OAuth::AccessToken)
      @response = OpenStruct.new(:code => 200, :body => '{}')
      OAuth::AccessToken.stub!("new").and_return(@mock_access_token)
      @client = Yammer::Client.new(:consumer => {}, :access => {})
    end
    
    it "should request the first page by default" do
      @mock_access_token.should_receive("get").with("/api/v1/users.json").and_return(@response)
      @client.users
    end
    
    it "can request a specified page" do
      @mock_access_token.should_receive("get").with("/api/v1/users.json?page=2").and_return(@response)
      @client.users(:page => 2)
    end
    
  end  
  
end