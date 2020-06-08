# Ubuntool

Just a sample pullable docker util. I use this for CoreOS style toolboxes and pods in K8s.

It's a thicc boi, around 400MB~, so might be best to pull something like alpine-curl, if that's just what
you need. 

```
$ make
+------------------+
| ubuntool targets |
+------------------+
build        Build ubuntool locally
shell        Start a /bin/bash shell on ubuntool container
publish      Build locally and publish to registry
```

Do things:

```
docker run  --rm -i -t ubuntool bash                                                                                                                                              <<<
root@cb50a8b4bda1:/# which k9s
/usr/local/bin/k9s
root@cb50a8b4bda1:/# which ip
/usr/sbin/ip
root@cb50a8b4bda1:/# which iperf3
/usr/bin/iperf3
root@cb50a8b4bda1:/# which ss
/usr/bin/ss
```
