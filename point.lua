Point = {}

function Point:new(x, y)
    local newObj = {
        x = x,
        y = y
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Point:set(x, y)
    self.x = x
    self.y = y
end

return Point