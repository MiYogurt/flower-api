lapis = require "lapis"
import Model from require "lapis.db.model"

class Categorys extends Model
    @timestamp: false

    @relations: {
        { "goods", has_many: "Goods" }
    }