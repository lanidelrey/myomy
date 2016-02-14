--Here's a little script we made.
--It is created for use with SketchUp, the 3D drawing application
--It combines the Myo armband with a few of the functions of SketchUp
--yay

scriptId = 'com.myomy.scripts.positions+messing_around'
scriptTitle = "positions + messing around"
scriptDetailsUrl = ""

--Only applicable if the SketchUp window is selected
function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return platform == "MacOS" and app == "com.sketchup.SketchUp.2016"
end

-- Mouse enabled only when unlocked
function onUnlock()
    myo.controlMouse(true)
    --Doesn't lock until you explicitly tell it to (see line 82)
    myo.unlock("hold")
end

--Check pose, execute accordingly
function onPoseEdge(pose, edge)
    myo.debug("onPoseEdge: " .. pose .. ": " .. edge)
    
    if pose ~= "rest" and pose ~= "unknown" then
        --hold if edge is on, timed if edge is off
        --"if edge is off call timed, otherwise call hold"
        myo.unlock(edge == "off" and "timed" or "hold")
    end

    if edge == "on" then
        if pose == "waveOut" then
            onWaveOut()
        elseif pose == "waveIn" then
            onWaveIn()
        elseif pose == "fist" then
            onFist()
        elseif pose == "offFist" then
            offFist()
        elseif pose == "fingersSpread" then
            onFingersSpread()
        elseif pose == "doubleTap" then
            onDoubleTap()
        end
    elseif edge == "off" then
        offFist()
    end
end

--waveOut is select tool
function onWaveOut()
    myo.debug("Select")
    myo.keyboard("/","press","command")
    myo.mouse("left","click")
end

--waveIn is free draw tool
function onWaveIn()
    myo.debug("Free Draw")
    myo.keyboard("f","press","command")
end

--fist is hold left click down
function onFist()
    myo.debug("left down")
    myo.mouse("left","down")
end

--offFist is let go of left click
function offFist()
    myo.debug("left up")
    myo.mouse("left","up")
end

--fingersSpread is walk tool
function onFingersSpread()
    myo.debug("Walk")
    myo.keyboard("comma","press","command")
end

--double tap locks if myo is currently unlocked
function onDoubleTap()
    if myo.isUnlocked() then
        myo.controlMouse(false)
        myo.lock()
    end
end
