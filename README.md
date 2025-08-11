# Terraform Azure Infrastructure Deployment for ToDo App

## Project Overview

This project demonstrates a full infrastructure deployment for a simple ToDo List web application using Terraform and Microsoft Azure.  
The goal was to modularize infrastructure as code (IaC) into reusable Terraform modules and automate provisioning of the necessary networking, compute, and storage resources.  

The solution uses Azure Virtual Machines, Network Security, Storage Accounts, and a remote state backend to store and manage Terraform state securely.

## Tech Stack

- **Terraform** – Infrastructure as Code (IaC)  
- **Microsoft Azure** – Cloud provider  
- **Azure Virtual Machines** – Compute resources  
- **Azure Virtual Network** – Private network for deployed services  
- **Azure Blob Storage** – Remote backend for storing Terraform state  
- **Custom Script Extension** – Used for provisioning the ToDo List app on the VM  

## Project Structure
/
├─ modules/
│ ├─ network/ # Manages VNet, subnet, NSG, and public IP
│ ├─ compute/ # Manages the VM, NIC, and app deployment
│ └─ storage/ # Manages storage account and container
├─ main.tf
├─ variables.tf
├─ outputs.tf
├─ terraform.tfvars
└─ backend.tf # Remote state backend configuration


## What Was Done

### Project Structure and Modules

- Designed a modular Terraform project with:  
  - **network/** – provisions virtual network, subnet, network security group (NSG), and public IP  
  - **compute/** – provisions a VM, network interface, and deploys the ToDo app  
  - **storage/** – creates a storage account and blob container for artifacts  

### Network Module

- Created a Virtual Network with address space `10.0.0.0/16`  
- Defined a Subnet with prefix `10.0.0.0/24`  
- Configured a Network Security Group (NSG) with inbound SSH and HTTP rules  
- Created a Public IP with a dynamic DNS label built from `matetask` + random number  

### Compute Module

- Deployed an Ubuntu 22.04 VM  
- Attached a Network Interface with NSG and subnet  
- Connected via SSH key-based access  
- Used Custom Script Extension to install and run the ToDo application  

### Storage Module

- Provisioned an Azure Storage Account  
- Created a Blob Container named `task-artifacts` to store deployment files  

### Remote State (`backend.tf`)

- Configured remote backend using Azure Blob Storage to manage Terraform state  
- Used specified resource group, storage account, container, and blob key (`terraform.tfstate`)  
- Enabled collaborative and safe state management  

### Variables & Configuration

- Centralized input values in `terraform.tfvars` (location, resource names, public SSH key, etc.)  
- Defined reusable and parameterized variables in `variables.tf`  

### Deployment & Validation

- Initialized and applied the Terraform project with:  
  ```bash
  terraform init && terraform apply
Retrieved public IP / DNS and verified VM accessibility

Confirmed the ToDo app is running via a web browser

Wrote INSTRUCTION.md with detailed steps to deploy and validate the solution
