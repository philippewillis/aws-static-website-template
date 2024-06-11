# AWS Static Website Template
- Goal is to have a template to easily deploy an Static Web application to AWS
- Have Terraform deploy it




## Notes
- The App name comes from the package.json `name` property
- Create a `./.env` file from the `./.env.sample`




## Deploy
```shell
# Infra
$ ./pipeline/deploy.sh dev

# Sync Source
$ ./pipeline/sync-source-code.sh dev

```



## AWS Services
- [x] S3 - store the source code
- [x] CloudFront - CDN
- [ ] Route53 - DNS
- [ ] ACM - Certs
