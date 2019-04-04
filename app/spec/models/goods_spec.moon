import use_test_env from require "lapis.spec"
import truncate_tables from require "lapis.spec.db"
import Goods, Users, Orders, GoodsComments
    from require "models"

import
    raw_goods,
    create_goods,

    raw_order,
    create_order,

    raw_goods_comment,
    create_goods_comment

    from require "spec.models.factory"


describe "Goods Test #model #model_goods", ->
    use_test_env!

    before_each ->
        truncate_tables Goods, Orders, GoodsComments

    it "get comments", ->
        create_goods_comment!
        create_goods!

        good = Goods\find raw_goods
        comments = good\get_comments!

        assert.are.same raw_goods_comment, comments[1]

    it "get orders", ->
        create_order!
        create_goods!

        good = Goods\find raw_goods
        orders = good\get_orders!

        assert.are.same raw_order, orders[1]


