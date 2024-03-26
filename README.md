# React App Deployment on EKS Cluster using Infrastructure as Code (Terraform)

This repository contains the necessary code and configurations to deploy a React app on an Amazon EKS cluster using Terraform for infrastructure provisioning and Kubernetes for orchestration.

![AWS Architectural Diagram]([https://openai.com/favicon.ico](https://media.licdn.com/dms/image/D4D2DAQFuTbVui9p80Q/profile-treasury-image-shrink_1920_1920/0/1708372847530?e=1712055600&v=beta&t=-ijdvC0moQsK_iWyInT8Kw4ImwuN2GcmSXgf8PFLqM0))


## Prerequisites
Make sure you have the following installed and configured:
- `Terraform`
- `AWS CLI` and `AWS IAM` user with appropriate permissions
- `kubectl`
- `Docker`

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
### 1. Create Remote Backend using Terraform code in S3-files 
- Set up an `S3` bucket and `DynamoDB` table for `Terraform` state storage and locking.

### 2. Create Main Infrastructure and Provision Kubernetes (EKS) Cluster using Terraform
- Provision a VPC with 2 private and 2 public subnets across different availability zones.
- Set up Internet and NAT gateways, route tables, and associations.
- Create necessary security groups and a Bastion host for SSH access.
- Use Terraform to create the EKS cluster within the VPC.

### 4. Docker Image Creation and Push
- Write a `Dockerfile` for the `React` app.
- Build and push the `Docker` image to `Dockerhub`.

### 5. Deploy Web App
- Use kubectl to apply Kubernetes manifest files for deployment and service creation.

## Usage
### 1. Clone this repository:
```js
git clone https://github.com/DelaneKay/EKS-Terrafom-React
cd EKS-Terrafom-React
```

### 2. Set up Terraform remote backend:
```js
cd s3-files
terraform init
terraform validate
terraform plan
terraform apply
```
This will create an S3 bucket and a DynamoDB table for storing the Terraform state file.

### 3. Create Main Infrastructure
Navigate to the root directory and run:
```js
terraform init
terraform validate
terraform plan
terraform apply
```
This will create the VPC, subnets, internet gateway, NAT gateway, route table, the Bastion host and the EKS cluster.

### 4. Build and Push Docker Image
Build the Docker image and push it to Dockerhub:
```js
docker build -t your-dockerhub-username/react-app:latest .
docker login
docker push your-dockerhub-username/react-app:latest
```

### 5. Deploy Web App to EKS Cluster
Navigate to the manifest directory and apply the Kubernetes manifest files:
```js
cd manifests
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
This will create the deployment and a load balancer service for the React app.

After completing these steps, your React app should be successfully deployed on the EKS cluster.
Just to check if the nodes, pods and deployments are running in EKS cluster do the following:
```js
kubectl get nodes
kubectl get pods
kubectl get deployments
```

To the get the external IP of the load-balancer where you will see the app do the following: 
```js
kubectl get service
```

## Note
- Make sure to configure `AWS credentials` properly before running `Terraform` commands.
- Ensure that your `Dockerhub credentials` are set up for image push.
- Feel free to customize the `Terraform` variables and `Kubernetes` manifest files according to your project requirements.
