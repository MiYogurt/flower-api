import config from require "lapis.config"
config "development", ->
  postgres ->
    host "pg_db"
    user "postgres"
    password ""
    database "db"