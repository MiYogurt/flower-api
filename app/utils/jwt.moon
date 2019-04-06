jwt = require "luajwt"

import get from require "lapis.config"

alg = "HS256"

config = get!

copy = (source, time) ->
    time or= 3600 * 24
    default = {
        iss: "flower_api" -- 签发者
        nbf: os.time() -- 开始日期
        exp: os.time() + time -- 截止日
    }
    for k,v in pairs source
        default[k] = v
    
    return default        

to_string = (user, time) ->
    _user = {
        id: user.id
        email: user.id
        username: user.username
    }
    jwt.encode copy(_user, time), 
        config.jwt_key, alg

get_user = (token) ->
    jwt.decode token, config.jwt_key, true

return {
    :to_string
    :get_user
}        