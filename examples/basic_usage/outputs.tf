output "ipa_client_security_group" {
  value       = module.ipa_master.client_security_group
  description = "The IPA client security group."
}

output "ipa_server_security_group" {
  value       = module.ipa_master.server_security_group
  description = "The IPA server security group."
}

output "master" {
  value       = module.ipa_master.master
  description = "The IPA master EC2 instance."
}

output "replica" {
  value       = module.ipa_replica1.replica
  description = "The IPA replica EC2 instance."
}
