
import 'nodes/webserver_node.pp'
import 'nodes/database_node.pp'

node 'p-slave.local.com' inherits webserver_node {

}


