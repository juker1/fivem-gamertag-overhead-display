CreateThread(function()
    while true do
        Wait(0)
        local playerId = PlayerId()
        local Ped = GetPlayerPed(-1)
        local PlayerName = GetPlayerName(playerId)
        local WantedLevel = GetPlayerWantedLevel(playerId)
        local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
        
        if NetworkIsPlayerActive(playerId) and playerId == playerId then

            if IsMpGamerTagActive(GamerTagId) then
	            RemoveMpGamerTag(GamerTagId)
	            repeat Wait(0) until IsMpGamerTagFree(GamerTagId)
            end

            local GamerTagId = CreateMpGamerTagWithCrewColor(playerId, PlayerName, false, false, "", 0, 0, 0, 0)
            
            SetMpGamerTagVisibility(GamerTagId, 0, true)
            SetMpGamerTagVisibility(GamerTagId, 4, NetworkIsPlayerTalking(playerId))
            SetMpGamerTagVisibility(GamerTagId, 5, IsPauseMenuActive())

            if WantedLevel > 0 then
                SetMpGamerTagVisibility(GamerTagId, 7, true)
                SetMpGamerTagWantedLevel(GamerTagId, WantedLevel)
            else
                SetMpGamerTagVisibility(GamerTagId, 7, false)
            end

            if IsPedSittingInVehicle(Ped, CurrentVehicle) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
                SetMpGamerTagVisibility(GamerTagId, 8, true)
                SetMpGamerTagVisibility(GamerTagId, 9, false)
            elseif IsPedSittingInVehicle(Ped, CurrentVehicle) and GetPedInVehicleSeat(CurrentVehicle, 0) == PlayerPedId() then
                SetMpGamerTagVisibility(GamerTagId, 8, false)
                SetMpGamerTagVisibility(GamerTagId, 9, true)
            else
                SetMpGamerTagVisibility(GamerTagId, 8, false)
                SetMpGamerTagVisibility(GamerTagId, 9, false)
            end

            SetMpGamerTagVisibility(GamerTagId, 2, IsPlayerTargettingAnything(playerId))
            SetMpGamerTagAlpha(GamerTagId, 2, 255)
            SetMpGamerTagHealthBarColor(GamerTagId, 0)

            SetMpGamerTagColour(GamerTagId, 0, 4)
            SetMpGamerTagColour(GamerTagId, 4, 0)
            SetMpGamerTagAlpha(GamerTagId, 4, 255)
            SetMpGamerTagsUseVehicleBehavior(true)
            SetMpGamerTagsVisibleDistance(100.0)
        end
    end
end)
