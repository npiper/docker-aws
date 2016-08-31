# Docker container for IAG AWS Scripting

This docker container saves you setting up a Ruby / local environment where you have access to AWS IAG assets, and can be used to generate the one time token.

## Docker Image name default

iag-aws

To see if it is built use 'docker images' and look for this label.

# Pre-Requisites

You have registered for IAG AWS access as per the formal process.

 * Docker
 * Access to chuck
 * Access to IAG's AWS as an SSO user

The Docker image is base on the public `ruby:latest` image.

The image includes the following SDK's for interacting with AWS:

* AWS cli
* ASW Ruby SDK v2

# To configure

Edit the `.dev_env` file locally to incorporate your chuck user id, username & password. (sNumber & Password)

Save `.dev_env` locally (Don't check in..)

`source .dev_env`

The goal is to make this a portable Docker container that Developers / Build engineers can use to interact with AWS just by editing this file without the need of setting up their own VM , installing all required software etc;.

The build & run scripts and container itself rely on the following environment variables being created and used to set Proxy settings and user id's in a configurable manner.

```
# Your Chuck/Jira user id i.e. neil.piper
export CHUCKUSER=

# Your s number
export SUSER=
# Your s number password
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
# Generate the access tokens, one time pass to ~/.aws/credentials file
ruby get_aws_api_keys.rb -u $AD_USER -w
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

#### May not work via VPN

When attempting to use via the VPN the `get_aws_api_keys.rb` script fails with a network error.

```
`rescue in block in connect': Failed to open TCP connection to saml.iag.com.au:443 (getaddrinfo: Name or service not known) (SocketError)
```

# References

`/home/working/scripts/`

[AWS Using Credentials](https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs)

[Amazon Ruby v2 SDK API Docs](http://docs.aws.amazon.com/sdkforruby/api/top-level-namespace.html)

[AWS IAG SSO Access](https://confluence.iag.com.au/display/SDET/AWS+Federated+SSO+Access)

[AWS IAG Portal](https://saml.iag.com.au/fim/sps/awsidp/saml20/logininitial?RequestBinding=HTTPPost&PartnerId=urn:amazon:webservices&NameIdFormat=Transient&AllowCreate=fal)

[github AWS-CLI Docker image project - fstab ](https://github.com/fstab/docker-aws-cli)
