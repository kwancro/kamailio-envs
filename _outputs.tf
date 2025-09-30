output "jenkins_instance_public_ips" {
  description = "Public IP addresses of Jenkins instances"
  value = {
    for env, instance in module.jenkins-instances : env => instance.Jenkins-Public-IPs
  }
}