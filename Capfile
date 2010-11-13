#!/usr/bin/env ruby

set :user, 'mick'
set :ssh_options, { :forward_agent => true }

host = ENV['HOST']
host ||= 'puppet-ubuntu01'


namespace :puppet do 
	desc "prep server for puppet run - git clone etc"
	task :prep, :hosts => host do
		options = ENV['options'] || ENV['OPTIONS']
		run "git clone https://aussielunix@github.com/aussielunix/puppet-standalone-demo.git /opt/"
	end

  desc "runs puppet on remote host - Params:  HOST OPTIONS"
  task :go, :hosts => host do
		options = ENV['options'] || ENV['OPTIONS']
		run "#{sudo} puppet --verbose /opt/puppet/init.pp --modulepath=/opt/puppet/modules #{options}"
  end
end


