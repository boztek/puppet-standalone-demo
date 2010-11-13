#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : nodes.pp
# @created : Mon, 07 Jun 2010 16:16:01 +1000
# @last changed: Sat 13 Nov 2010 20:58:31 EST
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
  include postfix
  include apache2::common

  apache2::site { "glenlivet.lunix.lan": 
   ensure => "present",
   webmaster => "webmaster@lunix.lan"
  }

  apache2::site { "default": 
   ensure => "absent",
  }

  realize(Group['devop'])
  realize(Group['deploy'])
  realize(Ssh_user['deploy'])
  realize(Ssh_user['lunix'])  
}
