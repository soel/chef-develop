#
# Cookbook Name:: postgresql_yum
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "postgresql-server" do
       action :install
end

dataDir = "/var/lib/pgsql/data/"
if not File.exists? dataDir then
  execute "postgresql-init" do
    command "service postgresql initdb"
  end
end

template "/var/lib/pgsql/data/pg_hba.conf" do
  mode 0600
end

template "/var/lib/pgsql/data/postgresql.conf" do
  mode 0600
end

service "postgresql" do
  action [:enable, :restart]
end

# データベース作成
#postgresql_database 'HOGE' do
#  connection ({:host => "localhost", :username => "postgres", :password => node['postgresql']['password']})
#  encoding "UTF-8"
#  action :create
#end

