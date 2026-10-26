--game where animals fall from top player clicks
--before hit the bottom
--game ends when animal hits bottom

function love.load()
  chickenFace = love.graphics.newImage("chicken.png")
  backgroundImage = love.graphics.newImage("bg.png")
  powerUp = love.graphics.newImage("powerUp.png")
  
   randx =  love.math.random(0, love.graphics.getWidth() - powerUp:getWidth() )
   randy = love.math.random(powerUp:getHeight(), powerUp:getHeight() * 2)
  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  startx = {math.random(0, love.graphics.getWidth() - chickenFace:getWidth()), 
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),  
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()),  
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth()), 
            math.random(0, love.graphics.getWidth() - chickenFace:getWidth())}
  starty = {0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2),
            0 - math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2)}
end

-------------------------------------------------
--MOUSE PRESS
--1 = left, 2 = right, 3 = middle wheel
-------------------------------------------------

function love.mousepressed(x, y, button, istouch)
  if button == 1 then -- Left click
    
    -- 1. Check if a chicken was clicked
    for i, v in ipairs(startx) do
      if x >= startx[i] and x <= startx[i] + chickenFace:getWidth() and 
         y >= starty[i] and y <= starty[i] + chickenFace:getHeight() then
        
        -- Reset chicken back to the top
        starty[i] = math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2) * -1
        -- Give it a new random X position so it doesn't fall in the same line
        startx[i] = math.random(0, love.graphics.getWidth() - chickenFace:getWidth())
      end
    end
    
    -- 2. Check if the power-up was clicked (Keep this OUTSIDE the chicken loop!)
    if x >= randx and x <= randx + powerUp:getWidth() and 
       y >= randy and y <= randy + powerUp:getHeight() then
      
      print("Power-up clicked!")
      
      -- Move power-up to a new random spot after clicking it
      randx = love.math.random(0, love.graphics.getWidth() - powerUp:getWidth())
      randy = love.math.random(powerUp:getHeight(), powerUp:getHeight() * 2)
    end

  end
end





-------------------------------------------------
--UPDATE
-------------------------------------------------
function love.update(dt)
  for i, v in ipairs(starty) do
    --if chicken hits the bottom of the screen, lua quits (we lose)
    if starty[i] + chickenFace:getHeight() >= love.graphics.getHeight() then
      --print("over the edge")
      love.event.quit()
    end
    --chickens move down 
    starty[i] = starty[i] + 80 * dt
  end
end

-------------------------------------------------
--DRAW
-------------------------------------------------
function love.draw()
  
  love.graphics.draw(backgroundImage, 0, 0)
   love.graphics.draw(powerUp, randx, randy)
   

  --draw each chicken at their respective x and y
  for i, v in ipairs(startx) do
    love.graphics.draw(chickenFace, startx[i], starty[i], 0, 1, 1)
  end
end

--[[function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    --print("left mouse clicked")
    for i, v in ipairs(startx) do
      --if the mouse x and y is within the boundary of a chicken picture
      if x >= startx[i] and x <= startx[i] + chickenFace:getWidth() and y >= starty[i] and y <= starty[i] + chickenFace:getHeight() then
        --print("in bounds")
        math.randomseed(os.time())
        math.random(); math.random(); math.random()
        --reset its y value (go back to the top)
        starty[i] = math.random(chickenFace:getHeight(), chickenFace:getHeight() * 2) * -1
      elseif x >= randx and x <= randx + powerUp:getWidth() and y >= randy and y <= randy + powerUp:getHeight() then
        --the powerup will do something
      
      end
    end
  end
end]]
