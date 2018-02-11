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
    love.graphics.rectangle("line", self.position.x, self.position.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end

function Paddle:handleMovement(dt)
    if love.keyboard.isDown(self.controls.down) and self.position.y + PADDLE_HEIGHT + 5 < SCREEN_HEIGHT then
        self.position.y = self.position.y + (PADDLE_SPEED * dt)
    elseif love.keyboard.isDown(self.controls.up) and self.position.y >= 5 then
        self.position.y = self.position.y - (PADDLE_SPEED * dt)
    end
end

return Paddle

