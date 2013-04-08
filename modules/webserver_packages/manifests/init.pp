class webserver_packages {
	$packages = [ 'openssl', 'memcached', 'libmysqlclient-dev', 'python2.7', 'uwsgi-plugin-python', 'python2.7-dev', 'python-virtualenv', 'uwsgi' ]
        
	package { $packages:
                ensure => present,
        }

}