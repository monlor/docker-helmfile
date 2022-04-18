FROM alpine:latest

LABEL author=monlor

RUN apk update && apk add --no-cache age && \
    # k8s 工具
    curl -Lo /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x /usr/local/bin/kubectl && \
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
    # 安装 helmfile 
    curl -Lo /usr/local/bin/helmfile https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    chmod + /usr/local/bin/helmfile && \
    # 安装 sops
    curl -Lo /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64 && \
    chmod +x /usr/local/bin/sops && \
    # 安装helm插件
    helm plugin install https://github.com/jkroepke/helm-secrets && \
    helm plugin install https://github.com/databus23/helm-diff