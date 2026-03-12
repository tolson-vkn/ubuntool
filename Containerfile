FROM docker.io/ubuntu:24.04

# Packages
RUN apt-get update && apt-get install --no-install-recommends -y \
      curl \
      vim \
      ncdu \
      iputils-ping \
      dnsutils \
      postgresql-client \
      postgresql-client-common \
      ca-certificates \
      nmap \
      openssh-client \ 
      iperf3 \
      tcpdump \ 
      unzip \
      sysstat \
      iproute2 \
      traceroute \
      htop \
      bc \
      lsof \
      python3 \
      python3-pip \
      coreutils \
      netcat-traditional \
      redis-tools \
      podman \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

# Bins from the web.
WORKDIR /tmp
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

RUN curl -LO https://get.helm.sh/helm-v3.17.3-linux-amd64.tar.gz \
    && curl -LO https://get.helm.sh/helm-v3.17.3-linux-amd64.tar.gz.sha256sum \
    && sha256sum -c helm-v3.17.3-linux-amd64.tar.gz.sha256sum | grep helm-v3.17.3-linux-amd64.tar.gz \
    && tar -zxvf helm-v3.17.3-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm

RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.50.4/k9s_Linux_amd64.tar.gz \
    && curl -LO https://github.com/derailed/k9s/releases/download/v0.50.4/checksums.sha256 \
    && sha256sum -c checksums.sha256 2>&1 | grep k9s_Linux_amd64.tar.gz \
    && tar -zxvf k9s_Linux_amd64.tar.gz \
    && mv k9s /usr/local/bin/k9s

RUN curl -LO https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_amd64.zip \
    && curl -LO https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_SHA256SUMS \
    && sha256sum -c terraform_1.11.4_SHA256SUMS 2>&1 | grep terraform_1.11.4_linux_amd64.zip \
    && unzip terraform_1.11.4_linux_amd64.zip \
    && mv terraform /usr/local/bin/terraform

RUN curl -LO https://github.com/stern/stern/releases/download/v1.32.0/stern_1.32.0_linux_amd64.tar.gz \
    && curl -LO https://github.com/stern/stern/releases/download/v1.32.0/checksums.txt \
    && sha256sum -c checksums.txt 2>&1 | grep stern_1.32.0_linux_amd64.tar.gz \ 
    && tar -zxvf stern_1.32.0_linux_amd64.tar.gz \
    && mv stern /usr/local/bin/stern

RUN curl -LO https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 \
    && chmod +x hey_linux_amd64 \
    && mv hey_linux_amd64 /usr/local/bin/hey

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install
ENV AWS_PAGER ''

RUN rm -rf /tmp/*
WORKDIR /

