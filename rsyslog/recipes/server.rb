#
# Cookbook Name:: rsyslog
# Recipe:: default
#
# Copyright 2009, Maxnet
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "mysql::server"
include_recipe "mysql::client"

%w{rsyslog rsyslog-mysql}.each do |p|
  package(p) { version "3.18.1-1~8.04prevu1" }
end

remote_file "/etc/default/rsyslog" do
  source "server.rsyslog.default"
end

service "rsyslog" do
  supports [ :restart, :status ]
  action :nothing
end

template "/etc/rsyslog.d/remote_server" do
  action :delete
  notifies :restart, resources(:service => "rsyslog"), :delayed
  only_if do File.exists?("/etc/rsyslog.d/remote_server") end
end
