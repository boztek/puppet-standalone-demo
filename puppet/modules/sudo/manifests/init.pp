#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : init.pp
# @created : 12 Feb 2010 09:05:47 +1100
# @last changed: Sat 13 Nov 2010 12:28:05 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: sudo
#
# This class enables the central management of /etc/sudoers
#
# Parameters:
#   none
#
# Actions:
#   Ensures the sudo package is installed and distrubutes a /etc/sudoers file to nodes
#
# Requires:
#   - Package["sudo"]
#
class sudo {

    package { sudo: ensure => latest }

    file { "/etc/sudoers":
        owner   => root,
        group   => root,
        mode    => 440,
        source  => "/opt/puppet/modules/sudo/files/sudoers",
        require => Package["sudo"],
    }
}

