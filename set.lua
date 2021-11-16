local set = {}

setmetatable(set, {
    __call = function(_, ...)
        return set.new(...)
    end
})

local mt = {
    __add = function(s1, s2)
        return s1:union(s2)
    end,
    __sub = function(s1, s2)
        return s1:difference(s2)
    end,
    __mul = function(s1, s2)
        return s1:intersection(s2)
    end,
    __eq = function(s1, s2)
        return s1:equals(s2)
    end,
    __lt = function(s1, s2)
        return s1:isProperSubset(s2)
    end,
    __le = function(s1, s2)
        return s1:isSubset(s2)
    end,
    __tostring = function(s)
        return s:tostring()
    end,
    __index = set
}

function set.new(...)
    local res = {}
    for _, v in next, {...} do
        res[v] = true
    end
    return setmetatable(res, mt)
end

function set.fromList(t)
    return set.new((unpack or table.unpack)(t))
end

function set.toList(s)
    local res = {}
    for k in next, s do
        res[#res + 1] = k
    end
    return res
end

function set.tostring(s)
    return "{" .. table.concat(s:toList(), ", ") .. "}"
end

function set.clone(s)
    local res = {}
    for k in next, s do
        res[k] = true
    end
    return setmetatable(res, mt)
end

function set.union(s1, s2)
    local res = {}
    for k in next, s1 do
        res[k] = true
    end
    for k in next, s2 do
        res[k] = true
    end
    return setmetatable(res, mt)
end

function set.intersection(s1, s2)
    local res = {}
    for k in next, s1 do
        if s2[k] then
            res[k] = true
        end
    end
    return setmetatable(res, mt)
end

function set.difference(s1, s2)
    local res = {}
    for k in next, s1 do
        if not s2[k] then
            res[k] = true
        end
    end
    return setmetatable(res, mt)
end

function set.isSubset(s1, s2)
    for k in next, s1 do
        if not s2[k] then
            return false
        end
    end
    return true
end

function set.equals(s1, s2)
    return s1:isSubset(s2) and s2:isSubset(s1)
end

function set.isProperSubset(s1, s2)
    return s1:isSubset(s2) and not s2:isSubset(s1)
end

function set.contains(s, e)
    return not not s[e]
end

function set.isEmpty(s)
    return next(s) == nil
end

function set.size(s)
    local count = 0
    for _ in next, s do
        count = count + 1
    end
    return count
end

function set.insert(s, e)
    s[e] = true
    return e
end

function set.remove(s, e)
    s[e] = nil
    return e
end

function set.iterate(s)
    local e = nil
    return function()
        local res = (next(s, e))
        e = res
        return res
    end
end

return set
