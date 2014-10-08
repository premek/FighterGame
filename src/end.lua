endlib = {}

-------------------------------------
-- endlib.load
-------------------------------------
function endlib.load (arg)
  endlib.time_dt = 0
  endlib.alpha = 0
end

-------------------------------------
-- endlib.update
-------------------------------------
function endlib.update (dt)
  if state == "end" then
    endlib.time_dt = endlib.time_dt + dt
    endlib.alpha = endlib.alpha + dt*255
    if endlib.alpha > 255 then
      endlib.alpha = 255
    end
  end  
end

-------------------------------------
-- endlib.draw
-------------------------------------
function endlib.draw ()
  if state == "end" then
    love.graphics.setFont(assets.font_large)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,800,600)
    love.graphics.setColor(255,0,0,endlib.alpha)

      -- love.graphics.draw(assets.soniam,400-assets.soniam:getWidth()/2,600-assets.soniam:getHeight())
      if endlib.time_dt > 1 then
        love.graphics.printf("YOU LOSE",0,50,800,"center")
      end
  end  
end

-------------------------------------
-- endlib.keypressed
-------------------------------------
function endlib.keypressed (key,unicode)
  if state == "end" then
    if endlib.time_dt > 3 then
      state = "intro"
      love.audio.stop()
      love.audio.play(music_intro)
      end_state_temp = true
      gamelib.load()
      introlib.load()
      endlib.load()
    end
  end  
end


function endlib.playmusic()
  love.audio.stop()
  -- love.audio.play(music_end)
end
-------------------------------------
-- endlib.keyreleased
-------------------------------------
function endlib.keyreleased (key)
  if state == "end" then
    
  end  
end

-------------------------------------
-- endlib.mousepressed
-------------------------------------
function endlib.mousepressed (x,y,button)
  if state == "end" then
    
  end  
end

-------------------------------------
-- endlib.mousereleased
-------------------------------------
function endlib.mousereleased (x,y,button)
  if state == "end" then
    
  end  
end

-------------------------------------
-- endlib.joystickpressed
-------------------------------------
function endlib.joystickpressed (joystick,button)
  if state == "end" then
    
  end  
end

-------------------------------------
-- endlib.joystickreleased
-------------------------------------
function endlib.joystickreleased (joystick,button)
  if state == "end" then
    
  end  
end

-------------------------------------
-- endlib.focus
-------------------------------------
function endlib.focus (f)
  if state == "end" then
    
  end  
end

-------------------------------------
-- endlib.quit
-------------------------------------
function endlib.quit ()
  if state == "end" then
    
  end  
end

