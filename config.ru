require 'bundler'
Bundler.require
Bitly.use_api_version_3
# Rack config
use Rack::Static, :urls => ['/css', '/js', '/img', '/favicon.ico', '/fonts', '/robots.txt'], :root => 'public'
use Rack::CommonLogger
use Rack::Deflect
use Rack::StaticIfPresent, :urls => ["/"], :root => "public"

if ENV['RACK_ENV'] == 'development'
  Bundler.require(:development)
  use Rack::ShowExceptions
  use Rack::Bug
end

use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true
toto = Toto::Server.new do
  set :author,    "Pedro Nascimento"
  set :title,     "asilia"
  set :url,       (ENV['RACK_ENV'] == 'development') ? "http://localhost" : "http://tunein.heroku.com"
  set :markdown,  :smart
  set :cache,      28800
  set :date, lambda {|now| now.strftime("%d %B %Y") }
  set :error_page, lambda {|code| "Sadly, there is an error. You made it go #{code}, thanks a lot." }
end

run toto
