#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : roles.pp
# @created : Tue, 23 Nov 2010 22:25:47 +1100
# @last changed: Sun 30 Jan 2011 19:47:37 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
# define the inheritance heirarchy for different
# roles
# class common to all servers
#
class standardbuild {
  include motd
  include root_mail
  include sudo
  include ssh
  include sysstat
  include git
  include postfix

  realize(Group['devop'])
  realize(Ssh_user['lunix'])  
}

class web inherits standardbuild {

  include apache2::common
  include apache2::php5

  realize(Group['deploy'])
  realize(Ssh_user['deploy'])

}
