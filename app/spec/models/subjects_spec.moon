import use_test_env from require "lapis.spec"
import truncate_tables from require "lapis.spec.db"
import Subjects, Coupons, Categorys from require "models"

import
    raw_subject,
    create_subject,
    raw_category,
    create_category,
    raw_coupon,
    create_coupon
    from require "spec.models.factory"

describe "Subject Test #models #models_subjets", ->

    use_test_env!

    before_each ->
        truncate_tables Subjects, Coupons, Categorys

    
    it "create subject", ->
        create_subject!
        subject = Subjects\find raw_subject
        assert.is.truthy subject

    it "get coupon", -> 
        create_coupon!
        create_subject!
        subject = Subjects\find raw_subject
        coupons = subject\get_coupons!
        assert.are.equal 1, #coupons

    it "get coupon by reload", -> 
        create_subject!
        create_coupon!
        
        subject = Subjects\find raw_subject
        Subjects\preload_relations {subject}, "coupons"
        assert.are.same raw_coupon, subject['coupons'][1]
