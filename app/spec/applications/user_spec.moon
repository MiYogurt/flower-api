import use_test_server from require "lapis.spec"
import request from require "lapis.spec.server"
import truncate_tables from require "lapis.spec.db"

import Users from require "models"

cjson = require "cjson"
omit = require "utils.omit"

i = require "inspect"

import to_string from require "utils.jwt"

import pre_user from require "utils.pre_user"

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

    pre_user raw_user

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

  it "request /user_info", ->
    raw_user = {
        username: "yugo"
        email: "belovedyogurt@gmail.com"
        password: "password"
        phone: "00000000000"
    }

    Users\create raw_user

    token  = to_string raw_user

    status, body = request "/user_info"
      headers: 
        "content-type": "application/json"
        "x-access-token": token
      expect: "json"

    assert.equal 200, status
    assert.same omit(raw_user, {"password"}), body
