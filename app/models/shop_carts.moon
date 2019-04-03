lapis = require "lapis"
import Model from require "lapis.db.model"

class ShopCarts extends Model
    @relations: {
        { "user", belongs_to: "Users" }
        { "goods", belongs_to: "Goods" }
    }