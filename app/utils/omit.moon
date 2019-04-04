in_array = require "utils.in_array"

-- { a: 1, b: 2 }, { a } -> { b: 2 }
omit = (source, omit) ->
    {k,v for k,v in pairs source when not in_array(omit, k)}

return omit