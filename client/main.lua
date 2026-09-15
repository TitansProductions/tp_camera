local HAS_CAMERA_VIEW = false 

local CameraHandler = { 
    handler = nil, 
    x = 0.0, 
    y = 0.0, 
    z = 0.0, 
    rotx = 0.0, 
    roty = 0.0, 
    rotz = 0.0,
    zoom = 50.0
}

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    if CameraHandler.handler then
        DestroyCam(CameraHandler.handler, true)
    end

end)

DisplayHelp = function(_message, x, y, w, h, enableShadow, col1, col2, col3, a, centre)

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 5);

	DisplayText(str, x, y)

end

function CheckControls(func, pad, controls)
	if type(controls) == 'number' then
		return func(pad, controls)
	end

	for _, control in ipairs(controls) do
		if func(pad, control) then
			return true
		end
	end

	return false
end

-----------------------------------------------------------
--[[ Commands ]]--
-----------------------------------------------------------

RegisterCommand('cameraview', function()
    HAS_CAMERA_VIEW = not HAS_CAMERA_VIEW

    if HAS_CAMERA_VIEW then 
        
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())

        local handler = CreateCamWithParams(
            "DEFAULT_SCRIPTED_CAMERA",
            coords.x,
            coords.y,
            coords.z + 1.0,
            0.0,
            0.0,
            heading,
            CameraHandler.zoom,
            false,
            2
        )

        SetCamActive(handler, true)
        RenderScriptCams(true, false, 0, true, true, 0)
        
        CameraHandler.handler = handler 
        CameraHandler.x = coords.x
        CameraHandler.y = coords.y
        CameraHandler.z = coords.z + 1.0
        CameraHandler.rotx = 0.0
        CameraHandler.roty = 0.0
        CameraHandler.rotz = heading

        Citizen.CreateThread(function()
    
            while true do 
                Wait(0)

                if not HAS_CAMERA_VIEW then 
                    TaskStandStill(PlayerPedId(), 1)
                    
                    if CameraHandler.handler then
                        DestroyCam(CameraHandler.handler, true)
                    end
            
                    CameraHandler = { 
                        handler = nil, 
                        x = 0.0, 
                        y = 0.0, 
                        z = 0.0, 
                        rotx = 0.0, 
                        roty = 0.0, 
                        rotz = 0.0,
                        zoom = 50.0
                    }
            
                    DisplayRadar(true)
                    break
                end
                
                TaskStandStill(PlayerPedId(), -1)
                DisplayRadar(false)

                local heretext = string.format(
                    "{ x = %.3f, y = %.3f, z = %.3f, rotx = %.3f, roty = %.3f, rotz = %.3f, fov = %.1f }\nExecute /copycamera to copy the coordinates",
                    CameraHandler.x,
                    CameraHandler.y,
                    CameraHandler.z,
                    CameraHandler.rotx,
                    CameraHandler.roty,
                    CameraHandler.rotz,
                    CameraHandler.zoom
                )
                
                DisplayHelp(
                    heretext,
                    0.50,
                    0.90,
                    0.4,
                    0.4,
                    true,
                    255,
                    255,
                    255,
                    255,
                    true
                )

                -------------------------------------------------------
                -- CAMERA MOVEMENT
                -------------------------------------------------------

                local speed = 0.1

                -- W - Forward
                if CheckControls(IsDisabledControlPressed, 0, `INPUT_MOVE_UP_ONLY`) then
                    local rad = math.rad(CameraHandler.rotz)

                    CameraHandler.x = CameraHandler.x - math.sin(rad) * speed
                    CameraHandler.y = CameraHandler.y + math.cos(rad) * speed
                end

                -- S - Backward
                if CheckControls(IsDisabledControlPressed, 0, `INPUT_MOVE_DOWN_ONLY`) then
                    local rad = math.rad(CameraHandler.rotz)

                    CameraHandler.x = CameraHandler.x + math.sin(rad) * speed
                    CameraHandler.y = CameraHandler.y - math.cos(rad) * speed
                end

                -- A - Left
                if CheckControls(IsDisabledControlPressed, 0, `INPUT_MOVE_LEFT_ONLY`) then
                    local rad = math.rad(CameraHandler.rotz + 90.0)

                    CameraHandler.x = CameraHandler.x - math.sin(rad) * speed
                    CameraHandler.y = CameraHandler.y + math.cos(rad) * speed
                end

                -- D - Right
                if CheckControls(IsDisabledControlPressed, 0, `INPUT_MOVE_RIGHT_ONLY`) then
                    local rad = math.rad(CameraHandler.rotz - 90.0)

                    CameraHandler.x = CameraHandler.x - math.sin(rad) * speed
                    CameraHandler.y = CameraHandler.y + math.cos(rad) * speed
                end

                -- SPACE - Down
                if CheckControls(IsDisabledControlPressed, 0, `INPUT_SPRINT`) then
                    CameraHandler.z = CameraHandler.z - speed
                end

                -- SHIFT - Up
                if CheckControls(IsDisabledControlPressed, 0, `INPUT_JUMP`) then
                    CameraHandler.z = CameraHandler.z + speed
                end

                -------------------------------------------------------
                -- MOUSE CAMERA ROTATION
                -------------------------------------------------------

                local axisX = GetDisabledControlNormal(
                    0,
                    `INPUT_LOOK_LR`
                )

                local axisY = GetDisabledControlNormal(
                    0,
                    `INPUT_LOOK_UD`
                )

                if axisX ~= 0.0 or axisY ~= 0.0 then

                    -- Mouse left/right
                    CameraHandler.rotz = CameraHandler.rotz
                        + axisX * -1.0 * 5.0

                    -- Mouse up/down
                    CameraHandler.rotx = math.max(
                        math.min(
                            89.9,
                            CameraHandler.rotx
                                + axisY * -1.0 * 5.0
                        ),
                        -89.9
                    )
                end

                -------------------------------------------------------
                -- APPLY CAMERA
                -------------------------------------------------------

                SetCamCoord(
                    CameraHandler.handler,
                    CameraHandler.x,
                    CameraHandler.y,
                    CameraHandler.z
                )

                SetCamRot(
                    CameraHandler.handler,
                    CameraHandler.rotx,
                    CameraHandler.roty,
                    CameraHandler.rotz,
                    2
                )
                
            end
        
        end)

    end

end)


RegisterCommand('copycamera', function()
    if not HAS_CAMERA_VIEW then
        print('[Camera] Camera view is not active.')
        return
    end

    local cameraData = string.format(
        "{ x = %.3f, y = %.3f, z = %.3f, rotx = %.3f, roty = %.3f, rotz = %.3f, fov = %.1f }",
        CameraHandler.x,
        CameraHandler.y,
        CameraHandler.z,
        CameraHandler.rotx,
        CameraHandler.roty,
        CameraHandler.rotz,
        CameraHandler.zoom
    )

    print('[Camera] Opening copy camera NUI')
    print('[Camera] ' .. cameraData)

    SetNuiFocus(true, true)

    SendNUIMessage({
        action = 'open_copycamera',
        cameraData = cameraData
    })
end)

RegisterNUICallback('copycamera_close', function(data, cb)
    SetNuiFocus(false, false)

    cb('ok')
end)
