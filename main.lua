local border = 10
local short_time = true
local time_str = os.date("%H:%M")

function love.conf(t)
	-- t.console = true
end

function love.load()
   love.window.setTitle("Love2D clock")
   -- normal font digits
   digits = love.graphics.newImageFont("data/digits01.png", "1234567890 :", 0)
   love.graphics.setFont(digits)
   local font_height = digits:getHeight()
   local screen_height = font_height + 2 * border
   local screen_width = digits:getWidth("23:23:55") + 2 * border
   if short_time then
      time_str = os.date("%H %M")
      screen_width = digits:getWidth("23:23") + 2 * border
   else
      time_str = os.date("%H:%M:%S")
   end

   love.window.setMode(screen_width, screen_height,
      {
         resizable = false,
         vsync = 0,
         minwidth = screen_width,
         minheight = screen_height
      })
end

-- local on_dots = false
-- local function without_seconds()
--    if on_dots then
--       time_str = os.date("%H:%M")
--    else
--       time_str = os.date("%H %M")
--    end

--    on_dots = not on_dots
-- end

-- local function with_seconds()
--    return os.date("%H:%M:%S")
-- end

-- local function get_time_str()
--    -- update the clock
--    if short_time then
--       return without_seconds()
--    end
--    return with_seconds()
-- end
local dots_on = true
local function get_time_str(on)
   if short_time then
      if on then
         return os.date("%H:%M")
      else
         return os.date("%H %M")
      end
   end
   return os.date("%H:%M:%S")
end

local dtotal = 0 -- this keeps track of how much time has passed

function love.update(dt)
   -- we add the time passed since the last update, probably a very
   -- small number like 0.01
   dtotal = dtotal + dt
   if dtotal >= 1.0 then
      -- reduce our timer by a second, but don't discard the change...
      -- what if our framerate is 2/3 of a second?
      dtotal = dtotal - 1.0
      time_str = get_time_str(dots_on)
      -- print(dtotal, time_str)
      dots_on = not dots_on
   end
end

function love.draw()
   love.graphics.print(time_str, 0, border)
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end
