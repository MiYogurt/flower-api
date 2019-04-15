lapis = require "lapis"
omit = require "utils.omit"
i = require "inspect"

import to_string, get_user from require "utils.jwt"

import
    respond_to
    capture_errors
    json_params
    yield_error
    from require "lapis.application"

import assert_valid from require "lapis.validate"

import Goods, Categorys, GoodsComments, Subjects, Coupons from require "models"

import json_capture_erros, post_method, extract_token from require "helpers.app"

class SubjectsApplication extends lapis.Application

    -- 专题列表
    [list: "/subjects"]: json_params json_capture_erros =>
        paged = Subjects\paginated per_page: @params.per_page or 10
        ret = paged\get_page @params.page or 1

        {
            json: {
                data: ret,
                all: paged\num_pages!
                current: @params['page'] or 1
                per: @params['per_page'] or 10
                
            }
        }
    
    -- 专题
    [byId: "/subject/:id"]: json_params json_capture_erros =>
        subject = Subjects\find @params.id
        coupons = Coupons\select [[ where subject_id = ? and user_id = 0 ]], @params.id

        {
            json: {
                subject: subject,
                has_coupon: #coupons > 0
            }
        }

    -- 领取优惠券
    [get_coupon: "/coupons/:subject_id"]: extract_token =>
        coupons = Coupons\select [[ where subject_id = ? and user_id = 0 ]], @params.subject_id
        if #coupons > 0
            coupons[1].user_id = @user.id
            coupons[1]\update "user_id"

            {
                json: coupons[1]
            }        
        else 
            yield_error "没有优惠券了" 