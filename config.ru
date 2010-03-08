require 'rack'
require 'rack/contrib'
require 'coderay'
require 'rack/codehighlighter'
require 'rack/less'

require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger
use Rack::Deflect

if ENV['RACK_ENV'] == 'development'
  require 'rack/bug'

  use Rack::ShowExceptions
  use Rack::Profiler
  use Rack::Bug
end

use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true

Rack::Less.configure do |config|
    config.compress = :yui # Requires yui-compressor gem
    config.cache = (ENV['RACK_ENV'] == 'development') # Heroku is read-only, so only cache in development
end
use Rack::Less, :source => "less/"

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  #
  # See http://github.com/cloudhead/toto#readme for the configuration keys

  set :author,    "Colin Shea"
  set :title,     "Mind Tables"
  set :url,       (ENV['RACK_ENV'] == 'development') ? "http://localhost" : "http://mindtables.heroku.com"
  set :markdown,  :smart
  set :cache,      28800
  set :date, lambda {|now| now.strftime("%d %B %Y") }

  # set :author,    ENV['USER']                               # blog author
  # set :title,     Dir.pwd.split('/').last                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
  # set :disqus,    false                                     # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

end

run toto

# vim: set syn=ruby:
