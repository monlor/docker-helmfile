FROM alpine:latest

LABEL author=monlor

ENV HELM_VERSION="v3.8.0"

ENV HELMFILE_VERSION="v0.144.0"

ENV SOPS_VERSION="v3.7.2"

RUN apk update && apk add --no-cache age curl git bash && \
    # k8s 工具
    curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    # 安装 helm
    curl -fsSLO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    tar xzvf helm-${HELM_VERSION}-linux-amd64.tar.gz --strip 1 -C /usr/local/bin linux-amd64/helm && \
    rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    # 安装 helmfile 
    curl -Lo /usr/local/bin/helmfile https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    # 安装 sops
    curl -Lo /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64 && \
    # 授权
    chmod 0755 /usr/local/bin/* && \
    # 安装helm插件
    helm plugin install https://github.com/jkroepke/helm-secrets && \
    helm plugin install https://github.com/databus23/helm-diff