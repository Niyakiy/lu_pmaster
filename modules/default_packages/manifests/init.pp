class default_packages {
        package { mc:
                ensure => present,
        }

	package { git:
                ensure => present,
        }

	package { vim:
                ensure => present,
        }

	package { htop:
                ensure => present,
        }

	package { fail2ban:
                ensure => present,
        }

	package { screen:
                ensure => present,
        }

}