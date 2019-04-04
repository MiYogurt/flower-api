import use_test_env from require "lapis.spec"
import truncate_tables from require "lapis.spec.db"
import Goods, Users, Orders, GoodsComments
    from require "models"

import
    raw_goods,
    create_goods,

    raw_user,
    create_user,

    raw_order,
    create_order

    raw_goods_comment,
    create_goods_comment

    from require "spec.models.factory"


describe "Goods Test #model #model_goods", ->
    use_test_env!

    before_each ->
        truncate_tables Goods, Orders, Users , GoodsComments

    it "get goods", ->
        create_goods_comment!
        create_goods!

        comment = GoodsComments\find raw_goods_comment
        goods = comment\get_goods!

        assert.are.same raw_goods, goods

    it "get order", ->
        create_goods_comment!
        create_order!

        comment = GoodsComments\find raw_goods_comment
        order = comment\get_order!

        assert.are.same raw_order, order

    it "get user", ->
        create_goods_comment!
        create_user!

        comment = GoodsComments\find raw_goods_comment
        user = comment\get_user!

        assert.are.same raw_user, user

