#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : virtual_sshusers.pp
# @created : Mon, 07 Jun 2010 16:16:01 +1000
# @last changed: Sat 13 Nov 2010 12:19:12 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# These virtual users and groups are site-wide,
# and should be realised in nodes.pp or site.pp.
#
# relies on the ssh_user definition in modules/sshusers

import 'sshusers'

  @group { "sysads": gid => 5000 }
  @group { "developers": gid => 5001 }
  @group { "admin": gid => 109 }


  @ssh_user { "lunix":
    comment => "Mick Pollard",
    uid     => 5001,
    group   => 'sysads',
    groups  => 'admin',
    mail    => 'mick@example.com.au'
  }
  @ssh_user { "dave":
    comment => "dave smith",
    uid     => 5002,
    group   => 'developers',
    groups  => 'admin',
    mail    => 'dave@example.com.au'
  }
  @ssh_user { "deployment":
    comment => "application deployment user",
    uid     => 5003,
    group   => 'developers',
    groups  => 'admin',
    mail    => 'deployment@example.com.au'
  }
