#
# Module: aegir
#
#  Created by  on 2011-04-24.
#  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
#
# Define:
#  
#
# Parameters:
#
#   
# Actions:
#
# Requires:
#
# Sample Usage:
# (start code)

class aegir {

    package { 'drush':
        require => [
            Exec['drush-ppa'],
            Package['php5-cli'],
        ],
        ensure  => present,
    }

    # package { 'aegir':
    #     require         => [
    #         Package['drush'],
    #         Class['php52'],
    #         Class['mysql'],
    #         Exec['koumbit-sources'],
    #         File['/root/aegir-hostmaster.seed'],
    #     ],
    #     ensure          => present,
    #     responsefile    => '/root/aegir-hostmaster.seed',
    # }

    file { '/root/aegir-hostmaster.seed':
        ensure  => file,
        mode    => 0600,
        owner   => root,
        group   => root,
        source  => "/opt/puppet/modules/aegir/files/aegir-hostmaster.seed",
    }

    file { '/etc/apt/sources.list.d/koumbit-stable.list':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 0644,
        content => 'deb http://debian.koumbit.net/debian stable main',
    }

    exec { "drush-ppa":
        require     => Package['python-software-properties'],
        command     => "add-apt-repository ppa:brianmercer/drush",
        path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        # refreshonly => true,
    }

    exec { "koumbit-sources":
        require     => [
            Exec['/root/koumbit.key.asc'],
            File['/etc/apt/sources.list.d/koumbit-stable.list'],
        ],
        command     => "apt-key add /root/koumbit.key.asc",
        path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        refreshonly => true,
        notify      => Exec['aegir update apt'],
    }

    exec { "aegir update apt":
        before      => Package['drush'],
        command     => "apt-get update",
        path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        refreshonly => true,
        subscribe   => [Exec['koumbit-sources'], Exec['drush-ppa']],
    }

    exec { '/root/koumbit.key.asc':
        creates => '/root/koumbit.key.asc',
        command => "wget http://debian.koumbit.net/debian/key.asc -O /root/koumbit.key.asc",
        path    => '/usr/bin',
    }

}
# (end)
