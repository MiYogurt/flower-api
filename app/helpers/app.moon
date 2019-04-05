import
    respond_to
    capture_errors
    json_params
    from require "lapis.application"

json_capture_erros = (fn) ->
    capture_errors {
        on_error: =>
            { json: @errors }
        fn
    }

post_method = (fn) -> 
    json_params respond_to {
        POST: fn
    }

delete_method = (fn) -> 
    json_params respond_to {
        DELETE: fn
    }
    
put_method = (fn) -> 
    json_params respond_to {
        PUT: fn
    }



{
    :post_method
    :json_capture_erros
    :delete_method
    :put_method
}