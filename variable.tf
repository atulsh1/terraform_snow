# Specifying Variables

variable "snowflake_account" {
    description = "Snowflake account details"
    default = "NUDVUHU-JXB91605"
}

variable "snowflake_username" {
    description = "Snowflake user details"
    default = "atul1140"
}

variable "snowflake_password" {
    description = "Snowflake user password"
    default = "Bangalore@9990"
}


variable "snowflake_role" {
    description = "Snowflake Roles"
    default = "ACCOUNTADMIN"
}

# variable "snowflake_region" {
#     description = "Snowflake Regions"
# }