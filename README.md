# This is a step-by-step guide on how to host your porfolio/resume/cv on your own.

Note: I tried my best to keep this project cost effecient, so you will see a lot of free tier componenet being used

# External Dependencies :  What you need
1) Google cloud platfom Account : We will be using a free VM on GCP for hosting  our site. (you can use any other If you have cloud exposure
2) Your own domain: You can buy domains from various domain registrars (nvolves cost based on domain name)
3) Cloudflare free account :  We will be using cloudflare for providing DNS and CDN services. You can use any CDN of your choice.

# System prerequisites : What you need on your machine

1) Terraform v12 : We will be using terraform for infrastructure provisioning on GCP/any other cloud platform
2) Ansible v2.9.0 :  We need ansible for installing/updating varios infrastructure components
3) Docker CE v19.0:  We need docker for running Jenkins container on local machines



# Procuring a Google cloud VM for hosting
> Login to GCP console and access below url for generating service key. Keep this key handy as it will be needed 
        https://console.cloud.google.com/apis/credentials/serviceaccountkey
> Run terraform init
> In main.tf point your project-key. can be found on gcp console top right
> In main.tf Point credentials to your credential file
> Install ssh-keygen and create ssh key using the below link 
    >>MAC: 
    >>Windows:
    >>Linux: https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/
> Once key is generated , change pointing of public key file to your public key inside "metadata" section of gcp.tf file 
> Run terraform init to initialize state. It will create state file on your local
> Run terraform plan and ensure that it is creating a static external ip and a vm. Please dont change "tags" in compute cloud as these tags ensure   that your vm has http and https access
> Run terraform apply and type "yes" when prompt appears
> This completed procurement of vm with static ip on google cloud platform




# Ansible script for installing docker on gcp vm
1) Install Ansible on your machine  --- https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#from-pip
2) change Values in Infra/Ansible_For_Docker/inventory.txt to point to your server ip,used and ssh key
3) Navigate to the folder Infra/Ansible_For_Docker/  and run  below command
    ansible-playbook -i inventory.txt Install_docker.yaml


# Jenkins and ansbile docker images
1) Install docker on your local machine
2) Run below command for pulling latest image of jenkins
    docker pull jenkins/jenkins
3) Start jenkins images and login using root
4) run below commands to installing ansible
    apt-get update
    apt-get install ansible
5) Check if ansible is installed properlu using  below command
    ansible --version
6) what needs to be done
    create dockerfile for building image with jenkins and ansible. Also place a file inside the dockerfile which will have inventory details and ansible script and jenkins home folder with jenkins setup    


# Ansile script for deploying latest image
    sudo docker pull apoorv0692/resume
    sudo docker stop resume
    sudo docker rm resume
    sudo docker run -dti -p 80:80 --name resume apoorv0692/resume
    need to resolve ssl issue    

# ansible command for deploying latest     


# Install ansible 2.9 on jenkins container
https://tecadmin.net/install-ansible-on-debian-9-stretch/