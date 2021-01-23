#!/bin/sh
echo "ssh -i remote-dev-box.pem -l ec2-user $(echo "aws_eip.remote-dev-box-eip.public_ip" | terraform console) -A" | pbcopy