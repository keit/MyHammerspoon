--- === AudioOutputSwitcher ===
---
--- A Spoon to set the default audio output device when a specific application is launched.
---

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "AudioOutputSwitcher"
obj.version = "1.0"
obj.author = "Kei Takashima <takashima.kei@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local rules = {
    ["Transcribe!"] = "Scarlett 2i2 4th Gen",
    ["iReal Pro"] = "Scarlett 2i2 4th Gen",
    ["Music"] = "Scarlett 2i2 4th Gen"
}

local function setOutputDevice(deviceName)
    local device = hs.audiodevice.findOutputByName(deviceName)
    if device then
        device:setDefaultOutputDevice()
    end
end

local appWatcher = hs.application.watcher.new(function(appName, eventType, app)
    if eventType == hs.application.watcher.launched then
        local deviceName = rules[appName]
        if deviceName then
            setOutputDevice(deviceName)
        end
    end
end)

function obj:init()
end

function obj:start()
    appWatcher:start()
end

function obj:stop()
    appWatcher:stop()
end

return obj
