!!! WIP !!!

Tried to be fancy with cloud-init but it doesn't do what I thought it does. I think.

First time you ssh to the box, you want to run `root_data.sh` (or the contents of) as root and then `user_data.sh` as your user.

Most likely I will employ good ol' ansible further down the line to take care of these tasks.

Have fun!
# TF Remote Dev Environment
A remote dev box on AWS for users of MacOS and VSCode.

## AWS Account
Get hold of a Key ID and a Key Secret

## AWS CLI
```
brew install awscli

aws configure
```

## AWS Keypair
### Create
```
aws ec2 create-key-pair --key-name remote-dev-box --query 'KeyMaterial' --output text > remote-dev-box.pem
```
### Set permissions
```
chmod 400 remote-dev-box.pem
```

### Optional steps
These steps are mostly for reference

#### Validate
```
aws ec2 describe-key-pairs --key-name remote-dev-box --query 'KeyPairs[0].[KeyFingerprint]' --output text --no-cli-pager

openssl pkcs8 -in remote-dev-box.pem -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
```
#### Generate public key
```
ssh-keygen -y -f remote-dev-box.pem
```
#### Delete
```
aws ec2 delete-key-pair --key-name remote-dev-box --output text --no-cli-pager
```

## Terraform
```
brew install terraform

terraform init

terraform apply #type yes
```

## Connect to box
```
# being lazy, copy ssh command to clipboard
./cmd.sh
```
Paste command in terminal so that you connect to the box and then run the contents of `root_data.sh` as root and `user_data.sh` as the ec2-user.

## VSCode SSH
### Integrated terminal (Linux) should start TMUX
Add this to VSCode settings this will open a tmux session when you use vscode's integrated terminal on the remote host. Great for long running processes.
```
...
"terminal.integrated.shell.linux": "/home/ec2-user/code-shell.sh",
...
```
### Remote-SSH: Connect to Host
Use output of `cmd.sh` command
