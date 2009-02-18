Gem::Specification.new do |s|
  s.name    = 'yammer4r'
  s.version = '0.1.2'
  s.date    = '2009-02-18'

  s.summary = "Yammer access for ruby"
  s.description = "Yammer4R provides an object based API to query or update your Yammer account via pure Ruby.  It hides the ugly HTTP/REST code from your code."

  s.authors  = ['Jim Patterson', 'Jason Stewart']
  s.email    = 'jimp79@gmail.com'
  s.homepage = 'http://github.com/jpatterson/yammer4r'

  s.has_rdoc = false
  s.files = %w(README example.rb oauth.yml.template lib/yammer4r.rb lib/yammer/client.rb lib/yammer/message.rb lib/yammer/message_list.rb lib/yammer/user.rb lib/ext/core_ext.rb)

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.2.7"])
    else
      s.add__dependency(%q<json>, [">= 1.1.3"])
      s.add__dependency(%q<oauth>, [">= 0.2.7"])
    end
  else
    s.add__dependency(%q<json>, [">= 1.1.3"])
    s.add__dependency(%q<oauth>, [">= 0.2.7"])
  end

end

