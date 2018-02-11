Score = {
    isFinished = false,
    player1 = 0,
    player2 = 0,
    paddle1Won = false,
    paddle2Won = false
}

function Score:hasWinner()
    if score.isFinished and (score.paddle1Won or score.paddle2Won) then
        -- if space is pressed, game restart
        if love.keyboard.isDown("space") then
            score.paddle1Won = false
            score.paddle2Won = false
            score.isFinished = false
            score.player1 = 0
            score.player2 = 0
            ball.position:set(CENTER_BALL_X, CENTER_BALL_Y)
        end
        return true
    elseif score.isFinished then
        score.isFinished = false
        ball.position:set(CENTER_BALL_X, CENTER_BALL_Y)
    end
    return false
end

function Score:check(ballPos)
    if ballPos.x <= -PADDLE_WIDTH then
        love.audio.play(sounds.point)
        self.player2 = self.player2 + 1
        score.isFinished = true
    elseif ballPos.x >= SCREEN_WIDTH then
        love.audio.play(sounds.point)
        self.player1 = self.player1 + 1
        score.isFinished = true
    end

    if score.player1 == 5 then
        score.isFinished = true
        score.paddle1Won = true
        score.paddle2Won = false
    elseif score.player2 == 5 then
        score.isFinished = true
        score.paddle1Won = false
        score.paddle2Won = true
    end
end


return Score