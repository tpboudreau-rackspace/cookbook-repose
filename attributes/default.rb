case node['platform_family']
when 'rhel'
  default['repose']['owner'] = 'repose'
  default['repose']['group'] = 'repose'
  default['repose']['repo']['baseurl'] = 'http://repo.openrepose.org/rhel'
  default['repose']['repo']['gpgkey'] = 'http://repo.openrepose.org/rhel/RPM_GPG_KEY-openrepose'
  default['repose']['repo']['gpgcheck'] = false # the openrepose repo doesn't sign packages
  default['repose']['repo']['enabled'] = true
  default['repose']['repo']['managed'] = true
  default['repose']['install_opts'] = ''
when 'debian'
  default['repose']['owner'] = 'root'
  default['repose']['group'] = 'root'
  default['repose']['repo']['baseurl'] = 'http://repo.openrepose.org/debian'
  default['repose']['repo']['gpgkey'] = 'http://repo.openrepose.org/debian/pubkey.gpg'
  default['repose']['repo']['managed'] = true
  default['repose']['install_opts'] = '-o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes'
end

default['repose']['version'] = nil
default['repose']['loglevel'] = 'DEBUG'
default['repose']['cluster_ids'] = ['repose']
default['repose']['rewrite_host_header'] = true
default['repose']['node_id'] = 'repose_node1'
default['repose']['port'] = 7000
default['repose']['ssl_port'] = 7443
default['repose']['shutdown_port'] = 8188
default['repose']['connection_timeout'] = 30000
default['repose']['read_timeout'] = 30000
default['repose']['deploy_auto_clean'] = false
default['repose']['filter_check_interval'] = 60000
default['repose']['config_directory'] = '/etc/repose'
default['repose']['log_path'] = '/var/log/repose'
default['repose']['pid_file'] = '/var/run/repose-valve.pid'
default['repose']['user'] = 'repose'
default['repose']['java_opts'] = ''

default['repose']['peer_search_enabled'] = false
default['repose']['peer_search_query'] = "chef_environment:#{node.chef_environment} AND repose_cluster_ids:*"

default['repose']['peers'] = [
  { 'cluster_id' => 'repose',
    'id' => 'repose_node1',
    'hostname' => 'localhost',
    'port' => 7000,
  }
]

default['repose']['filters'] = ['header-normalization','keystone-v2','extract-device-id','valkyrie-authorization','merge-header']
default['repose']['services'] = []

default['repose']['endpoints'] = [
  { 'cluster_id' => 'repose',
    'id' => 'api0',
    'protocol' => 'http',
    'hostname' => 'localhost',
    'port' => 7010,
    'root_path' => '/',
    'default' => true,
  }
]

default['repose']['dist_datastore']['cluster_id'] = ['all']
default['repose']['dist_datastore']['allow_all'] = false
default['repose']['dist_datastore']['allowed_hosts'] = ['127.0.0.1']
default['repose']['dist_datastore']['port'] = 8081

default['repose']['slf4j_http_logging']['cluster_id'] = ['all']
default['repose']['slf4j_http_logging']['id'] = 'http'
default['repose']['slf4j_http_logging']['format'] = 'Remote IP=%a Local IP=%A Response Size(bytes)=%b Remote Host=%h Request Method=%m Server Port=%p Query String=%q Time Request Received=%t Status=%s Remote User=%u Rate Limit Group: %{X-PP-Groups}i URL Path Requested=%U X-Forwarded-For=%{X-Forwarded-For}i X-REAL-IP=%{X-Real-IP}i'

default['repose']['header_translation']['cluster_id'] = ['all']
default['repose']['header_translation']['headers'] = [
  { 'original_name' => 'Content-Type',
    'new_name' => 'rax-content-type'
  },
  { 'original_name' => 'Content-Length',
    'new_name' => 'rax-content-length not-rax-content-length something-else',
    'remove_original' => true
  }
]

default['repose']['derp']['cluster_id'] = ['all']

default['repose']['content_type_stripper']['cluster_id'] = ['all']

default['repose']['header_normalization']['cluster_id'] = ['all']
default['repose']['header_normalization']['uri_regex'] = nil
default['repose']['header_normalization']['whitelist'] = []
default['repose']['header_normalization']['blacklist'] = [
  { 'id' => 'authorization',
    'http_methods' => 'ALL',
    'headers' => [
      'X-Authorization',
      'X-Token-Expires',
      'X-Identity-Status',
      'X-Impersonator-Id',
      'X-Impersonator-Name',
      'X-Impersonator-Roles',
      'X-Roles',
      'X-Contact-Id',
      'X-Device-Id',
      'X-User-Id',
      'X-User-Name',
      'X-PP-User',
      'X-PP-Groups',
      'X-Catalog',
      'X-Subject-Token',
      'X-Subject-Name',
      'X-Subject-ID',
      'X-Support-Token'
    ]
  }
]

default['repose']['header_identity']['cluster_id'] = ['all']
default['repose']['header_identity']['headers'] = [
  { 'id' => 'X-Auth-Token',
    'quality' => 0.95
  },
  { 'id' => 'X-Forwarded-For',
    'quality' => 0.5
  }
]

default['repose']['ip_identity']['cluster_id'] = ['all']
default['repose']['ip_identity']['quality'] = 0.2
default['repose']['ip_identity']['white_list_quality'] = 1.0
default['repose']['ip_identity']['white_list_ip_addresses'] = ['127.0.0.1']

default['repose']['client_auth']['cluster_id'] = ['all']
default['repose']['client_auth']['auth_provider'] = 'RACKSPACE'
default['repose']['client_auth']['username_admin'] = 'admin'
default['repose']['client_auth']['password_admin'] = 'password'
default['repose']['client_auth']['tenant_id'] = 'tenant-id'
default['repose']['client_auth']['auth_uri'] = 'https://auth.api.rackspacecloud.com/v1.1/auth'
default['repose']['client_auth']['mapping_regex'] = '.*/v1/([-|\w]+)/?.*'
default['repose']['client_auth']['mapping_type'] = 'CLOUD'
default['repose']['client_auth']['delegable'] = false
default['repose']['client_auth']['tenanted'] = true
default['repose']['client_auth']['request_groups'] = true
default['repose']['client_auth']['token_cache_timeout'] = 600000
default['repose']['client_auth']['group_cache_timeout'] = 600000
default['repose']['client_auth']['endpoints_in_header'] = false
default['repose']['client_auth']['white_list'] = false
default['repose']['client_auth']['uri_regex'] = nil

default['repose']['client_authorization']['cluster_id'] = 'all'
default['repose']['client_authorization']['username_admin'] = 'admin'
default['repose']['client_authorization']['password_admin'] = 'password'
default['repose']['client_authorization']['auth_uri'] = 'https://auth.api.rackspacecloud.com/v1.1/auth'
default['repose']['client_authorization']['tenant_id_admin'] = nil
default['repose']['client_authorization']['endpoint_list_ttl'] = 300
default['repose']['client_authorization']['connection_pool_id'] = nil
default['repose']['client_authorization']['service_endpoint'] = 'https://exampleservice.api.rackspacecloud.com/v1.0'
default['repose']['client_authorization']['service_region'] = nil
default['repose']['client_authorization']['service_name'] = nil
default['repose']['client_authorization']['service_type'] = nil
default['repose']['client_authorization']['ignore_tenant_roles'] = []
default['repose']['client_authorization']['roles'] = []
default['repose']['client_authorization']['delegating_quality'] = nil

default['repose']['rate_limiting']['cluster_id'] = ['all']
default['repose']['rate_limiting']['uri_regex'] = '/limits'
default['repose']['rate_limiting']['include_absolute_limits'] = false
default['repose']['rate_limiting']['limit_groups'] = [
  { 'id' => 'limited',
    'groups' => 'limited',
    'default' => true,
    'limits' => [
      { 'id' => 'all',
        'uri' => '*',
        'uri-regex' => '/.*',
        'http-methods' => 'POST PUT GET DELETE',
        'unit' => 'MINUTE',
        'value' => 10
      }
    ]
  },
  { 'id' => 'unlimited',
    'groups' => 'unlimited',
    'default' => false,
    'limits' => []
  }
]

default['repose']['connection_pool']['chunked_encoding'] = true
default['repose']['connection_pool']['max_total'] = 400
default['repose']['connection_pool']['max_per_route'] = 200
default['repose']['connection_pool']['socket_timeout'] = 30000
default['repose']['connection_pool']['connection_timeout'] = 30000
default['repose']['connection_pool']['socket_buffer_size'] = 8192
default['repose']['connection_pool']['connection_max_line_length'] = 8192
default['repose']['connection_pool']['connection_max_header_count'] = 100
default['repose']['connection_pool']['connection_max_status_line_garbage'] = 100
default['repose']['connection_pool']['tcp_nodelay'] = true
default['repose']['connection_pool']['keepalive_timeout'] = 0

default['repose']['translation']['cluster_id'] = ['all']
default['repose']['translation']['allow_doctype_decl'] = false
default['repose']['translation']['request_translations'] = []
default['repose']['translation']['response_translations'] = []

default['repose']['rackspace_auth_user']['cluster_id'] = ['all']
default['repose']['rackspace_auth_user']['v1_1']['enabled'] = true
default['repose']['rackspace_auth_user']['v1_1']['read_limit'] = 4096
default['repose']['rackspace_auth_user']['v1_1']['group'] = 'Pre_Auth'
default['repose']['rackspace_auth_user']['v1_1']['quality'] = 0.6
default['repose']['rackspace_auth_user']['v2_0']['enabled'] = true
default['repose']['rackspace_auth_user']['v2_0']['read_limit'] = 4096
default['repose']['rackspace_auth_user']['v2_0']['group'] = 'Pre_Auth'
default['repose']['rackspace_auth_user']['v2_0']['quality'] = 0.6

default['repose']['uri_identity']['cluster_id'] = ['all']
default['repose']['uri_identity']['mappings'] = [
  '.*/servers/(\w*)/.*',
  '.*/servers/(\w*)/.*'
]
default['repose']['uri_identity']['group'] = 'User_Standard'
default['repose']['uri_identity']['quality'] = 0.5

default['repose']['api_validator']['cluster_id'] = ['all']
default['repose']['api_validator']['enable_rax_roles'] = true
default['repose']['api_validator']['wadl'] = nil
default['repose']['api_validator']['dot_output'] = nil

default['repose']['keystone_v2']['cluster_id'] = ['all']
default['repose']['keystone_v2']['uri_regex'] = nil
default['repose']['keystone_v2']['identity_username'] = 'identity_username'
default['repose']['keystone_v2']['identity_password'] = 'identity_p4ssw0rd'
default['repose']['keystone_v2']['identity_uri'] = 'http://identity.api.example.com' # 'https://staging.identity.api.rackspacecloud.com' 'https://identity.api.rackspacecloud.com'
default['repose']['keystone_v2']['identity_set_roles'] = true
default['repose']['keystone_v2']['identity_set_groups'] = false
default['repose']['keystone_v2']['identity_set_catalog'] = false
default['repose']['keystone_v2']['whitelist_uri_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/agent_installers/.+(\.sh)?'
default['repose']['keystone_v2']['tenant_uri_extraction_regex'] = '.*/v1.0/(\d+|[a-zA-Z]+:\d+)/.+'
default['repose']['keystone_v2']['preauthorized_service_admin_role'] = nil
default['repose']['keystone_v2']['token_timeout_variability'] = 15
default['repose']['keystone_v2']['token_timeout'] = 600

default['repose']['extract_device_id']['cluster_id'] = ['all']
default['repose']['extract_device_id']['uri_regex'] = '.*/hybrid:\d+/entities/.*'
default['repose']['extract_device_id']['maas_service_uri'] = 'http://localhost:7010'
default['repose']['extract_device_id']['cache_timeout_millis'] = 60000
default['repose']['extract_device_id']['delegating_quality'] = nil

default['repose']['valkyrie_authorization']['cluster_id'] = ['all']
default['repose']['valkyrie_authorization']['uri_regex'] = '.*/hybrid:\d+/(?!agent_installers/).*'
default['repose']['valkyrie_authorization']['cache_timeout_millis'] = 60000
default['repose']['valkyrie_authorization']['enable_masking_403s'] = true
default['repose']['valkyrie_authorization']['delegating_quality'] = nil
default['repose']['valkyrie_authorization']['valkyrie_server_uri'] = 'http://valkyrie.my.example.com' #'https://valkyrie.staging.myrs.rackspace.com', 'https://valkyrie.my.rackspace.com'
default['repose']['valkyrie_authorization']['valkyrie_server_username'] = 'username'
default['repose']['valkyrie_authorization']['valkyrie_server_password'] = 'p4ssw0rd'

default['repose']['merge_header']['cluster_id'] = ['all']
default['repose']['merge_header']['uri_regex'] = nil
default['repose']['merge_header']['headers'] = ['X-Roles','X-Impersonator-Roles']

