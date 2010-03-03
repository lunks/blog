
require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

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
  set :url,       "http://mindtables.heroku.com"
  set :markdown,  :smart
  set :cache,      28800
  set :date, lambda {|now| now.strftime("%d %B %Y") }

end

run toto

# vim: set syn=ruby:
