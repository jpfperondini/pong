require "config"
require "point"
require "paddle"
require "ball"
collision = require "collision"
score = require "score"

CENTER_BALL_X = (SCREEN_WIDTH - BALL_SIZE) / 2
CENTER_BALL_Y = (SCREEN_HEIGHT - BALL_SIZE) / 2


ball = Ball:new(CENTER_BALL_X, CENTER_BALL_Y, BALL_SPEED)
paddle1 = Paddle:new(PADDLE_PADDING, PADDLE_PADDING, 'w', 's')
paddle2 = Paddle:new(SCREEN_WIDTH - PADDLE_WIDTH - PADDLE_PADDING,
    SCREEN_HEIGHT - PADDLE_HEIGHT - PADDLE_PADDING, 'up', 'down')


sounds = {}

function love.load()
    sounds.paddle = love.audio.newSource("assets/paddle.wav")
    sounds.wall = love.audio.newSource("assets/wall.wav")
    sounds.point = love.audio.newSource("assets/point.wav")
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    love.graphics.newFont(24)
end

function love.update(dt)
    -- if someone wins, don't update anything
    if score:hasWinner() then return end

    -- Checks if the a player scores
    score:check(ball.position)

    -- Handles players input
    paddle1:handleMovement(dt)
    paddle2:handleMovement(dt)

    -- Updates ball
    ball:update(dt, sounds.wall)

    -- Collision
    collision:check(ball.position, ball.speed, paddle1.position, paddle2.position, sounds.paddle)
end



function love.draw()
    drawDashedLine()

    -- Draws winner if any
    if score.paddle2Won or score.paddle1Won then
        love.graphics.print(score.paddle2Won and "PLAYER 2 WON!" or "PLAYER 1 WON",
            (SCREEN_WIDTH - 100) / 2, SCREEN_HEIGHT / 2)
        love.graphics.print("Press space to play again",
            (SCREEN_WIDTH - 156) / 2, (SCREEN_HEIGHT + 100) / 2)
    end

    ball:draw()
    paddle1:draw()
    paddle2:draw()
end

function drawDashedLine()
    local x = SCREEN_WIDTH / 2
    local y0 = 0
    local y1 = SCREEN_HEIGHT
    local size = 10
    for i = y0, y1, size do
        print(i)
        love.graphics.line(x, i, x, i + size / 2)
    end
end