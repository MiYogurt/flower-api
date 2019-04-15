import get from require "lapis.config"

config = get!

password_salt = config['password_salt']
bcrypt_rounds = config['bcrypt_rounds']


bcrypt = require "bcrypt"

pre_user = (user) ->
    user['password'] = bcrypt.digest password_salt .. user['password'], bcrypt_rounds
    user

check_pwd = (user_input_pwd, db_pwd) ->
     bcrypt.verify password_salt .. user_input_pwd, db_pwd

return {
    :pre_user
    :password_salt
    :bcrypt_rounds
    :check_pwd
}