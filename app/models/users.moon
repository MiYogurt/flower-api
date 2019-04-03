lapis = require "lapis"
import Model from require "lapis.db.model"

class Users extends Model
    @timestamp: false

    @relations: {
        { "coupons", has_many: "Coupons" }
        { "comments", has_many: "GoodsComments" }
        { "orders", has_many: "Orders" }
        { "shop_carts", has_many: "ShopCarts" }
    }