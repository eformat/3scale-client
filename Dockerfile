FROM registry.redhat.io/3scale-amp2/toolbox-rhel7:3scale2.10

ARG HELM_VERSION=3.5.3
ARG JQ_VERSION=1.6
ARG OC_VERSION=4.6
ARG YQ_VERSION=4.5.1

USER root
RUN yum install -y git net-tools && \
    ### tools
    curl -Lo /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
    chmod +x /usr/local/bin/jq && \
    curl -L https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar --strip-components=1 -C /usr/local/bin -xzf - linux-amd64/helm && \
    curl -Lo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 && \
    chmod +x /usr/local/bin/yq && \
    rm -f /usr/bin/oc && \
    curl -L http://mirror.openshift.com/pub/openshift-v4/clients/oc/${OC_VERSION}/linux/oc.tar.gz | tar -C /usr/local/bin -xzf - && \
    ### Cleanup
    yum clean all && \
    rm -rf /var/cache/yum

USER 1001
WORKDIR ${USER_HOME_DIR}
