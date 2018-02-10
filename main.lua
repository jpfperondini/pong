SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

BALL_SIZE = 20
BALL_SPEED = 200

PADDLE_WIDTH = 20
PADDLE_HEIGHT = 80
PADDLE_PADDING = 20
PADDLE_SPEED = 400

winner = {
    paddle1Won = false,
    paddle2Won = false
}


ballPos = {
    x = (SCREEN_WIDTH - BALL_SIZE) / 2,
    y = (SCREEN_HEIGHT - BALL_SIZE) / 2
}
ballSpeed = {
    x = -BALL_SPEED,
    y = BALL_SPEED
}

paddle1Pos = {
    x = PADDLE_PADDING,
    y = PADDLE_PADDING
}
paddle2Pos = {
    x = SCREEN_WIDTH - PADDLE_WIDTH - PADDLE_PADDING,
    y = SCREEN_HEIGHT - PADDLE_HEIGHT - PADDLE_PADDING
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
    -- if space is pressed, game restart
    if love.keyboard.isDown("space") then
        winner.paddle1Won = false
        winner.paddle2Won = false
        ballPos.x = (SCREEN_WIDTH - BALL_SIZE) / 2
        ballPos.y = (SCREEN_HEIGHT - BALL_SIZE) / 2
    end

    -- if someone wins, don't update anything
    if winner.paddle1Won or winner.paddle2Won then
        return
    end

    -- Checks if the ball goes out of bounds
    if ballPos.y <= 0 or ballPos.y >= SCREEN_HEIGHT - BALL_SIZE then
        ballSpeed.y = -ballSpeed.y
    end

    -- Checks if the a player scores
    if ballPos.x <= -PADDLE_WIDTH then
        winner.paddle2Won = true
    elseif ballPos.x >= SCREEN_WIDTH then
        winner.paddle1Won = true
    end

    -- Checks collision between ball and paddle
    if ballPos.x <= (paddle1Pos.x + PADDLE_WIDTH) and
            ballPos.y >= paddle1Pos.y and
            ballPos.y <= (paddle1Pos.y + PADDLE_HEIGHT - BALL_SIZE) then
        ballSpeed.x = -ballSpeed.x
    elseif ballPos.x >= (paddle2Pos.x - PADDLE_WIDTH) and
            ballPos.y >= paddle2Pos.y and
            ballPos.y <= (paddle2Pos.y + PADDLE_HEIGHT - BALL_SIZE) then
        ballSpeed.x = -ballSpeed.x
    end

    -- Updates ball speed
    ballPos.x = ballPos.x + (ballSpeed.x * dt)
    ballPos.y = ballPos.y + (ballSpeed.y * dt)

    -- Handles player 1 input
    if love.keyboard.isDown('s') then
        paddle1Pos.y = paddle1Pos.y + (PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('w') then
        paddle1Pos.y = paddle1Pos.y - (PADDLE_SPEED * dt)
    end

    -- Handles player 2 input
    if love.keyboard.isDown('down') then
        paddle2Pos.y = paddle2Pos.y + (PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('up') then
        paddle2Pos.y = paddle2Pos.y - (PADDLE_SPEED * dt)
    end
end

function love.draw()
    -- Draws winner if any
    if winner.paddle2Won or winner.paddle1Won then
        love.graphics.print(paddle2Won and "PLAYER 2 WON!" or "PLAYER 1 WON",
            (SCREEN_WIDTH - 100) / 2, SCREEN_HEIGHT / 2)
        love.graphics.print("Press space to play again",
            (SCREEN_WIDTH - 156) / 2, (SCREEN_HEIGHT + 100) / 2)
    end

    -- Draws ball
    love.graphics.rectangle("fill",
        ballPos.x, ballPos.y,
        BALL_SIZE, BALL_SIZE)

    -- Draws player 1
    love.graphics.rectangle("fill",
        paddle1Pos.x, paddle1Pos.y,
        PADDLE_WIDTH, PADDLE_HEIGHT)

    -- Draws player 2
    love.graphics.rectangle("fill",
        paddle2Pos.x, paddle2Pos.y,
        PADDLE_WIDTH, PADDLE_HEIGHT)
end