Alpha = {}
Tunnel.bindInterface("Alpha", Alpha)

function Alpha.GetArmour(armour,vest)
	local player = GetPlayerPed(-1)
	if vest then
	  if(GetEntityModel(player) == GetHashKey("mp_m_freemode_01")) then
		SetPedComponentVariation(player, 9, 4, 1, 2)
	  else 
		if(GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
		  SetPedComponentVariation(player, 9, 6, 1, 2)
		end
	  end
	end
	local n = math.floor(armour)
	SetPedArmour(player,n)
end