from ruby:latest

# If you want 'vim' need to include these and set the proxy for apt
# Ref: http://askubuntu.com/questions/349702/apt-conf-acquirehttpproxy-proxyserverport-seems-not-to-be-used-ubuntu-13
COPY apt.conf /etc/apt/apt.conf

RUN echo "Installing AWS Image"

RUN apt-get update
RUN apt-get upgrade -y

# Set the timezone
RUN echo "Australia/Melbourne" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN gem install aws-sdk
RUN gem install nokogiri

RUN update-ca-certificates --fresh


# Following lines taken from github project - https://github.com/fstab/docker-aws-cli


# AWS CLI needs the PYTHONIOENCODING environment varialbe to handle UTF-8 correctly:
ENV PYTHONIOENCODING=UTF-8

# Set up AWS command line
# ssh lets us login to instances
# vim for editing
# python for aws cli using pip install
 
RUN apt-get install -y \
    less \
    man \
    ssh \
    python \
    python-pip \
    python-virtualenv \
    vim

RUN adduser --disabled-login --gecos '' aws

WORKDIR /home/aws

USER aws

RUN \
    mkdir aws && \
    virtualenv aws/env && \
    ./aws/env/bin/pip install awscli && \
    echo 'source $HOME/aws/env/bin/activate' >> .bashrc && \
    echo 'complete -C aws_completer aws' >> .bashrc


# Expose SSH Port
EXPOSE 22

RUN mkdir -p /home/working

WORKDIR /home/working/buildeng-sde-infra-prov/scripts/aws-api-keys/

