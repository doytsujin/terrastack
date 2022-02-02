# Prerequisites
Before you run terraform apply you need:
- A file with your credentials named "ccfs-igniters-sbx-002-ecb17f946e92.json"
- A public key named "id_rsa.pub" in the home directory inside the ".ssh" directory. The path would look as follows ""~/.ssh/id_rsa.pub"
- A private key named "id_rsa" in the home directory inside the ".ssh" directory. The path would look as follows ""~/.ssh/id_rsa.pub"

# Post install configuration
After the apply finishes successfuly we still need to do some manual configuration.

To start you need to ssh into the minion vm. Once there we will edit the file "/etc/salt/minion" using root privileges and the text editor "vim"
``` sh
sudo vim /etc/salt/minion
```