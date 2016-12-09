#
# Cookbook Name:: craftcake
# Recipe:: vanilla
#
# Copyright 2015, yellowfive.com
#

# install java
package 'java' do
  package_name "java-#{node[:craftcake][:java][:version]}-openjdk"
  action :install
  notifies :restart, 'service[minecraft]', :delayed
end

# create the minecraft directory
directory node[:craftcake][:directory] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# download the minecraft server binary
remote_file "#{node[:craftcake][:directory]}/#{node[:craftcake][:minecraft][:jar]}" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/#{node[:craftcake][:minecraft][:version]}/minecraft_server.#{node[:craftcake][:minecraft][:version]}.jar"
  mode '0755'
  notifies :restart, 'service[minecraft]', :delayed
end

# accept and update the eula text file
cookbook_file "#{node[:craftcake][:directory]}/eula.txt" do
  source 'eula.txt'
  mode '0755'
end

# add ops to the server config
template "#{node[:craftcake][:directory]}/ops.json" do
  source 'ops.json.erb'
  mode '0755'
  variables :ops_settings => node['craftcake']['ops']
  action :create_if_missing
  notifies :restart, 'service[minecraft]', :delayed
end

# create the minecraft server script
template "/etc/init.d/minecraft" do
  source "minecraft.erb"
  mode '0755'
  notifies :restart, 'service[minecraft]', :delayed
end

# run the server
service 'minecraft' do
  supports :restart => true
  action :start
end
