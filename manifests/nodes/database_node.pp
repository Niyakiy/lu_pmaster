import 'default_node.pp'

# MySQL module need to know OSFamily! :)
if ! $::osfamily {
      case $::operatingsystem {
        'RedHat', 'Fedora', 'CentOS', 'Scientific', 'SLC', 'Ascendos', 'CloudLinux', 'PSBM', 'OracleLinux', 'OVS', 'OEL': {
          $osfamily = 'RedHat'
        }
        'ubuntu', 'debian': {
          $osfamily = 'Debian'
        }
        'SLES', 'SLED', 'OpenSuSE', 'SuSE': {
          $osfamily = 'Suse'
        }
        'Solaris', 'Nexenta': {
          $osfamily = 'Solaris'
        }
        default: {
          $osfamily = $::operatingsystem
        }
      }
    }


node database_node inherits default_node {
	
	# setting up mysql client libs
	class { 'mysql': }

	# setting up and starting mysql server 
	class { 'mysql::server':
		config_hash => { 'root_password' => 'FAyJoZAiIV_WKc6cdiphKRt!MN4zmfj3kcQ%AAYKkib' }
	}	
}