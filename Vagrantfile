# -*- mode: ruby -*-
# vi: set ft=ruby :

NETWORK = "192.168.100."
BOX_DEBIAN_BUSTER = "debian/stretch64"

machines = {
    "auditoria" => { "image" => BOX_DEBIAN_BUSTER, "ip" => NETWORK + "10" },
    #"auditoria2" => { "image" => BOX_DEBIAN_BUSTER, "ip" => NETWORK + "20" },
    "jenkins" => { "image" => BOX_DEBIAN_BUSTER, "ip" => NETWORK + "20" },
    "gitlab-ce" => { "image" => BOX_DEBIAN_BUSTER, "ip" => NETWORK + "30"  }
}

Vagrant.configure("2") do |config|
    # config.vm.define "auditoria" do |auditoria|
    #     auditoria.vm.box = BOX_DEBIAN_BUSTER
    #     auditoria.vm.network "private_network", ip: NETWORK + "10"
    # end
    #config.vm.define "jenkins" do |jenkins|
     #   jenkins.vm.box = BOX_DEBIAN_BUSTER
     #  jenkins.vm.network "private_network", ip: NETWORK + "20"
    # end
    id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
    #ansible_pub = File.read("/home/ims/Documents/projetos/vagrantwork/files/ansible.pub")

    #config.vm.box_check_update = false
    config.vm.boot_timeout = 300
    machines.each do |name, conf|
        config.vm.define "#{name}" do |machine|
          machine.vm.box = "#{conf["image"]}"
          machine.vm.network "private_network", ip: "#{conf["ip"]}"
          machine.vm.hostname = "#{name}.tce.am.gov.br"
          machine.vm.provision "copy ssh public key", type: "shell", inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys", privileged: true
          machine.vm.provider "virtualbox" do |vb|
                vb.name = "#{name}"
                vb.customize ["modifyvm", :id, "--groups", "/Auditoria-Logs"]
                if vb.name == "auditoria"
                    vb.memory = "2024"
                    vb.cpus = "2"
                else
                    vb.memory = "1024"
                    vb.cpus = "1"
                end
          end
          machine.vm.provision "shell", inline: "apt install python -y"
          machine.vm.provision "shell", inline: "apt install vim -y"
          machine.vm.provision "shell", inline: "apt update -y"
        end
    end
end