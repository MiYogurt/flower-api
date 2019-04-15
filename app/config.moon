import config from require "lapis.config"
config "development", ->
    jwt_key "flower_api_0ck2bq"
    admin_key "hellojecklly"
    password_salt "flower_apixxx"
    bcrypt_rounds 9
    postgres ->
        host "pg_db"
        user "postgres"
        password ""
        database "db"

config "test", ->
    jwt_key "flower_api_xx2fx6"
    admin_key "hellojecklly"
    password_salt "flower_apixxx"
    bcrypt_rounds 9
    postgres ->
        host "pg_db"
        user "postgres"
        password ""
        database "test_db"
