class sudo { 

	$package_name = 'sudo'

	package { $package_name: 
		ensure => present, 
	} 

	file { "/etc/sudoers": 
		owner => "root", 
		group => "root", 
		mode => 0440, 
		source => "puppet:///modules/$package_name/etc/sudoers", 
		require => Package[$package_name], 
	} 
}