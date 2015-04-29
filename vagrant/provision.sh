#!/bin/bash -x

add_vagrant_keys() {
  cat <<EOF >/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
EOF

  cat <<EOF >/root/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzI
w+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoP
kcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2
hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NO
Td0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW
yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQIBIwKCAQEA4iqWPJXtzZA68mKd
ELs4jJsdyky+ewdZeNds5tjcnHU5zUYE25K+ffJED9qUWICcLZDc81TGWjHyAqD1
Bw7XpgUwFgeUJwUlzQurAv+/ySnxiwuaGJfhFM1CaQHzfXphgVml+fZUvnJUTvzf
TK2Lg6EdbUE9TarUlBf/xPfuEhMSlIE5keb/Zz3/LUlRg8yDqz5w+QWVJ4utnKnK
iqwZN0mwpwU7YSyJhlT4YV1F3n4YjLswM5wJs2oqm0jssQu/BT0tyEXNDYBLEF4A
sClaWuSJ2kjq7KhrrYXzagqhnSei9ODYFShJu8UWVec3Ihb5ZXlzO6vdNQ1J9Xsf
4m+2ywKBgQD6qFxx/Rv9CNN96l/4rb14HKirC2o/orApiHmHDsURs5rUKDx0f9iP
cXN7S1uePXuJRK/5hsubaOCx3Owd2u9gD6Oq0CsMkE4CUSiJcYrMANtx54cGH7Rk
EjFZxK8xAv1ldELEyxrFqkbE4BKd8QOt414qjvTGyAK+OLD3M2QdCQKBgQDtx8pN
CAxR7yhHbIWT1AH66+XWN8bXq7l3RO/ukeaci98JfkbkxURZhtxV/HHuvUhnPLdX
3TwygPBYZFNo4pzVEhzWoTtnEtrFueKxyc3+LjZpuo+mBlQ6ORtfgkr9gBVphXZG
YEzkCD3lVdl8L4cw9BVpKrJCs1c5taGjDgdInQKBgHm/fVvv96bJxc9x1tffXAcj
3OVdUN0UgXNCSaf/3A/phbeBQe9xS+3mpc4r6qvx+iy69mNBeNZ0xOitIjpjBo2+
dBEjSBwLk5q5tJqHmy/jKMJL4n9ROlx93XS+njxgibTvU6Fp9w+NOFD/HvxB3Tcz
6+jJF85D5BNAG3DBMKBjAoGBAOAxZvgsKN+JuENXsST7F89Tck2iTcQIT8g5rwWC
P9Vt74yboe2kDT531w8+egz7nAmRBKNM751U/95P9t88EDacDI/Z2OwnuFQHCPDF
llYOUI+SpLJ6/vURRbHSnnn8a/XG+nzedGH5JGqEJNQsz+xT2axM0/W/CRknmGaJ
kda/AoGANWrLCz708y7VYgAtW2Uf1DPOIYMdvo6fxIB5i9ZfISgcJ/bbCUkFrhoH
+vq/5CIWxCPp0f85R4qxxQ5ihxJ0YDQT9Jpx4TMss4PSavPaBH3RXow5Ohe+bYoQ
NE5OgEXk2wVfZczCZpigBKbKZHNYcelXtTt/nP3rsCuGcM4h53s=
-----END RSA PRIVATE KEY-----
EOF
chmod 0600 /root/.ssh/id_rsa
}

interface_ip() {
  ip addr show dev $1 | sed -n '/inet / { s!.*inet !!; s!/.*!!; p; }'
}

install_master() {
  cp -r -f /vagrant/training/beta3/ansible/* /etc/ansible/
  sed -i -e 's/ose3-master.example.com/ose3-master.example.com openshift_ip='\''192.168.0.40'\''/g' /etc/ansible/hosts
  pushd /vagrant/openshift-ansible
  ANSIBLE_HOST_KEY_CHECKING=0 python -u /usr/bin/ansible-playbook playbooks/byo/config.yml
  popd

  >/etc/openshift-passwd
  for user in joe alice; do
    useradd $user
    echo redhat | passwd --stdin $user
    htpasswd -b /etc/openshift-passwd $user redhat
  done

  sed -i -e 's/name: anypassword/name: apache_auth/; s/kind: AllowAllPasswordIdentityProvider/kind: HTPasswdPasswordIdentityProvider/; /kind: HTPasswdPasswordIdentityProvider/i \      file: \/etc\/openshift-passwd' /etc/openshift/master.yaml

  cp /vagrant/training/beta3/scheduler.json /etc/openshift
  sed -i -e 's!schedulerConfigFile: ""!schedulerConfigFile: "/etc/openshift/scheduler.json"!' /etc/openshift/master.yaml

  systemctl restart openshift-master

  sleep 10

  for user in joe alice
  do
    su -c "cd; osc login -u $user -p redhat --certificate-authority=/var/lib/openshift/openshift.local.certificates/ca/cert.crt --server=https://ose3-master.example.com:8443" $user
  done

  osadm new-project demo --display-name="OpenShift 3 Demo" --description="This is the first demo project with OpenShift v3" --admin=joe

  pushd /vagrant/training/beta3
  osc create -f quota.json --namespace=demo
  popd

  osadm router --create --credentials=/var/lib/openshift/openshift.local.certificates/openshift-router/.kubeconfig --images='registry.access.redhat.com/openshift3_beta/ose-${component}:${version}'

  osadm registry --create --credentials=/var/lib/openshift/openshift.local.certificates/openshift-registry/.kubeconfig --images='registry.access.redhat.com/openshift3_beta/ose-${component}:${version}'

  while [ $(osc get pods | grep Running | wc -l) -ne 2 ]
  do
    sleep 5
  done

  pushd /vagrant/openshift-ansible
  cat <<EOF >>/etc/ansible/hosts
ose3-node1.example.com openshift_ip='192.168.0.41'
ose3-node2.example.com openshift_ip='192.168.0.42'
EOF
  ANSIBLE_HOST_KEY_CHECKING=0 python -u /usr/bin/ansible-playbook playbooks/byo/config.yml
  popd

  osc update node ose3-master.example.com --patch='{ "apiVersion": "v1beta3", "metadata": { "labels": { "region": "infra", "zone": "NA" } } }'
  osc update node ose3-node1.example.com --patch='{ "apiVersion": "v1beta3", "metadata": { "labels": { "region": "primary", "zone": "east" } } }'
  osc update node ose3-node2.example.com --patch='{ "apiVersion": "v1beta3", "metadata": { "labels": { "region": "primary", "zone": "west" } } }'

  osc update deploymentconfig router --patch='{ "apiVersion": "v1beta1", "template": { "controllerTemplate": { "podTemplate": { "nodeSelector": { "region": "infra" } } } } }'
  osc update deploymentconfig docker-registry --patch='{ "apiVersion": "v1beta1", "template": { "controllerTemplate": { "podTemplate": { "nodeSelector": { "region": "infra" } } } } }'

  for node in ose3-master ose3-node1 ose3-node2
  do
    ssh $node.example.com service openshift-node restart
  done

  cp -r /var/lib/openshift/openshift.local.certificates /vagrant

  osc create -f /vagrant/training/beta3/image-streams.json -n openshift

  # registry_push jminter-sti-gcc
  ## registry_push openshift/ruby-20-centos7
  ## registry_push openshift/wildfly-8-centos
}

registry_push() {
  DOCKER_EP=$(osc get services docker-registry -o template --template='{{.spec.portalIP}}:{{(index .spec.ports 0).port}}')
  docker tag $1 $DOCKER_EP/$(basename $1)
  while true; do
    if docker push $DOCKER_EP/$(basename $1); then
      break
    fi
    sleep 10
  done

}

add_vagrant_keys
docker load </vagrant/jminter-sti-gcc/jminter-sti-gcc.tar

if [ $(interface_ip eth1) = 192.168.0.40 ]; then
  install_master
fi
