#!/bin/sh
cd terraform
EIP=$(echo "aws_eip.remote-dev-box-eip.public_dns" | terraform console | sed s/\"//g)
cd ..
ssh -i remote-dev-box-key -l ec2-user $EIP -A