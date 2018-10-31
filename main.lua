require("maps")
require("entities")
require("player")
require("inventory")

notification = "Arrow keys to move"
currency = 0

mapOffset = {15,15}

function love.load()
  width, height = love.graphics.getDimensions()
  tile = {}
	for i=0,10 do
		tile[i] = love.graphics.newImage( "assets/tile"..i..".png" )
	end
  
  draw_entities()

  map_display_w = #realmap.landscape.tiles[1]+mapOffset[1]
	map_display_h = #realmap.landscape.tiles+mapOffset[2]
	tile_w = 8
	tile_h = 12
  
	map_w = #realmap.landscape.tiles[1]
	map_h = #realmap.landscape.tiles
	map_x = -mapOffset[1] - tile_w/2
	map_y = -mapOffset[2] - tile_h/2
	map_display_buffer = 2
  print(height)
  print(tile_h*map_h)
  print(height/(tile_h*map_h))
end
 
function love.touchmoved( id, x, y, dx, dy, pressure )
  print(dx)
  print(dy)
end
 
function love.keypressed(key, scancode, isrepeat)
  playerMove(key)
end
 
function love.draw()
  love.graphics.scale(height/(tile_h*map_h+mapOffset[1]*2),height/(tile_h*map_h+mapOffset[2]*2))
	drawMap(realmap.landscape.tiles, realmap.landscape.colors)
  drawMap(realmap.entities.tiles, realmap.entities.colors)
  love.graphics.setColor(255,255,255)
  love.graphics.print(notification, 10, 250)
  love.graphics.setColor(0,255,0)
  love.graphics.print("$"..currency, 10,280)
  drawInventory()
end