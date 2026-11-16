-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

-- line 1-36
-- proto#1 params=0 locals=0 upvalues=0 vararg=false
function Initialize()
    setPosition = gamelua.setPosition
    setVelocity = gamelua.setVelocity
    applyImpulse = gamelua.applyImpulse
    applyForce = gamelua.applyForce
    addParticles = gamelua.addParticles
    addEventCall = gamelua.addEventCall
    playAudio = gamelua.playAudio
    destroyObject = gamelua.destroyObject
    getForwardV = gamelua.getForwardV
    getUpV = gamelua.getUpV
    getStartingForwardV = gamelua.getStartingForwardV
    getStartingUpV = gamelua.getStartingUpV
    createObject = gamelua.createObject
    getObjectsInWorld = gamelua.getObjectsInWorld
    attachEventListener = gamelua.attachEventListener
    checkStillInWorld = gamelua.checkStillInWorld
    addScore = gamelua.addScore
    setRotation = gamelua.setRotation
    setSprite = gamelua.setSprite
    getObjectDefinition = gamelua.getObjectDefinition
    setActive = gamelua.setActive
    getAudioName = gamelua.getAudioName
    removeBird = gamelua.removeBird
    setAnimation = gamelua.setAnimation
    physicsScale = gamelua.physicsScale
    addPuffToTrajectory = gamelua.addPuffToTrajectory
    vNormalize = gamelua.vNormalize
    physicsToWorldTransform = gamelua.physicsToWorldTransform
    makeExplosion = gamelua.makeExplosion
    setCameraTarget = gamelua.setCameraTarget
    vLength = gamelua.vLength
    setObjectParameter = gamelua.setObjectParameter
    putParticles = gamelua.putParticles
    addUpdateCall = gamelua.addUpdateCall
end

birdExitGravitationArea = {
    params = { timer = 0 },
    action = function(p2_0)
        local r2_0 = gamelua.objects.world[p2_0.name]
        local r2_1 = gamelua.objects.world[p2_0.other]
        if r2_0 ~= nil and r2_1 ~= nil and r2_1.sensorType == "gravitation" then
            if r2_0.numGravitationAreas == nil then
                r2_0.enteredGravitationArea = false
            else
                local r2_2 = r2_0.numGravitationAreas
                r2_0.numGravitationAreas = r2_2 - 1
                if r2_0.numGravitationAreas == 0 then
                    if r2_0.startedOutsideAtmosphere and not gamelua.getLevelMetadata(gamelua.levelName).objectsDestroyableByTap then
                        gamelua.SettingsWrapper:increaseBirdsExitedGravity()
                    end
                    r2_0.numGravitationAreas = nil
                    r2_0.enteredGravitationArea = false
                end
            end
        end
    end
}
count2GravityTimer = {
    params = { timer = 0 },
    action = function(p3_0)
        local r3_0 = gamelua.objects.world[p3_0.name]
        if r3_0 ~= nil then
            if r3_0.numGravitationAreas == nil then
                r3_0.timeIn2Gravities = nil
            else
                local r3_1 = r3_0.numGravitationAreas
                if r3_1 > 1 then
                    if r3_0.timeIn2Gravities == nil then
                        r3_0.timeIn2Gravities = p3_0.dt
                    else
                        r3_0.timeIn2Gravities = r3_0.timeIn2Gravities + p3_0.dt
                    end
                    addEventCall("count2GravityTimer", p3_0)
                else
                    r3_0.timeIn2Gravities = nil
                end
            end
        end
    end
}
birdEnteredGraviationArea = {
    params = { timer = 0 },
    action = function(p4_0)
        local r4_0 = gamelua.objects.world[p4_0.name]
        local r4_1 = gamelua.objects.world[p4_0.other]
        if r4_0 ~= nil and r4_1 ~= nil and r4_1.sensorType == "gravitation" and r4_1.active then
            if r4_0.enteredGravitationArea then
                if r4_0.numGravitationAreas == nil then
                    r4_0.numGravitationAreas = 2
                else
                    local r4_2 = r4_0.numGravitationAreas
                    r4_0.numGravitationAreas = r4_2 + 1
                end
                if r4_0.numGravitationAreas == 2 then
                    addEventCall("count2GravityTimer", p4_0)
                end
            else
                if gamelua.flyingBird ~= nil and r4_0.name == gamelua.flyingBird.name and gamelua.flyingBird.startCheckingGravityTriggers then
                    local r4_3 = gamelua.blockTable.blocks[r4_0.definition]
                    local r4_4 = r4_3.enterGravitationParticles
                    putParticles({ objectName = p4_0.name, particles = r4_4, amount = 10 })
                    playAudio("enter_atmosphere")
                    r4_0.startedOutsideAtmosphere = true
                end
                r4_0.numGravitationAreas = 1
                r4_0.enteredGravitationArea = true
            end
        end
    end
}
birdTailParticlesUpdate = {
    params = { timer = 0 },
    action = function(p5_0)
        local r5_0 = gamelua.objects.world[p5_0.name]
        if r5_0 ~= nil and r5_0.shot and not r5_0.hasCollided then
            if r5_0.startCheckingGravityTriggers == nil then
                r5_0.startCheckingGravityTriggers = true
            end
            if r5_0.ignoreTrailParticles then
                return
            end
            local r5_1
            if r5_0.enteredGravitationArea then
                local r5_2 = gamelua.blockTable.blocks[r5_0.definition]
                r5_1 = r5_2.atmosphereTailParticles
            else
                local r5_3 = gamelua.blockTable.blocks[r5_0.definition]
                r5_1 = r5_3.normalTailParticles
            end
            local r5_4
            if r5_0.usePowerupParticles then
                local r5_5 = gamelua.blockTable.blocks[r5_0.definition]
                r5_4 = r5_5.powerupParticles
            else
                r5_4 = r5_1
            end
            if r5_4 ~= nil then
                local r5_6 = gamelua.particleTable.particles[r5_4].amount or 1
                local r5_7 = 0.01666666753590107
                p5_0.leftOverTime = p5_0.leftOverTime and p5_0.leftOverTime + p5_0.dt or p5_0.dt
                while p5_0.leftOverTime >= r5_7 do
                    local r5_8 = p5_0.leftOverTime
                    p5_0.leftOverTime = r5_8 - r5_7
                    putParticles({ objectName = p5_0.name, particles = r5_4, amount = r5_6 })
                end
            end
            addEventCall("birdTailParticlesUpdate", p5_0)
        end
    end
}
useBoostSpecialty = {
    params = { timer = 0 },
    action = function(p6_0)
        local r6_0 = p6_0.specialty
        if r6_0 == "DRILL" then
            setAnimation(flyingBird.name, "DrillAnim")
        end
        local r6_1 = gamelua.objects.world[p6_0.name]
        local r6_2 = gamelua.blockTable
        local r6_3 = gamelua.boostForce * 1.25 * 2.5 * physicsScale * r6_1.mass
        if r6_0 == "LAZER_SHOT" then
            gamelua.SettingsWrapper:markTutorialShown(r6_1.name)
            r6_1.ignoreTrailParticles = true
            local r6_4 = vNormalize
            local r6_5 = gamelua.cursorPhysics.x
            local r6_6 = r6_1.x
            local r6_7 = r6_5 - r6_6
            local r6_8 = gamelua.cursorPhysics.y
            local r6_9 = r6_1.y
            local r6_10, r6_11 = r6_4(r6_7, r6_8 - r6_9)
            local r6_12 = r6_11
            local r6_13 = r6_10
            local r6_14 = r6_3 * 4
            r6_1.boostAim = {
                sprite = "RETICLE_1",
                x = gamelua.cursorPhysics.x,
                y = gamelua.cursorPhysics.y
            }
            r6_1.laserField = { x = r6_1.x, y = r6_1.y, scale = 1, time = 0 }
            r6_1.laserBoost = {
                force = r6_14,
                x = -r6_13,
                y = -r6_12,
                timer = 0.10000000149011612,
                posX = r6_1.x,
                posY = r6_1.y
            }
            setVelocity(r6_1.name, 0, 0)
            local r6_15 = r6_2.blocks[r6_1.definition]
            playAudio(r6_15.sounds.special)
        else
            local r6_16, r6_17 = vNormalize(r6_1.xVel, r6_1.yVel)
            local r6_18 = r6_17
            local r6_19 = r6_16
            setVelocity(r6_1.name, 0, 0)
            applyImpulse(r6_1.name, -r6_19 * r6_3, -r6_18 * r6_3, r6_1.x, r6_1.y)
            local r6_20 = r6_2.blocks[r6_1.definition]
            playAudio(r6_20.sounds.special)
            local r6_21 = gamelua.objects.world[r6_1.name]
            local r6_22 = getObjectDefinition(r6_1.name)
            r6_21.sprite = r6_22.sprites.action
            local r6_23 = gamelua.objects.world[r6_1.name]
            setSprite(r6_1.name, r6_23.sprite)
            local r6_24, r6_25 = physicsToWorldTransform(r6_1.x, r6_1.y)
            addPuffToTrajectory(1, r6_24, r6_25)
        end
        local r6_26 = gamelua.objects.world[r6_1.name]
        r6_26.ignoreGravityTimer = 10
        gamelua.enableGravityForBird(r6_1.name, false)
    end
}
useSwordSpecialty = {
    params = { timer = 0 },
    action = function(p7_0)
        gamelua.print("CREATING SWORD for bird " .. p7_0.name)
        local r7_0 = gamelua.objects.world[p7_0.name]
        r7_0.swordActive = true
        local r7_1 = gamelua.blockTable.blocks[r7_0.definition]
        local r7_2 = r7_0.angle - 2.5
        local r7_3 = gamelua.blockTable.blocks[r7_1.specialtyObject]
        local r7_4 = r7_3.swordMinScale
        local r7_5 = gamelua.worldToPhysicsTransform
        local r7_6 = gamelua._G.res.getSpriteBounds
        local r7_7, r7_8 = r7_5(r7_6(r7_3.sprite))
        local r7_9 = r7_7 * r7_4
        local r7_10 = createObject(gamelua.blockTable, r7_1.specialtyObject, "SWORD_" .. p7_0.name, r7_0.x, r7_0.y, r7_3.radius, r7_3.width, r7_3.height, r7_4, r7_4, r7_3.vertices)
        gamelua.activateBulletTime(0.20000000298023224, 0.5, 1, 0.20000000298023224)
        setObjectParameter(r7_10, 21, 6)
        local r7_11 = gamelua.objects
        local r7_12 = r7_11.world[r7_10]
        r7_12.angle = r7_2
        r7_12.scaleX = r7_4
        r7_12.scaleY = r7_4
        setRotation(r7_12.name, r7_12.angle)
        r7_12.life = r7_3.swordDuration
        r7_12.parent = r7_0
        r7_12.swordTouchingObjects = {}
        addUpdateCall("updateSword", { name = r7_10 }, nil, "swordUpdater_" .. r7_10)
        playAudio(r7_1.sounds.special)
    end
}
updateSword = {
    params = { timer = 0 },
    action = function(p8_0)
        local r8_0 = gamelua.objects.world[p8_0.name]
        if r8_0 ~= nil then
            local r8_1 = gamelua.blockTable.blocks[r8_0.definition]
            for r8_2, r8_3 in _G.pairs(r8_0.swordTouchingObjects) do
                local r8_4 = gamelua.objects.world[r8_3[1]]
                local r8_5 = r8_3[2]
                if r8_4.strength ~= 0 then
                    local r8_6 = r8_4.strength
                    local r8_7 = r8_4.strength
                    r8_4.strength = r8_7 - r8_5
                    r8_3[2] = 0
                    if r8_4.strength <= 0 then
                        gamelua.destroyObject(r8_3[1])
                        gamelua.SettingsWrapper:blockDestroyedBySword()
                        local r8_8 = { "Jedi Initiate", "Jedi Knight", "Jedi Master" }
                        for r8_9, r8_10 in _G.ipairs(r8_8) do
                            local r8_11 = gamelua.SettingsWrapper.getNumBlocksDestroyedBySword()
                            if gamelua.getAchievementLimit(r8_10) <= r8_11 then
                                gamelua.registerAchievement(r8_10)
                            end
                        end
                    else
                        gamelua.createDamageParticles(r8_4, gamelua.blockTable.blocks, r8_6)
                        gamelua.updateDamageSprite(r8_4)
                    end
                end
            end
            if r8_0.life then
                local r8_12 = gamelua.getDeltaTimeMultiplier()
                r8_0.life = r8_0.life - p8_0.dt / r8_12
                local r8_13 = gamelua.getDeltaTimeMultiplier()
                r8_0.angle = r8_0.angle + r8_1.swordAngleSpeed * (p8_0.dt / r8_13)
                local r8_14 = r8_1.swordDuration / 2
                local r8_15 = gamelua._G.math.abs(r8_14 - r8_0.life)
                r8_0.scaleX = r8_1.swordMaxScale - r8_15 / (r8_1.swordDuration / 2) * (r8_1.swordMaxScale - r8_1.swordMinScale)
                r8_0.scaleY = r8_0.scaleX
                gamelua.setScale(r8_0.name, r8_0.scaleX, r8_0.scaleY)
                setRotation(r8_0.name, r8_0.angle)
                if r8_0.parent then
                    local r8_16 = physicsToWorldTransform
                    local r8_17 = r8_0.parent.x
                    local r8_18 = r8_0.parent
                    local r8_19, r8_20 = r8_16(r8_17, r8_18.y)
                    local r8_21, r8_22 = r8_1.particlesTrail, r8_1.particlesTrailTimer
                    if r8_21 and r8_22 then
                        if not r8_0.trailTimer then
                            r8_0.trailTimer = 0
                        end
                        local r8_23 = gamelua.getDeltaTimeMultiplier()
                        r8_0.trailTimer = r8_0.trailTimer + p8_0.dt / r8_23
                        local r8_24 = r8_0.trailTimer
                        if r8_22 <= r8_24 then
                            local r8_25 = r8_0.trailTimer
                            r8_0.trailTimer = r8_25 - r8_22
                            gamelua.putParticles({
                                particles = r8_21,
                                amount = 1,
                                worldX = r8_19,
                                worldY = r8_20,
                                angle = gamelua.getAngle(r8_0.name),
                                minScaleBegin = r8_0.scaleX,
                                maxScaleBegin = r8_0.scaleX,
                                minScaleEnd = r8_0.scaleX,
                                maxScaleEnd = r8_0.scaleX
                            })
                        end
                    end
                    local r8_26 = gamelua.worldToPhysicsTransform
                    local r8_27 = gamelua._G.res.getSpriteBounds
                    local r8_28, r8_29 = r8_26(r8_27(r8_0.sprite))
                    local r8_30 = r8_0.scaleX
                    local r8_31 = r8_28 * r8_30
                    r8_0.x = r8_0.parent.x
                    r8_0.y = r8_0.parent.y
                    setPosition(p8_0.name, r8_0.x, r8_0.y)
                end
                if r8_0.life < 0 then
                    gamelua.print("REMOVING ITEM")
                    destroyObject(p8_0.name, true)
                    gamelua.removeUpdateCall("swordUpdater_" .. r8_0.name)
                    if r8_0.parent then
                        r8_0.parent.swordActive = nil
                    end
                end
            end
        end
    end
}
useBombSpecialty = {
    params = { timer = 0 },
    action = function(p9_0)
        if checkStillInWorld(p9_0.name) then
            local r9_0 = gamelua.blockTable
            local r9_1 = gamelua.objects.world[p9_0.name]
            local r9_2 = nil
            local r9_3 = r9_0.blocks[r9_1.definition]
            local r9_4
            if r9_3.sounds == nil then
                r9_4 = r9_2
            else
                local r9_5 = r9_0.blocks[r9_1.definition]
                r9_4 = r9_5.sounds.special
            end
            local r9_6 = r9_0.blocks[r9_1.definition]
            playAudio(r9_6.sounds.special)
            gamelua.activateBulletTime(0.10000000149011612, 0.800000011920929, 0.6000000238418579, 0.20000000298023224)
            gamelua.SettingsWrapper:markTutorialShown(r9_1.name)
            makeExplosion(r9_1, getObjectDefinition(r9_1.name), r9_4)
            if r9_1.insideWater and r9_1.freezeBomb then
                local r9_7 = createObject(gamelua.blockTable, "BLOCK_ASTEROID_ICE_1", "WATER_BOMB", r9_1.x, r9_1.y)
                local r9_8, r9_9 = vNormalize(r9_1.xVel, r9_1.yVel)
                setVelocity(r9_7, r9_1.xVel, r9_1.yVel)
            end
            local r9_10 = gamelua.objects.castleCameraData[gamelua.deviceModel]
            local r9_11 = gamelua.objects.birdCameraData[gamelua.deviceModel]
            local r9_12, r9_13 = gamelua.worldToPhysicsTransform(r9_10.px, r9_10.py)
            local r9_14, r9_15 = gamelua.worldToPhysicsTransform(r9_11.px, r9_11.py)
            local r9_16 = { x = r9_12 - r9_14, y = r9_13 - r9_15 }
            local r9_17 = { x = r9_12 - r9_1.x, y = r9_13 - r9_1.y }
            local r9_18 = gamelua.vLength(r9_17.x, r9_17.y)
            local r9_19 = gamelua.vLength(r9_16.x, r9_16.y) * 2
            if r9_18 < r9_19 then
                local r9_20, r9_21 = vNormalize(r9_17.x, r9_17.y)
                r9_17.y = r9_21
                r9_17.x = r9_20
                gamelua.cameraTargetObject = {
                    x = r9_1.x,
                    y = r9_1.y,
                    xVel = r9_17.x * 15,
                    yVel = r9_17.y * 15
                }
                gamelua.usingCameraDummy = true
                local r9_22 = { dest = { x = r9_12 - r9_17.x, y = r9_13 - r9_17.y } }
                addEventCall("moveDummyObjectToDestination", r9_22, 0)
            else
                gamelua.setCameraTargetObject(nil)
            end
        end
    end
}
activatePinkBirdAntigravity = {
    params = { timer = 0 },
    action = function(p10_0)
        local r10_0 = gamelua.objects.world[p10_0.name]
        if r10_0 then
            local r10_1 = gamelua.blockTable.blocks[r10_0.definition]
            for r10_2, r10_3 in _G.pairs(gamelua.objects.world) do
                if r10_3.reticleName then
                    local r10_4 = r10_3.reticleName
                    local r10_5 = p10_0.name
                    if r10_4 == r10_5 then
                        gamelua.setSleeping(r10_3.name, false)
                        if gamelua.objects.worldGravity or r10_3.insideGravity then
                            gamelua.setRevertGravityWithMultiplier(r10_3.name, true, r10_1.specialtySpaceGravityMultiplier, r10_1.specialtyMaximumVelocity)
                        end
                        r10_3.specialtyClassicGravityMultiplier = r10_1.specialtyClassicGravityMultiplier
                        r10_3.specialtyMaximumVelocity = r10_1.specialtyMaximumVelocity
                        r10_3.bubbleAntiGravityTimer = r10_1.specialtyDuration
                        local r10_6 = r10_3.y
                        local r10_7 = r10_0.y
                        local r10_8 = r10_6 - r10_7
                        local r10_9 = _G.math.atan2(r10_8, r10_3.x - r10_0.x)
                        local r10_10 = r10_1.specialtyStartImpulse
                        local r10_11 = _G.math.cos(r10_9)
                        local r10_12 = r10_10 * r10_11
                        local r10_13 = r10_1.specialtyStartImpulse
                        local r10_14 = _G.math.sin(r10_9)
                        local r10_15 = r10_13 * r10_14
                        gamelua.removeBreakableJointsFromObject(r10_3.name, _G.math.abs(r10_1.specialtyStartImpulse))
                        applyImpulse(r10_3.name, r10_12 * r10_3.mass, r10_15 * r10_3.mass, r10_3.x, r10_3.y)
                        local r10_16 = getObjectDefinition(r10_3.name)
                        if r10_16.onLeiaForcePull then
                            gamelua.fireAction(r10_16.onLeiaForcePull, { name = r10_3.name })
                        end
                        gamelua.SettingsWrapper:blockLiftedByLeia()
                        local r10_17 = gamelua.SettingsWrapper.getNumBlocksLiftedByLeia()
                        if gamelua.getAchievementLimit("Fatal Attraction") <= r10_17 then
                            gamelua.registerAchievement("Fatal Attraction")
                        end
                    end
                end
            end
        end
    end
}
showPinkBirdParticles = {
    params = { timer = 0 },
    action = function(p11_0)
        gamelua.putParticles({
            x = p11_0.position.x,
            y = p11_0.position.y,
            particles = p11_0.position.particles
        })
    end
}
usePinkBirdSpecialty = {
    params = { timer = 0 },
    action = function(p12_0)
        gamelua.activateBulletTime(0.10000000149011612, 1.2000000476837158, 0.4000000059604645, 0.30000001192092896)
        local r12_0 = gamelua.objects.world[p12_0.name]
        local r12_1 = gamelua.blockTable.blocks[r12_0.definition]
        addEventCall("activatePinkBirdAntigravity", p12_0, r12_1.specialtyBeamPhase1Time + r12_1.specialtyBeamPhase2Time)
        local r12_2 = gamelua.blockTable.blocks[r12_0.definition]
        playAudio(r12_2.sounds.special)
        local r12_3 = gamelua.blockTable.blocks[r12_0.definition]
        playAudio(r12_3.sounds.special_loop)
        local r12_4 = p12_0.xPos
        local r12_5 = p12_0.yPos
        local r12_6 = r12_0.x
        local r12_7 = r12_4 - r12_6
        local r12_8 = r12_0.y
        local r12_9 = r12_5 - r12_8
        local r12_10 = _G.math.atan2(r12_9, r12_7)
        local r12_11 = gamelua.levelRightEdgePhysics
        local r12_12 = gamelua.levelLeftEdgePhysics
        local r12_13 = r12_11 - r12_12
        local r12_14 = gamelua.levelBottomEdgePhysics
        local r12_15 = gamelua.levelTopEdgePhysics
        local r12_16 = r12_14 - r12_15
        local r12_17 = gamelua.distance(0, 0, r12_13, r12_16)
        local r12_18 = r12_0.x
        local r12_19 = _G.math.cos(r12_10)
        local r12_20 = r12_18 + r12_19 * r12_17
        local r12_21 = r12_0.y
        local r12_22 = _G.math.sin(r12_10)
        local r12_23 = r12_21 + r12_22 * r12_17
        local r12_24 = gamelua.getRayCastedObjects
        local r12_25 = { x1 = r12_0.x, y1 = r12_0.y, x2 = r12_20, y2 = r12_23, source = p12_0.name }
        local r12_26 = r12_24(r12_25)
        local r12_27 = false
        if r12_26[1] then
            local r12_28 = {}
            for r12_29 = 1, #r12_26, 6 do
                local r12_30 = gamelua.objects.world[r12_26[r12_29]]
                r12_30.rayCastFraction = r12_26[r12_29 + 5]
                r12_30.rayCastContactX = r12_26[r12_29 + 1]
                r12_30.rayCastContactY = r12_26[r12_29 + 2]
                local r12_31 = r12_30.name
                local r12_32 = p12_0.name
                if r12_31 ~= r12_32 then
                    local r12_33 = getObjectDefinition(r12_30.name)
                    if not r12_33.ignoreLeiaForce then
                        _G.table.insert(r12_28, r12_30)
                    end
                end
            end
            if r12_28[1] then
                r12_27 = true
                _G.table.sort(r12_28, function(p13_0, p13_1)
                    local r13_0 = p13_0.rayCastFraction
                    local r13_1 = p13_1.rayCastFraction
                    return r13_0 < r13_1
                end)
                local r12_34 = r12_28[1]
                local r12_35 = r12_34.rayCastContactX
                r12_23 = r12_28[1].rayCastContactY
                local r12_36 = gamelua.objects.world[r12_28[1].name]
                r12_36.bubblePrimaryTarget = true
                local r12_37 = gamelua.objects.world[r12_28[1].name]
                r12_37.bubbleBeamTimer = r12_1.specialtyBeamPhase1Time
                local r12_38 = gamelua.objects.world[r12_28[1].name]
                r12_38.bubbleBeamPhase = 1
                local r12_39 = gamelua.objects.world[r12_28[1].name]
                r12_39.bubbleBeamAnimationTimer = 0
                local r12_40 = gamelua.objects.world[r12_28[1].name]
                r12_40.bubbleBeamAnimationFrame = 1
                local r12_41 = gamelua.objects.world[r12_28[1].name]
                r12_41.reticleName = p12_0.name
                local r12_42 = gamelua.objects.world[r12_28[1].name]
                r12_42.bubbleActivationX = r12_35
                local r12_43 = gamelua.objects.world[r12_28[1].name]
                r12_43.bubbleActivationY = r12_23
            end
        end
        if not r12_27 then
            r12_0.bubbleBeamPhase = 1
            r12_0.bubbleBeamTimer = r12_1.specialtyBeamPhase1Time
            r12_0.bubblePrimaryTarget = true
            r12_0.bubbleActivationX = r12_20
            r12_0.bubbleActivationY = r12_23
            r12_0.bubbleBeamAnimationTimer = 0
            r12_0.bubbleBeamAnimationFrame = 1
        end
        r12_0.bubbleSoundTimer = r12_1.specialtyBeamPhase1Time + r12_1.specialtyBeamPhase2Time + r12_1.specialtyDuration
        local r12_44 = r12_20
        r12_0.specialtyActivationY = r12_23
        r12_0.specialtyActivationX = r12_44
        local r12_45 = {
            position = { x = r12_20, y = r12_23, particles = r12_1.specialtyParticle }
        }
        addEventCall("showPinkBirdParticles", r12_45, r12_1.specialtyBeamPhase1Time)
        local r12_46 = r12_1.specialtyRadius
        local r12_47 = gamelua.getLevelMetadata(gamelua.levelName)
        if r12_47.useBiggerLeiaSpecialtyRadius then
            r12_46 = r12_1.specialtyRadiusForBossLevel
        end
        local r12_48 = {
            x = r12_20,
            y = r12_23,
            left = -r12_46,
            right = r12_46,
            down = -r12_46,
            up = r12_46
        }
        for r12_49, r12_50 in _G.pairs(gamelua.getIntersectingObjects(r12_48)) do
            local r12_51 = gamelua.objects
            local r12_52 = r12_51.world[r12_50]
            local r12_53 = getObjectDefinition(r12_52.name)
            if r12_53 and (not (r12_52.name == "killingBox" or r12_53.controllable or r12_52.isSensor or not (r12_52.mass > 0) or r12_53.material == "staticGround" or r12_50 == p12_0.name) or r12_53.destroyWithLeiaForce) then
                local r12_54
                local r12_55
                local r12_56, r12_57, r12_58, r12_59
                if r12_52.width == nil then
                    if r12_52.radius == nil then
                        local r12_60 = res.getSpriteBounds
                        local r12_61 = blockTable.blocks[r12_52.definition]
                        r12_56, r12_57 = r12_60(r12_61.sprite)
                        r12_58, r12_59 = worldToPhysicsTransform(r12_56, r12_57)
                        local r12_62 = r12_59
                        r12_54 = r12_58
                        r12_55 = r12_62
                    else
                        local r12_63 = r12_52.radius
                        local r12_64 = r12_52.radius
                        r12_54 = r12_63
                        r12_55 = r12_64
                    end
                elseif r12_52.height == nil then
                    if r12_52.radius == nil then
                        local r12_65 = res.getSpriteBounds
                        local r12_66 = blockTable.blocks[r12_52.definition]
                        r12_56, r12_57 = r12_65(r12_66.sprite)
                        r12_58, r12_59 = worldToPhysicsTransform(r12_56, r12_57)
                        local r12_67 = r12_59
                        r12_54 = r12_58
                        r12_55 = r12_67
                    else
                        local r12_68 = r12_52.radius
                        local r12_69 = r12_52.radius
                        r12_54 = r12_68
                        r12_55 = r12_69
                    end
                else
                    local r12_70 = r12_52.width
                    local r12_71 = r12_52.height
                    r12_54 = r12_70
                    r12_55 = r12_71
                end
                local r12_72 = gamelua.getSquaredDistanceFromOBBToPoint(r12_52.x, r12_52.y, r12_54, r12_55, r12_52.angle, r12_20, r12_23)
                if _G.math.sqrt(r12_72.distance) < r12_46 then
                    r12_52.inBubble = true
                    r12_52.bubbleBeamTimer = r12_1.specialtyBeamPhase1Time
                    r12_52.bubbleBeamPhase = 1
                    r12_52.bubbleBeamAnimationTimer = 0
                    r12_52.bubbleBeamAnimationFrame = 1
                    r12_52.reticleName = p12_0.name
                    r12_52.bubbleActivationX = r12_20
                    r12_52.bubbleActivationY = r12_23
                    if r12_53.destroyWithLeiaForce then
                        r12_52.destroyWhenBeamHits = true
                        if r12_52.bubblePrimaryTarget then
                            r12_0.bubbleBeamPhase = 1
                            r12_0.bubbleBeamTimer = r12_1.specialtyBeamPhase1Time
                            r12_0.bubblePrimaryTarget = true
                            r12_0.bubbleActivationX = r12_20
                            r12_0.bubbleActivationY = r12_23
                            r12_0.bubbleBeamAnimationTimer = 0
                            r12_0.bubbleBeamAnimationFrame = 1
                        end
                    end
                end
            end
        end
    end
}
use3CPOSpecialty = {
    params = { timer = 0 },
    action = function(p14_0)
        local r14_0 = gamelua.objects.world[p14_0.name]
        local r14_1 = gamelua.blockTable.blocks[r14_0.definition]
        local r14_2 = gamelua.blockTable
        removeBird(r14_0)
        local r14_3 = r14_0.angle
        local r14_4 = r14_2.blocks[r14_0.definition]
        local r14_5 = r14_4.angleOffset
        local r14_6 = r14_3 + (r14_5 or 0)
        local r14_7 = {
            definition = r14_2.blocks[r14_0.definition],
            x = r14_0.x,
            y = r14_0.y,
            angle = r14_6,
            xVel = r14_0.startingXVel,
            yVel = r14_0.startingYVel,
            keepOriginalVelocity = r14_2.blocks[r14_0.definition].keepOriginalVelocity
        }
        local r14_8 = gamelua.spawnObjects
        local r14_9 = r14_2.blocks[r14_0.definition]
        r14_8(r14_9.spawnedObjects, r14_7)
        local r14_10 = gamelua.blockTable.blocks[r14_0.definition]
        playAudio(r14_10.sounds.special)
        gamelua.SettingsWrapper:markTutorialShown(r14_0.name)
    end
}
useR2D2Specialty = {
    params = { timer = 0 },
    action = function(p15_0)
        local r15_0 = gamelua.objects.world[p15_0.name]
        local r15_1 = gamelua.blockTable.blocks[r15_0.definition]
        if r15_0.specialtyUsed then
            return
        end
        r15_0.specialtyUsed = true
        local r15_2 = nil
        if r15_1.sounds ~= nil then
            r15_2 = r15_1.sounds.special
        end
        playAudio(r15_2)
        gamelua.SettingsWrapper:markTutorialShown(r15_0.name)
        makeExplosion(r15_0, getObjectDefinition(r15_0.name), bombSound)
        gamelua.activateBulletTime(0, 0.800000011920929, 0.5, 0.10000000149011612)
        for r15_3, r15_4 in _G.pairs(gamelua.levelGoals) do
            local r15_5 = gamelua.distance(r15_0.x, r15_0.y, r15_4.x, r15_4.y)
            local r15_6 = r15_1.specialtyRange
            if r15_5 < r15_6 then
                local r15_7 = gamelua.objects.world[p15_0.name]
                local r15_8 = gamelua.blockTable.blocks[r15_7.definition]
                local r15_9 = r15_4.y
                local r15_10 = r15_7.y
                local r15_11 = r15_9 - r15_10
                local r15_12 = _G.math.atan2(r15_11, r15_4.x - r15_7.x)
                local r15_13 = gamelua.blockTable.blocks[r15_1.specialtyObject]
                local r15_14, r15_15 = gamelua._G.res.getSpriteBounds(r15_13.sprite)
                local r15_16 = gamelua.physicsToWorld
                local r15_17 = r15_5 * r15_16 / r15_14
                local r15_18 = createObject(gamelua.blockTable, r15_1.specialtyObject, "R2D2_ZAP_" .. r15_4.name, r15_7.x, r15_7.y, r15_13.radius, r15_5 * gamelua.physicsToWorld, 10, r15_17, r15_17, r15_13.vertices)
                setObjectParameter(r15_18, 21, 6)
                local r15_19 = gamelua.objects
                local r15_20 = r15_19.world[r15_18]
                local r15_21 = gamelua.physicsToWorld
                r15_20.width = r15_5 * r15_21
                r15_20.height = 10
                if getObjectDefinition(r15_18).animations ~= nil then
                    gamelua.animatedObjects[r15_18] = r15_20
                    setObjectParameter(r15_18, 13, 1)
                end
                gamelua.print("Zapping " .. r15_4.name .. " from distance " .. r15_5)
                r15_20.angle = r15_12
                r15_20.scaleX = r15_17
                r15_20.scaleY = r15_17
                setRotation(r15_20.name, r15_20.angle)
            end
        end
    end
}
R2D2ZapCreated = {
    params = { timer = 0 },
    action = function(p16_0)
        addEventCall("destroyR2D2Zap", p16_0, 0.20000000298023224)
    end
}
destroyR2D2Zap = {
    params = { timer = 0 },
    action = function(p17_0)
        gamelua.animatedObjects[p17_0.name] = nil
        gamelua.destroyObject(p17_0.name)
    end
}
SpeechBubbleLogic = {
    params = { timer = 0 },
    action = function(p18_0)
        local r18_0 = gamelua.objects.spriteObjects[p18_0.name]
        if r18_0 ~= nil then
            if p18_0.time == nil then
                p18_0.time = 0
                p18_0.multiplier = 1
                addEventCall("SpeechBubbleLogic", p18_0, 0)
            else
                if p18_0.time < 0.05000000074505806 then
                    r18_0.scaleX = r18_0.scaleX + p18_0.dt * p18_0.multiplier
                    r18_0.scaleY = r18_0.scaleY + p18_0.dt * p18_0.multiplier
                    p18_0.multiplier = p18_0.multiplier + p18_0.dt * 5
                    addEventCall("SpeechBubbleLogic", p18_0, 0)
                elseif p18_0.time < 0.25 then
                    addEventCall("SpeechBubbleLogic", p18_0, 0)
                elseif p18_0.time < 0.44999998807907104 then
                    r18_0.scaleX = r18_0.scaleX - p18_0.dt * p18_0.multiplier * 5
                    r18_0.scaleY = r18_0.scaleY - p18_0.dt * p18_0.multiplier * 5
                    if r18_0.finalX ~= nil then
                        r18_0.x = r18_0.x + (r18_0.finalX - r18_0.x) * p18_0.dt * 8
                    end
                    p18_0.multiplier = p18_0.multiplier - p18_0.dt * 5
                    addEventCall("SpeechBubbleLogic", p18_0, 0)
                elseif p18_0.time < 0.5 then
                    addEventCall("SpeechBubbleLogic", p18_0, 0)
                else
                    local r18_1 = gamelua.objects
                    r18_1.spriteObjects[p18_0.name] = nil
                end
                p18_0.time = p18_0.time + p18_0.dt
            end
        end
    end
}
enableDetonatorCollision = {
    params = { timer = 0 },
    action = function(p19_0)
        if gamelua.checkStillInWorld(p19_0.name) then
            gamelua.setCollisionEnabled(p19_0.name, true)
        end
    end
}
blueBirdCollision = {
    params = { timer = 0 },
    action = function(p20_0)
        local r20_0 = p20_0.name
        if gamelua.checkStillInWorld(p20_0.name) and gamelua.PowerupManager then
            local r20_1 = gamelua.objects.world[p20_0.name]
            local r20_2 = r20_1["powerupObject" .. "_" .. gamelua.PowerupManager.BLASTER_DROID_DEF_NAME]
            if r20_2 then
                gamelua.addEventCall("enableDetonatorCollision", { name = r20_2.name })
            end
        end
        gamelua.fireAction("checkForCollisionAchievement", p20_0)
    end
}
checkForCollisionAchievement = {
    params = { timer = 0 },
    action = function(p21_0)
        if checkStillInWorld(p21_0.name) then
            local r21_0 = gamelua.objects.world[p21_0.name]
            local r21_1 = gamelua.objects.world[p21_0.other]
            if r21_1 and r21_1.material ~= pig and not r21_1.controllable and r21_1.strength < 0 then
                gamelua.SettingsWrapper:blockDestroyedByBird(r21_0.material)
                if r21_0.material == "materialBlueBird" then
                    local r21_2 = gamelua.SettingsWrapper:getNumBlocksDestroyedByBird(r21_0.material)
                    if gamelua.getAchievementLimit("Skilled Pilot") <= r21_2 then
                        gamelua.registerAchievement("Skilled Pilot")
                    end
                elseif r21_0.material == "materialBigBird" then
                    local r21_3 = gamelua.SettingsWrapper:getNumBlocksDestroyedByBird(r21_0.material)
                    if gamelua.getAchievementLimit("Magnificent Grumble") <= r21_3 then
                        gamelua.registerAchievement("Magnificent Grumble")
                    end
                elseif r21_0.material == "boba" then
                    local r21_4 = r21_0.name .. r21_0.timeCreated.year .. r21_0.timeCreated.month .. r21_0.timeCreated.day .. r21_0.timeCreated.hour .. r21_0.timeCreated.minutes .. r21_0.timeCreated.seconds
                    gamelua.SettingsWrapper:blockDestroyedByBoba(r21_4)
                    local r21_5 = gamelua.SettingsWrapper:getNumBlocksDestroyedByBoba(r21_4)
                    if gamelua.getAchievementLimit("Block Buster") <= r21_5 then
                        gamelua.registerAchievement("Block Buster")
                    end
                end
                local r21_6 = gamelua.SettingsWrapper:getNumBlocksDestroyedByBird(r21_0.material)
                gamelua.print("objects destroyed by " .. r21_0.material .. ": " .. r21_6)
            end
        end
    end
}
redBigBirdCollided = {
    params = { timer = 0 },
    action = function(p22_0)
        if checkStillInWorld(p22_0.name) then
            checkForCollisionAchievement.action(p22_0)
            local r22_0 = gamelua.objects.world[p22_0.name]
            if gamelua.flyingBird ~= nil and gamelua.flyingBird.name == p22_0.name then
                gamelua.birdSpecialtyAvailable = false
            end
            if r22_0 and not r22_0.regBigCollided then
                local r22_1 = cameraShakeModeSine
                local r22_2 = gamelua.blockTable.blocks[r22_0.definition]
                gamelua.addCameraShake(r22_1, 10000, r22_2.cameraShakeValue, 1)
                local r22_3 = gamelua.blockTable.blocks[r22_0.definition]
                gamelua.makeExplosion(r22_0, gamelua.getObjectDefinition(r22_0.name), r22_3.sounds.special)
                r22_0.regBigCollided = true
            end
        end
    end
}
redBigBirdCollidedLaser = {
    params = { timer = 0 },
    action = function(p23_0)
        if getObjectDefinition(p23_0.other.emitterName) then
            local r23_0 = gamelua.objects.world
            local r23_1 = p23_0.other
            local r23_2 = r23_0[r23_1.emitterName]
            local r23_3 = r23_2.parent
            if gamelua.isTurret(r23_3.definition) then
                local r23_4 = gamelua.isChewbacca
                local r23_5 = p23_0.obj
                if r23_4(r23_5.definition) then
                    gamelua.SettingsWrapper:nonPlayerGunShotBird(r23_3.name, p23_0.obj.name, r23_3.timeCreated)
                    local r23_6 = gamelua.SettingsWrapper:getTimesNonPlayerGunShotBird(r23_3.name, p23_0.obj.name, r23_3.timeCreated)
                    if gamelua.getAchievementLimit("Walking Carpet") < r23_6 then
                        gamelua.registerAchievement("Walking Carpet")
                    end
                end
            end
        end
    end
}
r2d2Collided = {
    params = { timer = 0 },
    action = function(p24_0)
        if checkStillInWorld(p24_0.name) and (not checkStillInWorld(p24_0.other) or not gamelua.objects.world[p24_0.other].isSensor) and not gamelua.objects.world[p24_0.name].ignoreBomb then
            local r24_0 = gamelua.objects
            flyingBird = r24_0.world[p24_0.name]
            local r24_1 = gamelua.objects.world[p24_0.name]
            r24_1.notCollided = nil
            setObjectParameter(p24_0.name, 11, 0)
            if gamelua.objects.world[p24_0.other] ~= nil then
                local r24_2 = gamelua.objects.world[p24_0.other]
                r24_2.notCollided = nil
                setObjectParameter(p24_0.other, 11, 0)
            end
            local r24_3 = gamelua.objects.world[p24_0.name]
            r24_3.ignoreBomb = true
        end
    end
}
blackBirdCollided = {
    params = { timer = 0 },
    action = function(p25_0)
        if checkStillInWorld(p25_0.name) and (not checkStillInWorld(p25_0.other) or not gamelua.objects.world[p25_0.other].isSensor) and not gamelua.objects.world[p25_0.name].ignoreBomb then
            local r25_0 = gamelua.objects
            flyingBird = r25_0.world[p25_0.name]
            local r25_1 = gamelua.objects.world[p25_0.name]
            r25_1.notCollided = nil
            setObjectParameter(p25_0.name, 11, 0)
            if gamelua.objects.world[p25_0.other] ~= nil then
                local r25_2 = gamelua.objects.world[p25_0.other]
                r25_2.notCollided = nil
                setObjectParameter(p25_0.other, 11, 0)
            end
            local r25_3 = gamelua.objects.world[p25_0.name]
            setSprite(p25_0.name, r25_3.sprite)
            local r25_4 = gamelua.objects.world[p25_0.name]
            r25_4.ignoreBomb = true
        end
    end
}
blackBirdExplodeAfterCollision = {
    params = { timer = 0 },
    action = function(p26_0)

    end
}
useBlackClusterSpecialty = {
    params = { timer = 0 },
    action = function(p27_0)
        g_emitterIndex = g_emitterIndex or 0
        g_emitterIndex = g_emitterIndex + 1
        local r27_0 = gamelua.objects.world[p27_0.name]
        local r27_1 = gamelua.blockTable
        local r27_2, r27_3 = physicsToWorldTransform(r27_0.x, r27_0.y)
        addPuffToTrajectory(1, r27_2, r27_3)
        local r27_4 = gamelua.objects
        parent = r27_4.world[p27_0.name]
        local r27_5 = createObject(gamelua.blockTable, "BLOCK_SENSOR_LAZER_EMITTER", "BLOCK_REDBIRD_LAZER_EMITTER" .. g_emitterIndex, parent.x, parent.y, 5, 5, 5, 1, 1, nil)
        local r27_6 = gamelua.objects
        local r27_7 = r27_6.world[r27_5]
        r27_7.parent = parent
        parent.emitterBody = r27_7
        r27_7.xDelta = 0
        r27_7.yDelta = 0
        local r27_8 = { timer = 0, emitInterval = 10000000272564224 }
        r27_7.emitter = r27_8
        local r27_9 = 0
        r27_8.emitInterval = 0
        r27_8.shotData = {
            {
                block = "BLOCK_TNT_3X3",
                timeInterval = 999,
                currentTime = r27_9 * 1,
                angle = { 20, 20 },
                startImpulse = 550
            },
            {
                block = "BLOCK_TNT_3X3",
                timeInterval = 999,
                currentTime = r27_9 * 1,
                angle = { -20, -20 },
                startImpulse = 550
            }
        }
        addUpdateCall("updateEmitter", { name = r27_5 }, nil, r27_5)
    end
}
useClusterSpecialty = {
    params = { timer = 0 },
    action = function(p28_0)
        local r28_0
        local r28_1 = gamelua.objects.world[p28_0.name]
        local r28_2 = gamelua.blockTable
        local r28_3, r28_4 = physicsToWorldTransform(r28_1.x, r28_1.y)
        if not r28_1.collision then
            addPuffToTrajectory(1, r28_3, r28_4)
        end
        local r28_5 = vNormalize
        local r28_6 = r28_1.yVel
        local r28_7 = r28_1.xVel
        local r28_8, r28_9 = r28_5(r28_6, -r28_7)
        local r28_10 = r28_1.xVel
        local r28_11
        local r28_12
        if r28_10 == 0 then
            if r28_1.yVel == 0 then
                local r28_13 = 0
                r28_0 = 1
                r28_11 = r28_13
                r28_12 = r28_0
            else
                r28_11 = r28_8
                r28_12 = r28_9
            end
        else
            r28_11 = r28_8
            r28_12 = r28_9
        end
        if r28_10 == 0 then
            local r28_14
            if r28_14 == 0 then
                r28_12 = r28_0
            else
                r28_12 = r28_9
            end
        else
            r28_12 = r28_9
        end
        local r28_15 = 0.17000000178813934
        local r28_16 = 0.20000000298023224
        local r28_17 = vLength(r28_1.xVel, r28_1.yVel) / 45
        local r28_18 = _G.math.min(r28_17, 1)
        local r28_19 = r28_15 + (r28_16 - r28_15) * r28_18
        local r28_20 = gamelua.transformCoordinates(r28_19, r28_1.xVel, r28_1.yVel)
        local r28_21 = gamelua.transformCoordinates(-r28_19, r28_1.xVel, r28_1.yVel)
        gamelua.SettingsWrapper:markTutorialShown(r28_1.name)
        gamelua.GameScene:makeClusterBird(r28_1.name .. "a", -r28_11, -r28_12, r28_20.x - r28_1.xVel, r28_20.y - r28_1.yVel)
        local r28_22 = r28_1.name .. "b"
        gamelua.GameScene:makeClusterBird(r28_22, 0, 0, 0, 0)
        if gamelua.PowerupManager then
            local r28_23 = r28_1["powerupObject" .. "_" .. gamelua.PowerupManager.BLASTER_DROID_DEF_NAME]
            if r28_23 then
                r28_23.attachToAfterJointRemove = r28_22
            end
        end
        local r28_24 = r28_1.name .. "c"
        local r28_25 = r28_21.x - r28_1.xVel
        gamelua.GameScene:makeClusterBird(r28_24, r28_11, r28_12, r28_25, r28_21.y - r28_1.yVel)
        gamelua.otherBirds = { r28_1.name .. "a", r28_1.name .. "b" }
        r28_1.doNotCount = true
        local r28_26 = r28_1.damageDone
        r28_1.damageDone = r28_26 + 10
        r28_1.startedOutsideAtmosphere = nil
        if not p28_0.mainMenuBird then
            setCameraTarget(r28_24)
        end
        gamelua.objects.world[r28_24].recordTrajectory = r28_1.recordTrajectory
        removeBird(r28_1)
        gamelua.flyingBird = gamelua.objects.world[r28_24]
        local r28_27 = r28_2.blocks[r28_1.definition]
        playAudio(r28_27.sounds.special)
        if p28_0.mainMenuBird then
            gamelua.flyingBird = nil
        end
    end
}
calledMightyEagle = false
BaitCollided = {
    params = { timer = 0 },
    action = function(p29_0)
        local r29_0 = getObjectDefinition(p29_0.other)
        if r29_0 and r29_0.preventBirdCollision then
            return
        end
        if gamelua.g_scoreAddedTime < 2 then
            gamelua.g_scoreAddedTime = 2
        end
        addEventCall("callMightyFalcon", p29_0, 1.5)
    end
}
changeBirdForFalcon = {
    params = { timer = 0.10000000149011612 },
    action = function(p30_0)
        if gamelua.currentBirdName == nil then
            gamelua.ignorePlayerInput = true
            addEventCall("changeBirdForFalcon", p30_0)
        else
            if gamelua.objects.world[gamelua.currentBirdName].definition ~= "ME_BAIT" then
                gamelua.setObjectParameter(gamelua.currentBirdName, 33, 0)
                gamelua.replaceSelectedBirdWithME()
                if gamelua.menuManager:getRoot() ~= nil then
                    local r30_0 = gamelua.menuManager:getRoot()
                    local r30_1 = r30_0.name
                end
            end
            gamelua.ignorePlayerInput = false
        end
    end
}
callMightyFalcon = {
    params = { timer = 0 },
    action = function(p31_0)
        gamelua.print([[ callMightyFalcon 
]])
        gamelua.eventManager:notify({ id = gamelua.events.EID_MIGHTY_FALCON_CALLED })
        if gamelua.levelCompleted then
            gamelua.print([[ Not creating mighty falcon, level is completed 
 ]])
            return
        end
        local r31_0 = gamelua.objects.world[p31_0.name]
        if not (r31_0 == nil or r31_0.calledMightyFalcon == true) then
            r31_0.calledMightyFalcon = true
            gamelua.allowResetToBirdCamera = false
            local r31_1 = r31_0.x
            p31_0.y = r31_0.y
            p31_0.x = r31_1
            destroyObject(p31_0.name)
            gamelua.birds[p31_0.name] = nil
            local r31_2 = gamelua.objects.world[p31_0.name]
            r31_2.onCollisionEnter = nil
            local r31_3 = getObjectDefinition(r31_0.name)
            gamelua.g_birdEmitterTargets[r31_0.name] = {
                r31_0.x,
                r31_0.y,
                nil,
                0,
                r31_3.reticleSprite
            }
            gamelua.registerAchievement("Mighty Launch")
            addEventCall("CreateMightyFalcon", p31_0)
        end
    end
}
CreateMightyFalcon = {
    params = { timer = 1.5 },
    action = function(p32_0)
        gamelua.print('"CreateMightyFalcon"')
        gamelua.numberOfMightyFalcons = gamelua.numberOfMightyFalcons + 1
        local r32_0 = createObject(gamelua.blockTable, "BLOCK_MIGHTY_FALCON", "BLOCK_MIGHTY_FALCON_" .. gamelua.numberOfMightyFalcons, p32_0.x, p32_0.y)
        local r32_1 = gamelua.objects
        local r32_2 = r32_1.world[r32_0]
        gamelua.print("Created mighty falcon to " .. p32_0.x .. ", " .. p32_0.y)
        local r32_3 = gamelua.ui.MightyFalcon
        local r32_4 = {
            name = r32_0,
            physicsObject = r32_2,
            targetX = p32_0.x,
            targetY = p32_0.y,
            totalTime = gamelua.blockTable.blocks.BLOCK_MIGHTY_FALCON.falconFlyTime,
            baitName = p32_0.name
        }
        local r32_5 = r32_3:new(r32_4)
        r32_5.floorCoordinates = false
        if gamelua.menuManager:getRoot() ~= nil then
            gamelua.menuManager:getRoot():addChild(r32_5)
        end
        playAudio("mighty_falcon_fly")
        local r32_6 = {
            name = r32_0,
            shotTargetCoordinates = { p32_0.x, p32_0.y },
            numberOfShots = 5
        }
        addEventCall("initMightyFalconEmitter", r32_6)
        for r32_7, r32_8 in _G.pairs(gamelua.levelGoals) do
            gamelua.setCurrentState(r32_8, "nervousState")
        end
    end
}
initMightyFalconEmitter = {
    params = { timer = 0 },
    action = function(p33_0)
        gamelua.print('"initMightyFalconEmitter"')
        g_emitterIndex = g_emitterIndex or 0
        g_emitterIndex = g_emitterIndex + 1
        local r33_0 = gamelua.objects
        parent = r33_0.world[p33_0.name]
        local r33_1 = gamelua.blockTable.blocks[parent.definition]
        local r33_2 = createObject(gamelua.blockTable, r33_1.falconEmitter, r33_1.falconEmitter .. g_emitterIndex, parent.x, parent.y, 5, 5, 5, 1, 1, nil)
        gamelua.setCollisionEnabled(r33_2, false)
        local r33_3 = gamelua.objects
        local r33_4 = r33_3.world[r33_2]
        r33_4.parent = parent
        parent.emitterBody = r33_4
        r33_4.xDelta = 0
        r33_4.yDelta = 0
        local r33_5 = { timer = 0, emitInterval = 0 }
        r33_4.emitter = r33_5
        gamelua.setVisible(r33_4.name, false)
        local r33_6 = r33_1.falconLaserShotSpeed
        r33_5.shotSpeed = r33_6
        r33_5.emitInterval = 0
        r33_5.birdEmitter = true
        gamelua.g_birdEmitterTargets = gamelua.g_birdEmitterTargets or {}
        local r33_7 = p33_0.shotTargetCoordinates[1]
        local r33_8 = p33_0.shotTargetCoordinates[2]
        r33_5.shotData = {}
        for r33_9 = 1, r33_1.falconLaserNumberOfShots do
            r33_5.shotData[r33_9] = {
                block = r33_1.falconLaser,
                timeInterval = 44,
                currentTime = r33_1.falconLaserPattern[r33_9],
                angle = { 180, 360 },
                speed = { r33_6, r33_6 },
                shotTargetCoordinates = p33_0.shotTargetCoordinates
            }
        end
        addUpdateCall("updateEmitter", { name = r33_2 }, nil, r33_2)
    end
}
addMightyEagleFlash = {
    params = { timer = 0.20000000298023224 },
    action = function(p34_0)
        gamelua.mightyEagleFlashAlpha = 0.5
        if #gamelua.mightyEagleBHBG <= 1 then
            gamelua.mightyEagleBGAlpha = nil
        end
    end
}
addMightyEagleDarkness = {
    params = { timer = 1.7000000476837158 },
    action = function(p35_0)
        if gamelua.mightyEagleBGAlpha == nil then
            gamelua.mightyEagleBGAlpha = 0.10000000149011612
        end
    end
}
replaceSelectedBirdWithME = {
    params = { timer = 0.10000000149011612 },
    action = function(p36_0)
        gamelua.replaceSelectedBirdWithME()
    end
}
cameraShakeOff = {
    params = { timer = 1 },
    action = function(p37_0)
        gamelua.mightyEagleCameraShake.running = false
    end
}
BaitLaunched = {
    params = { timer = 2.5 },
    action = function(p38_0)
        local r38_0 = gamelua.objects.world[p38_0.name]
        if r38_0 ~= nil then
            local r38_1 = createObject(gamelua.blockTable, "BLOCK_MIGHTY_EAGLE", "BLOCK_MIGHTY_EAGLE_1", r38_0.x, r38_0.y)
        end
    end
}
useLazerShotSpecialty = {
    params = { timer = 0 },
    action = function(p39_0)
        if gamelua.checkStillInWorld(p39_0.name) then
            local r39_0 = gamelua.objects.world[p39_0.name]
            local r39_1 = gamelua.blockTable.blocks[r39_0.definition]
            g_emitterIndex = g_emitterIndex or 0
            g_emitterIndex = g_emitterIndex + 1
            local r39_2 = createObject(gamelua.blockTable, "BLOCK_SENSOR_LAZER_EMITTER", "BLOCK_REDBIRD_LAZER_EMITTER" .. g_emitterIndex, r39_0.x, r39_0.y, 5, 5, 5, 1, 1, nil)
            gamelua.setCollisionEnabled(r39_2, false)
            local r39_3 = gamelua.objects
            local r39_4 = r39_3.world[r39_2]
            r39_4.parent = r39_0
            r39_0.emitterBody = r39_4
            r39_4.xDelta = 0
            r39_4.yDelta = 0
            local r39_5 = { timer = 0, emitInterval = 0 }
            r39_4.emitter = r39_5
            gamelua.setVisible(r39_4.name, false)
            local r39_6 = gamelua.gameWorldScale
            local r39_7 = 100 * r39_6
            r39_5.shotSpeed = r39_7
            r39_5.emitInterval = 0
            r39_5.birdEmitter = true
            gamelua.activateBulletTime(0, 0.800000011920929, 0.800000011920929, 0.4000000059604645)
            r39_5.shotData = {}
            local r39_8 = 1
            local r39_9 = r39_1.specialtyShots
            for r39_10 = r39_8, #r39_9 do
                local r39_11 = gamelua.vec2Rotate
                local r39_12 = p39_0.xPos
                local r39_13 = r39_0.x
                local r39_14 = r39_12 - r39_13
                local r39_15 = p39_0.yPos
                local r39_16 = r39_0.y
                local r39_17 = r39_15 - r39_16
                local r39_18 = r39_1.specialtyShots[r39_10].angle
                local r39_19 = _G.math.pi
                local r39_20, r39_21 = r39_11(r39_14, r39_17, r39_18 * r39_19 / 180)
                r39_5.shotData[r39_10] = {
                    block = r39_1.specialtyObject,
                    timeInterval = 100,
                    currentTime = r39_1.specialtyShots[r39_10].delay,
                    angle = { 180, 360 },
                    speed = { r39_7, r39_7 },
                    shotTargetCoordinates = { r39_0.x + r39_20, r39_0.y + r39_21 },
                    offset = r39_1.specialtyShots[r39_10].offset,
                    doNotDrawTarget = r39_1.specialtyShots[r39_10].doNotDrawTarget
                }
            end
            addUpdateCall("updateEmitter", { name = r39_2 }, nil, r39_2)
        end
    end
}
lazerBirdCollision = {
    params = { timer = 0 },
    action = function(p40_0)
        local r40_0 = gamelua.objects.world[p40_0.name]
        local r40_1 = getObjectDefinition(p40_0.name)
        if r40_1 and r40_1.specialtyActivationDelay == nil and r40_0.emitterBody then
            gamelua.destroyEmitter(r40_0.emitterBody)
        end
    end
}
sensorToBirdCollision = {
    params = { timer = 0 },
    action = function(p41_0)
        if p41_0.name == "killingBox" or p41_0.other == "killingBox" then
            return
        end
        local r41_0 = gamelua.objects.world[p41_0.name]
        local r41_1 = gamelua.objects.world[p41_0.other]
        local r41_2 = gamelua.blockTable.materials[r41_1.material]
        if r41_1.controllable and not r41_1.ignoreLaserCollision then
            local r41_3 = gamelua.getRayCastedObjects
            local r41_4 = {
                x1 = r41_0.x,
                y1 = r41_0.y,
                x2 = r41_1.x,
                y2 = r41_1.y,
                source = r41_0.name
            }
            local r41_5 = r41_3(r41_4)
            if r41_5[1] then
                local r41_6 = gamelua.objects.world[r41_5[1]]
                local r41_7 = r41_5[2]
                local r41_8 = r41_5[3]
                local r41_9 = gamelua.blockTable.blocks[r41_0.definition]
                local r41_10, r41_11 = r41_9.impulseGivenOnBirdCollision, physicsScale
                local r41_12 = r41_10 * r41_11
                if not (r41_10 * r41_11) then
                    r41_12 = 250
                end
                local r41_13 = r41_0.movementAngleX * r41_12
                gamelua.applyImpulse(r41_6.name, r41_13, r41_0.movementAngleY * r41_12, r41_7, r41_8)
            end
        end
        if r41_2.bouncesLaserTargeted then
            local r41_14 = nil
            local r41_15 = 100000000
            if r41_1.laserBounceTargets == nil then
                r41_1.laserBounceTargets = {}
            end
            for r41_16, r41_17 in _G.pairs(gamelua.levelGoals) do
                local r41_18 = (r41_0.x - r41_17.x) * (r41_0.x - r41_17.x) + (r41_0.y - r41_17.y) * (r41_0.y - r41_17.y)
                if r41_18 < r41_15 and (r41_1.laserBounceTargets[r41_17.name] == nil or r41_1.laserBounceTargets[r41_17.name] < 1) then
                    r41_15 = r41_18
                    r41_14 = r41_17
                end
            end
            local r41_19
            if r41_14 then
                if r41_1.laserBounceTargets[r41_14.name] == nil then
                    gamelua.print("First laser bounce to target " .. r41_14.name)
                    r41_1.laserBounceTargets[r41_14.name] = 1
                else
                    gamelua.print("Second laser bounce to target " .. r41_14.name)
                    r41_1.laserBounceTargets[r41_14.name] = r41_1.laserBounceTargets[r41_14.name] + 1
                end
                r41_19 = _G.math.atan2(r41_14.y - r41_0.y, r41_14.x - r41_0.x)
            else
                r41_19 = _G.math.atan2(r41_0.y - r41_1.y, r41_0.x - r41_1.x)
            end
            local r41_20 = _G.math.cos
            r41_0.movementAngleX = r41_20(r41_19)
            local r41_21 = _G.math.sin
            r41_0.movementAngleY = r41_21(r41_19)
            r41_0.bounceAngle = r41_19
            local r41_22 = gamelua.blockTable.blocks[r41_0.definition]
            local r41_23 = r41_22.particlesCollision
            if r41_23 then
                gamelua.putParticles({ x = r41_0.x, y = r41_0.y, particles = r41_23 })
            end
            local r41_24 = gamelua.blockTable.blocks[r41_0.definition]
            local r41_25 = r41_24.deflectionSound
            if r41_25 then
                gamelua.playAudio(r41_25)
            end
            if r41_1.isSword then
                local r41_26 = r41_1.name .. r41_1.timeCreated.year .. r41_1.timeCreated.month .. r41_1.timeCreated.day .. r41_1.timeCreated.hour .. r41_1.timeCreated.minutes .. r41_1.timeCreated.seconds
                gamelua.SettingsWrapper:laserDeflectedBySword(r41_26, r41_0.name)
                local r41_27 = gamelua.SettingsWrapper:getTimesLaserDeflectedBySword(r41_26)
                if gamelua.getAchievementLimit("Prominent Jedi") <= r41_27 then
                    gamelua.registerAchievement("Prominent Jedi")
                end
            end
            local r41_28 = gamelua.blockTable.blocks[r41_0.definition]
            local r41_29 = r41_28.collidedScoreInc
            if r41_29 then
                if gamelua.blockTable.blocks[r41_0.definition].spriteScore == nil then
                    if r41_29 > 0 then
                        local r41_30 = {
                            x = r41_0.x,
                            y = r41_0.y,
                            text = "" .. r41_29,
                            score = r41_29,
                            time = 0,
                            lifetime = 0.6000000238418579,
                            maxScale = 0.25 + r41_29 / 3000,
                            xs = 0
                        }
                        _G.table.insert(gamelua.floatingScores, r41_30)
                    end
                else
                    local r41_31 = {
                        x = r41_0.x,
                        y = r41_0.y,
                        sprite = gamelua.blockTable.blocks[r41_0.definition].spriteScore,
                        score = r41_29,
                        time = 0,
                        lifetime = 0.8999999761581421,
                        maxScale = 1,
                        xs = 0
                    }
                    _G.table.insert(gamelua.floatingScores, r41_31)
                end
                gamelua.scoreTable.blocks.score = gamelua.scoreTable.blocks.score + r41_29
            end
        end
    end
}
