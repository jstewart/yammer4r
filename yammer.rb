module Yammer; end
 
def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end
 
require('rubygems')
require('date')
require('yaml')
require('open-uri')
require('json')
require('oauth/consumer')
 
require_local('ext/core_ext')
require_local('yammer/client')
require_local('yammer/message')
require_local('yammer/message_list')
require_local('yammer/user')
