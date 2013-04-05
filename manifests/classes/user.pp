define user_add ( $uid ) {

        $username = $title

# Create user
        user { $username:
                home => "/home/$username",
                shell => "/bin/bash",
                uid => $uid
        }

# Create group
        group { $username:
                gid => $uid,
                require => User[$username]
        }

# Ensure user's homedir present
        file { "/home/$username/":
                ensure => directory,
                owner => $username,
                group => $username,
                mode => 700,
                require => [ User[$username], Group[$username] ]
        }

# User's SSH key store prepare
        file { "/home/$username/.ssh":
                ensure => directory,
                owner => $username,
                group => $username,
                mode => 700,
                require => File["/home/$username/"]
        }


# Generation of rand password 
        exec { "create-rand-password-$username":
		command => "/etc/puppet/scripts/gen-rand-user-password.sh $username",
		path => "/bin:/usr/bin",
                refreshonly => true,
                subscribe => User[$username],
                unless => "cat /etc/shadow | grep $username| cut -f 2 -d : | grep -v '!'"
        }

# Touch empty authorized_keys file
        file { "/home/$username/.ssh/authorized_keys":
                ensure => present,
                owner => $username,
                group => $username,
                mode => 600,
                require => File["/home/$username/.ssh"]
        }

}

# Add ssh pub key to user's .ssh/authorized_keys 
define user_ssh_key_add( $key, $type ) {

        $username = $title

        ssh_authorized_key{ "${username}_${key}":
                ensure => present,
                key => $key,
                type => $type,
                user => $username,
                require => File["/home/$username/.ssh/authorized_keys"]
        }

}