#
# Cookbook Name:: craftcake
# Recipe:: notifier
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

#install sendmail
package 'sendmail' do
  package_name "sendmail"
  action :install
end

settings = data_bag_item("notify", "settings")

log "#{settings['email']} emails.."

# create the notifier script
template "#{node[:craftcake][:directory]}/notify.sh" do
  source "notify.sh.erb"
  mode '0755'
  variables :email => settings['email']
end

# run the script every 5 mins
cron 'notify.sh' do
  minute '*/2'
  environment ({"PATH" => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"})
  command "#{node[:craftcake][:directory]}/notify.sh &> /dev/null"
  user 'root'
end
