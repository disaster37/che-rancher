
FROM quay.io/webcenter/che-ubi:latest

ENV \ 
    KUBECTL_VERSION="v1.21.7" \
    RANCHER_VERSION="v2.4.6" \
    HELM_VERSION="v3.7.2" \
    VAULT_VERSION="1.9.2" \
    TERRAFORM_VERSION="1.1.2" \
    TERRAGRUNT_VERSION="v0.35.16" \
    BUILDKIT_VERSION="0.1.5" \
    PLUTO_VERSION="v5.7.0" \
    DAGGER_VERSION="v0.2.8"


# Install some tools
RUN \
    echo "Install kubectl" &&\
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl &&\
    chmod +x /usr/bin/kubectl &&\
    echo "Install rancher" &&\
    curl -o- -L https://github.com/rancher/cli/releases/download/${RANCHER_VERSION}/rancher-linux-amd64-${RANCHER_VERSION}.tar.gz | tar xvz -C /usr/local/bin --strip-components=2 &&\
    chmod +x /usr/local/bin/rancher &&\
    echo "Install helm" &&\
    curl -o- -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xvz -C /usr/local/bin --strip-components=1 &&\
    chmod +x /usr/local/bin/helm &&\
    echo "Install vault" &&\
    curl -L https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -o /tmp/vault.zip &&\
    unzip /tmp/vault.zip &&\
    mv vault /usr/bin/vault &&\
    chmod +x /usr/bin/vault &&\
    echo "Install terraform" &&\
    curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform.zip &&\
    unzip /tmp/terraform.zip &&\
    mv terraform /usr/bin/terraform &&\
    chmod +x /usr/bin/terraform &&\
    echo "Install terragrunt" &&\
    curl -L https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -o /usr/bin/terragrunt &&\
    chmod +x /usr/bin/terragrunt &&\
    echo " Install buildkit for kubectl" &&\
    curl -L  https://github.com/vmware-tanzu/buildkit-cli-for-kubectl/releases/download/v${BUILDKIT_VERSION}/kubectl-buildkit-${BUILDKIT_VERSION}-1.el7.x86_64.rpm -o /tmp/kubectl-buildkit.rpm &&\
    rpm -i /tmp/kubectl-buildkit.rpm &&\
    echo "Install dagger" &&\
    curl -o- -L https://github.com/dagger/dagger/releases/download/${DAGGER_VERSION}/dagger_${DAGGER_VERSION}_linux_amd64.tar.gz | tar xvz -C /usr/local/bin --strip-components=0 &&\
    chmod +x /usr/local/bin/dagger &&\
    echo "Install plutot" &&\
    curl -o- -L https://github.com/FairwindsOps/pluto/releases/download/${PLUTO_VERSION}/pluto_${PLUTO_VERSION}_linux_amd64.tar.gz | tar xvz -C /usr/local/bin --strip-components=0 &&\
    chmod +x /usr/local/bin/dagger


# Install chectl
RUN \
    microdnf install -y nodejs &&\
    cd /home/theia &&\
    bash -c "bash <(curl -sL  https://www.eclipse.org/che/chectl/)"


# Clean
RUN \
    microdnf clean all && \
    rm -rf /tmp/* /var/tmp/*

SHELL ["/bin/bash", "-c"]