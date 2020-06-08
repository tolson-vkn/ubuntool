FROM ubuntu

# Packages
RUN apt-get update && apt-get install --no-install-recommends -y \
      curl \
      vim \
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
      lsof \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

# Bins from the web.
WORKDIR /tmp
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl

RUN curl -LO https://get.helm.sh/helm-v3.2.3-linux-amd64.tar.gz \
    && tar -zxvf helm-v3.2.3-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm

RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.20.5/k9s_Linux_x86_64.tar.gz \
    && tar -zxvf k9s_Linux_x86_64.tar.gz \
    && mv k9s /usr/local/bin/k9s

RUN curl -LO https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip \
    && unzip terraform_0.12.26_linux_amd64.zip \
    && mv terraform /usr/local/bin/terraform
RUN rm -rf /tmp
WORKDIR /

