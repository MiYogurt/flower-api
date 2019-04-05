lapis = require "lapis"
omit = require "utils.omit"
i = require "inspect"

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

query = (name, limit, where, offset, preload) =>
    limit or= 10
    offset or= 1
    preload or= {}
    model = models[name]
    data = model\find where db.raw "limit "..limit.." offset "..offset
    if #preload > 0
        preload data preload
    {
        json: data
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
        {
            json: data\update omit @params, {"name", "id"}
        }

delete = (name, id) =>
    model = models[name]
    data = model\find id
    if data
        {
            json: data\delete!
        }

table_info = (name) =>
    {
        json: models[name]\columns!
    }

class SKDApplication extends lapis.Application
    [table_info: "/:name/info"]: =>
        table_info(@params.name)
    [query: "/:name/query"]: =>
        query(@params.name, @params.limit, @params.where, @params.offset, @params.preload)
    
    [delete: "/:name/:id"]: respond_to {
        DELETE: =>
            delete(@params.name, @params.id)
        PUT: =>
            update(@params.name, @params.id)

    }
