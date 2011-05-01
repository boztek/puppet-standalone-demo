#!/usr/bin/env ruby

set :user, 'root'
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

host = ENV['HOST']
host ||= 'hostmaster'
db_root = ENV['DB_ROOT']
db_root ||= 'changeme'

# hostname = ENV['HOSTNAME']
# domain = ENV['DOMAIN']

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
    run "cd /opt/puppet && git checkout -t origin/aegir"
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
    run "cd /opt/puppet && #{sudo} FACTER_db_root='#{db_root}' /var/lib/gems/1.8/bin/rump go #{options}"
  end

  desc "cleanup server - remove puppet and other files used during deployment"
  task :clean, :host => host do
    #TODO: add in a cleanup task
  end

end

desc "initialise host with .ssh directory and fqdn"
task :fqdn, :hosts => host do
  # run "cd /root && mkdir .ssh"
  prompt_with_default(:hostname, 'aegir')
  prompt_with_default(:domain, 'domain.com')
  run "echo \"#{hostname}\" > /etc/hostname && hostname -F /etc/hostname"
  run "echo \"#{host}  #{hostname}.#{domain} #{hostname}\" >> /etc/hosts"
end

desc "ubuntu upgrade"
task :upgrade, :hosts => host do
  run "apt-get update && apt-get upgrade --show-upgraded"
end

desc "install ssh key"
task :ssh_key_install, :hosts => host do
  # cat .ssh/id_rsa.pub | ssh user@server "cat >> .ssh/authorized_keys"
  system "cat ~/.ssh/id_rsa.pub | ssh #{user}@#{host} \"cat >> .ssh/authorized_keys\""
end

namespace :aegir do
  
  desc "install aegir from koumbit stable packages"
  task :install, :hosts => host do
    system "ssh #{user}@#{host} apt-get install aegir -y"
  end
  
  desc "add public key to aegir user"
  task :ssh_key_install, :hosts => host do
    run "mkdir -pv /var/aegir/.ssh"
    run "chmod 700 /var/aegir/.ssh"
    run "chown aegir:aegir /var/aegir/.ssh"
    system "cat ~/.ssh/id_rsa.pub | ssh #{user}@#{host} \"cat >> /var/aegir/.ssh/authorized_keys\""
  end

  desc "add a platform with a make file uri"
  task :new_platform, :hosts => host do
    prompt_with_default(:platform, 'drupal6')
    prompt_with_default(:path, "/var/aegir/platforms/#{platform}")
    prompt_with_default(:makefile, "http://dl.dropbox.com/u/26031/d620.make")
    set :user, 'aegir'
    set :platform_id, "#{platform}".gsub(/[ \.-]/, '')
    # run "drush status"
    run "drush provision-save @platform_#{platform_id} --context_type=platform --root=\"#{path}\" --makefile=\"#{makefile}\""
    run "drush provision-verify @platform_#{platform_id}"
    run "drush @hostmaster hosting-import @platform_#{platform_id}"
    run "drush @hostmaster hosting-task @platform_#{platform_id} verify"
    run "drush @hostmaster hosting-dispatch"
  end
end

desc "deploy html site to linode - Params: HOST"
task :deploy, :hosts => host do
  prompt_with_default(:domain, "devops.lunix.com.au")
  run "cd /opt/html/ && cp -a . /var/www/#{domain}/"
end
