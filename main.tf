# create snowflake database
resource "snowflake_database" "cdwdev" {
  name = "cdwdev"
}

# create snowflake schema
resource "snowflake_schema" "finance" {
  name     = "finance"
  database = snowflake_database.cdwdev.name
}

# create snowflake schema
resource "snowflake_schema" "hr" {
  name     = "hr"
  database = snowflake_database.cdwdev.name
}

# create snowflake schema
resource "snowflake_schema" "analyst" {
  name     = "analyst"
  database = snowflake_database.cdwdev.name
}

# create snowflake schema
resource "snowflake_schema" "credit" {
  name     = "credit"
  database = snowflake_database.cdwdev.name
}

# create snowflake schema
resource "snowflake_schema" "debit" {
  name     = "debit"
  database = snowflake_database.cdwdev.name
}


# create snowflake roles
resource "snowflake_role" "finance" {
  name = "svc_finance_dev_role" 
}

# create snowflake roles
resource "snowflake_role" "tranacation" {
  name = "svc_transcation_dev_role"      
}

# create snowflake roles
resource "snowflake_role" "hr" {
  name = "svc_hr_dev_role"      
}

# create snowflake roles - service roles   # RW role
resource "snowflake_role" "developer" {
  name = "svc_rw_dev_role"       
}


# create snowflake users service user for etl use cases - tf script
resource "snowflake_user" "etl" {
  name     = "svc_etl_deployment_dev_user"
  password = "Qassword123!"
}


# # grant role to database
resource "snowflake_database_grant" "db_grant" {
  database_name = snowflake_database.cdwdev.name
  roles          = [snowflake_role.developer.name, snowflake_role.finance.name, snowflake_role.hr.name, snowflake_role.tranacation.name]
  privilege      = "usage"
  with_grant_option   = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_finance" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.finance.name
  roles          = [snowflake_role.finance.name] # ro
  privilege      = "usage"
  with_grant_option      = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_hr" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.hr.name
  roles          = [snowflake_role.hr.name] # ro
  privilege      = "usage"
  with_grant_option      = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_credit" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.credit.name
  roles          = [snowflake_role.tranacation.name] # ro
  privilege      = "usage"
  with_grant_option      = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_debit" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.debit.name
  roles          = [snowflake_role.tranacation.name] # ro
  privilege      = "usage"
  with_grant_option      = true
}


# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_finance_rw" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.finance.name
  roles          = [snowflake_role.developer.name] # rW
  privilege      = "ALL PRIVILEGES"
  with_grant_option      = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_hr_rw" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.hr.name
  roles          = [snowflake_role.developer.name] # rW
  privilege      = "ALL PRIVILEGES"
  with_grant_option      = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_credit_rw" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.credit.name
  roles          = [snowflake_role.developer.name] # rW
  privilege      = "ALL PRIVILEGES"
  with_grant_option      = true
}

# # grant role to schema
resource "snowflake_schema_grant" "schema_grant_debit_rw" {
  database_name = snowflake_database.cdwdev.name
  schema_name   = snowflake_schema.debit.name
  roles          = [snowflake_role.developer.name] # rW
  privilege      = "ALL PRIVILEGES"
  with_grant_option      = true
}

# Role to role grant from SVC to AD - SVC has access to schema and DB

resource "snowflake_role_grants" "finance_role" {
  role_name     = snowflake_role.finance.name  
  roles = ["AD_FINANCE_ANALYST", "AD_BANK_ANALYST"]    # AD group
}


resource "snowflake_role_grants" "hr_role" {
  role_name     = snowflake_role.hr.name  
  roles = ["AD_HR_ANALYST"]    # AD group
}

resource "snowflake_role_grants" "tranacation_role" {
  role_name     = snowflake_role.tranacation.name  
  roles = ["AD_BANK_ANALYST"]    # AD group
}

resource "snowflake_role_grants" "dev_role" {
  role_name     = snowflake_role.developer.name  
  users = [snowflake_user.etl.name]    # Service User
}