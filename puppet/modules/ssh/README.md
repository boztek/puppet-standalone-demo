# ssh puppet module  
  
## Class: ssh  

This class installs openssh.  

** Only tested on CentOS & Ubuntu  **  

### Parameters:  
	-	$permitrootlogin =  
							'without-password'  
							'no'  
							'yes'  

### Actions:  

Ensures that the openssh package is installed and distributes a config file.  ``/etc/ssh/sshd_config``  

### Requires:  
	Package["openssh"]  

### Credits  

This module originated from [rasputnik's github repos](http://github.com/rasputnik/babysteps-puppet/tree/master/modules/ssh/)  

