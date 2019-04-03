lapis = require "lapis"
import Model from require "lapis.db.model"

class Subjects extends Model
    @timestamp: false
    
    @relations: {
        { "coupons", has_many: "Coupons" }
    }