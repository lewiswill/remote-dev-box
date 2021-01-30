#!/bin/sh
ssh -i remote-dev-box-key -l ec2-user $(echo "aws_eip.remote-dev-box-eip.public_dns" | terraform console | sed s/\"//g) -A