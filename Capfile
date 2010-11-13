#!/usr/bin/env ruby

set :user, 'mick'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

host = ENV['HOST']
host ||= 'puppet-ubuntu01'

namespace :puppet do

	desc "prep server for puppet run - git clone etc"
	task :prep, :hosts => host do
		options = ENV['options'] || ENV['OPTIONS']
		sudo "git clone git://github.com/aussielunix/puppet-standalone-demo.git /opt/"
		sudo "apt-get install -y  puppet puppet-common"
	end
	
	desc "runs puppet on remote host - Params:  HOST OPTIONS"
	task :go, :hosts => host do
		options = ENV['options'] || ENV['OPTIONS']
		sudo "puppet --verbose /opt/puppet/init.pp --modulepath=/opt/puppet/modules #{options}"
	end

end


