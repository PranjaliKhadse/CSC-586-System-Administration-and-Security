export DEBIAN_FRONTEND=noninteractive

echo -e " 

slapd slapd/internal/generated_adminpw password test
slapd slapd/no_configuration boolean false
slapd slapd/domain string wisc.cloudlab.us
slapd slapd/internal/adminpw password test
slapd slapd/backend string MDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true



" | sudo debconf-set-selections


sudo apt-get update
sudo apt-get install -y slapd ldap-utils
sudo dpkg-reconfigure slapd
sudo ufw allow ldap


