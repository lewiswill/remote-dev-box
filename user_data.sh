#!/bin/bash
cat > /home/ec2-user/code-shell.sh << EOF
#!/bin/sh
SESSION="vscode`pwd | md5`"
tmux attach-session -d -t $SESSION || tmux new-session -s $SESSION
EOF
chmod +x /home/ec2-user/code-shell.sh
# Install NVM
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc