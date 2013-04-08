import 'default_node.pp'

node webserver_node inherits default_node {

	# standard packages for web server
	include webserver_packages

	# specific configurable packages
	
	class { 'memcached':
        	port      => '11211',
        	maxconn   => '2048',
        	cachesize => '2048',  # in Mb
		user => 'nobody',
    	}

	
}

