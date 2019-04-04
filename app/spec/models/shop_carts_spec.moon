import use_test_env from require "lapis.spec"
import truncate_tables from require "lapis.spec.db"
import ShopCarts, Users, Goods from require "models"


import
    raw_shop_cart,
    create_shop_cart,
    raw_user,
    create_user,
    raw_goods,
    create_goods
    from require "spec.models.factory"


describe "ShopCarts Test #model #model_shop_carts", ->
    use_test_env!

    before_each ->
        truncate_tables ShopCarts, Users, Goods

    it "get user", ->
        create_shop_cart!
        create_user!

        shop_cart = ShopCarts\find raw_shop_cart
        user = shop_cart\get_user!

        assert.are.same raw_user, user
    
    it "get goods", ->
        create_shop_cart!
        create_goods!

        shop_cart = ShopCarts\find raw_shop_cart
        goods = shop_cart\get_goods!

        assert.are.same raw_goods, goods