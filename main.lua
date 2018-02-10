require "config"
require "point"
require "paddle"
require "ball"
collision = require "collision"

CENTER_BALL_X = (SCREEN_WIDTH - BALL_SIZE) / 2
CENTER_BALL_Y = (SCREEN_HEIGHT - BALL_SIZE) / 2


ball = Ball:new(CENTER_BALL_X, CENTER_BALL_Y, BALL_SPEED)
paddle1 = Paddle:new(PADDLE_PADDING, PADDLE_PADDING, 'w', 's')
paddle2 = Paddle:new(SCREEN_WIDTH - PADDLE_WIDTH - PADDLE_PADDING,
    SCREEN_HEIGHT - PADDLE_HEIGHT - PADDLE_PADDING, 'up', 'down')

winner = {
    paddle1Won = false,
    paddle2Won = false
}

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    love.graphics.newFont(24)
end

function love.update(dt)
    -- if someone wins, don't update anything
    if winner.paddle1Won or winner.paddle2Won then
        -- if space is pressed, game restart
        if love.keyboard.isDown("space") then
            winner.paddle1Won = false
            winner.paddle2Won = false
            ball.position:set(CENTER_BALL_X, CENTER_BALL_Y)
        end
        return
    end

    -- Checks if the a player scores
    checkScore(ball.position)

    -- Handles players input
    paddle1:handleMovement(dt)
    paddle2:handleMovement(dt)

    -- Updates ball
    ball:update(dt)

    -- Collision
    collision:check(ball.position, ball.speed, paddle1.position, paddle2.position)
end

function checkScore(ballPos)
    if ballPos.x <= -PADDLE_WIDTH then
        winner.paddle2Won = true
    elseif ballPos.x >= SCREEN_WIDTH then
        winner.paddle1Won = true
    end
end



function love.draw()
    -- Draws winner if any
    if winner.paddle2Won or winner.paddle1Won then
        love.graphics.print(winner.paddle2Won and "PLAYER 2 WON!" or "PLAYER 1 WON",
            (SCREEN_WIDTH - 100) / 2, SCREEN_HEIGHT / 2)
        love.graphics.print("Press space to play again",
            (SCREEN_WIDTH - 156) / 2, (SCREEN_HEIGHT + 100) / 2)
    end

    ball:draw()
    paddle1:draw()
    paddle2:draw()
end