#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : nodes.pp
# @created : Mon, 07 Jun 2010 16:16:01 +1000
# @last changed: Sun 30 Jan 2011 19:42:10 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# default node to be used by all
node "default" {
  $mailserver_dest_hosts = "localhost"
  $mailserver_networks = "localhost"
  include web

  apache2::site { "devops.lunix.com.au": 
   ensure => "present",
   webmaster => "webmaster@lunix.lan"
  }

  apache2::site { "default": 
   ensure => "absent",
  }

}
