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


# Setup Docker cloud

This works?? this works???
https://stackoverflow.com/questions/55497276/how-to-find-out-or-what-is-the-correct-docker-host-url-to-use-in-jenkins-to-sp



# Setup Jenkins agent node

After all the effort, this is not what I am looking for. Good

## Reference
 - https://www.cloudbees.com/blog/how-to-install-and-run-jenkins-with-docker-compose
 - https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/client-and-managed-masters/host-key-verification-for-ssh-agents


.env file as follows
```
export JENKINS_AGENT_SSH_PUBKEY=ssh-rsa xxx user@example.com
```

docker-compose.yml
```
version: '3.9'
services:
  jenkins:
    image: jenkins/jenkins:lts-jdk11
    restart: on-failure
    ports:
      - 8080:8080
      - 50000:50000
    container_name: jenkins
    volumes:
      - jenkins_home:/var/jenkins_home
      # - /var/run/docker.sock:/var/run/docker.sock
  jenkins-agent-local:
    image: jenkins/ssh-agent:jdk11
    container_name: jenkins-agent-local
    expose:
      - 22
    environment:
      - JENKINS_AGENT_SSH_PUBKEY=${JENKINS_AGENT_SSH_PUBKEY}

volumes:
  jenkins_home:
```

docker-compose.yml can see .env file by using ${your_variable} 
https://docs.docker.com/compose/environment-variables/

The .env file feature only works when you use the docker-compose up command and does not work with docker stack deploy.


## Host key verification error

This works for me:
https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/client-and-managed-masters/host-key-verification-for-ssh-agents

1. Choose ManuallyProvidedKeyVerificationStrategy on the browser localhost > jenkins

2. Docker exec /bin/sh into the **agent** container to get the public key of the **agent**
```
cat /etc/ssh/ssh_host_rsa_key.pub
```

3. Paste the agent public key manually on the browser localhost > jenkins > Agent Node Configure



# Install Docker Cloud in Jenkins



# Long journey

Hope this one really works..

https://phoenixnap.com/kb/how-to-configure-docker-in-jenkins

Or this one
https://www.cloudbees.com/blog/how-to-install-and-run-jenkins-with-docker-compose

Or this one
https://docs.cloudbees.com/docs/cloudbees-ci-kb/latest/client-and-managed-masters/host-key-verification-for-ssh-agents

Or this one
https://stackoverflow.com/questions/36765138/bind-to-docker-socket-on-windows

Or this 
https://geekflare.com/change-docker-sock-file-path/


Or this
https://docs.docker.jp/config/daemon/daemon.html

## Blue Ocean is related??!!

https://stackoverflow.com/questions/55055488/jenkins-in-docker-cannot-connect-to-the-docker-daemon-at-unix-var-run-docke




# What was wrong with using Docker-in-Docker
This article https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/



# Pre-install docker in the image

Docker engine does not come with jenkins host
```
/var/jenkins_home/workspace/starter/flask@tmp/durable-d46f33a0/script.sh: 1: docker: not found
```
I wanted to use docker in the jenkins instance, but this is not the way it works.

The following does not work for me. 

Pre install docker engine in the jenkins image
```
FROM jenkins/jenkins:lts-jdk11

# Install docker
USER root
RUN apt-get update && \
    apt-get -y install curl iptables libdevmapper1.02.1 systemctl && \
    mkdir -p tmp && \
    curl -o tmp/containerd.io.deb https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/containerd.io_1.6.6-1_amd64.deb && \
    dpkg -i tmp/containerd.io.deb && \
    curl -o tmp/docker-ce-cli.deb https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-ce-cli_20.10.17~3-0~debian-bullseye_amd64.deb && \
    dpkg -i tmp/docker-ce-cli.deb && \
    curl -o tmp/docker-compose-plugin https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-compose-plugin_2.6.0~debian-bullseye_amd64.deb && \
    dpkg -i tmp/docker-compose-plugin && \
    curl -o tmp/docker-ce.deb https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/docker-ce_20.10.17~3-0~debian-bullseye_amd64.deb && \
    dpkg -i tmp/docker-ce.deb

# set user as jenkins
USER jenkins
```

```
docker run -d -p 8080:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home raychung/jenkins:latest
```

The error is
```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
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


# General information of docker

## Architecture
https://docs.docker.com/get-started/overview/

## Set up CI/CD
https://docs.docker.com/ci-cd/best-practices/
