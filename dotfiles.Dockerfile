FROM ubuntu:latest

ARG TAGS
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y software-properties-common \
    && apt-add-repository -y ppa:ansible/ansible \
    && apt update \
    && apt install -y curl git ansible build-essential

ARG USERNAME=joqsan
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# WORKDIR /usr/local/bin
WORKDIR /home/joqsan

COPY --chown=joqsan:joqsan my-pass my-pass
COPY --chown=joqsan:joqsan .ssh/id_ed25519.pub .ssh/id_ed25519.pub
COPY --chown=joqsan:joqsan .ssh/config .ssh/config
# COPY --chown=joqsan:joqsan .ssh .ssh
COPY --chown=joqsan:joqsan tasks tasks
COPY --chown=joqsan:joqsan local.yml local.yml
COPY --chown=joqsan:joqsan run-ansible run-ansible



