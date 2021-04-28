## Network Dashboard

This is a my dashboard and monitoring software for my home network.
It also includes and manages a dhcp server as well as a dns server.

### Deployment

The application as well as the dns and DHCP servers live on their own maschine, in my case a VM (2 cores and 2gb ram seams sufficient). 

1. Install ubuntu server 20.04 lts (other versions/distros might work, but it´s developed for ubuntu 20.04)
2. Make sure you can login as root via ssh using your public key
3. Install ansible and required collections on your local maschine  
  `sudo apt install ansible`  
  `ansible-galaxy install -r deployment/ansible_requirements.yml`
4. Put your ssh public key into `deployment/deploy_ssh_keys`
5. Setup everything on the server using the playbook  
  `ansible-playbook deployment/setup_appserver.yml`
6. Deploy the rails application to the server with capistrano  
  `bundle exec cap production deploy`
   
* The **hostname** for the deployment is specified in `config/deploy/production.rb` and `deployment/setup_appserver.yml`.
  It also has to be in in the ansible host inventory `/etc/ansible/hosts`.
