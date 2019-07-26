export DEBIAN_FRONTEND=noninteractive

echo -e " 


slapd slapd/internal/generated_adminpw password test

slapd slapd/no_configuration boolean false
slapd slapd/domain string wisc.cloudlab.us
slapd slapd/internal/adminpw password test
slapd slapd/backend string MDB
slapd slapd/purge_database boolean true
slapd slapd/move_old_database boolean true

slapd slapd/root_password password test 
slapd slapd/root_password_again password test



slapd slapd/password2 password test
slapd slapd/password1 password test


slapd slapd/unsafe
slapd shared/organization string IT410



slapd slapd/allow_ldap_v2 boolean false


" | sudo debconf-set-selections


sudo apt-get update
sudo apt-get install -y slapd ldap-utils
sudo dpkg-reconfigure slapd
sudo ufw allow ldap


cat>> location  <<'EOF'
ldapadd -x -D cn=admin,dc=wisc,dc=cloudlab,dc=us -W -f basedn.ldif
slappasswd
ldapadd -x -D cn=admin,dc=wisc,dc=cloudlab,dc=us -W -f users.ldif
ldapsearch -x -LLL -b dc=wisc,dc=cloudlab,dc=us 'uid=student' cn gidNumber



#ssh into ldap client
sudo apt-get update
sudo apt install -y libnss-ldap libpam-ldap ldap-utils
