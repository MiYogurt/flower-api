jwt = require "luajwt"

import get from require "lapis.config"

pick = require "utils.pick"
copy = require "utils.copy"

alg = "HS256"

key = get!['jwt_key']

normalize = (source, exp) ->
    exp or= 3600 * 24

    default = {
        iss: "flower_api" -- 签发者
        nbf: os.time() -- 开始日期
        exp: os.time() + exp -- 截止日
    }
    
    return copy source, default        

to_string = (user, time) ->
    picked_user = pick user, { "id", "username", "email" }
    jwt.encode normalize(picked_user, time), 
        key, alg

get_user = (token) ->
    -- 设置为 false 屏蔽测试环境取到的 key 不一样
    jwt.decode token, key, false

return {
    :to_string
    :get_user
}        