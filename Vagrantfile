# -*- mode: ruby -*-
# vi: set ft=ruby :
# noinspection RubyResolve

Vagrant.configure("2") do |config|
  os = "ubuntu/xenial64"
  os_version = "20180323.0.0"

  config.vm.box = "#{os}"
  config.vm.box_version = "#{os_version}"
  config.vm.synced_folder "saltstack/salt/", "/srv/salt/"
  config.vm.provision :salt do |salt|
    salt.masterless = true
    salt.minion_config = "saltstack/etc/minion.yml"
    salt.run_highstate = true
    salt.verbose = true
    salt.colorize = true
  end
end
