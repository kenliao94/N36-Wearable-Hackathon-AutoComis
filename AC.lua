require "os"
scriptId = 'com.AutoComis.examples.myFirstScript'
 
function onForegroundWindowChange(app, title) --This is a callback defined by Myo Script
        return true
end
--Unlock Mechanism
function unlock()
        unlocked = true
        extendUnlock()
end
 
function extendUnlock()
        unlockedSince = myo.getTimeMilliseconds()
end
 
function onPoseEdge(pose, edge)
        myo.debug(pose .. ": " .. edge)
    -- Unlock
    if pose == "thumbToPinky" then
        myo.debug("Unlocked!")
        if edge == "off" then
            -- Actually unlock when pose is released in case the user holds it for a
            -- while.
            unlock()
        elseif edge == "on" and not unlocked then
            -- Vibrate twice on unlock.
            -- We do this when the pose is made for better feedback.
            myo.vibrate("short")
            myo.vibrate("short")
            extendUnlock()
        end
    end
 
    --Message Sending
    if unlocked and pose ~= "rest" then
        sendMsg (pose, edge)
    end
 
       
end
 
function idle()
        --Locking
    if myo.getTimeMilliseconds() - unlockedSince >= 2000 and unlocked == true then
        lock()
        myo.vibrate("short")
    end
end
function lock ()
        myo.debug("Locked!")
        unlocked = false
end
 
function sendMsg (pose, edge)
        unlockedSince = myo.getTimeMilliseconds()
 
        if pose == "fist" then
                myo.debug("You see this pose? It's the screw you pose!")
        end
 
        if pose == "fingersSpread" then
                myo.debug("This pose is extremely apologetic! I'm so sorry...")
                os.execute("java LoadImageApp.class stopSign.jpg")
        end
 
        if pose == "waveIn" then
                myo.debug("This pose indicates that I want to turn left :)")
        end
 
        if pose == "waveOut" then
                myo.debug("I WANNA TURN RIGHT YO BEEP BEEP")
        end
 
        myo.vibrate("short")
end