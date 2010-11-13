# root_mail puppet module

 This module makes sure emails for root are redirected to a valid email account
 Only tested on CentOS & Ubuntu.

## Parameters:
	None at present.
	TODO: paramatise the email address

## Actions:
   edits /etc/aliases and sets root mail to redirect to valid email account

## Requires:
	TODO: need to set a dependency of sendmail/exim/postfix

## Credits:

This module originated from [rasputnik's github repos](http://github.com/rasputnik/babysteps-puppet/tree/master/modules/root_mail/)  
