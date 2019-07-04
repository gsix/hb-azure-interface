set :environment, ENV['RAKE_ENV'] || ENV['RAILS_ENV'] || 'development'
set :output, File.join(Whenever.path, 'log', 'whenever.log')

every 30.minute do
  runner 'Activity.import_from_hubstaff'
end
