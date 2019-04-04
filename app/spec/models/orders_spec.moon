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
    create_order,

    raw_goods_comment,
    create_goods_comment

    from require "spec.models.factory"


describe "Orders Test #model #model_orders", ->
    use_test_env!

    before_each ->
        truncate_tables Goods, Users, Orders, GoodsComments

    -- it "get goods", ->
    --     create_order!
    --     create_goods!

    --     order = Orders\find raw_order
    --     goods = order\get_goods!

    --     assert.are.same raw_goods, goods

    -- it "get user", ->
    --     create_order!
    --     create_user!

    --     order = Orders\find raw_order
    --     user = order\get_user!

    --     assert.are.same raw_user, user

    it "get comment", ->
        create_order!
        create_goods_comment!
        order = Orders\find raw_order
        comment1 = GoodsComments\find raw_goods_comment
        assert.is.truthy comment1
        comment = order\get_comment!
        assert.is.truthy comment
        assert.are.same raw_goods_comment, comment


