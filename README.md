# Prerequisites
Before you run terraform apply you need:
- A file with your credentials named "ccfs-igniters-sbx-002-ecb17f946e92.json"
- A public key named "id_rsa.pub" in the home directory inside the ".ssh" directory. The path would look as follows ""~/.ssh/id_rsa.pub"
- A private key named "id_rsa" in the home directory inside the ".ssh" directory. The path would look as follows ""~/.ssh/id_rsa.pub"

# Post install configuration
After the apply finishes successfuly we still need to do some manual configuration.

To start you need to ssh into the minion vm. Once there we will edit the file "/etc/salt/minion" using root privileges and the text editor "vim"
``` bash
sudo vim /etc/salt/minion
```

In the file set the master node ip address
``` bash
# Set the location of the salt master server. If the master server cannot be 
# resolved, then the minion will fail to start. 
master: the ip of the master vm
```

Now we need to run the following command on the "master node"
``` bash
$ sudo salt-key --finger-all
Local Keys:
master.pem:  90:54:a9:21:d6:5e:dd:aa:f3:d6:c5:cc:3b:80:88:f5:15:69:93:79:d5:bb:9a:d2:26:fd:3a:38:26:f1:a6:c2
master.pub:  8e:eb:68:7c:99:64:37:dd:04:6c:b1:67:3f:43:1a:b2:e6:9b:57:a3:24:fd:5a:72:ce:2d:0e:26:79:b0:f7:b7
```

Now copy the public fingerprint "master.pub" and add it to the minion configuration file "/etc/salt/minion"

``` bash
# Fingerprint of the master public key to validate the identity of your Salt master 
# before the initial key exchange. The master fingerprint can be found by running 
# "salt-key -f master.pub" on the Salt master. 
master_finger: '8e:eb:68:7c:99:64:37:dd:04:6c:b1:67:3f:43:1a:b2:e6:9b:57:a3:24:fd:5a:72:ce:2d:0e:26:79:b0:f7:b7'
```

And let's also assign the minion a name in the configuration file "/etc/salt/minion"
``` bash
# clusters. 
id: Minion
```

Now save the file and restart the minion
``` bash
sudo systemctl restart salt-minion
```

To see the minion's fingerprint run the following command
``` bash
$ sudo salt-call key.finger --local 
local:
    f7:0b:26:49:ea:fc:9a:64:05:38:b8:0b:2e:a1:fe:83:b4:91:51:f1:30:4a:f5:f2:4a:7e:8d:bd:ca:f7:d2:ab
```

Now run the following command on the "master node" to confirm if the fingerprint of the minion matches.
``` bash
$ sudo salt-key --finger-all                              
Local Keys:
master.pem:  90:54:a9:21:d6:5e:dd:aa:f3:d6:c5:cc:3b:80:88:f5:15:69:93:79:d5:bb:9a:d2:26:fd:3a:38:26:f1:a6:c2
master.pub:  8e:eb:68:7c:99:64:37:dd:04:6c:b1:67:3f:43:1a:b2:e6:9b:57:a3:24:fd:5a:72:ce:2d:0e:26:79:b0:f7:b7
Unaccepted Keys:
Minion:  f7:0b:26:49:ea:fc:9a:64:05:38:b8:0b:2e:a1:fe:83:b4:91:51:f1:30:4a:f5:f2:4a:7e:8d:bd:ca:f7:d2:ab
```
The output above confirms that our minion has been added, now accept the Minion as below.

Now run the following command on the "salt master"
``` bash
$ sudo salt-key -a Minion1
The following keys are going to be accepted:
Unaccepted Keys:
Minion1
Proceed? [n/Y] y
Key for minion Minion1 accepted.
```

Now ping to verify the connection between the master and the minion
``` bash
$ sudo salt Minion1 test.ping 
Minion:
    True
```


# Run Remote commands on Minions from the Master
Now you can run remote commands on the minions from the master, for example installing nginx with the following command
``` bash
sudo salt Minion1 pkg.install nginx
```