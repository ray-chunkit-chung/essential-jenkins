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
