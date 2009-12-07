require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "git-pair"
    gem.summary = %Q{Configure git to commit as more than one author}
    gem.description = %Q{Configure git to commit as more than one author}
    gem.email = "chris@kampers.net"
    gem.homepage = "http://github.com/chrisk/git-pair"
    gem.authors = ["Chris Kampmeier"]
    gem.add_development_dependency "cucumber", ">= 0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :features
