# React App Deployment on EKS Cluster

This repository contains the necessary code and configurations to deploy a React app on an Amazon EKS cluster using Terraform for infrastructure provisioning and Kubernetes for orchestration.

## Prerequisites
Make sure you have the following installed and configured:
- Terraform
- AWS CLI and AWS IAM user with appropriate permissions
- kubectl
- Docker

## Folder Structure
- `app`: Contains the React app code
- `eks`: Terraform code for EKS cluster provisioning
- `eks-sg`: Terraform code for security group resources
- `manifest`: Kubernetes manifest files for deployment and service
- `s3-files`: S3 locking code for Terraform backend
- Individual Terraform files:
  - `bastion.tf`: Terraform code for creating a Bastion host
  - `networking.tf`: Terraform code for networking resources
  - `output.tf`: Terraform output configurations
  - `provider.tf`: Terraform provider configurations
  - `security.tf`: Terraform code for security groups

## Task Overview
### 1. Create Remote Backend
- Set up an S3 bucket and DynamoDB table for Terraform state storage.

### 2. Create Main Infrastructure
- Provision a VPC with 2 private and 2 public subnets across different availability zones.
- Set up Internet and NAT gateways, route tables, and associations.
- Create necessary security groups and a Bastion host for SSH access.

### 3. Provision Kubernetes (EKS) Cluster
- Use Terraform to create the EKS cluster within the VPC.

### 4. Docker Image Creation and Push
- Write a Dockerfile for the React app.
- Build and push the Docker image to Dockerhub.

### 5. Deploy Web App
- Use kubectl to apply Kubernetes manifest files for deployment and service creation.

## Usage
1. Clone this repository:
