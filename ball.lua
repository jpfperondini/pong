Ball = {}

function Ball:new(x, y, speed)
    local newObj = {}

    newObj.position = Point:new(x, y)

    newObj.speed = Point:new(speed, speed)

    self.__index = self
    return setmetatable(newObj, self)
end

function Ball:update(dt)
    handleOutOfBounds(ball.position, ball.speed)

    self.position.x = self.position.x + (self.speed.x * dt)
    self.position.y = self.position.y + (self.speed.y * dt)
end

function Ball:draw()
    love.graphics.rectangle("fill", self.position.x, self.position.y, BALL_SIZE, BALL_SIZE)
end

function handleOutOfBounds(ballPos, ballSpeed)
    if ballPos.y <= 0 or ballPos.y >= SCREEN_HEIGHT - BALL_SIZE then
        ballSpeed.y = -ballSpeed.y
    end
end

return Ball