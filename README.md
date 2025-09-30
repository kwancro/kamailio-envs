# AWS Multi-Environment Infrastructure

This Terraform project creates a complete AWS infrastructure with separate development and production environments, each isolated in their own subnets within a shared VPC. The infrastructure includes security groups, Jenkins instances, and networking components following AWS best practices.

## Architecture Overview

```
                    ┌───────────────────────────────────────────────────────┐
                    │                   AWS VPC                             │
                    │                172.31.0.0/16                          │
                    │                                                       │
                    │  ┌─────────────────┐    ┌─────────────────┐           │
                    │  │   Development   │    │   Production    │           │
                    │  │   Environment   │    │   Environment   │           │
                    │  │                 │    │                 │           │
                    │  │ ┌─────────────┐ │    │ ┌─────────────┐ │           │
                    │  │ │   Subnet    │ │    │ │   Subnet    │ │           │
                    │  │ │172.31.20.0/ │ │    │ │172.31.10.0/ │ │           │
                    │  │ │     24      │ │    │ │     24      │ │           │
                    │  │ │             │ │    │ │             │ │           │
                    │  │ │┌───────────┐│ │    │ │┌───────────┐│ │           │
                    │  │ ││ Jenkins   ││ │    │ ││ Jenkins   ││ │           │
                    │  │ ││ Instance  ││ │    │ ││ Instance  ││ │           │
                    │  │ ││ t3.micro  ││ │    │ ││ t3.micro  ││ │           │
                    │  │ │└───────────┘│ │    │ │└───────────┘│ │           │
                    │  │ └─────────────┘ │    │ └─────────────┘ │           │
                    │  └─────────────────┘    └─────────────────┘           │
                    │                                                       │
                    │  ┌─────────────────────────────────────────────────┐  │
                    │  │              Security Groups                    │  │
                    │  │  • SSH (22) from 0.0.0.0/0                      │  │
                    │  │  • HTTP (80) from 0.0.0.0/0                     │  │
                    │  │  • HTTPS (443) from 0.0.0.0/0                   │  │
                    │  └─────────────────────────────────────────────────┘  │
                    │                                                       │
                    │  ┌─────────────────────────────────────────────────┐  │
                    │  │              Internet Gateway                   │  │
                    │  │          (Public Route Table)                   │  │
                    │  └─────────────────────────────────────────────────┘  │
                    └───────────────────────────────────────────────────────┘
                                            │
                                            ▼
                                       Internet
```

## Network Segregation

The infrastructure provides complete network segregation between environments:

```
┌─────────────────────────────────────────────────────────────┐
│                      VPC: 172.31.0.0/16                     │
│                                                             │
│  Development Environment        Production Environment      │
│  ┌─────────────────────────┐    ┌─────────────────────────┐ │
│  │                         │    │                         │ │
│  │  Subnet: 172.31.20.0/24 │    │  Subnet: 172.31.10.0/24 │ │
│  │  ┌─────────────────────┐│    │  ┌─────────────────────┐│ │
│  │  │ Available IPs:      ││    │  │ Available IPs:      ││ │
│  │  │ 172.31.20.4 -       ││    │  │ 172.31.10.4 -       ││ │
│  │  │ 172.31.20.254       ││    │  │ 172.31.10.254       ││ │
│  │  │                     ││    │  │                     ││ │
│  │  │ Jenkins Instance:   ││    │  │ Jenkins Instance:   ││ │
│  │  │ - Private IP: Auto  ││    │  │ - Private IP: Auto  ││ │
│  │  │ - Public IP: Auto   ││    │  │ - Public IP: Auto   ││ │
│  │  │ - SSH Key: aws_ie-1 ││    │  │ - SSH Key: aws_ie-1 ││ │
│  │  └─────────────────────┘│    │  └─────────────────────┘│ │
│  └─────────────────────────┘    └─────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Module Structure

The project is organized into reusable Terraform modules:

```
.
├── main.tf                     # Root configuration and module calls
├── _variables.tf               # Global variable definitions
├── _providers.tf               # AWS provider configuration
├── _outputs.tf                 # Root-level outputs
├── _data.tf                    # Global data sources
└── modules/
    ├── vpc/                    # VPC, IGW, and route table
    │   ├── vpc.tf
    │   └── _variables.tf
    ├── security/               # Security groups
    │   ├── security-groups.tf
    │   └── _variables.tf
    ├── networking/             # Subnets and route associations
    │   ├── networking.tf
    │   ├── _variables.tf
    │   └── _data.tf
    └── jenkins-instances/      # EC2 instances
        ├── jenkins.tf
        ├── _variables.tf
        └── _output.tf
```

## Features

- ✅ **Multi-Environment Support**: Separate dev and prod environments
- ✅ **Network Isolation**: Each environment in its own subnet
- ✅ **Modular Design**: Reusable Terraform modules
- ✅ **Security Groups**: Configured for SSH, HTTP, and HTTPS access
- ✅ **Auto-Scaling Ready**: Infrastructure prepared for scaling
- ✅ **Cost-Optimized**: Uses t3.micro instances by default
- ✅ **Customizable**: All parameters configurable via variables

## Customizable Parameters

Edit `_variables.tf` to customize the infrastructure for your needs:

### Network Configuration
```hcl
variable "main_cidr_block" {
  default = "172.31.0.0/16"    # Main VPC CIDR block
}

variable "environment" {
  default = {
    development = {
      cidr_block    = "172.31.20.0/24"        # Dev subnet CIDR
      ami           = "ami-0c9e5f4bbf9701d5d" # AMI ID
      instance_type = "t3.micro"              # Instance size
    }
    production = {
      cidr_block    = "172.31.10.0/24"        # Prod subnet CIDR
      ami           = "ami-0c9e5f4bbf9701d5d" # AMI ID
      instance_type = "t3.micro"              # Instance size
    }
  }
}
```

### Security Configuration
```hcl
variable "ssh-allowed-inbound-subnets" {
  default = ["0.0.0.0/0"]    # SSH access (restrict for production)
}

variable "https-allowed-inbound-subnets" {
  default = ["0.0.0.0/0"]    # HTTPS/HTTP access
}

variable "initial_ssh_key_name" {
  default = "aws_ie-1"       # Your AWS key pair name
}
```

### AWS Configuration
Update `_providers.tf` to set your region and credentials:
```hcl
provider "aws" {
  region                   = "eu-west-1"      # Your AWS region
  shared_credentials_files = ["./_config"]    # Path to credentials
}
```

## Deployment Instructions

1. **Prerequisites**:
   - Terraform >= 1.0
   - AWS CLI configured or credentials file
   - AWS key pair created (update `initial_ssh_key_name`)

2. **Deploy**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. **Get Outputs**:
   ```bash
   terraform output
   ```

4. **Access Instances**:
   ```bash
   ssh -i ~/.ssh/your-key.pem admin@<public-ip>
   ```

## Infrastructure Components

| Component | Description | Module |
|-----------|-------------|--------|
| **VPC** | Main virtual network (172.31.0.0/16) | `modules/vpc` |
| **Internet Gateway** | Public internet access | `modules/vpc` |
| **Route Table** | Routes traffic to internet | `modules/vpc` |
| **Security Group** | Firewall rules (SSH, HTTP, HTTPS) | `modules/security` |
| **Dev Subnet** | Development network (172.31.20.0/24) | `modules/networking` |
| **Prod Subnet** | Production network (172.31.10.0/24) | `modules/networking` |
| **Jenkins Instances** | EC2 instances with Docker/Jenkins | `modules/jenkins-instances` |

## Security Considerations

⚠️ **Important Security Notes**:
- Default configuration allows SSH/HTTP/HTTPS from anywhere (0.0.0.0/0)
- For production, restrict `ssh-allowed-inbound-subnets` to your IP ranges
- Consider using a bastion host for SSH access
- Implement IAM roles instead of long-term access keys
- Enable VPC Flow Logs for network monitoring

## Outputs

The infrastructure provides these outputs:
- `jenkins_instance_public_ips`: Public IP addresses for all environments
- Instance access details for SSH connections

## Cost Estimation

With default settings (2 x t3.micro instances):
- **Estimated monthly cost**: ~$15-20 USD
- **Components**: EC2 instances, data transfer, storage
- **Optimization**: Use Reserved Instances for long-term deployments

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

## Contributing

1. Test changes in development environment first
2. Follow Terraform best practices
3. Update this README for any architectural changes
4. Ensure all modules have proper variable validation