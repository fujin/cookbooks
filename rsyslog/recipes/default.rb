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

package "rsyslog" do
  version "3.18.1-1~8.04prevu1"
end


service "rsyslog" do
  supports [ :restart, :status ]
  action :nothing
end

syslog_server = search(:node, "recipe:rsyslog::server").first["fqdn"]

remote_file "/etc/default/rsyslog" do
  source "client.rsyslog.default"
  notifies :restart, resources(:service => "rsyslog"), :delayed
end

template "/etc/rsyslog.d/remote_server" do
  source "remote_server.erb"
  mode 0644
  owner "root"
  group "root"
  variables :server => syslog_server
  notifies :restart, resources(:service => "rsyslog"), :delayed
end
