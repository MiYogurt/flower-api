import use_test_server from require "lapis.spec"
import request from require "lapis.spec.server"
import truncate_tables from require "lapis.spec.db"

import Users from require "models"

cjson = require "cjson"
omit = require "utils.omit"

i = require "inspect"

describe "user application #application #application_user", ->
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
    raw_user_str = cjson.encode raw_user
    status, body = request "/sign_up", {
        headers: 
            'content-type': 'application/json'
        expect: "json"
        method: "POST"
        post: raw_user_str
      }
    assert.same 200, status
    assert.truthy body['token']

  it "request /sign_in", ->
    raw_user = {
        username: "yugo"
        email: "belovedyogurt@gmail.com"
        password: "password"
        phone: "00000000000"
    }

    Users\create raw_user
    
    status, body = request "/sign_in", {
        headers: {
          "content-type": "application/json"
        }
        post: cjson.encode {
          email: "belovedyogurt@gmail.com"
          password: "password"
        }
        expect: "json"
      }

    assert.same 200, status
    assert.truthy body['token']

