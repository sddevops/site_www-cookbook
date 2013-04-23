#
# Copyright:: Copyright (c) 2013 Alexander van Zoest
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "git"
include_recipe "apache2"
#include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_env"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_setenvif"
include_recipe "apache2::mod_headers"

directory "/srv/#{node[:site_www][:app_name]}" do
  owner node[:site_www][:user]
  group "users"
  mode "0775"
  action :create
end

directory "/srv/#{node[:site_www][:app_name]}/shared" do
  owner node[:site_www][:user]
  group "users"
  mode "0775"
  action :create
end

%w{config log pids system}.each do |dir|
  directory "/srv/#{node[:site_www][:app_name]}/shared/#{dir}" do
    recursive true
    owner node[:site_www][:user]
    group "users"
    mode "0775"
  end
end

ssh_known_hosts_entry 'github.com'

deploy_revision "/srv/#{node[:site_www][:app_name]}" do
  repo node[:site_www][:repo]
  revision node[:site_www][:revision]
  user node[:site_www][:user]
  group "users"
  keep_releases 2
  enable_submodules false
  migrate node[:site_www][:migrate]
  migration_command node[:site_www][:migrate_command]
  shallow_clone true
  symlink_before_migrate ({})
  create_dirs_before_symlink ["tmp", "htdocs"]
  purge_before_symlink ["logs", "htdocs/system"]
  symlinks "system" => "htdocs/system", "log" => "log"
  action node[:site_www][:action].to_sym
end


web_app node[:site_www][:app_name] do
  template "apache_site.conf.erb"
  server_name node[:site_www][:app_name]
end

# disable the default ubuntu site "it works"
apache_site "000-default" do
  enable false
end
