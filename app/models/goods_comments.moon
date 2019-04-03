lapis = require "lapis"
import Model from require "lapis.db.model"

class GoodsComments extends Model
    @timestamp: false

    @relations: {
        { "goods", belongs_to: "Goods" }
        { "user", belongs_to: "Users" }
        { "order", belongs_to: "Orders" }
    }