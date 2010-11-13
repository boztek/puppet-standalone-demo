class postfix {

	package { 
		"postfix": ensure => installed;
	}

	service { 
		"postfix":
		  enable => true,
		  ensure => running,
                  provider => debian,
		  require => File["/etc/postfix"];
	}

	file { 
		"/etc/postfix": 
		  mode => 0755,
		  notify => Service[postfix],
		  source => "puppet:///postfix/etc/postfix",
		  require => Package["postfix"];
		  
		  "/etc/postfix/main.cf":
		    ensure => present, 
		    content => template("postfix/main.cf.erb"),
		    notify => Service["postfix"];
		  
		"/etc/mailname":	mode => 0644, content => "${domain}", notify => Service["postfix"];
	}
}
