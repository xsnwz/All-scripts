local Network = {}
local Callbacks = {}

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if (self:IsA("RemoteEvent") and (method == "FireClient" or method == "FireAllClients")) then
        local eventName = self.Name

        if Callbacks[eventName] then
            for _, callback in ipairs(Callbacks[eventName]) do
                task.spawn(function()
                    callback(unpack(args))
                end)
            end
        end
    end
    
    return oldNamecall(self, ...)
end))

function Network:Retrieve(eventName, callback)
    if not Callbacks[eventName] then
        Callbacks[eventName] = {}
    end
    
    table.insert(Callbacks[eventName], callback)
    
    return function()
        for i, cb in ipairs(Callbacks[eventName]) do
            if cb == callback then
                table.remove(Callbacks[eventName], i)
                break
            end
        end
    end
end

return Network
