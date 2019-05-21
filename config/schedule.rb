set :environment, ENV['RAKE_ENV'] || ENV['RAILS_ENV'] || 'development'
set :output, File.join(Whenever.path, 'log', 'whenever.log')

every 1.hour do
  runner 'Activity.import_from_hubstaff'
end
