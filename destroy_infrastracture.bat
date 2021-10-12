@echo off
echo Destroy Terraform
terraform destroy -auto-approve 
cd website
terraform destroy -auto-approve