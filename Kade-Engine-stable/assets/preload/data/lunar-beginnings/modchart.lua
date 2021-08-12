function start (song)
	print("Song: " .. song .. " @ " .. bpm .. " downscroll: " .. downscroll)
end


function update (elapsed) -- example https://twitter.com/KadeDeveloper/status/1382178179184422918
	local currentBeat = (songPos / 1000)*(bpm/60)
	for i=0,7 do
		setActorX(_G['defaultStrum'..6..'X'], 4)
		setActorX(_G['defaultStrum'..7..'X'], 5)
		setActorX(_G['defaultStrum'..5..'X'], 6)
		setActorX(_G['defaultStrum'..4..'X'], 7)
	end
end

function beatHit (beat)
   -- do nothing
end

function stepHit (step)
	-- do nothing
end

function keyPressed (key)
	-- do nothing
end

print("Mod Chart script loaded :)")