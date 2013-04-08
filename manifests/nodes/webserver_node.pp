import 'default_node.pp'

node webserver_node inherits default_node {

	include webserver_packages

}

