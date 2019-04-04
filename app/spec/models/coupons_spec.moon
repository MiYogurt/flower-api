import use_test_env from require "lapis.spec"
import truncate_tables from require "lapis.spec.db"
import Subjects, Coupons, Users from require "models"

import
    raw_subject,
    create_subject,
    raw_coupon,
    create_coupon,
    create_user,
    raw_user
    from require "spec.models.factory"

describe "Coupons Test #models #models_coupons", ->

    use_test_env!

    before_each ->
        truncate_tables Subjects, Coupons, Users

    it "create coupon", ->
        create_coupon!
        coupon = Coupons\find raw_coupon
        assert.is.truthy coupon
    

    it "get user", -> 
        create_coupon!
        create_user!

        coupon = Coupons\find raw_coupon
        user = coupon\get_user!

        assert.are.same raw_user, user

    it "get subject", ->
        create_subject!
        create_coupon!

        coupon = Coupons\find raw_coupon
        subject = coupon\get_subject!

        assert.are.same raw_subject, subject