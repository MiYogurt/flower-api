import use_test_server from require "lapis.spec"
import request from require "lapis.spec.server"
import truncate_tables from require "lapis.spec.db"

import Users from require "models"

cjson = require "cjson"
omit = require "utils.omit"

describe "user application #application", ->
  use_test_server!

  before_each ->
    truncate_tables Users
  
  it "request /sign_up", ->
    raw_user = {
        username: "yugo"
        email: "belovedyogurt@gmail.com"
        password: "password"
        password_repeat: "password"
        phone: "00000000000"
    }
    
    status, body = request "/sign_up", {
        headers: {
          "content-type": "application/json"
        }
        post: cjson.encode raw_user
        expect: "json"
      }

    assert.same 200, status
    assert.same omit raw_user, 
        { "password_repeat" },
      omit body, { "id" }