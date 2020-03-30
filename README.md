# This is a step-by-step guide on how to host your resume/cv on your own.
1) Install terraform
2) Generate  and download key from https://console.cloud.google.com/apis/credentials/serviceaccountkey
3) Run terraform init
4) In main.tf point your project-key. can be found on gcp console top right
5) In main.tf Point credentials to your credential file
6) Install ssh-keygen and create ssh key using the below link 
    MAC: 
    Windows:
    Linux: https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/
7) Once key is generated , change pointing of public key file to your public key inside "metadata" section of gcp.tf file 
8) run terraform init to initialize state. It will create state file on your local
9) Run terraform plan and ensure that it is creating a static external ip and a vm. Please dont change "tags" in compute cloud as these tags ensure that your vm has http and https access
10) Run terraform apply and type "yes" when prompt appears
11) This completed procurement of vm with static ip on google cloud platform




# Ansible script for installing docker on gcp vm
1) Install Ansible on your machine  --- https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#from-pip
2) change Values in Infra/Ansible_For_Docker/inventory.txt to point to your server ip,used and ssh key
3) Navigate to the folder Infra/Ansible_For_Docker/  and run  below command
    ansible-playbook -i inventory.txt Install_docker.yaml


# Jenkins and ansbile docker images
1) Install docker on your local machin
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