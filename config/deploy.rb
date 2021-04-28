# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "network_dashboard"
set :repo_url, "git@github.com:mschaf/network_dashboard.git"
set :deploy_to, "/var/www/app"

set :nvm_node, File.read('.nvmrc')
set :nvm_map_bins, %w{node npm yarn rake}
