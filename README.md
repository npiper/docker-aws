# Docker container for AWS Scripting

This docker container saves you setting up a Ruby / local environment where you have access to AWS assets, and can be used to generate the one time token and credentials.

## Docker Image name default

npiper/docker-aws

To see if it is built use 'docker images' and look for this label.

# Pre-Requisites
 * Access to am Amazon account and sign in credentials
 * Docker

The Docker image is base on the public `ruby:latest` image.

The image includes the following SDK's for interacting with AWS:

* AWS cli
* AWS Ruby SDK v2
* AWS ECS CLI (Container service)
# To configure

Save `.dev_env` locally (Don't check in..)

`source .dev_env`

The goal is to make this a portable Docker container that Developers / Build engineers can use to interact with AWS just by editing this file without the need of setting up their own VM , installing all required software etc;.

The build & run scripts and container itself rely on the following environment variables being created and used to set Proxy settings and user id's in a configurable manner.

```
# Your single sign-on user
export SUSER=
# Your single sign-on password
export SPASS=
```



# To Build

Execute the `./build.sh` script


# To Run

Execute the `./run.sh` script.

A docker image is created as a detached image, the docker id is printed out

use `docker exec -it <IMAGE_ID> bash` to interact with it.

## Executing scripts

Once you are in the running instance follow the following commands to start to execute AWS integration.

There is a separate 'aws' user & sub-environment created for executing these commands.

```
# Switch to aws user
su aws
# Configure your profile to use region ap-southeast-2 by default
aws configure --profile $AD_USER set region ap-southeast-2
# List the IAG AWS instances in that region
aws --no-verify-ssl --profile $AD_USER ec2 describe-instances
```
### ISSUES 
 
#### Currently getting a 'Certificate error' on trying to do this.

```
[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:581)
```

Using the `--no-verify-ssl` option after the `aws` command to work around this.

http://github.com/aws/aws-cli/issues/864


# Sample Projects

## Create Amazon EC2 Container service Identities and sample 

https://github.com/npiper/ecs-poc

# References

`/home/working/scripts/`

[AWS Using Credentials](https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs)

[Amazon Ruby v2 SDK API Docs](http://docs.aws.amazon.com/sdkforruby/api/top-level-namespace.html)

[Using Amazon ECS CLI](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html)


[github AWS-CLI Docker image project - fstab ](https://github.com/fstab/docker-aws-cli)
