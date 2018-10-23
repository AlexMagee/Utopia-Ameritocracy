player_x = 15;
player_y = 15;
player_tile = 1;

function love.load()
  renderWorld()
end

function renderWorld()
	-- our tiles
	tile = {}
	for i=0,8 do -- change 3 to the number of tile images minus 1.
		tile[i] = love.graphics.newImage( "tile"..i..".png" )
	end
 
	-- the map (random junk + copy and paste)
	map={{}}
  
  for x=1, 20 do
    map[x]={}
    for y=1, 20 do
      map[x][y] = 0
    end
  end

  house = {
    {3,8,8,8,8,8,8,8,5},
    {7,0,0,0,0,0,0,0,7},
    {7,0,0,0,0,0,0,0,7},
    {7,0,0,3,8,5,0,0,7},
    {7,0,0,7,0,7,0,0,7},
    {7,0,0,4,8,6,0,0,7},
    {7,0,0,0,0,0,0,0,7},
    {7,0,0,0,0,0,0,0,7},
    {4,8,8,8,0,8,8,8,6}
  }
  
  add_feature(map, house, 1, 1)
  map[player_y][player_x] = player_tile
 
	-- map variables
  map_display_w = #map[1]
	map_display_h = #map
	tile_w = 8
	tile_h = 12
  
	map_w = #map[1] -- Obtains the width of the first row of the map
	map_h = #map -- Obtains the height of the map
	map_x = 0 - tile_w/2
	map_y = 0 - tile_h/2
	map_display_buffer = 2 -- We have to buffer one tile before and behind our viewpoint.
	
end

function add_feature(map, feature, ox, oy)
  for x=1, #feature[1] do
    for y=1, #feature do
      if(feature[x][y]~=0) then
        map[ox+x][oy+y] = feature[x][y];
      end
    end
  end
end
 
function draw_map()
	offset_x = map_x % tile_w
	offset_y = map_y % tile_h
	firstTile_x = math.floor(map_x / tile_w)
	firstTile_y = math.floor(map_y / tile_h)
 
	for y=1, (map_display_h + map_display_buffer) do
		for x=1, (map_display_w + map_display_buffer) do
			-- Note that this condition block allows us to go beyond the edge of the map.
			if y+firstTile_y >= 1 and y+firstTile_y <= map_h
				and x+firstTile_x >= 1 and x+firstTile_x <= map_w
			then
				love.graphics.draw(
					tile[map[y+firstTile_y][x+firstTile_x]], 
					((x-1)*tile_w) - offset_x - tile_w/2, 
					((y-1)*tile_h) - offset_y - tile_h/2)
			end
		end
	end
end
 
function love.update( dt )
  
end
 
function love.keypressed(key, scancode, isrepeat)
  if(key == "up" and player_y-1 > 0 and map[player_y-1][player_x] == 0) then
    player_y = player_y-1
  end
  if(key == "down" and player_y+1 < #map and map[player_y+1][player_x] == 0) then
    player_y = player_y+1
  end
  if(key == "right" and map[player_y][player_x+1] == 0) then
    player_x = player_x+1
  end
  if(key == "left" and map[player_y][player_x-1] == 0) then
    player_x = player_x-1
  end
  renderWorld()
end
 
function love.draw()
	draw_map()
end