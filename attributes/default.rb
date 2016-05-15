#
# Cookbook Name:: craftcake
# attributes:: default
#
# Copyright 2015, yellowfive.com
#

default['craftcake']['minecraft']['version'] = "1.9.4"
default['craftcake']['minecraft']['jar'] = "minecraft_server.jar"

default['craftcake']['java']['version'] = "1.8.0"

default['craftcake']['directory'] = "/var/minecraft"

# minecraft server login notifier settings
default['craftcake']['notify_on_login'] = "true"
default['craftcake']['notify']['to_address'] = "root@#{domain}"
default['craftcake']['notify']['from_address'] = "#{hostname}@#{domain}"
default['craftcake']['notify']['subject'] = "Minecraft Server Login"
default['craftcake']['notify']['log_file'] = "#{node['craftcake']['directory']}/nohup.out"

# default mods for the server (you'll want to change this)
default['craftcake']['ops'] = [
  {
    "uuid" => "120aaa19-a7fc-4c86-9712-7dfa3a4711b3",
    "name"  => "jezzegfunk",
    "level" => 4,
    "bypassesPlayerLimit" => false
  },
  {
    "uuid" => "35c11d9c-7e04-4fc5-9912-c058d82ef851",
    "name"=> "NolanW0317",
    "level"=> 4,
    "bypassesPlayerLimit" => false
  },
  {
    "uuid" => "f609c6ee-e30d-46c9-a67b-5191bf2e1f85",
    "name" => "HeathW",
    "level" => 4,
    "bypassesPlayerLimit" => false
  },
  {
    "uuid" => "a2297a98-7f9e-40bd-8a56-f48e4a9040c8",
    "name" => "khopegfunk",
    "level" => 4,
    "bypassesPlayerLimit" => false
  }
]
