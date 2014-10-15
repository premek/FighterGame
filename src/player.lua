Player = class:new()

Player.x = 100 -- TODO position is relative to screen, not world
Player.y = 0
Player.facing = 1

Player.jump = false
Player.jump_dt = 0
Player.jump_speed = 1.5

Player.action = nil 

Player.life = 90
Player.pos = "left"

Player.controls = {
  right = "right",
  left = "left",
  jump = "up",
  attack = " "
  -- b= ...
}

-- TODO more boxes of one type
Player.hitboxes = { -- FIXME do NOT share hitboxes between instances - same for controls
  attack = {
    x=-10,
    y=-50,
    w=20,
    h=10
  },
  vulnerability = {
    x=-50,
    y=-100,
    w=70,
    h=110
  }

}

-- TODO move
spritemap = {
 img = love.graphics.newImage( "assets/char/mai.png" ),
 scale = 2.5,
 rows = {
  -- {t=top, b=bottom, x1, x2, x3 },
  { t=90,  b=202, 10,90,158 },
  { t=340, b=439, 10,101,194,285,377,469,560,651,742,834,926,1018 },
  { t=450, b=547, 10,101,194,285,377 },
 }
}

--[[ find sprites in image automatically?
d=spritemap.img:getData()
for x=0, spritemap.img:getWidth()-1 do
for y=0, spritemap.img:getHeight()-1 do
print (d:getPixel(x,y))
end
end
]]--

quads = {}

for rownum,row in ipairs(spritemap.rows) do
 --print ("row", rownum, row.t, row.b)
 quads[rownum] = {}
 local x = nil
 for colnum, nextx in ipairs(row) do
  if x then
   print ("quad", rownum, colnum, "TL", row.t, x, "BR", row.b, nextx) 
   quads[rownum][colnum] = love.graphics.newQuad(x, row.t, nextx-x, row.b-row.t, spritemap.img:getDimensions())  
  end
  x = nextx
 end
end

animation = {}
for i,q in pairs(quads[2]) do table.insert(animation,q) end
for i,q in pairs(quads[3]) do table.insert(animation,q) end


function Player:draw()
    local animationframe = (math.floor(frame + (self.pos == "right" and 5 or 0)) % #animation) + 1
    local q = animation[animationframe];
    local qx, qy, qw, qh = q:getViewport( )
local posx = self.x-(self.facing*qw*spritemap.scale/2)
local posy = self.y-qh*spritemap.scale

    love.graphics.setColor(255,255,255)
    love.graphics.draw(spritemap.img,
        q,
        posx,
        posy,
        0,
        spritemap.scale*self.facing,
        spritemap.scale )

    love.graphics.printf(math.floor(self.life), (self.pos == "right" and 700 or 30), 20, 10,"left")

    if debug then

        love.graphics.setColor(255,255,255)
        love.graphics.setNewFont(9)
        love.graphics.print(animationframe, posx, posy)

        love.graphics.circle("fill", self.x, self.y, 3,8)
        for hbtype,box in pairs(self.hitboxes) do
           love.graphics.setColor(hbtype=="attack" and {255,0,0,220} or {255,255,255,80})         
           love.graphics.rectangle("fill", self.x+box.x, self.y+box.y, box.w, box.h)
        end
    end

end


