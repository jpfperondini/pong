Ball = {}

function Ball:new(x, y, speed)
    local newObj = {}

    newObj.position = Point:new(x, y)

    newObj.speed = Point:new(speed, speed)

    self.__index = self
    return setmetatable(newObj, self)
end

function Ball:update(dt, sound)
    handleOutOfBounds(ball.position, ball.speed, sound)

    self.position.x = self.position.x + (self.speed.x * dt)
    self.position.y = self.position.y + (self.speed.y * dt)
end

function Ball:draw()
    love.graphics.rectangle("fill", self.position.x, self.position.y, BALL_SIZE, BALL_SIZE)
end

function handleOutOfBounds(ballPos, ballSpeed, sound)
    if ballPos.y <= 0 or ballPos.y >= SCREEN_HEIGHT - BALL_SIZE then
        love.audio.play(sound)
        ballSpeed.y = -ballSpeed.y
    end
end

return Ball