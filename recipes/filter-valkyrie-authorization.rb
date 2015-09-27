#
# Cookbook Name:: repose
# Recipe:: filter-valkyrie-authorization
#

include_recipe 'repose::install'

unless node['repose']['filters'].include? 'valkyrie-authorization'
  filters = node['repose']['filters'] + ['valkyrie-authorization']
  node.normal['repose']['filters'] = filters
end

template "#{node['repose']['config_directory']}/valkyrie-authorization.cfg.xml" do
  owner node['repose']['owner']
  group node['repose']['group']
  mode '0644'
  variables(
    :cache_timeout_millis => node['repose']['valkyrie_authorization']['cache_timeout_millis'],
    :enable_masking_403s => node['repose']['valkyrie_authorization']['enable_masking_403s'],
    :delegating_quality => node['repose']['valkyrie_authorization']['delegating_quality'],
    :valkyrie_server_uri => node['repose']['valkyrie_authorization']['valkyrie_server_uri'],
    :valkyrie_server_username => node['repose']['valkyrie_authorization']['valkyrie_server_username'],
    :valkyrie_server_password => node['repose']['valkyrie_authorization']['valkyrie_server_password'],
    :preauthorized_service_admin_role => node['repose']['valkyrie_authorization']['preauthorized_service_admin_role']
  )
  notifies :restart, 'service[repose-valve]'
end

