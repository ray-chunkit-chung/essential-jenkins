# Essential Jenkins
Useful Jenkinsfile and vars to reuse

# Getting started

Install Jenkins on local
```
docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
```

Get initial password in the container
```
cat /var/jenkins_home/secrets/initialAdminPassword
```

Visit in browser and enter initial password 
```
localhost:8080
```


# Install Docker Cloud in Jenkins

Hope this one really works..

https://phoenixnap.com/kb/how-to-configure-docker-in-jenkins




# Does not work => heat to pre-install docker in the image

Usually set a docker cloud host as worker. If no time for that, here is a 
```
docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home raychung/jenkins:latest
```


## OS version and architecture of jenkins/jenkins:lts-jdk11
```
cat /etc/os-release
dpkg --print-architecture
```

## Install docker

Guide: https://docs.docker.com/engine/install/debian/#install-from-a-package

Package to use: https://download.docker.com/linux/debian/dists/bullseye/pool/stable/adm64/

```
curl -o docker-ce.deb https://download.docker.com/linux/debian/dists/bullseye/pool/stable/arm64/docker-ce_20.10.17~3-0~debian-bullseye_adm64.deb
dpkg -i docker-ce.deb
```
and other necessary packages
