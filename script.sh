# Garantindo as chaves
    KEY_PATH='files'
    mkdir -p /root/.ssh
    cp $KEY_PATH/key /root/.ssh/id_rsa
    cp $KEY_PATH/key.pub /root/.ssh/id_rsa.pub
    cp $KEY_PATH/key.pub /root/.ssh/authorized_keys
    
    cp $KEY_PATH/ansible /root/.ssh/ansible
    cp $KEY_PATH/ansible.pub /root/.ssh/ansible.pub
    cp $KEY_PATH/ansible.pub /root/.ssh/authorized_keys

    chmod 400 /root/.ssh/id_rsa*
    
    cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

    # Garantindo os hosts
    HOSTS=$(head -n7 /etc/hosts)
    echo -e "$HOSTS" > /etc/hosts
    echo '192.168.100.10 auditoria.tce.am.gov.br' >> /etc/hosts
    echo '192.168.100.20 jenkins.tce.am.gov.br' >> /etc/hosts
    echo '192.168.100.30 gitlab.tce.am.gov.br' >> /etc/hosts
    