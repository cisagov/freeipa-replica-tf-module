# freeipa-replica-tf-module #

[![GitHub Build Status](https://github.com/cisagov/freeipa-replica-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/freeipa-replica-tf-module/actions)

A Terraform module for deploying a FreeIPA replica into a VPC.

## Usage ##

```hcl
module "ipa_replica" {
  source = "github.com/cisagov/freeipa-replica-tf-module"

  admin_pw                    = "thepassword"
  associate_public_ip_address = true
  aws_instance_type           = "t3.large"
  cert_bucket_name            = "certbucket"
  cert_pw                     = "lemmy"
  cert_read_role_arn          = "arn:aws:iam::123456789012:role/ReadCert-example.com"
  hostname                    = "ipa-replica1.example.com"
  private_reverse_zone_id     = "ZLY47KYR9X93M"
  private_zone_id             = "ZKX36JXQ8W82L"
  public_zone_id              = "ZJW25IWP7V71K"
  server_security_group_id    = module.ipa_master.server_security_group_id
  subnet_id                   = aws_subnet.replica_subnet.id
  tags                        = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
  ttl                         = 60
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/freeipa-replica-tf-module/tree/develop/examples/basic_usage)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers ##

| Name | Version |
|------|---------|
| aws | n/a |
| aws.public_dns | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin_pw | The password for the Kerberos admin role. | `string` | n/a | yes |
| ami_owner_account_id | The ID of the AWS account that owns the FreeIPA server AMI, or "self" if the AMI is owned by the same account as the provisioner. | `string` | `self` | no |
| associate_public_ip_address | Whether or not to associate a public IP address with the IPA replica. | `bool` | `false` | no |
| aws_instance_type | The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas. | `string` | `t3.medium` | no |
| cert_bucket_name | The name of the AWS S3 bucket where certificates are stored. | `string` | n/a | yes |
| cert_pw | The password used to protect the PKCS#12 certificates. | `string` | n/a | yes |
| cert_read_role_arn | The ARN of the delegated role that allows the relevent certificates to be read from the appropriate S3 bucket. | `string` | n/a | yes |
| hostname | The hostname of this IPA replica (e.g. ipa-replica.example.com). | `string` | n/a | yes |
| master_hostname | The hostname of the IPA master (e.g. ipa.example.com).  Only necessary if you want the replica to delay installation until the master becomes available. | `string` | | no |
| private_reverse_zone_id | The zone ID corresponding to the private Route53 reverse zone where the PTR records related to this IPA replica should be created (e.g. ZKX36JXQ8W82L). | `string` | n/a | yes |
| private_zone_id | The zone ID corresponding to the private Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L). | `string` | n/a | yes |
| public_zone_id | The zone ID corresponding to the public Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L).  Only required if a public IP address is associated with the IPA replica (i.e. if associate_public_ip_address is true). | `string` | `` | no |
| server_security_group_id | The ID for the IPA server security group (e.g. sg-0123456789abcdef0). | `string` | n/a | yes |
| subnet_id | The ID of the AWS subnet into which to deploy this IPA replica (e.g. subnet-0123456789abcdef0). | `string` | n/a | yes |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| ttl | The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing. | `number` | `86400` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| replica | The IPA replica EC2 instance. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every
directory that contains Terraform code. In this repository, these are
the main directory and the `dns` and `dns/route53` directories under
the main directory, as well as every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
