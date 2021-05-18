FROM ubuntu

# Packages
RUN apt-get update && apt-get install --no-install-recommends -y \
      curl \
      vim \
      ncdu \
      iputils-ping \
      dnsutils \
      postgresql-client \
      ca-certificates \
      nmap \
      openssh-client \ 
      iperf3 \
      tcpdump \ 
      unzip \
      sysstat \
      iproute2 \
      htop \
      bc \
      lsof \
      python3 \
      python3-pip \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

# Bins from the web.
WORKDIR /tmp
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

RUN curl -LO https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz \
    && tar -zxvf helm-v3.5.4-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm

RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.24.9/k9s_Linux_x86_64.tar.gz \
    && tar -zxvf k9s_Linux_x86_64.tar.gz \
    && mv k9s /usr/local/bin/k9s

RUN curl -LO https://releases.hashicorp.com/terraform/0.15.2/terraform_0.15.2_linux_amd64.zip \
    && unzip terraform_0.15.2_linux_amd64.zip \
    && mv terraform /usr/local/bin/terraform

RUN curl -LO https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 \
    && chmod +x stern_linux_amd64 \
    && mv stern_linux_amd64 /usr/local/bin/stern

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install
ENV AWS_PAGER ''
RUN rm -rf /tmp/*
WORKDIR /

