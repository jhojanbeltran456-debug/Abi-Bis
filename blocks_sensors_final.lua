-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

sensorBlocks = {
    {
        definition = "STREAM_1",
        type = "line",
        sprite = "TRAIL_WHITE_1",
        scale = 1,
        nodes = {},
        vertices = {},
        canBeEdited = true,
        material = "sensor",
        sensorType = "stream",
        force = 200,
        radius = 60,
        active = true
    },
    {
        definition = "BLOCK_SENSOR_PIG_B",
        type = "circle",
        sprite = "GRAVITY_SENSOR_BLUE_2",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 13,
        sensorType = "pig",
        z_order = 0,
        scale = 0,
        onTriggerEnter = "pigSensorBEntered",
        onTriggerExit = "pigSensorBExited"
    },
    {
        definition = "BLOCK_SENSOR_PIG_A",
        type = "circle",
        sprite = "GRAVITY_SENSOR_BLUE_2",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 7.5,
        sensorType = "pig",
        z_order = 0,
        scale = 0,
        onTriggerEnter = "pigSensorAEntered",
        onTriggerExit = "pigSensorAExited"
    },
    {
        definition = "BLOCK_SENSOR_PIG_B_2",
        type = "circle",
        sprite = "GRAVITY_SENSOR_BLUE_2",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 1.5,
        sensorType = "pig",
        z_order = 0,
        scale = 0,
        onTriggerEnter = "pigSensorBEntered",
        onTriggerExit = "pigSensorBExited"
    },
    {
        definition = "BLOCK_SENSOR_PIG_A_2",
        type = "circle",
        sprite = "GRAVITY_SENSOR_BLUE_2",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 1,
        sensorType = "pig",
        z_order = 0,
        scale = 0,
        onTriggerEnter = "pigSensorAEntered",
        onTriggerExit = "pigSensorAExited"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION",
        type = "circle",
        sprite = "GRAVITY_SENSOR_BLUE_2",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 100,
        sensorType = "gravitation",
        gravitationForce = 300,
        gravitationMinForce = 200,
        gravitationMaxForce = 300,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1.5,
        ignoreFilter = { "COIN_1", "BLOCK_SENSOR_DYNAMIC_GRAVITATION" },
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_WATER",
        type = "circle",
        sprite = "GRAVITY_SENSOR_BLUE_2",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 50,
        sensorType = "gravitation",
        gravitationForce = -300,
        gravitationMinForce = -200,
        gravitationMaxForce = -300,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 3,
        ignoreFilter = { "COIN_1", "BLOCK_SENSOR_DYNAMIC_GRAVITATION" },
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        onTriggerEnter = "waterCollision"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_BOX",
        type = "box",
        sprite = "GRAVITY_SENSOR_BLUE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 160,
        height = 160,
        sensorType = "gravitation",
        gravitationForce = 300,
        gravitationMinForce = 105,
        gravitationMaxForce = 105,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1,
        forceAngle = 0,
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        isVisible = false
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_BOX_BESPIN",
        type = "box",
        sprite = "GRAVITY_SENSOR_BLUE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 160,
        height = 160,
        sensorType = "gravitation",
        gravitationForce = 300,
        gravitationMinForce = 105,
        gravitationMaxForce = 105,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1,
        forceAngle = 0,
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        isVisible = false,
        onTriggerEnter = "steamAreaEntered",
        triggerEnterSfx = "steam_generator",
        onActiveStateChange = "adjustSensorActiveState"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_BOX_BESPIN_MOVING",
        type = "box",
        sprite = "GRAVITY_SENSOR_BLUE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 160,
        height = 160,
        sensorType = "gravitation",
        gravitationForce = 300,
        gravitationMinForce = 105,
        gravitationMaxForce = 105,
        density = 0.000000000009999999960041972,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1,
        forceAngle = 0,
        strength = 1,
        defence = 1000000,
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        isVisible = false,
        resistsExplosion = true,
        onTriggerEnter = "steamAreaEnteredRemoveBreakableJoints",
        onTriggerEnterRemoveList = { "BESPIN_PLATFORM_SMALL_2", "PIG_SW_BOBA_FETT" },
        triggerEnterSfx = "steam_generator",
        onActiveStateChange = "adjustSensorActiveState"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_BOX_DS2_MOVING",
        type = "box",
        sprite = "GRAVITY_SENSOR_BLUE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 160,
        height = 160,
        sensorType = "gravitation",
        gravitationForce = 300,
        gravitationMinForce = 105,
        gravitationMaxForce = 105,
        density = 0.000000000009999999960041972,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1,
        forceAngle = 0,
        strength = 1,
        defence = 1000000,
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        isVisible = false,
        resistsExplosion = true,
        onTriggerEnter = "steamAreaEnteredRemoveBreakableJoints",
        onTriggerEnterRemoveList = { "BESPIN_PLATFORM_SMALL_2", "PIG_SW_BOBA_FETT" },
        triggerEnterSfx = "energygenerator_bounce",
        onActiveStateChange = "adjustSensorActiveState"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_BOX_EMPERORBOSS_MOVING",
        type = "box",
        sprite = "GRAVITY_SENSOR_BLUE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 160,
        height = 160,
        sensorType = "gravitation",
        gravitationForce = 300,
        gravitationMinForce = 105,
        gravitationMaxForce = 105,
        density = 0.000000000009999999960041972,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1,
        forceAngle = 0,
        strength = 1,
        defence = 1000000,
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        isVisible = false,
        resistsExplosion = true,
        onTriggerEnter = "steamAreaEnteredRemoveBreakableJoints",
        onTriggerEnterRemoveList = { "BESPIN_PLATFORM_SMALL_2", "PIG_SW_BOBA_FETT" },
        onActiveStateChange = "adjustSensorActiveState"
    },
    {
        definition = "BLOCK_SENSOR_GRAVITATION_BOX_ENDOR2",
        type = "box",
        sprite = "GRAVITY_SENSOR_BLUE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 3,
        height = 160,
        sensorType = "dummy",
        gravitationForce = 300,
        gravitationMinForce = 105,
        gravitationMaxForce = 105,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 1,
        forceAngle = 0,
        active = true,
        gravityCollisionMask = "GRAVITATION_SENSOR",
        isVisible = false,
        onTriggerEnter = "d2DeathStarLaserEntered",
        onTriggerExit = "d2DeathStarLaserExited"
    },
    {
        definition = "BLOCK_SENSOR_KILLING_BOX",
        type = "box",
        sprite = "BIRD_HOMING_YELL",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        width = 160,
        height = 160,
        sensorType = "killing",
        z_order = 0,
        scale = 1,
        active = true
    },
    {
        definition = "BLOCK_SENSOR_DYNAMIC_GRAVITATION",
        type = "circle",
        sprite = "GRAVITY_SENSOR_GREEN_2",
        controllable = false,
        ignoreBirds = true,
        isSensor = true,
        material = "dynamicSensor",
        radius = 20,
        sensorType = "gravitation",
        gravitationForce = 100,
        gravitationMinForce = 200,
        gravitationMaxForce = 200,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 0.30000001192092896,
        active = false,
        gravityCollisionMask = "DYNAMIC_GRAVITATION_SENSOR"
    },
    {
        definition = "BLOCK_SENSOR_DYNAMIC_GRAVITATION2",
        type = "circle",
        sprite = "GRAVITY_SENSOR_GREEN_2",
        controllable = false,
        ignoreBirds = true,
        isSensor = true,
        material = "dynamicSensor",
        radius = 20,
        sensorType = "gravitation",
        gravitationForce = 100,
        gravitationMinForce = 50,
        gravitationMaxForce = 50,
        massMultiplier = 0.10000000149011612,
        z_order = 0,
        scale = 0.6000000238418579,
        active = false,
        gravityCollisionMask = "DYNAMIC_GRAVITATION_SENSOR"
    },
    {
        definition = "SHOOTING_VISUAL",
        type = "circle",
        sprite = "SHOOTING_VISUAL_TEMP",
        controllable = false,
        material = "misc",
        strength = 0,
        scale = 2,
        collision = false,
        z_order = 100
    },
    {
        definition = "BirdDummy",
        type = "circle",
        radius = 0.8500000238418579,
        friction = 0.30000001192092896,
        restitution = 0.019999999552965164,
        density = 10,
        sprite = "TRAIL_WHITE_1",
        material = "dynamicSensor",
        particlesDestroyed = "redBuff",
        particlesTrail = "redBirdTrail",
        sensorType = "dummy",
        gravitationForce = 0,
        gravitationMinForce = 0,
        gravitationMaxForce = 0
    },
    {
        definition = "BLOCK_SENSOR_SWORD_GREEN_1",
        type = "polygon",
        vertices = {
            { x = 0.5, y = 0 },
            { x = 1.5, y = 0 },
            { x = 1.5, y = 1 },
            { x = 0.5, y = 1 }
        },
        width = 10,
        height = 6,
        sprite = "LIGHT_SABER_GREEN_3",
        controllable = false,
        ignoreBirds = true,
        material = "sword",
        damage = 100,
        swordMinScale = 0.5,
        swordMaxScale = 1.7000000476837158,
        swordDuration = 0.5,
        swordAngleSpeed = 9,
        forceMultiplier = 300,
        sensorType = "dummy",
        z_order = 0,
        active = true,
        gravityCollisionMask = "DYNAMIC_GRAVITATION_SENSOR",
        onCollisionEnter = "swordCollision",
        onTriggerExit = "swordEndCollision",
        isSword = true,
        particlesCollision = "saberSparkBuff",
        particlesTrail = "redBirdSpecial_GreenSaber",
        particlesTrailTimer = 0.02500000037252903
    },
    {
        definition = "BLOCK_SENSOR_SWORD_BLUE_1",
        type = "polygon",
        vertices = {
            { x = 0.5, y = 0 },
            { x = 1.5, y = 0 },
            { x = 1.5, y = 1 },
            { x = 0.5, y = 1 }
        },
        width = 9,
        height = 5,
        sprite = "LIGHT_SABER_BLUE_1",
        controllable = false,
        ignoreBirds = true,
        material = "sword",
        damage = 100,
        swordMinScale = 0.5,
        swordMaxScale = 1.399999976158142,
        swordDuration = 0.5,
        swordAngleSpeed = 9,
        forceMultiplier = 300,
        sensorType = "dummy",
        z_order = 0,
        active = true,
        gravityCollisionMask = "DYNAMIC_GRAVITATION_SENSOR",
        onCollisionEnter = "swordCollision",
        onTriggerExit = "swordEndCollision",
        isSword = true,
        particlesCollision = "saberSparkBuff",
        particlesTrail = "redBirdSpecial_BlueSaber",
        particlesTrailTimer = 0.02500000037252903
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_BLASTER_DROID",
        type = "circle",
        sprite = "LASER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 0.5,
        sensorType = "dummy",
        z_order = 0,
        scale = 2,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "redBuff",
        isVisible = false,
        sendEventOnEmit = true
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER",
        type = "circle",
        sprite = "LASER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 0.5,
        sensorType = "dummy",
        z_order = 0,
        scale = 2,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "redBuff",
        isVisible = false,
        shotPattern = 1,
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_PISTOL_1",
        type = "box",
        width = 3,
        height = 1,
        sprite = "PIG_SW_STORMTROOPER_BLASTER",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 4,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "explosionBuff",
        isVisible = true,
        definitionHeldByForce = "FORCE_GLOW_RED_4X1",
        glowRotation = -90,
        shotPattern = 1,
        laserSound = "ingame_piglazer",
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_TURRET_1",
        type = "box",
        width = 3,
        height = 1,
        sprite = "TURRET_CANNON_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 51,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "explosionBuff",
        isVisible = true,
        shotPattern = 1,
        laserSound = "ingame_turretshooting",
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_TURRET_DS2",
        type = "box",
        width = 3,
        height = 1,
        sprite = "TURRET_TRIANGLE_BARREL",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 19,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "explosionBuff",
        isVisible = true,
        shotPattern = 1,
        laserSound = "ingame_turretshooting",
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_PISTOL_2",
        type = "box",
        width = 3,
        height = 1,
        sprite = "PIG_SW_STORMTROOPER_BLASTER",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 4,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "explosionBuff",
        horFlip = true,
        laserSound = "ingame_piglazer",
        isVisible = true,
        shotPattern = 1,
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_TURRET_2",
        type = "box",
        width = 3,
        height = 1,
        sprite = "TURRET_CANNON_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 51,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "explosionBuff",
        horFlip = true,
        isVisible = true,
        laserSound = "ingame_turretshooting",
        shotPattern = 1,
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_WALKER_1",
        type = "box",
        scale = 1.5,
        width = 0.5,
        height = 4,
        sprite = "BLOCK_WALKER_GUN_PIPE_1",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 21,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "explosionBuff",
        isVisible = true,
        shotPattern = 1,
        laserSound = "ingame_turretshooting",
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -90, -90 },
                    speed = { 50, 50 }
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_ATST_1",
        type = "box",
        scale = 2.799999952316284,
        width = 4.300000190734863,
        height = 0.5,
        sprite = "ATST_CANON",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 27,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "bespinExplosionBuff",
        isVisible = true,
        shotPattern = 1,
        laserSound = "ingame_turretshooting",
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { -180, -180 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            }
        }
    },
    {
        definition = "BLOCK_SENSOR_LAZER_EMITTER_ATST_2",
        horFlip = true,
        type = "box",
        scale = 2.799999952316284,
        width = 4.300000190734863,
        height = 0.5,
        sprite = "ATST_CANON",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        sensorType = "dummy",
        z_order = 27,
        density = 0.10000000149011612,
        ignoreFilter = {},
        active = true,
        particlesDestroyed = "bespinExplosionBuff",
        isVisible = true,
        shotPattern = 1,
        laserSound = "ingame_atst_shooting",
        shotData = {
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.4000000059604645,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                },
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 2,
                    currentTime = 0.20000000298023224,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 1.5,
                    currentTime = 0,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            },
            {
                {
                    block = "BLOCK_LAZER_SHOT_TURRET_RED",
                    timeInterval = 0.5,
                    currentTime = 0,
                    angle = { 0, 0 },
                    speed = { 50, 50 },
                    altSprite = "ATST_CANON_FIRE",
                    altSpriteDuration = 0.10000000149011612
                }
            }
        }
    },
    {
        definition = "BLOCK_LAZER_SHOT_RED",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "LASER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 1,
        strength = 250,
        damageDoneOnBounce = 37.5,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 10000,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "ingame_piglazer"
    },
    {
        definition = "BLOCK_LAZER_SHOT_TURRET_RED",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "LASER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 1,
        strength = 250,
        damageDoneOnBounce = 37.5,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 10000,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "ingame_turretshooting"
    },
    {
        definition = "BLOCK_LASER_SHOT_1",
        onDestroyed = "destroyProjectile",
        birdShot = "yellowBird",
        type = "box",
        sprite = "BLASTER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 0.5,
        strength = 200,
        damageDoneOnBounce = 30,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_1"
    },
    {
        definition = "BLOCK_LASER_SHOT_2",
        birdShot = "yellowBird",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "BLASTER_BEAM_BLUE",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 0.800000011920929,
        strength = 225,
        damageDoneOnBounce = 30,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_2"
    },
    {
        definition = "BLOCK_LASER_SHOT_3",
        birdShot = "yellowBird",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "BLASTER_BEAM_GREEN",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 1,
        strength = 250,
        damageDoneOnBounce = 30,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_3"
    },
    {
        definition = "BLOCK_LANDO_LASER_SHOT_1",
        birdShot = "landoBird",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "BLASTER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 0.5,
        strength = 250,
        damageDoneOnBounce = 30,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_1"
    },
    {
        definition = "BLOCK_LANDO_LASER_SHOT_2",
        birdShot = "landoBird",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "BLASTER_BEAM_BLUE",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 0.5,
        strength = 275,
        damageDoneOnBounce = 30,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_2"
    },
    {
        definition = "BLOCK_LANDO_LASER_SHOT_3",
        birdShot = "landoBird",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "BLASTER_BEAM_GREEN",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 0.5,
        strength = 300,
        damageDoneOnBounce = 30,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_3"
    },
    {
        definition = "BLOCK_FALCON_LASER_SHOT_1",
        onDestroyed = "destroyProjectile",
        type = "box",
        sprite = "LASER_BEAM_MIGHTY_FALCON",
        controllable = false,
        ignoreBirds = false,
        damageFactors = "TurboLazerProjectileDamageFactors",
        material = "lazerProjectile",
        z_order = 152,
        scale = 1,
        strength = 400,
        damageDoneOnBounce = 100,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "falconLaserExplosion",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        createSound = "mighty_falcon_laser_blast",
        turboLaser = true
    },
    {
        definition = "BLOCK_SENSOR_MIGHTY_FALCON_EMITTER",
        type = "circle",
        sprite = "LASER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "sensor",
        radius = 0,
        sensorType = "dummy",
        z_order = 0,
        scale = 2,
        density = 0,
        ignoreFilter = {},
        active = true,
        isVisible = false
    },
    {
        definition = "BLOCK_LASER_SHOT_DROID",
        onDestroyed = "destroyProjectile",
        birdShot = "yellowBird",
        type = "box",
        sprite = "BLASTER_BEAM_RED",
        controllable = false,
        ignoreBirds = false,
        material = "lazerProjectile",
        z_order = 0,
        scale = 0.5,
        scaleX = 1,
        scaleY = 0.699999988079071,
        strength = 70,
        damageDoneOnBounce = 20,
        collidedScoreInc = 1000,
        spriteScore = "SCORE_1K_YELLOW",
        onTriggerEnter = "sensorToBirdCollision",
        impulseGivenOnBirdCollision = 1300,
        onCollisionEnter = "lazerCollision",
        onTriggerExit = "lazerCollisionExit",
        particlesDestroyed = "energySparkBuff",
        particlesCollision = { "energySparkBuff" },
        isEmittedParticle = true,
        deflectionSound = "ingame_lazerdeflected",
        createSound = "birds_hansolo_specialactivate_1",
        collisionGroupIndex = 1
    },
    {
        definition = "BLOCK_SENSOR_R2D2_ELECTRICITY_1",
        type = "polygon",
        vertices = {
            { x = 0.5, y = 0 },
            { x = 1.5, y = 0 },
            { x = 1.5, y = 1 },
            { x = 0.5, y = 1 }
        },
        useOptionalDimensions = true,
        sprite = "R2D2_ZAPPER_1",
        controllable = false,
        ignoreBirds = true,
        material = "R2D2Electricity",
        damage = 80,
        forceMultiplier = 300,
        sensorType = "dummy",
        z_order = 100,
        animations = {
            {
                frameTime = { 0.009999999776482582, 0.009999999776482582 },
                name = "default",
                defaultAnim = true,
                idleTime = { 0, 0 },
                thresholdTime = { 0.5, 0.5 },
                sprites = { { "R2D2_ZAPPER_1", "R2D2_ZAPPER_2" } },
                triggers = { { minVel = 0, maxVel = 5, minAngle = -180, maxAngle = 180 } }
            }
        },
        active = true,
        gravityCollisionMask = "DYNAMIC_GRAVITATION_SENSOR",
        isSword = true,
        onCreated = "R2D2ZapCreated"
    }
}
