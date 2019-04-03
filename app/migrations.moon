import create_table, types, add_column from require "lapis.db.schema"

import serial, varchar , text, date, time, integer, double, boolean from types

{
  ["2019年04月02日17:50:02"]: =>
    create_table "users", {
      { "id", serial }
      { "username", varchar }
      { "email", varchar }
      { "password",  varchar }

      "PRIMARY KEY (id)"
    }

  ["2019年04月02日17:52:30"]: =>
    add_column "users", "phone", "character varying(11)"

  ["2019年04月03日15:37:38"]: =>

    -- 购物车
    create_table "shop_carts", {
      { "id", varchar }
      { "flower_id", serial  }
      { "user_id", serial }
      "PRIMARY KEY (id)"
    }

    -- 分类
    create_table "categorys", {
      { "id", varchar }
      { "name", varchar  }

      "PRIMARY KEY (id)"
    }

    create_table "flowers", {
      { "id", serial }
      { "title", varchar } -- 标题
      { "desc", varchar } -- 简介
      { "category_id", serial } -- 分类
      { "type", varchar } -- 型号
      { "content", text } -- 内容
      { "price", double } -- 价格
      { "src", text } -- 图片

      "PRIMARY KEY (id)"
    }

    -- 活动专题
    create_table "subjects", {
      { "id", serial }
      { "title", varchar }
      { "src", varchar }
      { "content", text }
      { "up", serial }
      { "view", serial }

      "PRIMARY KEY (id)"
    }

    -- 优惠券
    create_table "coupons", {
      { "id", serial }
      { "price", integer } -- 价格
      { "user_id", serial null: true }
      { "subject", serial null: true }
      { "rule", varchar } -- 使用规则
      { "end_time", date } -- 截止日
      { "used", boolean default: false } -- 是否使用
      "PRIMARY KEY (id)"
    }

    create_table "orders", {
      { "uid", serial } -- 订单编码
      { "flower_id", serial }
      { "user_id", serial }
      { "type", varchar } -- 分类
      { "status", varchar }
      { "created_at", time }

      "PRIMARY KEY (uid)"
    }

    create_table "flower_comments", {
      { "id", serial }
      { "flower_id", serial }
      { "order_id", serial }
      { "user_id", serial }
      { "content", text } -- 评论内容
      { "level", serial } -- 好评等级
      "PRIMARY KEY (id)"
    }




} 