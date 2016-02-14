scriptId = 'com.myomy.scripts.messingaround'
scriptTitle = "messing around"
scriptDetailsUrl = ""

function onForegroundWindowChange(app, title)
	myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
	return true
	end

myo.controlMouse(true)

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
			onFist()
		elseif pose == "fingersSpread" then
			onFingersSpread(keyEdge)
		end
	elseif edge == "off" then
		offFist()
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

function onFist()
	myo.debug("left down")
--	myo.vibrate("long")
	myo.mouse("left","down")
end

function offFist()
	myo.debug("left up")
	myo.mouse("left","up")
end

function onFingersSpread(keyEdge)
	myo.debug("Escape")
--	myo.vibrate("short")
--	myo.vibrate("long")
	myo.keyboard("escape",keyEdge)
end
