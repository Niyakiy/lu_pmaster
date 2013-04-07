# Some useful puppet scripts auto upload to client

define upload_scripts ( ) {


	# Ensuring scripts directory present
	file { "/etc/puppet/scripts/":
                ensure => directory,
                owner => root,
                group => root,
                mode => 755,
        }

	# password generator script
	file { "/etc/puppet/scripts/gen-rand-user-password.sh":
		source => "puppet:///scripts/gen-rand-user-password.sh",
		owner => root,
                group => root,
                mode => 755,
	}
}