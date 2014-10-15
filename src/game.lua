require "class"
require "player"
gamelib = {}

frame = 0; -- FIXME move

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
  players[2].controls = {
    right = "d",
    left = "a",
    jump = "w",
    attack = "lctrl"
  } 
  players[2].pos = "right"
  players[2].facing = -1

end

-------------------------------------
-- gamelib.update
-------------------------------------
function gamelib.update (dt)
  if state == "game" then

    frame = frame + dt * 12 -- TODO limit?

    for i,p in ipairs(players) do
      if p.life < 10 then
        state = "end"
        endlib.playmusic()
      end

      -- collisions
      local me = p
      for i,him in ipairs(players) do
        if not (me == him) then -- reference comparsion - do not collide with self
          
          for myHitboxType, myHitbox in pairs(me.hitboxes) do
          for hisHitboxType, hisHitbox in pairs(him.hitboxes) do
		  
		  if hisHitboxType == "vulnerability" and myHitboxType == "attack" and collision(myHitbox, hisHitbox, me, him) then
		      print ("HIT", him.pos);
		      him.life = him.life - 0.1
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

	    if p.action then
		p.action.dt = p.action.dt + dt
		if p.action.dt > p.action.dur then
		  p.action=nil
		end

                if p.action and p.action.name == "attack" then p.hitboxes.attack.x = 30
                else p.hitboxes.attack.x = -10
                end 
                
	    end



	    if love.keyboard.isDown(p.controls.left) then
              p.facing=-1
-- FIXME
	      p.x = p.x - 400*dt
	      if p.x < 100 and p.x >= 0 then
                if distance>0 then p.x = 100 end
		distance = distance - 500*dt
	      end
	      if p.x < 0 then p.x = 0 end
              
	    elseif love.keyboard.isDown(p.controls.right) then
              p.facing=1

	      p.x = p.x + 400*dt
	      if p.x > 550 then -- rborder
		p.x = 550
		distance = distance + 500*dt
	      end
	    end


	  p.y = 530-math.sin(p.jump_dt)*250
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
    love.graphics.setColor(255,255,255)

    local cityscale = 600/assets.city:getHeight();
    if not debug then
     love.graphics.draw(assets.city,-distance,0,0,cityscale)
    end

    for i,p in ipairs(players) do
       p:draw()

    end

    if debug then
        love.graphics.setColor(255,255,255)
        love.graphics.setNewFont(15)

      love.graphics.print("\n"
          .."\nDistance:"..math.floor(distance)
          .."\nplx,ply:"..math.floor(players[1].x)..","..math.floor(players[1].y)
          .."\nframe:"..math.floor(frame)
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

	    elseif love.keyboard.isDown(p.controls.attack) and not p.action then
              p.action = {name="attack", dt=0, dur=.2}
       
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
