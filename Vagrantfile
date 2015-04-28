Vagrant.configure(2) do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 2
    libvirt.memory = 2048
    libvirt.volume_cache = "unsafe"
  end

  config.vm.define "master", primary: true do |vm|
    vm.vm.box = "rhel-server-7:ose3b3-base"
    vm.vm.network :private_network, ip: "192.168.0.40"
    vm.vm.hostname = "ose3-master.example.com"
  end

  config.vm.define "node1" do |vm|
    vm.vm.box = "rhel-server-7:ose3b3-base"
    vm.vm.network :private_network, ip: "192.168.0.41"
    vm.vm.hostname = "ose3-node1.example.com"
  end

  config.vm.define "node2" do |vm|
    vm.vm.box = "rhel-server-7:ose3b3-base"
    vm.vm.network :private_network, ip: "192.168.0.42"
    vm.vm.hostname = "ose3-node2.example.com"
  end

  config.vm.provision :shell, path: "vagrant/provision.sh"
end
