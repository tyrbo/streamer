require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'

# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'streamer'
set :repo_url, 'git@github.com:tyrbo/streamer.git'

set :deploy_to, '/home/app/streamer'

set :scm, :git
set :branch, 'master'
set :deploy_via, :copy

set :pty, false

#set :domain, 'stream.lolsummoners.com'
#roles :all, fetch(:domain)


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :mkdir, '-p', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    on roles(:web) do
      file = File.open('config/application.yml')
      upload! file, "#{shared_path}/application.yml"
    end
  end

  desc "Symlink application.yml to the release path"
  task :finalize do
    on roles(:web) do
      execute :ln, '-sf', "#{shared_path}/application.yml", "#{release_path}/config/application.yml"
    end
  end
end

after "deploy:started", "figaro:setup"
after "deploy:symlink:release", "figaro:finalize"
