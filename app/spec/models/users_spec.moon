import use_test_env from require "lapis.spec"
import truncate_tables from require "lapis.spec.db"
import Users, Coupons, GoodsComments, Orders, ShopCarts  from require "models"

import 
    raw_coupon, raw_order, raw_user, raw_shop_cart
    create_coupon, create_order, create_user , create_shop_cart
    from require "spec.models.factory"

describe "User Test #models #models_users", -> 
    use_test_env!

    -- 清空表
    before_each ->
        truncate_tables Users, Coupons, GoodsComments, Orders, ShopCarts

    -- 创建用户
    it "create new user",  ->

        create_user!
        user = Users\find raw_user
        assert.is.truthy(user)

    -- 更新属性
    it "update username", ->

        create_user!
        user = Users\find raw_user

        expect_username = "any"

        user\update {
            username: expect_username
        }

        assert.are.equal user.username , expect_username

        query_user = Users\find {
            username: expect_username
        }

        assert.is.truthy query_user

    -- 删除用户
    it "delete user", -> 
        create_user!
        user = Users\find raw_user
        user\delete!
        -- has delete row
        assert.is.falsy Users\find raw_user
    
    -- 获取优惠券
    it "get coupons", ->
        create_user!
        create_coupon!

        user = Users\find raw_user

        coupons = user\get_coupons!

        assert.are.equal #coupons, 1
        assert.are.same coupons[1], raw_coupon

    -- 获取订单
    it "get orders", ->
        create_user!
        create_order!

        user = Users\find raw_user

        orders = user\get_orders!

        assert.are.equal #orders, 1
        assert.are.same orders[1], raw_order


    -- 获取购物车
    it "get shop_cats", -> 
        create_shop_cart!
        create_user!

        user = Users\find raw_user

        shop_carts = user\get_shop_carts!

        assert.are.equal #shop_carts, 1
        assert.are.same shop_carts[1], raw_shop_cart
