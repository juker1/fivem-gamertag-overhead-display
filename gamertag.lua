CreateThread(function()
    local gamerTags = {}

    while true do
        Wait(0)
        for _, p in ipairs(GetActivePlayers()) do
            local CurrentPlayer = PlayerId()
            local ped = GetPlayerPed(p)
            local WantedLevel = GetPlayerWantedLevel(p)
            local CurrentVehicle = GetVehiclePedIsIn(ped)

            if p ~= CurrentPlayer and NetworkIsPlayerActive(CurrentPlayer) then
					
                    if not IsMpGamerTagActive(gamerTags[p]) then
                        gamerTag = CreateFakeMpGamerTag(ped, GetPlayerName(p), false, false, "", 0)
                    end

                    SetMpGamerTagVisibility(gamerTags[p], 2, IsPlayerTargettingEntity(CurrentPlayer, ped))
                    SetMpGamerTagVisibility(gamerTags[p], 4, NetworkIsPlayerTalking(p))

                    -- Wanted Level
                    if WantedLevel > 0 then
                        SetMpGamerTagVisibility(gamerTags[p], 7, true)
                        SetMpGamerTagWantedLevel(gamerTags[p], WantedLevel)
                    else
                        SetMpGamerTagVisibility(gamerTags[p], 7, false)
                    end

                    -- Driver / Passenger
                    if IsPedSittingInVehicle(ped, CurrentVehicle) and GetPedInVehicleSeat(CurrentVehicle, -1) == ped then
                        SetMpGamerTagVisibility(gamerTags[p], 8, true)
                        SetMpGamerTagVisibility(gamerTags[p], 9, false)
                    elseif IsPedSittingInVehicle(ped, CurrentVehicle) and GetPedInVehicleSeat(CurrentVehicle, 0) == ped then
                        SetMpGamerTagVisibility(gamerTags[p], 8, false)
                        SetMpGamerTagVisibility(gamerTags[p], 9, true)
                    else
                        SetMpGamerTagVisibility(gamerTags[p], 8, false)
                        SetMpGamerTagVisibility(gamerTags[p], 9, false)
                    end

                    SetMpGamerTagAlpha(gamerTags[p], 2, 255)
                    SetMpGamerTagHealthBarColor(gamerTags[p], 0)

                    SetMpGamerTagColour(gamerTags[p], 0, 0)
                    SetMpGamerTagColour(gamerTags[p], 4, 0)
                    SetMpGamerTagAlpha(gamerTags[p], 4, 255)
                    SetMpGamerTagsUseVehicleBehavior(true)

                    gamerTags[p] = gamerTag
            end
        end
    end
end)
