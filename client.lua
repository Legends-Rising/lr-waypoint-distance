local config = {
  -- Display settings
  font = 1,
  scale = 0.5,
  posX = 0.150,  -- Position under minimap (left side)
  posY = 0.90,   -- Bottom left area
  
  -- Colors (R, G, B, A)
  userWaypointColor = {255, 0, 0, 255}, -- Red
  missionWaypointColor = {255, 255, 0, 255}, -- Yellow
  
  -- Distance units: 1 = meters, 2 = kilometers, 3 = miles
  distanceUnit = 1,
  
  -- Always show distance
  alwaysShow = true,
  
  -- Performance optimization
  updateInterval = 500  -- Update distance every 500ms instead of every frame
}

-- Cache variables
local lastDistance = 0
local displayText = ""
local lastUpdate = 0

-- Function to convert distance based on unit
local function FormatDistance(distance)
  if config.distanceUnit == 1 then
      return string.format("%.0fm", distance)
  elseif config.distanceUnit == 2 then
      return string.format("%.1fkm", distance / 1000)
  elseif config.distanceUnit == 3 then
      return string.format("%.1fmi", distance * 0.000621371)
  end
  return string.format("%.0fm", distance)
end

-- Function to draw text on screen
local function DrawText3D(text, r, g, b, a)
  SetTextScale(config.scale, config.scale)
  SetTextColor(r, g, b, a)
  SetTextCentre(false)
  SetTextDropshadow(2, 0, 0, 0, 255)
  SetTextFontForCurrentCommand(config.font)
  
  local str = CreateVarString(10, "LITERAL_STRING", text)
  DisplayText(str, config.posX, config.posY)
end

-- Function to check if waypoint is active using correct native
local function IsWaypointActive()
  return Citizen.InvokeNative(0x202B1BBFC6AB5EE4, Citizen.ResultAsInteger()) == 1
end

-- Function to get waypoint coordinates using correct native
local function GetWaypointCoords()
  return Citizen.InvokeNative(0x29B30D07C3F7873B, Citizen.ResultAsVector())
end

-- Distance calculation thread (runs every 500ms)
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(config.updateInterval)
      
      if IsWaypointActive() then
          local playerPed = PlayerPedId()
          local playerCoords = GetEntityCoords(playerPed)
          local waypointCoords = GetWaypointCoords()
          
          if waypointCoords then
              local distance = #(vector2(playerCoords.x, playerCoords.y) - vector2(waypointCoords.x, waypointCoords.y))
              lastDistance = distance
              displayText = FormatDistance(distance)
          end
      else
          displayText = ""
      end
  end
end)

-- Render thread (only draws when needed)
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      
      if displayText ~= "" then
          local shouldDisplay = config.alwaysShow
          
          if not config.alwaysShow then
              if IsPlayerFreeAiming(PlayerId()) then
                  local playerPed = PlayerPedId()
                  local weapon = Citizen.InvokeNative(0x3A87E44BB9A01D54, playerPed, true, 0, false)
                  shouldDisplay = weapon == GetHashKey("WEAPON_SNIPERRIFLE_CARCANO") or
                                 weapon == GetHashKey("WEAPON_SNIPERRIFLE_ROLLINGBLOCK") or
                                 weapon == GetHashKey("WEAPON_RIFLE_BOLTACTION")
              end
          end
          
          if shouldDisplay then
              DrawText3D(displayText, config.userWaypointColor[1], config.userWaypointColor[2], 
                        config.userWaypointColor[3], config.userWaypointColor[4])
          end
      else
          Citizen.Wait(500)  -- Sleep longer when no waypoint
      end
  end
end)

-- Toggle always show
RegisterCommand('toggledistance', function()
  config.alwaysShow = not config.alwaysShow
  print("Waypoint distance display: " .. (config.alwaysShow and "Always ON" or "Only when aiming"))
end, false)

-- Change distance unit
RegisterCommand('distanceunit', function(source, args)
  if not args[1] then
      print("Usage: /distanceunit [1=meters, 2=kilometers, 3=miles]")
      print("Current unit: " .. (config.distanceUnit == 1 and "meters" or config.distanceUnit == 2 and "kilometers" or "miles"))
      return
  end
  
  local unit = tonumber(args[1])
  if unit and unit >= 1 and unit <= 3 then
      config.distanceUnit = unit
      local unitName = unit == 1 and "meters" or unit == 2 and "kilometers" or "miles"
      print("Distance unit changed to: " .. unitName)
      -- Recalculate display text immediately
      if lastDistance > 0 then
          displayText = FormatDistance(lastDistance)
      end
  else
      print("Invalid unit. Usage: /distanceunit [1=meters, 2=kilometers, 3=miles]")
  end

end, false)
