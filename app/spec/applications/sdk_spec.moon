import use_test_server from require "lapis.spec"
import request from require "lapis.spec.server"
import truncate_tables from require "lapis.spec.db"

import Users from require "models"
import Model from require "lapis.db.model"

db = require "lapis.db"
cjson = require "cjson"
omit = require "utils.omit"
i = require "inspect"

raw_user = {
    id: 1
    username: "yugo"
    email: "belovedyogurt@gmail.com"
    password: "password"
    phone: "00000000000"
}

create_user = ->
    request "/sdk/users", {
        method: "POST"
        headers: 
          'content-type': 'application/json'
          'x-access-token': 'hellojecklly'
        post: cjson.encode raw_user
        expect: "json"
    }

describe "sdk application #application #sdk", ->
  use_test_server!

  before_each ->
    truncate_tables Users
  
  it "request users table info", ->
    
    status, body = request "/sdk/users/info", {
        headers:
          'x-access-token': 'hellojecklly'
        expect: "json"
    }

    assert.same 200, status
    assert.equal 5, #body

  it "create users by put", ->
    status, body = create_user!
    assert.same 200, status
    assert.same raw_user, body

  it "query users by query api", ->
    for i = 1, 32
        raw_user["id"] = i
        Users\create raw_user
    status, body = request "/sdk/users/query", {
        headers: 
          'content-type': 'application/json'
          'x-access-token': 'hellojecklly'
        expect: "json"
        method: "POST"
    }

    assert.same 200, status
    assert.same 4, body["all"]
  
  it "update users by put", ->
    Users\create raw_user
    raw_user['username'] = "coco"
    status, body = request "/sdk/users/#{raw_user.id}"
        headers: 
          'content-type': 'application/json'
          'x-access-token': 'hellojecklly'

        expect: "json"
        method: "PUT"
        data: cjson.encode raw_user
    
    assert.equal 200, status
    assert.same raw_user, body

  it "delete users by delete", ->
    Users\create raw_user
    status, body = request "/sdk/users/#{raw_user.id}"
      headers: 
        'content-type': 'application/json'
        'x-access-token': 'hellojecklly'
      expect: "json"
      method: "DELETE"
    
    assert.equal 200, status
    assert.is.falsy Users\find raw_user.id