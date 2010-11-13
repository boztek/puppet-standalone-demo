# sudo puppet module  

## Class: sudo  

Ensures the sudo package is installed and sets up the config file.  
  
** Only tested on CentOS && Ubuntu  **  

### Parameters:  
	None  

### Actions:  

This class installs sudo and distributes ``/etc/sudoers``  

### Requires:  
	Package["sudo"]  

### Credits  

I am not the original author of this module but I can not remember where I got it from now.  
I will gladly amend this readme if you recognise who the original author was.  


