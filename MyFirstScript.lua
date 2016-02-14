scriptId = 'com.thalmic.examples.myfirstscript'
scriptTitle = "My First Script"
scriptDetailsUrl = ""

function onForegroundWindowChange(app, title)
	myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
	return true
	end

--[[function onPoseEdge(pose, edge)
	if(edge == "on") then
		if(pose == "waveIn") then
			myo.debug("waveIn detected.")
		elseif(pose == "waveOut") then
			myo.debug("waveOut detected.")
		elseif(pose == "fist") then
			myo.debug("fist detected.")
		elseif(pose == "doubleTap") then
			myo.debug("doubleTap detected")
		else
			myo.debug("other.")
		--myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
		end
	end
end
--]]

function onPoseEdge(pose, edge)
	myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
	
	pose = conditionallySwapWave(pose)
	
	if pose ~= "rest" and pose ~= "unknown" then
		--hold if edge is on, timed if edge is off
		--"if edge is off call timed, otherwise call hold"
		myo.unlock(edge == "off" and "timed" or "hold")
	end

	local keyEdge
	if edge == "on" then
		keyEdge = "down"
	else
		keyEdge = "up"
	end

	if edge == "on" then
		if pose == "waveOut" then
			onWaveOut(keyEdge)
		elseif pose == "waveIn" then
			onWaveIn(keyEdge)
		elseif pose == "fist" then
			onFist(keyEdge)
		elseif pose == "fingersSpread" then
			onFingersSpread(keyEdge)
		end
	end
end

function conditionallySwapWave(pose)
	if myo.getArm() == "left" then
		if pose == "waveIn" then
			pose = "waveOut"
		elseif pose == "waveOut" then
			pose = "waveIn"
		end
	end
	return pose
end

function onWaveOut(keyEdge)
	myo.debug("Next")
--	myo.vibrate("short")
	myo.keyboard("tab",keyEdge)
end

function onWaveIn(keyEdge)
	myo.debug("Previous")
--	myo.vibrate("short")
--	myo.vibrate("short")
	myo.keyboard("tab",keyEdge,"shift")
end

function onFist(keyEdge)
	myo.debug("Enter")
--	myo.vibrate("long")
	myo.keyboard("return",keyEdge)
end

function onFingersSpread(keyEdge)
	myo.debug("Escape")
--	myo.vibrate("short")
--	myo.vibrate("long")
	myo.keyboard("escape",keyEdge)
end
