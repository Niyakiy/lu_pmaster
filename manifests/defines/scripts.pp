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
		require => File['/etc/puppet/scripts/']
	}
}

define add_line_to_file($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
              onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }

            # Use this resource instead if your platform's grep doesn't support -vFx;
            # note that this command has been known to have problems with lines containing quotes.
            # exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
            #     onlyif => "/bin/grep -qFx '${line}' '${file}'"
            # }
        }
    }
}