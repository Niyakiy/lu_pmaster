# Class: memcached
#
# Install, enable and configure memcached.
#
# Parameters:
#  $other:
#    Optional other. Default: none
#
# Sample Usage :
#  include memcached
#

class memcached (
  $port      = '11211',
  $user      = 'memcached',
  $maxconn   = '1024',
  $cachesize = '64',
  $options   = ''
) {

  package { 'memcached': ensure => installed }

  service { 'memcached':
    enable    => true,
    ensure    => running,
    hasstatus => true,
    require   => Package['memcached'],
  }

  # Configuration

	case $operatingsystem {
      		centos, redhat: { 
			$mc_config_file = "/etc/sysconfig/memcached"
			$mc_config_template = "memcached/sysconfig.erb"
		}
      		debian, ubuntu: { 
			$mc_config_file = "/etc/memcached.conf" 
			$mc_config_template = "memcached/memcached.conf.erb"
		}
      		default: { fail("Unrecognized operating system for memcached") }
    	}

  file { $mc_config_file:
    content => template($mc_config_template),
    notify  => Service['memcached'],
    require => Package['memcached'],
  }

}

