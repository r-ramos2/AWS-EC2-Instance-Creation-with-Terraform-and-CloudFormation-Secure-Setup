# AWS EC2 Instance Creation with Terraform (Secure Setup)

## Overview

This repository provides a simple and secure way to deploy an **Amazon EC2** instance with **Terraform**, adhering to security best practices for Infrastructure as Code (IaC).

---

## Prerequisites

Ensure the following tools are installed:

1. **Homebrew** (for macOS) - Package manager for macOS. [Install it here](https://brew.sh/).
2. **AWS CLI** - AWS command-line interface, installable via:
   ```bash
   brew install awscli
   ```
3. **Terraform** - Infrastructure as Code (IaC) tool, installable via:
   ```bash
   brew tap hashicorp/tap
   brew install hashicorp/tap/terraform
   ```

### AWS CLI Configuration

Before you begin, configure the AWS CLI with an IAM user that follows the **least privilege** principle for EC2 operations.

```bash
aws configure
```

```bash
aws sts get-caller-identity
```

```bash
curl ifconfig.me
```

> **Security Note**: Use an IAM user with only the permissions necessary to create EC2 instances and security groups. Avoid sharing access keys, and store them securely.

---

## Step 1: Configure Terraform Files

1. **`main.tf`** - Contains the configurations for the **EC2 security group** and **EC2 instance**.
   - **Replace `var.my_ip`** in the security group configuration with your IP address in CIDR notation (e.g., `"203.0.113.0/32"`) to restrict SSH access.
   - **Replace `var.ami_id`** with the AMI ID for your region (e.g., `"ami-xxxxxxxxxxxxxxxxx"` for Amazon Linux 2 in `us-east-1`).
   - **Replace `var.key_pair_name`** with the name of your existing SSH key pair.

2. **`variables.tf`** - Defines input variables for flexibility.
   - **Update `default` values** for any variables if preferred. Most importantly:
     - **`instance_type`** (e.g., `"t2.micro"` for free tier)
     - **`key_pair_name`** with the name of your SSH key pair
     - **`my_ip`** with your IP address for secure SSH access (CIDR notation).

3. **`outputs.tf`** - Outputs instance details.
   - No customization needed unless you want to change the outputs displayed.

4. **`provider.tf`** - Specifies the AWS provider and region.
   - **Ensure the `region`** is set to your preferred AWS region (e.g., `"us-east-1"`).

---

## Step 2: Initialize and Apply Terraform Configuration

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Plan the Infrastructure**:
   ```bash
   terraform plan
   ```

3. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

   ```bash
   aws ec2 describe-instances
   ```

   ```bash
   aws ec2 describe-instances --instance-ids i-xxxxxxxxxxxxxxxxx --query "Reservations[*].Instances[*].PublicIpAddress" --output text
   ```
   
> **Security Tip**: Avoid using `-auto-approve` in production environments; always review proposed changes before applying.

---

## Step 3: Access Your EC2 Instance

After deployment, Terraform will output the public IP of the EC2 instance. To SSH into your instance, use:

```bash
ssh -i path_to_your_key.pem ec2-user@<public_ip>
```

- Replace `path_to_your_key.pem` with the path to your SSH key file.
- Replace `<public_ip>` with the instance's actual public IP address, as shown in the output.

---

## Step 4: Cleanup

To avoid incurring charges, destroy the resources when you’re finished:

```bash
terraform destroy
```

Additionally, remove your AWS CLI credentials if they’re no longer needed:

```bash
aws configure unset aws_access_key_id
aws configure unset aws_secret_access_key
```

---

## Security Best Practices

- **IAM Permissions**: Use least-privilege permissions for your IAM user, limiting access to essential services only.
- **SSH Key Management**: Securely store your private key. Avoid sharing it, and consider rotating keys periodically.
- **Network Security**: Restrict SSH access to trusted IP addresses by specifying your IP in `my_ip`, instead of allowing open access (`0.0.0.0/0`).
- **Terraform State Management**: For production environments, consider a remote backend (such as an encrypted S3 bucket) for your Terraform state file.

---

## Troubleshooting

- **Permissions**: Verify that the IAM user has sufficient permissions for EC2 actions.
- **SSH Access**: If SSH fails, confirm that the security group allows inbound SSH traffic from your IP.

---

## Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/index.html)
- [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
