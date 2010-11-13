#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : common.pp
# @created : Thu, 28 Oct 2010 14:54:55 +1100
# @last changed: Sat 13 Nov 2010 19:37:12 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# This class installs the apache2 service
# this is a Ubuntu 10.04(Lucid) LTS compatable (e.g. apache 2.2) manifest.
class apache2::common {
  package{ [apache2, apache2-threaded-dev]: 
    ensure => installed 
  }

  service{ "apache2" :
    subscribe  => Package["apache2"],
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true 
  }

  exec { "reload-apache2":
    command => "/etc/init.d/apache2 reload",
    onlyif => "/usr/sbin/apache2ctl -t",
    require => Service["apache2"],
    refreshonly => true,
  }
}

