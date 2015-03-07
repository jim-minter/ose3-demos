#!/bin/bash

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
  sed -i -e 's/^OPTIONS=.*/OPTIONS="--loglevel=4 --public-master=ose3-master.example.com"/' /etc/sysconfig/openshift-master 

  sed -i -e 's/^OPTIONS=.*/OPTIONS="--loglevel=4"/' /etc/sysconfig/openshift-node

  sed -i -e 's/^OPTIONS=.*/OPTIONS="-v=4"/' /etc/sysconfig/openshift-sdn-master

  sed -i -e 's!^MASTER_URL=.*!MASTER_URL="http://ose3-master.example.com:4001"!; s!^OPTIONS=.*!OPTIONS="-v=4"!; s!^DOCKER_OPTIONS=.*!DOCKER_OPTIONS="--insecure-registry=0.0.0.0/0 -b=lbr0 --mtu=1450 --selinux-enabled"!' /etc/sysconfig/openshift-sdn-node

  sed -i -e "s!^MINION_IP=.*!MINION_IP=\"$IP\"!" /etc/sysconfig/openshift-sdn-node

  # echo OPENSHIFT_PROFILE=web >>/etc/sysconfig/openshift-master

cat <<EOF >/etc/rc.d/rc.local
#!/bin/bash

systemctl start openshift-master
sleep 10
systemctl start openshift-sdn-master
systemctl start openshift-sdn-node
EOF

  chmod 0755 /etc/rc.d/rc.local
  /etc/rc.d/rc.local

  OPENSHIFT_CA_DATA=$(sed ':a;N;$!ba;s/\n/\\n/g' /var/lib/openshift/openshift.local.certificates/master/root.crt)

  osc create -f - <<EOF
kind: Pod
apiVersion: v1beta2
id: router
desiredState:
  manifest:
    version: v1beta1
    containers:
    - name: origin-haproxy-router-mainrouter
      image: registry.access.redhat.com/openshift3_beta/ose-haproxy-router
      command:
      - --loglevel=4
      ports:
      - containerPort: 80
        hostPort: 80
      - containerPort: 443
        hostPort: 443
      env:
      - name: OPENSHIFT_MASTER
        value: "https://ose3-master.example.com:8443"
      - name: OPENSHIFT_CA_DATA
        value: "$OPENSHIFT_CA_DATA"
      - name: OPENSHIFT_INSECURE
        value: "false"
EOF

  pushd /vagrant/training
  CERT_DIR=/var/lib/openshift/openshift.local.certificates/master KUBERNETES_MASTER=https://ose3-master.example.com:8443 CONTAINER_ACCESSIBLE_API_HOST=ose3-master.example.com bash install-registry.sh
  popd

  sleep 20

  osc create -f - <<EOF
kind: List
apiVersion: v1beta2
items:
- kind: Node
  apiVersion: v1beta1
  id: ose3-node1.example.com
  resources:
    capacity:
      cpu: 1
      memory: 256000000

- kind: Node
  apiVersion: v1beta1
  id: ose3-node2.example.com
  resources:
    capacity:
      cpu: 1
      memory: 256000000
EOF

  registry_push jminter-sti-gcc
  registry_push openshift/ruby-20-centos7
  registry_push openshift/wildfly-8-centos

  echo OK >/tmp/step1
}

registry_push() {
  DOCKER_EP=$(osc get services docker-registry | tail -n +2 | awk '{print $4 ":" $5}')
  docker tag $1 $DOCKER_EP/$(basename $1)
  while true; do
    if docker push $DOCKER_EP/$(basename $1); then
      break
    fi
    sleep 10
  done

}

install_node() {
  while true; do
    if [ "$(ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@ose3-master.example.com 'cat /tmp/step1' 2>/dev/null)" = "OK" ]; then
      break
    fi
    sleep 5
  done

  rsync -e 'ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' -av root@ose3-master.example.com:/var/lib/openshift/openshift.local.certificates /var/lib/openshift/ 2>/dev/null

  sed -i -e 's/^OPTIONS=.*/OPTIONS="--loglevel=4"/' /etc/sysconfig/openshift-node

  sed -i -e 's!^MASTER_URL=.*!MASTER_URL="http://ose3-master.example.com:4001"!; s!^OPTIONS=.*!OPTIONS="-v=4"!; s!^DOCKER_OPTIONS=.*!DOCKER_OPTIONS="--insecure-registry=0.0.0.0/0 -b=lbr0 --mtu=1450 --selinux-enabled"!' /etc/sysconfig/openshift-sdn-node

  sed -i -e "s!^MINION_IP=.*!MINION_IP=\"$IP\"!" /etc/sysconfig/openshift-sdn-node

  ln -s /usr/lib/systemd/system/openshift-sdn-node.service /etc/systemd/system/multi-user.target.wants/openshift-sdn-node.service
  systemctl start openshift-sdn-node
}

add_vagrant_keys
docker load </vagrant/jminter-sti-gcc/jminter-sti-gcc.tar

curl -so /etc/yum.repos.d/rhel-7-server-rpms.repo http://192.168.0.254:8086/rhel-7-server-rpms.repo
http_proxy=http://192.168.0.254:8080/ yum install -y nmap-ncat PyYAML

IP=$(interface_ip eth1)

if [ $IP = 192.168.0.40 ]; then
  install_master
else
  install_node
fi
