pick = require "utils.pick"
omit = require "utils.omit"
in_array = require "utils.in_array"

describe "omit #utils", ->

    it "in_array function", ->
        actual = in_array { "a" }, "a"
        assert.is.true actual

    it "omit function", ->
        source = {
            a: 1
            b: 2
        }

        keys = { "a" }

        actual = omit source, keys

        assert.are.same { b: 2 }, actual
    
    it "pick function", ->
        source = {
            a: 1
            b: 2
        }
        keys = { "a" }
        actual = pick source, keys
        assert.are.same { a: 1 }, actual
