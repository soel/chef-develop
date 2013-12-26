#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "docker-io" do
  action :install
  options '--enablerepo=epel'
end

service "docker" do
  action [:enable, :start]
end
