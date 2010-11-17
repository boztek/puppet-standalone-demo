#!/usr/bin/env ruby

set :user, 'root'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

host = ENV['HOST']
host ||= 'puppet-ubuntu01'

def prompt_with_default(var, default)
  set(var) do
    Capistrano::CLI.ui.ask "#{var} [#{default}] : "
  end
  set var, default if eval("#{var.to_s}.empty?")
end
 





namespace :puppet do

	desc "prep server for puppet run - git clone etc"
	task :prep, :hosts => host do
		options = ENV['options'] || ENV['OPTIONS']
		run "apt-get install -y  git-core puppet puppet-common"
		run "git clone git://github.com/aussielunix/puppet-standalone-demo.git /opt/"
	end
	
	desc "update puppet repos from github"
	task :up, :hosts => host do
		run "cd /opt/ && git pull"
	end

	desc "runs puppet on remote host - Params:  HOST OPTIONS"
	task :go, :hosts => host do
		options = ENV['options'] || ENV['OPTIONS']
		run "puppet --verbose /opt/puppet/init.pp --modulepath=/opt/puppet/modules #{options}"
	end

end


desc "deploy html site to linode - Params: HOST"
task :deploy, :hosts => host do
  prompt_with_default(:domain, "devops.lunix.com.au")
	run "cp -a /opt/html/ /var/www/#{domain}/"
end
