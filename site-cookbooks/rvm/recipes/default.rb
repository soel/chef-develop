#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "#{node['rvm']['src_dir']}#{node['rvm']['file']}" do
  source "#{node['rvm']['file']}"
  mode 0644
end

package "ruby" do
  action :install
end

bash "install rvm" do
  user    "root"
  cwd     node['rvm']['src_dir']
  code   <<-EOH
    bash #{node['rvm']['file']}
    source /etc/profile.d/rvm.sh
    rvm get head && rvm reload
    rvm install 1.9.3
    rvm use 1.9.3
  EOH
end
