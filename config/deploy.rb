load "deploy/assets"
require "bundler/capistrano"
require "torquebox-capistrano-support"

set :default_shell, "bash -l"

set :application, "torkel"
set :repository,  "."

set :deploy_via, :copy
set :copy_cache, false
set :copy_exclude, ".git/*"

set :deploy_to, "/var/www/#{application}"
set :torquebox_home, "/opt/torquebox/current"

set :scm, :git

set :use_sudo, true

ssh_options[:keys] = ["~/.ec2/elabs.pem"]
ssh_options[:paranoid] = false

server "torque1.elabs", :web, :app, :db
server "torque2.elabs", :web, :app, :db
