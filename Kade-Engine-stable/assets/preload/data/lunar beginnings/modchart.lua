function start (song)
	print("Song: " .. song .. " @ " .. bpm .. " downscroll: " .. downscroll)
	--setActorX(defaultStrum6X, 4)
	--setActorX(defaultStrum7X, 5)
	--setActorX(defaultStrum5X, 6)
	--setActorX(defaultStrum4X, 7)
	strumAlpha = 1
	if distractions == true then
		for i = 0,7 do
			setActorY(_G['defaultStrum'..i..'Y'] - 20, i)
			setActorAlpha(0, i)
		end
		strumAlpha = 0.8
	end


end


function update (elapsed) -- example https://twitter.com/KadeDeveloper/status/1382178179184422918
	local currentBeat = (songPos / 1000)*(bpm/60)
	for i=0,7 do
		--setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
		--setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
end

function beatHit (beat)
   -- do nothing
   print("beat was hit")

   if beat == 49 or beat == 63 or beat == 81 or beat == 97 or beat == 132 or beat == 201 or beat == 217 or beat == 232 then --When bf notes should hide
	for i=4,7 do
		tweenFadeOut(i, 0, 0.5, "hid the strum")
		tweenPos(i, _G['defaultStrum'..i..'X'], _G['defaultStrum'..i..'Y'] - 20, 0.5, "moved the strum")
	end
	print("should hide")
   end
   if beat == 38 or beat == 52 or beat == 71 or beat == 86 or beat == 103 or beat == 146 or beat == 171 or beat == 206 or beat == 220 then --When bf notes should show
	for i=4,7 do
		tweenFadeOut(i, strumAlpha, 0.5, "shown the strum")
		tweenPos(i, _G['defaultStrum'..i..'X'], _G['defaultStrum'..i..'Y'], 0.5, "moved again")
	end
	print("should show")
   end
   
   if beat == 40 or beat == 54 or beat == 72 or beat == 88 or beat == 104 or beat == 147 or beat == 207 or beat == 222 or beat == 232 then --When player2 notes should hide
	for i=0,3 do
		tweenFadeOut(i, 0, 0.5, "hid the strum")
		tweenPos(i, _G['defaultStrum'..i..'X'], _G['defaultStrum'..i..'Y'] - 20, 0.5, "moved the strum")
	end
	print("should hide")
   end
   if beat == 31 or beat == 47 or beat == 56 or beat == 63 or beat == 80 or beat == 96 or beat == 111 or beat == 161 or beat == 215 or beat == 225 then --When player 2 notes should show
	for i=0,3 do
		tweenFadeOut(i, strumAlpha, 0.5, "shown the strum")
		tweenPos(i, _G['defaultStrum'..i..'X'], _G['defaultStrum'..i..'Y'], 0.5, "moved again")
	end
	print("should show")
   end

end

function stepHit (step)
	-- do nothing
end

function keyPressed (key)
	-- do nothing
end

print("Mod Chart script loaded :)")