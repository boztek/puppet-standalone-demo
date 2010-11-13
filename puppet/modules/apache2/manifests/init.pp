#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : init.pp
# @created : Thu, 28 Oct 2010 14:54:55 +1100
# @last changed: Sat 13 Nov 2010 12:19:57 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# This class installs the apache2 service
# this is a Ubuntu 10.04(Lucid) LTS compatable (e.g. apache 2.2) manifest.
inherit "common.pp"
inherit "site.pp"
