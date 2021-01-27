# Remote Development Environment
Your 5 year old MacBook Air doesn't cut the mustard anymore.
You like MacOS and VSCode but you need more powaaaar! 🚀

This repository will help you set up a remote dev box on AWS.
It's pretty opinionated, as it's what I use so feel free to fork to your own needs! 😉

So... I want to use the remote ssh plugin of VSCode on MacOS to connect to an EC2 instance on AWS.
I also like `.zshrc` for my terminal and I want to setup `tmux` in case my connection drops and my `docker-compose` stack stops.
Oh, and I live in London, so that's the datacenter location I want.

## AWS account
Before you do anything, you need to [create an account on AWS](https://portal.aws.amazon.com/billing/signup#/start)

Once you're logged in the console, [add a user](https://console.aws.amazon.com/iam/home?#/users) and select the user. Click on the _Security credentials_ tab, then click on _Create access keys_. Save this somewhere or download the file.

### Free tier
So the idea is that if you have a new account, you'll be eligible for the 12-month free tier promo,ie 750hrs on a t2.micro instance per month.

## Homebrew
I assume you have Homebrew installed on your Mac. If not, why not?!?

You can find it [here](https://brew.sh). Just copy the install script and run it in your terminal.

## AWS CLI (Optional)
You can install and set up the the AWS CLI after running the following commands.
```
brew install awscli

aws configure
```

## Terraform
We will use [Terraform](https://www.terraform.io) to set up the infrastructure for our remote dev box.

Firstly install Terraform
```
brew install terraform
```
Import dependencies
```
terraform init
```

## Ansible
We will use [Ansible](https://www.ansible.com) to install packages and configuration on both the remote server and our local machine.

Install ansible
```
brew install ansible
```
Install ansible requirements
```
ansible-galaxy install -r requirements.yml
```

## READY, SET, GO! 💨
After entering the following command, the following things will happen:
* Local box
  * additional pip packages will be installed (needed for the aws tasks)
  * a key pair will be generated on AWS, the private part will be downloaded locally
* Remote box
  * box set up with as t2.micro with 20GB block storage
  * [security group](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) set up with ports 22 and 80 accessible from anywhere
  * static ip [EIP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) set up
* Local box
  * `ssh_config` file with connection details saved locally - this will included along the rest of the ssh configuration
* Local box
  * install packages like git, tmux, docker, nvm
  * install VSCode tmux shell helper script
  * git clone repositories

  ```
  ansible-playbook playbook.yml
  ```

## Connect to box

* Open the "command palette" (Cmd + Shift + P)
* Select "Connect to host"
* Select "remote-dev-box"

Boom 💥  you're in!

## Bonus round
### VSCode integrated terminal (Linux) should start TMUX
Add this to VSCode settings this will open a tmux session when you use vscode's integrated terminal on the remote host. Great for long running processes.
```
...
"terminal.integrated.shell.linux": "/home/ec2-user/code-shell.sh",
...
```
