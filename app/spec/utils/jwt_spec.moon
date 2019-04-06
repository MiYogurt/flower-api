import
    to_string
    get_user
    from require "utils.jwt"

i = require "inspect"

describe "jwt module test #jwt", ->
    it "default", ->
        user = {
            username: "yugo"
        }

        token, err = to_string user
        
        assert.is.nil err

        user_, err = get_user token

        assert.is.nil err

        assert.is.equal user['username'], user_['username']