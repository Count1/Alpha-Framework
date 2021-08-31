local Tunnel = module("lib/Tunnel")
local Proxy = module("lib/Proxy")               

AlphaC = Tunnel.getInterface("Alpha", "Alpha")

RegisterCommand("armour", function(source, args, rawCommand)
    AlphaC.GetArmour(source,{100,true})
end, false)