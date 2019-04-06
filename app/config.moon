import config from require "lapis.config"
config "development", ->
    jwt_key "flower_api_0ck2bq"

    postgres ->
        host "pg_db"
        user "postgres"
        password ""
        database "db"

config "test", ->
    jwt_key "flower_api_xx2fx6"

    postgres ->
        host "pg_db"
        user "postgres"
        password ""
        database "test_db"
