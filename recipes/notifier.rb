#
# Cookbook Name:: craftcake
# Recipe:: vanilla
#
# Copyright 2015, yellowfive.com
#

# install cron deamon
package 'cron' do
  package_name "cronie"
  action :install
end

# make sure deamon is started
service 'crond' do
  supports :restart => true
  action :start
end

# create the notifier script
template "#{node[:craftcake][:directory]}/notify.sh" do
  source "notify.sh.erb"
  mode '0755'
end


# run the script every 5 mins
cron 'notify.sh' do
  minute '*/5'
  command "#{node[:craftcake][:directory]}/notify.sh"
  user 'root'
end

# */5 * * * * /usr/bin/python /var/minecraft_notify.py
