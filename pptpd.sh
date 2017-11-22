#install pptps
sudo apt-get -y install pptpd

#ip
sudo echo "bcrelay eth0" >> /etc/pptpd.conf
sudo echo "localip 192.168.0.1" >> /etc/pptpd.conf
sudo echo "remoteip 192.168.0.100-200" >> /etc/pptpd.conf

#dns
sudo echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
sudo echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options

#add users
sudo echo "user1 * 123456 *" >> /etc/ppp/chap-secrets
sudo echo "user2 * 123456 *" >> /etc/ppp/chap-secrets
sudo echo "user3 * 123456 *" >> /etc/ppp/chap-secrets
sudo echo "user4 * 123456 *" >> /etc/ppp/chap-secrets
sudo echo "user5 * 123456 *" >> /etc/ppp/chap-secrets
sudo echo "user6 * 123456 *" >> /etc/ppp/chap-secrets
sudo echo "user7 * 123456 *" >> /etc/ppp/chap-secrets

#restart pptpd
sudo /etc/init.d/pptpd restart

#enable net forward
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p

#add iptable rules
sudo echo "iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE" > /etc/rc.local
sudo echo "iptables -A FORWARD -p tcp --syn -s 192.168.0.0/24 -j TCPMSS --set-mss 1356" >> /etc/rc.local
sudo echo "exit 0" >> /etc/rc.local
