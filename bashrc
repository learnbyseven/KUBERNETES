
------------
Global Proxy
------------

File = .bashrc
Configuration
-------------
export HTTP_PROXY="172.31.47.174:3128"
export HTTPS_PROXY="172.31.47.174:3128"
export NO_PROXY="localhost,127.0.0.1,172.31.43.15,192.168.0.0/16,10.96.0.0/12,172.17.0.0/16,ip-172-31-43-15"

#Source .bashrc


Package Proxy
-------------

File = /etc/apt/apt.conf.d/proxy.conf

Configuration
-------------

Acquire {
  HTTP::proxy "http://172.31.47.174:3128";
  HTTPS::proxy "http://172.31.47.174:3128";
}



Docker proxy
------------

# mdkir -p /etc/systemd/system/docker.service.d/
# vi /etc/systemd/system/docker.service.d/proxy.conf

Configuration
-------------

[Service]
Environment="HTTP_PROXY=http://172.31.47.174:3128"
Environment="HTTPS_PROXY=http://172.31.47.174:3128"
Environment="NO_PROXY="localhost,127.0.0.1,::1"

#systemctl daemon-reload
#systemctl restart docker 




