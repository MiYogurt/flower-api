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

import Goods, Categorys, GoodsComments from require "models"

import json_capture_erros, post_method from require "helpers.app"

class GoodsApplication extends lapis.Application

    --详情查询接口
    [byId: "/goods/:id"]: json_capture_erros => 

        good = Goods\find @params.id
        if good == nil
            yield_error "not found"
        GoodsComments\include_in {good}, "goods_id", as: "comments", flip: true, many: true
        GoodsComments\preload_relation good['comments'], "user"

        {
            json: good
        }
    
    -- 所有分类
    [categorys: "/categorys"]: json_capture_erros => 
        {
            json: Categorys\select!
        }
    
    -- 分类查询接口
    [by_category: "/category/:id"]: post_method json_params json_capture_erros => 
        paged = Goods\paginated [[where category_id = ?]], @params.id, per_page: @params['per_page'] or 10
        ret = nil
        if @params.page != nil
            ret = paged\get_page @params.page
        else
            ret = paged\get_all!

        {
            json: {
                data: ret,
                all: paged\num_pages!
                current: @params['page'] or 1
                per: @params['per_page'] or 10
            }
        }    

