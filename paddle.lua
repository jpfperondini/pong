Paddle = {}

function Paddle:new(x, y, up, down)
    local newObj = {
        position = Point:new(x, y),
        controls = {
            up = up,
            down = down
        }
    }

    self.__index = self
    return setmetatable(newObj, self)
end


function Paddle:draw()
    love.graphics.rectangle("fill", self.position.x, self.position.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end

function Paddle:handleMovement(dt)
    if love.keyboard.isDown(self.controls.down) then
        self.position.y = self.position.y + (PADDLE_SPEED * dt)
    elseif love.keyboard.isDown(self.controls.up) then
        self.position.y = self.position.y - (PADDLE_SPEED * dt)
    end
end

return Paddle

