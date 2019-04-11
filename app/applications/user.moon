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

import Users from require "models"

import json_capture_erros, post_method, extract_token from require "helpers.app"

class UserApplication extends lapis.Application

    [sign_up: "/sign_up"]: post_method json_capture_erros => 
        assert_valid @params, {
            { "username", exists: true, min_length: 2, max_length: 25 }
            { "email", exists: true, min_length: 2, max_length: 25 }
            { "password", exists: true, min_length: 2 }
            { "password_repeat", equals: @params.password }
            { "phone", exists: true, min_length: 11 }
        }

        user = Users\create omit @params, {"password_repeat"}
        
        {
            json: {
                token: to_string user
            }
        }

    [sign_in: "/sign_in"]: post_method json_capture_erros => 
        assert_valid @params, {
            { "email", exists: true, min_length: 2, max_length: 25 }
            { "password", exists: true, min_length: 2 }
        }

        user = Users\find @params
        
        if user != nill
            {
                json: {
                    token: to_string user
                }
            }

        else 
            yield_error "user not found"

    [user_info: "/user_info"]: extract_token =>
        user = Users\find @user.id

        {
            json: omit user, {'password'}
        }
