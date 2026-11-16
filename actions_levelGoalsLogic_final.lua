-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

bobaFettCreated = {
    params = { timer = 0 },
    action = function(p1_0)

    end
}
bobaFettFlying = {
    params = { timer = 0 },
    action = function(p2_0)
        local r2_0 = gamelua.objects.world[p2_0.name]
        if r2_0 and not gamelua.isLevelEnded() then
            bobaObjDef = gamelua.getObjectDefinition(r2_0.name)
            local r2_1 = gamelua.getAngle(p2_0.name)
            local r2_2, r2_3 = gamelua.vec2Rotate(0, 1, -r2_1)
            local r2_4 = gamelua.normalizeVector(r2_2, r2_3)
            local r2_5 = bobaObjDef.jetPackForce
            if gamelua.checkStillInWorld(p2_0.name) then
                gamelua.applyForce(p2_0.name, r2_5 * r2_4.x, -r2_5 * r2_4.y, r2_0.x, r2_0.y)
                gamelua.setAngularDamping(p2_0.name, 2)
                gamelua.addEventCall("bobaFettFlying", p2_0, 0)
            end
        end
    end
}
bobaFettJointRemoved = {
    params = { timer = 0 },
    action = function(p3_0)
        local r3_0 = gamelua.objects.world[p3_0.name]
        local r3_1 = gamelua.objects.joints[p3_0.jointName]
        if r3_0 and not r3_0.hasCollided and r3_1.breakable then
            bobaObjDef = gamelua.getObjectDefinition(r3_0.name)
            for r3_2, r3_3 in _G.ipairs(gamelua.getJointedObjects(gamelua.objects.joints, p3_0.name)) do
                if r3_3.definition == "BOBA_SPAWNER" or r3_3.definition == "BOBA_SPAWNER_2" then
                    local r3_4 = gamelua.objects.world[r3_3.name]
                    r3_4.loopingParticles = bobaObjDef.loopingParticlesDamaged
                    local r3_5 = gamelua.objects.world[r3_3.name]
                    r3_5.loopingParticlesInteval = bobaObjDef.loopingParticlesDamagedInterval
                end
            end
            if bobaObjDef.collisionSound then
                gamelua.playAudio(bobaObjDef.collisionSound)
            end
            r3_0.hasCollided = true
            gamelua.addEventCall("bobaFettFlying", p3_0, 0)
        end
    end
}
bobaFettLaserCollision = {
    params = { timer = 0 },
    action = function(p4_0)
        gamelua.removeBreakableJointsFromObject(p4_0.name, 999999995904)
    end
}
bobaFettTapped = {
    params = { timer = 0 },
    action = function(p5_0)
        gamelua.fireAction("bobaFettLaserCollision", p5_0)
    end
}
bespinPlatformCreated = {
    params = { timer = 0 },
    action = function(p6_0)
        local r6_0 = gamelua.objects.world[p6_0.name]
    end
}
bespinPlatformLaserCollision = {
    params = { timer = 0 },
    action = function(p7_0)
        if gamelua.objects.world[p7_0.name] then
            gamelua.removeBreakableJointsFromObject(p7_0.name, 999999995904)
        end
    end
}
bespinPlatformTapped = {
    params = { timer = 0 },
    action = function(p8_0)
        gamelua.fireAction("bespinPlatformLaserCollision", p8_0)
    end
}
bespinPlatformJointRemoved = {
    params = { timer = 0 },
    action = function(p9_0)
        local r9_0 = gamelua.objects.world[p9_0.name]
        local r9_1 = gamelua.objects.joints[p9_0.jointName]
        local r9_2 = gamelua.getObjectDefinition(r9_0.name)
        if r9_0 and r9_2 and r9_1.breakable and r9_0.strength > 0 then
            gamelua.setObjectAnimation(r9_0, r9_2, 2)
            gamelua.playAudio("dynamic_platform_damage")
        end
    end
}
bunkerDoorCreated = {
    params = { timer = 0 },
    action = function(p10_0)
        local r10_0 = gamelua.objects.world[p10_0.name]
        r10_0.doorStateChangeTime = gamelua.time
        r10_0.currentDoorState = 1
        r10_0.doorTouchingObjects = {}
        r10_0.ignoreLaserCollision = false
        gamelua.addUpdateCall("updateBunkerDoor", { doorName = r10_0.name }, nil, "updateBunkerDoor " .. p10_0.name)
    end
}
updateBunkerDoor = {
    params = { timer = 0 },
    action = function(p11_0)
        local r11_0 = gamelua.objects.world[p11_0.doorName]
        if r11_0 then
            local r11_1 = gamelua.getObjectDefinition(r11_0.name)
            local r11_2 = r11_1.BUNKER_DOOR_STATES
            if r11_2[r11_0.currentDoorState].time < gamelua.time - r11_0.doorStateChangeTime then
                local r11_3 = r11_0.currentDoorState
                r11_0.currentDoorState = r11_3 + 1
                local r11_4 = r11_0.currentDoorState
                if gamelua.countKeys(r11_2) < r11_4 then
                    r11_0.currentDoorState = 1
                end
                local r11_5 = r11_2[r11_0.currentDoorState]
                gamelua.setSprite(r11_0.name, r11_5.sprite)
                r11_0.doorStateChangeTime = gamelua.time
                if r11_5.entryFunction then
                    gamelua.addEventCall(r11_5.entryFunction, p11_0, 0)
                end
                if r11_5.playSound then
                    gamelua.playAudio(r11_5.playSound)
                end
            end
        end
    end
}
bunkerDoorDestroyed = {
    params = { timer = 0 },
    action = function(p12_0)
        gamelua.removeUpdateCall("updateBunkerDoor" .. p12_0.obj.name)
    end
}
onBunkerDoorOpened = {
    params = { timer = 0 },
    action = function(p13_0)
        gamelua.setCollisionEnabled(p13_0.doorName, false)
        local r13_0 = gamelua.objects.world[p13_0.doorName]
        r13_0.ignoreLaserCollision = true
    end
}
onBunkerDoorClosed = {
    params = { timer = 0 },
    action = function(p14_0)
        gamelua.setCollisionEnabled(p14_0.doorName, true)
        local r14_0 = gamelua.objects.world[p14_0.doorName]
        for r14_1, r14_2 in _G.pairs(r14_0.doorTouchingObjects) do
            if gamelua.checkStillInWorld(r14_2) then
                gamelua.destroyObject(r14_2)
            end
        end
        r14_0.ignoreLaserCollision = false
    end
}
bunkerDoorCollision = {
    params = { timer = 0 },
    action = function(p15_0)
        local r15_0 = gamelua.objects.world[p15_0.name]
        gamelua._G.table.insert(r15_0.doorTouchingObjects, p15_0.other)
    end
}
bunkerDoorEndCollision = {
    params = { timer = 0 },
    action = function(p16_0)
        local r16_0 = gamelua.objects.world[p16_0.name]
        for r16_1, r16_2 in _G.pairs(r16_0.doorTouchingObjects) do
            local r16_3 = r16_2[1]
            local r16_4 = p16_0.other
            if r16_3 == r16_4 then
                gamelua._G.table.remove(r16_0.doorTouchingObjects, r16_1)
            end
        end
    end
}
