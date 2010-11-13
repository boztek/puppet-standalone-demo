#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename: manifests/init.pp
# @created : Thu, 11 Feb 2010 15:21:05 +1100
# @last changed: Sun 24 Oct 2010 14:27:38 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################

import "nodes"
import "virtual_sshusers.pp"

Exec { path => "/usr/bin:/usr/sbin/:/bin:/sbin" }

