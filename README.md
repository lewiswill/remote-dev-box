# TF Remote Dev Environment

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
### Validate
```
aws ec2 describe-key-pairs --key-name remote-dev-box --query 'KeyPairs[0].[KeyFingerprint]' --output text --no-cli-pager

openssl pkcs8 -in remote-dev-box.pem -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
```
### Generate public key
```
ssh-keygen -y -f remote-dev-box.pem
```
### Delete
```
aws ec2 delete-key-pair --key-name remote-dev-box --output text --no-cli-pager
```

## Terraform
```
brew install terraform

terraform init

terraform apply #type yes
```

## VSCode SSH
### Integrated terminal (Linux) should start TMUX
Add this to VSCode settings
```
...
"terminal.integrated.shell.linux": "/home/ec2-user/code-shell.sh",
...
```
### Remote-SSH: Connect to Host
```
ssh -i "remote-dev-box.pem" ec2-user@PUBLIC_DNS -A
```
