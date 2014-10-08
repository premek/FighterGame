Player = class:new()

Player.x = 100 -- TODO position is relative to screen, not world
Player.y = 0

Player.jump = false
Player.jump_dt = 0
Player.jump_speed = 1.5

Player.life = 90
Player.pos = "left"

Player.controls = {
  right = "right",
  left = "left",
  jump = "up"
}

Player.hitboxes = {
  {
    type="attack",
    x=50,
    y=-50,
    w=20,
    h=10
  },
  {
    type="vulnerability",
    x=-50,
    y=-100,
    w=70,
    h=110
  }

}

function Player:draw()

    love.graphics.setColor(255,255,255)
    love.graphics.draw(assets.puddi[1],
        self.x-77,
        self.y-77,
        0,
        .5,
        .5,
        0,
        61)

    love.graphics.printf(self.life, (self.pos == "right" and 700 or 30), 20, 10,"left")

    if debug then

        love.graphics.circle("line", self.x, self.y, 3,8)
        for i,box in ipairs(self.hitboxes) do
           love.graphics.setColor(box.type=="attack" and {255,0,0} or {255,255,255})         
           love.graphics.rectangle("line", self.x+box.x, self.y+box.y, box.w, box.h)
        end
    end

end


