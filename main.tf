# Define the Snowflake database, use lifecycle to prevent changes if it already exists
resource "snowflake_database" "NW_DBA1" {
  name                     = "NW_DBA1"
  data_retention_time_in_days = 3

  lifecycle {
    prevent_destroy = true
  }
}

# Define the Snowflake schema, add a count to prevent errors if it already exists
resource "snowflake_schema" "file_schema" {
  count              = 1
  database           = snowflake_database.NW_DBA1.name
  name               = "CUSTOMER_SCHEMA"
  is_transient       = false
  is_managed         = false
  data_retention_days = 1
}

# Define the Snowflake roles
resource "snowflake_role" "role_developer" {
  name = "DEVELOPER"
}

resource "snowflake_role" "role_data_analyst" {
  name = "DATA_ANALYST"
}

# Grant privileges to the roles on the database
resource "snowflake_database_grant" "db_grant" {
  database_name      = snowflake_database.NW_DBA1.name
  privilege          = "USAGE"
  roles              = [snowflake_role.role_data_analyst.name]
  with_grant_option  = false
}

# Grant privileges to the roles on the schema
resource "snowflake_schema_grant" "sch_grant" {
  database_name      = snowflake_database.NW_DBA1.name
  schema_name        = snowflake_schema.file_schema.name
  privilege          = "USAGE"
  roles              = [snowflake_role.role_developer.name]
  with_grant_option  = false
}
