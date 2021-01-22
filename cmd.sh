#!/bin/sh
echo "ssh -i remote-dev-box.pem -l ec2-user $(echo "aws_instance.remote-dev-box.public_ip" | terraform console)" | pbcopy