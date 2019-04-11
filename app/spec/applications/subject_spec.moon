import use_test_server from require "lapis.spec"
import request from require "lapis.spec.server"
import truncate_tables from require "lapis.spec.db"

import Users, Subjects, Coupons from require "models"

import raw_coupon, raw_user, create_user, raw_subject from require "spec.models.factory"

import to_string, get_user from  require "utils.jwt"

cjson = require "cjson"
omit = require "utils.omit"

i = require "inspect"

describe "user application #application #application_subject", ->
  use_test_server!

  before_each ->
    truncate_tables Users, Coupons, Subjects
  
  it "request /subjects", ->
    for i = 1, 20 
        raw_subject['id'] = i
        Subjects\create raw_subject
    status, body = request "/subjects"
        headers:
            'x-access-token': token
            'content-type': 'application/json'
        expect: 'json'

    assert.equal 200, status
    assert.equal 2, body['all']

  it "request /subject/1", ->

    Subjects\create raw_subject
    subject = Subjects\find raw_subject.id
    status, body = request "/subject/" .. raw_subject['id'],
        headers:
            'content-type': 'application/json'  
        expect: 'json'
    assert.equal 200, status
    assert.equal raw_subject['id'], body['subject']['id']

  it "request /coupons/:subject_id", ->
    create_user!
    raw_coupon['user_id'] = 0
    Coupons\create raw_coupon
    token = to_string raw_user


    status, body = request "/coupons/1"
        headers:
            'x-access-token': token
        expect: 'json'

    assert.equal 1, body['user_id']

