## puppet-standalone-demo

In here you will find a basic collection of puppet manifests and modules, a capistrano script and
some cucumber-nagios tests.

With this I am able to take a fresh Linode/Slice and have it running my
website in 5 minutes.  
I am also able to test that puppet has installed the hosting stack
correctly before deploying a site.  
I can then also test that my site is deployed.  


    git clone git://github.com/aussielunix/puppet-standalone-demo.git
    cd puppet-standalone-demo
    cap  puppet:prep HOST="173.255.200.9"
    puppet:go HOST="173.255.200.9" OPTIONS="--noop"
    puppet:go HOST="173.255.200.9"



