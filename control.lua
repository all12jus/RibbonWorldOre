local function on_chunk_generated(event)
	local area = event.area
	local left_top = area.left_top
	local right_bottom = area.right_bottom
	local surface = event.surface
	for _, entity in pairs(surface.find_entities_filtered({area=area, type="resource"})) do
		entity.destroy()
	end

	for y=left_top.y,right_bottom.y do
		for x=left_top.x,right_bottom.x do
			local tile = surface.get_tile(x, y)
			if tile.name ~= "out-of-map" then
				if y >= 81 or y <= -81 then
					surface.set_tiles{{name="out-of-map", position={x,y}},{name="out-of-map", position={x,y-1}}, {name="out-of-map", position={x,y+1}}}
				end
				-- this isn't the right name for the ground tile name....
				-- if tile.name ~= "out-of-map" and tile.collides_with("water-tile") then
				if tile.name ~= "out-of-map" then
					surface.set_tiles{{name="grass-1", position={x,y}},{name="grass-1", position={x,y-1}}, {name="grass-1", position={x,y+1}}}
				end

			end

		end
	end

	for y=left_top.y,right_bottom.y do
		for x=left_top.x,right_bottom.x do

			local tile = surface.get_tile(x, y)

			if tile.collides_with("ground-tile") and tile.name ~= "out-of-map" then
				if y >= 	79 or y < -78 then
					surface.set_tiles{{name="water", position={x,y}},{name="water", position={x,y-1}}, {name="water", position={x,y+1}}}
				else
					if x >= 0 then
						if y >= 69 then
							-- uranium
							surface.create_entity({name="uranium-ore", amount=math.abs((x+1)*5), position={x,y}})
							-- end uranium
						elseif y >= 64 then
							-- stone
							surface.create_entity({name="stone", amount=math.abs((x+1)*5), position={x,y}})
							-- end stone
						elseif y >= 16 then
							-- copper
							surface.create_entity({name="copper-ore", amount=math.abs((x+1)*5), position={x,y}})
							-- end copper
						elseif y < -70 then
							if y == -75 and (x+1) % 3 < 1 then
								-- oil... get exact.
								surface.create_entity({name="crude-oil", amount=math.abs((x+1)*5000), position={x,y}})
							end
							-- END OIL
						elseif y < -65 then
							-- coal
							surface.create_entity({name="coal", amount=math.abs((x+1)*5), position={x,y}})
							-- end coal
						elseif y < -16 then
							-- iron
							surface.create_entity({name="iron-ore", amount=math.abs((x+1)*5), position={x,y}})
							-- end iron
						end
					end
				end

			end
		end
	end

	for key, entity in pairs (game.surfaces[1].find_entities_filtered({force="neutral", name="cliff"})) do
		entity.destroy()
	end


end
script.on_event(defines.events.on_chunk_generated, on_chunk_generated)
