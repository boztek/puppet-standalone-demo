#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : init.pp
# @created : Sat, 27 Feb 2010 14:56:19 +1100
# @last changed: Sat 13 Nov 2010 12:22:06 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: git  
#
# This class installs git.  
#
# Parameters:  
#	None  
#	
# Actions:  
#	Ensures the git package is installed.  
#
# Requires:  
#	None  
#
# Credits  
#	Mick Pollard <aussielunix@gmail.com>  
#
class git {
    package { git-core: ensure => installed }
}

