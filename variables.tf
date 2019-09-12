# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "admin_pw" {
  description = "The password for the Kerberos admin role"
}

variable "cert_bucket_name" {
  description = "The name of the AWS S3 bucket where certificates are stored"
}

variable "cert_pw" {
  description = "The password used to protect the PKCS#12 certificates"
}

variable "cert_read_role_arn" {
  description = "The ARN of the delegated role that allows the relevent certificates to be read from the appropriate S3 bucket"
}

variable "hostname" {
  description = "The hostname of this IPA replica (e.g. ipa-replica.example.com)"
}

variable "private_reverse_zone_id" {
  description = "The zone ID corresponding to the private Route53 reverse zone where the PTR records related to this IPA replica should be created (e.g. ZKX36JXQ8W82L)"
}

variable "private_zone_id" {
  description = "The zone ID corresponding to the private Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L)"
}

variable "server_security_group_id" {
  description = "The ID for the IPA server security group (e.g. sg-0123456789abcdef0)"
}

variable "subnet_id" {
  description = "The ID of the AWS subnet into which to deploy this IPA replica (e.g. subnet-0123456789abcdef0)"
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults, or their requirement is
# dependent on the values of the other parameters.
# ------------------------------------------------------------------------------

variable "ami_owner_account_id" {
  description = "The ID of the AWS account that owns the FreeIPA server AMI"
  default     = "563873274798" # CISA NCATS Playground account
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether or not to associate a public IP address with the IPA replica"
  default     = false
}

variable "aws_instance_type" {
  description = "The AWS instance type to deploy (e.g. t3.medium).  Two gigabytes of RAM is given as a minimum requirement for FreeIPA, but I have had intermittent problems when creating t3.small replicas."
  default     = "t3.medium"
}

variable "master_hostname" {
  description = "The hostname of the IPA master (e.g. ipa.example.com).  Only necessary if you want the replica to delay installation until the master becomes available."
  default     = ""
}

variable "public_zone_id" {
  description = "The zone ID corresponding to the public Route53 zone where the Kerberos-related DNS records should be created (e.g. ZKX36JXQ8W82L).  Only required if a public IP address is associated with the IPA replica (i.e. if associate_public_ip_address is true)."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "ttl" {
  description = "The TTL value to use for Route53 DNS records (e.g. 86400).  A smaller value may be useful when the DNS records are changing often, for example when testing."
  default     = 86400
}
