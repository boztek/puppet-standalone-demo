#!/usr/bin/env ruby

set :user, 'root'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

host = ENV['HOST']
host ||= 'hostmaster'

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
    run "apt-get install -y  git-core ruby libruby libopenssl-ruby libxmlrpc-ruby rubygems"
    run "gem install rump"
    run "echo 'PATH=$PATH:/var/lib/gems/1.8/bin' >> ~/.bashrc"
    run "/var/lib/gems/1.8/bin/rump clone git://github.com/boztek/puppet-standalone-demo.git /opt/puppet"
    run "cd /opt/puppet && git checkout -t origin/puppet-2.6-aegir"
    run "cd /opt/puppet && /var/lib/gems/1.8/bin/rump freeze" # latest puppet
    run "groupadd puppet"
    run "useradd -M -g puppet puppet"
  end

  desc "update puppet repos from github"
  task :up, :hosts => host do
    options = ENV['options'] || ENV['OPTIONS']
    run "cd /opt/puppet && #{sudo} git pull"
  end

  desc "runs puppet on remote host - Params:  HOST OPTIONS"
  task :go, :hosts => host do
    options = ENV['options'] || ENV['OPTIONS']
    run "cd /opt/puppet && #{sudo} /var/lib/gems/1.8/bin/rump go #{options}"
  end

  desc "cleanup server - remove puppet and other files used during deployment"
  task :clean, :host => host do
    #TODO: add in a cleanup task
  end

end


desc "deploy html site to linode - Params: HOST"
task :deploy, :hosts => host do
  prompt_with_default(:domain, "devops.lunix.com.au")
  run "cd /opt/html/ && cp -a . /var/www/#{domain}/"
end
