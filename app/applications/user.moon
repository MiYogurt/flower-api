lapis = require "lapis"
omit = require "utils.omit"
i = require "inspect"

import
    respond_to
    capture_errors
    json_params
    from require "lapis.application"

import assert_valid from require "lapis.validate"

import Users from require "models"

import json_capture_erros, post from require "helpers.app"

class UserApplication extends lapis.Application

    [sign_up: "/sign_up"]: post json_capture_erros => 
        assert_valid @params, {
            { "username", exists: true, min_length: 2, max_length: 25 }
            { "email", exists: true, min_length: 2, max_length: 25 }
            { "password", exists: true, min_length: 2 }
            { "password_repeat", equals: @params.password }
            { "phone", exists: true, min_length: 11 }
        }

        user = Users\create omit @params, {"password_repeat"}

        {
            json: user
        }