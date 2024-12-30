--- === InputSource ===
---
--- A simple Spoon to set InputSource to English when an application is switched.
---

local obj = {} -- Create the Spoon object
obj.__index = obj

-- Metadata
obj.name = "InputSource"
obj.version = "1.0"
obj.author = "Kei Takashima <takashima.kei@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local inputSources = {
    ["Japanese"] = "com.apple.inputmethod.Kotoeri.RomajiTyping",
    ["Australian"] = "com.apple.keylayout.Australian"
}

-- Function to switch input source
local function switchInputSource(targetSource)
    local currentSource = hs.keycodes.currentSourceID()
    if currentSource ~= targetSource then
        hs.keycodes.currentSourceID(targetSource)
    end
end

local appWatcher = hs.application.watcher.new(function(appName, eventType, app)
    if eventType == hs.application.watcher.activated then
        switchInputSource(inputSources["Australian"])
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

-- Return the object
return obj
