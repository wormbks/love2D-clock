local border = 10
local udate_flag = true

function love.load()
    love.window.setTitle("Love2D clock")
      -- normal font digits
    digits = love.graphics.newImageFont("data/digits01.png",
           "1234567890 :", 0)
    love.graphics.setFont(digits)
    font_height = digits:getHeight( )
    screen_height = font_height + 2*border
    screen_width = digits:getWidth("23:23:55") + 2*border

    love.window.setMode(screen_width, screen_height,
        {resizable=false,
         vsync=0,
         minwidth=screen_width,
         minheight=screen_height})

end

dtotal = 0   -- this keeps track of how much time has passed
function love.update(dt)
   -- we add the time passed since the last update, probably a very
   -- small number like 0.01
   dtotal = dtotal + dt
   if dtotal >= 1 then
      -- reduce our timer by a second, but don't discard the change...
      -- what if our framerate is 2/3 of a second?
      dtotal = dtotal - 1
   end
end

function love.draw()
    if udate_flag then
       local time_str = os.date("%H:%M:%S") -- hour..':'..minute
       love.graphics.print(time_str, 0, border)
       update_flag= false
    end

end