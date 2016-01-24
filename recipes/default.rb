#
# Cookbook Name:: craftcake
# Recipe:: default
#
# Copyright 2015, yellowfive.com
#

if platform?("centos", "redhat")
  # default version is vanilla minecraft
  include_recipe "craftcake::vanilla"

  # if notifier is turned on install and run it
  if node[:craftcake][:notify_on_login] == "true"
    include_recipe "craftcake::notifier"
  end

else
  # not a valid platform...
  Chef::Log.error("Sorry, it does not appear you are running a valid platform.")
  exit

end
