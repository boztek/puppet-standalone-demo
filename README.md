## puppet-standalone-demo

**NOT COMPLETE YET**

In here you will find a basic collection of puppet manifests and modules and a capistrano recipe.  

With this I am able to take a fresh Linode/Slice and have it running my website in 5 minutes.  


    git clone git://github.com/aussielunix/puppet-standalone-demo.git
    cd puppet-standalone-demo
    gem install capistrano
    cap puppet:prep HOST="173.255.200.9"
    cap puppet:go HOST="173.255.200.9" OPTIONS="--noop"
    cap puppet:go HOST="173.255.200.9"
    cap deploy HOST="173.255.200.9" (you'll be asked for the domain of the vhost)


### TODO

* Add some cucumber-nagios tests to confirm puppet has deployed correctly
* add some roles to puppet, eg: base server, drupal, mercury, mediawiki etc
