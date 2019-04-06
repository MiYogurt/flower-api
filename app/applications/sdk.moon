lapis = require "lapis"
omit = require "utils.omit"
i = require "inspect"
db = require "lapis.db"

import
    respond_to
    capture_errors
    json_params
    from require "lapis.application"

import assert_valid from require "lapis.validate"

models = require "models"

import json_capture_erros, 
    post_method,
    delete_method,
    put_method
    from require "helpers.app"
import preload from require "lapis.db.model"

query = (name, limit, where, page, preload) =>
    limit or= 10
    page or= 1
    preload or= {}
    model = models[name]
    paged = model\paginated where, per_page: limit

    if #preload > 0
        preload data preload
    {
        json: 
            count: paged\total_items!
            all: paged\num_pages!
            limit: limit
            page: page
            data: paged\get_page page
    }

create = (name) =>
    model = models[name]
    {
        json: model\create omit @params, {"name"}
    }

update = (name, id) =>
    model = models[name]
    data = model\find id
    if data
        data\update omit @params, {"name", "id"}
        {
            json: data
        }

delete = (name, id) =>
    model = models[name]
    data = model\find id
    if data
        {
            json: data\delete!
        }

table_info = (name) =>
    model = models[name]
    if model
        {
            json: model\columns!
        }

class SDKApplication extends lapis.Application
    [table_info: "/:name/info"]: =>
        print @params.name
        table_info(@, @params.name)

    [query: "/:name/query"]: post_method =>
        query(@, @params.name, @params.limit, @params.where, @params.offset, @params.preload)
    
    [create: "/:name"]: post_method =>
        create @, @params.name

    [model: "/:name/:id"]: json_params respond_to {
        DELETE: =>
            delete(@, @params.name, @params.id)
        PUT: =>
            update(@, @params.name, @params.id)

    }
