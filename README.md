# This is a step-by-step guide on how to host your porfolio.

> Note: I tried my best to keep this project cost free, so you will see a lot of free tier components being used.

## External Dependencies :  What you need
1. Google cloud platfom Account : We will be using a free VM on GCP for hosting  our site. (you can use any other If you have cloud exposure
2. Your own domain: You can buy domains from various domain registrars (nvolves cost based on domain name)
3. Cloudflare free account :  We will be using cloudflare for providing DNS and CDN services. You can use any CDN of your choice.

## System prerequisites : What you need on your machine

1. Terraform v12 : We will be using terraform for infrastructure provisioning on GCP/any other cloud platform.
2. Ansible v2.9.0 :  We need ansible for installing/updating varios infrastructure components.
3. Docker CE v19.0:  We need docker for running Jenkins container on local machines.
4. Any Terminal : I would recommemnd Mobax Term for windows and iTerm for Mac. Othe linux machines comes with default terminals.
5. Git: for cloning this repo on your local incase you decide to use my-work for hosting your portfolio.
6. Any editing tool : I personally use VS Code and Atom sometimes


 >If you are still reading this , i am assuming that you have decided to use this approach for hosting your resume.Hence please clone this repo  on  your local machines using below command
    >> git clone https://github.com/apoorv0692/self-hosted-resume.git

## Procuring a Google cloud VM for hosting
1. Login to GCP console and access below url for generating service credentials for your account.Download the key on your local.
    > https://console.cloud.google.com/apis/credentials/serviceaccountkey
2. Open "self-hosted-resume" folder using your code editor .
3. Navigate to "Portfolio/Infra/GCP-VM" .
3. Inside "main.tf" point "credentials" to your service credential file that we just downloaded in point number 1 
4. Inside "main.tf" file , change pointing of your project-key, You can find the project key on the top left section of your GCP Console. (add images from console)
5. Install ssh-keygen and create ssh key using the below help links.This will generate a public file (id_.pub) and a private key file (id_rsa).
    > MAC: 
    > Windows:
    > Linux: https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/
6. Once ssh key is generated, opne "gcp.tf" file and scroll down. There you will find metadata section. Please change the "path" to your public key (***.pub).
    > metadata = {
    > ssh-keys = "apoorvshrivastava:${file("path to your .pub file")}"
    > } 
7. Open your terminal and navigate to Portfolio/Infra/GCP-VM using below command.
    > cd Portfolio/Infra/GCP-VM
8. Now, run below command on the terminal to initialize state. ( This will create terrafomr state files on your local).
    > terraform init
9. Now you are all set to create your google cloud VM. Just to make sure that there are not syntax error introducted accidently and also to review what will  be created, run  below command.
    > terraform plan
> Note: Please don't change "tags" in compute cloud as these tags ensure  that your vm has http and https access

9. Run  below command to initiate vm creation and input "yes" when prompt appears
    > terraform apply
10. This completes procurement of vm with static ip on google cloud platform. You can now see that a VM is created under "compute" section and an external static IP under "VPC Networks" section of your GCP account. Please note down the static IP as we will need it in later section

## Installing Docker on GCP VM
As we will be deploying our porfolio as a docker images, we need docker on the host VM. This section will help you on how to install docker on the host VM
1. Open "self-hosted-resume" folder in your code editor .
2. Navigate to "Portfolio/Infra/Ansible_For_Docker" in the editor
3. Edit the inventory.txt file 
    > ansible_host=your_vm_static_external_ip
    > ansible_user= ssh_user (you can find the ssh user while generating ssh key)
    > ansible_ssh_private_key_file="path to your private ssh file " (This will be your id_rsa)
4. Open terminal on your current directory
5. Execute below command for installing docker on GCP VM using ansible.
    > ansible-playbook -i inventory.tx Install_docker.yaml
6. Now you are done installing docker on your GCP VM. Run below check to ensure docker is properly installed on the VM. In case of any issues. please refer to known issues section at the bottom.
    > ssh into your GCP VM using ssh service provide by GCP on the console. (add image)
    > execute below command to ensure docker is installed
        >> sudo docker info    


## Update DNS entry to your static ip . Add images in this section
Now that we are done setting up our GCP VM, lets point our domain to the VM static ip. This section will help you with how to do this, if you are using Cloudflare account. If you are using any other DNS, please refer to their documentation
1. Login to your cloudflare account .
2. On the home page click on "Add a site" .
3. Enter your domain and click "Add site" .
4. Select the free ( 0$ ) plan and click on "Confirm" .
5. Update the "Value" column of exiting "A" record with the GCP VM static IP. Don't worry if you don't find a "Save" button.Cloudflare updates the entry as soon as you change it.
6. And you are Done here.




## Installing Ansible for installing docker on gcp vm
1. Install Ansible on your machine.
2. Change Values in Infra/Ansible_For_Docker/inventory.txt to point to your server ip,used and ssh key
3. Navigate to the folder Infra/Ansible_For_Docker/  and run  below command
   > ansible-playbook -i inventory.txt Install_docker.yaml


## Jenkins and ansbile docker images
1. Install docker on your local machine
2. Run below command for pulling latest image of jenkins
    > docker pull jenkins/jenkins
3. Start jenkins images and login using root
4. run below commands to installing ansible
    > apt-get update
    > apt-get install ansible
5. Check if ansible is installed properlu using  below command
   > ansible --version
6. what needs to be done
    > create dockerfile for building image with jenkins and ansible. Also place a file inside the dockerfile which will have inventory details and >  ansible script and jenkins home folder with jenkins setup    


## Ansile script for deploying latest image
    sudo docker pull apoorv0692/resume
    sudo docker stop resume
    sudo docker rm resume
    sudo docker run -dti -p 80:80 --name resume apoorv0692/resume
    need to resolve ssl issue    

# ansible command for deploying latest     


# Install ansible 2.9 on jenkins container
https://tecadmin.net/install-ansible-on-debian-9-stretch/


## curl request on cloudflare
curl -X PUT "https://api.cloudflare.com/client/v4/zones/13bd8d5e327a1a324cc388a77d717d35/dns_records/c59df44428464ece75e517f76a514d3c" \
     -H "Authorization: Bearer CXd-s4uSQIwmz3PJmN_UDmQTMIzTrgKGVPsVk4pS" \
     -H "Content-Type:application/json" \
     --data '{"type":"A","name":"apoorv.sh","content":"35.225.197.88","ttl":120,"proxied":true}'