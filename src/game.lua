require "class"
gamelib = {}




Player = class:new()
    Player.x = 100 -- TODO position is relative to screen, not world
    Player.y = 0
    Player.jump = false
    Player.jump_dt = 0
    Player.jump_speed = 1.5
    Player.life = 90
    Player.controls = {
      right = "right",
      left = "left",
      jump = "up"
    }

--Player.value = 13
--function Player:setvalue(v)
--    Player.value = v
--end



function dist(o1, o2)
  return math.sqrt( (o1.x - o2.x)^2 +(o1.y - o2.y)^2) 
end


-------------------------------------
-- gamelib.load
-------------------------------------
function gamelib.load (arg)

  gamelib.distance = 0
  gamelib.dt_time = 0
  gamelib.debug = true 


gamelib.players = {Player:new(), Player:new()}
gamelib.players[2].x = 500
gamelib.players[2].controls  = {
      right = "d",
      left = "a",
      jump = "w"
    }

end

-------------------------------------
-- gamelib.update
-------------------------------------
function gamelib.update (dt)
  if state == "game" then

    gamelib.dt_time = gamelib.dt_time + dt

    for i,p in ipairs(gamelib.players) do
      if p.life < 10 then
        state = "end"
        endlib.playmusic()
      end

    
	    if p.jump then
		p.jump_dt = p.jump_dt + dt*math.pi*p.jump_speed
		if p.jump_dt > math.pi then
		  p.jump_dt = 0
		  p.jump = false
		end
	    end



	    if love.keyboard.isDown(p.controls.left) then
	      p.x = p.x - 400*dt
	      if p.x < 50 then
		p.x = 50
		gamelib.distance = gamelib.distance - 500*dt
	      end
	    elseif love.keyboard.isDown(p.controls.right) then
	      p.x = p.x + 400*dt
	      if p.x > 550 then -- rborder
		p.x = 550
		gamelib.distance = gamelib.distance + 500*dt
	      end
	    end

	  p.y = 500-math.sin(p.jump_dt)*250
	  --if gamelib.player.life < 0  then
	  --  state = "end"
	  --  endlib.playmusic()
	  --end
	  end
    end
end

-------------------------------------
-- gamelib.draw
-------------------------------------
function gamelib.draw ()
  if state == "game" then
    love.graphics.setColor(assets.bgcolor.r,assets.bgcolor.g,assets.bgcolor.b)
    love.graphics.rectangle("fill",0,0,800,600)
    love.graphics.setColor(255,255,255)

    love.graphics.draw(assets.city,-gamelib.distance%800,(300-assets.city:getHeight()*800/assets.city:getWidth()),0,800/assets.city:getWidth())
    love.graphics.draw(assets.city,-gamelib.distance%800-800,(300-assets.city:getHeight()*800/assets.city:getWidth()),0,800/assets.city:getWidth())
    love.graphics.setColor(assets.barcolor.r,assets.barcolor.g,assets.barcolor.b)
    love.graphics.rectangle("fill",0,300,800,600)

    local temp_sprite = 1

    for i,p in ipairs(gamelib.players) do

    love.graphics.setColor(255,255,255)
    love.graphics.draw(assets.puddi[temp_sprite],
        p.x-77,
        p.y-77,
        0,
        .5,
        .5,
        0,
        61)

    love.graphics.printf(p.life,32+(i-1)*670,20, 10,"left")

    end

    if gamelib.debug then

      for i,p in ipairs(gamelib.players) do
        love.graphics.circle("line", p.x, p.y, 3,8)
      end

      love.graphics.print(""
          .."\nDistance:"..math.floor(gamelib.distance)
          .."\nplx,ply:"..gamelib.players[1].x..","..gamelib.players[1].y
          .."\n",0,0)
    end
  end  
end

-------------------------------------
-- gamelib.keypressed
-------------------------------------
function gamelib.keypressed (key,unicode)
  if state == "game" then

    for i,p in ipairs(gamelib.players) do

	    if love.keyboard.isDown(p.controls.jump) and not p.jump then
	      p.jump = true
	      p.jump_dt = 0
	    end
    end

    if key == "`" then
      gamelib.debug = not gamelib.debug 
    end

  end  
end

-------------------------------------
-- gamelib.keyreleased
-------------------------------------
function gamelib.keyreleased (key)
  if state == "game" then
    
  end  
end

-------------------------------------
-- gamelib.mousepressed
-------------------------------------
function gamelib.mousepressed (x,y,button)
  if state == "game" then
    
  end  
end

-------------------------------------
-- gamelib.mousereleased
-------------------------------------
function gamelib.mousereleased (x,y,button)
  if state == "game" then
    
  end  
end

-------------------------------------
-- gamelib.joystickpressed
-------------------------------------
function gamelib.joystickpressed (joystick,button)
  if state == "game" then
    
  end  
end

-------------------------------------
-- gamelib.joystickreleased
-------------------------------------
function gamelib.joystickreleased (joystick,button)
  if state == "game" then
    
  end  
end

-------------------------------------
-- gamelib.focus
-------------------------------------
function gamelib.focus (f)
  if state == "game" then
    
  end  
end

-------------------------------------
-- gamelib.quit
-------------------------------------
function gamelib.quit ()
  if state == "game" then
    
  end  
end
