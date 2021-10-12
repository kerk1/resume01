@echo off
echo Running Terraform
terraform init
terraform apply -auto-approve
terraform output > website/website/api_link.txt
cd website/website
dir
python create_script.py
cd ..
terraform init
terraform apply -auto-approve