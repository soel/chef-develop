#
# Cookbook Name:: apache2.2
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{openssl openssl-devel}.each do |pkg|
    package pkg do
      action :install
    end
end

cookbook_file "#{node['apache']['src_dir']}#{node['apache']['version']}.tar.gz" do
  mode 0644
end

group "apache" do
   group_name node['apache']['group']
   #action :create
end

user "apache" do
  group node['apache']['group']
  home "/var/empty/"
  shell "/sbin/nologin"
end
  
bash "install apache" do
  user     node['apache']['install_user']
  cwd      node['apache']['src_dir']
  not_if   "ls #{node['apache']['dir']}"
  notifies :run, 'bash[start apache]', :immediately
  code   <<-EOH
    tar xzf #{node['apache']['version']}.tar.gz
    cd #{node['apache']['version']}
    ./configure #{node['apache']['configure']}
    make
    make install
  EOH
end

template "#{node['apache']['dir']}conf/httpd.conf" do
  source   "httpd.conf.erb"
  owner    node['apache']['install_user']
  group    node['apache']['install_group']
  mode     00644
  notifies :run, 'bash[restart apache]', :immediately
end

for include_file in node['apache']['include_files']
  template "#{node['apache']['dir']}conf/extra/#{include_file}.conf" do
    source   "#{include_file}.conf.erb"
    owner    node['apache']['install_user']
    group    node['apache']['install_group']
    mode     00644
    notifies :run, 'bash[restart apache]', :immediately
  end
end

bash "start apache" do
  action :nothing
  flags  '-ex'
  user   node['apache']['install_user']
  code   <<-EOH
    #{node['apache']['dir']}bin/apachectl start
  EOH
end

bash "restart apache" do
  action :nothing
  flags  '-ex'
  user   node['apache']['install_user']
  code   <<-EOH
    #{node['apache']['dir']}bin/apachectl restart
  EOH
end
