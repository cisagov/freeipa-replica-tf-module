#!/usr/bin/env python3

"""Download certificates from AWS S3.

This file is a template.  It should be processed by Terraform.
"""

# Third-Party Libraries
import boto3

# Inputs from terraform
CERT_BUCKET_NAME = "${cert_bucket_name}"
CERT_READ_ROLE_ARN = "${cert_read_role_arn}"
SERVER_FQDN = "${server_fqdn}"

# These files will be copied from the bucket and installed in the
# specified location.
INSTALLATION_MAP = {
    "fullchain.pem": "/etc/ipa/fullchain.pem",
    "privkey.pem": "/etc/ipa/privkey.pem",
}

# Create STS client
sts = boto3.client("sts")

# Assume the role that can read the certificate
stsresponse = sts.assume_role(
    RoleArn=CERT_READ_ROLE_ARN, RoleSessionName="cert_installation"
)
newsession_id = stsresponse["Credentials"]["AccessKeyId"]
newsession_key = stsresponse["Credentials"]["SecretAccessKey"]
newsession_token = stsresponse["Credentials"]["SessionToken"]

# Create a new client to access S3 using the temporary credentials
s3 = boto3.client(
    "s3",
    aws_access_key_id=newsession_id,
    aws_secret_access_key=newsession_key,
    aws_session_token=newsession_token,
)

# Copy each file from the bucket to the local file system
for src, dst in INSTALLATION_MAP.items():
    obj = s3.get_object(
        Bucket=CERT_BUCKET_NAME, Key="live/{}/{}".format(SERVER_FQDN, src)
    )
    with open(dst, "wb") as f:
        f.write(obj["Body"].read())
