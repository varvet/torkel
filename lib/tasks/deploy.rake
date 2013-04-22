task :deploy do
  Rake::Task["assets:precompile"].invoke
  Rake::Task["torquebox:remote:stage"].invoke
  Rake::Task["assets:clean"].invoke
  Rake::Task["torquebox:remote:stage:deploy"].invoke
  Rake::Task["torquebox:remote:exec"].invoke("bundle exec rake db:migrate")
end
