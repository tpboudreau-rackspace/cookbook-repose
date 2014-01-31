if platform_family? 'rhel'
  default['repose']['owner'] = 'repose'
  default['repose']['group'] = 'repose'
end

if platform_family? 'debian'
  default['repose']['owner'] = 'root'
  default['repose']['group'] = 'root'
end

default['repose']['loglevel'] = 'DEBUG'

default['repose']['cluster_id'] = 'repose'
default['repose']['node_id'] = 'repose_node1'
default['repose']['port'] = 8080
default['repose']['ssl_port'] = 8443
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

default['repose']['filters'] = []
default['repose']['services'] = []

default['repose']['peer_search_enabled'] = false
default['repose']['peer_search_role'] = 'repose'
default['repose']['peers'] = [
  { 'id' => 'repose_node1',
    'hostname' => 'localhost',
    'port' => 8080,
  }
]

default['repose']['endpoints'] = [
  { 'id' => 'open_repose',
    'protocol' => 'http',
    'hostname' => 'www.openrepose.org',
    'port' => 80,
    'root_path' => '/',
    'default' => true,
  }
]

default['repose']['dist_datastore']['allow_all'] = false
default['repose']['dist_datastore']['allowed_hosts'] = ['127.0.0.1']
default['repose']['dist_datastore']['port'] = 8081

default['repose']['http_logging']['id'] = 'http-log'
default['repose']['http_logging']['format'] = 'Remote IP=%a Local IP=%A Response Size(bytes)=%b Remote Host=%h Request Method=%m Server Port=%p Query String=%q Time Request Received=%t Status=%s Remote User=%u Rate Limit Group: %{X-PP-Groups}i URL Path Requested=%U X-Forwarded-For=%{X-Forwarded-For}i X-REAL-IP=%{X-Real-IP}i'
default['repose']['http_logging']['logfile'] = '/var/log/repose/http.log'

default['repose']['ip_identity']['quality'] = 0.2
default['repose']['ip_identity']['white_list_quality'] = 1.0
default['repose']['ip_identity']['white_list_ip_addresses'] = ['127.0.0.1']

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
