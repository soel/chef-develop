#
# Cookbook Name:: postgresql_source
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'readline-devel' do
  action :install
end

package "zlib-devel" do
  action :install
end

directory "#{node['postgres']['src_dir']}" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

cookbook_file "#{node['postgres']['src_dir']}#{node['postgres']['version']}.tar.gz" do
  mode 0644
end

group "postgres" do
  group_name node['postgres']['group']
end

user "postgres" do
  group node['postgres']['group']
end

bash "tar xvf postgres" do
  user    "root"
  cwd     node['postgres']['src_dir']
  code   <<-EOH
    tar xvf #{node['postgres']['version']}.tar.gz
    chown -R #{node['postgres']['install_user']}:#{node['postgres']['install_user']} #{node['postgres']['version']}
  EOH
end

bash "install postgres" do
  user     "node['postgres']['install_user']"
  cwd      "#{node['postgres']['src_dir']}/#{node['postgres']['version']}"
  not_if   "ls #{node['postgres']['dir']}"
  code   <<-EOH
    ./configure #{node['postgres']['configure']}
    gmake
    gmake install
  EOH
end


