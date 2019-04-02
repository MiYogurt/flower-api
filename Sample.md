
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