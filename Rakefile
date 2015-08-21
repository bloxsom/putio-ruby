require "bundler/gem_tasks"


task :console do
  require 'pry'
  require 'putio'

  def reload!
    Dir.glob("lib/**/*").reject { |fn| File.directory?(fn) }.each { |fn| load fn }
  end

  #Putio.configure
  Pry.start
end

