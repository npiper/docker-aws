# Docker container for AWS Scripting

This docker container saves you setting up a Ruby / local environment where you have access to AWS assets, and can be used to generate the one time token and credentials.


## Docker Image name default

npiper/docker-aws

To see if it is built use 'docker images' and look for this label.

# Pre-Requisites
 * Access to am Amazon account and sign in credentials
 * Docker

The Docker image is base on the public `ruby:2.4.2` image.

The image includes the following SDK's for interacting with AWS:

* AWS cli
* AWS Ruby SDK v2
* AWS ECS CLI (Container service)


The goal is to make this a portable Docker container that Developers / Build engineers can use to interact with AWS just by editing this file without the need of setting up their own VM , installing all required software etc;.


# To Build

Execute the `./build.sh` script or

```
docker build -t npiper/docker-aws
```


# To Run

Execute the `./run.sh` script.. or

```
docker run -it npiper/docker-aws bash
```
Have your AWS Access key, Secret access key, desired region (default eu-west-1, Ireland) ready and run as your first command in the docker image:

```
aws configure
```

## Executing scripts

Once you are in the running instance follow the following commands to start to execute AWS integration.

There is a separate 'aws' user & sub-environment created for executing these commands.

```
# Switch to aws user
su aws
# Configure your profile to use region ap-southeast-2 by default
aws configure --profile $AD_USER set region ap-southeast-2
# List your AWS instances in that region
aws ec2 describe-instances
```


# Sample Projects

## Create Amazon EC2 Container service Identities and sample

https://github.com/npiper/ecs-poc

# References

[AWS Using Credentials](https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs)

[Amazon Ruby v2 SDK API Docs](http://docs.aws.amazon.com/sdkforruby/api/top-level-namespace.html)

[Using Amazon ECS CLI](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html)


[github AWS-CLI Docker image project - fstab ](https://github.com/fstab/docker-aws-cli)

#### In a Federated environment

http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html

https://aws.amazon.com/blogs/security/how-to-implement-federated-api-and-cli-access-using-saml-2-0-and-ad-fs/
