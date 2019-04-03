
```
docker network create api
docker network connect api api
docker run --name pg_db -p 5432:5432 -d postgres
docker network connect api pg_db
```

```
resolver 127.0.0.11;
```

```
docker network inspect api
```

```
{
    "files.exclude": {
        "**/*_temp": true,
        "app/*.lua": true,
        "app/logs": true,
        "app/mime.types": true,
        "app/nginx.conf*": true
    }
}
```

```
import config from require "lapis.config"
config "development", ->
  postgres ->
    host "pg_db"
    user "postgres"
    password ""
    database "db"
```

```
lapis = require "lapis"
import Model from require "lapis.db.model"

class User extends Model
```

```
  "/user": =>
    user = models.User\find 1
    {
      json: user
    }
```


```
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
      { "id", serial }
      { "goods_id", serial  }
      { "user_id", serial }
      { "type", varchar } -- 型号
      { "num", integer } -- 数量
      {"created_at", time }
      {"updated_at", time }
      
      "PRIMARY KEY (id)"
    }

    -- 分类
    create_table "categorys", {
      { "id", serial }
      { "name", varchar  }

      "PRIMARY KEY (id)"
    }

    create_table "goods", {
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
      { "subject_id", serial null: true }
      { "rule", varchar } -- 使用规则
      { "end_time", date } -- 截止日
      { "used", boolean default: false } -- 是否使用
      "PRIMARY KEY (id)"
    }

    create_table "orders", {
      { "uid", serial } -- 订单编码
      { "goods_id", serial }
      { "user_id", serial }
      { "type", varchar } -- 分类
      { "status", varchar }
      { "created_at", time }

      "PRIMARY KEY (uid)"
    }

    create_table "goods_comments", {
      { "id", serial }
      { "goods_id", serial }
      { "order_id", serial }
      { "user_id", serial }
      { "content", text } -- 评论内容
      { "level", serial } -- 好评等级
      "PRIMARY KEY (id)"
    }
} 
```



```
luarocks install busted
```

```
config "test", ->
    postgres ->
        host "pg_db"
        user "postgres"
        password ""
        database "test_db"
```

```
lapis migrate test
```

```
luarocks install uuid
```