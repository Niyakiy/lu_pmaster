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

	
	# there must be some perfomance tuning parameters and various mysql/mysqld params
	mysql::server::config { 'normal_config':
     		settings => {
       			'mysqld' => {
         			'query_cache_limit'     => '5M',
         			'query_cache_size'      => '128M',
         			'port'                  => 3306,
         			'skip-external-locking' => true,
				'character_set_server'	=> 'utf8',
       			},

       			'client' => {
				'default-character-set' => 'utf8',
       			}
     		}
   	}

}