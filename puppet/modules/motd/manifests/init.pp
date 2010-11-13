##############################################################
# @filename : init.pp
# @created : 12 Feb 2010 09:05:47 +1100
# @last changed: Sat 13 Nov 2010 12:22:52 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: motd  
#
# This class distributes a ``/etc/motd`` to alert users the server is managed by Puppet   
#
# Parameters:
#	None
#
# Actions:  
#	Distributes a ``/etc/motd``  
#
# Requires:
#	None
#
class motd {
  file { "/etc/motd" :
    mode    => 444,
    content => template("motd/motd.erb")
  }
}

