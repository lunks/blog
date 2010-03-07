require 'toto'

@config = Toto::Config::Defaults

task :default => :new

desc "Create a new article."
task :new do
  title = ask('Title: ')
  slug = title.empty?? nil : title.strip.slugize

  article = {'title' => title, 'date' => Time.now.strftime("%d/%m/%Y")}.to_yaml
  article << "\n"
  article << "Once upon a time...\n\n"

  path = "#{Toto::Paths[:articles]}/#{Time.now.strftime("%Y-%m-%d")}#{'-' + slug if slug}.#{@config[:ext]}"

  unless File.exist? path
    File.open(path, "w") do |file|
      file.write article
    end
    toto "an article was created for you at #{path}."
  else
    toto "I can't create the article, #{path} already exists."
  end
end

desc "Publish my blog."
task :publish do
  toto "publishing your article(s)..."
  `git push heroku master`
end

begin
  require 'seo_checker'
   desc "Test for SEO"
   task :seo do
       toto "testing for SEO support (namely, sitemap)..."
       require 'seo_checker'
       SEOChecker.new("http://127.0.0.1:9292").check
   end
rescue LoadError
    task :seo do
        abort "SEO Checker is not available. In order to run seo, you must: sudo gem install seo_checker"
    end
end

def toto msg
  puts "\n  toto ~ #{msg}\n\n"
end

def ask message
  print message
  STDIN.gets.chomp
end

