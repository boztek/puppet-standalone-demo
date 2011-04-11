# sshuser puppet module  

** Only tested on CentOS & Ubuntu **

This is just a define statement used to enable the declaration of virtual users.  
It allows the:  

* Setup local accounts with a given public key to connect to them.  

To create an account, first copy the public key into  
files/public_keys/username, then define a user with  

	@ssh_user { "username":  
	  comment => "U. Sername",
	  uid     => 4566,
	  group   => sysadmins,
	  mail    => 'foo@bar.com'
	}

_(the 'sysadmins' group should exist)._  

This module just creates the ssh_user() definition.  
You need to use this module's define to create your virtual users  
and then realize them in your site, role or node manifest.  

We also set up a mail alias  
(depends on ``Exec['newaliases']`` defined in the ``root_mail`` module).  

In your roles.pp (or nodes.pp), just have a line like  

	realise(Ssh_user['username'])

to have the user created.  

### TODO

* better documentation  
* allow multiple keys to be add to the one user. usefull for the _deployment_ user.  

### Credits  

This module originated from [rasputnik's github repos](http://github.com/rasputnik/babysteps-puppet/tree/master/modules/sshusers/)  

