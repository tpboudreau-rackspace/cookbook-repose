#
# Cookbook Name:: repose
# Recipe:: filter-add-header
#
# Copyright (C) 2015 Rackspace Hosting
#

include_recipe 'repose::install'

unless node['repose']['filters'].include? 'add-header'
  filters = node['repose']['filters'] + ['add-header']
  node.normal['repose']['filters'] = filters
end

template "#{node['repose']['config_directory']}/add-header.cfg.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  variables(
    :request_headers => node['repose']['add_header']['request_headers'],
    :response_headers => node['repose']['add_header']['response_headers']
  )
  notifies :restart, 'service[repose-valve]'
end
