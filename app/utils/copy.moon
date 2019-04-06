
copy = (source, target) ->
    target or= {}
    
    for k,v in pairs source
        target[k] = v
    
    return target

return copy