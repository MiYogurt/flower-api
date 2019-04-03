lapis = require "lapis"
import Model from require "lapis.db.model"

class Goods extends Model
    @timestamp: false

    @relations: {
        { "comments", has_many: "GoodsComments" }
        { "orders", has_many: "Orders" }
    }