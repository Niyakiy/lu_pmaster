class default_packages {
	$packages = [ 'mc', 'git', 'vim', 'joe', 'htop', 'fail2ban', ]
        
	package { $packages:
                ensure => present,
        }

}