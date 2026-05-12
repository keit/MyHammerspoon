--- === iPodcastAutoLaunch ===
---
--- Launches iPodcast when an iPod volume mounts at /Volumes/IPOD.
---
--- Usage:
---   hs.loadSpoon("iPodcastAutoLaunch")
---   spoon.iPodcastAutoLaunch:start()

local obj = {}
obj.__index = obj

obj.name = "iPodcastAutoLaunch"
obj.version = "1.0"
obj.author = "Kei Takashima"
obj.license = "MIT"

obj.mountPath = "/Volumes/IPOD"
obj.appName = "iPodcast"

function obj:init()
    self.watcher = hs.fs.volume.new(function(event, info)
        if event == hs.fs.volume.didMount and info and info.path == obj.mountPath then
            hs.application.launchOrFocus(obj.appName)
        end
    end)
    return self
end

function obj:start()
    if self.watcher then self.watcher:start() end
    return self
end

function obj:stop()
    if self.watcher then self.watcher:stop() end
    return self
end

return obj
