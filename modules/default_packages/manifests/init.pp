class default_packages {
	$packages = [ 'mc', 'git', 'vim', 'joe', 'htop', 'fail2ban', 'chkconfig']
        
	package { $packages:
                ensure => present,
        }

}