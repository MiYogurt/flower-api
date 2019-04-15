lapis = require "lapis"
omit = require "utils.omit"
i = require "inspect"
bcrypt = require "bcrypt"

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

import pre_user, password_salt, bcrypt_rounds, check_pwd from require "utils.pre_user"


class UserApplication extends lapis.Application
    -- 注册
    [sign_up: "/sign_up"]: post_method json_capture_erros => 
        assert_valid @params, {
            { "username", exists: true, min_length: 2, max_length: 25 }
            { "email", exists: true, min_length: 2, max_length: 25 }
            { "password", exists: true, min_length: 6 }
            { "password_repeat", equals: @params.password }
            { "phone", exists: true, min_length: 11 }
        }

        pre_user @params

        user = Users\create omit @params, {"password_repeat"}
        
        {
            json: {
                token: to_string user
            }
        }
    -- 登陆
    [sign_in: "/sign_in"]: post_method json_capture_erros => 
        assert_valid @params, {
            { "email", exists: true, min_length: 2, max_length: 25 }
            { "password", exists: true, min_length: 2 }
        }

        user = Users\find { email: @params.email }
        
        if user != nill and check_pwd @params['password'], user['password']
            {
                json: {
                    token: to_string user
                }
            }

        else 
            yield_error "user not found"

    -- 用户信息
    [user_info: "/user_info"]: extract_token =>
        user = Users\find @user.id

        {
            json: omit user, {'password'}
        }

    -- 修改密码
    [change_password: "/change_pwd/:email"]: extract_token json_capture_erros =>
        assert_valid @params, {
            { "old_password", exists: true, min_length: 6, max_length: 25 }
            { "password", exists: true, min_length: 6, max_length: 25 }
            { "password_repeat", equals: @params.password }
        }

        user = Users\find { email: @params.email }

        if user == nil
            yield_error "not found"

        if not check_pwd @params['old_password'], user['password']
            yield_error "password not match"

        user\update {
            password: @params['password']
        }

        {
            json: "success"
        }