#
# Module: php
#
#  Created by  on 2011-05-01.
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

# Class: php
#
#
class php {
    # resources
    package { ['php5', 'php5-cli', 'libapache2-mod-php5', 'php5-gd']:
        ensure => installed,
    }

    file { "/etc/php5/apache2/php.ini":
        ensure => file,
        
    }
    
    # mod_php

    service { 'apache2':
        ensure    => running,
        require   => [
            Package['apache2'],
            Package['libapache2-mod-php5'],
        ],
        # subscribe => Exec['mod_php5'],
    }

    exec { 'mod_php5':
        command => '/usr/sbin/a2enmod php5',
        creates => [
            '/etc/apache2/mods-enabled/php5.conf',
            '/etc/apache2/mods-enabled/php5.load',
        ],
        require => Package['libapache2-mod-php5'],
        notify  => Service['apache2'],
    }

    # PHP configuration
    
    file { '/etc/php5/cli/php.ini':
        ensure  => file,
        content => template('php/php.ini.erb'),
        owner   => root,
        group   => root,
        mode    => 644,
        require => Package['php5-cli'],
    }
    
    file { '/etc/php5/apache2/php.ini':
        ensure  => file,
        content => template('php/php.ini.erb'),
        owner   => root,
        group   => root,
        mode    => 644,
        require => Package['php5'],
        notify  => Service['apache2'],
    }
}

# (end)
