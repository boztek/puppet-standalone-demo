#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : virtual_sshusers.pp
# @created : Mon, 07 Jun 2010 16:16:01 +1000
# @last changed: Sun 14 Nov 2010 20:46:57 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# These virtual users and groups are site-wide,
# and should be realised in nodes.pp or site.pp.
#
# relies on the ssh_user definition in modules/sshusers

import 'sshusers'

  @group { "deploy": gid => 5000 }
  @group { "devop": gid => 5001 }


  @ssh_user { "boris":
    comment => "Boris Gordon",
    uid     => 5001,
    group   => 'devop',
    groups  => 'sudo',
    password  => '$1$vgmT9S6z$wHzZUnKjb0po7ObiPE9kz.',
    mail    => 'email@boris.com.au'
  }
  @ssh_user { "deploy":
    comment => "application deployment user",
    uid     => 5002,
    group   => 'deploy',
    groups  => 'sudo',
    password  => '$1$vgmT9S6z$wHzZUnKjb0po7ObiPE9kz.',
    mail    => 'email+deploy@boris.com.au'
  }
