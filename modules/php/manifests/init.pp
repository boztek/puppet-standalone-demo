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
    package { ['php', 'php-cli', 'libapache2-mod-php5', 'php5-gd']:
        ensure => installed,
    }

    # file { "/etc/php5/":
    #     ensure => file,
    #     
    # }
    
    service { 'apache2':
        require => Package['libapache2-mod-php5'],
        ensure  => running,
    }
}

# (end)
