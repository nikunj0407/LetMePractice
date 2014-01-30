default_run_options[:pty] = true
set :repository, "https://github.com/nikunj0407/LetMePractice.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache

set :application, "LetMePractice"
set :deploy_to, "/var/www/rails_apps/#{application}"
set :user, "ittest_admin"
set :admin_runner, "ittest_admin"

role :app, "http://letmepractice.com"
role :web, "http://letmepractice.com"
role :db, "http://letmepractice.com", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
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