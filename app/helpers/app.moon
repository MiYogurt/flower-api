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

post = (fn) -> 
    json_params respond_to {
        POST: fn
    }

{
    :post
    :json_capture_erros
}