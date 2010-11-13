#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : nodes.pp
# @created : Mon, 07 Jun 2010 16:16:01 +1000
# @last changed: Sat 13 Nov 2010 17:45:49 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# default node to be used by all
node "default" {
  include motd
  include root_mail
  include sudo
  include ssh
  include sysstat
  include git
  include apache2::common

  apache2::site { "glenlivet.lunix.lan": 
   ensure => "present",
   webmaster => "webmaster@lunix.lan"
  }

  apache2::site { "default": 
   ensure => "absent",
  }

  realize(Group['sysads'])
  realize(Group['developers'])
  realize(Ssh_user['deployment'])
  realize(Ssh_user['lunix'])  
}
