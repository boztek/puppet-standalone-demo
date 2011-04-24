# Class: php52
#
#
class php52 {
    $php_memory_limit = "192M"

    # resources
    package {'python-software-properties':
        ensure => present,
    }

    package { ['php5-mysql', 'php5-gd', 'php5-cli', 'php5',]:
        ensure      => present,
        require     => Exec['apt-get update'],
    }
    
    package { 'apache2':
        ensure      => present,
    }
    
    file {'/etc/apt/preferences.d/php':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => 644,
        source  => '/opt/puppet/modules/php52/files/php52.apt.pin',
    }
    
    file {'/etc/apt/sources.list.d/andphe-php-lucid.list':
        ensure  => present,
    }
    
    exec {'apt-add-repository ppa:andphe/php':
        path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        subscribe   => [
            Package['python-software-properties'],
            File['/etc/apt/sources.list.d/andphe-php-lucid.list'],
        ],
        refreshonly => true,
    }
    
    exec {'apt-get update':
        path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        require     => File['/etc/apt/preferences.d/php'],
        subscribe   => Exec["apt-add-repository ppa:andphe/php"],
        refreshonly => true,
    }

    # mod_php

    service {'apache2':
        ensure      => running,
        subscribe   => [
            Package['apache2'],
        ],
    }

    exec { '/usr/sbin/a2enmod php5':
        creates => [
            '/etc/apache2/mods-enabled/php5.conf',
            '/etc/apache2/mods-enabled/php5.load',
        ],
        require => Package['php5'],
        notify  => Service['apache2'],
    }

    # PHP configuration
    
    file { '/etc/php5/cli/php.ini':
        ensure  => file,
        content => template('php52/php.ini.erb'),
        owner   => root,
        group   => root,
        mode    => 644,
        require     => Package['php5-cli'],
    }
    
    file { '/etc/php5/apache2/php.ini':
        ensure  => file,
        content => template('php52/php.ini.erb'),
        owner   => root,
        group   => root,
        mode    => 644,
        require => Package['php5'],
        notify  => Service['apache2'],
    }
    
    # php mcrypt

    # /php5-mcrypt_5.2.6-0ubuntu2_amd64.deb
    # /php5-mcrypt_5.2.6-0ubuntu2_i386.deb
    $source_pkg = $architecture ? {
        x86_64  => 'amd64',
        i386    => 'i386',
        default => undef,
    }
    
    package { ['libltdl7', 'libmcrypt4']:
        ensure => present,
    }

    package { 'php5-mcrypt':
        ensure      => present,
        require     => [
            Package['php5-cli'],
            Package['libltdl7'],
            Package['libmcrypt4'],
            Exec['php5-mcrypt_5.2.6-0ubuntu2.deb'],
        ],
        provider    => dpkg,
        source      => "/root/php5-mcrypt_5.2.6-0ubuntu2_$source_pkg.deb",
    }

    package { 'mcrypt':
        require => Package['php5-mcrypt'],
        ensure  => present,
    }

    exec { 'php5-mcrypt_5.2.6-0ubuntu2.deb':
        command => "wget http://free.nchc.org.tw/ubuntu/pool/universe/p/php-mcrypt/php5-mcrypt_5.2.6-0ubuntu2_$source_pkg.deb -O /root/php5-mcrypt_5.2.6-0ubuntu2_$source_pkg.deb",
        creates => "/root/php5-mcrypt_5.2.6-0ubuntu2_$source_pkg.deb",
        path    => '/usr/bin',
    }
}