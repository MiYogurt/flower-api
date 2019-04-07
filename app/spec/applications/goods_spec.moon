import use_test_server from require "lapis.spec"
import request from require "lapis.spec.server"
import truncate_tables from require "lapis.spec.db"

import Users, Categorys, Goods, GoodsComments from require "models"

cjson = require "cjson"
omit = require "utils.omit"

i = require "inspect"

import 
  raw_category
  raw_goods
  raw_goods_comment

  create_user
  create_category
  create_goods
  create_goods_comment
  from require "spec.models.factory"

describe "user application #application #application_goods", ->
  use_test_server!

  before_each ->
    truncate_tables Categorys, Goods, GoodsComments, Users
  
  it "request /categoryts", ->
    Categorys\create name: "送父母"
    status, body = request "/categorys"
      expect: 'json'
    assert.same 200, status
    assert.truthy #body

  it "request /category/:id", ->
    create_category!
    create_goods!
    create_goods_comment!
    status, body = request "/category/1"
      method: "POST"
      expect: 'json'
    assert.same 200, status
    assert.truthy #body['data']

  it "request /goods/1", ->
    create_user!
    create_category!
    create_goods!
    create_goods_comment!
    status, body = request "/goods/1"
      expect: 'json'
    assert.same 200, status
    assert.equal "test@noop.net", body.comments[1].user.email