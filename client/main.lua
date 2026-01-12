lib.locale()

local function hasWeapon()
    local playerPed = cache.ped
    for _, weapon in ipairs(Config.AllowedWeapons) do
        if GetSelectedPedWeapon(playerPed) == GetHashKey(weapon) then
            return true
        end
    end
    return false
end

local function slashTire(entity, boneName)
    if not hasWeapon() then
        lib.notify({
            title = locale('error_no_weapon_title'),
            description = locale('error_no_weapon_desc'),
            type = Config.NotificationTypes.error
        })
        return
    end

    local success = lib.progressBar({
        duration = Config.Animation.duration,
        label = locale('progress_label'),
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = Config.Animation.dict,
            clip = Config.Animation.anim
        }
    })

    if success then
        local tireIndex = nil

        if boneName == 'wheel_lf' then tireIndex = 0
        elseif boneName == 'wheel_rf' then tireIndex = 1
        elseif boneName == 'wheel_lm' then tireIndex = 2
        elseif boneName == 'wheel_rm' then tireIndex = 3
        elseif boneName == 'wheel_lr' then tireIndex = 4
        elseif boneName == 'wheel_rr' then tireIndex = 5
        end

        if tireIndex then
            if not IsVehicleTyreBurst(entity, tireIndex, false) then
                SetVehicleTyreBurst(entity, tireIndex, true, 1000.0)
                lib.notify({
                    title = locale('success_title'),
                    description = locale('success_desc'),
                    type = Config.NotificationTypes.success
                })
            end
        end
    else
        lib.notify({
            title = locale('error_cancelled_title'),
            description = locale('error_cancelled_desc'),
            type = Config.NotificationTypes.error
        })
    end
end

local bones = {
    'wheel_lf', 'wheel_rf', 'wheel_lm', 'wheel_rm', 'wheel_lr', 'wheel_rr'
}

exports.ox_target:addGlobalVehicle({
    {
        label = locale('target_label'),
        icon = Config.Target.icon,
        distance = Config.Target.distance,
        bones = bones,
        canInteract = function(entity, distance, coords, name, boneId)
            if not hasWeapon() then return false end

            local tireIndex = nil
            if name == 'wheel_lf' then tireIndex = 0
            elseif name == 'wheel_rf' then tireIndex = 1
            elseif name == 'wheel_lm' then tireIndex = 2
            elseif name == 'wheel_rm' then tireIndex = 3
            elseif name == 'wheel_lr' then tireIndex = 4
            elseif name == 'wheel_rr' then tireIndex = 5
            end

            if tireIndex and IsVehicleTyreBurst(entity, tireIndex, false) then
                return false
            end

            return true
        end,
        onSelect = function(data)
            local closestBone = nil
            local minDist = 100.0

            -- Find the closest tire bone to the interaction point
            for _, boneName in ipairs(bones) do
                local boneIndex = GetEntityBoneIndexByName(data.entity, boneName)
                if boneIndex ~= -1 then
                    local boneCoords = GetWorldPositionOfEntityBone(data.entity, boneIndex)
                    local dist = #(data.coords - boneCoords)
                    if dist < minDist then
                        minDist = dist
                        closestBone = boneName
                    end
                end
            end

            if closestBone then
                slashTire(data.entity, closestBone)
            end
        end
    }
})
