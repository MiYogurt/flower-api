lapis = require "lapis"
import Model from require "lapis.db.model"

class Orders extends Model
    @primary_key: "uid"

    @relations: {
        { "user", belongs_to: "Users" }
        { "goods", belongs_to: "Goods" }
        { "comment", has_one: "GoodsComments" }
    }

    @timestamp: false