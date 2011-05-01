#
# Module: mysql
#
#  Created by  on 2011-04-23.
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

# Class: mysql
#
#
class mysql {

    $mysql_root_password = "123456789"

    file { '/root/mysql-server.seed':
        # source => "/opt/puppet/modules/mysql/files/mysql-server.seed",
        content => template('mysql/mysql-server.seed.erb'),
        mode => 0600,
        owner => root,
        group => root
    }

    package { 'mysql-server':
        ensure => present,
        responsefile => "/root/mysql-server.seed",
        require => File["/root/mysql-server.seed"],
    }

    file { '/etc/mysql/my.cnf':
        require => Package['mysql-server'],
        notify  => Service['mysql'],
        source  => '/opt/puppet/modules/mysql/files/my.cnf',
    }

    service { 'mysql':
        require => Package['mysql-server'],
        ensure  => 'running',
        enable  => 'true',
    }
}

# (end)
