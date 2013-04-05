
import 'classes/scripts.pp'
import 'classes/user.pp'


node basenode {

	# Modules with packages
	# default_packages - configless pkgs
	include default_packages
	# sudo - needs to be shipped with modified /etc/sudoers file
	include sudo
	include screen

	# Useful client side puppet scripts
	upload_scripts { common_scripts: }		

	# default users	(UIDS 1000-29999 - default for debian users) 
	user_add { eugene:
		uid => 1001
	}
	user_add { turbid:
                uid => 1002
        }
	user_add { levelup:
                uid => 1003
        }

	# SSH Keys for users
	
	user_ssh_key_add { eugene:
		key => "AAAAB3NzaC1kc3MAAACBAOL68Lzol6G/e6BngewwEmi14zpmf7YTsuXjPAE/lI/aqKIZd5WQciQUX9Eatwmp1pLYG7jkJECEgpWqq3qUiVGJ6+9Jqwsuz4mPidPcbn48HUR5pATa029xmIXwW8nCmRyEUNTB0A+yi7ebgi2k45XjPM/Ksruu7KarkpaS8EvvAAAAFQC/wL4A3FEQygLu9dXjExQYTkmPzQAAAIALyXKwfYxGF3YO94+adYqAwJw+nm5P6AP2o+dJX2eMmkBAfZbgp4uub6lSMGAEP3o/5ZiVRgr/1BrhEWnlkr/yK5gsgWOG29B1/O6eINC8sDOTveCFOD8rRNJkEiHGvlm47JdTXPNmiKRIRr2ZYdgLtRf17pzs2yDAlVT1wzMSDQAAAIEAiUgf6ldF9jXlolCHoerzQY44w6EfZMdZ+uIZria0E/QxMyULVZiP07cyi7ZiEQfp49+pr0erWheCaSdSZqldHORZ8jrhBllRmAin30PcsNgfVlduxmF6YISZ+L6oArFzkhdgQRSELnyIpVpDK1v0+35Ygf0j3iLNXLcIbTN9u8s=",
		type => 'ssh-dss'
	}
}