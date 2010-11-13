define apache2::site($ensure, $webmaster) {

    case $ensure {
        present: {

	    #source vhost file from template
	    # requires $name & $webmaster
		  file { "/etc/apache2/sites-available/$name":
			mode => "644",
			require => Package["apache2"],
			content => template("apache2/vhost.erb"),
		  }
			
			file { "/var/www/$name":
				mode => "775",
				owner => "root",
				group => "www-data",
				ensure => directory,
			}

		  exec { "enable $name":
			command => "/usr/sbin/a2ensite $name",
			# add a onlyif vhost file exists in sites-available
			unless => "/bin/ls /etc/apache2/sites-enabled | grep '$name'",
			require => File["/var/www/$name"],
			notify => Service['apache2']
		  }
        }

        absent: {
            exec { "disable $name":
                    command => "/usr/sbin/a2dissite $name",
                    onlyif => "/bin/ls /etc/apache2/sites-enabled | grep '$name'",
                    notify => Service['apache2']
            }
        }
        default: {
            fail "Invalid 'ensure' value '$ensure' for apach2::vhost"
        }
    }
}
