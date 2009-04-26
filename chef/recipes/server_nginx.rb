#
# Author:: Joshua Timberman <joshua@opscode.com>
# Author:: Joshua Sierles <joshua@37signals.com>
# Author:: AJ Christensen <aj@junglist.gen.nz
# Cookbook Name:: chef
# Recipe:: server_nginx
#
# Copyright 2008-2009, Opscode, Inc
# Copyright 2009, 37signals
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

include_recipe "nginx"
include_recipe "passenger::nginx"

nginx_passenger_app "chef_server" do
  docroot "#{node[:chef][:server_path]}/public"
  template "chef_server_nginx.conf.erb"
  server_name "chef.#{node[:domain]}"
  server_aliases [ "chef" ]
end
