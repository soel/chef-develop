#
# Cookbook Name:: munin-node
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "munin-node" do
  action :install
  options '--enablerepo=epel'
end

template "/etc/munin/munin-node.conf" do
  mode 644
end

service "munin-node" do
  action [:enable, :start]
end
