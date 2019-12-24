# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.network "private_network", ip: "192.168.66.66"

  config.vm.synced_folder "./", "/app",
    id: "vagrant-root",
    :group=>'www-data',
    :mount_options=>['dmode=775,fmode=775']
  config.vm.synced_folder "./provision", "/provision",
    id: "configs",
    :group=>'www-data',
    :mount_options=>['dmode=775,fmode=775']

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.ssh.insert_key = false

  #config.vm.provision :shell, keep_color: true, path: "./provision/vagrant/provision.sh"

end
