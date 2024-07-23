#Terraform blocks
terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.92.0"
    }
  }
}


#Provider blocks

provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_username
  password = var.snowflake_password
  role     = var.snowflake_role
}