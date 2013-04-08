
import '../defines/scripts.pp'
import '../defines/local_user.pp'

node default_node {

	# 1. Adding apt repositories for our packages. UA - deafult (need new param to define for other coutry)
	# WARNING! POINT OF DISCUSSION!
	include apt

	# Puppet repo 
	apt::source { 'puppetlabs':
      		location   => 'http://apt.puppetlabs.com',
      		repos      => 'main',
      		key        => '4BD6EC30',
      		key_server => 'pgp.mit.edu',
    	}

	apt::source { "debian_unstable":
  		location          => "http://debian.mirror.iweb.ca/debian/",
  		release           => "unstable",
  		repos             => "main contrib non-free",
  		key               => "55BE302B",
  		key_server        => "subkeys.pgp.net",
	}

	 apt::source { "debian_experimental":
                location          => "http://debian.mirror.iweb.ca/debian/",
                release           => "experimental",
                repos             => "main contrib non-free",
                key               => "55BE302B",
                key_server        => "subkeys.pgp.net",
        }

	
	
	# END OF WARNING

	# Modules with packages
	# default_packages - configless pkgs
	include default_packages
	# sudo - needs to be shipped with modified /etc/sudoers file
	include sudo
	include screen

	# Useful client side puppet scripts
	upload_scripts { common_scripts: }		

	local_user { 'eugene':
		ssh_key_type => 'ssh-dss',
		ssh_key_value => 'AAAAB3NzaC1kc3MAAACBAOL68Lzol6G/e6BngewwEmi14zpmf7YTsuXjPAE/lI/aqKIZd5WQciQUX9Eatwmp1pLYG7jkJECEgpWqq3qUiVGJ6+9Jqwsuz4mPidPcbn48HUR5pATa029xmIXwW8nCmRyEUNTB0A+yi7ebgi2k45XjPM/Ksruu7KarkpaS8EvvAAAAFQC/wL4A3FEQygLu9dXjExQYTkmPzQAAAIALyXKwfYxGF3YO94+adYqAwJw+nm5P6AP2o+dJX2eMmkBAfZbgp4uub6lSMGAEP3o/5ZiVRgr/1BrhEWnlkr/yK5gsgWOG29B1/O6eINC8sDOTveCFOD8rRNJkEiHGvlm47JdTXPNmiKRIRr2ZYdgLtRf17pzs2yDAlVT1wzMSDQAAAIEAiUgf6ldF9jXlolCHoerzQY44w6EfZMdZ+uIZria0E/QxMyULVZiP07cyi7ZiEQfp49+pr0erWheCaSdSZqldHORZ8jrhBllRmAin30PcsNgfVlduxmF6YISZ+L6oArFzkhdgQRSELnyIpVpDK1v0+35Ygf0j3iLNXLcIbTN9u8s='
	}

	local_user { 'turbid':
        }

	local_user { 'levelup':
	}
}
