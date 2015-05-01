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

directory "/var/minecraft" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "/var/minecraft/minecraft_server.jar" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/1.8.4/minecraft_server.1.8.4.jar"
  mode '0755'
end

cookbook_file '/var/minecraft/eula.txt' do
  source 'eula.txt'
  mode '0755'
end

template "/etc/init.d/minecraft" do
  source "minecraft.erb"
  mode '0755'
end

service 'minecraft' do
  action :start
end