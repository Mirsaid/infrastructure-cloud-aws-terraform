#cloud-config

hostname: aws
fqdn: aws.priceit.cloud

users:
  - name: ansible
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh-authorized-keys:
      - ${file("ssh_keys.tpl")}
      
package_update: true
package_upgrade: true

packages:
  - software-properties-common
  - nfs-common

runcmd:
  # Create the /mnt/efs directory if it doesn't exist
  - 'test -d /mnt/efs1 || sudo mkdir /mnt/efs1'
  # Append the EFS mount configuration to /etc/fstab
  - 'echo "${efs_dns_name}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev 0 0" | sudo tee -a /etc/fstab'
  # Mount everything in fstab (which will include our new EFS mount)
  - 'sudo mount -a'
