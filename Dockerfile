FROM ubuntu:23.04
# amd64, arm64
ARG ARCH
# x86_64, aarch64
ARG ARCH2
RUN echo "Using --build-arg ARCH=$ARCH, --build-arg ARCH2=$ARCH2"

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    groff \
    less \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$ARCH2.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -f awscliv2.zip && \
    rm -rf aws

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

ENTRYPOINT ["sh", "/scripts/entrypoint.sh"]
