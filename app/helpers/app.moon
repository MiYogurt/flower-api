import
    respond_to
    capture_errors
    json_params
    yield_error
    from require "lapis.application"

import
    get_user
    from require "utils.jwt"

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

extract_token = (fn) -> 
    json_capture_erros =>
        token = @req.headers["x-access-token"]
        if token == nil
            yield_error "not found x-access-token"
        user, err = get_user token
        if err != nil
            yield_error err
        @user = user
        fn @
    


{
    :post_method
    :json_capture_erros
    :delete_method
    :put_method

    :extract_token
}