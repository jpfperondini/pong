Collision = {}

function Collision:check(ballPos, ballSpeed, paddle1Pos, paddle2Pos, sound)
    if ballPos.x <= (paddle1Pos.x + PADDLE_WIDTH) and
            ballPos.y >= paddle1Pos.y and
            ballPos.y <= (paddle1Pos.y + PADDLE_HEIGHT - BALL_SIZE) and
            ballSpeed.x < 0 then
        love.audio.play(sound)
        ballSpeed.x = -ballSpeed.x
    elseif ballPos.x >= (paddle2Pos.x - PADDLE_WIDTH) and
            ballPos.y >= paddle2Pos.y and
            ballPos.y <= (paddle2Pos.y + PADDLE_HEIGHT - BALL_SIZE) and
            ballSpeed.x > 0 then
        love.audio.play(sound)
        ballSpeed.x = -ballSpeed.x
    end
end

return Collision