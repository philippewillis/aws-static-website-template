# AWS Static Website Template
- Goal is to have a template to easily deploy an Static Web application to AWS
- Have Terraform deploy it
- The `APP_NAME` & `APP_VERSION` name comes from the package.json `name` property


## Deploy
1. Make sure you have manually created an ACM cert (*view `Create ACM Cert Manually`*)
2. Define the `./.env` file from `./.env.sample
  ```bash
  AWS_PROFILE="default"
  AWS_ACCOUNT_ID="123456789012"
  TF_VERSION="1.7.5"
  HOSTED_ZONE_NAME="example.com"
  ```
3. Use Terraform to create the infra
  ```shell
  $ ./pipeline/deploy-infra.sh dev
  ```
4. Sync source code to S3

  ```shell
  # Sync Source
  $ ./pipeline/sync-source-code.sh dev
  ```


## AWS Services
- [x] S3 - store the source code
- [x] CloudFront - CDN
- [x] Route53 - DNS
- [x] ACM - Certs




## Create ACM Cert Manually

**NOTE:** *To avoid creating/updating/destroying the certificate, the Terraform will just reference the existing manually created Cert in the AWS Console*

1. Make sue you have a registered domain name within AWS Route53 or if you need to register one [go here](https://us-east-1.console.aws.amazon.com/route53/domains/home?region=us-west-2#/) 
2. Create a AWS Certificate Manager (ACM) certificate for your domain name. [go here](https://us-east-1.console.aws.amazon.com/acm/home?region=us-east-1#/welcome)
  - **We want the Cert to be in us-east-1 (N. Virginia)**
  - `Request certificate` -> `Request a public certificate`
  - For the `Fully qualified domain name`, add 2 values one *with* a `*.` and *one without* `*.` 
    `some-awesome-site.com`
    `*.some-awesome-site.com`
  - Using the wild-card certificate allows you to use the same cert for any subdomains. For example `https://api.some-awesome-site.com`
  - For `Validation method`, choose `DNS validation`, since we own the AWS domain name it makes it easier & faster
  - Use `RSA 2048`, for RSA is the most widely used key type.

