Score = {
    paddle1Won = false,
    paddle2Won = false
}

function Score:hasWinner()
    if score.paddle1Won or score.paddle2Won then
        -- if space is pressed, game restart
        if love.keyboard.isDown("space") then
            score.paddle1Won = false
            score.paddle2Won = false
            ball.position:set(CENTER_BALL_X, CENTER_BALL_Y)
        end
        return true
    end
    return false
end

function Score:check(ballPos)
    if ballPos.x <= -PADDLE_WIDTH then
        love.audio.play(sounds.point)
        score.paddle2Won = true
    elseif ballPos.x >= SCREEN_WIDTH then
        love.audio.play(sounds.point)
        score.paddle1Won = true
    end
end


return Score