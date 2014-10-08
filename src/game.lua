require "class"
require "player"
gamelib = {}



function dist(o1, o2)
  return math.sqrt( (o1.x - o2.x)^2 +(o1.y - o2.y)^2) 
end

function collision(o1, o2, offset1, offset2)
  return o1.x + offset1.x < o2.x + offset2.x + o2.w and
         o2.x + offset2.x < o1.x + offset1.x + o1.w and
         o1.y + offset1.y < o2.y + offset2.y + o2.h and
         o2.y + offset2.y < o1.y + offset1.y + o1.h
end

-------------------------------------
-- gamelib.load
-------------------------------------
function gamelib.load (arg)

  distance = 0 -- TODO ?
  debug = true 
  players = {Player:new(), Player:new()}

  players[2].x = 500
  players[2].controls  = {
      right = "d",
      left = "a",
      jump = "w"
  
  }
  players[2].pos = "right"

end

-------------------------------------
-- gamelib.update
-------------------------------------
function gamelib.update (dt)
  if state == "game" then

    for i,p in ipairs(players) do
      if p.life < 10 then
        state = "end"
        endlib.playmusic()
      end

      -- collisions
      local me = p
      for i,him in ipairs(players) do
        if not (me == him) then -- reference comparsion - do not collide with self
          
          for i,myhitbox in ipairs(me.hitboxes) do
          for i,hishitbox in ipairs(him.hitboxes) do
		  
		  if collision(myhitbox, hishitbox, me, him) then
                      if hishitbox.type == "vulnerability" and myhitbox.type == "attack" then
		      print ("HIT", him.pos);
		      him.life = him.life - 0.001
                    end
		  end
          end
          end
        end
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
		distance = distance - 500*dt
	      end
	    elseif love.keyboard.isDown(p.controls.right) then
	      p.x = p.x + 400*dt
	      if p.x > 550 then -- rborder
		p.x = 550
		distance = distance + 500*dt
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

    love.graphics.draw(assets.city,-distance%800,(300-assets.city:getHeight()*800/assets.city:getWidth()),0,800/assets.city:getWidth())
    love.graphics.draw(assets.city,-distance%800-800,(300-assets.city:getHeight()*800/assets.city:getWidth()),0,800/assets.city:getWidth())
    love.graphics.setColor(assets.barcolor.r,assets.barcolor.g,assets.barcolor.b)
    love.graphics.rectangle("fill",0,300,800,600)

    for i,p in ipairs(players) do
       p:draw()

    end

    if debug then
      love.graphics.print("\n"
          .."\nDistance:"..math.floor(distance)
          .."\nplx,ply:"..players[1].x..","..players[1].y
          .."\n",0,0)
    end
  end  
end

-------------------------------------
-- gamelib.keypressed
-------------------------------------
function gamelib.keypressed (key,unicode)
  if state == "game" then

    for i,p in ipairs(players) do

	    if love.keyboard.isDown(p.controls.jump) and not p.jump then
	      p.jump = true
	      p.jump_dt = 0
	    end
    end

    if key == "`" then
      debug = not debug 
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
