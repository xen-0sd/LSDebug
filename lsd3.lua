factor = 1;
while true do
	local readbyte = memory.readbyte
	local rs32 = memory.read_s32_le
	local ru32 = memory.read_u32_le

	timerGame = rs32(0x90B74) --Game timer
	timerField = rs32(0x8AC70) --Field (current level) timer
	linkDiv = math.floor((timerGame / timerField)+0.5) --Divide tG by tF and round down (pretty sure this is how the game determines where to send you during a link)
	fmv = rs32(0xF3E94) --Whether the player is in a video or not
	circleread = readbyte(0x915A4) --Is circle pressed
	walkingspeed = readbyte(0x915DC)
	tpfactor = (factor * 100) --How far to go when the player presses an arrow key
	level = readbyte(0x8ABF8)
	day = memory.read_u32_le(0x916B0)
	soundfont = rs32(0x1FF424) --This keeps breaking randomly
	x = rs32(0x91E74)
	y = rs32(0x91E7C)
	z = rs32(0x91E78)
	cX = 318 --Center of graph.png
	cY = 19 --Center of graph.png

			
	daytxt = day+1 --What is internally "Day 0" is displayed as "Day 1" in-game and in this debug menu
	
	-- Graph Manager (Graph prediction code made by hgs. | GUI display, link colors, and starting level predictor made by Xen)

	  total_area_x = memory.readbyte(0x0091678) + memory.readbyte(0x0091679)*256 + memory.readbyte(0x009167A)*256*256 + memory.readbyte(0x009167B)*256*256*256
	  if total_area_x >= (256*256*256*256)/2 then
		total_area_x = total_area_x - 256*256*256*256
	  end
	  total_area_y = memory.readbyte(0x009167C) + memory.readbyte(0x009167D)*256 + memory.readbyte(0x009167E)*256*256 + memory.readbyte(0x009167F)*256*256*256
	  if total_area_y >= (256*256*256*256)/2 then
		total_area_y = total_area_y - 256*256*256*256
	  end
	  last_area_x = memory.readbyte(0x0091674)
	  if last_area_x >= 256/2 then
		last_area_x = last_area_x - 256
	  end
	  if last_area_x >= 6 then
		lank_last_area_x = 2
	  elseif last_area_x >= 3 then
		lank_last_area_x = 1
	  elseif last_area_x >= -2 then
		lank_last_area_x = 0
	  elseif last_area_x >= -5 then
		lank_last_area_x = -1
	  elseif last_area_x <= -6 then
		lank_last_area_x = -2
	  end
	  last_area_y  = memory.readbyte(0x0091675)
	  if last_area_y >= 256/2 then
		last_area_y = last_area_y - 256
	  end
	  if last_area_y >= 6 then
		lank_last_area_y = 2
	  elseif last_area_y >= 3 then
		lank_last_area_y = 1
	  elseif last_area_y >= -2 then
		lank_last_area_y = 0
	  elseif last_area_y >= -5 then
		lank_last_area_y = -1
	  elseif last_area_y <= -6 then
		lank_last_area_y = -2
	  end
	  area_counter = memory.readbyte(0x0091680) + memory.readbyte(0x0091681)*256 + memory.readbyte(0x0091682)*256*256 + memory.readbyte(0x0091683)*256*256*256
	  if area_counter >= (256*256*256*256)/2 then
		area_counter = area_counter - 256*256*256*256
	  end
	  
	  total_chara_x   = memory.readbyte(0x0091688) + memory.readbyte(0x0091689)*256 + memory.readbyte(0x009168A)*256*256 + memory.readbyte(0x009168B)*256*256*256
	  if total_chara_x >= (256*256*256*256)/2 then
		total_chara_x = total_chara_x - 256*256*256*256
	  end
	  total_chara_y = memory.readbyte(0x009168C) + memory.readbyte(0x009168D)*256 + memory.readbyte(0x009168E)*256*256 + memory.readbyte(0x009168F)*256*256*256
	  if total_chara_y >= (256*256*256*256)/2 then
		total_chara_y = total_chara_y - 256*256*256*256
	  end
	  last_chara_x = memory.readbyte(0x0091684)
	  if last_chara_x >= 256/2 then
		last_chara_x = last_chara_x - 256
	  end
	  if last_chara_x >= 6 then
		lank_last_chara_x = 2
	  elseif last_chara_x >= 3 then
		lank_last_chara_x = 1
	  elseif last_chara_x >= -2 then
		lank_last_chara_x = 0
	  elseif last_chara_x >= -5 then
		lank_last_chara_x = -1
	  elseif last_chara_x <= -6 then
		lank_last_chara_x = -2
	  end
	  last_chara_y  = memory.readbyte(0x0091685)
	  if last_chara_y >= 256/2 then
		last_chara_y = last_chara_y - 256
	  end
	  if last_chara_y >= 6 then
		lank_last_chara_y = 2
	  elseif last_chara_y >= 3 then
		lank_last_chara_y = 1
	  elseif last_chara_y >= -2 then
		lank_last_chara_y = 0
	  elseif last_chara_y >= -5 then
		lank_last_chara_y = -1
	  elseif last_chara_y <= -6 then
		lank_last_chara_y = -2
	  end
	  chara_counter = memory.readbyte(0x0091690) + memory.readbyte(0x0091691)*256 + memory.readbyte(0x0091692)*256*256 + memory.readbyte(0x0091693)*256*256*256
	  if chara_counter >= (256*256*256*256)/2 then
		chara_counter = chara_counter - 256*256*256*256
	  end
	  area_x = 0
	  area_y = 0
	  if area_counter >= 1 then
		area_x = total_area_x / area_counter
		if area_x <= 0 then
		  area_x = math.ceil(area_x)
		else
		  area_x = math.floor(area_x)
		end
		area_y = total_area_y / area_counter
		if area_y <= 0 then
		  area_y = math.ceil(area_y)
		else
		  area_y = math.floor(area_y)
		end
	  end
	  if (area_x + lank_last_area_x) >=10 then
		area_x = -9
	  elseif (area_x + lank_last_area_x) <=-10 then
		area_x = 9
	  else
		area_x = area_x + lank_last_area_x
	  end
	  if (area_y + lank_last_area_y) >=10 then
		area_y = -9
	  elseif (area_y + lank_last_area_y) <=-10 then
		area_y = 9
	  else
		area_y = area_y + lank_last_area_y
	  end
	  if chara_counter >= 1 then
		chara_x = total_chara_x / chara_counter
		if chara_x <= 0 then
		  chara_x = math.ceil(chara_x)
		else
		  chara_x = math.floor(chara_x)
		end
		chara_y = total_chara_y / chara_counter
		if chara_y <= 0 then
		  chara_y = math.ceil(chara_y)
		else
		  chara_y = math.floor(chara_y)
		end
		if (chara_x + lank_last_chara_x) >=10 then
		  chara_x = -9
		elseif (chara_x + lank_last_chara_x) <=-10 then
		  chara_x = 9
		else
		  chara_x = chara_x + lank_last_chara_x
		end
		if (chara_y + lank_last_chara_y) >=10 then
		  chara_y = -9
		elseif (chara_y + lank_last_chara_y) <=-10 then
		  chara_y = 9
		else
		  chara_y = chara_y + lank_last_chara_y
		end
		graph_x = (area_x + chara_x) / 2
		if graph_x <= 0 then
		  graph_x = math.ceil(graph_x)
		else
		  graph_x = math.floor(graph_x)
		end
		graph_y = (area_y + chara_y) / 2
		if graph_y <= 0 then
		  graph_y = math.ceil(graph_y)
		else
		  graph_y = math.floor(graph_y)
		end
	    else
		  graph_x = area_x
		  graph_y = area_y
	    end
	
	--Link color setup--
	left = (graph_x <= -4)
	xMiddle = (graph_x >= -3 and graph_x <= 3)
	right = (graph_x >= 4)
	
	top = (graph_y >= 4)
	yCenter = (graph_y >= -3 and graph_y <= 3)
	bottom = (graph_y <= -4)
	
	--Top row--
	if (graph_y >= 1 and graph_x <= -4) then
		linkColor = "#00FF00" --green
	end
	
	if top and yCenter then
		linkColor = "#0000FF" --blue
	end
	
	if top and right then
		linkColor = "#FF00FF" --pink
	end
	
	--Center row--
	if (graph_y >= -3 and graph_y <= 1 and graph_x <= -4) or yCenter and xMiddle then
		linkColor = "#FFFFFF" --white
	end

	if yCenter and right then
		linkColor = "#000000" --black
	end
	
	--Bottom row--

	if bottom and left then
		linkColor = "#FFFF00" --yellow
	end

	if xMiddle and bottom then
		linkColor = "#FF0000" --red
	end
	
	if bottom and right then
		linkColor = "#00FFFF" --light blue
	end

	-- Walking Manager
	if (walkingspeed == 1) then
		walkingtxt = "Tunnel-Walking (96 UPF)"
	end

	if (walkingspeed == 2) then
		walkingtxt = "BMA-Walking (256 UPF)"
	end

	if (walkingspeed == 3) then
		walkingtxt = "Walking (512 UPF)"
	end

	if (walkingspeed == 4) then
		walkingtxt = "Dashing (1024 UPF)"
	end

	-- Circle Manager
	if (circleread == 1) then
		circle = true
	else
		circle = false
	end

	-- Day Manager
	if (daytxt % 2 == 0) then
		daytype = "Even"
	else
		daytype = "Odd"
	end

	-- FMV-Indicator Manager
	if (fmv == 1) then
		fmvtxt = "In video"
	else
		fmvtxt = ""
	end

    -- i now know how to make an array
	levelnumber = level + 1
	
	local lvltbl = {"Bright Moon Apartment", "Temple", "Kyoto", "The Natural World", "HAPPY TOWN", "Violence Town", "Moonlight Tower", "Temple Dojo", "Flesh Tunnels", "Clockwork Machines", "Long Hallway", "Sun Faces Heave", "Black Space", "Monument Park"}
	

	if soundfont == 115 then
		sftxt = "Electro/Lovely"
	end
	
	if soundfont == 131 then
		sftxt = "Ambient"
	end

	if soundfont == 133 then
		sftxt = "Human/Cartoon"
	end

	if soundfont == 134 then
		sftxt = "Standerd"
	end

	if soundfont == 141 then
		sftxt = "Ethnova"
	end

-- 4a4a programming lesson: copy and paste the same bit of code every time you need to use it
    if input.get()["I"] then
        if not IHeld then
            IHeld = true;
            factor = factor - 1;
			gui.addmessage("Factor: "..factor)
        end
    else
        IHeld = false;
    end

    if input.get()["O"] then
        if not OHeld then
            OHeld = true;
            factor = factor + 1;
			gui.addmessage("Factor: "..factor)
        end
    else
        OHeld = false;
    end

    if input.get()["Q"] then
        if not QHeld then
            QHeld = true;
            memory.write_s32_le(0x916B0, rs32(0x916B0, "MainRAM") - factor);
			gui.addmessage("Day decreased by "..factor)
        end
    else
        QHeld = false;
    end

    if input.get()["E"] then
        if not EHeld then
            EHeld = true;
            memory.write_s32_le(0x916B0, rs32(0x916B0, "MainRAM") + factor);
			gui.addmessage("Day increased by "..factor)
        end
    else
        EHeld = false;
    end

    if input.get()["Shift"] then
        if not ShiftHeld then
            ShiftHeld = true;
            memory.write_s32_le(0x91E78, z + tpfactor);
			gui.addmessage("Z increased by "..tpfactor)
        end
    else
        ShiftHeld = false;
    end

    if input.get()["Space"] then
        if not SpaceHeld then
            SpaceHeld = true;
            memory.write_s32_le(0x91E78, z - tpfactor);
			gui.addmessage("Z decreased by "..tpfactor)
        end
    else
        SpaceHeld = false;
    end

    if input.get()["Up"] then
        if not UpHeld then
            UpHeld = true;
            memory.write_s32_le(0x91E74, x + tpfactor);
			gui.addmessage("X increased by "..tpfactor)
        end
    else
        UpHeld = false;
    end

    if input.get()["Down"] then
        if not DownHeld then
            DownHeld = true;
            memory.write_s32_le(0x91E74, x - tpfactor);
			gui.addmessage("X decreased by "..tpfactor)
        end
    else
        DownHeld = false;
    end

    if input.get()["Left"] then
        if not LeftHeld then
            LeftHeld = true;
            memory.write_s32_le(0x91E7C, y + tpfactor);
			gui.addmessage("Y increased by "..tpfactor)
        end
    else
        LeftHeld = false;
    end

    if input.get()["Right"] then
        if not RightHeld then
            RightHeld = true;
            memory.write_s32_le(0x91E7C, y - tpfactor);
			gui.addmessage("Y decreased by "..tpfactor)
        end
    else
        RightHeld = false;	
    end
		
	if circle then
		gui.drawEllipse (173, 118, 24, 24, "black", "black");
		gui.drawEllipse (175, 120, 20, 20, "red", "red");
		gui.drawEllipse (177, 122, 16, 16, "black", "black");
	end

	gui.pixelText(18, 0, "Day "..daytxt.." "..daytype)
	gui.pixelText(18, 8, lvltbl[levelnumber])
--	gui.pixelText(18, 16, sftxt.." ♫")
	gui.pixelText(18, 24, fmvtxt)
	
	gui.pixelText(170, 0, timerGame)
	gui.pixelText(170, 8, timerField)
	gui.pixelText(170, 16, linkDiv, linkColor) --link color will be added once we have an accurate graph predictor
	
	gui.pixelText(300, 40, "("..graph_x..",".." "..graph_y..")")
	gui.drawImage("graph.png", 299, 0)  
	gui.drawRectangle (cX + graph_x * 2, cY + -graph_y * 2, 0.5, 0.5, "red", "red")

	gui.pixelText(170, 192, walkingtxt)
	gui.pixelText(170, 200, "X "..x, "crimson")
	gui.pixelText(170, 208, "Y "..y, "lightgreen")
	gui.pixelText(170, 216, "Z "..z, "skyblue")
	
	emu.frameadvance()
end