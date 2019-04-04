
in_array = (array, value) ->
    for i, v in pairs array
        if v == value
            return true
    return false

return in_array