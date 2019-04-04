uuid = require "uuid"
import Users, 
    Coupons, 
    Goods,
    GoodsComments, 
    Orders, 
    Categorys,
    Subjects,
    ShopCarts  from require "models"

import format_date from require "lapis.db"

raw_user = {
    id: 1
    username: "yugo"
    password: "1234"
    email: "test@noop.net"
    phone: "119"
}

raw_coupon = {
    id: 1
    price: 180
    user_id: raw_user.id
    subject_id: 1
    end_time: "2019-05-03"
    rule: ">1000"
    used: false
}

raw_order = {
    user_id: raw_user.id
    uid: uuid!
    type: "紫色"
    goods_id: 1 -- 必须制定，默认值为 0 会导致失败
    status: "paying"
    created_at: format_date!
}

raw_shop_cart = {
    id: 1
    goods_id: 1
    user_id: 1
    num: 1
    type: "一号包装"
    created_at: format_date!
    updated_at: format_date!
}

raw_category = {
    id: 1
    name: "爱情"
}

raw_subject= {
    id: 1
    title: "温馨花"
    src: ""
    content: ""
    up: 1,
    view: 1
}

raw_goods = {
    id: 1
    title: "茉莉花"
    desc: "hello"
    category_id: 1
    type: "白色"
    content: "如何如何的值得购买"
    price: 99
    src: ""
}

create_user = () ->
    Users\create raw_user

create_coupon = () ->
    Coupons\create raw_coupon

create_order = () ->
    Orders\create raw_order

create_shop_cart = () ->
    ShopCarts\create raw_shop_cart

create_subject = () ->
    Subjects\create raw_subject

create_category = () ->
    Categorys\create raw_category

create_goods = () ->
    Goods\create raw_goods

{
    :raw_coupon
    :raw_order
    :raw_user
    :raw_shop_cart
    :raw_subject
    :raw_category
    :raw_goods

    :create_coupon
    :create_order
    :create_user
    :create_shop_cart
    :create_subject
    :create_category
    :create_goods
}