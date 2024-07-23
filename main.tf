resource "snowflake_database" "NW_DBA1" {
  name                     = "NW_DBA1"
  data_retention_time_in_days = 3
}

resource "snowflake_schema" "file_schema" {
  database           = snowflake_database.NW_DBA1.name
  name               = "CUSTOMER_SCHEMA"
  is_transient       = false
  is_managed         = false
  data_retention_days = 1
}

resource "snowflake_role" "role_developer" {
  name = "DEVELOPER"
}

resource "snowflake_role" "role_data_analyst" {
  name = "DATA_ANALYST"
}

resource "snowflake_database_grant" "db_grant" {
  database_name      = snowflake_database.NW_DBA1.name
  privilege          = "USAGE"
  roles              = [snowflake_role.role_data_analyst.name]
  with_grant_option  = false
}

resource "snowflake_schema_grant" "sch_grant" {
  database_name      = snowflake_database.NW_DBA1.name
  schema_name        = snowflake_schema.file_schema.name
  privilege          = "USAGE"
  roles              = [snowflake_role.role_developer.name]
  with_grant_option  = false
}
