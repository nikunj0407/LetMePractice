#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require "bundler/capistrano"
set :rake, 'bundle exec rake'

default_run_options[:pty] = true
set :repository, "https://github.com/nikunj0407/LetMePractice.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache

set :application, "LetMePractice"
set :deploy_to, "/var/www/rails_apps/#{application}"
set :user, "root"
set :admin_runner, "root"

set :rvm_type, :system

role :app, "letmepractice.com"
role :web, "letmepractice.com"
role :db, "letmepractice.com", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
  desc "Start Application -- not needed for Passenger"
  task :start, :roles => :app do
    # nothing -- need to override default cap start task when using Passenger
  end
end

#set :application, "set your application name here"
#set :repository,  "set your repository location here"
#
#set :scm, :subversion
## Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
#
## if you're still using the script/reaper helper you will need
## these http://github.com/rails/irs_process_scripts
#
## If you are using Passenger mod_rails uncomment this:
## namespace :deploy do
##   task :start do ; end
##   task :stop do ; end
##   task :restart, :roles => :app, :except => { :no_release => true } do
##     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
##   end
## end