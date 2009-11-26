require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'ostruct'

describe Yammer::Client do
  
  it "can be created" do
    Yammer::Client.new(:consumer => {}, :access => {}).should_not be_nil
  end
  
end