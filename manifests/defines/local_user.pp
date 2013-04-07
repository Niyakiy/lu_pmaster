# Normal linux user creation type definition
define local_user($ssh_key_type = '', $ssh_key_value = '') {

	$user_name = $title

	$user_home_dir = "/home/$user_name"
	$user_sshkey_dir = "$user_home_dir/.ssh"
	$user_sshkey_file = "$user_sshkey_dir/authorized_keys"
	
	# Create non system user with managed homedir
        user { $user_name:
                home => $user_home_dir,
                shell => $local_user::params::default_shell,
		managehome => true,
		ensure => present,
        }

	# Create .ssh under user's home
	file { $user_sshkey_dir:
                ensure => directory,
                owner => $user_name,
                group => $user_name,
                mode => 700,
                require => User[$user_name],
        }

	# Create empty authorized_keys file
	file { $user_sshkey_file:
                ensure => present,
                owner => $user_name,
                group => $user_name,
                mode => 600,
                require => [ User[$user_name], File[$user_sshkey_dir] ]
        }

	# Create random user's password
	exec { "create-rnd-password-$user_name":
                command => "/etc/puppet/scripts/gen-rand-user-password.sh $user_name",
                path => "/bin:/usr/bin",
		refreshonly => true,
                subscribe => User[$user_name],
                unless => "cat /etc/shadow | grep $user_name| cut -f 2 -d : | grep -v '!'"
        }	
	
	if ($ssh_key_type != '') and ($ssh_key_value != '') {
		# Add ssh key into user's authorized_keys
		ssh_authorized_key{ "${user_name}_${ssh_key_value}":
                	ensure => present,
	                key => $ssh_key_value,
	                type => $ssh_key_type,
	                user => $user_name,
	                require => File[$user_sshkey_file]
	        }
	}

}
