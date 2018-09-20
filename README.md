# Open SC Terraform Infrastructure

Creates a custom VPC for hosting Aurora RDS (Postgres Engine) and for the lambda functions.

# Quick Start
```bash
pip install awsmfa
terraform init
awsmfa -i <PROFILE>
```

## Verify everything looks good:
```bash
terraform plan -var 'postgres_user=testuser' -var 'postgres_password=test123$'
```

## Apply the Plan
```bash
terraform apply
```