
#!/bin/bash -xe

#EFS Mounting
sudo su -
yum update -y
yum install -y nfs-utils
FILE_SYSTEM_ID=fs- 05ef6738c6209ceda
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone )
REGION=${AVAILABILITY_ZONE:0:-1}
MOUNT_POINT=/var/www/html
mkdir -p ${MOUNT_POINT}
chown ec2-user:ec2-user ${MOUNT_POINT}
echo ${FILE_SYSTEM_ID}.efs.${REGION}.amazonaws.com:/ ${MOUNT_POINT} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0 >> /etc/fstab
mount -a -t nfs4
chmod -R 755 /var/www/html


DB_NAME='wordpressdb'

DB_USER='admin'

DB_PASSWORD='stackinc'

DB_HOST='localhost'

#get the latest versions of the LAMP MariaDB and PHP packages for Amazon Linux 2
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
#install the Apache web server, MariaDB, and PHP software packages
sudo yum install -y httpd mariadb-server
#Start the Apache web server.
sudo systemctl start httpd
#configure the Apache web server to start at each system boot.
sudo systemctl enable httpd

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1