#
# Cookbook Name:: craftcake
# Recipe:: default
#
# Copyright 2015, yellowfive.com
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
	action :remove
end

package 'sendmail' do
	action :remove
end

package 'java' do
  package_name 'java-1.8.0-openjdk'
  action :install
end

package 'screen' do
  action :install
end

package 'crontabs' do
  action :install
end

service 'crond' do
  action :start
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
end

cookbook_file '/var/minecraft/eula.txt' do
  source 'eula.txt'
  mode '0755'
end

cookbook_file '/var/minecraft/ops.json' do
  source 'ops.json'
  mode '0755'
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

cron 'chef-client-job' do
  minute '0,30'
  command %w{chef-client >> /var/log/chef-client.log}.join(' ')
end