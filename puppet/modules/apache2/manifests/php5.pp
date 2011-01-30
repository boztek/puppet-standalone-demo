#vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:
##############################################################
# @filename : php.pp
# @created : Sat, 01 Jan 2011 19:08:42 +1100
# @last changed: Sun 30 Jan 2011 20:12:56 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################

class apache2::php5 {
  include apache2::common

    package { "mod-php5": 
      name => "libapache2-mod-php5",
	   ensure => installed,
	   require => [ Package["apache2"] ],
	   notify  => [ Service["apache2"] ]
    }

  file {
    "/etc/apache2/mods-available/php5.conf":
      source => "/opt/puppet/modules/apache2/files/etc/apache2/mods-available/php5.conf",
	     mode => 440, owner => root, group => www-data;

    "/etc/php5/apache2/php.ini":
      source => "/opt/puppet/modules/apache2/files/etc/php5/apache2/php.ini",
	     mode => 0644, owner => root, group => root,
	     notify  => Exec["reload-apache2"],
	     require => Package["mod-php5"],
  }
}
