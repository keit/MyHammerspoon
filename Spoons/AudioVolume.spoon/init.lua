--- === AudioVolume ===
---
--- A simple Spoon to set audio volume level when speakers are switched.
---

local obj = {} -- Create the Spoon object
obj.__index = obj

-- Metadata
obj.name = "AudioVolume"
obj.version = "1.0"
obj.author = "Kei Takashima <takashima.kei@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Load the audio module
local audio = require("hs.audiodevice")

-- Function to handle audio device changes
local function audioDeviceChanged(event)
    if event == "dOut" then
        local device = audio.defaultOutputDevice()
        if device then
            local deviceName = device:name()
            print("Audio output changed to: " .. deviceName)

            -- Adjust volume for specific devices
            if deviceName == "iMac Speakers" or deviceName == "External Headphones" then
                device:setVolume(20)
                print("Volume set to 20 for " .. deviceName)
            else
                -- Default volume for other devices
                device:setVolume(60)
                print("Volume set to default 60 for " .. deviceName)
            end
        end
    end
end

function obj:init()
end

function obj:start()
    -- Watch for audio device changes
    audio.watcher.setCallback(audioDeviceChanged)
    audio.watcher.start()
end

function obj:stop()
    audio.watcher.stop()
end

-- Return the object
return obj
