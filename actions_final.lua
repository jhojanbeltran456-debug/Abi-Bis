-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

-- line 3-34
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
    vNormalize = gamelua.vNormalize
    physicsToWorldTransform = gamelua.physicsToWorldTransform
    print = gamelua.print
    vLength = gamelua.vLength
    getVelocity = gamelua.getVelocity
end

onLevelLoad = {
    params = { timer = 0 },
    action = function(p2_0)
        gamelua.showCameraDebugData = false
        gamelua.visualizeScreen = { x = 0, y = 0 }
    end
}
onBeforeLevelLoad = {
    params = { timer = 0 },
    action = function(p3_0)

    end
}
playBossMusic = {
    params = { timer = 1 },
    action = function(p4_0)
        playAudio(p4_0.music)
    end
}
playFalconSilverMedalSound = {
    params = { timer = 0 },
    action = function(p5_0)
        gamelua.playAudio(p5_0.music)
    end
}
onRunEventFromGame = {
    params = { timer = 0 },
    action = function(p6_0)
        if startedBirdTutorial then
            addEventCall("endTutorial", p6_0, 0)
            startedBirdTutorial = false
        else
            addEventCall("startTutorial", p6_0, 0)
            startedBirdTutorial = true
        end
    end
}
setPosition = {
    params = { timer = 0.20000000298023224 },
    action = function(p7_0)
        if gamelua.objects.world[p7_0.name] ~= nil then
            local r7_0 = gamelua.objects.world[p7_0.name]
            local r7_1 = gamelua.objects.world[p7_0.name]
            setPosition(p7_0.name, r7_0.startingX, r7_1.startingY)
        end
    end
}
destroy = {
    params = { timer = 0 },
    action = function(p8_0)
        if checkStillInWorld(p8_0.name) then
            destroyObject(p8_0.name)
        end
    end
}
delayedDestroyObject = {
    params = { timer = 0.30000001192092896 },
    action = function(p9_0)
        if checkStillInWorld(p9_0.other) and checkStillInWorld(p9_0.name) and gamelua.objects.world[p9_0.other].controllable then
            destroyObject(p9_0.name)
        end
    end
}
numRespawned = 0
respawnInOriginalPosition = {
    params = { timer = 0 },
    action = function(p10_0)
        local r10_0 = p10_0.obj.definition .. "respawned" .. numRespawned
        createObject(gamelua.blockTable, p10_0.obj.definition, r10_0, p10_0.obj.startingX, p10_0.obj.startingY)
        numRespawned = numRespawned + 1
    end
}
setAsteroidVelocityAndRotation = {
    params = { timer = 0 },
    action = function(p11_0)
        if checkStillInWorld(p11_0.name) then
            setVelocity(p11_0.name, 5, 20)
        end
    end
}
physicsOff = {
    params = { timer = 0 },
    action = function(p12_0)
        gamelua.setPhysicsEnabled(false)
    end
}
physicsOn = {
    params = { timer = 0 },
    action = function(p13_0)
        gamelua.setPhysicsEnabled(true)
    end
}
spawnTimer = {
    params = { timer = 0.5 },
    action = function(p14_0)
        if p14_0.name == nil or gamelua.objects.world[p14_0.name] == nil then
            if p14_0.obj ~= nil then
                local r14_0 = p14_0.obj.definition .. "respawned" .. numRespawned
                createObject(gamelua.blockTable, p14_0.obj.definition, r14_0, p14_0.obj.startingX, p14_0.obj.startingY)
                numRespawned = numRespawned + 1
                addEventCall("spawnTimer", { obj = p14_0.obj }, 0.25)
            end
        else
            local r14_1 = gamelua.objects.world[p14_0.name]
            local r14_2 = p14_0.obj.definition .. "respawned" .. numRespawned
            createObject(gamelua.blockTable, p14_0.obj.definition, r14_2, p14_0.obj.startingX, p14_0.obj.startingY)
            numRespawned = numRespawned + 1
            addEventCall("spawnTimer", { obj = p14_0.obj }, 0.25)
        end
    end
}
teleportObject = {
    params = { timer = 0.10000000149011612 },
    action = function(p15_0)
        if gamelua.objects.world[p15_0.other] ~= nil and (gamelua.objects.world[p15_0.other].canTeleport == nil or gamelua.objects.world[p15_0.other].canTeleport ~= false) then
            for r15_0, r15_1 in _G.pairs(portalList) do
                local r15_2 = p15_0.name
                if not (r15_1 == r15_2 or gamelua.objects.world[r15_1] == nil) then
                    local r15_3 = gamelua.objects
                    local r15_4 = r15_3.world[r15_1]
                    local r15_5 = gamelua.objects
                    local r15_6 = r15_5.world[r15_1]
                    setPosition(p15_0.other, r15_4.x, r15_6.y)
                    local r15_7 = gamelua.objects
                    local r15_8 = r15_7.world[r15_1]
                    local r15_9 = gamelua.objects
                    local r15_10 = r15_9.world[r15_1]
                    setPosition(p15_0.other, r15_8.x, r15_10.y)
                    local r15_11 = gamelua.objects.world[p15_0.other]
                    r15_11.canTeleport = false
                    addEventCall("enableTeleport", { name = p15_0.other }, 0.25)
                end
            end
        end
    end
}
checkSpawnLoopingParticles = {
    params = { timer = 0 },
    action = function(p16_0)
        if checkStillInWorld(p16_0.name) and (gamelua.objects.world[p16_0.name].active == nil or gamelua.objects.world[p16_0.name].active) then
            addEventCall("spawnLoopingParticles", p16_0)
        end
    end
}
particleSpawnerActiveStateChange = {
    params = { timer = 0 },
    action = function(p17_0)
        if checkStillInWorld(p17_0.name) then
            local r17_0 = gamelua.objects.world[p17_0.name]
            if p17_0.active then
                addEventCall("startSpawnLoopingParticles", p17_0)
            else
                addEventCall("stopSpawnLoopingParticles", p17_0)
            end
        end
    end
}
toggleSpawnLoopingParticles = {
    params = { timer = 0 },
    action = function(p18_0)
        if checkStillInWorld(p18_0.name) then
            local r18_0 = gamelua.objects.world[p18_0.name]
            if r18_0.stopSpawnLoopingParticles == nil or r18_0.stopSpawnLoopingParticles then
                addEventCall("startSpawnLoopingParticles", p18_0)
            else
                addEventCall("stopSpawnLoopingParticles", p18_0)
            end
        end
    end
}
spawnLoopingParticles = {
    params = { timer = 0 },
    action = function(p19_0)
        local r19_0 = gamelua.objects.world[p19_0.name]
        if r19_0 ~= nil then
            local r19_1 = gamelua.fireAction
            local r19_2 = "spawnParticles"
            local r19_3 = { name = p19_0.name }
            local r19_4 = gamelua.objects.world[p19_0.name]
            local r19_5 = r19_4.loopingParticles
            local r19_6
            if r19_5 then
                r19_6 = r19_5
            else
                local r19_7 = gamelua.blockTable.blocks[r19_0.definition]
                r19_6 = r19_7.loopingParticles
            end
            r19_3.particles = r19_6
            r19_1(r19_2, r19_3)
            local r19_8 = gamelua.objects.world[p19_0.name]
            local r19_9 = r19_8.loopingParticlesInterval
            local r19_10
            if r19_9 then
                r19_10 = r19_9
            else
                local r19_11 = gamelua.blockTable.blocks[r19_0.definition]
                r19_10 = r19_11.loopingParticlesInterval
            end
            local r19_12 = r19_10 or 0.10000000149011612
            if not r19_0.stopSpawnLoopingParticles then
                addEventCall("spawnLoopingParticles", p19_0, r19_12)
            end
        end
    end
}
startSpawnLoopingParticles = {
    params = { timer = 0 },
    action = function(p20_0)
        if checkStillInWorld(p20_0.name) then
            local r20_0 = gamelua.objects.world[p20_0.name]
            r20_0.stopSpawnLoopingParticles = false
            addEventCall("spawnLoopingParticles", p20_0)
        end
    end
}
stopSpawnLoopingParticles = {
    params = { timer = 0 },
    action = function(p21_0)
        if checkStillInWorld(p21_0.name) then
            local r21_0 = gamelua.objects.world[p21_0.name]
            r21_0.stopSpawnLoopingParticles = true
        end
    end
}
spawnParticles = {
    params = { timer = 0 },
    action = function(p22_0)
        local r22_0 = p22_0.particles
        if gamelua.particleTable.particles[r22_0] then
            putParticles({
                objectName = p22_0.name,
                particles = r22_0,
                amount = gamelua.particleTable.particles[r22_0].amount
            })
        else
            for r22_1, r22_2 in _G.pairs(r22_0) do
                if gamelua.particleTable.particles[r22_2] then
                    putParticles({
                        objectName = p22_0.name,
                        particles = r22_2,
                        amount = gamelua.particleTable.particles[r22_2].amount
                    })
                end
            end
        end
    end
}
spawnAnimationParticles = {
    params = { timer = 0 },
    action = function(p23_0)
        local r23_0 = gamelua.objects.world[p23_0.name]
        local r23_1 = gamelua.getObjectDefinition(p23_0.name)
        if r23_0 and r23_1 then
            local r23_2 = r23_1.animations[r23_0.currentAnimation]
            if r23_2 and r23_2.loopingParticles then
                local r23_3 = {
                    name = p23_0.name,
                    particles = r23_1.animations[r23_0.currentAnimation].loopingParticles
                }
                gamelua.fireAction("spawnParticles", r23_3)
                if r23_2.loopingParticlesInterval then
                    addEventCall("spawnAnimationParticles", p23_0, r23_2.loopingParticlesInterval)
                end
            end
        end
    end
}
portalList = {}
portalCreated = {
    params = { timer = 0 },
    action = function(p24_0)
        portalList[#portalList + 1] = p24_0.name
    end
}
enableTeleport = {
    params = { timer = 0.20000000298023224 },
    action = function(p25_0)
        if gamelua.objects.world[p25_0.name] ~= nil then
            local r25_0 = gamelua.objects.world[p25_0.name]
            r25_0.canTeleport = true
        end
    end
}
addedSlipperFunction = false
icePlanetCollision = {
    params = { timer = 0 },
    action = function(p26_0)
        if checkStillInWorld(p26_0.name) and checkStillInWorld(p26_0.other) and gamelua.objects.world[p26_0.other].controllable and not addedSlipperFunction then
            addedSlipperFunction = true
            addEventCall("slipperPlanetF", { name = p26_0.name, other = p26_0.other }, 0)
        end
    end
}
icePlanetStopCollision = {
    params = { timer = 0 },
    action = function(p27_0)
        if checkStillInWorld(p27_0.name) and checkStillInWorld(p27_0.other) and gamelua.objects.world[p27_0.other].controllable then
            addedSlipperFunction = false
        end
    end
}
slipperPlanetF = {
    params = { timer = 0 },
    action = function(p28_0)
        if addedSlipperFunction and checkStillInWorld(p28_0.name) and checkStillInWorld(p28_0.other) then
            local r28_0 = gamelua.objects.world[p28_0.name]
            local r28_1 = gamelua.objects.world[p28_0.other]
            if r28_1.controllable and not r28_1.isSlidingDisabled then
                local r28_2 = vLength(r28_1.xVel, r28_1.yVel)
                if not r28_1.sliding then
                    r28_1.startingSpeed = r28_2 * 2.5
                end
                if r28_1.sliding and r28_2 < 15 then
                    r28_1.isSlidingDisabled = true
                elseif not r28_1.sliding or r28_2 > 25 then
                    r28_1.sliding = true
                    local r28_3 = r28_0.x
                    local r28_4 = r28_1.x
                    local r28_5 = r28_3 - r28_4
                    local r28_6 = r28_0.y
                    local r28_7 = r28_1.y
                    local r28_8, r28_9 = vNormalize(r28_5, r28_6 - r28_7)
                    local r28_10 = r28_9
                    local r28_11 = r28_8
                    local r28_12, r28_13 = vNormalize(r28_1.xVel, r28_1.yVel)
                    local r28_14, r28_15 = vNormalize(-r28_11 + r28_12 * 500, -r28_10 + r28_13 * 500)
                    setVelocity(p28_0.other, r28_12 * r28_1.startingSpeed, r28_13 * r28_1.startingSpeed)
                    addEventCall("slipperPlanetF", { name = p28_0.name, other = p28_0.other }, 0)
                    local r28_16 = gamelua._G.math.atan2(r28_1.yVel, r28_1.xVel)
                end
            end
        end
    end
}
waterCollision = {
    params = { timer = 0 },
    action = function(p29_0)
        if checkStillInWorld(p29_0.name) and checkStillInWorld(p29_0.other) then
            local r29_0 = gamelua.objects.world[p29_0.name]
            local r29_1 = gamelua.objects.world[p29_0.other]
            if r29_1.controllable then
                r29_1.insideWater = true
            end
        end
    end
}
moveDummyObjectToDestination = {
    params = { timer = 0 },
    action = function(p30_0)
        if gamelua.usingCameraDummy and gamelua.cameraTargetObject ~= nil then
            local r30_0 = gamelua.cameraTargetObject
            local r30_1 = { x = p30_0.dest.x - r30_0.x, y = p30_0.dest.y - r30_0.y }
            local r30_2 = vLength(r30_0.xVel, r30_0.yVel)
            local r30_3 = vLength(r30_1.x, r30_1.y)
            if r30_2 * 0.10000000149011612 < r30_3 then
                local r30_4, r30_5 = vNormalize(r30_1.x, r30_1.y)
                r30_1.y = r30_5
                r30_1.x = r30_4
                gamelua.cameraTargetObject.x = gamelua.cameraTargetObject.x + r30_0.xVel * p30_0.dt
                gamelua.cameraTargetObject.y = gamelua.cameraTargetObject.y + r30_0.yVel * p30_0.dt
                addEventCall("moveDummyObjectToDestination", { dest = p30_0.dest }, 0)
            else
                gamelua.setCameraTargetObject(nil)
                gamelua.usingCameraDummy = false
            end
        end
    end
}
startFollowPath = {
    params = { timer = 0 },
    action = function(p31_0)
        if gamelua.objects.world[p31_0.name] ~= nil then
            p31_0.pathIdx = 1
            p31_0.path = addEvent
        end
    end
}
startFollowPath = {
    params = { timer = 0 },
    action = function(p32_0)
        local r32_0 = gamelua.objects.world[p32_0.name]
        if r32_0 ~= nil then
            local r32_1 = gamelua.blockTable.blocks[r32_0.definition]
            p32_0.path = {
                "BOSS_1_DUMMY_OBJECT_1_1",
                "BOSS_1_DUMMY_OBJECT_1_2",
                "BOSS_1_DUMMY_OBJECT_1_3",
                "BOSS_1_DUMMY_OBJECT_1_4",
                "BOSS_1_DUMMY_OBJECT_1_5",
                "BOSS_1_DUMMY_OBJECT_1_6",
                "BOSS_1_DUMMY_OBJECT_1_7"
            }
            r32_0.pathIdx = 1
            r32_0.followSpeed = 50
            addEventCall("followPath", p32_0, 0)
        end
    end
}
followPath = {
    params = { timer = 0 },
    action = function(p33_0)
        local r33_0 = gamelua.objects.world[p33_0.name]
        if r33_0 ~= nil then
            local r33_1 = gamelua.blockTable.blocks[r33_0.definition]
            local r33_2 = gamelua.objects.world[p33_0.path[r33_0.pathIdx]]
            if r33_2 ~= nil then
                local r33_3 = r33_2.x
                local r33_4 = r33_0.x
                local r33_5 = r33_3 - r33_4
                local r33_6 = r33_2.y
                local r33_7 = r33_0.y
                local r33_8 = r33_6 - r33_7
                local r33_9 = vLength(r33_5, r33_8)
                if r33_9 > 10 then
                    local r33_10, r33_11 = vNormalize(r33_5, r33_8)
                    local r33_12 = r33_10 * r33_0.followSpeed
                    setVelocity(p33_0.name, r33_12, r33_11 * r33_0.followSpeed)
                    gamelua.setAngularVelocity(p33_0.name, 0)
                else
                    local r33_13 = r33_0.pathIdx
                    r33_0.pathIdx = r33_13 + 1
                    local r33_14 = r33_0.pathIdx
                    if #p33_0.path < r33_14 then
                        r33_0.pathIdx = 1
                    end
                end
            end
            addEventCall("followPath", p33_0, 0.10000000149011612)
        end
    end
}
tweenSpriteObjectScale = {
    params = { timer = 0 },
    action = function(p34_0)
        local r34_0 = gamelua.objects.spriteObjects[p34_0.name]
        print("HERE1!!!!!")
        if r34_0 ~= nil then
            print("HERE2!!!!!")
            if p34_0.increment == nil then
                if gamelua.blockTable.blocks[r34_0.definition].scaleTweenTime == nil then
                    p34_0.time = 0.25
                    p34_0.increment = 7.199999809265137
                    p34_0.scale = r34_0.scaleX
                else
                    local r34_1 = gamelua.blockTable.blocks[r34_0.definition]
                    p34_0.time = r34_1.scaleTweenTime
                    local r34_2 = gamelua.blockTable.blocks[r34_0.definition]
                    p34_0.increment = r34_2.scaleTweenIncrement
                    p34_0.scale = r34_0.scaleX
                end
            end
            print("HERE3!!!!!")
            local r34_3 = p34_0.time
            if r34_3 > 0 then
                p34_0.scale = p34_0.scale + p34_0.dt * p34_0.increment
                local r34_4 = gamelua.objects.spriteObjects[p34_0.name]
                r34_4.scaleX = p34_0.scale
                local r34_5 = gamelua.objects.spriteObjects[p34_0.name]
                r34_5.scaleY = p34_0.scale
                print("HERE4!!!!!")
                p34_0.time = p34_0.time - p34_0.dt
                addEventCall("tweenSpriteObjectScale", p34_0, 0)
            end
        end
    end
}
tweenSpriteObjectPosition = {
    params = { timer = 0 },
    action = function(p35_0)
        local r35_0 = gamelua.objects.spriteObjects[p35_0.name]
        print("HERE1!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        if r35_0 ~= nil then
            print("HERE2!!!!!")
            if p35_0.time == nil then
                if gamelua.blockTable.blocks[r35_0.definition].positionTweenTime == nil then
                    p35_0.time = 0.25
                    p35_0.xIncrement = 10
                else
                    local r35_1 = gamelua.blockTable.blocks[r35_0.definition]
                    p35_0.time = r35_1.positionTweenTime
                    local r35_2 = gamelua.blockTable.blocks[r35_0.definition]
                    p35_0.xIncrement = r35_2.xIncrement
                    local r35_3 = gamelua.blockTable.blocks[r35_0.definition]
                    p35_0.yIncrement = r35_3.yIncrement
                end
            end
            print("HERE3!!!!!")
            local r35_4 = p35_0.time
            if r35_4 > 0 then
                local r35_5 = gamelua.objects.spriteObjects[p35_0.name]
                local r35_6 = gamelua.objects.spriteObjects[p35_0.name]
                r35_5.x = r35_6.x + p35_0.dt * p35_0.xIncrement
                local r35_7 = gamelua.objects.spriteObjects[p35_0.name]
                local r35_8 = gamelua.objects.spriteObjects[p35_0.name]
                r35_7.y = r35_8.y + p35_0.dt * p35_0.yIncrement
                print("HERE4!!!!!")
                p35_0.time = p35_0.time - p35_0.dt
                addEventCall("tweenSpriteObjectPosition", p35_0, 0)
            end
        end
    end
}
tweenScale = {
    params = { timer = 0 },
    action = function(p36_0)
        local r36_0 = gamelua.objects.world[p36_0.name]
        if r36_0 ~= nil then
            if p36_0.increment == nil then
                if gamelua.blockTable.blocks[r36_0.definition].scaleTweenTime == nil then
                    p36_0.time = 0.25
                    p36_0.increment = 7.199999809265137
                    p36_0.scale = 0
                else
                    local r36_1 = gamelua.blockTable.blocks[r36_0.definition]
                    p36_0.time = r36_1.scaleTweenTime
                    local r36_2 = gamelua.blockTable.blocks[r36_0.definition]
                    p36_0.increment = r36_2.scaleTweenIncrement
                    p36_0.scale = 0
                end
            end
            local r36_3 = p36_0.time
            if r36_3 > 0 then
                p36_0.scale = p36_0.scale + p36_0.dt * p36_0.increment
                local r36_4 = gamelua.blockTable.blocks[r36_0.definition]
                local r36_5 = gamelua.blockTable.blocks[r36_0.definition]
                gamelua.setScale(p36_0.name, r36_4.scale + p36_0.scale, r36_5.scale + p36_0.scale)
                p36_0.time = p36_0.time - p36_0.dt
                addEventCall("tweenScale", p36_0, 0)
            end
        end
    end
}
tweenRotation = {
    params = { timer = 0 },
    action = function(p37_0)
        local r37_0 = gamelua.objects.world[p37_0.name]
        if r37_0 ~= nil then
            if p37_0.increment == nil then
                if gamelua.blockTable.blocks[r37_0.definition].rotationTweenTime == nil then
                    p37_0.time = 0.25
                    p37_0.increment = 7.199999809265137
                    p37_0.angle = r37_0.angle
                else
                    local r37_1 = gamelua.blockTable.blocks[r37_0.definition]
                    p37_0.time = r37_1.rotationTweenTime
                    local r37_2 = gamelua.blockTable.blocks[r37_0.definition]
                    p37_0.increment = r37_2.rotationTweenIncrement
                    p37_0.angle = r37_0.angle
                end
            end
            local r37_3 = p37_0.time
            if r37_3 > 0 then
                p37_0.angle = p37_0.angle + p37_0.dt * p37_0.increment
                gamelua.setRotation(p37_0.name, p37_0.angle)
                p37_0.time = p37_0.time - p37_0.dt
                addEventCall("tweenRotation", p37_0, 0)
            end
        end
    end
}
tweenPosition = {
    params = { timer = 0 },
    action = function(p38_0)
        local r38_0 = gamelua.objects.world[p38_0.name]
        if r38_0 ~= nil then
            if p38_0.xIncrement == nil then
                if gamelua.blockTable.blocks[r38_0.definition].positionTweenTime == nil then
                    p38_0.time = 0.25
                    p38_0.xIncrement = 7.199999809265137
                    p38_0.yIncrement = 7.199999809265137
                    p38_0.x = r38_0.x
                    p38_0.y = r38_0.y
                else
                    local r38_1 = gamelua.blockTable.blocks[r38_0.definition]
                    p38_0.time = r38_1.positionTweenTime
                    local r38_2 = gamelua.blockTable.blocks[r38_0.definition]
                    p38_0.xIncrement = r38_2.tweenXIncrement
                    local r38_3 = gamelua.blockTable.blocks[r38_0.definition]
                    p38_0.yIncrement = r38_3.tweenYIncrement
                    p38_0.x = r38_0.x
                    p38_0.y = r38_0.y
                    p38_0.startingX = r38_0.x
                    p38_0.startingY = r38_0.y
                end
            end
            local r38_4 = p38_0.time
            if r38_4 > 0 then
                p38_0.x = p38_0.x + p38_0.dt * p38_0.xIncrement
                p38_0.y = p38_0.y + p38_0.dt * p38_0.yIncrement
                gamelua.setPosition(p38_0.name, p38_0.x, p38_0.y)
                p38_0.time = p38_0.time - p38_0.dt
                addEventCall("tweenPosition", p38_0, 0)
            end
        end
    end
}
fireMultipleEvents = {
    params = { timer = 0 },
    action = function(p39_0)
        local r39_0 = gamelua.objects.world[p39_0.name]
        if r39_0 == nil then
            local r39_1 = gamelua.objects.spriteObjects[p39_0.name]
            if r39_1 ~= nil then
                if p39_0.eventList == nil then
                    local r39_2 = gamelua.blockTable.blocks[r39_1.definition]
                    if r39_2.eventList ~= nil then
                        for r39_3, r39_4 in gamelua._G.pairs(r39_2.eventList) do
                            r39_4.params.name = p39_0.name
                            addEventCall(r39_4.name, r39_4.params, r39_4.timer)
                        end
                    end
                else
                    for r39_5, r39_6 in gamelua._G.pairs(p39_0.eventList) do
                        r39_6.params.name = p39_0.name
                        addEventCall(r39_6.name, r39_6.params, r39_6.timer)
                    end
                end
            end
        elseif p39_0.eventList == nil then
            local r39_7 = gamelua.blockTable.blocks[r39_0.definition]
            if r39_7.eventList ~= nil then
                for r39_8, r39_9 in gamelua._G.pairs(r39_7.eventList) do
                    r39_9.params.name = p39_0.name
                    addEventCall(r39_9.name, r39_9.params, r39_9.timer)
                end
            end
        else
            for r39_10, r39_11 in gamelua._G.pairs(p39_0.eventList) do
                r39_11.params.name = p39_0.name
                addEventCall(r39_11.name, r39_11.params, r39_11.timer)
            end
        end
    end
}
FreeIceBird = {
    params = { timer = 0 },
    action = function(p40_0)
        local r40_0 = gamelua.objects
        local r40_1 = r40_0.world.IceBird_2
        local r40_2 = {
            xIncrement = 196,
            yIncrement = 0,
            time = 0.5,
            name = "IceBird_2",
            x = r40_1.x,
            y = r40_1.y
        }
        addEventCall("tweenPosition", r40_2, 0)
    end
}
bShowingTutorial = false
handleMusic = {
    params = { timer = 1 },
    action = function(p41_0)
        gamelua.handleLevelMusic()
    end
}
startCreditsLogic = {
    params = { timer = 1 },
    action = function(p42_0)
        addEventCall("startCreditsLogic", p42_0)
    end
}
mainMenuSpawnPoints = {
    "BOSS_1_DUMMY_OBJECT_1_1",
    "BOSS_1_DUMMY_OBJECT_1_2",
    "BOSS_1_DUMMY_OBJECT_1_3",
    "BOSS_1_DUMMY_OBJECT_1_4",
    "BOSS_1_DUMMY_OBJECT_1_5"
}
spaceShipSpawnPoint = "BOSS_1_DUMMY_OBJECT_1_6"
spaceShipDefinition = "BLOCK_FOREGROUND_ELEMENT_1"
numSpawnedMenuObjects = 0
activeObjects = 0
birdSpawnPoints = {
    "BOSS_1_DUMMY_OBJECT_1_6",
    "BOSS_1_DUMMY_OBJECT_1_7",
    "BOSS_1_DUMMY_OBJECT_1_8"
}
maxObjectsInMainMenu = 24
mainMenuObjDestroyed = {
    params = { timer = 0 },
    action = function(p43_0)
        activeObjects = activeObjects - 1
    end
}
mainMenuSpaceShipMoveRight = {
    params = { timer = -1 },
    action = function(p44_0)
        local r44_0 = gamelua.objects.world[p44_0.name]
        if r44_0 ~= nil then
            if r44_0.timer < 6.5 then
                r44_0.x = r44_0.x + p44_0.dt * 30
                local r44_1 = r44_0.startingY
                local r44_2 = gamelua._G.math.sin(r44_0.timer)
                r44_0.y = r44_1 + r44_2 * 12
                setPosition(p44_0.name, r44_0.x, r44_0.y)
                r44_0.timer = r44_0.timer + p44_0.dt
                addEventCall("mainMenuSpaceShipMoveRight", p44_0)
            else
                destroyObject(p44_0.name)
            end
        end
    end
}
removeBoostAim = {
    params = { timer = 0 },
    action = function(p45_0)
        local r45_0 = gamelua.objects.world[p45_0.name]
        if r45_0 ~= nil then
            r45_0.boostAim = nil
        end
    end
}

-- line 879-881
-- proto#46 params=0 locals=0 upvalues=0 vararg=false
function restartMainMenuElements()

end

-- line 883-885
-- proto#47 params=0 locals=0 upvalues=0 vararg=false
function initializeMainMenu()
    activeObjects = 0
end

optionsMenuOpened = {
    params = { timer = 0 },
    action = function(p48_0)
        if p48_0.time == nil then
            p48_0.time = 0
            gamelua.audioEnabled = not gamelua.audioEnabled
            local r48_0 = gamelua.objects
            r48_0.buttonObjects.mainMenuOptionsAudioBtn = {
                x = gamelua.screenWidth * 0.10000000149011612,
                y = gamelua.screenHeight * 0.8999999761581421,
                scaleX = 1,
                scaleY = 1,
                angle = 0,
                name = "mainMenuOptionsAudioBtn",
                guiObject = true,
                sprite = "BTN_PAUSE"
            }
            addEventCall("optionsMenuOpened", p48_0, 0)
            local r48_1 = gamelua.objects
            r48_1.buttonObjects.mainMenuOptionsInfoBtn = {
                x = gamelua.screenWidth * 0.10000000149011612,
                y = gamelua.screenHeight * 0.8999999761581421,
                scaleX = 1,
                scaleY = 1,
                angle = 0,
                name = "mainMenuOptionsInfoBtn",
                guiObject = true,
                sprite = "BTN_PAUSE"
            }
            addEventCall("optionsMenuOpened", p48_0, 0)
            local r48_2 = gamelua.objects
            local r48_3 = r48_2.buttonObjects.mainMenuOptionsBtn
            if r48_3 ~= nil then
                r48_3.onClicked = "optionsMenuClosed"
            end
        else
            local r48_4 = gamelua.objects
            local r48_5 = r48_4.buttonObjects.mainMenuOptionsAudioBtn
            if p48_0.time < 0.30000001192092896 then
                r48_5.y = r48_5.y - p48_0.dt * gamelua.screenHeight * 0.6000000238418579
                p48_0.time = p48_0.time + p48_0.dt
                addEventCall("optionsMenuOpened", p48_0, 0)
            elseif p48_0.time < 0.6000000238418579 then
                r48_5.y = r48_5.y - p48_0.dt * gamelua.screenHeight * 0.6000000238418579
                p48_0.time = p48_0.time + p48_0.dt
                addEventCall("optionsMenuOpened", p48_0, 0)
                local r48_6 = gamelua.objects
                local r48_7 = r48_6.buttonObjects.mainMenuOptionsInfoBtn
                r48_7.y = r48_7.y - p48_0.dt * gamelua.screenHeight * 0.6000000238418579
            end
        end
    end
}
optionsMenuClosed = {
    params = { timer = 0 },
    action = function(p49_0)
        if p49_0.time == nil then
            p49_0.time = 0
            gamelua.audioEnabled = not gamelua.audioEnabled
            local r49_0 = gamelua.objects
            local r49_1 = r49_0.buttonObjects.mainMenuOptionsBtn
            if r49_1 ~= nil then
                r49_1.onClicked = "optionsMenuOpened"
            end
            addEventCall("optionsMenuClosed", p49_0, 0)
        else
            local r49_2 = gamelua.objects
            local r49_3 = r49_2.buttonObjects.mainMenuOptionsAudioBtn
            if p49_0.time < 0.15000000596046448 then
                r49_3.y = r49_3.y + p49_0.dt * gamelua.screenHeight * 1.2000000476837158
                p49_0.time = p49_0.time + p49_0.dt
                local r49_4 = gamelua.objects
                local r49_5 = r49_4.buttonObjects.mainMenuOptionsInfoBtn
                r49_5.y = r49_5.y + p49_0.dt * gamelua.screenHeight * 1.100000023841858
                addEventCall("optionsMenuClosed", p49_0, 0)
            elseif p49_0.time < 0.30000001192092896 then
                r49_3.y = r49_3.y + p49_0.dt * gamelua.screenHeight * 1.2000000476837158
                p49_0.time = p49_0.time + p49_0.dt
                addEventCall("optionsMenuClosed", p49_0, 0)
            else
                local r49_6 = gamelua.objects
                r49_6.buttonObjects.mainMenuOptionsAudioBtn = nil
                local r49_7 = gamelua.objects
                r49_7.buttonObjects.mainMenuOptionsInfoBtn = nil
            end
        end
    end
}
optionsMenu2Opened = {
    params = { timer = 0 },
    action = function(p50_0)
        if p50_0.time == nil then
            p50_0.time = 0
            local r50_0 = gamelua.objects
            r50_0.buttonObjects.mainMenuOptions2Btn1 = {
                x = gamelua.screenWidth * 0.8999999761581421,
                y = gamelua.screenHeight * 0.8999999761581421,
                scaleX = 1,
                scaleY = 1,
                angle = 0,
                name = "mainMenuOptions2Btn1",
                guiObject = true,
                sprite = "BTN_PAUSE"
            }
            addEventCall("optionsMenu2Opened", p50_0, 0)
            local r50_1 = gamelua.objects
            r50_1.buttonObjects.mainMenuOptions2Btn2 = {
                x = gamelua.screenWidth * 0.8999999761581421,
                y = gamelua.screenHeight * 0.8999999761581421,
                scaleX = 1,
                scaleY = 1,
                angle = 0,
                name = "mainMenuOptions2Btn2",
                guiObject = true,
                sprite = "BTN_PAUSE"
            }
            addEventCall("optionsMenu2Opened", p50_0, 0)
            local r50_2 = gamelua.objects
            local r50_3 = r50_2.buttonObjects.mainMenuOptionsBtn2
            if r50_3 ~= nil then
                r50_3.onClicked = "optionsMenu2Closed"
            end
        else
            local r50_4 = gamelua.objects
            local r50_5 = r50_4.buttonObjects.mainMenuOptions2Btn1
            if p50_0.time < 0.30000001192092896 then
                r50_5.y = r50_5.y - p50_0.dt * gamelua.screenHeight * 0.6000000238418579
                p50_0.time = p50_0.time + p50_0.dt
                addEventCall("optionsMenu2Opened", p50_0, 0)
            elseif p50_0.time < 0.6000000238418579 then
                r50_5.y = r50_5.y - p50_0.dt * gamelua.screenHeight * 0.6000000238418579
                p50_0.time = p50_0.time + p50_0.dt
                addEventCall("optionsMenu2Opened", p50_0, 0)
                local r50_6 = gamelua.objects
                local r50_7 = r50_6.buttonObjects.mainMenuOptions2Btn2
                r50_7.y = r50_7.y - p50_0.dt * gamelua.screenHeight * 0.6000000238418579
            end
        end
    end
}
optionsMenu2Closed = {
    params = { timer = 0 },
    action = function(p51_0)
        if p51_0.time == nil then
            p51_0.time = 0
            local r51_0 = gamelua.objects
            local r51_1 = r51_0.buttonObjects.mainMenuOptionsBtn2
            if r51_1 ~= nil then
                r51_1.onClicked = "optionsMenu2Opened"
            end
            addEventCall("optionsMenu2Closed", p51_0, 0)
        else
            local r51_2 = gamelua.objects
            local r51_3 = r51_2.buttonObjects.mainMenuOptions2Btn1
            if p51_0.time < 0.15000000596046448 then
                r51_3.y = r51_3.y + p51_0.dt * gamelua.screenHeight * 1.2000000476837158
                p51_0.time = p51_0.time + p51_0.dt
                local r51_4 = gamelua.objects
                local r51_5 = r51_4.buttonObjects.mainMenuOptions2Btn2
                r51_5.y = r51_5.y + p51_0.dt * gamelua.screenHeight * 1.100000023841858
                addEventCall("optionsMenu2Closed", p51_0, 0)
            elseif p51_0.time < 0.30000001192092896 then
                r51_3.y = r51_3.y + p51_0.dt * gamelua.screenHeight * 1.2000000476837158
                p51_0.time = p51_0.time + p51_0.dt
                addEventCall("optionsMenu2Closed", p51_0, 0)
            else
                local r51_6 = gamelua.objects
                r51_6.buttonObjects.mainMenuOptions2Btn1 = nil
                local r51_7 = gamelua.objects
                r51_7.buttonObjects.mainMenuOptions2Btn2 = nil
            end
        end
    end
}
pigEnteredGravityArea = {
    params = { timer = 0.5 },
    action = function(p52_0)
        local r52_0 = gamelua.objects.world[p52_0.name]
        local r52_1 = gamelua.objects.world[p52_0.other]
        if gamelua.getLevelMetadata(gamelua.levelName).objectsDestroyableByTap ~= true and r52_0 ~= nil and r52_1 ~= nil and r52_1.sensorType == "gravitation" and r52_0.spriteUnfreeze ~= nil then
            r52_0.sprite = r52_0.spriteUnfreeze
            r52_0.material = r52_0.materialUnfreeze
            r52_0.disableAnimations = false
            gamelua.setSprite(r52_0.name, r52_0.sprite)
            r52_0.timeOutsideAtmosphere = 0
            r52_0.enteredState = false
            gamelua.setCurrentState(r52_0, "idleState")
            addEventCall("removeIciclesFromPig", { name = p52_0.name })
        end
    end
}
removeIciclesFromPig = {
    params = { timer = 0.5 },
    action = function(p53_0)
        if gamelua.freezingObjects.objects[p53_0.name] ~= nil then
            local r53_0 = gamelua.freezingObjects.objects[p53_0.name]
            r53_0.timer = 0
            gamelua.freezeObjects(gamelua.freezingObjects.objects, 0)
        end
    end
}
swordCollision = {
    params = { timer = 0 },
    action = function(p54_0)
        local r54_0 = gamelua.getObjectDefinition(p54_0.other)
        if r54_0 and not r54_0.ignoreSwordCollision then
            local r54_1 = gamelua.objects.world[p54_0.name]
            gamelua.setSleeping(p54_0.other, false)
            gamelua._G.table.insert(r54_1.swordTouchingObjects, { p54_0.other, p54_0.resultDamage })
            local r54_2 = gamelua.blockTable.blocks[r54_1.definition]
            collisionParticles = r54_2.particlesCollision
            local r54_3 = gamelua.worldToPhysicsTransform
            local r54_4 = gamelua._G.res.getSpriteBounds
            local r54_5, r54_6 = r54_3(r54_4(r54_1.sprite))
            local r54_7 = gamelua._G.math.cos(r54_1.angle)
            local r54_8 = gamelua._G.math.sin(r54_1.angle)
            gamelua.putParticles({
                x = r54_1.x + r54_7 * r54_5 * 0.5,
                y = r54_1.y + r54_8 * r54_5 * 0.5,
                particles = collisionParticles
            })
        end
    end
}
swordEndCollision = {
    params = { timer = 0 },
    action = function(p55_0)
        local r55_0 = gamelua.objects.world[p55_0.name]
        for r55_1, r55_2 in _G.pairs(r55_0.swordTouchingObjects) do
            local r55_3 = r55_2[1]
            local r55_4 = p55_0.other
            if r55_3 == r55_4 then
                gamelua._G.table.remove(r55_0.swordTouchingObjects, r55_1)
            end
        end
    end
}
lazerCollision = {
    params = { timer = 0 },
    action = function(p56_0)

    end
}
lazerCollisionExit = {
    params = { timer = 0 },
    action = function(p57_0)

    end
}
initEmitter = {
    params = { timer = 0 },
    action = function(p58_0)
        local r58_0
        local r58_1, r58_2 = p58_0.name, nil
        local r58_3 = getObjectDefinition(p58_0.name)
        g_emitterIndex = g_emitterIndex or 0
        g_emitterIndex = g_emitterIndex + 1
        if p58_0.objectCreated ~= true then
            local r58_4
            if p58_0.name == "F8" then
                r58_4 = createObject(gamelua.blockTable, "BLOCK_SENSOR_LAZER_EMITTER", "BLOCK_LAZER_EMITTER" .. g_emitterIndex, p58_0.spawnX * 1, p58_0.spawnY * 1, 5, 5, 5, 1, 1, nil)
            else
                r58_4 = createObject(gamelua.blockTable, "BLOCK_SENSOR_LAZER_EMITTER", "BLOCK_LAZER_EMITTER" .. g_emitterIndex, r58_2.x, r58_2.y, 5, 5, 5, 1, 1, nil)
                local r58_5 = gamelua.objects
                r58_2 = r58_5.world[p58_0.name]
            end
            setCollisionEnabled(r58_4, false)
        end
        if r58_3.isVisible == false and not gamelua.showEditor then
            gamelua.setVisible(r58_0, false)
        end
        setObjectParameter(r58_0, 21, 8)
        local r58_6
        if p58_0.parent == nil then
            r58_6 = r58_2
        else
            local r58_7 = gamelua.objects
            r58_6 = r58_7.world[p58_0.parent]
        end
        local r58_8 = gamelua.objects
        local r58_9 = r58_8.world[r58_0]
        if r58_6 then
            r58_9.parent = r58_6
            r58_9.xDelta = r58_9.x - r58_9.parent.x
            r58_9.yDelta = r58_9.y - r58_9.parent.y
        end
        r58_9.emitter = {
            timer = 0,
            emitInterval = 0,
            shotData = gamelua.deepCopy(gamelua.blockTable.blocks[r58_9.definition].shotData)
        }
        gamelua.addUpdateCall("updateEmitter", { name = r58_0 }, nil, r58_0)
    end
}
updateEmitter = {
    params = { timer = 0 },
    action = function(p59_0)
        local r59_0 = gamelua.objects.world[p59_0.name]
        if r59_0 == nil then
            return
        end
        local r59_1 = r59_0.emitter
        r59_1.timer = r59_1.timer - p59_0.dt
        local r59_2 = r59_1.emittedParticles
        r59_1.emittedParticles = r59_2 or 0
        if r59_1.birdEmitter then
            local r59_3 = p59_0.dt
            local r59_4 = gamelua.getDeltaTimeMultiplier()
            p59_0.dt = r59_3 * r59_4
        end
        local r59_5 = r59_1.shotData
        local r59_6 = r59_1.shotData[1]
        local r59_7
        if r59_6[1] then
            if r59_0.shotPattern then
                r59_7 = r59_1.shotData[r59_0.shotPattern]
            else
                r59_7 = r59_1.shotData[1]
            end
        else
            r59_7 = r59_1.shotData
        end
        if r59_0.parent then
            if not r59_1.birdEmitter then
                r59_0.xDelta = r59_0.x - r59_0.parent.x
                r59_0.yDelta = r59_0.y - r59_0.parent.y
            end
            r59_0.x = r59_0.parent.x + r59_0.xDelta
            r59_0.y = r59_0.parent.y + r59_0.yDelta
            if r59_0.updateNativePosition then
                setPosition(r59_0.name, r59_0.x, r59_0.y)
            end
        end
        local r59_8 = gamelua.g_birdEmitterTargets[r59_0.name]
        if r59_8 then
            if r59_8[3] then
                r59_8[3] = r59_8[3] - p59_0.dt
                if r59_8[3] <= 0 then
                    gamelua.g_birdEmitterTargets[r59_0.name] = nil
                end
            elseif r59_8[4] and r59_1.emittedParticles == #r59_7 then
                r59_8[4] = r59_8[4] - r59_1.shotSpeed * p59_0.dt
                if r59_8[4] <= 0 then
                    gamelua.g_birdEmitterTargets[r59_0.name] = nil
                end
            end
        end
        if r59_1.altSpriteResetTimer then
            r59_1.altSpriteResetTimer = r59_1.altSpriteResetTimer - p59_0.dt
            if r59_1.altSpriteResetTimer <= 0 then
                gamelua.setSprite(r59_0.name, r59_0.sprite)
                r59_1.altSpriteResetTimer = nil
            end
        end
        if r59_1.timer <= 0 then
            r59_1.timer = r59_1.emitInterval + r59_1.timer
            for r59_9, r59_10 in _G.ipairs(r59_7) do
                r59_10.currentTime = r59_10.currentTime - p59_0.dt
                if r59_10.currentTime <= 0 then
                    local r59_11 = r59_1.emittedParticles
                    r59_1.emittedParticles = r59_11 + 1
                    local r59_12 = gamelua.blockTable.blocks[r59_10.block]
                    local r59_13 = gamelua.blockTable.blocks[r59_0.definition]
                    local r59_14 = r59_13.laserSound or r59_12.createSound
                    playAudio(r59_14)
                    local r59_15 = createObject(gamelua.blockTable, r59_10.block, "EMITTED_" .. (r59_0.name .. "" .. r59_10.block) .. "_" .. r59_1.emittedParticles, r59_0.x, r59_0.y, r59_12.radius, r59_12.width, r59_12.height, r59_12.scaleX or 1.5, r59_12.scaleY or 1.5, r59_12.vertices)
                    if r59_1.birdEmitter then
                        setObjectParameter(r59_15, 21, 7)
                    else
                        setObjectParameter(r59_15, 21, 5)
                    end
                    setObjectParameter(r59_15, 16, 1)
                    local r59_16 = gamelua.objects
                    local r59_17 = r59_16.world[r59_15]
                    r59_17.isProjectile = true
                    r59_17.emitterName = r59_0.name
                    local r59_18 = _G.math.abs
                    r59_17.startDt = r59_18(r59_10.currentTime)
                    r59_10.currentTime = r59_10.timeInterval + r59_10.currentTime
                    if r59_10.shotTargetCoordinates == nil then
                        local r59_19 = _G.math.random(r59_10.angle[1], r59_10.angle[2])
                        local r59_20 = r59_0.angle
                        local r59_21 = _G.math.rad(r59_19) + r59_20
                        local r59_22 = _G.math.cos
                        r59_17.movementAngleX = r59_22(r59_21)
                        local r59_23 = _G.math.sin
                        r59_17.movementAngleY = r59_23(r59_21)
                        setRotation(r59_17.name, r59_21)
                    else
                        local r59_24 = r59_10.shotTargetCoordinates[1]
                        local r59_25 = r59_0.x
                        local r59_26 = r59_24 - r59_25
                        local r59_27 = r59_10.shotTargetCoordinates[2]
                        local r59_28 = r59_0.y
                        local r59_29 = r59_27 - r59_28
                        local r59_30 = _G.math.atan2(r59_29, r59_26)
                        local r59_31 = _G.math.cos
                        r59_17.movementAngleX = r59_31(r59_30)
                        local r59_32 = _G.math.sin
                        r59_17.movementAngleY = r59_32(r59_30)
                        setRotation(r59_17.name, r59_30)
                    end
                    local r59_33, r59_34 = _G.res.getSpriteBounds(r59_17.sprite)
                    local r59_35 = gamelua.worldToPhysicsTransform(r59_33, r59_34)
                    r59_17.x = r59_0.x
                    r59_17.y = r59_0.y
                    r59_17.timeCreatedMilliseconds = gamelua.time
                    gamelua.setPosition(r59_17.name, r59_17.x, r59_17.y)
                    local r59_36 = gamelua.blockTable.blocks[r59_17.definition]
                    if r59_10.shotTargetCoordinates and not r59_36.turboLaser then
                        local r59_37 = r59_17.x
                        local r59_38 = r59_10.shotTargetCoordinates[1]
                        local r59_39 = r59_37 - r59_38
                        local r59_40 = r59_17.y
                        local r59_41 = r59_10.shotTargetCoordinates[2]
                        local r59_42 = r59_40 - r59_41
                        local r59_43 = _G.math.sqrt(r59_39 * r59_39 + r59_42 * r59_42)
                        local r59_44 = nil
                        local r59_45 = gamelua.g_birdEmitterTargets[r59_0.name]
                        if r59_45 then
                            local r59_46
                            r59_44 = r59_46[6]
                        end
                        if r59_0.parent then
                            if not r59_10.doNotDrawTarget then
                                gamelua.g_birdEmitterTargets[r59_0.name] = {
                                    r59_10.shotTargetCoordinates[1],
                                    r59_10.shotTargetCoordinates[2],
                                    nil,
                                    r59_43,
                                    gamelua.blockTable.blocks[r59_0.parent.definition].reticleSprite,
                                    r59_44
                                }
                            end
                        else
                            gamelua.g_birdEmitterTargets[r59_0.name] = {
                                r59_10.shotTargetCoordinates[1],
                                r59_10.shotTargetCoordinates[2],
                                nil,
                                r59_43,
                                nil,
                                r59_44
                            }
                        end
                        if r59_36.birdShot then
                            r59_17.birdShot = r59_36.birdShot
                        end
                    end
                    if r59_10.startImpulse then
                        local r59_47 = r59_17.movementAngleX * r59_10.startImpulse
                        gamelua.applyImpulse(r59_17.name, r59_47, r59_17.movementAngleY * r59_10.startImpulse, r59_17.x, r59_17.y)
                    end
                    local r59_48 = gamelua.getObjectDefinition(r59_0.name)
                    if r59_48 and r59_48.sendEventOnEmit then
                        local r59_49 = nil
                        if r59_0.parent and r59_0.parent.name then
                            r59_49 = r59_0.parent.name
                        end
                        local r59_50 = gamelua.eventManager
                        local r59_51 = {
                            id = gamelua.events.EID_PARTICLE_EMITTED,
                            emitterName = r59_0.name,
                            parentName = r59_49
                        }
                        r59_50:notify(r59_51)
                    end
                    if r59_10.speed then
                        r59_17.speed = _G.math.random(r59_10.speed[1], r59_10.speed[2])
                        gamelua.addUpdateCall("moveEmittedParticle", { name = r59_15 }, nil, r59_15)
                    end
                    local r59_52 = #r59_7
                    if r59_9 == r59_52 and r59_1.deleteEmitterAfterEmitting then
                        gamelua.destroyEmitter(r59_0)
                    end
                    if r59_10.altSprite then
                        gamelua.setSprite(r59_0.name, r59_10.altSprite)
                        r59_1.altSpriteResetTimer = r59_10.altSpriteDuration
                    end
                end
            end
        end
    end
}
print = gamelua.print
loginfo = gamelua.loginfo

-- line 1399-1570
-- proto#60 params=1 locals=70 upvalues=0 vararg=false
function collideLaser(p60_0)
    local r60_0 = gamelua.blockTable.blocks[p60_0.definition]
    local r60_1 = gamelua.blockTable.materials[r60_0.material]
    local r60_2, r60_3 = p60_0.laserCollisions, nil
    if r60_2 then
        local r60_4, r60_5, r60_6 = _G.ipairs(p60_0.laserCollisions)
        r60_3 = nil
        for r60_7, r60_8 in r60_4, r60_5, r60_6 do
            local r60_9 = gamelua.objects.world[r60_8.name]
            if r60_9 then
                local r60_10
                if r60_9.controllable then
                    local r60_11 = r60_9.birdShot
                    if r60_11 then
                        r60_10 = r60_11
                    else
                        r60_10 = p60_0.birdShot
                    end
                else
                    local r60_12 = p60_0.controllable
                    if r60_12 then
                        local r60_13 = r60_9.birdShot
                        if r60_13 then
                            r60_10 = r60_13
                        else
                            r60_10 = p60_0.birdShot
                        end
                    else
                        r60_10 = r60_12
                    end
                end
                local r60_14 = gamelua.blockTable.blocks[r60_9.definition]
                local r60_15 = gamelua.blockTable.materials[r60_14.material]
                if not r60_14.strength then
                    local r60_16 = r60_15.strength
                end
                local r60_17 = gamelua.blockTable.damageFactors[p60_0.damageFactors]
                local r60_18 = r60_17.damageMultiplier[r60_14.material]
                if not r60_18 then
                    r60_18 = 1
                end
                if not (r60_9.strength <= 0) then
                    if p60_0.strength <= 0 then
                        return r60_3
                    end
                    if not r60_14.ignoreLaserCollision and not r60_9.ignoreLaserCollision then
                        local r60_19 = gamelua.blockTable.blocks[p60_0.definition]
                        if r60_19.turboLaser and (r60_9.material == "staticGround" or r60_9.material == "staticGroundIce" or r60_9.material == "planet" or r60_9.material == "materialEggsteroid" or r60_9.material == "dropStone") then
                            return r60_3
                        end
                        if r60_10 then
                            gamelua.checkForLaserShotAchievements(p60_0, r60_9)
                        end
                        local r60_20 = false
                        if r60_15.bouncesLaser ~= nil then
                            r60_20 = r60_15.bouncesLaser
                        end
                        local r60_21
                        if r60_14.bouncesLaser == nil then
                            r60_21 = r60_20
                        else
                            r60_21 = r60_14.bouncesLaser
                        end
                        local r60_22
                        if r60_9.bouncesLaser == nil then
                            r60_22 = r60_21
                        else
                            r60_22 = r60_9.bouncesLaser
                        end
                        local r60_23 = r60_22 and r60_0.turboLaser ~= true
                        local r60_24 = r60_9.strength
                        local r60_25
                        if r60_23 and not p60_0.bounceAngle then
                            playAudio("ingame_lazerbouncing")
                            p60_0.hasCollided = true
                            r60_3 = r60_3 or r60_8
                            local r60_26 = _G.math.min(r60_0.damageDoneOnBounce, p60_0.strength)
                            local r60_27 = p60_0.strength
                            p60_0.strength = r60_27 - r60_26
                            local r60_28 = _G.math.max
                            local r60_29 = r60_26 * r60_18
                            local r60_30 = r60_14.defence or r60_15.defence
                            local r60_31 = r60_28(r60_29 - r60_30, 0)
                            local r60_32 = r60_9.strength
                            r60_9.strength = r60_32 - r60_31
                            r60_25 = r60_25 + r60_31
                            local r60_33 = gamelua.dotProduct(r60_9.rayCastNormalX, r60_9.rayCastNormalY, p60_0.movementAngleX, p60_0.movementAngleY)
                            local r60_34 = 2 * r60_33
                            local r60_35 = p60_0.movementAngleX
                            local r60_36 = r60_9.rayCastNormalX
                            local r60_37 = r60_35 - r60_36 * r60_34
                            local r60_38 = p60_0.movementAngleY
                            local r60_39 = r60_9.rayCastNormalY
                            local r60_40 = r60_38 - r60_39 * r60_34
                            local r60_41 = _G.math.atan2(r60_40, r60_37)
                            local r60_42 = _G.math.cos
                            p60_0.movementAngleX = r60_42(r60_41)
                            local r60_43 = _G.math.sin
                            p60_0.movementAngleY = r60_43(r60_41)
                            p60_0.bounceAngle = r60_41
                            local r60_44 = r60_1.bouncingSound
                            if r60_44 then
                                playAudio(r60_44)
                            end
                            local r60_45 = p60_0.strength * r60_18
                            if r60_14.onLaserCollision then
                                gamelua.fireAction(r60_14.onLaserCollision, {
                                    name = r60_9.name,
                                    obj = r60_9,
                                    other = p60_0,
                                    force = r60_45,
                                    resultDamage = r60_31,
                                    dot = gamelua.dotProduct(r60_9.rayCastNormalX, r60_9.rayCastNormalY, p60_0.movementAngleX, p60_0.movementAngleY)
                                })
                            end
                        elseif p60_0.bounceAngle then
                            if p60_0.ignoreCollisions == nil then
                                p60_0.ignoreCollisions = {}
                            end
                            p60_0[r60_9.name] = true
                        elseif not r60_10 and r60_9.collisionEnabled ~= 0 then
                            local r60_46 = r60_9.strength / r60_18
                            local r60_47 = r60_14.defence or r60_15.defence
                            local r60_48 = r60_47 / r60_18
                            local r60_49 = p60_0.strength * r60_18
                            local r60_50 = p60_0.strength
                            local r60_51 = _G.math.min(r60_46 + r60_48, r60_50) - r60_48
                            local r60_52 = p60_0.strength
                            p60_0.strength = r60_52 - r60_48
                            local r60_53 = r60_51 * r60_18
                            local r60_54 = r60_9.strength
                            r60_9.strength = r60_54 - r60_53
                            local r60_55 = p60_0.strength
                            p60_0.strength = r60_55 - r60_51
                            r60_25 = r60_25 + r60_53
                            if r60_14.onLaserCollision then
                                gamelua.fireAction(r60_14.onLaserCollision, {
                                    name = r60_9.name,
                                    obj = r60_9,
                                    other = p60_0,
                                    force = r60_49,
                                    resultDamage = r60_53,
                                    dot = gamelua.dotProduct(r60_9.rayCastNormalX, r60_9.rayCastNormalY, p60_0.movementAngleX, p60_0.movementAngleY)
                                })
                            end
                            local r60_56 = r60_1.collisionSound
                            if r60_56 then
                                playAudio(r60_56)
                            end
                            if not r60_3 then
                                r60_3 = r60_8
                            end
                        end
                        if not r60_10 then
                            gamelua.updateDamageSprite(r60_9)
                            if r60_25 > 0 then
                                local r60_57 = _G.math.floor(r60_25) * 5
                                gamelua.addScore(r60_57, p60_0.x, p60_0.y)
                            end
                            if r60_9.strength <= 0 then
                                gamelua.setSleeping(r60_9.name, false)
                                destroyObject(r60_9.name)
                            end
                        end
                        gamelua.checkForLaserShotAchievements(p60_0, r60_9)
                    end
                end
            end
        end
    end
    return r60_3
end

-- line 1572-1688
-- proto#61 params=2 locals=43 upvalues=0 vararg=false
function stepLaser(p61_0, p61_1)
    if p61_1 == 0 or p61_0 == nil or p61_0 ~= nil and p61_0.dead then
        return
    end
    local r61_0 = 1
    if p61_0.birdShot then
        local r61_1 = 0.5
        if gamelua.getDeltaTimeMultiplier() < 1 then
            r61_0 = gamelua.getDeltaTimeMultiplier() * r61_1 + 1 - r61_1
        end
    end
    local r61_2 = p61_0
    local r61_3 = gamelua.blockTable.blocks[r61_2.definition]
    local r61_4 = gamelua.blockTable.materials[r61_3.material]
    p61_0.oldX = p61_0.x
    p61_0.oldY = p61_0.y
    local r61_5 = p61_1
    if r61_0 ~= 0 then
        r61_5 = p61_1 / r61_0
    end
    local r61_6 = p61_0.movementAngleX
    local r61_7 = r61_5 * r61_6
    local r61_8 = p61_0.speed
    local r61_9 = r61_7 * r61_8
    local r61_10 = p61_0.x + r61_9
    local r61_11 = p61_0.y + r61_5 * p61_0.movementAngleY * p61_0.speed
    local r61_12, r61_13 = _G.res.getSpriteBounds(p61_0.sprite)
    local r61_14, r61_15 = gamelua.worldToPhysicsTransform(r61_12, r61_13)
    local r61_16 = gamelua.getRayCastedObjects
    local r61_17 = {
        x1 = -r61_14 * 0.4000000059604645 * p61_0.movementAngleX + p61_0.x,
        y1 = -r61_14 * 0.4000000059604645 * p61_0.movementAngleY + p61_0.y,
        x2 = r61_10,
        y2 = r61_11,
        source = p61_0.name
    }
    local r61_18 = r61_16(r61_17)
    local r61_19 = nil
    if r61_18[1] then
        local r61_20 = p61_0.ignoreCollisions
        p61_0.ignoreCollisions = r61_20 or {}
        p61_0.laserCollisions = {}
        for r61_21 = 1, #r61_18, 6 do
            local r61_22 = gamelua.objects.world[r61_18[r61_21]]
            r61_22.rayCastFraction = r61_18[r61_21 + 5]
            r61_22.rayCastNormalX = r61_18[r61_21 + 3]
            r61_22.rayCastNormalY = r61_18[r61_21 + 4]
            r61_22.rayCastContactX = r61_18[r61_21 + 1]
            r61_22.rayCastContactY = r61_18[r61_21 + 2]
            _G.table.insert(p61_0.laserCollisions, r61_22)
        end
        if #p61_0.laserCollisions > 1 then
            _G.table.sort(p61_0.laserCollisions, function(p62_0, p62_1)
                local r62_0 = p62_0.rayCastFraction
                local r62_1 = p62_1.rayCastFraction
                return r62_0 < r62_1
            end)
        end
        local r61_23 = collideLaser(p61_0)
        if r61_23 and gamelua.objects.world[r61_23.name].controllable ~= true and gamelua.objects.world[r61_23.name].strength > 0 then
            local r61_24 = r61_23.rayCastContactX
            local r61_25 = r61_23.rayCastContactY
            local r61_26 = p61_0.movementAngleX
            r61_10 = r61_24 + r61_26 * r61_14 * 0.5
            local r61_27 = p61_0.movementAngleY
            r61_11 = r61_25 + r61_27 * r61_14 * 0.5
        end
    end
    p61_0.x = r61_10
    p61_0.y = r61_11
    setPosition(p61_0.name, p61_0.x, p61_0.y)
    if p61_0.bounceAngle then
        p61_0.angle = p61_0.bounceAngle
        setRotation(p61_0.name, p61_0.angle)
        p61_0.bounceAngle = nil
    end
    if r61_19 then
        local r61_28 = r61_3.particlesCollision
        if r61_28 then
            gamelua.putParticles({ x = r61_2.x, y = r61_2.y, particles = r61_28 })
        end
    end
    p61_0.laserCollisions = nil
    if p61_0.strength <= 0 then
        p61_0.dead = true
        gamelua.setVisible(p61_0.name, false)
        destroyObject(p61_0.name, true)
    end
    if r61_19 and r61_19.rayCastFraction > 0 then
        stepLaser(p61_0, p61_1 * (1 - r61_19.rayCastFraction))
    end
end

moveEmittedParticle = {
    params = { timer = 0 },
    action = function(p63_0)
        local r63_0 = gamelua.objects.world[p63_0.name]
        if r63_0 then
            gamelua.setActive(r63_0.name, true)
            gamelua.setSleeping(r63_0.name, false)
            if r63_0.timeCreatedMilliseconds then
                p63_0.dt = p63_0.dt + (gamelua.time - r63_0.timeCreatedMilliseconds)
                r63_0.timeCreatedMilliseconds = nil
            end
            if r63_0.startDt then
                p63_0.dt = p63_0.dt + r63_0.startDt
                r63_0.startDt = nil
            end
            stepLaser(r63_0, p63_0.dt)
        end
    end
}
destroyProjectile = {
    params = { timer = 0 },
    action = function(p64_0)

    end
}
emptyFunction = {
    params = { timer = 0 },
    action = function(p65_0)

    end
}
tieFighterWingCollided = {
    params = { timer = 0 },
    action = function(p66_0)
        gamelua.checkForWingPoppedPigAchievement(p66_0)
    end
}
mynockCollided = {
    params = { timer = 0 },
    action = function(p67_0)
        gamelua.checkForMynockCollisionAchievement(p67_0)
    end
}
removeGravityFilterCategory = {
    params = { timer = 0 },
    action = function(p68_0)
        p68_0.obj.gravityFilterCategory = "NORMAL_OBJECT"
        if not (p68_0.obj.gravityFilterCategory == nil or gamelua.g_gravityFiltersCategories[p68_0.obj.gravityFilterCategory] == nil) then
            gamelua.setObjectGravityCategory(p68_0.obj.name, gamelua.g_gravityFiltersCategories[p68_0.obj.gravityFilterCategory])
            gamelua.setSleeping(p68_0.obj.name, false)
        end
    end
}
applyImpulseUp = {
    params = { timer = 0 },
    action = function(p69_0)
        gamelua.applyImpulse(p69_0.obj.name, 0, -100, p69_0.obj.x, p69_0.obj.y)
    end
}
toggleActiveState = {
    params = { timer = 0 },
    action = function(p70_0)
        if checkStillInWorld(p70_0.obj.name) then
            local r70_0 = gamelua.objects.world
            local r70_1 = p70_0.obj
            local r70_2 = r70_0[r70_1.name]
            local r70_3 = false
            if r70_2.active ~= nil then
                local r70_4 = r70_2.active
                r70_3 = not r70_4
            end
            gamelua.setGameObjectActive(r70_2.name, r70_3)
        end
    end
}
adjustSensorActiveState = {
    params = { timer = 0 },
    action = function(p71_0)
        if checkStillInWorld(p71_0.name) then
            local r71_0 = gamelua.objects.world[p71_0.name]
            if r71_0.active then
                gamelua.setObjectParameter(p71_0.name, 22, 1)
            else
                gamelua.setObjectParameter(p71_0.name, 22, 0)
            end
        end
    end
}
pigTieFighterExploded = {
    params = { timer = 0 },
    action = function(p72_0)
        local r72_0 = p72_0.obj
        local r72_1 = gamelua.blockTable.blocks[r72_0.definition]
        local r72_2 = r72_0.angle
        local r72_3 = r72_1.angleOffset
        local r72_4 = r72_2 + r72_3
        local r72_5 = { x = _G.math.sin(r72_4), y = _G.math.cos(r72_4) }
        local r72_6, r72_7 = vNormalize(r72_5.x, r72_5.y)
        r72_5.y = r72_7
        r72_5.x = r72_6
        local r72_8 = {
            x = _G.math.sin(r72_4 + _G.math.pi / 2),
            y = _G.math.cos(r72_4 + _G.math.pi / 2)
        }
        local r72_9, r72_10 = vNormalize(r72_8.x, r72_8.y)
        r72_8.y = r72_10
        r72_8.x = r72_9
        local r72_11, r72_12, r72_13 = gamelua.blockTable, gamelua.objects, r72_1.spawnedObjects[1]
        local r72_14 = createObject(r72_11, r72_13, r72_11.blocks[r72_13].name, r72_0.x - r72_5.x * r72_1.spawnDistance, r72_0.y + r72_5.y * r72_1.spawnDistance)
        if not gamelua.isInGameMode() then
            r72_12.world[r72_14].isMainMenuObject = true
            r72_12.destroyableByTap[#r72_12.destroyableByTap + 1] = r72_14
        end
        setRotation(gamelua.objects.world[r72_14].name, r72_0.angle)
        applyImpulse(r72_14, -r72_5.x * r72_1.explosionForce, r72_5.y * r72_1.explosionForce, gamelua.objects.world[r72_14].x + r72_8.x * 10, gamelua.objects.world[r72_14].y + r72_8.y * 10)
        p72_0.wingL = r72_14
        local r72_15 = r72_1.spawnedObjects[2]
        local r72_16 = createObject(r72_11, r72_15, r72_11.blocks[r72_15].name, r72_0.x + r72_5.x * r72_1.spawnDistance, r72_0.y - r72_5.y * r72_1.spawnDistance)
        if not gamelua.isInGameMode() then
            r72_12.world[r72_16].isMainMenuObject = true
            r72_12.destroyableByTap[#r72_12.destroyableByTap + 1] = r72_16
        end
        setRotation(gamelua.objects.world[r72_16].name, r72_0.angle)
        applyImpulse(r72_16, r72_5.x * r72_1.explosionForce, -r72_5.y * r72_1.explosionForce, gamelua.objects.world[r72_16].x + r72_8.x * 10, gamelua.objects.world[r72_16].y + r72_8.y * 10)
        p72_0.wingR = r72_16
        addEventCall("PigTieFighterWingParticles", p72_0, 0.10000000149011612)
    end
}
PigTieFighterWingParticles = {
    params = { timer = 0 },
    action = function(p73_0)
        local r73_0 = p73_0.wingTimer
        p73_0.wingTimer = r73_0 or 0
        local r73_1 = p73_0.wingTimer
        p73_0.wingTimer = r73_1 + 1
        putParticles({
            objectName = p73_0.wingR,
            particles = "tieFighterSparkBuffRight",
            amount = 3
        })
        putParticles({ objectName = p73_0.wingL, particles = "tieFighterSparkBuffLeft", amount = 3 })
        if p73_0.wingTimer < 15 then
            addEventCall("PigTieFighterWingParticles", p73_0, 0.10000000149011612)
        end
    end
}
spawnDamagedYoda = {
    params = { timer = 0 },
    action = function(p74_0)
        local r74_0 = p74_0.obj
        local r74_1 = gamelua.blockTable.blocks[r74_0.definition]
        local r74_2, r74_3, r74_4 = r74_0.angle, gamelua.blockTable, r74_1.spawnedObjects[1]
        local r74_5 = createObject(r74_3, r74_4, r74_3.blocks[r74_4].name, r74_0.x, r74_0.y)
        setRotation(gamelua.objects.world[r74_5].name, r74_0.angle)
        local r74_6, r74_7 = gamelua.getLinearVelocity(r74_0.name)
        setVelocity(gamelua.objects.world[r74_5].name, r74_6, r74_7)
    end
}
steamAreaEnteredRemoveBreakableJoints = {
    params = { timer = 0 },
    action = function(p75_0)
        local r75_0 = getObjectDefinition(p75_0.other)
        local r75_1 = getObjectDefinition(p75_0.name)
        steamAreaEntered.action(p75_0)
        for r75_2, r75_3 in _G.ipairs(r75_1.onTriggerEnterRemoveList) do
            local r75_4 = r75_0.definition
            if r75_3 == r75_4 then
                gamelua.removeBreakableJointsFromObject(p75_0.other, 999999995904)
            end
        end
    end
}
steamAreaEntered = {
    params = { timer = 0 },
    action = function(p76_0)
        local r76_0 = getObjectDefinition(p76_0.other)
        local r76_1 = getObjectDefinition(p76_0.name)
        if r76_0.triggerEnterSfx and not r76_1.resistsSteamSound then
            playAudio(r76_0.triggerEnterSfx)
        end
        if r76_1.triggerEnterSfx and not r76_0.resistsSteamSound then
            playAudio(r76_1.triggerEnterSfx)
        end
    end
}
steamAreaExitted = {
    params = { timer = 0 },
    action = function(p77_0)
        local r77_0 = getObjectDefinition(p77_0.other)
        local r77_1 = getObjectDefinition(p77_0.name)
        if r77_0.triggerExitSfx then
            playAudio(r77_0.triggerExitSfx)
        end
        if r77_1.triggerExitSfx then
            playAudio(r77_1.triggerExitSfx)
        end
    end
}
splitToObjects = {
    params = { timer = 0 },
    action = function(p78_0)
        local r78_0, r78_1
        local r78_2 = p78_0.obj
        local r78_3 = gamelua.blockTable.blocks[r78_2.definition]
        local r78_4, r78_5 = r78_2.angle, gamelua.blockTable
        local r78_6 = { x = _G.math.cos(r78_4), y = _G.math.sin(r78_4) }
        local r78_7, r78_8 = vNormalize(r78_6.x, r78_6.y)
        r78_6.y = r78_8
        r78_6.x = r78_7
        local r78_9, r78_10, r78_11 = r78_3.spawnedObjects[1], 1, 1
        local r78_12 = r78_5.blocks[r78_9].type
        local r78_13
        local r78_14
        if r78_12 == "box" then
            local r78_15 = r78_5.blocks[r78_9]
            local r78_16 = r78_15.width
            r78_0 = r78_5.blocks[r78_9].height
            r78_13 = r78_16
            r78_14 = r78_0
        else
            r78_13 = r78_10
            r78_14 = r78_11
        end
        if r78_12 == "box" then
            r78_14 = r78_0
        else
            r78_14 = r78_11
        end
        local r78_17 = r78_5.blocks[r78_9].type
        local r78_18
        local r78_19
        if r78_17 == "circle" then
            local r78_20 = r78_5.blocks[r78_9].radius * 2
            r78_1 = r78_5.blocks[r78_9].radius * 2
            r78_18 = r78_20
            r78_19 = r78_1
        else
            r78_18 = r78_13
            r78_19 = r78_14
        end
        if r78_17 == "circle" then
            r78_19 = r78_1
        else
            r78_19 = r78_14
        end
        local r78_21 = _G.math.floor(r78_3.width / r78_18 + 0.5)
        local r78_22 = _G.math.floor(r78_3.height / r78_19 + 0.5)
        if r78_21 < 1 then
            r78_21 = 1
        end
        if r78_22 < 1 then
            r78_22 = 1
        end
        for r78_23 = 1, r78_22 do
            local r78_24 = r78_23 * r78_19 - r78_19 / 2 - r78_22 * (r78_19 / 2)
            for r78_25 = 1, r78_21 do
                local r78_26 = r78_25 * r78_18 - r78_18 / 2 - r78_21 * (r78_18 / 2)
                local r78_27 = _G.math.cos(r78_4 - 3.140000104904175)
                local r78_28 = _G.math.sin(r78_4 - 3.140000104904175)
                local r78_29 = _G.math.cos(r78_4 - 3.140000104904175)
                local r78_30 = _G.math.sin(r78_4 - 3.140000104904175)
                local r78_31 = createObject(r78_5, r78_9, r78_5.blocks[r78_9].name, r78_2.x + (r78_26 * r78_27 - r78_24 * r78_28), r78_2.y + (r78_24 * r78_29 + r78_26 * r78_30))
                setRotation(gamelua.objects.world[r78_31].name, r78_2.angle)
                local r78_32, r78_33 = gamelua.getLinearVelocity(r78_2.name)
                setVelocity(gamelua.objects.world[r78_31].name, r78_32, r78_33)
            end
        end
    end
}
endorDrumCollision = {
    params = { timer = 0 },
    action = function(p79_0)
        _G.themeSystem.spawnFGLayerParticles(1)
        _G.themeSystem.spawnFGLayerParticles(2)
        gamelua.putParticles({
            objectName = p79_0.name,
            particles = "ewoks_light",
            amount = gamelua.particleTable.particles.ewoks_light.amount
        })
        if gamelua.levelName ~= "LevelSelection" then
            gamelua.SettingsWrapper:addDrumlevelCollision(gamelua.levelName)
            local r79_0 = gamelua.SettingsWrapper:getDrumlevelCollisions(gamelua.levelName)
            local r79_1 = gamelua.getAchievementLimit("Call the ewoks")
            if r79_0 == r79_1 then
                gamelua.registerAchievement("Call the ewoks")
            end
        end
    end
}
endorDrumCreated = {
    params = { timer = 0 },
    action = function(p80_0)
        if gamelua.levelName ~= "LevelSelection" then
            gamelua.SettingsWrapper:resetDrumlevelCollisions()
        end
    end
}
