##############################################################
# @filename : init.pp
# @created : 12 Feb 2010 09:05:47 +1100
# @last changed: Sat 13 Nov 2010 20:47:47 EST
# @author : Mick Pollard <aussielunix@gmail.com>
##############################################################
#
# Class: root_mail
#
# This class makes sure emails for root are redirected to a valid  
# email account
# Only tested on CentOS & Ubuntu
#
# Parameters:
#	None at present.
#	TODO: paramatise the email address
#
# Actions:
#   edits /etc/aliases and sets root mail to redirect to valid email account
#
# Requires:
#	TODO: need to set a dependency of sendmail/exim/postfix
#
class root_mail {
  exec { "newaliases": 
		refreshonly => true,
		require => Package['postfix']
		
	}

  mailalias { "rootalias":
    ensure    => present,
    recipient => 'aussielunix@gmail.com',
    name      => 'root',
    notify    => Exec['newaliases']
  }
}
