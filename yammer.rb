module Yammer; end
 
def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end
 
require('rubygems')
require('yaml')
require('open-uri')
require('json')
require('oauth/consumer')
 
require_local('yammer/client')
require_local('yammer/message')