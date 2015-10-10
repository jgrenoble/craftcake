#
# Cookbook Name:: craftcake
# Recipe:: default
#
# Copyright 2015, yellowfive.com
#

package 'java' do
  package_name 'java-#{node['craftcake']['java']['version']}-openjdk'
  action :install
end

directory "/var/minecraft" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "/var/minecraft/minecraft_server.jar" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/1.8.7/minecraft_server.1.8.7.jar"
  mode '0755'
  notifies :restart, 'service[minecraft]', :delayed
  notifies :run, 'ruby_block[sleep]', :immediately
end

cookbook_file '/var/minecraft/eula.txt' do
  source 'eula.txt'
  mode '0755'
end

template "/var/minecraft/ops.json" do
  source 'ops.json.erb'
  mode '0755'
  variables :ops_settings => node['craftcake']['ops']
  action :create
  notifies :restart, 'service[minecraft]', :delayed
end

template "/etc/init.d/minecraft" do
  source "minecraft.erb"
  mode '0755'
  notifies :restart, 'service[minecraft]', :delayed
end

service 'minecraft' do
  supports :restart => true
  action :start
end

#TODO: install python 1.7
#TODO: install pygtail from git
#TODO: install crond and start

#TODO: login notifications
# */5 * * * * /usr/bin/python /var/minecraft_notify.py
