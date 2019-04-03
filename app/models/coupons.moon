lapis = require "lapis"
import Model from require "lapis.db.model"

class Coupons extends Model
    @timestamp: false

    @relations: {
        { "user", belongs_to: "Users" }
        { "subject", belongs_to: "Subjects" }
    }