#!/bin/bash -ex
# for userdata
# http://stackoverflow.com/questions/12417630/is-there-an-ami-that-takes-ssh-on-port-443

logger [start user-data]

perl -pi -e 's/^#?Port [0-9]+/Port ${ssh_port}/' /etc/ssh/sshd_config
service sshd restart || service ssh restart

# 自インスタンスの停止関数
cat << 'EOS' >> /home/ec2-user/.bashrc
function stop-self-instance() {
  instanceId=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
  region=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/.$//'`
  aws ec2 stop-instances --region $region --instance-ids $instanceId
}
EOS

logger [end user-data]
