in_array = require "utils.in_array"

-- { a: 1, b: 2 }, { a } -> { a: 1 }
pick = (source, pick) ->
    {k,v for k,v in pairs source when in_array(pick, k)}

return pick