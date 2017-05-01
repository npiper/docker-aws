#FROM cloudgear/ruby:2.2 
FROM ruby:2.4.1
RUN echo "Installing AWS Image"

RUN apt-get update
RUN apt-get upgrade -y
# Set the timezone
RUN apt-get install -y ntp ntpdate apt-utils
RUN echo "Australia/Melbourne" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
RUN gem install aws-sdk
RUN gem install nokogiri

RUN update-ca-certificates --fresh

# Following lines taken from github project - https://github.com/fstab/docker-aws-cli
RUN apt-get install -y curl

# Install Amazon ECS CLI
RUN curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
RUN chmod +x /usr/local/bin/ecs-cli
RUN ecs-cli --version

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
    sudo \
    python \
    python-pip \
    python-virtualenv \
    python-dev \
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
RUN echo 'new test'

# Expose SSH Port
EXPOSE 22
