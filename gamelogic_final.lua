-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

local r0_0 = {}

-- line 5-10
-- proto#1 params=2 locals=0 upvalues=1 vararg=false
function addUpdateFunction(p1_0, p1_1)
    if not r0_0[p1_0] then
        print("adding update function with name: " .. p1_0)
        r0_0[p1_0] = p1_1
    end
end

-- line 12-14
-- proto#2 params=1 locals=0 upvalues=1 vararg=false
function removeUpdateFunction(p2_0)
    r0_0[p2_0] = nil
end

loadLuaFile(scriptPath .. "/settingsWrapper.lua", "", false, false)
loadLuaFile(scriptPath .. "/game.lua", "", false, false)
loadLuaFile(scriptPath .. "/camera.lua", "", false, false)
if eggsplorationEnabled then
    loadLuaFileToObject(scriptPath .. "/eggsploration/EggsplorationMainMenu.lua", _G, "Eggsploration")
end
if this.steam ~= nil then
    loadLuaFileToObject(commonScriptPath .. "/timer.lua", this, "util")
    loadLuaFileToObject(commonScriptPath .. "/steam.lua", this, "Steam")
    this.Steam:init()
end
if this.marketplace ~= nil then
    loadLuaFileToObject(commonScriptPath .. "/Marketplace.lua", this.marketplace, "")
end
postHighscores = true
deterministicPhysics = true
DEBUG_POINTER_EVENTS = false
usingCameraDummy = false
g_forceFunctions = {}
g_queuedEventCalls = {}
g_blockLevelMusic = false
g_mouseAvailable = true
g_safeToQuit = false
g_isWindowSnapped = false
g_scoreAddedTime = 0
g_currentLocale = "en_EN"
g_aimingAidAttributes = { enabled = true, visible = false }
g_aimingAidCursor = {
    cursorToUse = nil,
    framesToProfile = 22,
    minDistanceToResumeDrag = 1536 / screenWidth,
    maxDistanceToPutDragOnHold = 51.20000076293945 / screenWidth,
    currentDragDistance = 0,
    onHold = false,
    lastFramesPositions = {},
    lastFramesTimes = {}
}
wasAudioPlaying = nil
gameCamera = nil
rovioNewsIsShown = false
rovioNewsIsLoaded = false
g_killingVolumeAttributes = { enableDebugging = false, birdRemovalTime = 0 }
g_killingVolumeOffsets = {}
g_killingVolumeOffsets.ipad = { width = 0.05000000074505806, height = 0.05000000074505806 }
g_killingVolumeOffsets.iphone = { width = 0.05000000074505806, height = 0.05000000074505806 }
g_killingVolumeOffsets.default = { width = 0.05000000074505806, height = 0.05000000074505806 }
g_usingGestureControls = false
if releaseBuild then
    showEditor = false
    postHighscores = true
    DEBUG_POINTER_EVENTS = false
end
tapRadius = 15 * screenWidth / 480
g_debugLines = {}
g_debugPoints = {}
slingShotAngle = 0
gameWorldScale = gameWorldScale or 1
slingshotScale = gameWorldScale * (g_slingShotScaleMultiplier or 1)
fpsString = ""
g_mouseDragAttributes = {
    mouseDragTime = -1,
    targetDragTime = 0.5,
    minDragTime = 0.019999999552965164,
    lastPressedX = -1,
    lastPressedY = -1,
    cummulativeDragX = 0,
    cummulativeDragY = 0,
    dragFromTouch = false,
    dragFromMouse = false
}
g_birdDragOnTouchAttributes = {
    enabled = true,
    dragging = false,
    lastCursorX = -1,
    lastCursorY = -1,
    previousTouchCount = 0,
    elapsedTimeAtRest = 0,
    targetRestTime = 0.009999999776482582,
    dragStartPosPhysics = { x = nil, y = nil },
    dragLastPosPhysics = { x = nil, y = nil },
    touchOneID = nil,
    shootMinLength = 3 * slingshotScale,
    disabledForBirdSpecialty = false,
    needsNewTouchToDrag = false
}
g_safeArea = deviceModel == "roku" and 0.05000000074505806 or 0
disableAllLinks = deviceModel == "roku"
useAccelerometerControls = deviceModel == "roku"
g_registrationURLs = {}
activeSensors = {}
previousCursorPoint = {}
defaultPhysicsDrag = 0.15000000596046448
minorPhysicsDrag = 0.4000000059604645
defaultBirdsDrag = 0.05000000074505806
birdDragTimer = 3
shootingTreshold = 1
dragVelocityThreshold = 1 * gameWorldScale
velocityDebugColor = { r = 255, g = 255, b = 255 }
g_lineGravityVisualization = true
maxInputWaitingTime = 0.75
birdCollisionMultiplier = 1
g_gravityFiltersCategories = {
    NORMAL_OBJECT = 1,
    BIRD = 2,
    COIN = 4,
    AIMING_AID = 8,
    BIRD_UNAFFECTED_BY_GRAVITY = 16,
    FORCE_OBJECT = 32,
    IGNOREGRAVITY = 64,
    YODA_FORCE_OBJECT = 128,
    HOVERING_OBJECT = 256
}
g_gravityFiltersNameMasks = {
    GRAVITATION_SENSOR = {
        "NORMAL_OBJECT",
        "BIRD",
        "AIMING_AID",
        "FORCE_OBJECT",
        "HOVERING_OBJECT"
    },
    BLACK_HOLE_SENSOR = { "NORMAL_OBJECT" },
    COIN_SUCKER_SENSOR = { "COIN" },
    DYNAMIC_GRAVITATION_SENSOR = { "NORMAL_OBJECT" }
}
g_gravityFiltersMasks = {}
g_inMainMenu = false

-- line 168-192
-- proto#3 params=1 locals=7 upvalues=0 vararg=false
function isSafeToQuit(p3_0)
    if menuManager == nil or menuManager:getRoot() == nil then
        return true
    end
    if g_inMainMenu then
        local r3_0 = menuManager:getRoot()
        if r3_0.children then
            local r3_1 = _G.pairs
            local r3_2 = menuManager:getRoot()
            for r3_3, r3_4 in r3_1(r3_2.children) do
                if r3_4.requireInput then
                    if p3_0 then
                        print("Not safe to quit: frame " .. r3_4.name .. " requires input")
                    end
                    return false
                end
            end
        end
        return true
    end
    if p3_0 then
        print("Not safe to quit: not in main menu")
    end
    return false
end

-- line 195-224
-- proto#4 params=0 locals=1 upvalues=0 vararg=false
function resolutionChanged()
    g_aimingAidCursor.minDistanceToResumeDrag = 1536 / screenWidth
    g_aimingAidCursor.maxDistanceToPutDragOnHold = 51.20000076293945 / screenWidth
    if startedFromEditor ~= true then
        screen = {
            x = screenWidth * 0.5,
            y = screenHeight * 0.5,
            top = 0,
            left = 0,
            bottom = screenHeight,
            right = screenWidth
        }
    end
    bannerWidth = 320 * (screenHeight / 320)
    bannerHeight = 48 * (screenHeight / 320)
    continueButtonY = screenHeight * 0.5 + 70
    tapRadius = 15 * screenWidth / 480
    if not g_usingNewCamera and isInGameMode() then
        doItAllCamera(0)
    end
    if g_usingNewCamera and gameCamera then
        g_skipEpisodeCameraMovement = true
        updateCamera(0)
        g_skipEpisodeCameraMovement = false
    end
    if isPCVersion() and gameCamera then
        native_resetThemeSystem()
        local r4_0 = gameCamera:getEdgeCameras()
        recalculateLevelLimits(r4_0)
    end
end

if deviceModel == "metro" then
    -- line 227-235
    -- proto#5 params=1 locals=4 upvalues=0 vararg=false
    function setMetroWindowState(p5_0)
        if eventManager ~= nil then
            if p5_0 == "FILLED" or p5_0 == "FULL" then
                local r5_0 = eventManager
                local r5_1 = { id = events.EID_METRO_VIEW_FULL, state = p5_0 }
                r5_0:notify(r5_1)
            elseif p5_0 == "SNAP_LEFT" or p5_0 == "SNAP_RIGHT" then
                local r5_2 = eventManager
                local r5_3 = { id = events.EID_METRO_VIEW_SNAPPED, state = p5_0 }
                r5_2:notify(r5_3)
            end
        end
    end
end

-- line 238-240
-- proto#6 params=0 locals=1 upvalues=0 vararg=false
function isIpad3()
    local r6_0
    if deviceModel == "ios" then
        r6_0 = screenWidth == 2048
    elseif deviceModel == "ipad" then
        r6_0 = screenWidth == 2048
    else
        r6_0 = false
    end
    return r6_0
end

-- line 242-247
-- proto#7 params=1 locals=1 upvalues=0 vararg=false
function getNextLevelName(p7_0)
    if this[p7_0] ~= nil and _G.type(this[p7_0]) == "function" then
        return this[p7_0]()
    end
    return p7_0
end

-- line 249-255
-- proto#8 params=1 locals=0 upvalues=0 vararg=false
function setLevelName(p8_0)
    if levelName == nil then
        levelName = p8_0
    else
        queuedLevelName = p8_0
    end
end

-- line 257-263
-- proto#9 params=1 locals=0 upvalues=0 vararg=false
function setLevelFolder(p9_0)
    if levelFolder == nil then
        levelFolder = p9_0
    else
        queuedLevelFolder = p9_0
    end
end

-- line 266-272
-- proto#10 params=1 locals=0 upvalues=0 vararg=false
function setCurrentFolder(p10_0)
    if currentFolder == nil then
        currentFolder = p10_0
    else
        queuedCurrentFolder = p10_0
    end
end

-- line 274-280
-- proto#11 params=1 locals=0 upvalues=0 vararg=false
function setCurrentLevel(p11_0)
    if currentLevel == nil then
        currentLevel = p11_0
    else
        queuedCurrentLevel = p11_0
    end
end

-- line 282-288
-- proto#12 params=1 locals=0 upvalues=0 vararg=false
function setCurrentLevelPack(p12_0)
    if currentPack == nil then
        currentPack = p12_0
    else
        queuedCurrentPack = p12_0
    end
end

-- line 290-294
-- proto#13 params=1 locals=0 upvalues=0 vararg=false
function setFont(p13_0)
    if p13_0 ~= nil then
        res.useFont(p13_0)
    end
end

-- line 296-309
-- proto#14 params=0 locals=7 upvalues=0 vararg=false
function setupFilterMasks()
    for r14_0, r14_1 in _G.pairs(g_gravityFiltersNameMasks) do
        local r14_2 = 0
        for r14_3, r14_4 in _G.pairs(r14_1) do
            r14_2 = performBitwiseOr(r14_2, g_gravityFiltersCategories[r14_4])
        end
        g_gravityFiltersMasks[r14_0] = r14_2
    end
end

setupFilterMasks()

-- line 313-437
-- proto#15 params=0 locals=5 upvalues=0 vararg=false
function initParams()
    initializeManufacturer()
    if SettingsWrapper:isAndroidPremium() then
        print("Overriding isPremium state from settings")
        isPremium = true
    else
        SettingsWrapper:storeAndroidPremium(isPremium)
    end
    print("Screen resolution is " .. screenWidth .. "x" .. screenHeight)
    if isHDVersion == true then
        print("HD is enabled")
    elseif isHDVersion == false then
        print("HD is disabled")
    else
        _G.assert(isHDVersion == nil)
        print("HD is undefined")
    end
    _G.math.randomseed(_G.os.time())
    numberKeys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
    screen = {
        x = screenWidth * 0.5,
        y = screenHeight * 0.5,
        top = 0,
        left = 0,
        bottom = screenHeight,
        right = screenWidth
    }
    initCamera()
    oldScreenWidth = screenWidth
    oldScreenHeight = screenHeight
    bannerWidth = 320 * (screenHeight / 320)
    bannerHeight = 48 * (screenHeight / 320)
    rubberBandPos = { x = 0, y = 0 }
    rubberBandSpeed = 0
    floatingScores = {}
    objectCounts = {}
    scoreTable = {}
    draggingSpeed = 0
    draggingSpeed = 0
    draggingStartPosPhysics = { x = -1, y = -1 }
    draggingStartPosWorld = { x = -1, y = -1 }
    draggingStartPosScreen = { x = -1, y = -1 }
    selectedObjects = {}
    selectedObjectPos = { x = 0, y = 0 }
    selectedBird = nil
    objectToAdd = nil
    objectToAddAngle = 0
    currentGroup = nil
    doubleClickTimer = 0
    quadClickTimer = 0
    quadClickCounter = 0
    gameTimer = 0
    levelCompleteTimer = 0
    birdBuffTimer = 0
    currentBirdIndex = 1
    currentBirdName = nil
    flyingBird = nil
    birdSpecialtyAvailable = false
    particleAmount = 0
    blockMoveTimer = 0
    local r15_0 = cursor
    local r15_1 = cursor
    local r15_2 = 0
    r15_1.y = 0
    r15_0.x = r15_2
    cursorPhysics = { x = 0, y = 0 }
    cursorWorld = { x = 0, y = 0 }
    oldCursorWorld = { x = 0, y = 0 }
    oldCursor = { x = 0, y = 0 }
    tapPosWorld = { x = 0, y = 0 }
    springConstant = 1500
    springDampening = 50
    difficultyLevel = 1
    score = 0
    zoomLevel = 0
    defaultForce = -800
    blockDestroyedScoreIncrement = 100
    physicsToWorld = 20
    physicsScale = 1 / physicsToWorld
    shootRange = 2.200000047683716 * slingshotScale
    continueButtonY = screenHeight * 0.5 + 70
    oldScale = 1
    levelStartPosition = { x = 0, y = 0 }
    animationScreen = { x = 0, y = 0 }
    animationWorldScale = 1
    setPhysicsSimulationScale(physicsToWorld)
    setLevelName("")
    levelStartTimer = 0
    collisionParticleForceThreshold = 5
    levelSaved = true
    selectionRectActive = false
    birdFired = false
    maxZoomLevel = true
    particles = {}
    elementAnimations = {}
    g_currentCursorName = "CURSOR_HAND_POINT"
    g_wheelSpeed = 0
    g_gestureMenuTriggered = 0
    g_gestureMenuCursorHide = false
    initializeGame()
end

-- line 439-454
-- proto#16 params=0 locals=1 upvalues=0 vararg=false
function initializeManufacturer()
    if deviceManufacturer == nil then
        print("Device manufacturer is undefined")
        isUsingSamsungDevice = false
        return
    end
    print("Device manufacturer is " .. deviceManufacturer)
    local r16_0 = _G.string.lower(deviceManufacturer)
    if _G.string.find(r16_0, "samsung") then
        print("Samsung device detected")
        isUsingSamsungDevice = true
    else
        isUsingSamsungDevice = false
    end
end

-- line 456-459
-- proto#17 params=0 locals=1 upvalues=0 vararg=false
function isAndroidSamsungDevice()
    _G.assert(isUsingSamsungDevice ~= nil)
    local r17_0
    if deviceModel == "android" then
        r17_0 = isUsingSamsungDevice
    else
        r17_0 = false
    end
    return r17_0
end

-- line 461-481
-- proto#18 params=1 locals=0 upvalues=0 vararg=false
function changeRetinaResolution(p18_0)
    if deviceModel == "iphone4" then
        changeResolution = true
        if p18_0 == true then
            if wantedResolution ~= "FULL" then
                screenWidth = screenWidth * 2
                screenHeight = screenHeight * 2
                wantedResolution = "FULL"
                setMenuParticlesScale(2)
            end
        elseif wantedResolution ~= "HALF" then
            screenWidth = screenWidth / 2
            screenHeight = screenHeight / 2
            wantedResolution = "HALF"
            setMenuParticlesScale(1)
        end
    end
end

g_drawLoadingScreen = false
g_actionActionAfterLoadingScreen = ""
g_loadingScreenLevelAttributes = {}

-- line 487-494
-- proto#19 params=1 locals=5 upvalues=0 vararg=false
function getAudioName(p19_0)
    if audioGroups[p19_0] then
        local r19_0 = _G.math.random(1, #audioGroups[p19_0])
        local r19_1 = audioGroups[p19_0]
        return r19_1[r19_0]
    end
    return p19_0
end

-- line 499-513
-- proto#20 params=1 locals=2 upvalues=0 vararg=false
function isAudioPlaying(p20_0)
    local r20_0 = audioGroups[p20_0]
    if r20_0 then
        for r20_1 = 1, #r20_0 do
            if _G.res.isAudioPlaying(r20_0[r20_1]) then
                return r20_0[r20_1]
            end
        end
        return nil
    end
    if _G.res.isAudioPlaying(p20_0) then
        return p20_0
    end
    return nil
end

-- line 515-605
-- proto#21 params=5 locals=28 upvalues=0 vararg=false
function playAudio(p21_0, p21_1, p21_2, p21_3, p21_4)
    local r21_0, r21_1
    local r21_2, r21_3 = audioGroups[p21_0], p21_0
    if r21_2 then
        if r21_2.delay then
            if r21_2.nextTimePlay and r21_2.nextTimePlay > time then
                return
            end
            local r21_4 = time
            local r21_5 = _G.math.random(r21_2.delay[1] * 100, r21_2.delay[2] * 100)
            r21_2.nextTimePlay = r21_4 + r21_5 / 100
        end
        if r21_2.noOverlap then
            for r21_6 = 1, #r21_2 do
                if res.isAudioPlaying(r21_2[r21_6]) then
                    return
                end
            end
        end
        r21_3 = getAudioName(p21_0)
    end
    local r21_7 = audioData.sounds[r21_3]
    local r21_8, r21_9, r21_10 = p21_1, p21_2, p21_3
    if r21_7 then
        r21_10 = r21_7.channel
        r21_8 = audioData.sounds[r21_3].volume
        if r21_8 == nil then
            r21_8 = audioData.channelVolume[r21_10]
        else
            r21_8 = r21_8
        end
        if p21_2 == nil and r21_7.flag then
            r21_9 = audioData.sounds[r21_3].flag
        end
    end
    local r21_11 = r21_0
    if r21_10 == nil then
        r21_11 = 4
    end
    local r21_12 = r21_8 == nil and 1 or r21_8
    local r21_13 = r21_1
    if r21_9 == nil then
        r21_13 = false
    end
    local r21_14 = getLevelMetadata(levelName)
    local r21_15 = r21_14.audioFilters
    local r21_16 = false
    if p21_4 or r21_15 == nil then
        playAudioNative(r21_3, r21_12, r21_13, r21_11)
        return r21_3
    end
    local r21_17, r21_18, r21_19 = _G.pairs(r21_15)
    local r21_20 = r21_16
    for r21_21, r21_22 in r21_17, r21_18, r21_19 do
        for r21_23, r21_24 in _G.pairs(audioFilters[r21_22]) do
            local r21_25 = audioGroups[r21_24]
            local r21_26
            r21_20 = r21_26
            if r21_25 then
                local r21_27 = 1
                local r21_28 = audioGroups[r21_24]
                for r21_29 = r21_27, #r21_28 do
                    local r21_30 = audioGroups[r21_24][r21_29]
                    if r21_3 == r21_30 then
                        r21_20 = true
                        r21_20 = r21_20
                    else
                        r21_20 = r21_20
                    end
                end
            end
            if r21_3 == r21_24 then
                playAudioNative(r21_3, r21_12, r21_13, r21_11)
                return r21_3
            end
            if r21_20 then
                playAudioNative(r21_3, r21_12, r21_13, r21_11)
                return r21_3
            end
        end
    end
    return r21_3
end

-- line 607-615
-- proto#22 params=1 locals=3 upvalues=0 vararg=false
function stopAudioByFilter(p22_0)
    if p22_0 then
        for r22_0, r22_1 in _G.ipairs(p22_0) do
            if isAudioPlaying(r22_1) then
                stopAudio(r22_1)
            end
        end
    end
end

playAudioNative = _G.ResourceManager.native_playAudio
res.playAudio = playAudio
stopAudio = _G.res.stopAudio

-- line 621-662
-- proto#23 params=0 locals=15 upvalues=0 vararg=false
function drawLoadingScreen()
    if g_drawLoadingScreen then
        local r23_0 = (deviceModel == "iphone4" or isIpad3()) and 2 or 1
        setRenderState(0, 0, r23_0, r23_0, 0, 0, 0)
        _G.res.drawSprite("LOADING_BADGE", screenWidth * 0.5 / r23_0, screenHeight * 0.5 / r23_0)
        setRenderState(0, 0, 1, 1, 0, 0, 0)
        if g_actionActionAfterLoadingScreen == "INITIALIZE_GAME" then
            startGame(g_loadingScreenLevelAttributes.levelPack, g_loadingScreenLevelAttributes.levelNumber)
            g_drawLoadingScreen = false
        elseif g_actionActionAfterLoadingScreen == "INITIALIZE_GAME_AFTER_CUTSCENE" then
            local r23_1 = eventManager
            local r23_2 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r23_1:notify(r23_2)
            g_drawLoadingScreen = false
        elseif g_actionActionAfterLoadingScreen == "INITIALIZE_GAME_AFTER_RELOAD_FROM_GAME" then
            local r23_3 = eventManager
            local r23_4 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r23_3:notify(r23_4)
            g_drawLoadingScreen = false
        elseif g_actionActionAfterLoadingScreen == "INITIALIZE_GAME_AFTER_RELOAD_FROM_PAUSE_MENU" then
            if not resumingOldLevel and not startedFromEditor then
                local r23_5 = setLevelName
                local r23_6 = actions.myLevels[currentFolder]
                r23_5(r23_6[currentLevel])
            end
            local r23_7 = eventManager
            local r23_8 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r23_7:notify(r23_8)
            g_drawLoadingScreen = false
        elseif g_actionActionAfterLoadingScreen == "INITIALIZE_GAME_AFTER_RELOAD_FROM_LEVEL_FAILED_MENU" then
            local r23_9 = eventManager
            local r23_10 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r23_9:notify(r23_10)
            g_drawLoadingScreen = false
        elseif g_actionActionAfterLoadingScreen == "INITIALIZE_GAME_AFTER_RELOAD_FROM_LEVEL_COMPLETE_MENU" then
            local r23_11 = eventManager
            local r23_12 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r23_11:notify(r23_12)
            g_drawLoadingScreen = false
        elseif g_actionActionAfterLoadingScreen == "INITIALIZE_CUTSCENE_AFTER_LEVEL_FINISHED" then
            gotoCutscene()
            g_drawLoadingScreen = false
        end
    end
end

-- line 664-669
-- proto#24 params=2 locals=0 upvalues=0 vararg=false
function setLevelLoading(p24_0, p24_1)
    g_drawLoadingScreen = true
    g_loadingScreenLevelAttributes.levelPack = p24_0
    g_loadingScreenLevelAttributes.levelNumber = p24_1
    g_actionActionAfterLoadingScreen = "INITIALIZE_GAME"
end

-- line 671-674
-- proto#25 params=0 locals=0 upvalues=0 vararg=false
function setLevelLoadingAfterCutscene()
    g_drawLoadingScreen = true
    g_actionActionAfterLoadingScreen = "INITIALIZE_GAME_AFTER_CUTSCENE"
end

-- line 676-679
-- proto#26 params=0 locals=0 upvalues=0 vararg=false
function setLevelLoadingAfterRestartFromGame()
    g_drawLoadingScreen = true
    g_actionActionAfterLoadingScreen = "INITIALIZE_GAME_AFTER_RELOAD_FROM_GAME"
end

-- line 681-684
-- proto#27 params=0 locals=0 upvalues=0 vararg=false
function setLevelLoadingAfterRestartFromPauseMenu()
    g_drawLoadingScreen = true
    g_actionActionAfterLoadingScreen = "INITIALIZE_GAME_AFTER_RELOAD_FROM_PAUSE_MENU"
end

-- line 686-689
-- proto#28 params=0 locals=0 upvalues=0 vararg=false
function setLevelLoadingAfterRestartFromLevelFailedMenu()
    g_drawLoadingScreen = true
    g_actionActionAfterLoadingScreen = "INITIALIZE_GAME_AFTER_RELOAD_FROM_LEVEL_FAILED_MENU"
end

-- line 691-694
-- proto#29 params=0 locals=0 upvalues=0 vararg=false
function setLevelLoadingAfterRestartFromLevelCompleteMenu()
    g_drawLoadingScreen = true
    g_actionActionAfterLoadingScreen = "INITIALIZE_GAME_AFTER_RELOAD_FROM_LEVEL_COMPLETE_MENU"
end

-- line 696-699
-- proto#30 params=0 locals=0 upvalues=0 vararg=false
function setCutsceneLoadingAfterLevelFinished()
    g_drawLoadingScreen = true
    g_actionActionAfterLoadingScreen = "INITIALIZE_CUTSCENE_AFTER_LEVEL_FINISHED"
end

-- line 701-705
-- proto#31 params=1 locals=0 upvalues=0 vararg=false
function keyReceivedFromServer(p31_0)
    if deviceModel == "windows" then
        g_registrationPage:keyReceivedFromServer(p31_0)
    end
end

-- line 707-710
-- proto#32 params=2 locals=0 upvalues=0 vararg=false
function latestVersionNumberReceived(p32_0, p32_1)
    g_latestVersion = p32_0
    g_latestVersionUrl = p32_1
end

-- line 712-716
-- proto#33 params=0 locals=0 upvalues=0 vararg=false
function gameRegistrationSuccessful()
    g_registrationPage:close()
    g_isGameUnlocked = true
end

-- line 718-720
-- proto#34 params=0 locals=0 upvalues=0 vararg=false
function gameRegistrationCancel()
    g_registrationPage:close()
end

-- line 722-724
-- proto#35 params=0 locals=1 upvalues=0 vararg=false
function isPCVersion()
    local r35_0 = (deviceModel == "windows" or deviceModel == "osx") and true or deviceModel == "metro"
    return r35_0
end

-- line 726-728
-- proto#36 params=0 locals=2 upvalues=0 vararg=false
function isPCTouchState()
    local r36_0 = isPCVersion() and not g_mouseAvailable
    return r36_0
end

-- line 730-732
-- proto#37 params=0 locals=0 upvalues=0 vararg=false
function isAndroidVersion()
    return deviceModel == "android"
end

-- line 734-736
-- proto#38 params=0 locals=1 upvalues=0 vararg=false
function isIOSVersion()
    local r38_0 = (deviceModel == "iphone" or deviceModel == "iphone4" or deviceModel == "ipad") and true or deviceModel == "ios"
    return r38_0
end

-- line 738-740
-- proto#39 params=0 locals=1 upvalues=0 vararg=false
function isIOSFree()
    return isIOSVersion() and isLiteVersion
end

-- line 742-744
-- proto#40 params=0 locals=3 upvalues=0 vararg=false
function isIOSFreeLocked()
    local r40_0 = isIOSFree()
    local r40_1
    if r40_0 then
        r40_1 = not SettingsWrapper:getPurchase(g_freeUnlockIapID)
    else
        r40_1 = r40_0
    end
    return r40_1
end

-- line 747-749
-- proto#41 params=0 locals=0 upvalues=0 vararg=false
function PCupdateAvailableCallback()
    eventManager:notify({ id = events.EID_UPDATE_AVAILABLE })
end

-- line 752-759
-- proto#42 params=0 locals=0 upvalues=0 vararg=false
function PCCheckForUpdatesOnce()
    if g_updateCheckEnabled and deviceModel == "windows" then
        if not g_updateChecked then
            checkForUpdates()
        end
        g_updateChecked = true
    end
end

-- line 761-767
-- proto#43 params=6 locals=7 upvalues=0 vararg=false
function openURL(p43_0, p43_1, p43_2, p43_3, p43_4, p43_5)
    local r43_0
    local r43_1 = ui.Image:new({ name = "title" })
    r43_1:setImage(p43_2)
    local r43_2 = ui.ConfirmPrompt
    local r43_3 = {
        suffix = "EAGLE_PURCHASE",
        title = r43_1,
        content = _G.res.getString("TEXTS_BASIC", p43_1),
        returnValue = events.EID_OPEN_URL,
        closeCallback = p43_5 or nil,
        meta = { url = p43_0, urlVariable = p43_4 },
        inMenuSpace = p43_3
    }
    local r43_4 = r43_0(r43_2, r43_3)
    local r43_5 = eventManager
    local r43_6 = { id = events.EID_PUSH_FRAME, target = r43_4 }
    r43_5:notify(r43_6)
end

-- line 769-813
-- proto#44 params=0 locals=0 upvalues=0 vararg=false
function initializeMenuEngine()
    luaName = "AB Space gamelogic.lua"
    loadLuaFileToObject(commonScriptPath .. "/ui_components/MenuManager.lua", this, "MenuManager")
    loadLuaFileToObject(commonScriptPath .. "/events.lua", this, "events")
    loadLuaFileToObject(scriptPath .. "/events.lua", this.events, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/EventManager.lua", this, "EventManager")
    eventManager = EventManager.EventManager:new()
    menuManager = MenuManager.MenuManager:new()
    eventManager:addEventListener(events.EID_CHANGE_SCENE, menuManager)
    eventManager:addEventListener(events.EID_PUSH_FRAME, menuManager)
    eventManager:addEventListener(events.EID_POP_FRAME, menuManager)
    if isPCVersion() then
        loadLuaFileToObject(commonScriptPath .. "/ui_components/PCEventManager.lua", this, "PCEventManager")
        PCEventManager = PCEventManager.PCEventManager:new()
        eventManager:addEventListener(events.EID_SHOW_REGISTRATION_DIALOG, PCEventManager)
        eventManager:addEventListener(events.EID_UPDATE_AVAILABLE, PCEventManager)
        eventManager:addEventListener(events.EID_UPDATE_GAME, PCEventManager)
    end
    if deviceModel ~= "metro" then
        eventManager:addEventListener(events.EID_EXIT_GAME, exitEventListener)
        eventManager:addEventListener(events.EID_EXIT_CONFIRMED, exitEventListener)
    end
    if deviceModel == "wp8" or deviceModel == "wp7" then
        loadLuaFileToObject(commonScriptPath .. "/ui_components/WP8EventManager.lua", this, "WP8EventManager")
        WP8EventManager = WP8EventManager.WP8EventManager:new()
        eventManager:addEventListener(events.EID_SHOW_REGISTRATION_DIALOG, WP8EventManager)
        eventManager:addEventListener(events.EID_UPDATE_AVAILABLE, WP8EventManager)
        eventManager:addEventListener(events.EID_UPDATE_GAME, WP8EventManager)
    end
end

exitEventListener = {
    eventTriggered = function(p45_0, p45_1)
        local r45_0 = p45_1.id
        local r45_1 = events.EID_EXIT_GAME
        if r45_0 == r45_1 then
            if deviceModel ~= "metro" and deviceModel ~= "roku" then
                if deviceModel == "android" or isPCVersion() then
                    closeOnCancelKeyHandlerTemp = closeOnCancelKeyExitPromptHandler
                    if isPCVersion() then
                        closeOnCancelKeyHandlerTemp = nil
                    end
                    local r45_2 = ui.ConfirmPrompt
                    local r45_3 = {
                        content = _G.res.getString("TEXTS_BASIC", "TEXT_EXIT_CONFIRM"),
                        returnValue = events.EID_EXIT_CONFIRMED,
                        closeOnCancelKeyHandler = closeOnCancelKeyHandlerTemp,
                        inMenuSpace = true
                    }
                    local r45_4 = r45_2:new(r45_3)
                    local r45_5 = eventManager
                    local r45_6 = { id = events.EID_PUSH_FRAME, target = r45_4 }
                    r45_5:notify(r45_6)
                else
                    if deviceModel == "wp8" then
                        saveSettings()
                        savePersistentLuaFileWrapper("highscores.lua", "highscores")
                        savePurchases()
                    end
                    requestExit()
                end
            end
        else
            local r45_7 = p45_1.id
            local r45_8 = events.EID_EXIT_CONFIRMED
            if r45_7 == r45_8 then
                requestExit()
            end
        end
    end
}

-- line 847-856
-- proto#46 params=0 locals=0 upvalues=0 vararg=false
function closeOnCancelKeyExitPromptHandler()
    if deviceModel == "android" then
        return false
    end
    return true
end

-- line 858-860
-- proto#47 params=0 locals=0 upvalues=0 vararg=false
function initializeSoundManager()
    loadLuaFileToObject(scriptPath .. "/soundManager.lua", this, "soundManager")
end

-- line 862-879
-- proto#48 params=0 locals=4 upvalues=0 vararg=false
function initAds()
    if g_use_ads then
        print("gamelogic - initAds()")
        loadLuaFile(commonScriptPath .. "/subsystems/adsSubsystem.lua", "", false, false)
        adSystem = AdsSubSystem:new()
        local r48_0 = _G.tostring(isIOSFree())
        print("initAds - isIOSFree: " .. r48_0)
        if isIOSFree() then
            print("loading upsellScreenManager")
            loadLuaFile(scriptPath .. "/UpsellScreenManager.lua", "", false, false)
            adSystem.upsellScreenManager = UpsellScreenManager:new()
        end
    end
end

-- line 881-903
-- proto#49 params=2 locals=9 upvalues=0 vararg=false
function assertWithStackTrace(p49_0, p49_1)
    if p49_0 then
        return
    end
    local r49_0
    if p49_1 == nil then
        if _G.debug == nil then
            r49_0 = "Assertion failed and debug is null"
        else
            local r49_1 = "Assertion failed. "
            local r49_2 = _G.debug.traceback()
            r49_0 = r49_1 .. r49_2
        end
    elseif _G.debug == nil then
        r49_0 = "Assertion failed: " .. p49_1 .. " and no trace available"
    else
        local r49_3 = _G.debug.traceback()
        r49_0 = "Assertion failed: " .. p49_1 .. [[
]] .. r49_3
    end
    print(r49_0)
    _G.error(r49_0)
end

-- line 905-914
-- proto#50 params=0 locals=0 upvalues=0 vararg=false
function initAssertions()
    if enableAssertions then
        print("assertions enabled")
        _G.assert = assertWithStackTrace
    else
        print("assertions disabled")

        -- line 912-912
        -- proto#51 params=0 locals=0 upvalues=0 vararg=false
        function _G.assert()

        end
    end
end

initParams()
initAssertions()
initializeMenuEngine()
initializeGameMenus()
loadGameCenter()
loadLuaFile(scriptPath .. "/gamescene.lua", "", false, false)
assetLoadList = {}
loadlist = {}

-- line 928-939
-- proto#52 params=1 locals=11 upvalues=0 vararg=false
function loadLoadList(p52_0)
    if loadlist[p52_0] == nil then
        loadLuaFileToObject(imagePath .. "/" .. p52_0 .. "/loadlist.lua", this.loadlist, p52_0)
        local r52_0 = print
        local r52_1 = "Loading load list: " .. imagePath .. "/" .. p52_0 .. "/loadlist.lua" .. [[
]]
        r52_0(r52_1)
        for r52_2, r52_3 in _G.pairs(this.loadlist[p52_0].assetLoadList[p52_0]) do
            this.loadlist[p52_0][r52_2] = r52_3
        end
        this.loadlist[p52_0].assetLoadList = nil
    end
end

-- line 941-957
-- proto#53 params=2 locals=19 upvalues=0 vararg=false
local function r0_1(p53_0, p53_1)
    loadLoadList(p53_0)
    local r53_0 = loadlist[p53_0]
    local r53_1 = r53_0[p53_1]
    if r53_1 then
        for r53_2, r53_3 in _G.ipairs(r53_1) do
            if r53_3[2] == 0 then
                local r53_4 = _G.ResourceManager.native_createSpriteSheet
                local r53_5 = imagePath .. "/" .. p53_0 .. "/" .. r53_3[1]
                r53_4(r53_5)
            elseif r53_3[2] == 1 then
                local r53_6 = _G.res.createCompoSpriteSet
                local r53_7 = imagePath .. "/" .. p53_0 .. "/" .. r53_3[1]
                r53_6(r53_7)
            else
                local r53_8 = r53_3[2]
            end
        end
    end
end

-- line 959-974
-- proto#54 params=1 locals=5 upvalues=1 vararg=false
function loadAssets(p54_0)
    for r54_0, r54_1 in _G.ipairs(p54_0) do
        print("---- Loading assets for group : " .. r54_1 .. [[ --- 
]])
        local r54_2 = selectAssetProfile(r54_1)
        r0_1(r54_2, r54_1)
        if showEditor and not isIOSFree() and not deviceModel == "android" then
            local r54_3 = r54_2 .. "_free"
            r0_1(r54_3, r54_1)
        end
    end
end

-- line 976-995
-- proto#55 params=1 locals=23 upvalues=0 vararg=false
function releaseAssets(p55_0)
    for r55_0, r55_1 in _G.ipairs(p55_0) do
        local r55_2 = selectAssetProfile(r55_1)
        loadLoadList(r55_2)
        local r55_3 = loadlist[r55_2]
        local r55_4 = r55_3[r55_1]
        if r55_4 then
            for r55_5, r55_6 in _G.ipairs(r55_4) do
                if r55_6[2] == 0 then
                    local r55_7 = _G.ResourceManager.native_releaseSpriteSheet
                    local r55_8 = imagePath .. "/" .. r55_2 .. "/" .. r55_6[1]
                    r55_7(r55_8)
                elseif r55_6[2] == 1 then
                    local r55_9 = _G.res.releaseCompoSpriteSet
                    local r55_10 = imagePath .. "/" .. r55_2 .. "/" .. r55_6[1]
                    r55_9(r55_10)
                else
                    local r55_11 = r55_6[2]
                end
            end
        end
    end
end

loadImages = loadAssets
loadCompoSprites = loadAssets
releaseImages = releaseAssets
releaseCompoSprites = releaseAssets
mainMenuBGMoved = 0

-- line 1005-1007
-- proto#56 params=0 locals=0 upvalues=0 vararg=false
function resetBGInitialPosition()
    mainMenuBGMoved = 0
end

-- line 1010-1013
-- proto#57 params=0 locals=2 upvalues=0 vararg=false
function toggleFullScreen()
    local r57_0 = SettingsWrapper
    local r57_1 = SettingsWrapper:getFullScreen()
    r57_0:setFullScreen(not r57_1)
    setFullScreenMode(SettingsWrapper:getFullScreen())
end

-- line 1015-1027
-- proto#58 params=0 locals=4 upvalues=0 vararg=false
function loadSpecificLevelAudioAssets()
    local r58_0 = getLevelMetadata(levelName)
    if r58_0.audioLoadList ~= nil then
        for r58_1, r58_2 in _G.pairs(r58_0.audioLoadList) do
            if levelSpecificAudio[r58_2] ~= nil then
                loadSounds(levelSpecificAudio[r58_2])
            end
        end
    end
end

-- line 1029-1033
-- proto#59 params=1 locals=6 upvalues=0 vararg=false
function loadSounds(p59_0)
    for r59_0, r59_1 in _G.pairs(p59_0) do
        local r59_2 = audioPath
        res.createAudio(r59_2 .. r59_1.path, r59_1.name)
    end
end

-- line 1035-1048
-- proto#60 params=3 locals=1 upvalues=0 vararg=false
function saveLuaFileWrapper(p60_0, p60_1, p60_2)
    local r60_0 = isLiteVersion
    local r60_1 = p60_0
    if r60_0 == true and deviceModel == "s60" then
        r60_1 = p60_0
        if p60_1 == "settings" then
            r60_1 = "settings_trial.lua"
        end
        if p60_1 == "highscores" then
            r60_1 = "highscores_trial.lua"
        end
    end
    saveLuaFile(r60_1, p60_1, p60_2)
end

-- line 1050-1077
-- proto#61 params=2 locals=8 upvalues=0 vararg=false
function savePersistentLuaFileWrapper(p61_0, p61_1)
    local r61_0
    local r61_1 = isLiteVersion
    local r61_2 = p61_0
    if r61_1 == true and deviceModel == "s60" then
        r61_2 = p61_0
        if p61_1 == "settings" then
            r61_2 = "settings_trial.lua"
        end
        if p61_1 == "highscores" then
            r61_2 = "highscores_trial.lua"
        end
    end
    if RovioAccount and RovioAccount.profile.id and RovioAccount.profile.email and RovioAccount.profile.email ~= "" then
        if p61_1 == "settings" then
            r61_0 = "settings_" .. RovioAccount.profile.id .. ".lua"
            loadTableFromFile("settings.lua", "localAccountSettings")
            localAccountSettings = CloudSync.combineSettings(localAccountSettings, CloudSync.removeSyncableSettings(settings), true)
            savePersistentLuaFile("settings.lua", "localAccountSettings")
        elseif p61_1 == "highscores" then
            r61_0 = "highscores_" .. RovioAccount.profile.id .. ".lua"
        end
    end
    savePersistentLuaFile(r61_0, p61_1)
end

-- line 1079-1104
-- proto#62 params=0 locals=3 upvalues=0 vararg=false
function handleResolutionPopup()
    if isPCVersion() and menuManager and splashShown and deviceModel ~= "metro" then
        if (screenWidth < 1024 or screenHeight < 600) and not g_resolutionWarningShown then
            g_resolutionWarningShown = true
            local r62_0 = isInGameMode()
            g_isPhysicsEnabledBeforeResolutionWarning = r62_0 and isPhysicsEnabled()
            if isInGameMode() then
                setPhysicsEnabled(false)
            end
            local r62_1 = notificationsFrame
            if r62_1 then
                local r62_2 = ResolutionWarning:new(1024, 600)
                r62_1:addChild(r62_2)
                r62_2:onEntry()
                r62_2:layout()
            end
        end
        local r62_3 = screenWidth
        if r62_3 >= 1024 then
            local r62_4 = screenHeight
            if r62_4 >= 600 and g_resolutionWarningShown then
                g_resolutionWarningShown = false
                if g_isPhysicsEnabledBeforeResolutionWarning and not isPausePageVisible() and isInGameMode() then
                    setPhysicsEnabled(g_isPhysicsEnabledBeforeResolutionWarning)
                end
            end
        end
    end
end

showFps = not releaseBuild
showBG = true
showSleepingObjects = false
fpsTimer = 0
fpsFrames = 0
fps = 0
physicsCounters = { timer = 0, maxStep = 0, message = "0.00ms" }
g_physicsUpdateMillis = 0
zoomLevel = 0
POINTER_DEBUG_COLOR = { 1, 1, 1, 1 }
POINTER_DEBUG_FADE_MAX_TIME = 2
DEBUG_EVENTS_QUEUE = {}

-- line 1128-1427
-- proto#63 params=2 locals=35 upvalues=1 vararg=false
function update(p63_0, p63_1)
    g_safeToQuit = isSafeToQuit()
    if keyHold.CONTROL and keyPressed.I and newProfiler then
        if g_profiler then
            print("Stopping profiler")
            g_profiler:stop()
            local r63_0 = _G.io.open("pepperfish.txt", "w+")
            g_profiler:report(r63_0)
            r63_0:close()
            g_profiler = nil
        else
            print("Starting profiler")
            g_profiler = newProfiler()
            g_profiler:start()
        end
    end
    g_keyPressed = {}
    g_keyHold = {}
    g_keyReleased = {}
    for r63_1, r63_2 in _G.pairs(keyPressed) do
        g_keyPressed[r63_1] = r63_2
    end
    for r63_3, r63_4 in _G.pairs(keyReleased) do
        g_keyReleased[r63_3] = r63_4
    end
    for r63_5, r63_6 in _G.pairs(keyHold) do
        g_keyHold[r63_5] = r63_6
    end
    if adSystem then
        adSystem:update(p63_0, time)
    end
    pause.updatePause(p63_0)
    eventManager:tick()
    if not (processManager == nil or g_resolutionWarningShown) then
        processManager:update(p63_0)
    end
    if setLocale and releaseBuild == false and not startedFromEditor and keyHold.CONTROL then
        if keyPressed["1"] then
            setLocale("en_EN")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["2"] then
            setLocale("fr_FR")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["3"] then
            setLocale("it_IT")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["4"] then
            setLocale("de_DE")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["5"] then
            setLocale("es_ES")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["6"] then
            setLocale("zh_CN")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["7"] then
            setLocale("zh_TW")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["8"] then
            setLocale("ja_JA")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["9"] then
            setLocale("pt_PT")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        elseif keyPressed["0"] then
            setLocale("pl_PL")
            if menuManager and menuManager:getRoot() then
                menuManager:getRoot():layout()
            end
        end
    end
    if deviceModel == "osx" then
        OSX.updateTrackpad(p63_0)
    elseif useAccelerometerControls then
        motionremote.update()
    end
    time = time and time + p63_0 or 0
    playtimeCounter = playtimeCounter and playtimeCounter + p63_0 or 0
    doubleClick = false
    if DEBUG_POINTER_EVENTS then
        for r63_7, r63_8 in _G.pairs(DEBUG_EVENTS_QUEUE) do
            local r63_9 = r63_8.elapsed
            r63_8.elapsed = r63_9 - p63_0
            if r63_8.elapsed < 0 then
                _G.table.remove(DEBUG_EVENTS_QUEUE, r63_7)
            end
        end
    end
    if not (not DEBUG_POINTER_EVENTS or not isKeyPressed("LBUTTON")) or isKeyHold("LBUTTON") or isKeyReleased("LBUTTON") then
        if isKeyPressed("LBUTTON") and isKeyReleased("LBUTTON") then
            POINTER_DEBUG_COLOR = { 1, 0, 0, 1 }
        elseif isKeyPressed("LBUTTON") then
            POINTER_DEBUG_COLOR = { 1, 1, 0, 1 }
        elseif isKeyReleased("LBUTTON") then
            POINTER_DEBUG_COLOR = { 1, 0, 1, 1 }
        elseif isKeyHold("LBUTTON") then
            POINTER_DEBUG_COLOR = { 0, 1, 0, 1 }
        end
        _G.table.insert(DEBUG_EVENTS_QUEUE, {
            x = cursor.x,
            y = cursor.y,
            color = POINTER_DEBUG_COLOR,
            elapsed = POINTER_DEBUG_FADE_MAX_TIME
        })
    end
    if keyReleased.F7 and cheatsEnabled and deviceModel ~= "iphone" and deviceModel ~= "iphone4" and deviceModel ~= "ipad" and deviceModel == "ios" then

    end
    if doubleClickTimer == nil then
        doubleClickTimer = 0
    end
    if isKeyPressed("LBUTTON") then
        if doubleClickState == 2 then
            doubleClickState = 3
        else
            doubleClickState = 1
            doubleClickTimer = 0.5
        end
    else
        local r63_10 = doubleClickTimer
        if r63_10 > 0 and isKeyReleased("LBUTTON") then
            if doubleClickState == 1 then
                doubleClickState = 2
            elseif doubleClickState == 3 then
                doubleClick = true
            end
        end
    end
    doubleClickTimer = doubleClickTimer - p63_0
    if doubleClickTimer <= 0 then
        doubleClickTimer = 0
        doubleClickState = 0
    end
    if isKeyHold("LBUTTON") then
        g_currentCursorName = "CURSOR_HAND_CLICK"
    else
        g_currentCursorName = "CURSOR_HAND_POINT"
    end
    if menuManager:getRoot() ~= nil then
        menuManager:update(p63_0, time)
    end
    updateAudioRampVolume(p63_0, time)
    if keyPressed.F and not releaseBuild then
        showFps = not showFps
    end
    if not releaseBuild and keyHold.CONTROL and reloadLua and keyPressed.R then
        reloadLua()
    end
    if keyPressed["9"] and not releaseBuild and showEditor then
        showBG = not showBG
    end
    if keyPressed["8"] and not releaseBuild then
        showSleepingObjects = not showSleepingObjects
    end
    if keyPressed["7"] and not releaseBuild then
        g_showCameraDebugData = not g_showCameraDebugData
    end
    if showFps then
        local r63_11 = fpsTimer
        if r63_11 >= 1 then
            fps = fpsFrames / fpsTimer
            fpsTimer = 0
            fpsFrames = 0
        end
        fpsString = _G.string.format("%.1f", fps)
        fpsTimer = fpsTimer + p63_1
        fpsFrames = fpsFrames + 1
        physicsCounters.maxStep = _G.math.max(physicsCounters.maxStep, g_physicsUpdateMillis)
        physicsCounters.timer = physicsCounters.timer + p63_1
        local r63_12 = physicsCounters.timer
        if r63_12 >= 0.20000000298023224 then
            physicsCounters.message = _G.string.format("%.2fms", physicsCounters.maxStep)
            physicsCounters.maxStep = 0
            physicsCounters.timer = 0
        end
    end
    if oldScreenWidth == nil or oldScreenHeight == nil then
        oldScreenWidth = screenWidth
        oldScreenHeight = screenHeight
    end
    achievementsFrameUpdate()
    if gamerService then
        gamerService:update(p63_0)
    end
    if Steam then
        Steam:update(p63_0)
    end
    if deviceModel == "windows" or deviceModel == "osx" then
        local r63_13 = isInFullScreenMode()
        if SettingsWrapper:getFullScreen() ~= r63_13 then
            SettingsWrapper:setFullScreen(r63_13)
            screenDimensionsChanges()
            cancelBirdDrag()
        end
        if not SettingsWrapper:getFullScreen() then
            SettingsWrapper:setScreenWidth(screenWidth)
            SettingsWrapper:setScreenHeight(screenHeight)
        end
    end
    if oldScreenWidth ~= screenWidth or oldScreenHeight ~= screenHeight then
        screenDimensionsChanges()
        oldScreenWidth = screenWidth
        oldScreenHeight = screenHeight
        if menuManager and menuManager:getRoot() then
            menuManager:getRoot():layout()
        end
        notificationsFrame:layout()
        handleResolutionPopup()
    end
    notificationsFrame:update(p63_0, time)
    if isPCVersion() then
        if draggedTotal == nil then
            draggedTotal = {}
            draggedTotal.lastX = cursor.x
            draggedTotal.lastY = cursor.y
            draggedTotal.distanceX = 0
            draggedTotal.distanceY = 0
        end
        if isKeyHold("LBUTTON") then
            local r63_14 = _G.math.abs(cursor.x - draggedTotal.lastX)
            draggedTotal.distanceX = draggedTotal.distanceX + r63_14
            local r63_15 = _G.math.abs(cursor.y - draggedTotal.lastY)
            draggedTotal.distanceY = draggedTotal.distanceY + r63_15
            draggedTotal.lastX = cursor.x
            draggedTotal.lastY = cursor.y
        else
            draggedTotal.lastX = cursor.x
            draggedTotal.lastY = cursor.y
            draggedTotal.distanceX = 0
            draggedTotal.distanceY = 0
        end
    end
    for r63_16, r63_17 in _G.pairs(r0_0) do
        r63_17(p63_0, time)
    end
end

-- line 1429-1435
-- proto#64 params=0 locals=3 upvalues=0 vararg=false
function layoutFrames()
    if objects.frameObjects ~= nil then
        for r64_0, r64_1 in _G.pairs(objects.frameObjects) do
            r64_1:layout()
        end
    end
end

-- line 1437-1444
-- proto#65 params=0 locals=3 upvalues=0 vararg=false
function onEntryFrames()
    if objects.frameObjects ~= nil then
        for r65_0, r65_1 in _G.pairs(objects.frameObjects) do
            r65_1:onEntry()
        end
    end
end

-- line 1446-1462
-- proto#66 params=0 locals=0 upvalues=0 vararg=false
function screenDimensionsChanges()
    layoutFrames()
    if currentCamera ~= nil then
        recalculateCameraLimits()
        updateCurrentCameras(currentCamera)
    end
    if g_usingNewCamera and gameCamera ~= nil then
        gameCamera:resolutionChanged()
        gameCamera:updateActiveCameras()
    end
end

-- line 1464-1534
-- proto#67 params=0 locals=56 upvalues=0 vararg=false
function draw()
    handleGestureButtonVisibility()
    if menuManager:getRoot() ~= nil then
        menuManager:draw()
    end
    notificationsFrame:draw()
    native_drawNotificationParticles()
    if showFps then
        local r67_0 = 1
        if getFontScale then
            local r67_1
            r67_0 = r67_1
        end
        setFont("FONT_SPACE_BASIC")
        setRenderState(0, 0, r67_0, r67_0, 0)
        res.drawString("", fpsString, screenWidth * 0.5 / r67_0, screenHeight / r67_0, "BOTTOM", "HCENTER")
        res.drawString("", physicsCounters.message, screenWidth * 0.30000001192092896 / r67_0, screenHeight / r67_0, "BOTTOM", "RIGHT")
        if g_usedTextureMemory then
            local r67_2 = _G.string.format("%.2fmb", g_usedTextureMemory / 1024 / 1024)
            res.drawString("", r67_2, screenWidth * 0.6000000238418579 / r67_0, screenHeight / r67_0, "BOTTOM", "LEFT")
        end
        if g_usedAudioMemory then
            local r67_3 = _G.string.format("%.2fmb", g_usedAudioMemory / 1024 / 1024)
            res.drawString("", r67_3, screenWidth * 0.800000011920929 / r67_0, screenHeight / r67_0, "BOTTOM", "LEFT")
        end
    end
    for r67_4 = 1, #g_debugLines do
        drawLine2D(0, g_debugLines[r67_4].y, screenWidth, g_debugLines[r67_4].y, 2, 255, 0, 0, 255)
        local r67_5 = g_debugLines[r67_4]
        local r67_6 = g_debugLines[r67_4]
        drawLine2D(r67_5.x, 0, r67_6.x, screenHeight, 2, 0, 255, 0, 255)
    end
    for r67_7 = 1, #g_debugPoints do
        local r67_8 = 5
        drawLine2D(g_debugPoints[r67_7].x - r67_8, g_debugPoints[r67_7].y, g_debugPoints[r67_7].x + r67_8, g_debugPoints[r67_7].y, 2, 255, 0, 0, 255)
        drawLine2D(g_debugPoints[r67_7].x, g_debugPoints[r67_7].y - r67_8, g_debugPoints[r67_7].x, g_debugPoints[r67_7].y + r67_8, 2, 0, 255, 0, 255)
    end
    if useAccelerometerControls then
        motionremote.drawCursor()
    elseif not showCursor and isPCVersion() then
        drawPCCursor()
    end
    drawLoadingScreen()
    if DEBUG_POINTER_EVENTS then
        for r67_9, r67_10 in _G.pairs(DEBUG_EVENTS_QUEUE) do
            local r67_11 = 2
            drawRect(r67_10.color[1], r67_10.color[2], r67_10.color[3], r67_10.elapsed / POINTER_DEBUG_FADE_MAX_TIME, r67_10.x - r67_11, r67_10.y - r67_11, r67_10.x + r67_11, r67_10.y + r67_11, true)
        end
    end
    if luaRovioShelf then
        luaRovioShelf.render()
    end
end

-- line 1537-1549
-- proto#68 params=0 locals=4 upvalues=0 vararg=false
function handleGestureButtonVisibility()
    if isPCVersion() and isInGameMode() then
        local r68_0 = menuManager:getRoot()
        if not r68_0 then
            return
        end
        local r68_1 = OSX.using_mouse
        if not r68_1 then
            local r68_2
            r68_1 = not r68_2
        end
        local r68_3 = r68_0:getChild("pauseButton")
        local r68_4 = r68_0:getChild("restartButton")
        if r68_3 then
            r68_3:setVisible(r68_1)
        end
        if r68_4 then
            r68_4:setVisible(r68_1)
        end
    end
end

-- line 1551-1570
-- proto#69 params=0 locals=4 upvalues=0 vararg=false
function gameResumed()
    layoutFrames()
    if gameCenterEnabled and gameCenter and gameCenter.leaderboards and leaderboards and levelOrder then
        postTotalHighScores()
    end
    local r69_0 = {}
    if SettingsWrapper.getLastTimeGamePaused ~= nil then
        r69_0 = getTimeDifference(getCurrentTime(), SettingsWrapper:getLastTimeGamePaused())
    end
    local r69_1 = eventManager
    local r69_2 = { id = events.EID_GAME_RESUMED, differenceInSeconds = r69_0.seconds }
    r69_1:notify(r69_2)
end

-- line 1572-1587
-- proto#70 params=0 locals=1 upvalues=0 vararg=false
function gamePaused()
    calculatePlaytime()
    updateLastTimeGamePaused()
    saveSettings()
    savePersistentLuaFileWrapper("highscores.lua", "highscores")
    savePersistentLuaFileWrapper("bi_data.lua", "bi_data")
    storePersistentData()
    savePurchases()
    if not (menuManager == nil or menuManager:getRoot() == nil) then
        local r70_0 = menuManager:getRoot()
        local r70_1 = r70_0.name
    end
    eventManager:notify({ id = events.EID_GAME_PAUSED })
end

-- line 1589-1591
-- proto#71 params=0 locals=0 upvalues=0 vararg=false
function saveSettings()
    savePersistentLuaFileWrapper("settings.lua", "settings")
end

-- line 1593-1597
-- proto#72 params=0 locals=0 upvalues=0 vararg=false
function updateLastTimeGamePaused()
    if SettingsWrapper.setLastTimeGamePaused ~= nil then
        SettingsWrapper:setLastTimeGamePaused(getCurrentTime())
    end
end

-- line 1639-1663
-- proto#73 params=0 locals=0 upvalues=0 vararg=false
function initializeMenu()
    if SettingsWrapper:isAudioEnabled() then
        if not res.startAudioOutput() then
            if isPCVersion() == true then
                res.createAudioOutput(2, 16, 44100)
            else
                res.createAudioOutput(1, 16, 16000)
            end
        end
        setEffectsVolume(1)
        setMusicVolume(1)
    else
        res.stopAudioOutput()
        setEffectsVolume(0)
        setMusicVolume(0)
    end
    savePersistentLuaFileWrapper("settings.lua", "settings")
    storePersistentData()
end

-- line 1668-1681
-- proto#74 params=1 locals=7 upvalues=0 vararg=false
function getLastOpenLevelOfLevelPackFromHighscores(p74_0)
    local r74_0
    local r74_1 = 0
    if highscores ~= nil then
        local r74_2 = 1
        local r74_3 = levelOrder[p74_0]
        local r74_4 = #r74_3
        local r74_5 = 1
        r74_0 = r74_1
        for r74_6 = r74_2, r74_4, r74_5 do
            local r74_7 = levelOrder[p74_0]
            local r74_8 = r74_7[r74_6]
            if highscores[r74_8] == nil then
                r74_1 = r74_0
            else
                local r74_9 = highscores[r74_8]
                if r74_9.score then
                    local r74_10 = highscores[r74_8]
                    local r74_11 = r74_10.score
                    if r74_11 > 0 then
                        local r74_12 = highscores[r74_8]
                        if r74_12.completed == true then
                            r74_0 = _G.math.max(r74_0, r74_6 + 1)
                            r74_1 = r74_0
                        else
                            r74_1 = r74_0
                        end
                    else
                        r74_1 = r74_0
                    end
                else
                    r74_1 = r74_0
                end
            end
        end
    end
    return r74_0
end

-- line 1683-1688
-- proto#75 params=1 locals=2 upvalues=0 vararg=false
function getEagleScoreFromHighscores(p75_0)
    if highscores[p75_0] then
        local r75_0 = highscores[p75_0]
        return r75_0.eagleScore or 0
    end
    return 0
end

-- line 1690-1700
-- proto#76 params=0 locals=4 upvalues=0 vararg=false
function getEaglePercentageScore()
    local r76_0 = getLevelEagleScoreLimit(levelName)
    if r76_0 == nil then
        return 100
    end
    local r76_1 = _G.math.floor
    local r76_2 = _G.math.min(score, r76_0)
    return (r76_1(r76_2 / r76_0 * 100))
end

-- line 1702-1710
-- proto#77 params=1 locals=4 upvalues=0 vararg=false
function getLevelEagleScoreLimit(p77_0)
    if starTable[p77_0] == nil then
        return starTable.default.eagleScore
    end
    local r77_0 = starTable[p77_0].eagleScore or starTable.default.eagleScore
    return r77_0
end

-- line 1712-1718
-- proto#78 params=0 locals=4 upvalues=0 vararg=false
function isEagleUsedInLevel()
    local r78_0 = false
    if not startedFromEditor then
        local r78_1 = getEpisodeMetadata(currentFolder)
        r78_0 = r78_1.alwaysInEagleMode
    end
    local r78_2 = numMightyEaglesShot > 0 and true or r78_0
    return r78_2
end

-- line 1720-1741
-- proto#79 params=2 locals=8 upvalues=0 vararg=false
function getLevelStarScoreLimit(p79_0, p79_1)
    assert(p79_1 ~= nil, "Wrong  number of stars")
    if p79_1 == 1 then
        return 0
    end
    if p79_1 == 2 then
        if starTable[p79_0] == nil then
            return starTable.default.silverScore
        end
        local r79_0 = starTable[p79_0].silverScore or starTable.default.silverScore
        return r79_0
    end
    if p79_1 ~= 3 then
        return
    end
    if starTable[p79_0] == nil then
        return starTable.default.goldScore
    end
    local r79_1 = starTable[p79_0].goldScore or starTable.default.goldScore
    return r79_1
end

-- line 1743-1760
-- proto#80 params=1 locals=13 upvalues=0 vararg=false
function getLevelStarsFromHighscores(p80_0)
    if not (highscores[p80_0] ~= nil and (highscores[p80_0].score ~= nil or powerups and highscores[p80_0].powerUpScore ~= nil)) or getLevelMetadata(p80_0).type == "comic" then
        return 0
    end
    if powerups then
        local r80_0 = highscores[p80_0]
        if r80_0.powerUpScore ~= nil then
            local r80_1 = highscores[p80_0]
            local r80_2 = r80_1.powerUpScore
            local r80_3 = highscores[p80_0]
            local r80_4 = r80_3.score
            if r80_2 <= r80_4 then
                local r80_5 = highscores[p80_0]
                return getLevelStars(p80_0, r80_5.score)
            end
            if r80_4 < r80_2 then
                local r80_6 = highscores[p80_0]
                return getLevelStars(p80_0, r80_6.powerUpScore)
            end
        end
    end
    local r80_7 = highscores[p80_0]
    return getLevelStars(p80_0, r80_7.score)
end

-- line 1762-1776
-- proto#81 params=2 locals=1 upvalues=0 vararg=false
function getLevelStars(p81_0, p81_1)
    if getLevelMetadata(p81_0).type ~= "comic" then
        local r81_0 = starTable[p81_0]
        if not r81_0 then
            local r81_1
            r81_0 = r81_1.default
        end
        if p81_1 and r81_0 then
            if r81_0.goldScore <= p81_1 then
                return 3
            end
            if r81_0.silverScore <= p81_1 then
                return 2
            end
            if p81_1 > 0 then
                return 1
            end
        end
    end
    return 0
end

-- line 1779-1787
-- proto#82 params=1 locals=0 upvalues=0 vararg=false
function setEffectsVolume(p82_0)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 0)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 1)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 2)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 3)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 4)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 5)
    res.setTrackVolume(p82_0 * 0.6000000238418579, 6)
end

-- line 1789-1791
-- proto#83 params=1 locals=0 upvalues=0 vararg=false
function setMusicVolume(p83_0)
    res.setTrackVolume(p83_0, 7)
end

-- line 1794-1811
-- proto#84 params=2 locals=1 upvalues=0 vararg=false
function updateAudioRampVolume(p84_0, p84_1)
    if audioRampVolume then
        audioRampVolume = audioRampVolume + p84_0 / audioRampLength
        if audioRampVolume <= 0 then
            _G.res.stopAudioOutput()
            audioRampVolume = nil
        else
            local r84_0 = audioRampVolume
            if r84_0 > 1 then
                audioRampVolume = nil
            else
                setMusicVolume(audioRampVolume * audioRampVolume)
                setEffectsVolume(audioRampVolume * audioRampVolume)
            end
        end
    end
end

-- line 1814-1864
-- proto#85 params=0 locals=61 upvalues=0 vararg=false
function rePopulateWithRandomThemeSprites()
    local r85_0 = worldToPhysicsTransform
    local r85_1 = objects.castleCameraData[deviceModel]
    local r85_2 = r85_1.left
    local r85_3 = objects.castleCameraData[deviceModel]
    local r85_4, r85_5 = r85_0(r85_2, r85_3.bottom)
    local r85_6 = -1
    for r85_7, r85_8 in _G.pairs(repopulationLayers) do
        local r85_9 = r85_8.timer
        if r85_9 > 0 then
            local r85_10 = r85_8.timer
            r85_8.timer = r85_10 - 0.10000000149011612
        else
            local r85_11 = r85_8.repopulationTimer
            r85_8.timer = r85_11 or 1
            local r85_12 = objects.castleCameraData[deviceModel]
            local r85_13 = r85_12.screenWidth
            local r85_14 = objects.castleCameraData[deviceModel]
            local r85_15 = r85_14.screenHeight
            local r85_16 = r85_13 * 0.5
            local r85_17 = r85_15 * 0.5
            local r85_18 = r85_8.layer
            local r85_19 = r85_8.elements.amount or 0
            local r85_20 = r85_8.elements.scale or 0
            local r85_21
            if r85_19 > 1 then
                if deviceModel == "iphone" then
                    local r85_22 = r85_8.elements.amount
                    r85_21 = r85_22 / 2
                elseif deviceModel == "iphone4" then
                    local r85_23 = r85_8.elements.amount
                    r85_21 = r85_23 / 2
                else
                    r85_21 = r85_19
                end
            elseif deviceModel == "iphone4" then
                local r85_24 = r85_8.elements.amount
                r85_21 = r85_24 / 2
            else
                r85_21 = r85_19
            end
            local r85_25 = r85_8.elements.w or 1
            local r85_26 = r85_8.elements.h or 1
            local r85_27 = r85_8.elements.x or 0
            local r85_28 = r85_8.elements.y or 0
            local r85_29 = objects.castleCameraData[deviceModel]
            local r85_30 = r85_29.screenWidth
            local r85_31 = r85_27 * r85_30
            local r85_32 = objects.castleCameraData[deviceModel]
            local r85_33 = r85_32.screenHeight
            local r85_34 = r85_28 * r85_33
            local r85_35 = r85_16 * r85_25
            local r85_36 = r85_17 * r85_26
            for r85_37 = 1, r85_21 do
                local r85_38 = 0
                local r85_39 = r85_8.elements
                local r85_40
                if r85_39.randomRotation then
                    r85_40 = _G.math.random(0, _G.math.pi * 2)
                else
                    r85_40 = r85_38
                end
                local r85_41 = r85_8.scale * r85_20
                local r85_42 = _G.math.random()
                local r85_43 = (0.5 - r85_42) * 2
                local r85_44 = r85_8.elements.variation
                local r85_45 = r85_41 + r85_43 * r85_44
                local r85_46 = r85_8.elements.sprites[_G.math.random(1, #r85_8.elements.sprites)]
                local r85_47 = {
                    isAnimation = r85_8.elements.isAnimation,
                    bLoop = r85_8.elements.bLoop,
                    x = r85_31 + _G.math.random(-r85_35, r85_35),
                    y = r85_34 + _G.math.random(-r85_36, r85_36),
                    angle = r85_40,
                    layer = r85_18,
                    scale = { x = r85_45, y = r85_45 },
                    sprite = r85_46,
                    name = r85_46 .. r85_37,
                    velX = r85_8.elements.velX,
                    velY = r85_8.elements.velY or 0,
                    scaleSpeed = 0,
                    animation = r85_8.elements.sprites,
                    animDelay = r85_8.elements.animDelay,
                    startingDelay = r85_8.elements.startingDelay
                }
                addRandomThemeSprite(r85_47.name, r85_47)
            end
            r85_6 = -r85_6
        end
    end
end

-- line 1866-1961
-- proto#86 params=0 locals=85 upvalues=0 vararg=false
function populateWithRandomThemeSprites()
    local r86_0 = worldToPhysicsTransform
    local r86_1 = objects.castleCameraData[deviceModel]
    local r86_2 = r86_1.left
    local r86_3 = objects.castleCameraData[deviceModel]
    local r86_4, r86_5 = r86_0(r86_2, r86_3.bottom)
    local r86_6, r86_7 = 0, -1
    repopulationLayers = {}
    repopulationTimer = 1
    local r86_8 = _G.pairs
    local r86_9 = blockTable.themes[currentTheme]
    for r86_10, r86_11 in r86_8(r86_9.bgLayers) do
        if r86_11.elements then
            local r86_12 = objects.castleCameraData[deviceModel]
            local r86_13 = r86_12.screenWidth
            local r86_14 = objects.castleCameraData[deviceModel]
            local r86_15 = r86_14.screenHeight
            local r86_16 = r86_13 * 0.5
            local r86_17 = r86_15 * 0.5
            if r86_11.repopulate then
                r86_11.layer = r86_6
                local r86_18 = r86_11.repopulationTimer
                r86_11.timer = r86_18 or 1
                repopulationLayers[r86_10] = r86_11
            end
            local r86_19 = r86_11.elements.amount
            if not r86_19 then
                r86_19 = 0
            end
            local r86_20 = r86_11.elements.scale or 0
            local r86_21
            if r86_19 > 1 then
                if deviceModel == "iphone" then
                    r86_21 = r86_19 / 2
                elseif deviceModel == "iphone4" then
                    r86_21 = r86_19 / 2
                else
                    r86_21 = r86_19
                end
            else
                r86_21 = r86_19
            end
            local r86_22 = r86_11.elements.w or 1
            local r86_23 = r86_11.elements.h or 1
            local r86_24 = r86_11.elements.x or 0
            local r86_25 = r86_11.elements.y or 0
            local r86_26 = objects.castleCameraData[deviceModel]
            local r86_27 = r86_26.screenWidth
            local r86_28 = r86_24 * r86_27
            local r86_29 = objects.castleCameraData[deviceModel]
            local r86_30 = r86_29.screenHeight
            local r86_31 = r86_25 * r86_30
            local r86_32 = r86_16 * r86_22
            local r86_33 = r86_17 * r86_23
            for r86_34 = 1, r86_21 do
                local r86_35 = 0
                local r86_36 = r86_11.elements
                local r86_37
                if r86_36.randomRotation then
                    r86_37 = _G.math.random(0, _G.math.pi * 2)
                else
                    r86_37 = r86_35
                end
                local r86_38 = r86_11.scale * r86_20
                local r86_39 = _G.math.random()
                local r86_40 = (0.5 - r86_39) * 2
                local r86_41 = r86_11.elements.variation
                local r86_42 = r86_38 + r86_40 * r86_41
                local r86_43 = r86_11.elements.sprites[_G.math.random(1, #r86_11.elements.sprites)]
                local r86_44 = {
                    isAnimation = r86_11.elements.isAnimation,
                    bLoop = r86_11.elements.bLoop,
                    x = r86_28 + _G.math.random(-r86_32, r86_32),
                    y = r86_31 + _G.math.random(-r86_33, r86_33),
                    angle = r86_37,
                    layer = r86_6,
                    scale = { x = r86_42, y = r86_42 },
                    sprite = r86_43,
                    name = r86_43 .. r86_34,
                    velX = r86_11.elements.velX,
                    velY = r86_11.elements.velY or 0,
                    scaleSpeed = 0,
                    animation = r86_11.elements.sprites,
                    animDelay = r86_11.elements.animDelay,
                    startingDelay = r86_11.elements.startingDelay
                }
                addRandomThemeSprite(r86_44.name, r86_44)
            end
            r86_6 = r86_6 + 1
            r86_7 = -r86_7
        end
    end
    local r86_45 = _G.pairs
    local r86_46 = blockTable.themes[currentTheme]
    for r86_47, r86_48 in r86_45(r86_46.fgLayers) do
        if r86_48.elements then
            local r86_49 = 0
            local r86_50 = 0
            if r86_48.elements.amount then
                local r86_51 = r86_48.elements.scale
                if r86_51 then
                    r86_50 = r86_51
                else
                    r86_50 = 0
                end
                if deviceModel == "iphone" or deviceModel == "iphone4" then
                    local r86_52 = r86_48.elements.amount
                    r86_49 = r86_52 / 2
                else
                    r86_49 = r86_48.elements.amount
                end
            end
            for r86_53 = 1, r86_49 do
                local r86_54 = 0
                local r86_55 = r86_48.elements
                local r86_56
                if r86_55.randomRotation then
                    r86_56 = _G.math.random(0, _G.math.pi * 2)
                else
                    r86_56 = r86_54
                end
                local r86_57 = r86_48.scale * r86_50
                local r86_58 = _G.math.random()
                local r86_59 = (0.5 - r86_58) * 2
                local r86_60 = r86_48.elements.variation
                local r86_61 = r86_57 + r86_59 * r86_60
                local r86_62 = r86_48.elements.sprites[_G.math.random(1, #r86_48.elements.sprites)]
                local r86_63 = {
                    isAnimation = r86_48.elements.isAnimation,
                    bLoop = r86_48.elements.bLoop,
                    x = _G.math.random(-w, w),
                    y = _G.math.random(-h, h),
                    angle = r86_56,
                    layer = r86_6,
                    scale = { x = r86_61, y = r86_61 },
                    sprite = r86_62,
                    name = r86_62 .. r86_53,
                    velX = r86_48.elements.velX,
                    velY = r86_48.elements.velY or 0,
                    scaleSpeed = 0,
                    animation = r86_48.elements.sprites,
                    animDelay = r86_48.elements.animDelay,
                    startingDelay = r86_48.elements.startingDelay
                }
                addRandomThemeSprite(r86_63.name, r86_63)
            end
            r86_6 = r86_6 + 1
            r86_7 = -r86_7
        end
    end
end

-- line 1965-2013
-- proto#87 params=2 locals=11 upvalues=0 vararg=false
function addRandomThemeSprite(p87_0, p87_1)
    local r87_0, r87_1
    local r87_2 = p87_1.horFlip
    if not r87_2 then
        r87_2 = false
    end
    local r87_3 = p87_1.sprite
    if not p87_1.angleVel then

    end
    if p87_1.scale ~= nil then
        local r87_4 = p87_1.scale.x
        if r87_4 then
            r87_0 = r87_4
        else
            r87_0 = 1
        end
        local r87_5 = p87_1.scale.y
        if r87_5 then
            r87_1 = r87_5
        else
            r87_1 = 1
        end
    end
    p87_1.scaleX = r87_0
    p87_1.scaleY = r87_1
    p87_1.spriteName = p87_1.sprite
    if p87_1.isAnimation then
        createThemeAnimation(p87_1)
    else
        createThemeSprite(p87_1.name, r87_3, p87_1.x, p87_1.y, r87_0, r87_1, p87_1.angle, p87_1.layer, p87_1.scaleSpeed, r87_2, p87_1.velX, p87_1.velY)
    end
    themeSpriteObjects[p87_0] = {
        x = p87_1.x,
        y = p87_1.y,
        name = p87_1.name,
        definition = p87_1.definition,
        scale = p87_1.scale or {},
        angle = p87_1.angle,
        layer = p87_1.layer,
        horFlip = r87_2
    }
    local r87_6, r87_7 = res.getSpriteBounds(r87_3)
    local r87_8 = 0.9200000166893005
    local r87_9 = r87_6 * physicsScale * r87_8
    local r87_10 = r87_7 * physicsScale * r87_8
    themeSpriteObjects[p87_0].width = r87_9
    themeSpriteObjects[p87_0].height = r87_10
end

-- line 2017-2045
-- proto#88 params=3 locals=10 upvalues=0 vararg=false
function addThemeSprite(p88_0, p88_1, p88_2)
    print("ADDING THEME SPRITE, NAME = " .. p88_0 .. [[
]])
    local r88_0 = p88_1
    local r88_1 = blockTable.blocks[r88_0.definition]
    if not r88_1.horFlip then

    end
    local r88_2 = blockTable.blocks[r88_0.definition]
    local r88_3 = r88_2.sprite
    local r88_4
    if r88_3 then
        r88_4 = r88_3
    else
        local r88_5 = blockTable.blocks[r88_0.definition]
        if r88_5.damageSprites then
            local r88_6 = blockTable.blocks[r88_0.definition]
            r88_4 = r88_6.damageSprites.damage1
        else
            r88_4 = r88_3
        end
    end
    local r88_7 = blockTable.blocks[r88_0.definition]
    if not r88_7.angleVel then

    end
    createThemeSprite(r88_0.name, r88_4, r88_0.x, r88_0.y, r88_0.scale.x or 1, r88_0.scale.y or 1, r88_0.angle, r88_0.layer, 0, false, 0, 0)
    if startedFromEditor then
        ui.EditorScene.createEditableSprite(r88_0)
    end
end

-- line 2047-2050
-- proto#89 params=3 locals=4 upvalues=0 vararg=false
function addEventCall(p89_0, p89_1, p89_2)
    if not p89_2 then
        local r89_0 = actions[p89_0]
        local r89_1 = r89_0.params.timer
        if r89_1 then
            p89_2 = r89_1
        else
            p89_2 = 0
        end
    end
    _G.table.insert(g_queuedEventCalls, { actionName = p89_0, params = p89_1, timer = p89_2 })
end

-- line 2053-2065
-- proto#90 params=1 locals=8 upvalues=0 vararg=false
function removeEventCall(p90_0)
    for r90_0, r90_1 in _G.ipairs(g_queuedEventCalls) do
        if r90_1.actionName == p90_0 then
            _G.table.remove(g_queuedEventCalls, r90_0)
        end
    end
    for r90_2, r90_3 in _G.ipairs(eventCalls) do
        if r90_3.actionName == p90_0 then
            _G.table.remove(eventCalls, r90_2)
        end
    end
end

-- line 2068-2104
-- proto#91 params=1 locals=16 upvalues=0 vararg=false
function updateEventCalls(p91_0)
    if eventCalls ~= nil then
        for r91_0, r91_1 in _G.ipairs(g_queuedEventCalls) do
            _G.table.insert(eventCalls, r91_1)
        end
        g_queuedEventCalls = {}
        for r91_2, r91_3 in _G.ipairs(eventCalls) do
            if r91_3.timer <= 0 and not r91_3.expired then
                if actions[r91_3.actionName] ~= nil then
                    if r91_3.params == nil then
                        r91_3.params = {}
                    end
                    r91_3.params.dt = p91_0
                    _G.assert(actions[r91_3.actionName] ~= nil, "Failed to find action " .. r91_3.actionName)
                    local r91_4 = actions[r91_3.actionName]
                    r91_4.action(r91_3.params)
                    r91_3.expired = true
                end
            else
                local r91_5 = r91_3.timer
                r91_3.timer = r91_5 - p91_0
            end
        end
        for r91_6 = 1, #eventCalls do
            local r91_7 = eventCalls[r91_6]
            if r91_7 and r91_7.expired then
                _G.table.remove(eventCalls, r91_6)
                local r91_8 = r91_6 - 1
            end
        end
    end
end

-- line 2106-2118
-- proto#92 params=4 locals=3 upvalues=0 vararg=false
function addUpdateCall(p92_0, p92_1, p92_2, p92_3)
    if not p92_2 then
        local r92_0 = actions[p92_0]
        p92_2 = r92_0.params.timer
    end
    if p92_2 > 0 then
        addEventCall(p92_0, p92_1, p92_2)
    else
        local r92_1 = p92_3
        if p92_3 == nil then
            r92_1 = #updateCalls + 1
        end
        updateCalls[r92_1] = { actionName = p92_0, params = p92_1, timer = p92_2 }
    end
end

-- line 2120-2122
-- proto#93 params=1 locals=0 upvalues=0 vararg=false
function removeUpdateCall(p93_0)
    updateCalls[p93_0] = nil
end

-- line 2124-2126
-- proto#94 params=1 locals=1 upvalues=0 vararg=false
function hasUpdateCall(p94_0)
    local r94_0 = updateCalls[p94_0]
    return r94_0 ~= nil
end

-- line 2132-2148
-- proto#95 params=0 locals=6 upvalues=0 vararg=false
function checkGetLevelFileName()
    if not (levelName == "LevelSelection" or levelName == getEpisodeSelectionLevelName() or levelName == "Credits" or levelName == "MainMenu") then
        for r95_0, r95_1 in _G.pairs(actions.myLevels) do
            for r95_2, r95_3 in _G.pairs(r95_1) do
                local r95_4 = levelName
                if r95_3 == r95_4 then
                    currentFolder = r95_0
                    levelFolder = "levels/" .. currentFolder .. "/"
                    return levelFolder .. r95_3
                end
            end
        end
    end
end

-- line 2152-2165
-- proto#96 params=1 locals=4 upvalues=0 vararg=false
function isLevelInCurrentFolder(p96_0)
    if p96_0 == "MainMenu" or p96_0 == getEpisodeSelectionLevelName() or p96_0 == "Credits" then
        return true
    end
    for r96_0, r96_1 in _G.ipairs(actions.myLevels[currentFolder]) do
        if r96_1 == p96_0 then
            return true
        end
    end
    return false
end

-- line 2168-2195
-- proto#97 params=3 locals=25 upvalues=0 vararg=false
function replaceSocialLinks(p97_0, p97_1, p97_2)
    for r97_0, r97_1 in _G.ipairs(p97_1) do
        if not p97_0.counts[r97_1.what] then

        end
        local r97_2 = r97_1.what .. "_" .. p97_2
        local r97_3 = r97_1.with
        _G.assert(p97_0.world[r97_2] ~= nil, "block naming is not sequential")
        _G.assert(p97_0.world[r97_3] == nil, "attempting to overwrite existing block")
        p97_0.world[r97_3] = p97_0.world[r97_2]
        p97_0.world[r97_3].name = r97_3
        p97_0.world[r97_3].definition = r97_1.with
        p97_0.world[r97_2] = nil
        p97_0.counts[r97_1.with] = 1
        p97_0.counts[r97_1.what] = p97_0.counts[r97_1.what] - 1
        local r97_4 = "^" .. r97_1.what .. "_[0-9]+$"
        for r97_5, r97_6 in _G.pairs(p97_0.joints) do
            local r97_7 = _G.assert
            local r97_8 = _G.string.find
            local r97_9
            if r97_8(r97_6.end1, r97_4) then
                r97_9 = false
            else
                r97_9 = not _G.string.find(r97_6.end2, r97_4)
            end
            r97_7(r97_9, "replacing blocks with joints attached is not supported")
        end
    end
end

-- line 2199-2231
-- proto#98 params=2 locals=35 upvalues=0 vararg=false
function replaceBlocks(p98_0, p98_1)
    for r98_0, r98_1 in _G.ipairs(p98_1) do
        local r98_2 = p98_0.counts[r98_1.what]
        if not r98_2 then
            r98_2 = 0
        end
        local r98_3 = p98_0.counts[r98_1.with]
        if not r98_3 then
            r98_3 = 0
        end
        for r98_4 = 1, r98_2 do
            local r98_5 = r98_1.what
            local r98_6 = "_"
            local r98_7 = _G.tostring(r98_4)
            local r98_8 = r98_5 .. r98_6 .. r98_7
            local r98_9 = _G.tostring(r98_4)
            local r98_10 = r98_1.with .. "_" .. r98_9 + r98_3
            _G.assert(p98_0.world[r98_8] ~= nil, "block naming is not sequential")
            _G.assert(p98_0.world[r98_10] == nil, "attempting to overwrite existing block")
            p98_0.world[r98_10] = p98_0.world[r98_8]
            p98_0.world[r98_10].name = r98_10
            p98_0.world[r98_10].definition = r98_1.with
            p98_0.world[r98_8] = nil
        end
        if r98_2 > 0 then
            p98_0.counts[r98_1.with] = p98_0.counts[r98_1.what] + r98_3
            p98_0.counts[r98_1.what] = nil
            local r98_11 = "^" .. r98_1.what .. "_[0-9]+$"
            for r98_12, r98_13 in _G.pairs(p98_0.joints) do
                local r98_14 = _G.assert
                local r98_15 = _G.string.find
                local r98_16
                if r98_15(r98_13.end1, r98_11) then
                    r98_16 = false
                else
                    r98_16 = not _G.string.find(r98_13.end2, r98_11)
                end
                r98_14(r98_16, "replacing blocks with joints attached is not supported")
            end
        end
    end
end

-- line 2233-2256
-- proto#99 params=2 locals=16 upvalues=0 vararg=false
function filterBlocks(p99_0, p99_1)
    for r99_0, r99_1 in _G.ipairs(p99_1) do
        local r99_2 = p99_0.counts[r99_1]
        if not r99_2 then
            r99_2 = 0
        end
        for r99_3 = 1, r99_2 do
            local r99_4 = _G.tostring(r99_3)
            local r99_5 = r99_1 .. "_" .. r99_4
            _G.assert(p99_0.world[r99_5] ~= nil, "block naming is not sequential")
            p99_0.world[r99_5] = nil
        end
        if r99_2 > 0 then
            p99_0.counts[r99_1] = nil
            local r99_6 = "^" .. r99_1 .. "_[0-9]+$"
            for r99_7, r99_8 in _G.pairs(p99_0.joints) do
                if _G.string.find(r99_8.end1, r99_6) or _G.string.find(r99_8.end2, r99_6) then
                    p99_0.joints[r99_7] = nil
                end
            end
        end
    end
end

-- line 2258-2282
-- proto#100 params=1 locals=4 upvalues=0 vararg=false
function isObjectAvailableForDevice(p100_0)
    if startedFromEditor then
        return true
    end
    local r100_0 = blockTable.blocks[p100_0]
    if r100_0.supportedPlatforms ~= nil then
        for r100_1, r100_2 in _G.ipairs(r100_0.supportedPlatforms) do
            local r100_3 = deviceModel
            if r100_2 == r100_3 then
                if r100_0.supportedManufacturer == nil then
                    return true
                end
                if r100_0.supportedManufacturer == deviceManufacturer then
                    return true
                end
                return false
            end
        end
        return false
    end
    return true
end

-- line 2284-2343
-- proto#101 params=2 locals=43 upvalues=0 vararg=false
function addKillingBox(p101_0, p101_1)
    local r101_0, r101_1 = objects.birdCameraData[deviceModel], objects.castleCameraData[deviceModel]
    local r101_2 = _G.math.min(r101_0.py, r101_1.py)
    local r101_3 = _G.math.max(r101_0.py, r101_1.py)
    local r101_4, r101_5 = nil, nil
    local r101_6 = r101_0.px
    local r101_7 = r101_1.px
    local r101_8
    local r101_9
    if r101_6 < r101_7 then
        r101_8 = r101_0.px - r101_0.screenWidth * 0.5 / r101_0.sx
        r101_9 = r101_1.px + r101_1.screenWidth * 0.5 / r101_1.sx
    else
        r101_8 = r101_1.px - r101_1.screenWidth * 0.5 / r101_1.sx
        r101_9 = r101_0.px + r101_0.screenWidth * 0.5 / r101_0.sx
    end
    local r101_10 = r101_8 + (r101_9 - r101_8) * 0.5
    local r101_11 = r101_2 + (r101_3 - r101_2) * 0.5
    local r101_12 = r101_10 - screenWidth * 0.5 / minWorldScale
    local r101_13 = r101_10 + screenWidth * 0.5 / minWorldScale
    local r101_14 = r101_11 - screenHeight * 0.5 / minWorldScale
    local r101_15 = r101_11 + screenHeight * 0.5 / minWorldScale
    local r101_16, r101_17 = worldToPhysicsTransform(r101_12, r101_14)
    local r101_18, r101_19 = worldToPhysicsTransform(r101_13, r101_15)
    g_killingVolumePhysics = {}
    g_killingVolumePhysics.left = r101_16
    g_killingVolumePhysics.right = r101_18
    g_killingVolumePhysics.top = r101_17
    g_killingVolumePhysics.bottom = r101_19
    local r101_20 = _G.math.abs(r101_18 - r101_16)
    local r101_21 = _G.math.abs(r101_17 - r101_19)
    local r101_22 = r101_16 + r101_20 * 0.5
    local r101_23 = r101_17 + r101_21 * 0.5
    local r101_24 = g_killingVolumeOffsets[deviceModel]
    if not r101_24 then
        local r101_25
        r101_24 = r101_25.default
    end
    local r101_26 = p101_0
    if not p101_0 then
        r101_26 = r101_24.width
    end
    local r101_27 = p101_1
    if not p101_1 then
        r101_27 = r101_24.height
    end
    local r101_28 = r101_20 + r101_20 * r101_26
    local r101_29 = r101_21 + r101_21 * r101_27
    local r101_30 = r101_28 * 0.800000011920929
    local r101_31 = r101_29 * 0.800000011920929
    g_killingVolumePhysics.left = r101_22 - r101_30 * 0.5
    g_killingVolumePhysics.right = r101_22 + r101_30 * 0.5
    g_killingVolumePhysics.top = r101_23 - r101_31 * 0.5
    g_killingVolumePhysics.bottom = r101_23 + r101_31 * 0.5
    createBox("killingBox", "", r101_22, r101_23, r101_30, r101_31, 0, 1, 1, true, false, 0)
    setObjectParameter("killingBox", 19, 1)
    setAsSensor("killingBox", true)
end

-- line 2345-2361
-- proto#102 params=1 locals=5 upvalues=0 vararg=false
function setupLevelTutorials(p102_0)
    setupDeviceTutorials(p102_0)
    local r102_0 = {}
    if objects.world ~= nil then
        for r102_1, r102_2 in _G.pairs(objects.world) do
            if objects.world[r102_2.name] ~= nil then
                local r102_3 = objects.world[r102_2.name]
                if r102_3.controllable then
                    local r102_4 = objects.world[r102_2.name]
                    if r102_0[r102_4.definition] ~= true then
                        setupTutorial(r102_2.name, p102_0)
                    end
                    local r102_5 = objects.world[r102_2.name]
                    r102_0[r102_5.definition] = true
                end
            end
        end
    end
end

-- line 2363-2387
-- proto#103 params=1 locals=10 upvalues=0 vararg=false
function setupBirdTutorials(p103_0)
    setupDeviceTutorials(p103_0)
    local r103_0 = {}
    for r103_1, r103_2 in _G.pairs(birds) do
        if not r103_2.shot then
            _G.table.insert(r103_0, r103_2)
        end
    end
    _G.table.sort(r103_0, function(p104_0, p104_1)
        local r104_0 = p104_0.startNumber
        local r104_1 = p104_1.startNumber
        return r104_0 < r104_1
    end)
    local r103_3 = {}
    for r103_4, r103_5 in _G.ipairs(r103_0) do
        if not r103_3[r103_5.definition] then
            setupTutorial(r103_5.name, p103_0)
            r103_3[r103_5.definition] = true
        end
    end
end

-- line 2389-2408
-- proto#105 params=1 locals=1 upvalues=0 vararg=false
function setupDeviceTutorials(p105_0)
    if p105_0 then
        local r105_0 = menuManager:getRoot():getChild("gameHud")
        if r105_0 ~= nil then
            r105_0:returnToGame()
        end
    end
    if not OSX.using_mouse and isInFullScreenMode() then
        setupTutorial("gesture_shoot", p105_0, true)
        setupTutorial("gesture_camera", p105_0, true)
        setupTutorial("gesture_menu", p105_0, true)
        setupTutorial("gesture_zoom", p105_0, true)
    end
    if deviceModel == "roku" then
        setupTutorial("roku_camera_pan", p105_0, true)
        setupTutorial("roku_camera_zoom", p105_0, true)
    end
end

-- line 2410-2428
-- proto#106 params=0 locals=4 upvalues=0 vararg=false
function connectPortals()
    if not newPortals then
        return
    end
    for r106_0 = 1, #newPortals do
        local r106_1 = newPortals[r106_0]
        if r106_1.link == nil then
            for r106_2 = 1, #newPortals do
                local r106_3 = r106_1.definition
                local r106_4 = newPortals[r106_2]
                local r106_5 = r106_4.definition
                if r106_3 == r106_5 and r106_1 ~= newPortals[r106_2] then
                    r106_1.link = newPortals[r106_2]
                end
            end
        end
    end
    newPortals = nil
end

-- line 2430-2442
-- proto#107 params=2 locals=10 upvalues=0 vararg=false
function startGame(p107_0, p107_1)
    setCurrentLevelPack(p107_0)
    setLevelName(levelOrder[p107_0][p107_1])
    if levelName ~= g_oldLevelName then
        numberOfAttemptsInLevel = 0
    end
    setLevelFolder(levelPath .. "/" .. p107_0 .. "/")
    print("LEVEL FOLDER " .. levelFolder .. " Name: " .. levelName .. [[
]])
    print(" changing scene to game with level: " .. levelFolder .. " / " .. levelName .. [[
]])
    local r107_0 = eventManager
    local r107_1 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
    r107_0:notify(r107_1)
end

-- line 2444-2452
-- proto#108 params=1 locals=3 upvalues=0 vararg=false
function getCompoundObjectDefinition(p108_0)
    for r108_0, r108_1 in _G.pairs(objects.compounds) do
        if r108_1.name == p108_0 then
            return r108_1
        end
    end
    return nil
end

-- line 2454-2514
-- proto#109 params=1 locals=24 upvalues=0 vararg=false
function createCompoundObjectTableFromSingles(p109_0)
    local r109_0 = {}
    if objects.counts.compound == nil then
        objects.counts.compound = 0
    end
    objects.counts.compound = objects.counts.compound + 1
    r109_0.name = "compound_" .. objects.counts.compound
    r109_0.breakable = true
    r109_0.strength = 10
    r109_0.type = "compound"
    r109_0.blocks = {}
    r109_0.material = "tempCompound"
    local r109_1, r109_2, r109_3, r109_4 = 10000, 10000, -10000, -10000
    local r109_5, r109_6 = nil, nil
    local r109_7 = #p109_0
    for r109_8 = 1, r109_7 do
        local r109_9 = p109_0[r109_8]
        local r109_10 = r109_9.x
        local r109_11 = p109_0[r109_8]
        local r109_12 = r109_11.y
        r109_1 = _G.math.min(r109_1, r109_10)
        r109_2 = _G.math.min(r109_2, r109_12)
        r109_3 = _G.math.max(r109_3, r109_10)
        r109_4 = _G.math.max(r109_4, r109_12)
    end
    local r109_13 = r109_1 + (r109_3 - r109_1) * 0.5
    local r109_14 = r109_2 + (r109_4 - r109_2) * 0.5
    r109_0.x = r109_13
    r109_0.y = r109_14
    r109_0.angle = 0
    for r109_15 = 1, r109_7 do
        local r109_16 = {
            definition = p109_0[r109_15].definition,
            x = p109_0[r109_15].x - r109_13,
            y = p109_0[r109_15].y - r109_14,
            angle = p109_0[r109_15].angle
        }
        _G.table.insert(r109_0.blocks, r109_16)
    end
    return r109_0
end

-- line 2517-2527
-- proto#110 params=5 locals=1 upvalues=0 vararg=false
function spawnNewObject(p110_0, p110_1, p110_2, p110_3, p110_4)
    local r110_0 = createObject(blockTable, p110_1, p110_0, p110_2 * scaleFactor, p110_3 * scaleFactor)
    setRotation(p110_0, p110_4)
    local r110_1 = blockTable.blocks[p110_1]
    local r110_2 = blockTable.materials[r110_1.material]
    setMaterial(p110_0, r110_1.material)
end

-- line 2529-2594
-- proto#111 params=3 locals=30 upvalues=0 vararg=false
function createCompoundObjectFromDefinition(p111_0, p111_1, p111_2)
    local r111_0 = {
        x = p111_2.x,
        y = p111_2.y,
        angle = p111_2.angle,
        type = "compound",
        name = p111_1.name,
        material = p111_0.materials.tempCompound,
        children = {}
    }
    local r111_1 = 0.9200000166893005
    for r111_2, r111_3 in _G.pairs(p111_1.blocks) do
        local r111_4 = {
            x = r111_3.x,
            y = r111_3.y,
            angle = r111_3.angle,
            definition = r111_3.definition,
            blockData = p111_0.blocks[r111_3.definition]
        }
        if r111_4.blockData.sprite ~= nil then
            local r111_5 = _G.res.getSpriteBounds
            local r111_6 = r111_4.blockData
            local r111_7, r111_8 = r111_5(r111_6.sprite)
            local r111_9, r111_10 = 0.9200000166893005, 1
            if r111_4.blockData.type == "box" and (r111_4.blockData.width == nil or r111_4.blockData.height == nil) then
                r111_4.blockData.width = r111_7 * physicsScale * r111_1
                r111_4.blockData.height = r111_8 * physicsScale * r111_1
            elseif r111_4.blockData.type == "circle" and r111_4.blockData.radius == nil then
                r111_4.blockData.radius = r111_7 * 0.5 * physicsScale * r111_1
            elseif r111_4.blockData.type == "polygon" then
                r111_4.worldVertices = {}
                local r111_11, r111_12 = r111_4.blockData.density, r111_9
                if r111_11 == 0 then
                    r111_12 = 1
                end
                local r111_13 = _G.res.getSpriteBounds
                local r111_14 = r111_4.blockData
                local r111_15, r111_16 = r111_13(r111_14.sprite)
                local r111_17, r111_18 = r111_16, r111_15
                local r111_19 = r111_4.blockData
                local r111_20
                local r111_21
                if r111_19.width == nil then
                    local r111_22 = r111_18 * physicsScale * r111_12 * r111_10
                    local r111_23 = r111_17 * physicsScale * r111_12 * r111_10
                    r111_20 = r111_22
                    r111_21 = r111_23
                elseif r111_4.blockData.height == nil then
                    local r111_24 = r111_18 * physicsScale * r111_12 * r111_10
                    local r111_25 = r111_17 * physicsScale * r111_12 * r111_10
                    r111_20 = r111_24
                    r111_21 = r111_25
                else
                    local r111_26 = r111_4.blockData.width
                    local r111_27 = r111_4.blockData.height
                    r111_20 = r111_26
                    r111_21 = r111_27
                end
                for r111_28, r111_29 in _G.pairs(r111_4.blockData.vertices) do
                    local r111_30 = {
                        x = r111_29.x * r111_20 - r111_20 * 0.5,
                        y = r111_29.y * r111_21 - r111_21 * 0.5
                    }
                    _G.table.insert(r111_4.worldVertices, r111_30)
                end
            end
        end
        _G.table.insert(r111_0.children, r111_4)
    end
    createCompoundBodyFromTable(r111_0)
end

-- line 2596-2766
-- proto#112 params=7 locals=76 upvalues=0 vararg=false
function createCompoundObject(p112_0, p112_1, p112_2, p112_3, p112_4, p112_5, p112_6)
    clearShapesArray()
    local r112_0 = {}
    if objects.counts.compound == nil then
        objects.counts.compound = 0
    end
    objects.counts.compound = objects.counts.compound + 1
    local r112_1 = "compound_" .. objects.counts.compound
    r112_0.name = r112_1
    r112_0.counts = {}
    local r112_2 = p112_0.materials[p112_2]
    local r112_3 = r112_2.density
    local r112_4 = r112_2.friction
    local r112_5 = r112_2.restitution
    local r112_6 = r112_2.controllable
    local r112_7 = r112_2.z_order
    local r112_8 = r112_2.collision
    local r112_9 = r112_2.strength
    local r112_10 = r112_2.defence
    local r112_11 = r112_2.damageFactors
    local r112_12 = 10000
    local r112_13 = 10000
    local r112_14 = -10000
    local r112_15 = -10000
    local r112_16, r112_17 = nil, nil
    local r112_18 = #p112_1
    if not (r112_18 > 0) then
        return
    end
    local r112_19
    local r112_20
    if r112_18 > 1 then
        local r112_21 = 1
        local r112_22 = 1
        local r112_23, r112_24, r112_25, r112_26 = r112_12, r112_13, r112_14, r112_15
        for r112_27 = r112_21, r112_18, r112_22 do
            local r112_28, r112_29 = p112_3[r112_27], p112_4[r112_27]
            r112_23 = _G.math.min(r112_23, r112_28)
            r112_24 = _G.math.min(r112_24, r112_29)
            r112_25 = _G.math.max(r112_25, r112_28)
            r112_26 = _G.math.max(r112_26, r112_29)
        end
        r112_19 = r112_23 + (r112_25 - r112_23) * 0.5
        r112_20 = r112_24 + (r112_26 - r112_24) * 0.5
    else
        r112_19 = p112_3[i]
        r112_20 = p112_4[i]
    end
    local r112_30 = 1
    local r112_31 = 1
    local r112_32, r112_33 = r112_7, r112_8
    for r112_34 = r112_30, r112_18, r112_31 do
        local r112_35 = ""
        local r112_36 = p112_3[r112_34]
        local r112_37 = r112_36 - r112_19
        local r112_38 = p112_4[r112_34]
        local r112_39 = r112_38 - r112_20
        local r112_40 = p112_5[r112_34]
        local r112_41 = p112_6[r112_34]
        local r112_42 = p112_0.blocks[p112_1[r112_34]]
        local r112_43 = 1
        local r112_44, r112_45 = nil, nil
        if r112_32 == nil then
            r112_32 = 0
        end
        local r112_46 = r112_42.sprite
        if r112_42.controllable and r112_42.sprites ~= nil then
            r112_46 = r112_42.sprites.default
        end
        local r112_47, r112_48 = 1, 1
        local r112_49 = 0.9200000166893005
        local r112_50
        if r112_46 == nil then
            if r112_42.damageSprites == nil then
                r112_50 = r112_46
            else
                local r112_51 = r112_42.damageSprites
                r112_50 = r112_51.damage1.sprite
            end
        else
            r112_50 = r112_46
        end
        if r112_42.type == "box" or r112_42.type == "polygon" or r112_42.type == "line" or r112_42.type == "circle" then
            local r112_52
            local r112_53
            if r112_50 == "" then
                r112_52 = r112_47
                r112_53 = r112_48
            elseif r112_50 == nil then
                r112_52 = r112_47
                r112_53 = r112_48
            else
                local r112_54, r112_55 = res.getSpriteBounds(r112_50)
                local r112_56 = r112_55
                local r112_57 = r112_54
                local r112_58, r112_59 = res.getSpritePivot(r112_50)
                r112_52 = r112_57
                r112_53 = r112_56
            end
            local r112_60, r112_61 = r112_42.density, r112_49
            if r112_60 == 0 then
                r112_61 = 1
            end
            local r112_62
            local r112_63
            if r112_42.width == nil then
                local r112_64 = r112_52 * physicsScale * r112_61 * r112_43
                local r112_65 = r112_53 * physicsScale * r112_61 * r112_43
                r112_62 = r112_64
                r112_63 = r112_65
            elseif r112_42.height == nil then
                local r112_66 = r112_52 * physicsScale * r112_61 * r112_43
                local r112_67 = r112_53 * physicsScale * r112_61 * r112_43
                r112_62 = r112_66
                r112_63 = r112_67
            else
                local r112_68 = r112_42.width
                local r112_69 = r112_42.height
                r112_62 = r112_68
                r112_63 = r112_69
            end
            local r112_70 = r112_33
            if r112_70 == nil then
                r112_33 = true
                r112_70 = r112_33
            end
            local r112_71 = r112_42.type
            r112_33 = r112_70
            if r112_71 == "box" then
                addBoxToCompoundList(r112_50, r112_37, r112_39, r112_40, r112_62, r112_63)
            elseif r112_42.type == "polygon" or r112_42.type == "line" then
                clearVertices()
                if r112_42.vertices ~= nil then
                    local r112_72 = 1
                    local r112_73 = r112_42.vertices
                    for r112_74 = r112_72, #r112_73 do
                        local r112_75 = r112_42.vertices[r112_74]
                        local r112_76 = r112_75.x * r112_62 - r112_62 * 0.5
                        addVertex(r112_76, r112_75.y * r112_63 - r112_63 * 0.5)
                    end
                end
                if r112_42.type == "polygon" then
                    addPolygonToCompoundList(r112_50, r112_37, r112_39, r112_40, r112_62, r112_63)
                elseif r112_42.type == "line" then
                    addLineToCompoundList(r112_50, r112_37, r112_39, r112_40, r112_62, r112_63)
                end
            elseif r112_42.type == "circle" then
                local r112_77 = r112_62 * 0.5 * physicsScale * r112_61 * r112_43
                if r112_42.radius ~= nil then
                    r112_77 = r112_42.radius
                end
                if r112_70 == nil then
                    r112_33 = true
                    r112_33 = r112_33
                else
                    r112_33 = r112_70
                end
                local r112_78 = r112_41
                if r112_78 == nil then
                    r112_78 = r112_77
                end
                addCircleToCompoundList(r112_50, r112_37, r112_39, r112_40, r112_78)
            end
            setCompoundShapeLinearDamping(r112_35, defaultPhysicsDrag)
            setCompoundShapeParameter(r112_35, 5, r112_43)
        end
        if r112_42.disableImmovableCollisions then
            setCompoundShapeParameter(r112_35, 15, 1)
        end
    end
    createCompoundObject(r112_1, r112_19, r112_20, 0, r112_3, r112_4, r112_5, r112_33, r112_6, r112_32)
    return r112_1
end

-- line 2769-3357
-- proto#113 params=11 locals=199 upvalues=0 vararg=false
function createObject(p113_0, p113_1, p113_2, p113_3, p113_4, p113_5, p113_6, p113_7, p113_8, p113_9, p113_10)
    local r113_0 = p113_0.blocks[p113_1]
    if r113_0 == nil then
        if p113_1 == nil then
            assert(false, "createObject: objectDefinition is nil")
        else
            assert(false, "createObject: no definition for " .. p113_1)
        end
        return
    end
    local r113_1 = p113_0.materials[r113_0.material]
    local r113_2 = r113_0.density
    local r113_3 = r113_0.friction
    local r113_4 = r113_0.restitution
    local r113_5 = r113_0.controllable
    local r113_6 = r113_0.strength
    local r113_7 = r113_0.defence
    local r113_8 = r113_0.damageFactors
    local r113_9, r113_10, r113_11, r113_12, r113_13, r113_14 = r113_0.levelGoal, r113_0.collision, r113_0.damageFactors, r113_0.useLegacyCollisionPath, r113_0.z_order, r113_0.scale
    if not r113_14 then
        r113_14 = 1
    end
    local r113_15 = r113_0.shotPattern
    local r113_16 = screenHeight
    local r113_17, r113_18 = p113_8, p113_9
    if r113_16 <= 240 and (p113_1 == "BLOCK_EULA_LINK_BUBBLE" or p113_1 == "BLOCK_PRIVACY_LINK_BUBBLE") then
        r113_18 = r113_14 * 1.7999999523162842
    end
    local r113_19 = r113_17 or r113_0.scaleX or r113_0.scale or 1
    local r113_20 = r113_18 or r113_0.scaleY or r113_0.scale or 1
    local r113_21, r113_22, r113_23, r113_24, r113_25 = r113_0.enableFlipping, r113_0.horFlip, r113_0.isSensor, r113_0.sensorType, r113_0.isWater
    local r113_26, r113_27 = nil, nil
    local r113_28 = r113_0.ignoreClassicGravity
    local r113_29, r113_30, r113_31, r113_32, r113_33, r113_34, r113_35, r113_36, r113_37, r113_38, r113_39, r113_40 = r113_2, r113_3, r113_4, r113_5, r113_6, r113_7, r113_10, r113_11, r113_13, r113_23, r113_24, r113_28
    if r113_1 ~= nil then
        if r113_29 == nil then
            r113_29 = r113_1.density
            p113_0.blocks[p113_1].density = r113_29
            r113_29 = r113_29
        else
            r113_29 = r113_29
        end
        if r113_30 == nil then
            r113_30 = r113_1.friction
            p113_0.blocks[p113_1].friction = r113_30
            local r113_41 = "object without friction " .. p113_1 .. ", material: " .. p113_0.blocks[p113_1].material
            _G.assert(r113_30 ~= nil, r113_41)
            if r113_30 == nil then
                r113_30 = 0
            end
        end
        if r113_31 == nil then
            r113_31 = r113_1.restitution
            p113_0.blocks[p113_1].restitution = r113_31
            r113_31 = r113_31
        else
            r113_31 = r113_31
        end
        if r113_32 == nil then
            r113_32 = r113_1.controllable
            p113_0.blocks[p113_1].controllable = r113_32
            r113_32 = r113_32
        else
            r113_32 = r113_32
        end
        if r113_33 == nil then
            r113_33 = r113_1.strength
            p113_0.blocks[p113_1].strength = r113_33
            r113_33 = r113_33
        else
            r113_33 = r113_33
        end
        if r113_34 == nil then
            r113_34 = r113_1.defence
            p113_0.blocks[p113_1].defence = r113_34
            r113_34 = r113_34
        else
            r113_34 = r113_34
        end
        if r113_36 == nil then
            r113_36 = r113_1.damageFactors
            p113_0.blocks[p113_1].damageFactors = r113_36
        end
        if r113_37 == nil then
            r113_37 = r113_1.z_order
            p113_0.blocks[p113_1].z_order = r113_37
            r113_37 = r113_37
        else
            r113_37 = r113_37
        end
        if r113_23 == nil then
            r113_38 = r113_1.isSensor
        else
            r113_38 = r113_23
        end
        if r113_24 == nil then
            r113_39 = r113_1.sensorType
        else
            r113_39 = r113_24
        end
        if r113_35 == nil then
            r113_35 = r113_1.collision
        else
            r113_35 = r113_35
        end
        if r113_28 == nil then
            r113_40 = r113_1.ignoreClassicGravity
        end
    end
    local r113_42
    if r113_37 == nil then
        local r113_43 = 0
        p113_0.blocks[p113_1].z_order = r113_43
        r113_42 = r113_43
    else
        r113_42 = r113_37
    end
    local r113_44
    if countsSaved == false or p113_2 == nil then
        if objects.counts[p113_1] == nil then
            objects.counts[p113_1] = 0
        end
        objects.counts[p113_1] = objects.counts[p113_1] + 1
        r113_44 = p113_1 .. "_" .. objects.counts[p113_1]
    else
        r113_44 = p113_2
    end
    local r113_45 = r113_0.sprite
    if applyLocalization and applyLocalization() and r113_0.localized then
        r113_45 = _G.res.getString("TEXTS_BASIC", r113_0.sprite)
    end
    local r113_46
    if r113_0.controllable then
        if r113_0.sprites == nil then
            r113_46 = r113_45
        else
            r113_46 = r113_0.sprites.default
        end
    else
        r113_46 = r113_45
    end
    local r113_47 = 0.9200000166893005
    local r113_48
    if r113_46 == nil then
        if r113_0.damageSprites == nil then
            r113_48 = r113_46
        else
            local r113_49 = r113_0.damageSprites
            r113_48 = r113_49.damage1.sprite
        end
    else
        r113_48 = r113_46
    end
    local r113_50 = r113_0.type
    local r113_51, r113_52, r113_53, r113_54 = r113_35, r113_26, r113_27, r113_47
    if r113_50 == "box" then
        local r113_55
        local r113_56
        local r113_57
        if r113_48 == "" then
            r113_52 = r113_52
            r113_55 = r113_55
            r113_56 = r113_56
            r113_57 = r113_57
        elseif r113_48 == nil then
            r113_52 = r113_52
            r113_55 = r113_55
            r113_56 = r113_56
            r113_57 = r113_57
        else
            local r113_58, r113_59 = res.getSpriteBounds(r113_48)
            r113_60 = r113_59
            r113_61 = r113_58
            r113_62, r113_63 = res.getSpritePivot(r113_48)
            r113_55 = r113_63
            r113_52 = r113_62
            r113_55 = r113_55
            r113_56 = r113_61
            r113_57 = r113_60
        end
        r113_55 = r113_55
        if r113_48 == "" then
            r113_56 = r113_56
        elseif r113_48 == nil then
            r113_56 = r113_56
        else
            local r113_61
            r113_56 = r113_61
        end
        if r113_48 == "" then
            r113_57 = r113_57
        elseif r113_48 == nil then
            r113_57 = r113_57
        else
            local r113_60
            r113_57 = r113_60
        end
        local r113_64
        if r113_0.density == 0 then
            r113_64 = 1
        else
            r113_64 = r113_64
        end
        if r113_0.width == nil then
            r113_56 = r113_56 * physicsScale * r113_64 * r113_19
            r113_57 = r113_57 * physicsScale * r113_64 * r113_20
            r113_56 = r113_56
            r113_57 = r113_57
        elseif r113_0.height == nil then
            r113_56 = r113_56 * physicsScale * r113_64 * r113_19
            r113_57 = r113_57 * physicsScale * r113_64 * r113_20
            r113_56 = r113_56
            r113_57 = r113_57
        else
            r113_56 = r113_0.width
            r113_57 = r113_0.height
            r113_56 = r113_56
            r113_57 = r113_57
        end
        if p113_6 == nil then
            r113_56 = r113_56
            r113_57 = r113_57
        elseif p113_7 == nil then
            r113_56 = r113_56
            r113_57 = r113_57
        else
            r113_56 = p113_6 * r113_64 * r113_14
            r113_57 = p113_7 * r113_64 * r113_14
            r113_56 = r113_56
            r113_57 = r113_57
        end
        r113_57 = r113_57
        local r113_65 = r113_35 == nil and true or r113_35
        createBox(r113_44, r113_48, p113_3, p113_4, r113_56, r113_57, r113_29, r113_30, r113_31, r113_65, r113_32, r113_42)
        if r113_32 then
            setLinearDamping(r113_44, 0)
        else
            setLinearDamping(r113_44, defaultPhysicsDrag)
        end
        setObjectParameter(r113_44, 5, r113_14)
        if r113_17 ~= nil then
            setObjectParameter(r113_44, 17, r113_19)
        end
        if r113_18 ~= nil then
            setObjectParameter(r113_44, 18, r113_20)
        end
        if r113_21 == true then
            setObjectParameter(r113_44, 9, 1)
        end
        if r113_22 == true then
            setObjectParameter(r113_44, 8, 1)
        end
    end
    local r113_66 = r113_0.type
    local r113_67, r113_68, r113_69, r113_70 = r113_51, r113_52, r113_53, r113_54
    r113_67, r113_68, r113_69, r113_70 = r113_51, r113_52, r113_53, r113_54
    if r113_66 == "polygon" or r113_0.type == "line" then
        local r113_71
        local r113_72
        local r113_73
        local r113_74, r113_75, r113_76, r113_77, r113_78
        if r113_48 == "" then
            r113_72 = r113_53
            r113_73 = r113_77
            r113_71 = r113_78
        elseif r113_48 == nil then
            r113_72 = r113_53
            r113_73 = r113_77
            r113_71 = r113_78
        else
            local r113_79, r113_80 = res.getSpriteBounds(r113_48)
            r113_74 = r113_80
            r113_75 = r113_79
            local r113_81, r113_82 = res.getSpritePivot(r113_48)
            r113_72 = r113_82
            r113_72 = r113_72
            r113_73 = r113_75
            r113_71 = r113_74
        end
        if r113_48 == "" then
            r113_72 = r113_53
        elseif r113_48 == nil then
            r113_72 = r113_53
        else
            r113_72 = r113_72
        end
        if r113_48 == "" then
            r113_73 = r113_77
        elseif r113_48 == nil then
            r113_73 = r113_77
        else
            r113_73 = r113_75
        end
        if r113_48 == "" then
            r113_71 = r113_78
        elseif r113_48 == nil then
            r113_71 = r113_78
        else
            r113_71 = r113_74
        end
        local r113_83 = r113_0.density == 0 and 1 or r113_54
        local r113_84
        if r113_0.width == nil then
            r113_73 = r113_73 * physicsScale * r113_83 * r113_19
            local r113_85 = r113_71 * physicsScale * r113_83 * r113_20
            r113_73 = r113_73
            r113_84 = r113_85
        elseif r113_0.height == nil then
            r113_73 = r113_73 * physicsScale * r113_83 * r113_19
            local r113_86 = r113_71 * physicsScale * r113_83 * r113_20
            r113_73 = r113_73
            r113_84 = r113_86
        else
            r113_73 = r113_0.width
            local r113_87 = r113_0.height
            r113_73 = r113_73
            r113_84 = r113_87
        end
        local r113_88 = r113_0.useOptionalDimensions
        local r113_89
        if r113_88 then
            if p113_6 == nil then
                r113_73 = r113_73
                r113_89 = r113_84
            elseif p113_7 == nil then
                r113_73 = r113_73
                r113_89 = r113_84
            else
                r113_73 = p113_6 * physicsScale * r113_14
                r113_76 = p113_7 * physicsScale * r113_14
                r113_73 = r113_73
                r113_89 = r113_76
            end
        else
            r113_73 = r113_73
            r113_89 = r113_84
        end
        if r113_88 then
            if p113_6 == nil then
                r113_89 = r113_84
            elseif p113_7 == nil then
                r113_89 = r113_84
            else
                r113_89 = r113_76
            end
        else
            r113_89 = r113_84
        end
        local r113_90 = r113_51 == nil and true or r113_51
        clearVertices()
        local r113_91 = p113_10 or r113_0.vertices
        if r113_91 ~= nil then
            for r113_92 = 1, #r113_91 do
                local r113_93 = r113_91[r113_92]
                local r113_94 = r113_93.x * r113_73 - r113_73 * 0.5
                addVertex(r113_94, r113_93.y * r113_89 - r113_89 * 0.5)
            end
        end
        if r113_0.type == "polygon" then
            createPolygon(r113_44, r113_48, p113_3, p113_4, r113_73, r113_89, r113_29, r113_30, r113_31, r113_90, r113_32, r113_42)
        elseif r113_0.type == "line" then
            createLineShape(r113_44, r113_48, p113_3, p113_4, r113_73, r113_89, r113_29, r113_30, r113_31, r113_90, r113_32, r113_42)
        end
        if r113_32 then
            setLinearDamping(r113_44, 0)
        else
            setLinearDamping(r113_44, defaultPhysicsDrag)
        end
        setObjectParameter(r113_44, 5, r113_14)
        if r113_17 ~= nil then
            setObjectParameter(r113_44, 17, r113_19)
        end
        if r113_18 ~= nil then
            setObjectParameter(r113_44, 18, r113_20)
        end
        if r113_21 == true then
            setObjectParameter(r113_44, 9, 1)
        end
        if r113_22 == true then
            setObjectParameter(r113_44, 8, 1)
        end
    end
    if r113_0.type == "circle" then
        local r113_95, r113_96 = res.getSpriteBounds(r113_48)
        local r113_97 = r113_95
        local r113_98, r113_99 = res.getSpritePivot(r113_48)
        r113_100 = r113_99
        r113_101 = r113_98
        r113_102 = r113_97 * 0.5 * physicsScale * r113_70 * r113_19
        if r113_0.radius == nil then
            r113_0.radius = r113_102
        else
            r113_102 = r113_0.radius
        end
        local r113_103 = r113_67 == nil and true or r113_67
        if p113_5 == nil then
            r113_102 = r113_104
        else
            r113_102 = p113_5
        end
        createCircle(r113_44, r113_48, p113_3, p113_4, r113_102, r113_29, r113_30, r113_31, r113_103, r113_32, r113_42)
        if r113_32 then
            setLinearDamping(r113_44, 0)
        else
            setLinearDamping(r113_44, defaultPhysicsDrag)
        end
        setObjectParameter(r113_44, 5, r113_14)
        if r113_17 ~= nil then
            setObjectParameter(r113_44, 17, r113_19)
        end
        if r113_18 ~= nil then
            setObjectParameter(r113_44, 18, r113_20)
        end
        if r113_21 == true then
            setObjectParameter(r113_44, 9, 1)
        end
        if r113_22 == true then
            setObjectParameter(r113_44, 8, 1)
        end
        if r113_32 then
            objects.world[r113_44].useLegacyCollisionPath = r113_12
        end
    end
    local r113_101, r113_100
    if r113_38 then
        setAsSensor(r113_44, true)
        objects.world[r113_44].sensorType = r113_39
        objects.world[r113_44].isSensor = r113_38
        objects.world[r113_44].isWater = r113_25
        if r113_25 then
            objects.world[r113_44].waterDensityZeroLevel = r113_0.waterDensityZeroLevel
        end
        objects.world[r113_44].isEmittedParticle = r113_0.isEmittedParticle
        objects.world[r113_44].isSword = r113_0.isSword
        local r113_102
        local r113_105 = objects.world[r113_44]
        if r113_105.sensorType == "gravitation" then
            objects.world[r113_44].gravitationMinForce = r113_0.gravitationMinForce
            objects.world[r113_44].gravitationMaxForce = r113_0.gravitationMaxForce
        end
        if r113_0.type == "box" then
            local r113_106 = objects.world[r113_44]
            if r113_106.isEmittedParticle or objects.world[r113_44].isSword then
                objects.world[r113_44].height = r113_0.height or 1
                objects.world[r113_44].width = r113_0.width or 1
            else
                objects.world[r113_44].height = r113_0.height
                objects.world[r113_44].width = r113_0.width
                objects.world[r113_44].forceAngle = r113_0.forceAngle or 0
                local r113_107 = print
                local r113_108 = "CREATING BOX GRAVITY: " .. objects.world[r113_44].width .. ", " .. objects.world[r113_44].height .. [[
]]
                r113_107(r113_108)
            end
        else
            objects.world[r113_44].radius = r113_102
        end
        objects.world[r113_44].ignoreBirds = r113_0.ignoreBirds
        if objects.sensorList[r113_39] ~= nil then
            objects.sensorList[r113_39][r113_44] = objects.world[r113_44]
        end
        if r113_0.canBeEdited and objects.world[r113_44].sensorType == "stream" then
            objects.world[r113_44].nodes = r113_0.nodes
            objects.world[r113_44].radius = r113_0.radius
            objects.world[r113_44].force = r113_0.force
            objects.world[r113_44].vertices = r113_0.vertices
            print("LOADING STREAM NODES:")
            for r113_109, r113_110 in _G.pairs(objects.world[r113_44].nodes) do
                print("x: " .. r113_110.x .. " Y: " .. r113_110.y)
            end
        end
        setObjectParameter(r113_44, 20, 1)
        if r113_39 == "gravitation" then
            setObjectParameter(r113_44, 21, 2)
            setObjectParameter(r113_44, 25, r113_0.gravitationMinForce)
            setObjectParameter(r113_44, 26, r113_0.gravitationMaxForce)
        elseif r113_39 == "stream" then
            setObjectParameter(r113_44, 21, 3)
        end
        if not (r113_0.gravityCollisionMask == nil or g_gravityFiltersMasks[r113_0.gravityCollisionMask] == nil) then
            setSensorGravityMask(r113_44, g_gravityFiltersMasks[r113_0.gravityCollisionMask])
        end
        if r113_0.active == true then
            objects.world[r113_44].active = true
            setObjectParameter(r113_44, 22, 1)
        elseif r113_0.active == false then
            objects.world[r113_44].active = false
            setObjectParameter(r113_44, 22, 0)
        end
        if r113_0.type == "box" then
            setObjectParameter(r113_44, 24, 1)
            setObjectParameter(r113_44, 28, r113_0.width or 1)
            if r113_0.forceAngle ~= nil then
                setObjectParameter(r113_44, 29, r113_0.forceAngle)
            end
        elseif r113_0.type ~= "polygon" then
            setObjectParameter(r113_44, 24, 0)
            setObjectParameter(r113_44, 27, r113_102)
        end
    end
    objects.world[r113_44].resistsExplosion = r113_0.resistsExplosion
    objects.world[r113_44].onTriggerExit = r113_0.onTriggerExit
    objects.world[r113_44].onTriggerEnter = r113_0.onTriggerEnter
    objects.world[r113_44].onJointRemoved = r113_0.onJointRemoved
    objects.world[r113_44].onCollisionEnter = r113_0.onCollisionEnter
    objects.world[r113_44].onDestroyed = r113_0.onDestroyed
    objects.world[r113_44].onCreated = r113_0.onCreated
    objects.world[r113_44].onCollisionExit = r113_0.onCollisionExit
    objects.world[r113_44].onReceivedExplosionDamage = r113_0.onReceivedExplosionDamage
    objects.world[r113_44].onReceivedExplosionForce = r113_0.onReceivedExplosionForce
    objects.world[r113_44].onReceivedFreezeForce = r113_0.onReceivedFreezeForce
    objects.world[r113_44].onDamageStateChanged = r113_0.onDamageStateChanged
    local r113_111 = objects.world[r113_44]
    if r113_111.onCreated ~= nil then
        if r113_0.episodeType then
            fireAction(objects.world[r113_44].onCreated, { name = r113_44 })
        else
            local r113_112 = _G.type
            local r113_113 = objects.world[r113_44]
            if r113_112(r113_113.onCreated) == "table" then
                for r113_114, r113_115 in _G.ipairs(objects.world[r113_44].onCreated) do
                    addEventCall(r113_115, { name = r113_44 })
                end
            else
                addEventCall(objects.world[r113_44].onCreated, { name = r113_44 })
            end
        end
    end
    objects.world[r113_44].shotPattern = r113_15
    objects.world[r113_44].startingX = objects.world[r113_44].x
    objects.world[r113_44].startingY = objects.world[r113_44].y
    objects.world[r113_44].startingAngle = objects.world[r113_44].angle
    local r113_116 = objects.world[r113_44]
    r113_116.timeCreated = getCurrentTime()
    if not (r113_0.gravityFilterCategory == nil or g_gravityFiltersCategories[r113_0.gravityFilterCategory] == nil or r113_44 == "BirdSimulation") then
        objects.world[r113_44].gravityFilterCategory = r113_0.gravityFilterCategory
        setObjectGravityCategory(r113_44, g_gravityFiltersCategories[r113_0.gravityFilterCategory])
    end
    if r113_40 ~= nil then
        if r113_40 then
            setObjectParameter(r113_44, 16, 1)
        else
            setObjectParameter(r113_44, 16, 0)
        end
    end
    if r113_0.collisionGroupName ~= nil and collisionGroupNameToNumber then
        setObjectParameter(r113_44, 36, collisionGroupNameToNumber(r113_0.collisionGroupName))
    end
    if r113_0.collisionGroupIndex then
        setObjectParameter(r113_44, 36, r113_0.collisionGroupIndex)
    end
    if r113_0.collideOnlyWithMaterials then
        objects.world[r113_44].collisionMaterials = r113_0.collideOnlyWithMaterials
        native_setBlockCollisionEnabled(r113_44, false)
    end
    if r113_0.canBeEdited then
        if r113_0.explosionRadius ~= nil then
            objects.world[r113_44].explosionRadius = r113_0.explosionRadius
        end
        if r113_0.explosionForce ~= nil then
            objects.world[r113_44].explosionForce = r113_0.explosionForce
        end
        if r113_0.explosionDamageRadius ~= nil then
            objects.world[r113_44].explosionDamageRadius = r113_0.explosionDamageRadius
        end
        if r113_0.explosionDamage ~= nil then
            objects.world[r113_44].explosionDamage = r113_0.explosionDamage
        end
        if r113_0.startingForce ~= nil then
            objects.world[r113_44].startingForce = r113_0.startingForce
        end
        if r113_0.forceAngle ~= nil then
            objects.world[r113_44].forceAngle = r113_0.forceAngle
        end
        objects.world[r113_44].canBeEdited = true
    end
    if r113_0.disableImmovableCollisions then
        objects.world[r113_44].disableImmovableCollisions = true
        setObjectParameter(r113_44, 15, 1)
    end
    objects.world[r113_44].damageFactors = r113_36
    objects.world[r113_44].definition = p113_1
    objects.world[r113_44].damageSprite = r113_48
    objects.world[r113_44].controllable = r113_32
    objects.world[r113_44].strength = r113_33
    objects.world[r113_44].defence = r113_34
    objects.world[r113_44].material = r113_0.material
    objects.world[r113_44].themed = r113_0.themed
    objects.world[r113_44].levelGoal = r113_9
    objects.world[r113_44].spritePivotX = r113_101
    objects.world[r113_44].spritePivotY = r113_100
    native_setWaterDensity(r113_44, getWaterDensity(objects.world[r113_44]))
    if r113_0.editableAttributes then
        for r113_117, r113_118 in _G.ipairs(r113_0.editableAttributes) do
            if r113_0[r113_118] ~= nil then
                objects.world[r113_44][r113_118] = r113_0[r113_118]
            end
        end
        objects.world[r113_44].editableAttributes = r113_0.editableAttributes
    end
    if r113_0.animations ~= nil then
        initObjectAnimation(objects.world[r113_44], r113_0)
    end
    if r113_39 and r113_39 == "portal" then
        if newPortals == nil then
            newPortals = {}
        end
        newPortals[#newPortals + 1] = objects.world[r113_44]
    end
    if r113_0.emitParticles then
        objects.world[r113_44].emitParticles = true
    end
    local r113_119 = objects.world[r113_44]
    if r113_119.isSensor and objects.world[r113_44].sensorType == "killing" and p113_7 ~= nil and p113_6 ~= nil then
        print("CREATING KILLING SENSOR: " .. p113_7 .. ", " .. p113_6)
        objects.world[r113_44].height = p113_7
        objects.world[r113_44].width = p113_6
    end
    if r113_0.ignoresScore then
        native_setIgnoresScore(r113_44, true)
    end
    return r113_44
end

-- line 3361-3393
-- proto#114 params=3 locals=18 upvalues=0 vararg=false
function setObjectAnimation(p114_0, p114_1, p114_2)
    if p114_0.currentAnimation == p114_2 then
        return p114_1.animations[p114_0.currentAnimation].sprites[p114_0.currentSubAnimation][p114_0.animFrame]
    end
    local r114_0 = p114_1.animations[p114_2]
    if r114_0.frameTime == nil then
        return ""
    end
    p114_0.currentAnimation = p114_2
    p114_0.currentSubAnimation = 1
    if r114_0.idleTime ~= nil then
        local r114_1 = _G.math.random(r114_0.idleTime[1] * 100, r114_0.idleTime[2] * 100)
        p114_0.idleTimer = r114_1 / 100
    end
    p114_0.animFrame = _G.math.random(1, #r114_0.sprites[p114_0.currentSubAnimation])
    local r114_2 = r114_0.sprites[p114_0.currentSubAnimation]
    local r114_3 = r114_2[p114_0.animFrame]
    setSprite(p114_0.name, r114_3)
    local r114_4 = _G.math.random(r114_0.frameTime[1] * 100, r114_0.frameTime[2] * 100)
    p114_0.animFrameTime = r114_4 / 100
    p114_0.disableRotation = r114_0.disableRotation
    if p114_0.disableRotation == true then
        setObjectParameter(p114_0.name, 10, 1)
    else
        setObjectParameter(p114_0.name, 10, 0)
    end
    createAnimationParticles(p114_0, p114_1, p114_2)
    return r114_3
end

-- line 3395-3405
-- proto#115 params=3 locals=2 upvalues=0 vararg=false
function createAnimationParticles(p115_0, p115_1, p115_2)
    local r115_0 = p115_1.animations[p115_2]
    if r115_0.particles == nil then
        return
    end
    local r115_1 = p115_1.animations[p115_2]
    local r115_2 = r115_1.particles
    if r115_2 then
        fireAction("spawnParticles", { name = p115_0.name, particles = r115_2 })
    end
end

-- line 3411-3456
-- proto#116 params=2 locals=25 upvalues=0 vararg=false
function initObjectAnimation(p116_0, p116_1)
    local r116_0 = 1
    local r116_1, r116_2, r116_3 = nil, nil, nil
    local r116_4 = p116_1.animations
    local r116_5 = r116_1
    local r116_6 = r116_2
    local r116_7 = r116_3
    for r116_8 = 1, #r116_4 do
        local r116_9 = r116_4[r116_8]
        if r116_9.defaultAnim == true then
            r116_0 = r116_8
        end
        local r116_10 = r116_4[r116_8]
        if r116_10.deathAnim == true then
            r116_5 = r116_8
        end
        local r116_11 = r116_4[r116_8]
        if r116_11.laughAnim == true then
            r116_6 = r116_8
        end
        local r116_12 = r116_4[r116_8]
        if r116_12.laughJointedAnim == true then
            r116_7 = r116_8
        end
    end
    p116_0.defaultAnim = r116_0
    p116_0.deathAnim = r116_5
    p116_0.laughAnim = r116_6
    p116_0.laughJointedAnim = r116_7
    local r116_13 = r116_4[r116_0]
    if r116_13.frameTime ~= nil then
        p116_0.currentAnimation = r116_0
        p116_0.currentSubAnimation = 1
        local r116_14 = r116_4[r116_0]
        if r116_14.idleTime ~= nil then
            local r116_15 = _G.math.random(r116_4[r116_0].idleTime[1] * 100, r116_4[r116_0].idleTime[2] * 100)
            p116_0.idleTimer = r116_15 / 100
        end
        p116_0.animFrame = _G.math.random(1, #r116_4[r116_0].sprites[p116_0.currentSubAnimation])
        local r116_16 = _G.math.random(r116_4[r116_0].frameTime[1] * 100, r116_4[r116_0].frameTime[2] * 100)
        p116_0.animFrameTime = r116_16 / 100
        local r116_17 = r116_4[r116_0]
        p116_0.disableRotation = r116_17.disableRotation
        if p116_0.disableRotation == true then
            setObjectParameter(p116_0.name, 10, 1)
        else
            setObjectParameter(p116_0.name, 10, 0)
        end
    end
end

-- line 3461-3468
-- proto#117 params=0 locals=0 upvalues=0 vararg=false
function checkDirectories()
    if not checkDirectory(levelFolder) then
        createDirectory(levelFolder)
    end
    if not checkDirectory(levelFolder .. "temp/") then
        createDirectory(levelFolder .. "temp/")
    end
end

-- line 3471-3511
-- proto#118 params=1 locals=17 upvalues=0 vararg=false
function getObjectListBounds(p118_0)
    local r118_0, r118_1, r118_2, r118_3 = 1000000, -1000000, 1000000, -1000000
    for r118_4, r118_5 in _G.pairs(p118_0) do
        local r118_6 = r118_5.width
        local r118_7 = r118_5.height
        local r118_8
        local r118_9
        if r118_6 == nil then
            r118_8 = r118_5.radius
            r118_9 = r118_5.radius
        else
            r118_8 = r118_6 * 0.5
            r118_9 = r118_7 * 0.5
        end
        if r118_5.x - r118_8 < r118_0 then
            local r118_10 = r118_5.x
            r118_0 = r118_10 - r118_8
        end
        if r118_5.x + r118_8 > r118_1 then
            local r118_11 = r118_5.x
            r118_1 = r118_11 + r118_8
        end
        if r118_5.y - r118_9 < r118_2 then
            local r118_12 = r118_5.y
            r118_2 = r118_12 - r118_9
        end
        if r118_5.y + r118_9 > r118_3 then
            local r118_13 = r118_5.y
            r118_3 = r118_13 + r118_9
        end
    end
    return (r118_1 + r118_0) * 0.5, (r118_3 + r118_2) * 0.5, r118_1 - r118_0, r118_3 - r118_2
end

-- line 3514-3569
-- proto#119 params=1 locals=56 upvalues=0 vararg=false
function getSelectedObjects(p119_0)
    local r119_0, r119_1, r119_2, r119_3 = 1000000, -1000000, 1000000, -1000000
    for r119_4, r119_5 in _G.pairs(p119_0) do
        local r119_6, r119_7, r119_8 = r119_5.width, r119_5.height, r119_5.angle
        if r119_6 == nil then
            local r119_9 = r119_5.radius
            local r119_10 = r119_5.radius
            r119_0 = _G.math.min(r119_0, r119_5.x - r119_5.radius)
            r119_1 = _G.math.max(r119_1, r119_5.x + r119_5.radius)
            r119_2 = _G.math.min(r119_2, r119_5.y - r119_5.radius)
            r119_3 = _G.math.max(r119_3, r119_5.y + r119_5.radius)
        else
            local r119_11 = {}
            local r119_12 = transformCoordinates(r119_8, -(r119_6 * 0.5), r119_7 * 0.5)
            local r119_13 = transformCoordinates(r119_8, r119_6 * 0.5, r119_7 * 0.5)
            local r119_14 = transformCoordinates(r119_8, -(r119_6 * 0.5), -(r119_7 * 0.5))
            local r119_15 = transformCoordinates(r119_8, r119_6 * 0.5, -(r119_7 * 0.5))
            _G.table.insert(r119_11, r119_12)
            _G.table.insert(r119_11, r119_13)
            _G.table.insert(r119_11, r119_14)
            _G.table.insert(r119_11, r119_15)
            for r119_16, r119_17 in _G.pairs(r119_11) do
                r119_0 = _G.math.min(r119_0, r119_5.x + r119_17.x)
                r119_1 = _G.math.max(r119_1, r119_5.x + r119_17.x)
                r119_2 = _G.math.min(r119_2, r119_5.y + r119_17.y)
                r119_3 = _G.math.max(r119_3, r119_5.y + r119_17.y)
            end
        end
    end
    local r119_18 = r119_1 - r119_0
    local r119_19 = r119_3 - r119_2
    return r119_0 + r119_18 * 0.5, r119_2 + r119_19 * 0.5, r119_18, r119_19
end

-- line 3572-3592
-- proto#120 params=2 locals=7 upvalues=0 vararg=false
function addObjectToSelection(p120_0, p120_1)
    local r120_0 = blockTable.blocks[p120_0.definition]
    if r120_0 and r120_0.noSelectInEditor then
        print("noSelectInEditor set for " .. p120_0.definition)
        return
    end
    local r120_1 = false
    for r120_2 = 1, #selectedObjects do
        if selectedObjects[r120_2] == p120_0 then
            if p120_1 then
                _G.table.remove(selectedObjects, r120_2)
            end
            r120_1 = true
            local r120_3 = #selectedObjects
        end
    end
    if not r120_1 then
        _G.table.insert(selectedObjects, p120_0)
    end
end

-- line 3601-3624
-- proto#121 params=1 locals=11 upvalues=0 vararg=false
function updateFloatingScores(p121_0)
    local r121_0 = 1
    while #floatingScores >= r121_0 do
        local r121_1 = floatingScores[r121_0]
        local r121_2 = r121_1.time
        r121_1.time = r121_2 + p121_0
        if r121_1.time < 0.25 then
            r121_1.xs = r121_1.maxScale * r121_1.time / 0.25
        elseif r121_1.lifetime - 0.25 > r121_1.time then
            r121_1.xs = r121_1.maxScale
        else
            r121_1.xs = r121_1.maxScale * (r121_1.lifetime - r121_1.time) / 0.25
        end
        local r121_3 = floatingScores[r121_0]
        local r121_4 = r121_3.time
        local r121_5 = floatingScores[r121_0]
        if r121_5.lifetime < r121_4 then
            _G.table.remove(floatingScores, r121_0)
        else
            r121_0 = r121_0 + 1
        end
    end
end

-- line 3626-3639
-- proto#122 params=1 locals=7 upvalues=0 vararg=false
function updateScore(p122_0)
    score = 0
    local r122_0 = false
    for r122_1, r122_2 in _G.pairs(scoreTable) do
        score = score + r122_2.score
        r122_0 = true
    end
    if g_threeStarsCheat == true and starTable[levelName] ~= nil and starTable[levelName].goldScore ~= nil then
        local r122_3 = starTable[levelName]
        score = r122_3.goldScore
    end
end

-- line 3642-3648
-- proto#123 params=4 locals=0 upvalues=0 vararg=false
function tweenLinear(p123_0, p123_1, p123_2, p123_3)
    return p123_2 * p123_0 / p123_3 + p123_1
end

-- line 3650-3657
-- proto#124 params=4 locals=5 upvalues=0 vararg=false
function tweenEaseCubicIn(p124_0, p124_1, p124_2, p124_3)
    local r124_0 = p124_0 / p124_3
    return p124_2 * r124_0 * r124_0 * r124_0 + p124_1
end

-- line 3659-3666
-- proto#125 params=4 locals=5 upvalues=0 vararg=false
function tweenEaseCubicOut(p125_0, p125_1, p125_2, p125_3)
    local r125_0 = p125_0 / p125_3 - 1
    return p125_2 * (r125_0 * r125_0 * r125_0 + 1) + p125_1
end

-- line 3668-3682
-- proto#126 params=4 locals=6 upvalues=0 vararg=false
function tweenEaseCubicInOut(p126_0, p126_1, p126_2, p126_3)
    local r126_0 = p126_0 / (p126_3 / 2)
    if r126_0 < 1 then
        return p126_2 / 2 * (r126_0 * r126_0 * r126_0) + p126_1
    end
    local r126_1 = r126_0 - 2
    return p126_2 / 2 * (r126_1 * r126_1 * r126_1 + 2) + p126_1
end

-- line 3684-3704
-- proto#127 params=4 locals=8 upvalues=0 vararg=false
function tweenEaseBounceOut(p127_0, p127_1, p127_2, p127_3)
    local r127_0 = p127_0 / p127_3
    if r127_0 < 0.3636363744735718 then
        return p127_2 * 7.5625 * r127_0 * r127_0 + p127_1
    end
    if r127_0 < 0.7272727489471436 then
        local r127_1 = r127_0 - 0.5454545617103577
        return p127_2 * (7.5625 * r127_1 * r127_1 + 0.75) + p127_1
    end
    if r127_0 < 0.9090909361839294 then
        local r127_2 = r127_0 - 0.8181818127632141
        return p127_2 * (7.5625 * r127_2 * r127_2 + 0.9375) + p127_1
    end
    local r127_3 = r127_0 - 0.9545454382896423
    return p127_2 * (7.5625 * r127_3 * r127_3 + 0.984375) + p127_1
end

-- line 3706-3710
-- proto#128 params=2 locals=3 upvalues=0 vararg=false
function roundNumber(p128_0, p128_1)
    local r128_0 = 10 ^ p128_1
    return _G.math.floor(p128_0 * r128_0 + 0.5) / r128_0
end

-- line 3714-3722
-- proto#129 params=2 locals=3 upvalues=0 vararg=false
function isKeyInList(p129_0, p129_1)
    for r129_0, r129_1 in _G.pairs(p129_1) do
        if r129_0 == p129_0 then
            return true
        end
    end
    return false
end

-- line 3724-3736
-- proto#130 params=0 locals=0 upvalues=0 vararg=false
function savePurchases()
    if not isPCVersion() then
        saveLuaFileWrapper("gamepurchases.lua", "g_gamePurchasesTable", true)
        saveLuaFileWrapper("eaglepurchases.lua", "g_eaglePurchasesTable", true)
    end
    if g_saveGamePurchasesOnPC and isPCVersion() then
        saveLuaFileWrapper("gamepurchases.lua", "g_gamePurchasesTable", true)
    end
    saveLuaFileWrapper("episodepurchases.lua", "g_episodePurchasesTable", true)
end

-- line 3738-3744
-- proto#131 params=3 locals=2 upvalues=0 vararg=false
function startMEPurchaseFlow(p131_0, p131_1, p131_2)
    eventManager:notify({ id = events.EID_POP_FRAME })
    local r131_0 = eventManager
    local r131_1 = { id = events.EID_PUSH_FRAME, target = EaglePurchasePage:new() }
    r131_0:notify(r131_1)
    g_disableGameupdate = true
    purchaseMightyEagle(p131_0, p131_1, p131_2)
end

-- line 3746-3750
-- proto#132 params=3 locals=2 upvalues=0 vararg=false
function startEpisodePurchaseFlow(p132_0, p132_1, p132_2)
    eventManager:notify({ id = events.EID_POP_FRAME })
    local r132_0 = eventManager
    local r132_1 = { id = events.EID_PUSH_FRAME, target = EaglePurchasePage:new() }
    r132_0:notify(r132_1)
    purchaseEpisode(p132_0, p132_1, p132_2)
end

-- line 3752-3756
-- proto#133 params=1 locals=2 upvalues=0 vararg=false
function startFullVersionPurchaseFlow(p133_0)
    eventManager:notify({ id = events.EID_POP_FRAME })
    local r133_0 = eventManager
    local r133_1 = { id = events.EID_PUSH_FRAME, target = EaglePurchasePage:new() }
    r133_0:notify(r133_1)
    purchaseFullVersion(p133_0)
end

-- line 3758-3761
-- proto#134 params=0 locals=2 upvalues=0 vararg=false
function startRemoveAdsPurchaseFlow()
    local r134_0 = eventManager
    local r134_1 = { id = events.EID_PUSH_FRAME, target = EaglePurchasePage:new() }
    r134_0:notify(r134_1)
    purchaseAdRemoval()
end

-- line 3763-3769
-- proto#135 params=1 locals=1 upvalues=0 vararg=false
function toggleCurrentMusic(p135_0)
    if p135_0 then
        playAudio(previousMusicName)
    else
        _G.res.stopAudio(previousMusicName)
    end
end

-- line 3771-3794
-- proto#136 params=0 locals=7 upvalues=0 vararg=false
function handleLevelMusic()
    local r136_0 = blockTable.themes[objects.theme]
    musicToPlayNow = r136_0.music
    local r136_1 = blockTable.themes[objects.theme]
    local r136_2 = r136_1.musicVolume or 1
    local r136_3 = getLevelMetadata(levelName)
    local r136_4 = r136_3.musicName
    if r136_4 then
        musicToPlayNow = r136_4
    end
    local r136_5 = getLevelMetadata(levelName)
    if r136_5.playMainMusic then
        musicToPlayNow = getTitleTheme()
    end
    if previousMusicName and previousMusicName ~= musicToPlayNow then
        _G.res.stopAudio(previousMusicName)
        previousMusicName = nil
    end
    if musicToPlayNow and not res.isAudioPlaying(musicToPlayNow) then
        playAudio(musicToPlayNow, r136_2)
        previousMusicName = musicToPlayNow
    end
end

g_singleStep = false
local r0_2 = gameWorldScale
local r0_3 = 2.5 * r0_2
local r0_4 = useAccelerometerControls and 2.5 * r0_2 / 5.400000095367432 or 0.25

-- line 3808-3818
-- proto#137 params=2 locals=2 upvalues=2 vararg=false
function limitDragVector(p137_0, p137_1)
    local r137_0 = vLength(p137_0, p137_1)
    local r137_1 = r0_3 / r0_4
    local r137_2 = 1
    if r0_3 / r0_4 < r137_0 then
        r137_2 = r0_3 / r0_4 / r137_0
    end
    return p137_0 * r137_2, p137_1 * r137_2
end

-- line 3825-3841
-- proto#138 params=3 locals=14 upvalues=1 vararg=false
function calculateImpulseVectorForBird(p138_0, p138_1, p138_2)
    local r138_0, r138_1 = limitDragVector(p138_0, p138_1)
    local r138_2 = vLength(r138_0, r138_1) * r0_4
    local r138_3 = p138_2.powerModifier
    local r138_4 = r138_2 * (r138_3 or 1)
    local r138_5 = defaultForce * physicsScale * p138_2.mass * 1.25
    local r138_6
    if p138_2.flocker then
        if p138_2.speedReductionPercentage then
            local r138_7 = p138_2.speedReductionPercentage
            r138_6 = r138_4 * r138_7
        else
            r138_6 = r138_4
        end
    else
        r138_6 = r138_4
    end
    local r138_8 = p138_2.flocker and powerups.getLaunchVectorForFlockers(p138_2) or normalizeVector(r138_0, r138_1)
    local r138_9 = r138_6 * r138_5
    local r138_10 = r138_8.x * r138_9
    local r138_11 = r138_8.y
    r138_8.y = r138_11 * r138_9
    r138_8.x = r138_10
    return r138_8
end

-- line 3843-3901
-- proto#139 params=1 locals=15 upvalues=0 vararg=false
function simulateTrajectory(p139_0)
    local r139_0 = g_aimingAidCursor.cursorToUse
    local r139_1 = distance(levelStartPosition.x, levelStartPosition.y, r139_0.x, r139_0.y)
    local r139_2 = 1 * slingshotScale
    if r139_1 < r139_2 or g_birdDragOnTouchAttributes.shootMinLength > r139_1 then
        ClearSimulationTrajectory()
        clearAimingAid(1)
        g_aimingAidAttributes.visible = false
        return
    end
    if g_aimingAidAttributes.visible == false then
        populateAimingAid()
    end
    g_aimingAidAttributes.visible = true
    setSelectedBirdDuringSimulation(selectedBird.name)
    local r139_3 = "BirdSimulation"
    if objects.world[r139_3] == nil then
        local r139_4 = createObject(blockTable, selectedBird.definition, r139_3, selectedBird.x, selectedBird.y)
        setObjectGravityCategory(r139_3, g_gravityFiltersCategories.AIMING_AID)
    end
    local r139_5, r139_6 = objects.world[r139_3], birds[currentBirdName]
    if r139_5 and r139_6 then
        copyBirdValuesFromLiveBird(r139_5, r139_6)
    end
    local r139_7 = calculateImpulseVectorForBird(g_aimingAidCursor.cursorToUse.x - levelStartPosition.x, g_aimingAidCursor.cursorToUse.y - levelStartPosition.y, r139_5)
    setActive(r139_3, true)
    setPosition(r139_3, selectedBird.x, selectedBird.y)
    setVelocity(r139_3, 0, 0)
    applyImpulse(r139_3, r139_7.x, r139_7.y, g_aimingAidCursor.cursorToUse.x, g_aimingAidCursor.cursorToUse.y)
    setAngularVelocity(r139_3, 0)
    native_setWaterDensity(r139_3, getWaterDensity(selectedBird))
    ClearSimulationTrajectory()
    updateBirdTrajectoryTable()
    removeObject(r139_3)
    objects.world[r139_3] = nil
    birds[r139_3] = nil
    otherBirds[r139_3] = nil
    animatedObjects[r139_3] = nil
end

-- line 3904-3908
-- proto#140 params=2 locals=0 upvalues=0 vararg=false
function copyBirdValuesFromLiveBird(p140_0, p140_1)
    if p140_1.powerModifier then
        p140_0.powerModifier = p140_1.powerModifier
    end
end

-- line 3910-3920
-- proto#141 params=1 locals=9 upvalues=0 vararg=false
function getWaterDensity(p141_0)
    local r141_0 = blockTable.blocks[p141_0.definition]
    local r141_1 = r141_0.densityInWater
    local r141_2
    if r141_1 then
        r141_2 = r141_1
    else
        local r141_3 = blockTable.materials[r141_0.material]
        local r141_4 = r141_3.densityInWater
        if r141_4 then
            r141_2 = r141_4
        else
            r141_2 = r141_0.density
        end
    end
    local r141_5 = r141_2 ~= nil
    assert(r141_5, "Could not get water density for " .. p141_0.definition .. [[.
]])
    return r141_2
end

currentMenuMotorSpeed = 0

-- line 3924-3932
-- proto#142 params=0 locals=4 upvalues=0 vararg=false
function returnToLevelSelection()
    if _G.res.isAudioPlaying("score_count") then
        _G.res.stopAudio("score_count")
    end
    actions.loadLevelSelectionMenu.action()
    local r142_0 = eventManager
    local r142_1 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
    r142_0:queueEvent(r142_1)
end

-- line 3934-3945
-- proto#143 params=0 locals=1 upvalues=0 vararg=false
function togglePausePage()
    if levelName ~= "MainMenu" then
        local r143_0 = menuManager:getRoot():getChild("gameHud")
        if r143_0 then
            local r143_1 = r143_0:getChild("pausePage")
            if r143_1.visible then
                r143_0:returnToGame()
            else
                r143_0:showPauseMenu()
            end
        end
    end
end

-- line 3947-3962
-- proto#144 params=0 locals=1 upvalues=0 vararg=false
function isPausePageVisible()
    if levelName == "MainMenu" then
        return false
    end
    local r144_0 = menuManager:getRoot():getChild("gameHud")
    if r144_0 then
        local r144_1 = r144_0:getChild("pausePage")
        if r144_1.visible then
            return true
        end
        return false
    end
    return false
end

-- line 3964-3979
-- proto#145 params=0 locals=1 upvalues=0 vararg=false
function isPausePageShowing()
    if levelName == "MainMenu" then
        return false
    end
    local r145_0 = menuManager:getRoot():getChild("gameHud")
    if r145_0 then
        local r145_1 = r145_0:getChild("pausePage")
        if r145_1.show then
            return true
        end
        return false
    end
    return false
end

-- line 3981-3983
-- proto#146 params=1 locals=2 upvalues=0 vararg=false
function isKeyPressed(p146_0)
    local r146_0 = g_keyPressed and g_keyPressed[p146_0]
    return r146_0
end

-- line 3985-3987
-- proto#147 params=1 locals=2 upvalues=0 vararg=false
function isKeyHold(p147_0)
    local r147_0 = g_keyHold and g_keyHold[p147_0]
    return r147_0
end

-- line 3989-3991
-- proto#148 params=1 locals=2 upvalues=0 vararg=false
function isKeyReleased(p148_0)
    local r148_0 = g_keyReleased and g_keyReleased[p148_0]
    return r148_0
end

-- line 3993-3995
-- proto#149 params=0 locals=0 upvalues=0 vararg=false
function disableME()
    mightyEagleDisabled = true
end

-- line 3997-4020
-- proto#150 params=2 locals=1 upvalues=0 vararg=false
function setCurrentState(p150_0, p150_1)
    if not p150_0.emotionsDisabled then
        local r150_0 = getObjectDefinition(p150_0.name)
        if p150_0.inDamagedState then
            if p150_0.isInflated then
                p150_0.currentState = "inflatedDamagedState"
            elseif p150_0.insideWater and r150_0.stateAnimations and r150_0.stateAnimations.underwaterDamagedState and not p150_0.insideBubble and not p150_0.insideSmallBubble then
                p150_0.currentState = "underwaterDamagedState"
            else
                p150_0.currentState = "damagedState"
            end
        elseif p150_0.isInflated then
            p150_0.currentState = "inflatedState"
        elseif p150_0.insideWater and r150_0.stateAnimations and r150_0.stateAnimations.underwaterState and not p150_0.insideBubble and not p150_0.insideSmallBubble then
            p150_0.currentState = "underwaterState"
        else
            p150_0.currentState = p150_1
        end
    end
end

-- line 4022-4048
-- proto#151 params=1 locals=9 upvalues=0 vararg=false
function addBirdSpecialParticles(p151_0)
    local r151_0 = blockTable.blocks[p151_0.definition]
    local r151_1 = r151_0.specialParticles
    if r151_1 ~= nil then
        local r151_2 = r151_1[1] == nil and { r151_1 } or r151_1
        for r151_3, r151_4 in _G.pairs(r151_2) do
            particleAmount = particleTable.particles[r151_4].amount
            particleAmount = particleAmount or 12
            local r151_5, r151_6 = particleTable.particles[r151_4], 1
            if p151_0.flocker then
                local r151_7, r151_8
                r151_6 = r151_7 * r151_8
            end
            putParticles({
                objectName = p151_0.name,
                particles = r151_4,
                amount = particleAmount,
                minScaleBegin = r151_5.minScaleBegin * r151_6,
                maxScaleBegin = r151_5.maxScaleBegin * r151_6,
                minScaleEnd = r151_5.minScaleEnd * r151_6,
                maxScaleEnd = r151_5.maxScaleEnd * r151_6
            })
        end
    end
end

-- line 4050-4057
-- proto#152 params=0 locals=0 upvalues=0 vararg=false
function clearDraggingCursor()
    g_aimingAidCursor.cursorToUse = nil
    g_aimingAidCursor.timeOnMaxSpeed = 0
    g_aimingAidCursor.lastFramesPositions = {}
    g_aimingAidCursor.lastFramesTimes = {}
    g_aimingAidCursor.currentDragDistance = 0
    g_aimingAidCursor.onHold = false
end

-- line 4059-4124
-- proto#153 params=2 locals=41 upvalues=0 vararg=false
function updateDraggingCursor(p153_0, p153_1)
    if #g_aimingAidCursor.lastFramesPositions == g_aimingAidCursor.framesToProfile then
        _G.table.remove(g_aimingAidCursor.lastFramesPositions, 1)
        _G.table.remove(g_aimingAidCursor.lastFramesTimes, 1)
        local r153_0 = { x = cursorPhysics.x, y = cursorPhysics.y }
        _G.table.insert(g_aimingAidCursor.lastFramesPositions, r153_0)
        _G.table.insert(g_aimingAidCursor.lastFramesTimes, p153_0)
        if g_aimingAidCursor.onHold then
            local r153_1 = g_aimingAidCursor.lastFramesPositions[g_aimingAidCursor.framesToProfile]
            local r153_2 = g_aimingAidCursor.lastFramesPositions[g_aimingAidCursor.framesToProfile]
            local r153_3 = g_aimingAidCursor.lastFramesPositions[g_aimingAidCursor.framesToProfile - 1]
            local r153_4 = g_aimingAidCursor.lastFramesPositions[g_aimingAidCursor.framesToProfile - 1]
            local r153_5 = distance(r153_1.x, r153_2.y, r153_3.x, r153_4.y)
            g_aimingAidCursor.currentDragDistance = g_aimingAidCursor.currentDragDistance + r153_5
            local r153_6 = g_aimingAidCursor.currentDragDistance
            if g_aimingAidCursor.minDistanceToResumeDrag < r153_6 then
                g_aimingAidCursor.onHold = false
                g_aimingAidCursor.removedHoldTime = p153_0
                g_aimingAidCursor.currentDragDistance = 0
            end
        else
            local r153_7 = 0
            local r153_8 = 2
            local r153_9 = g_aimingAidCursor.lastFramesPositions
            for r153_10 = r153_8, #r153_9 do
                local r153_11 = g_aimingAidCursor.lastFramesPositions[r153_10 - 1]
                local r153_12 = g_aimingAidCursor.lastFramesPositions[r153_10 - 1]
                local r153_13 = distance(g_aimingAidCursor.lastFramesPositions[r153_10].x, g_aimingAidCursor.lastFramesPositions[r153_10].y, r153_11.x, r153_12.y)
                r153_7 = r153_7 + r153_13
            end
            local r153_14 = g_aimingAidCursor.maxDistanceToPutDragOnHold
            if r153_7 < r153_14 then
                g_aimingAidCursor.onHold = true
                g_aimingAidCursor.currentDragDistance = 0
            else
                g_aimingAidCursor.cursorToUse = {}
                if isPCVersion() then
                    g_aimingAidCursor.cursorToUse.x = cursorPhysics.x
                    g_aimingAidCursor.cursorToUse.y = cursorPhysics.y
                else
                    local r153_15 = #g_aimingAidCursor.lastFramesPositions
                    local r153_16
                    if g_aimingAidCursor.removedHoldTime then
                        local r153_17 = g_aimingAidCursor.removedHoldTime
                        if p153_0 - r153_17 < 0.5 then
                            if r153_15 > 5 then
                                local r153_18 = r153_15 - 5
                                if r153_18 > 5 then
                                    r153_16 = r153_18 - 5
                                else
                                    r153_16 = r153_18
                                end
                            else
                                r153_16 = r153_15
                            end
                        else
                            r153_16 = r153_15
                        end
                    else
                        r153_16 = r153_15
                    end
                    g_aimingAidCursor.cursorToUse.x = g_aimingAidCursor.lastFramesPositions[r153_16].x
                    g_aimingAidCursor.cursorToUse.y = g_aimingAidCursor.lastFramesPositions[r153_16].y
                end
            end
        end
        return
    end
    local r153_19 = { x = cursorPhysics.x, y = cursorPhysics.y }
    _G.table.insert(g_aimingAidCursor.lastFramesPositions, r153_19)
    _G.table.insert(g_aimingAidCursor.lastFramesTimes, p153_0)
    g_aimingAidCursor.cursorToUse = { x = cursorPhysics.x, y = cursorPhysics.y }
end

-- line 4129-4171
-- proto#154 params=3 locals=20 upvalues=0 vararg=false
function updateDraggingCursorLagOnly(p154_0, p154_1, p154_2)
    if not p154_2 then
        p154_2 = cursorPhysics
    end
    if #g_aimingAidCursor.lastFramesPositions == g_aimingAidCursor.framesToProfile then
        _G.table.remove(g_aimingAidCursor.lastFramesPositions, 1)
        _G.table.remove(g_aimingAidCursor.lastFramesTimes, 1)
        local r154_0 = { x = p154_2.x, y = p154_2.y }
        _G.table.insert(g_aimingAidCursor.lastFramesPositions, r154_0)
        _G.table.insert(g_aimingAidCursor.lastFramesTimes, p154_0)
        g_aimingAidCursor.cursorToUse = {}
        if isPCVersion() or useAccelerometerControls then
            g_aimingAidCursor.cursorToUse.x = p154_2.x
            g_aimingAidCursor.cursorToUse.y = p154_2.y
        else
            local r154_1 = #g_aimingAidCursor.lastFramesPositions
            local r154_2 = g_aimingAidCursor.lastFramesPositions
            for r154_3 = #r154_2 - 1, 1, -1 do
                local r154_4 = g_aimingAidCursor.lastFramesTimes[r154_3]
                if p154_0 - r154_4 < 0.10000000149011612 then
                    r154_1 = r154_1 - 1
                end
            end
            g_aimingAidCursor.cursorToUse.x = g_aimingAidCursor.lastFramesPositions[r154_1].x
            g_aimingAidCursor.cursorToUse.y = g_aimingAidCursor.lastFramesPositions[r154_1].y
        end
        return
    end
    local r154_5 = { x = p154_2.x, y = p154_2.y }
    _G.table.insert(g_aimingAidCursor.lastFramesPositions, r154_5)
    _G.table.insert(g_aimingAidCursor.lastFramesTimes, p154_0)
    g_aimingAidCursor.cursorToUse = { x = p154_2.x, y = p154_2.y }
end

-- line 4173-4238
-- proto#155 params=1 locals=26 upvalues=0 vararg=false
function applyForceToSelectedBird(p155_0)
    handleBirdIsBeingMoved()
    if p155_0 and not levelCompleted and not levelFailed and g_aimingAidAttributes.enabled then
        simulateTrajectory()
    end
    ClearSimulationTrajectory()
    setPosition(p155_0.name, p155_0.x, p155_0.y)
    if p155_0.definition == "ME_BAIT" then
        local r155_0 = getEpisodeMetadata(currentFolder)
        assert(r155_0.alwaysInEagleMode ~= true, "ME_BAIT used in Feather level.")
        numMightyEaglesShot = numMightyEaglesShot + 1
        menuManager:getRoot():reduceEagle()
    end
    local r155_1 = blockTable.blocks[p155_0.definition]
    if r155_1.onLaunched ~= nil then
        local r155_2 = _G.type
        local r155_3 = blockTable.blocks[p155_0.definition]
        if r155_2(r155_3.onLaunched) == "table" then
            local r155_4 = _G.ipairs
            local r155_5 = blockTable.blocks[p155_0.definition]
            for r155_6, r155_7 in r155_4(r155_5.onLaunched) do
                addEventCall(r155_7, { name = p155_0.name })
            end
        else
            local r155_8 = addEventCall
            local r155_9 = blockTable.blocks[p155_0.definition]
            r155_8(r155_9.onLaunched, { name = p155_0.name })
        end
    end
    if getNextBird(p155_0.startNumber + 1) == nil then
        disableME()
    end
    local r155_10 = calculateImpulseVectorForBird(g_aimingAidCursor.cursorToUse.x - levelStartPosition.x, g_aimingAidCursor.cursorToUse.y - levelStartPosition.y, p155_0)
    setActive(p155_0.name, true)
    setPosition(p155_0.name, p155_0.x, p155_0.y)
    setVelocity(p155_0.name, 0, 0)
    applyImpulse(p155_0.name, r155_10.x, r155_10.y, g_aimingAidCursor.cursorToUse.x, g_aimingAidCursor.cursorToUse.y)
    setAngularVelocity(p155_0.name, 0)
    SettingsWrapper:birdShot()
    checkForBirdsShotAchievement()
    if timeWithoutLevelGoals ~= nil then
        timeWithoutLevelGoals = -6
        g_scoreAddedTime = 6
        if not startedFromEditor then
            local r155_11 = getLevelMetadata
            local r155_12 = actions.myLevels[currentFolder]
            local r155_13 = r155_11(r155_12[currentLevel])
            if r155_13.additionalLevelTime and isLastBird(p155_0) then
                g_scoreAddedTime = g_scoreAddedTime + r155_13.additionalLevelTime
            end
        end
    end
    enableGravityForBird(p155_0.name, true)
    p155_0.resetAngle = p155_0.angle
end

-- line 4240-4248
-- proto#156 params=1 locals=3 upvalues=0 vararg=false
function isLastBird(p156_0)
    for r156_0, r156_1 in _G.pairs(birds) do
        if not (r156_1.shot or r156_1.name == p156_0.name) then
            return false
        end
    end
    return true
end

-- line 4251-4258
-- proto#157 params=1 locals=4 upvalues=0 vararg=false
function fireAllObjectTriggerEvents(p157_0)
    local r157_0 = objects.world[p157_0]
    if r157_0 and r157_0.triggerEvents then
        for r157_1, r157_2 in _G.pairs(r157_0.triggerEvents) do
            fireObjectTriggerEvents(p157_0, { obj = r157_0 }, r157_1)
        end
    end
end

-- line 4263-4288
-- proto#158 params=3 locals=11 upvalues=0 vararg=false
function fireObjectTriggerEvents(p158_0, p158_1, p158_2)
    if not p158_2 then
        return
    end
    local r158_0 = p158_1.obj
    local r158_1
    if r158_0 == nil then
        if p158_1.name then
            r158_1 = objects.world[p158_1.name]
        else
            r158_1 = r158_0
        end
    else
        r158_1 = r158_0
    end
    if r158_1 and r158_1.name and objects.world[r158_1.name] and objects.world[r158_1.name].triggerEvents and r158_1.triggerEvents[p158_2] then
        for r158_2, r158_3 in _G.pairs(r158_1.triggerEvents[p158_2]) do
            local r158_4 = objects.world[r158_2]
            if r158_4 then
                local r158_5 = { obj = r158_4 }
                for r158_6, r158_7 in _G.ipairs(r158_3) do
                    fireAction(r158_7, r158_5)
                end
            end
        end
    end
end

-- line 4290-4300
-- proto#159 params=3 locals=1 upvalues=0 vararg=false
function fireAction(p159_0, p159_1, p159_2)
    if actions[p159_0] ~= nil then
        p159_1.dt = 0
        fireObjectTriggerEvents(p159_0, p159_1, p159_2)
        local r159_0 = actions[p159_0]
        r159_0.action(p159_1)
    end
end

-- line 4303-4319
-- proto#160 params=0 locals=1 upvalues=0 vararg=false
function handleBirdSelected()
    if not (selectedBird.originalPosX and selectedBird.originalPosY) then
        selectedBird.originalPosX = selectedBird.x
        selectedBird.originalPosY = selectedBird.y
    end
    previousCursorPoint.x = selectedBird.x
    previousCursorPoint.y = selectedBird.y
    _G.assert(selectedBird ~= nil)
    local r160_0 = blockTable.blocks[selectedBird.definition]
    setAimingAidSprite(r160_0.aimingAidSprite)
end

-- line 4322-4342
-- proto#161 params=0 locals=19 upvalues=0 vararg=false
function handleBirdIsBeingMoved()
    local r161_0 = cursorPhysics
    if g_useNewBirdLaunch then
        local r161_1
        r161_0 = r161_1.cursorToUse
    end
    if selectedBird ~= nil then
        local r161_2 = { x = r161_0.x - levelStartPosition.x, y = r161_0.y - levelStartPosition.y }
        local r161_3 = vLength(r161_2.x, r161_2.y)
        if r161_3 > 0 then
            local r161_4 = _G.math.min(1, selectedBird.controlRadius / r161_3)
            local r161_5 = levelStartPosition.x + r161_2.x * r161_4
            setPosition(selectedBird.name, r161_5, levelStartPosition.y + r161_2.y * r161_4)
            local r161_6 = _G.math.atan2(r161_2.y, r161_2.x)
            setRotation(selectedBird.name, _G.math.pi + r161_6)
        else
            setPosition(selectedBird.name, levelStartPosition.x, levelStartPosition.y)
        end
    end
end

-- line 4344-4365
-- proto#162 params=0 locals=0 upvalues=0 vararg=false
function cancelBirdDrag()
    if selectedBird ~= nil then
        if selectedBird.dragStartedTimer then
            selectedBird.dragStartedTimer = nil
        end
        setPosition(selectedBird.name, levelStartPosition.x, levelStartPosition.y)
        setRotation(selectedBird.name, slingShotAngle or 0)
        g_birdDragOnTouchAttributes.dragging = false
        selectedBird = nil
        g_currentCursorName = "CURSOR_HAND_POINT"
        rubberBandPos.x = levelStartPosition.x
        rubberBandPos.y = levelStartPosition.y
        rubberBandSpeed = 0
        rubberBandLength = 0
        clearAimingAid(1)
    end
end

-- line 4367-4372
-- proto#163 params=0 locals=2 upvalues=0 vararg=false
function isTouchDragAllowed()
    local r163_0 = screen.x - screenWidth * 0.44999998807907104 / (worldScale * slingshotScale)
    local r163_1, r163_2 = physicsToWorldTransform(levelStartPosition.x, levelStartPosition.y)
    return r163_0 < r163_1
end

-- line 4378-4434
-- proto#164 params=2 locals=13 upvalues=0 vararg=false
function updatePCMouseDragging(p164_0, p164_1)
    if isKeyPressed("LBUTTON") then
        g_mouseDragAttributes.lastPressedX = -1
        g_mouseDragAttributes.lastPressedY = -1
        g_mouseDragAttributes.dragFromMouse = false
        g_mouseDragAttributes.mouseDragTime = 0
        g_mouseDragAttributes.cummulativeDragX = 0
        g_mouseDragAttributes.cummulativeDragY = 0
    elseif isKeyHold("LBUTTON") then
        g_mouseDragAttributes.dragFromMouse = true
        g_mouseDragAttributes.dragFromTouch = false
        if false == false and t_cursorOnHUDButtons == false then
            g_currentCursorName = "CURSOR_HAND_GRAB"
        end
        if g_mouseDragAttributes.lastPressedX < 0 then
            g_mouseDragStartX = cursor.x
            g_mouseDragAttributes.mouseDragTime = 0
            g_mouseDragAttributes.cummulativeDragX = 0
            g_mouseDragAttributes.cummulativeDragY = 0
            g_mouseDragAttributes.lastPressedX = cursor.x
            g_mouseDragAttributes.lastPressedY = cursor.y
        else
            local r164_0 = g_mouseDragAttributes.mouseDragTime
            local r164_1 = g_mouseDragAttributes.targetDragTime
            if r164_0 < r164_1 then
                g_mouseDragAttributes.cummulativeDragX = g_mouseDragAttributes.cummulativeDragX + (cursor.x - g_mouseDragAttributes.lastPressedX)
                g_mouseDragAttributes.cummulativeDragY = g_mouseDragAttributes.cummulativeDragY + (cursor.y - g_mouseDragAttributes.lastPressedY)
                g_mouseDragAttributes.mouseDragTime = g_mouseDragAttributes.mouseDragTime + p164_0
                g_mouseDragAttributes.lastPressedX = cursor.x
                g_mouseDragAttributes.lastPressedY = cursor.y
            else
                g_mouseDragAttributes.mouseDragTime = g_mouseDragAttributes.mouseDragTime % g_mouseDragAttributes.targetDragTime
                g_mouseDragAttributes.cummulativeDragX = cursor.x - g_mouseDragAttributes.lastPressedX
                g_mouseDragAttributes.cummulativeDragY = cursor.y - g_mouseDragAttributes.lastPressedY
                g_mouseDragAttributes.lastPressedX = cursor.x
                g_mouseDragAttributes.lastPressedY = cursor.y
            end
        end
    elseif isKeyReleased("LBUTTON") then
        g_mouseDragAttributes.lastPressedX = -1
        g_mouseDragAttributes.lastPressedY = -1
        g_mouseDragAttributes.dragFromMouse = false
    end
end

-- line 4436-4476
-- proto#165 params=2 locals=17 upvalues=0 vararg=false
function updatePCGesturePause(p165_0, p165_1)
    if touchcount == 2 and SettingsWrapper.getFullScreen() then
        if g_gesturePausePage.touchOneID == nil then
            for r165_0, r165_1 in _G.pairs(touches) do
                g_gesturePausePage.touchOneID = r165_0
                break
            end
            local r165_2 = g_gesturePausePage
            local r165_3 = touches[g_gesturePausePage.touchOneID]
            r165_2.currentDragX = r165_3.x
            local r165_4 = g_gesturePausePage
            local r165_5 = touches[g_gesturePausePage.touchOneID]
            r165_4.currentDragY = r165_5.y
        end
        if g_gesturePausePage.touchOneID ~= nil and touches[g_gesturePausePage.touchOneID] then
            local r165_6 = g_gesPrevX
            local r165_7
            if r165_6 then
                r165_7 = r165_6
            else
                local r165_8 = touches[g_gesturePausePage.touchOneID]
                r165_7 = r165_8.x
            end
            g_gesPrevX = r165_7
            local r165_9 = g_gesPrevY
            local r165_10
            if r165_9 then
                r165_10 = r165_9
            else
                local r165_11 = touches[g_gesturePausePage.touchOneID]
                r165_10 = r165_11.y
            end
            g_gesPrevY = r165_10
            local r165_12 = touches[g_gesturePausePage.touchOneID]
            local r165_13 = r165_12.x
            g_gesDragX = r165_13 - g_gesPrevX
            local r165_14 = touches[g_gesturePausePage.touchOneID]
            local r165_15 = r165_14.y
            g_gesDragY = r165_15 - g_gesPrevY
            local r165_16 = touches[g_gesturePausePage.touchOneID]
            g_gesPrevX = r165_16.x
            local r165_17 = touches[g_gesturePausePage.touchOneID]
            g_gesPrevY = r165_17.y
            if not g_gesturePausePage.visible and not g_animLevel and distance(0, 0, g_gesDragX, g_gesDragY) > 30 and 5 * _G.math.abs(g_gesDragX) < _G.math.abs(g_gesDragY) then
                g_gesturePausePage:open()
            end
        end
    else
        g_gesturePausePage.touchOneID = nil
        g_gesPrevX = nil
        g_gesPrevY = nil
    end
end

-- line 4479-4503
-- proto#166 params=2 locals=9 upvalues=0 vararg=false
function updateMultitouchSweep(p166_0, p166_1)
    if multitouchSweep.isSweepping == true and multitouchSweep.sweepAxis == "x" then
        local r166_0 = multitouchSweep.sweepOffsetX
        if g_usingNewCamera then
            local r166_1 = r166_0 / worldScale
            gameCamera:panCamera(r166_1, r166_1, true)
        else
            local r166_2 = objects.castleCameraData[deviceModel]
            local r166_3 = objects.birdCameraData[deviceModel]
            local r166_4 = r166_2.px - r166_3.px
            if r166_4 > 1 then
                cameraAnimationSlider = cameraAnimationSlider - r166_0 / (r166_4 * worldScale)
            end
            cameraAnimationSlider = _G.math.max(0, cameraAnimationSlider)
            cameraAnimationSlider = _G.math.min(1, cameraAnimationSlider)
            local r166_5 = cameraAnimationSlider
            if r166_5 > 0.5 then
                cameraAnimationSliderTarget = 1
            else
                cameraAnimationSliderTarget = 0
            end
        end
    end
end

-- line 4506-4518
-- proto#167 params=1 locals=3 upvalues=0 vararg=false
function rotateFlyingBird(p167_0)
    if objects.world[p167_0] ~= nil then
        local r167_0 = objects.world[p167_0]
        if not (r167_0.rotateWhileFlying == nil or r167_0.rotateWhileFlying) then
            return
        end
        local r167_1 = _G.math.atan2(r167_0.yVel, r167_0.xVel)
        setRotation(p167_0, r167_1)
    end
end

-- line 4520-4523
-- proto#168 params=0 locals=0 upvalues=0 vararg=false
function enableGameUpdate()
    setGameOn(isInGameMode())
    setPhysicsEnabled(true)
end

-- line 4526-4537
-- proto#169 params=2 locals=0 upvalues=0 vararg=false
function storeLevelProgress(p169_0, p169_1)
    if SettingsWrapper:getLevelProgress(p169_0) <= p169_1 and not getLevelMetadata(actions.myLevels[p169_0][p169_1]).episodeEndComic then
        loginfo("storeLevelProgress() LEVEL PROGRESS STORED")
        SettingsWrapper:setLevelProgress(p169_0, p169_1 + 1)
        return
    end
    loginfo("storeLevelProgress() level progress not stored")
end

-- line 4539-4554
-- proto#170 params=1 locals=2 upvalues=0 vararg=false
function checkRewardMightyEagles(p170_0)
    if platformSupportsME() then
        local r170_0 = getLevelMetadata(p170_0)
        local r170_1 = r170_0.rewardEagles
        if not (r170_1 == nil or r170_1.amount == nil or SettingsWrapper:isEaglesRewardedFrom(p170_0) == true) then
            SettingsWrapper:setEaglesRewarderFrom(p170_0)
            fireAction("setMEAdvertPossible", {})
            addMightyEagles(r170_1.amount)
        end
    end
end

-- line 4560-4574
-- proto#171 params=2 locals=7 upvalues=0 vararg=false
function cheatAllThreeStars(p171_0, p171_1)
    for r171_0, r171_1 in _G.ipairs(actions.myLevels[p171_0]) do
        if getLevelMetadata(r171_1).type ~= "comic" then
            if getLevelMetadata(r171_1).ignoreScore ~= true and not (p171_1 and getLevelMetadata(r171_1).lastLevelOfEpisode) then
                highscores[r171_1] = highscores[r171_1] or {}
                highscores[r171_1].score = 1000000000
                highscores[r171_1].eagleScore = 100
            end
        end
    end
end

-- line 4576-4579
-- proto#172 params=0 locals=2 upvalues=0 vararg=false
function cheatThreeStarsCurrentLevel()
    local r172_0 = highscores[levelName]
    r172_0.score = 999999
    local r172_1 = highscores[levelName]
    r172_1.eagleScore = 100
end

-- line 4581-4644
-- proto#173 params=1 locals=10 upvalues=0 vararg=false
function updateLevelEnding(p173_0)
    clearAimingAid(1)
    enableAimingAid(false)
    if levelCompleted then
        birdBuffTimer = birdBuffTimer - p173_0
        if birdBuffTimer < 0 then
            local r173_0 = getNextBird(birdsLeftCounter)
            if r173_0 == nil then
                levelCompleteTimer = levelCompleteTimer - p173_0
            else
                birdsLeftCounter = birdsLeftCounter + 1
                local r173_1 = birdsLeftScoreIncrement
                local r173_2 = getObjectDefinition(r173_0)
                if r173_2.birdLeftScore then
                    r173_1 = r173_2.birdLeftScore
                end
                scoreTable.birds.score = scoreTable.birds.score + r173_1
                local r173_3 = objects.world[r173_0]
                if addLeftoverBirdScore then
                    addLeftoverBirdScore(r173_3.definition, r173_1)
                end
                if hasBirdsLeftInSlingShot() then
                    if r173_2.sounds.idle then
                        playAudio(r173_2.sounds.idle)
                    else
                        playAudio("bird_misc")
                    end
                end
                _G.table.insert(floatingScores, {
                    birdScore = true,
                    x = r173_3.x,
                    y = r173_3.y - 4 * gameWorldScale,
                    sprite = getObjectDefinition(r173_0).sprites.score,
                    score = r173_1,
                    time = 0,
                    lifetime = 0.8999999761581421,
                    maxScale = 1,
                    xs = 0
                })
                birdBuffTimer = 0.5
            end
            updateScore(p173_0)
            if quadClick == true then
                score = getLevelStarScoreLimit(levelName, 3)
                if eagleBaitLaunched == true then
                    local r173_4 = starTable[levelName]
                    score = r173_4.eagleScore
                end
            end
        end
    else
        levelCompleteTimer = levelCompleteTimer - p173_0
    end
    if levelCompleteTimer <= 0 then
        if resetEventSystem then
            resetEventSystem()
        else
            g_blockLevelMusic = false
            gotoLevelEnding()
        end
    end
end

-- line 4647-4709
-- proto#174 params=1 locals=5 upvalues=0 vararg=false
function initLevelComplete(p174_0)
    loginfo([[
 ---------- init level complete ----------- 
 ]])
    if not startedFromEditor and editor == nil then
        checkForLevelCompleteRewards()
    end
    if currentMusic ~= nil and res.isAudioPlaying(currentMusic) then
        res.stopAudio(currentMusic)
    end
    if previousMusicName ~= nil and res.isAudioPlaying(previousMusicName) then
        res.stopAudio(previousMusicName)
    end
    rubberBandPos.x = levelStartPosition.x
    rubberBandPos.y = levelStartPosition.y
    rubberBandSpeed = 0
    levelCompleted = true
    birdsLeftCounter = currentBirdIndex
    disableME()
    if levelObjectives and levelObjectives.isObjectiveCompleted() then
        eventManager:notify({ id = events.EID_LEVEL_OBJECTIVES_COMPLETED })
    end
    if powerups then
        eventManager:notify({ id = events.EID_POWERUP_CLOSE_SLIDER })
    end
    if currentBirdName == nil or objects.world[currentBirdName].shot == true then
        birdsLeftCounter = birdsLeftCounter + 1
    end
    if not p174_0 then
        playAudio("level_clear_military")
    end
    stopAudioByFilter(audioFilters.levelEndFilters)
    levelCompleteTimer = levelCompleteDelay or 1
    birdBuffTimer = 1
    g_blockLevelMusic = true
    g_cameraSpringForceConstantNoTarget = 5
    if not dontMoveToBirdCameraWhenFinished then
        if g_usingNewCamera then
            activateLevelEndCamera()
        else
            local r174_0 = objects.castleCameraData[deviceModel]
            local r174_1 = objects.birdCameraData[deviceModel]
            moveToBirdCamera(r174_0.px - r174_1.px)
        end
    end
    if not (selectedBird == nil or selectedBird.name == nil or selectedBird.name == "") then
        cancelBirdDrag()
    end
end

-- line 4711-4740
-- proto#175 params=1 locals=2 upvalues=0 vararg=false
function initLevelFailed(p175_0)
    if not levelFailed then
        eventManager:notify({ id = events.EID_LEVEL_FAILED_INITIALIZED })
        eventManager:notify({ id = events.EID_LEVEL_WILL_END })
    end
    levelFailed = true
    local r175_0 = blockTable.themes[currentTheme]
    local r175_1 = r175_0.levelFailedSound
    if not (r175_1 == nil or res.isAudioPlaying(r175_1) == true) then
        playAudio(r175_1)
    end
    if g_usingNewCamera and levelFailedTimer == 0 then
        initLevelFailedCamera()
    end
    stopAudioByFilter(audioFilters.levelEndFilters)
    levelFailedTimer = levelFailedTimer + p175_0
    local r175_2 = levelFailedTimer
    if (levelFailedDelay or 1.5) < r175_2 then
        print("SETTING LEVEL FAILED")
        levelCompleteTimer = 0.5
    end
end

-- line 4750-4777
-- proto#176 params=0 locals=4 upvalues=0 vararg=false
function initializeGame()
    initializeEventSystem()
    initializeMenu()
    loadSubsystems()
    initSubsystems()
    if channelEnabled then
        rovioChannel = ChannelManager:new()
    end
    updateValues()
    setPhysicsEnabled(false)
    cos = _G.math.cos
    sin = _G.math.sin
    SettingsWrapper:increaseSessionNumber()
    biCheckDailyActiveNewUser()
    local r176_0 = eventManager
    local r176_1 = {
        id = events.EID_GAME_INITIALIZED,
        screenWidth = screenWidth,
        screenHeight = screenHeight,
        customerString = customerString,
        deviceModel = deviceModel
    }
    r176_0:notify(r176_1)
    if SettingsWrapper:getGamePurchasedFrom() == nil then
        SettingsWrapper:setGamePurchasedFrom(customerString)
        local r176_2 = eventManager
        local r176_3 = { id = events.EID_FLURRY_GAME_PURCHASED_FROM, from = customerString }
        r176_2:notify(r176_3)
    end
end

-- line 4779-4782
-- proto#177 params=0 locals=0 upvalues=0 vararg=false
function loadSubsystems()
    loadLuaFileToObject(commonScriptPath .. "/subsystemsapi.lua", this, "subsystemsapi")
    loadLuaFileToObject(commonScriptPath .. "/subsystems/subsystems.lua", this, "subsystems")
end

-- line 4784-4794
-- proto#178 params=0 locals=0 upvalues=0 vararg=false
function initSubsystems()
    print("gamelogic - initSubsystems()")
    initAds()
    if showEditor ~= true then
        loadLuaFileToObject(scriptPath .. "/flurry.lua", this.subsystems, "")
    end
end

-- line 4797-4827
-- proto#179 params=0 locals=14 upvalues=0 vararg=false
function biCheckDailyActiveNewUser()
    bi_data = bi_data or {}
    bi_data.root = bi_data.root or {}
    if bi_data.root.first_launch_date then
        local r179_0 = getTimeDifference(getCurrentTime(), bi_data.root.first_launch_date)
        local r179_1 = r179_0.days
        if r179_1 >= 1 then
            local r179_2 = eventManager
            local r179_3 = { id = events.EID_BI_RETENTION, differenceInDays = r179_0.days }
            r179_2:notify(r179_3)
        end
    else
        eventManager:notify({ id = events.EID_BI_NEW_USER })
        local r179_4 = getCurrentTime()
        r179_4.hour = 0
        r179_4.minutes = 0
        r179_4.seconds = 0
        bi_data.root.first_launch_date = r179_4
    end
    if bi_data.root.last_launch_date then
        local r179_5 = getTimeDifference(getCurrentTime(), bi_data.root.last_launch_date)
        local r179_6 = r179_5.days
        if r179_6 >= 1 then
            local r179_7 = eventManager
            local r179_8 = { id = events.EID_BI_DAILY_ACTIVE, differenceInDays = r179_5.days }
            r179_7:notify(r179_8)
        end
    else
        bi_data.root.last_launch_date = getCurrentTime()
    end
    savePersistentLuaFileWrapper("bi_data.lua", "bi_data")
end

-- line 4831-4857
-- proto#180 params=0 locals=7 upvalues=0 vararg=false
function metroSnapToggleAudio()
    local r180_0 = SettingsWrapper
    local r180_1 = SettingsWrapper:isAudioEnabled()
    r180_0:setAudioEnabled(not r180_1)
    local r180_2 = _G.tostring(SettingsWrapper:isAudioEnabled())
    print("metroSnapAudioToggle: " .. r180_2)
    if SettingsWrapper:isAudioEnabled() then
        audioRampVolume = nil
        audioRampLength = nil
        if not res.startAudioOutput() then
            if isPCVersion() == true then
                res.createAudioOutput(2, 16, 44100)
            else
                res.createAudioOutput(1, 16, 16000)
            end
        end
        if not g_blockLevelMusic then
            handleLevelMusic()
        end
    else
        _G.res.stopAudioOutput()
        audioRampVolume = nil
        audioRampLength = nil
    end
end

-- line 4859-4887
-- proto#181 params=0 locals=6 upvalues=0 vararg=false
function toggleAudio()
    local r181_0 = SettingsWrapper
    local r181_1 = SettingsWrapper:isAudioEnabled()
    r181_0:setAudioEnabled(not r181_1)
    local r181_2 = _G.tostring(SettingsWrapper:isAudioEnabled())
    print("toggleAudio: " .. r181_2)
    if SettingsWrapper:isAudioEnabled() then
        audioRampVolume = nil
        audioRampLength = nil
        if not res.startAudioOutput() then
            if isPCVersion() == true then
                res.createAudioOutput(2, 16, 44100)
            else
                res.createAudioOutput(1, 16, 16000)
            end
        end
        setEffectsVolume(1)
        setMusicVolume(1)
        if not g_blockLevelMusic then
            handleLevelMusic()
        end
    else
        audioRampVolume = 1
        audioRampLength = -1
    end
end

-- line 4890-4896
-- proto#182 params=1 locals=0 upvalues=0 vararg=false
function setAudioButtonState(p182_0)
    if SettingsWrapper:isAudioEnabled() then
        p182_0:setState(1)
    else
        p182_0:setState(2)
    end
end

-- line 4900-4994
-- proto#183 params=1 locals=55 upvalues=0 vararg=false
function animateBirdToSlingShot(p183_0)
    local r183_0 = currentBirdIndex + 1
    local r183_1 = nextBirdTimer
    if r183_1 > 0 then
        nextBirdTimer = nextBirdTimer - p183_0
        if nextBirdTimer <= 0 then
            if getNextBird(r183_0) == nil then
                allowResetToBirdCamera = false
            elseif birdFired then
                birdFired = false
                fillInNextBird = true
                selectedBird = nil
            end
        end
    end
    if fillInNextBird == true then
        if birdToSlingshotBirdName == nil then
            birdToSlingshotAnimationTimer = 0
            birdToSlingshotBirdName = getNextBird(r183_0)
            if birdToSlingshotBirdName == nil and startedFromEditor == true then
                _G.assert(false, "No Birds in level!!")
                return
            end
            if birdToSlingshotBirdName ~= nil then
                setObjectParameter(birdToSlingshotBirdName, 2, 1)
                local r183_2 = objects.world[birdToSlingshotBirdName]
                r183_2.jumpTimer = 10000
                local r183_3 = objects.world[birdToSlingshotBirdName]
                if r183_3.jumpOn == true then
                    local r183_4 = objects.world[birdToSlingshotBirdName]
                    birdToSlingshotAnimationStartY = r183_4.oldY
                    local r183_5 = objects.world[birdToSlingshotBirdName]
                    local r183_6 = objects.world[birdToSlingshotBirdName]
                    r183_5.y = r183_6.oldY
                    local r183_7 = objects.world[birdToSlingshotBirdName]
                    r183_7.jumpOn = false
                end
                local r183_8 = objects.world[birdToSlingshotBirdName]
                birdToSlingshotAnimationStartX = r183_8.x
                local r183_9 = objects.world[birdToSlingshotBirdName]
                birdToSlingshotAnimationStartY = r183_9.y
                local r183_10 = objects.world[birdToSlingshotBirdName]
                birdToSlingshotAnimationHeight = (levelStartPosition.y - r183_10.y) * 1.3300000429153442
            end
        end
        birdToSlingshotAnimationTimer = birdToSlingshotAnimationTimer + p183_0 * (timeAttackObjectiveEnabled and 1.5 or 1)
        local r183_11 = objects.world[birdToSlingshotBirdName]
        if r183_11 == nil then
            return
        end
        local r183_12 = _G.math.sin(birdToSlingshotAnimationAngle * birdToSlingshotAnimationTimer)
        setPosition(r183_11.name, birdToSlingshotAnimationStartX * (1 - birdToSlingshotAnimationTimer) + levelStartPosition.x * birdToSlingshotAnimationTimer, birdToSlingshotAnimationStartY + r183_12 * birdToSlingshotAnimationHeight)
        setRotation(r183_11.name, r183_11.angle + _G.math.pi * 2 * p183_0)
        setActive(r183_11.name, false)
        local r183_13 = birdToSlingshotAnimationTimer
        if r183_13 >= 1 then
            if resumingOldLevel and currentFolder ~= "bonus" then
                return
            end
            birdToSlingshotBirdName = nil
            birdToSlingshotAnimationTimer = 0
            fillInNextBird = false
            birdReady = true
            currentBirdIndex = currentBirdIndex + 1
            currentBirdName = getNextBird(currentBirdIndex)
            setPosition(currentBirdName, levelStartPosition.x - 0.10000000149011612 * slingshotScale, levelStartPosition.y - 0.10000000149011612 * slingshotScale)
            local r183_14 = rubberBandPos
            local r183_15 = levelStartPosition.x - 0.10000000149011612 * slingshotScale
            rubberBandPos.y = levelStartPosition.y - 0.10000000149011612 * slingshotScale
            r183_14.x = r183_15
            rubberBandAngle = _G.math.atan2(-0.10000000149011612, 0.10000000149011612)
            local r183_16 = objects.birdCameraData[deviceModel]
            local r183_17 = objects.birdCameraData[deviceModel]
            local r183_18 = objects.castleCameraData[deviceModel]
            local r183_19 = objects.castleCameraData[deviceModel]
            local r183_20 = _G.math.abs(distance(r183_16.px, r183_17.py, r183_18.px, r183_19.py))
            local r183_21 = objects.birdCameraData[deviceModel]
            local r183_22 = objects.birdCameraData[deviceModel]
            local r183_23 = _G.math.abs(distance(screen.x, screen.y, r183_21.px, r183_22.py))
            local r183_24 = _G.math.min(1, _G.math.max(0.25, 1 - r183_23 / r183_20))
            if hasBirdsLeftInSlingShot() and not g_disableBirdToSlingshotSound then
                res.playAudio("bird_next_military", r183_24)
            end
            setRotation(currentBirdName, slingShotAngle)
            setVelocity(currentBirdName, 0, 0)
            eventManager:notify({ id = events.EID_NEXT_BIRD_READY })
        end
    end
end

-- line 4996-5004
-- proto#184 params=0 locals=3 upvalues=0 vararg=false
function hasBirdsLeftInSlingShot()
    for r184_0, r184_1 in _G.pairs(birds) do
        if r184_1.controllable and not r184_1.shot and r184_1.definition ~= "ME_BAIT" then
            return true
        end
    end
    return false
end

-- line 5006-5185
-- proto#185 params=1 locals=124 upvalues=0 vararg=false
function updateCharacterAnimations(p185_0)
    if checkLevelFailed() then
        for r185_0, r185_1 in _G.pairs(levelGoals) do
            if r185_1.laughJointedAnim == nil or r185_1.currentAnimation == r185_1.laughJointedAnim or checkJointsForObject(r185_1.name) == false then
                if not (r185_1.laughAnim == nil or r185_1.currentAnimation == r185_1.laughAnim or r185_1.currentAnimation == r185_1.laughJointedAnim) then
                    setAnimation(r185_1.name, r185_1.laughAnim)
                end
            else
                setAnimation(r185_1.name, r185_1.laughJointedAnim)
            end
        end
    end
    for r185_2, r185_3 in _G.pairs(animatedObjects) do
        local r185_4 = true
        if not checkStillInWorld(r185_3.name) then
            r185_4 = false
        end
        local r185_5 = getObjectDefinition(r185_3.name)
        if r185_4 and r185_5.useStateAnimations then
            if r185_5.stateAnimations[r185_3.currentState] ~= nil and r185_3.currentSubAnimation ~= nil and r185_3.disableAnimations ~= true then
                if r185_3.animFrameTime == nil then
                    local r185_6 = _G.math.random(r185_5.stateAnimations[r185_3.currentState].frameTime[1] * 100, r185_5.stateAnimations[r185_3.currentState].frameTime[2] * 100)
                    r185_3.animFrameTime = r185_6 / 100
                end
                if r185_3.animTimer == nil then
                    r185_3.animTimer = r185_3.animFrameTime
                end
                local r185_7 = r185_3.animTimer
                r185_3.animTimer = r185_7 - p185_0
                if r185_3.idleTimer ~= nil then
                    local r185_8 = r185_3.idleTimer
                    r185_3.idleTimer = r185_8 - p185_0
                end
                if r185_3.animTimer < 0 then
                    local r185_9 = r185_3.animFrame
                    r185_3.animFrame = r185_9 + 1
                    local r185_10 = _G.math.random(r185_5.stateAnimations[r185_3.currentState].frameTime[1] * 100, r185_5.stateAnimations[r185_3.currentState].frameTime[2] * 100)
                    r185_3.animTimer = r185_10 / 100
                    local r185_11 = r185_5.stateAnimations[r185_3.currentState]
                    if r185_11.sprites[r185_3.currentSubAnimation] ~= nil and #r185_5.stateAnimations[r185_3.currentState].sprites[r185_3.currentSubAnimation] < r185_3.animFrame then
                        r185_3.animFrame = 1
                        if r185_3.idleTimer < 0 and r185_3.currentSubAnimation == 1 and r185_5.stateAnimations[r185_3.currentState].defaultAnim == true and #r185_5.stateAnimations[r185_3.currentState].sprites > 1 then
                            local r185_12 = r185_5.stateAnimations[r185_3.currentState]
                            r185_3.currentSubAnimation = _G.math.random(2, #r185_12.sprites)
                            if r185_5.stateAnimations[r185_3.currentState].sprites[r185_3.currentSubAnimation].sound ~= nil then
                                local r185_13 = res.playAudio
                                local r185_14 = r185_5.stateAnimations[r185_3.currentState]
                                local r185_15 = r185_14.sprites[r185_3.currentSubAnimation]
                                r185_13(r185_15.sound)
                                local r185_16 = _G.math.random(r185_5.stateAnimations[r185_3.currentState].idleTime[1] * 100, r185_5.stateAnimations[r185_3.currentState].idleTime[2] * 100)
                                r185_3.idleTimer = r185_16 / 100
                            end
                        else
                            local r185_17 = r185_3.currentSubAnimation
                            if r185_17 > 1 then
                                r185_3.currentSubAnimation = 1
                                local r185_18 = r185_5.stateAnimations[r185_3.currentState]
                                if r185_18.idleTime ~= nil then
                                    local r185_19 = _G.math.random(r185_5.stateAnimations[r185_3.currentState].idleTime[1] * 100, r185_5.stateAnimations[r185_3.currentState].idleTime[2] * 100)
                                    r185_3.idleTimer = r185_19 / 100
                                end
                            end
                        end
                    end
                    if not (r185_5.stateAnimations[r185_3.currentState] == nil or r185_5.stateAnimations[r185_3.currentState].sprites[r185_3.currentSubAnimation] == nil) then
                        local r185_20 = r185_5.stateAnimations[r185_3.currentState]
                        local r185_21 = r185_20.sprites[r185_3.currentSubAnimation]
                        setSprite(r185_3.name, r185_21[r185_3.animFrame])
                    end
                    local r185_22 = r185_5.stateAnimations[r185_3.currentState]
                    if r185_22.sound ~= nil then
                        local r185_23 = r185_5.stateAnimations[r185_3.currentState]
                        if r185_23.sound.playSoundsInOrder then
                            local r185_24 = r185_5.stateAnimations[r185_3.currentState]
                            local r185_25 = audioGroups[r185_24.sound.name]
                            r185_3.currentSoundIndex = r185_3.currentSoundIndex and r185_3.currentSoundIndex + 1 or 1
                            r185_3.currentSoundIndex = r185_3.currentSoundIndex <= #r185_25 and r185_3.currentSoundIndex or 1
                            if r185_3.currentSoundIndex % 2 == r185_3.animFrame % 2 then
                                local r185_26 = r185_3.currentSoundIndex
                                r185_3.currentSoundIndex = r185_26 + 1
                                local r185_27 = r185_3.currentSoundIndex
                                if #r185_25 < r185_27 then
                                    local r185_28 = r185_3.currentSoundIndex
                                    r185_3.currentSoundIndex = r185_28 - 2
                                end
                            end
                            r185_3.currentSound = r185_25[r185_3.currentSoundIndex]
                        else
                            local r185_29 = r185_5.stateAnimations[r185_3.currentState]
                            r185_3.currentSound = r185_29.sound.name
                        end
                        res.playAudio(r185_3.currentSound)
                    end
                end
            end
        elseif r185_4 and r185_5.animations ~= nil and r185_3.currentAnimation ~= nil and r185_3.currentSubAnimation ~= nil and r185_3.disableAnimations ~= true then
            local r185_30 = r185_3.animTimer
            r185_3.animTimer = r185_30 - p185_0
            if r185_3.idleTimer ~= nil then
                local r185_31 = r185_3.idleTimer
                r185_3.idleTimer = r185_31 - p185_0
            end
            if r185_3.animTimer < 0 then
                local r185_32 = r185_3.animFrame
                r185_3.animFrame = r185_32 + 1
                r185_3.animTimer = r185_3.animFrameTime
                if #r185_5.animations[r185_3.currentAnimation].sprites[r185_3.currentSubAnimation] < r185_3.animFrame then
                    r185_3.animFrame = 1
                    if r185_3.idleTimer < 0 and r185_3.currentSubAnimation == 1 and r185_5.animations[r185_3.currentAnimation].defaultAnim == true and #r185_5.animations[r185_3.currentAnimation].sprites > 1 then
                        local r185_33 = r185_5.animations[r185_3.currentAnimation]
                        r185_3.currentSubAnimation = _G.math.random(2, #r185_33.sprites)
                        if r185_5.animations[r185_3.currentAnimation].sprites[r185_3.currentSubAnimation].sound ~= nil then
                            local r185_34 = playAudio
                            local r185_35 = r185_5.animations[r185_3.currentAnimation]
                            local r185_36 = r185_35.sprites[r185_3.currentSubAnimation]
                            r185_34(r185_36.sound)
                        end
                    else
                        local r185_37 = r185_3.currentSubAnimation
                        if r185_37 > 1 then
                            r185_3.currentSubAnimation = 1
                            local r185_38 = r185_5.animations[r185_3.currentAnimation]
                            if r185_38.idleTime ~= nil then
                                local r185_39 = _G.math.random(r185_5.animations[r185_3.currentAnimation].idleTime[1] * 100, r185_5.animations[r185_3.currentAnimation].idleTime[2] * 100)
                                r185_3.idleTimer = r185_39 / 100
                            end
                        end
                    end
                end
                local r185_40 = r185_5.animations[r185_3.currentAnimation]
                local r185_41 = r185_40.sprites[r185_3.currentSubAnimation]
                setSprite(r185_3.name, r185_41[r185_3.animFrame])
                if r185_3.currentSound ~= nil and r185_5.animations[r185_3.currentAnimation].sound.loop == true and res.isAudioPlaying(r185_3.currentSound) ~= true then
                    r185_3.currentSound = playAudio(r185_5.animations[r185_3.currentAnimation].sound.name)
                end
            end
        end
    end
    for r185_42, r185_43 in _G.pairs(birds) do
        if r185_43.shot == true then
            if _G.type(r185_43.sprite) == "table" then
                local r185_44 = r185_43.animTimer
                r185_43.animTimer = r185_44 - p185_0
                if r185_43.animTimer < 0 then
                    local r185_45 = r185_43.animFrame
                    r185_43.animFrame = r185_45 + 1
                    local r185_46 = r185_43.animFrame
                    if #r185_43.sprite.frames < r185_46 then
                        r185_43.animFrame = 1
                        local r185_47, r185_48 = physicsToWorldTransform(r185_43.x, r185_43.y)
                        local r185_49 = screen.x - r185_47
                        local r185_50 = vLength(r185_49, screen.y - r185_48)
                        local r185_51 = 1 - r185_50 / (10000 * slingshotScale)
                        if r185_51 > 0 then
                            local r185_52 = blockTable.blocks[r185_43.definition]
                            playAudio(r185_52.sounds.specialLoop, r185_51)
                        end
                    end
                    r185_43.animTimer = r185_43.sprite.frameTime
                    setSprite(r185_43.name, r185_43.sprite.frames[r185_43.animFrame])
                end
            end
        else
            local r185_53 = r185_43.animTimer
            r185_43.animTimer = r185_53 - p185_0
            if r185_43.animTimer < 0 then
                if r185_43.animOn == true then
                    local r185_54 = _G.math.random(10, 150)
                    r185_43.animTimer = r185_54 / 100
                    r185_43.animOn = false
                else
                    local r185_55 = _G.math.random(10, 20)
                    r185_43.animTimer = r185_55 / 100
                    local r185_56 = _G.math.random(1, 4)
                    local r185_57
                    if r185_56 == 1 then
                        local r185_58 = blockTable.blocks[r185_43.definition]
                        r185_57 = r185_58.spriteYell
                        local r185_59, r185_60 = physicsToWorldTransform(levelStartPosition.x, levelStartPosition.y)
                        local r185_61 = screen.x - r185_59
                        local r185_62 = vLength(r185_61, screen.y - r185_60)
                        local r185_63 = 1 - r185_62 / (1000 * slingshotScale)
                        if r185_63 > 0 and hasBirdsLeftInSlingShot() then
                            local r185_64 = getObjectDefinition(r185_43.name)
                            if r185_64.sounds.idle then
                                res.playAudio(r185_64.sounds.idle, r185_63)
                            else
                                playAudio("bird_misc", r185_63)
                            end
                        end
                    else
                        local r185_65 = blockTable.blocks[r185_43.definition]
                        r185_57 = r185_65.spriteBlink
                    end
                    if r185_57 ~= nil then
                        setSprite(r185_43.name, r185_57)
                    end
                    r185_43.animOn = true
                end
            end
        end
    end
end

-- line 5187-5206
-- proto#186 params=1 locals=11 upvalues=0 vararg=false
function updateThemeSpriteAnimations(p186_0)
    for r186_0, r186_1 in _G.pairs(themeSpriteObjects) do
        local r186_2 = blockTable.blocks[r186_1.definition]
        if r186_2 ~= nil and r186_2.animations ~= nil and r186_1.currentAnimation ~= nil and r186_1.currentSubAnimation ~= nil then
            local r186_3 = r186_1.animTimer
            r186_1.animTimer = r186_3 - p186_0
            if r186_1.animTimer < 0 then
                local r186_4 = r186_1.animFrame
                r186_1.animFrame = r186_4 + 1
                r186_1.animTimer = r186_1.animFrameTime
                if #r186_2.animations[r186_1.currentAnimation].sprites[r186_1.currentSubAnimation] < r186_1.animFrame then
                    r186_1.animFrame = 1
                end
                local r186_5 = r186_2.animations[r186_1.currentAnimation]
                local r186_6 = r186_5.sprites[r186_1.currentSubAnimation]
                setThemeSprite(r186_1.name, r186_6[r186_1.animFrame], r186_1.layer)
            end
        end
    end
end

-- line 5208-5217
-- proto#187 params=8 locals=11 upvalues=0 vararg=false
function drawFakeCircle(p187_0, p187_1, p187_2, p187_3, p187_4, p187_5, p187_6, p187_7)
    for r187_0 = 1, p187_7 do
        local r187_1 = _G.math.cos(_G.math.pi * 2 / p187_7 * r187_0)
        local r187_2 = p187_4 + r187_1 * p187_6
        local r187_3 = _G.math.sin(_G.math.pi * 2 / p187_7 * r187_0)
        local r187_4 = p187_5 + r187_3 * p187_6
        local r187_5 = print
        local r187_6 = "FACE CIRCLE OUT!!!!" .. p187_4 .. "," .. p187_5 .. "," .. p187_6
        r187_5(r187_6)
        drawLine2D(p187_4, p187_5, r187_2, r187_4, 1, p187_0, p187_1, p187_2, p187_3)
    end
end

-- line 5219-5226
-- proto#188 params=0 locals=1 upvalues=0 vararg=false
function isRewardPageShowing()
    if menuManager ~= nil then
        local r188_0 = menuManager:getRoot()
        if r188_0 ~= nil then
            if r188_0:getChild("EpisodeRewardPage") == nil then
                return false
            end
            return true
        end
    end
end

-- line 5228-5235
-- proto#189 params=0 locals=1 upvalues=0 vararg=false
function isMightyEaglePurchasePageShowing()
    if menuManager ~= nil then
        local r189_0 = menuManager:getRoot()
        if r189_0 ~= nil then
            if r189_0:getChild("MEPage") == nil then
                return false
            end
            return true
        end
    end
end

-- line 5237-5245
-- proto#190 params=0 locals=1 upvalues=0 vararg=false
function isEaglePurchaseSpinnerPageShowing()
    if menuManager ~= nil then
        local r190_0 = menuManager:getRoot()
        if r190_0 ~= nil then
            if r190_0:getChild("eaglePurchasePage") == nil then
                return false
            end
            return true
        end
    end
end

-- line 5247-5298
-- proto#191 params=0 locals=21 upvalues=0 vararg=false
function repositionScreen()
    local r191_0 = objects.castleCameraData[deviceModel]
    local r191_1 = objects.birdCameraData[deviceModel]
    if worldScale < minWorldScale then
        worldScale = minWorldScale
        setWorldScale(worldScale)
    end
    local r191_2 = screen.x + screenWidth * 0.5 / worldScale
    local r191_3 = screen.x - screenWidth * 0.5 / worldScale
    local r191_4 = screen.y + screenHeight * 0.5 / worldScale
    local r191_5 = screen.y - screenHeight * 0.5 / worldScale
    if g_useLevelLimits and rightLimitWorld < r191_2 then
        screen.x = screen.x + (rightLimitWorld - r191_2)
    end
    if g_useLevelLimits and r191_3 < leftLimitWorld then
        screen.x = screen.x + (leftLimitWorld - r191_3)
    end
    if g_useLevelLimits and bottomLimitWorld < r191_4 then
        screen.y = screen.y + (bottomLimitWorld - r191_4)
    end
    if g_useLevelLimits and r191_5 < topLimitWorld then
        screen.y = screen.y + (topLimitWorld - r191_5)
    end
    local r191_6 = r191_2 - r191_3
    local r191_7 = r191_4 - r191_5
    if maxLevelWidthWorld < r191_6 then
        screen.x = (leftLimitWorld + rightLimitWorld) * 0.5
    end
    if maxLevelHeightWorld < r191_7 then
        screen.y = (bottomLimitWorld + topLimitWorld) * 0.5
    end
    if g_showCameraDebugData then
        g_currentCameraVisualization.x = screen.x
        g_currentCameraVisualization.y = screen.y
    end
    if cameraShakeOn then
        screen.x = screen.x + g_cameraShakePosition.x * worldScale / r191_0.sx
        screen.y = screen.y + g_cameraShakePosition.y * worldScale / r191_0.sx
    end
end

-- line 5300-5322
-- proto#192 params=6 locals=3 upvalues=0 vararg=false
function distancePointToLineSegment(p192_0, p192_1, p192_2, p192_3, p192_4, p192_5)
    local r192_0 = (p192_2 - p192_0) * (p192_2 - p192_0) + (p192_3 - p192_1) * (p192_3 - p192_1)
    if r192_0 == 0 then
        return vLength(p192_4 - p192_0, p192_5 - p192_1), 0.5
    end
    local r192_1 = dotProduct(p192_4 - p192_0, p192_5 - p192_1, p192_2 - p192_0, p192_3 - p192_1)
    local r192_2 = r192_1 / r192_0
    if r192_2 < 0 then
        return vLength(p192_4 - p192_0, p192_5 - p192_1), r192_2
    end
    if r192_2 > 1 then
        return vLength(p192_4 - p192_2, p192_5 - p192_3), r192_2
    end
    return vLength(p192_4 - (p192_0 + r192_2 * (p192_2 - p192_0)), p192_5 - (p192_1 + r192_2 * (p192_3 - p192_1))), r192_2
end

-- line 5327-5334
-- proto#193 params=2 locals=8 upvalues=0 vararg=false
function setPositions(p193_0, p193_1)
    for r193_0, r193_1 in _G.pairs(selectedObjects) do
        local r193_2 = r193_1.x + p193_0 * physicsScale
        setPosition(r193_1.name, r193_2, r193_1.y + p193_1 * physicsScale)
        setSleeping(r193_1.name, false)
    end
    levelSaved = false
end

-- line 5337-5348
-- proto#194 params=0 locals=14 upvalues=0 vararg=false
function updateScale()
    if oldScale ~= worldScale then
        local r194_0 = ((cursor.y / oldScale + screen.top) * worldScale - cursor.y) / worldScale
        screen.x = ((cursor.x / oldScale + screen.left) * worldScale - cursor.x) / worldScale + screenWidth * 0.5 / worldScale
        screen.y = r194_0 + screenHeight * 0.5 / worldScale
    end
    oldScale = worldScale
end

-- line 5350-5357
-- proto#195 params=1 locals=3 upvalues=0 vararg=false
function checkJointsForObject(p195_0)
    for r195_0, r195_1 in _G.pairs(objects.joints) do
        if r195_1.end1 == p195_0 then
            return r195_1
        end
        if r195_1.end2 == p195_0 then
            return r195_1
        end
    end
    return false
end

-- line 5359-5436
-- proto#196 params=4 locals=40 upvalues=0 vararg=false
function selectObjectAnimation(p196_0, p196_1, p196_2, p196_3)
    local r196_0 = objects.world[p196_0]
    if r196_0.destroyed ~= true then
        local r196_1 = blockTable.blocks[r196_0.definition]
        anim = r196_0.defaultAnim
        if not (r196_1.animations == nil or r196_0.currentAnimation == r196_0.laughAnim or r196_0.currentAnimation == r196_0.laughJointedAnim or r196_1.useDamageAnimations) then
            local r196_2 = false
            local r196_3 = 1
            local r196_4 = r196_1.animations
            for r196_5 = r196_3, #r196_4 do
                v = r196_1.animations[r196_5]
                for r196_6, r196_7 in _G.pairs(v.triggers) do
                    local r196_8 = r196_0.strength / r196_1.strength * 100
                    if (r196_7.minVel == nil or r196_7.minVel <= p196_1) and (r196_7.maxVel == nil or r196_7.maxVel >= p196_1) and (r196_7.minAngle == nil or r196_7.minAngle <= p196_2) and (r196_7.maxAngle == nil or r196_7.maxAngle >= p196_2) and (r196_7.minStrength == nil or r196_7.minStrength <= r196_8) and (r196_7.maxStrength == nil or r196_7.maxStrength >= r196_8) and not (r196_7.jointed and checkJointsForObject(p196_0) == false) then
                        anim = r196_5
                        r196_2 = true
                        break
                    end
                end
                if r196_2 then
                    break
                end
            end
            if anim ~= nil and r196_0.currentAnimation ~= anim then
                if r196_0.nextAnimation == anim or overrideThreshold == true then
                    local r196_9 = r196_0.animThresholdTimer
                    r196_0.animThresholdTimer = r196_9 - p196_3
                    if r196_0.animThresholdTimer <= 0 or overrideThreshold == true then
                        r196_0.currentAnimation = anim
                        local r196_10 = r196_1.animations[anim]
                        if r196_10.defaultAnim == true then
                            r196_0.currentSubAnimation = 1
                            local r196_11 = r196_1.animations[anim]
                            if r196_11.idleTime ~= nil then
                                local r196_12 = _G.math.random(r196_1.animations[anim].idleTime[1] * 100, r196_1.animations[anim].idleTime[2] * 100)
                                r196_0.idleTimer = r196_12 / 100
                            end
                        else
                            local r196_13 = r196_1.animations[anim]
                            r196_0.currentSubAnimation = _G.math.random(1, #r196_13.sprites)
                        end
                        r196_0.animFrame = 1
                        local r196_14 = _G.math.random(r196_1.animations[anim].frameTime[1] * 100, r196_1.animations[anim].frameTime[2] * 100)
                        r196_0.animFrameTime = r196_14 / 100
                        local r196_15 = r196_1.animations[anim]
                        if r196_15.disableRotation == true then
                            r196_0.disableRotation = true
                            setObjectParameter(p196_0, 10, 1)
                        else
                            r196_0.disableRotation = nil
                            setObjectParameter(p196_0, 10, 0)
                        end
                        local r196_16 = r196_1.animations[anim]
                        if r196_16.fatal == true then
                            r196_0.strength = 0.10000000149011612
                        end
                        local r196_17 = r196_1.animations[anim]
                        if r196_17.destroyJoints == true then
                            removeJointsFromObject(p196_0)
                        end
                        if r196_0.currentSound ~= nil then
                            _G.res.stopAudio(r196_0.currentSound)
                            r196_0.currentSound = nil
                        end
                        local r196_18 = r196_1.animations[anim]
                        if r196_18.sound ~= nil then
                            r196_0.currentSound = getAudioName(r196_1.animations[anim].sound.name)
                            res.playAudio(r196_0.currentSound)
                        end
                    end
                else
                    r196_0.nextAnimation = anim
                    local r196_19 = _G.math.random(r196_1.animations[anim].thresholdTime[1] * 100, r196_1.animations[anim].thresholdTime[2] * 100)
                    r196_0.animThresholdTimer = r196_19 / 100
                end
            end
        end
    end
end

-- line 5438-5500
-- proto#197 params=2 locals=46 upvalues=0 vararg=false
function setAnimation(p197_0, p197_1)
    local r197_0 = objects.world[p197_0]
    local r197_1 = blockTable.blocks[r197_0.definition]
    if r197_1.useStateAnimations then
        r197_0.currentAnimation = p197_1
        local r197_2 = r197_1.stateAnimations[p197_1]
        if r197_2.defaultAnim == true then
            r197_0.currentSubAnimation = 1
            local r197_3 = r197_1.stateAnimations[p197_1]
            if r197_3.idleTime ~= nil then
                local r197_4 = _G.math.random(r197_1.stateAnimations[p197_1].idleTime[1] * 100, r197_1.stateAnimations[p197_1].idleTime[2] * 100)
                r197_0.idleTimer = r197_4 / 100
            end
        else
            r197_0.currentSubAnimation = _G.math.random(1, #r197_1.stateAnimations[p197_1].sprites)
        end
        r197_0.animFrame = 1
        local r197_5 = _G.math.random(r197_1.stateAnimations[p197_1].frameTime[1] * 100, r197_1.stateAnimations[p197_1].frameTime[2] * 100)
        r197_0.animFrameTime = r197_5 / 100
        local r197_6 = r197_1.stateAnimations[p197_1]
        if r197_6.disableRotation == true then
            r197_0.disableRotation = true
            setObjectParameter(p197_0, 10, 1)
        else
            r197_0.disableRotation = nil
            setObjectParameter(p197_0, 10, 0)
        end
        if r197_0.currentSound ~= nil then
            _G.res.stopAudio(r197_0.currentSound)
            r197_0.currentSound = nil
        end
        local r197_7 = r197_1.stateAnimations[p197_1]
        if r197_7.sound ~= nil then
            r197_0.currentSound = res.playAudio(r197_1.stateAnimations[p197_1].sound.name)
        end
    elseif r197_1.animations ~= nil and r197_1.animations[p197_1] ~= nil then
        r197_0.currentAnimation = p197_1
        local r197_8 = r197_1.animations[p197_1]
        if r197_8.defaultAnim == true then
            r197_0.currentSubAnimation = 1
            local r197_9 = r197_1.animations[p197_1]
            if r197_9.idleTime ~= nil then
                local r197_10 = _G.math.random(r197_1.animations[p197_1].idleTime[1] * 100, r197_1.animations[p197_1].idleTime[2] * 100)
                r197_0.idleTimer = r197_10 / 100
            end
        else
            r197_0.currentSubAnimation = _G.math.random(1, #r197_1.animations[p197_1].sprites)
        end
        r197_0.animFrame = 1
        local r197_11 = _G.math.random(r197_1.animations[p197_1].frameTime[1] * 100, r197_1.animations[p197_1].frameTime[2] * 100)
        r197_0.animFrameTime = r197_11 / 100
        local r197_12 = r197_1.animations[p197_1]
        if r197_12.disableRotation == true then
            r197_0.disableRotation = true
            setObjectParameter(p197_0, 10, 1)
        else
            r197_0.disableRotation = nil
            setObjectParameter(p197_0, 10, 0)
        end
        if r197_0.currentSound ~= nil then
            _G.res.stopAudio(r197_0.currentSound)
            r197_0.currentSound = nil
        end
        local r197_13 = r197_1.animations[p197_1]
        if r197_13.sound ~= nil then
            r197_0.currentSound = res.playAudio(r197_1.animations[p197_1].sound.name)
        end
    end
end

-- line 5502-5515
-- proto#198 params=2 locals=4 upvalues=0 vararg=false
function setAnimationByName(p198_0, p198_1)
    local r198_0 = objects.world[p198_0]
    local r198_1 = blockTable.blocks[r198_0.definition]
    if r198_1.animations ~= nil then
        local r198_2 = 1
        local r198_3 = r198_1.animations
        for r198_4 = r198_2, #r198_3 do
            local r198_5 = r198_1.animations[r198_4]
            if r198_5.name == p198_1 then
                setAnimation(p198_0, r198_4)
                return
            end
        end
    end
end

-- line 5517-5544
-- proto#199 params=1 locals=30 upvalues=0 vararg=false
function startAnimations(p199_0)
    local r199_0 = getObjectDefinition(p199_0)
    if r199_0.animations ~= nil then
        local r199_1 = 1
        objects.world[p199_0].defaultAnim = r199_1
        local r199_2 = r199_0.animations[r199_1]
        if r199_2.frameTime ~= nil then
            objects.world[p199_0].currentAnimation = r199_1
            objects.world[p199_0].currentSubAnimation = 1
            local r199_3 = r199_0.animations[r199_1]
            if r199_3.idleTime ~= nil then
                local r199_4 = objects.world[p199_0]
                local r199_5 = _G.math.random(r199_0.animations[r199_1].idleTime[1] * 100, r199_0.animations[r199_1].idleTime[2] * 100)
                r199_4.idleTimer = r199_5 / 100
            end
            local r199_6 = r199_0.animations[r199_1].sprites[objects.world[p199_0].currentSubAnimation]
            objects.world[p199_0].animFrame = _G.math.random(1, #r199_6)
            local r199_7 = objects.world[p199_0]
            local r199_8 = _G.math.random(r199_0.animations[r199_1].frameTime[1] * 100, r199_0.animations[r199_1].frameTime[2] * 100)
            r199_7.animFrameTime = r199_8 / 100
            objects.world[p199_0].disableRotation = r199_0.animations[r199_1].disableRotation
            local r199_9 = objects.world[p199_0]
            if r199_9.disableRotation == true then
                setObjectParameter(p199_0, 10, 1)
            else
                setObjectParameter(p199_0, 10, 0)
            end
        end
        animatedObjects[p199_0] = objects.world[p199_0]
        setObjectParameter(p199_0, 13, 1)
    end
end

-- line 5547-5691
-- proto#200 params=10 locals=62 upvalues=0 vararg=false
function blockCollision(p200_0, p200_1, p200_2, p200_3, p200_4, p200_5, p200_6, p200_7, p200_8, p200_9)
    local r200_0, r200_1, r200_2 = objects.world[p200_0], objects.world[p200_1], false
    local r200_3 = false
    local r200_4 = blockTable.blocks[r200_0.definition]
    if r200_4.stopAnimationsAfterCollision then
        objects.animatedObjects[p200_0] = nil
    end
    local r200_5 = blockTable.blocks[r200_1.definition]
    if r200_5.stopAnimationsAfterCollision then
        objects.animatedObjects[p200_1] = nil
    end
    if r200_0.onCollisionEnter ~= nil then
        fireAction(r200_0.onCollisionEnter, {
            name = p200_0,
            obj = r200_0,
            other = p200_1,
            force = p200_2,
            wasDamageDone = p200_3,
            dot = p200_4,
            resultDamage = p200_5,
            collisionPointX = p200_6,
            collisionPointY = p200_7,
            collisionNormalX = p200_8,
            collisionNormalY = p200_9
        }, "onCollisionEnter")
        local r200_6 = actions[r200_0.onCollisionEnter]
        if r200_6.params.continueExec == false then
            return
        end
    end
    if r200_1.onCollisionEnter ~= nil then
        fireAction(r200_1.onCollisionEnter, {
            name = p200_1,
            obj = r200_1,
            other = p200_0,
            force = p200_2,
            wasDamageDone = p200_3,
            dot = p200_4,
            resultDamage = p200_5,
            collisionPointX = p200_6,
            collisionPointY = p200_7,
            collisionNormalX = p200_8,
            collisionNormalY = p200_9
        }, "onCollisionEnter")
        local r200_7 = actions[r200_1.onCollisionEnter]
        if r200_7.params.continueExec == false then
            return
        end
    end
    local r200_8 = blockTable.blocks[r200_0.definition]
    if r200_8.collisionSpawn ~= nil then
        local r200_9 = {
            definition = blockTable.blocks[r200_0.definition],
            x = r200_0.x,
            y = r200_0.y,
            angle = r200_0.angle
        }
        spawnList[#spawnList + 1] = {
            spawnedObjects = r200_9.definition.collisionSpawn,
            info = r200_9
        }
    end
    local r200_10 = blockTable.blocks[r200_1.definition]
    if r200_10.collisionSpawn ~= nil then
        local r200_11 = {
            definition = blockTable.blocks[r200_1.definition],
            x = r200_1.x,
            y = r200_1.y,
            angle = r200_1.angle
        }
        spawnList[#spawnList + 1] = {
            spawnedObjects = r200_11.definition.collisionSpawn,
            info = r200_11
        }
    end
    if p200_3 then
        cameraResetTimer = g_defaultCameraResetTime
        if p200_2 > 25 then
            local r200_12 = blockTable.blocks[r200_0.definition]
            local r200_13 = blockTable.blocks[r200_1.definition]
            local r200_14 = 0
            local r200_15 = r200_0.strength
            local r200_16 = r200_12.strength
            local r200_17
            if r200_15 == r200_16 then
                r200_17 = r200_14
            else
                r200_17 = r200_12.strength
            end
            local r200_18 = r200_1.strength
            local r200_19 = r200_13.strength
            local r200_20
            if r200_18 == r200_19 then
                r200_20 = r200_17
            else
                r200_20 = _G.math.max(r200_17, r200_13.strength)
            end
            local r200_21 = _G.math.min(r200_20, p200_2)
            local r200_22 = 3000000
            local r200_23 = _G.math.min(r200_21 * r200_21 * r200_21, r200_22)
            addCameraShake(cameraShakeModeSine, 150 * gameWorldScale, r200_23 / r200_22 * 5 * gameWorldScale, r200_23 / r200_22 * 0.5)
        end
        local r200_24 = getDamageSprite(r200_0, blockTable.blocks)
        local r200_25 = r200_24.sprite
        local r200_26 = r200_0.damageSprite
        r200_2 = r200_2
        if r200_25 ~= r200_26 then
            r200_0.damageSprite = r200_25
            r200_0.blinkSprite = r200_24.blink
            r200_0.smileSprite = r200_24.smile
            local r200_27 = getObjectDefinition(p200_0)
            if blockTable.materials[r200_27.material].damageSound ~= nil then
                local r200_28 = res.playAudio
                local r200_29 = blockTable.materials
                local r200_30 = getObjectDefinition(p200_0)
                local r200_31 = r200_29[r200_30.material]
                r200_28(r200_31.damageSound)
                r200_2 = true
            end
        end
        if not p200_4 then
            createDamageParticles(r200_1, blockTable.blocks, r200_1.strength + p200_5)
            updateDamageSprite(r200_1)
        end
        if r200_0.definition ~= "compound" then
            local r200_32 = getObjectDefinition(p200_0)
            local r200_33 = r200_32.damageParticles
            if r200_33 ~= nil then
                putParticles({
                    objectName = p200_0,
                    particles = r200_33,
                    amount = _G.math.ceil(p200_2 / 10)
                })
            end
        end
        if r200_1.definition ~= "compound" then
            local r200_34 = getObjectDefinition(p200_1)
            damageParticles = r200_34.damageParticles
            if damageParticles ~= nil then
                putParticles({
                    objectName = p200_1,
                    particles = damageParticles,
                    amount = _G.math.ceil(p200_2 / 10)
                })
            end
        end
        if r200_0.levelGoal and r200_0.strength / blockTable.blocks[r200_0.definition].strength < (g_levelGoalDamageStatePercent or 0.5) then
            setPigDamageState(r200_0)
        end
        if r200_1.levelGoal and r200_1.strength / blockTable.blocks[r200_1.definition].strength < (g_levelGoalDamageStatePercent or 0.5) then
            setPigDamageState(r200_1)
        end
    end
    if collisionSoundForceThreshold < p200_2 then
        local r200_35, r200_36 = nil, nil
        local r200_37, r200_38 = r200_0.definition, r200_35
        if r200_37 ~= "compound" then
            local r200_39, r200_40
            r200_38 = r200_39[r200_40]
        end
        local r200_41, r200_42 = r200_1.definition, r200_36
        if r200_41 ~= "compound" then
            local r200_43, r200_44
            r200_42 = r200_43[r200_44]
        end
        if r200_2 ~= true and r200_38 ~= nil then
            local r200_45 = getObjectDefinition(p200_0)
            if blockTable.materials[r200_45.material].collisionSound ~= nil then
                local r200_46 = blockTable.materials
                local r200_47 = getObjectDefinition(p200_0)
                local r200_48 = r200_46[r200_47.material]
                local r200_49 = getObjectDefinition(p200_0)
                res.playAudio(r200_49.collisionSound or r200_48.collisionSound)
            end
        end
        if r200_3 ~= true and r200_42 ~= nil and r200_42 ~= r200_38 then
            local r200_50 = getObjectDefinition(p200_1)
            if blockTable.materials[r200_50.material].collisionSound ~= nil then
                local r200_51 = blockTable.materials
                local r200_52 = getObjectDefinition(p200_1)
                local r200_53 = r200_51[r200_52.material]
                local r200_54 = getObjectDefinition(p200_1)
                res.playAudio(r200_54.collisionSound or r200_53.collisionSound)
            end
        end
        checkTwoWayLevelGoalPopAchievement(r200_0, r200_1, levelName)
    end
end

-- line 5693-5701
-- proto#201 params=1 locals=0 upvalues=0 vararg=false
function setPigDamageState(p201_0)
    local r201_0 = p201_0.currentState
    if r201_0 and r201_0 ~= "damagedState" then
        createLevelGoalDamageParticles(p201_0, blockTable.blocks)
    end
    p201_0.inDamagedState = true
    setCurrentState(p201_0, "damagedState")
end

-- line 5703-5715
-- proto#202 params=1 locals=8 upvalues=0 vararg=false
function updateDamageSprite(p202_0)
    local r202_0 = getDamageSprite(p202_0, blockTable.blocks)
    local r202_1 = r202_0.sprite
    local r202_2 = p202_0.damageSprite
    if r202_1 ~= r202_2 then
        p202_0.damageSprite = r202_1
        p202_0.blinkSprite = r202_0.blink
        p202_0.smileSprite = r202_0.smile
        local r202_3 = getObjectDefinition(p202_0.name)
        if blockTable.materials[r202_3.material].damageSound ~= nil then
            obj2SoundPlayed = true
            local r202_4 = res.playAudio
            local r202_5 = blockTable.materials
            local r202_6 = getObjectDefinition(p202_0.name)
            local r202_7 = r202_5[r202_6.material]
            r202_4(r202_7.damageSound)
        end
    end
end

-- line 5727-5794
-- proto#203 params=1 locals=28 upvalues=0 vararg=false
function putParticles(p203_0)
    local r203_0, r203_1, r203_2, r203_3, r203_4, r203_5, r203_6, r203_7, r203_8, r203_9
    local r203_10, r203_11, r203_12 = p203_0.objectName, p203_0.x, p203_0.y
    local r203_13 = p203_0.amount or 1
    local r203_14 = p203_0.particles
    local r203_15 = p203_0.w or 1
    local r203_16 = p203_0.h or 1
    local r203_17 = p203_0.angle or 0
    local r203_18 = p203_0.screenX
    local r203_19
    local r203_20
    if r203_18 then
        r203_0, r203_1 = screenToPhysicsTransform(p203_0.screenX, p203_0.screenY)
        r203_2 = r203_1
        r203_19 = r203_0
        r203_20 = r203_2
    elseif p203_0.screenY then
        r203_0, r203_1 = screenToPhysicsTransform(p203_0.screenX, p203_0.screenY)
        r203_2 = r203_1
        r203_19 = r203_0
        r203_20 = r203_2
    else
        r203_19 = r203_11
        r203_20 = r203_12
    end
    if r203_18 then
        r203_20 = r203_2
    else
        local r203_21
        if r203_21 then
            r203_20 = r203_2
        else
            r203_20 = r203_12
        end
    end
    local r203_22 = p203_0.worldX
    local r203_23
    if r203_22 then
        r203_24, r203_3 = worldToPhysicsTransform(p203_0.worldX, p203_0.worldY)
        r203_23 = r203_3
    elseif p203_0.worldY then
        r203_24, r203_3 = worldToPhysicsTransform(p203_0.worldX, p203_0.worldY)
        r203_23 = r203_3
    else
        r203_23 = r203_20
    end
    if r203_22 then
        r203_23 = r203_4
    else
        local r203_25
        if r203_25 then
            r203_23 = r203_4
        else
            r203_23 = r203_20
        end
    end
    if not p203_0.layer then
        p203_0.layer = 0
    end
    if r203_10 then
        local r203_26 = objects.world[r203_10]
        if r203_26 == nil then
            return
        end
        r203_5 = r203_26.x
        r203_6 = r203_26.y
        if r203_26.radius == nil then
            local r203_27, r203_28 = physicsToWorldTransform(r203_26.width, r203_26.height)
            r203_8 = r203_28
            r203_7 = r203_27
        else
            local r203_29 = physicsToWorldTransform
            local r203_30 = r203_26.radius * 2
            local r203_31 = r203_26.radius
            local r203_32, r203_33 = r203_29(r203_30, r203_31 * 2)
            r203_8 = r203_33
            r203_7 = r203_32
        end
        r203_9 = getAngle(r203_10)
    end
    local r203_34 = _G.type(r203_14) ~= "table" and { r203_14 } or r203_14
    for r203_35, r203_36 in _G.pairs(r203_34) do
        local r203_37, r203_38 = physicsToWorldTransform(r203_5, r203_6)
        local r203_39 = particleTable.particles[r203_36]
        if r203_39 ~= nil then
            local r203_40
            if p203_0.useAmountInDefinition then
                local r203_41 = r203_39.amount
                if r203_41 then
                    r203_40 = r203_41
                else
                    r203_40 = r203_13
                end
            else
                r203_40 = r203_13
            end
            p203_0.definitionName = r203_36
            p203_0.amount = r203_40
            p203_0.x = r203_37
            p203_0.y = r203_38
            p203_0.w = r203_7
            p203_0.h = r203_8
            p203_0.angle = r203_9
            p203_0.mode = p203_0.layer
            _G.particles.native_addParticlesWithMode(p203_0)
        end
    end
end

-- line 5799-5808
-- proto#204 params=1 locals=0 upvalues=0 vararg=false
function destroyEmitter(p204_0)
    removeObject(p204_0.name)
    objects.world[p204_0.name] = nil
    p204_0.emitter = nil
    deadBlocks[p204_0.name] = nil
    if g_birdEmitterTargets then
        g_birdEmitterTargets[p204_0.name] = nil
    end
    removeUpdateCall(p204_0.name)
end

-- line 5811-5817
-- proto#205 params=1 locals=2 upvalues=0 vararg=false
function getObjectDefinition(p205_0)
    if objects.world[p205_0] == nil then
        print("getObjectDefinition () failed for " .. p205_0 .. [[
]])
        return
    end
    local r205_0 = blockTable.blocks
    local r205_1 = objects.world[p205_0]
    return r205_0[r205_1.definition]
end

-- line 5819-5830
-- proto#206 params=1 locals=4 upvalues=0 vararg=false
function changeBirdNumbers(p206_0)
    for r206_0, r206_1 in _G.pairs(birds) do
        if r206_1.controllable then
            if r206_1.startNumber <= p206_0 then
                removeBird(r206_1)
            else
                local r206_2 = r206_1.startNumber
                r206_1.startNumber = r206_2 - p206_0
            end
        end
    end
end

-- line 5832-5840
-- proto#207 params=0 locals=0 upvalues=0 vararg=false
function restartBirdOrder()
    currentBirdName = getNextBird(1)
    if currentBirdName == nil then
        changeBirdNumbers(1)
        restartBirdOrder()
    end
end

-- line 5842-5854
-- proto#208 params=1 locals=3 upvalues=0 vararg=false
function checkBirdNumbers(p208_0)
    for r208_0, r208_1 in _G.pairs(birds) do
        if r208_1.controllable and r208_1.startNumber <= p208_0 then
            return true
        end
    end
    return false
end

-- line 5856-5885
-- proto#209 params=0 locals=23 upvalues=0 vararg=false
function replaceSelectedBirdWithME()
    if currentBirdName ~= nil then
        numMightyEaglesCalled = numMightyEaglesCalled + 1
        local r209_0 = objects.world[currentBirdName]
        local r209_1 = objects.world[currentBirdName]
        local r209_2 = createObject(blockTable, "ME_BAIT", "ME_BAIT" .. numMightyEaglesCalled, r209_0.x, r209_1.y)
        setupTutorial(r209_2)
        local r209_3 = objects.world[r209_2]
        local r209_4 = objects.world[currentBirdName]
        r209_3.startNumber = r209_4.startNumber
        objects.world[r209_2].controlRadius = 5.5
        birds[r209_2] = objects.world[r209_2]
        local r209_5 = objects.world[currentBirdName]
        r209_5.ignoreTutorialPowerUsage = true
        destroyObject(currentBirdName, true)
        currentBirdName = r209_2
        eventManager:notify({ id = events.EID_NEXT_BIRD_READY })
        objects.world[r209_2].damageDone = 0
        local r209_6 = objects.world[r209_2]
        local r209_7 = _G.math.random(10, 30)
        r209_6.animTimer = r209_7 / 10
        local r209_8 = objects.world[r209_2]
        local r209_9 = _G.math.random(10, 30)
        r209_8.jumpTimer = r209_9 / 10
        menuManager:getRoot():updateMELeft()
        local r209_10 = objects.world[r209_2]
        if not (r209_10.originalPosX and objects.world[r209_2].originalPosY) then
            objects.world[r209_2].originalPosX = objects.world[r209_2].x
            objects.world[r209_2].originalPosY = objects.world[r209_2].y
        end
        local r209_11 = getNextBird(currentBirdIndex + 1)
        if r209_11 == nil or objects.world[r209_11].definition == "ME_BAIT" then
            disableME()
        end
    end
end

-- line 5887-5922
-- proto#210 params=0 locals=26 upvalues=0 vararg=false
function replaceNextBirdWithME()
    for r210_0 = 1, 7 do
        local r210_1 = getNextBird(currentBirdIndex + r210_0)
        if r210_1 ~= nil then
            local r210_2 = objects.world[r210_1]
            if r210_2.definition ~= "ME_BAIT" then
                numMightyEaglesCalled = numMightyEaglesCalled + 1
                local r210_3 = createObject(blockTable, "ME_BAIT", "ME_BAIT" .. numMightyEaglesCalled, objects.world[r210_1].x, objects.world[r210_1].y)
                setupTutorial(r210_3)
                objects.world[r210_3].startNumber = objects.world[r210_1].startNumber
                objects.world[r210_3].controlRadius = 5.5
                birds[r210_3] = objects.world[r210_3]
                birds[r210_1] = nil
                objects.world[r210_1].ignoreTutorialPowerUsage = true
                destroyObject(r210_1, true)
                objects.world[r210_3].controllable = true
                objects.world[r210_3].damageDone = 0
                local r210_4 = objects.world[r210_3]
                local r210_5 = _G.math.random(10, 30)
                r210_4.animTimer = r210_5 / 10
                local r210_6 = objects.world[r210_3]
                local r210_7 = _G.math.random(10, 30)
                r210_6.jumpTimer = r210_7 / 10
                setObjectParameter(r210_1, 2, 0)
                local r210_8 = objects.world[r210_3]
                if not (r210_8.originalPosX and objects.world[r210_3].originalPosY) then
                    objects.world[r210_3].originalPosX = objects.world[r210_3].x
                    objects.world[r210_3].originalPosY = objects.world[r210_3].y
                end
                local r210_9 = getNextBird(currentBirdIndex + r210_0 + 1)
                if not (r210_9 == nil or objects.world[r210_9].definition == "ME_BAIT") then
                    return
                end
                disableME()
            end
        end
    end
    disableME()
end

-- line 5924-5952
-- proto#211 params=0 locals=27 upvalues=0 vararg=false
function swapBirdWithME()
    for r211_0, r211_1 in _G.pairs(birds) do
        if r211_1.definition ~= "ME_BAIT" then
            local r211_2 = r211_0
            if r211_2 ~= nil then
                local r211_3 = createObject(blockTable, "ME_BAIT", "ME_BAIT" .. numMightyEaglesCalled, objects.world[r211_2].x, objects.world[r211_2].y)
                setupTutorial(r211_3)
                objects.world[r211_3].startNumber = objects.world[r211_2].startNumber
                objects.world[r211_3].controlRadius = 5.5
                birds[r211_3] = objects.world[r211_3]
                birds[r211_2] = nil
                destroyObject(r211_2, true)
                objects.world[r211_3].controllable = true
                objects.world[r211_3].damageDone = 0
                local r211_4 = objects.world[r211_3]
                local r211_5 = _G.math.random(10, 30)
                r211_4.animTimer = r211_5 / 10
                local r211_6 = objects.world[r211_3]
                local r211_7 = _G.math.random(10, 30)
                r211_6.jumpTimer = r211_7 / 10
                setObjectParameter(r211_2, 2, 0)
                local r211_8 = objects.world[r211_3]
                if not (r211_8.originalPosX and objects.world[r211_3].originalPosY) then
                    objects.world[r211_3].originalPosX = objects.world[r211_3].x
                    objects.world[r211_3].originalPosY = objects.world[r211_3].y
                end
            end
        end
    end
    disableME()
end

-- line 5955-5966
-- proto#212 params=1 locals=3 upvalues=0 vararg=false
function getNextBird(p212_0)
    for r212_0, r212_1 in _G.pairs(birds) do
        if r212_1.controllable and r212_1.startNumber == p212_0 then
            return r212_0
        end
    end
    return nil
end

-- line 5969-5995
-- proto#213 params=1 locals=3 upvalues=0 vararg=false
function checkLevelComplete(p213_0)
    if levelObjectives and levelObjectives.isObjectiveCompleted() then
        return true
    end
    timeWithoutLevelGoals = timeWithoutLevelGoals or 0
    g_scoreAddedTime = g_scoreAddedTime or 0
    g_scoreAddedTime = g_scoreAddedTime - p213_0
    for r213_0, r213_1 in _G.pairs(levelGoals) do
        if r213_1.levelGoal then
            return false
        end
    end
    if g_scoreAddedTime < 0 then
        return true
    end
    local r213_2 = timeWithoutLevelGoals
    if r213_2 > 12 then
        return true
    end
    return false
end

-- line 5997-6038
-- proto#214 params=0 locals=7 upvalues=0 vararg=false
function checkLevelFailed()
    if levelObjectives and levelObjectives.isObjectiveFailed() then
        return true
    end
    for r214_0, r214_1 in _G.pairs(birds) do
        if r214_1.controllable and r214_1.hasCollided ~= true then
            return false
        end
    end
    if timeWithoutLevelGoals ~= nil then
        local r214_2 = true
        for r214_3, r214_4 in _G.pairs(levelGoals) do
            local r214_5 = r214_4.levelGoal
            if r214_4.levelGoal then
                r214_2 = false
            end
        end
        if r214_2 then
            return false
        end
    end
    if g_scoreAddedTime ~= nil and g_scoreAddedTime < 0 then
        return true
    end
    return false
end

-- line 6040-6064
-- proto#215 params=2 locals=7 upvalues=0 vararg=false
function createLevelGoalDamageParticles(p215_0, p215_1)
    if p215_0.definition == nil or p215_0.definition == "" then
        return
    end
    if p215_1[p215_0.definition] == nil then
        return
    end
    local r215_0 = p215_1[p215_0.definition]
    if r215_0.stateAnimations == nil then
        return
    end
    local r215_1 = p215_1[p215_0.definition]
    if r215_1.stateAnimations.damagedState == nil then
        return
    end
    local r215_2 = p215_1[p215_0.definition]
    if r215_2.stateAnimations.damagedState.damageParticles == nil then
        return
    end
    local r215_3 = particleTable.particles
    local r215_4 = p215_1[p215_0.definition]
    local r215_5 = r215_4.stateAnimations.damagedState
    local r215_6 = r215_3[r215_5.damageParticles]
    local r215_7 = r215_6.amount
    putParticles({
        objectName = p215_0.name,
        particles = p215_1[p215_0.definition].stateAnimations.damagedState.damageParticles,
        amount = r215_7 or 10
    })
end

-- line 6066-6096
-- proto#216 params=3 locals=13 upvalues=0 vararg=false
function createDamageParticles(p216_0, p216_1, p216_2)
    if p216_0.definition == nil or p216_0.definition == "" then
        return
    end
    if p216_1[p216_0.definition] == nil then
        return
    end
    local r216_0 = p216_1[p216_0.definition]
    if r216_0.damageSprites == nil then
        return
    end
    if p216_0.strength == nil then
        return
    end
    local r216_1 = p216_0.strength
    local r216_2 = p216_1[p216_0.definition]
    local r216_3 = r216_2.strength
    local r216_4 = r216_1 / r216_3 * 100
    local r216_5 = p216_1[p216_0.definition]
    local r216_6 = r216_5.strength
    local r216_7 = p216_2 / r216_6 * 100
    local r216_8 = _G.pairs
    local r216_9 = p216_1[p216_0.definition]
    for r216_10, r216_11 in r216_8(r216_9.damageSprites) do
        if r216_11.min < r216_4 and r216_11.max >= r216_4 and r216_11.max < r216_7 and r216_11.particles then
            local r216_12 = particleTable.particles[r216_11.particles]
            local r216_13 = r216_12.amount
            putParticles({
                objectName = p216_0.name,
                particles = r216_11.particles,
                amount = r216_13 or 10
            })
            return
        end
    end
end

-- line 6100-6115
-- proto#217 params=3 locals=10 upvalues=0 vararg=false
function getAndSetDamageAnimationSprite(p217_0, p217_1, p217_2)
    local r217_0 = _G.math.max(0, p217_0.strength / p217_1.strength * 100)
    for r217_1, r217_2 in _G.pairs(p217_1.animations) do
        if r217_2.min <= r217_0 and r217_2.max >= r217_0 then
            local r217_3 = p217_0.currentAnimation
            if p217_0.currentAnimation < r217_1 then
                r217_3 = r217_1
            end
            p217_2.sprite = setObjectAnimation(p217_0, p217_1, r217_3)
            return p217_2
        end
    end
    return p217_2
end

-- line 6117-6175
-- proto#218 params=2 locals=11 upvalues=0 vararg=false
function getDamageSprite(p218_0, p218_1)
    local r218_0 = { sprite = p218_0.sprite, blink = p218_0.sprite, smile = p218_0.sprite }
    if p218_0.definition == nil or p218_0.definition == "" then
        return r218_0
    end
    if p218_1[p218_0.definition] == nil then
        return r218_0
    end
    local r218_1 = p218_1[p218_0.definition]
    if r218_1.useDamageAnimations then
        return getAndSetDamageAnimationSprite(p218_0, p218_1[p218_0.definition], r218_0)
    end
    local r218_2 = p218_1[p218_0.definition]
    if r218_2.damageSprites == nil then
        return r218_0
    end
    if p218_0.strength == nil then
        return r218_0
    end
    local r218_3
    if p218_0.initial_strength then
        r218_3 = p218_0.initial_strength
    else
        local r218_4 = p218_1[p218_0.definition]
        r218_3 = r218_4.strength
    end
    local r218_5 = p218_0.strength / r218_3 * 100
    local r218_6 = _G.pairs
    local r218_7 = p218_1[p218_0.definition]
    for r218_8, r218_9 in r218_6(r218_7.damageSprites) do
        if r218_9.min < r218_5 and r218_9.max >= r218_5 and p218_0.sprite ~= r218_9.sprite then
            setSprite(p218_0.name, r218_9.sprite)
            r218_0.sprite = r218_9.sprite
            r218_0.blink = r218_9.sprite
            r218_0.smile = r218_9.sprite
            if r218_9.blinkSprite ~= nil then
                r218_0.blink = r218_9.blinkSprite
            end
            if r218_9.smileSprite ~= nil then
                r218_0.smile = r218_9.smileSprite
            end
            local r218_10 = p218_1[p218_0.definition]
            if r218_10.onDamageStateChanged then
                local r218_11 = fireAction
                local r218_12 = p218_1[p218_0.definition]
                r218_11(r218_12.onDamageStateChanged, { name = p218_0.name }, "onDamageStateChanged")
            end
            return r218_0
        end
    end
    return r218_0
end

-- line 6177-6182
-- proto#219 params=7 locals=2 upvalues=0 vararg=false
function getDistanceFromOBBToPoint(p219_0, p219_1, p219_2, p219_3, p219_4, p219_5, p219_6)
    local r219_0 = getSquaredDistanceFromOBBToPoint(p219_0, p219_1, p219_2, p219_3, p219_4, p219_5, p219_6)
    return {
        distance = _G.math.sqrt(r219_0.distance),
        pointX = r219_0.pointX,
        pointY = r219_0.pointY
    }
end

-- line 6186-6234
-- proto#220 params=7 locals=51 upvalues=0 vararg=false
function getSquaredDistanceFromOBBToPoint(p220_0, p220_1, p220_2, p220_3, p220_4, p220_5, p220_6)
    local r220_0 = p220_5 - p220_0
    local r220_1 = p220_6 - p220_1
    local r220_2 = 0
    local r220_3 = {}
    local r220_4 = { p220_2 / 2, p220_3 / 2 }
    local r220_5 = p220_4
    local r220_6 = _G.math.cos(r220_5)
    local r220_7 = _G.math.sin(r220_5)
    local r220_8 = _G.math.cos(r220_5 + _G.math.pi * 0.5)
    local r220_9 = _G.math.sin(r220_5 + _G.math.pi * 0.5)
    local r220_10, r220_11 = vNormalize(r220_6, r220_7)
    local r220_12 = r220_11
    local r220_13 = r220_10
    local r220_14, r220_15 = vNormalize(r220_8, r220_9)
    local r220_16 = r220_15
    local r220_17 = r220_14
    local r220_18 = { x = r220_13, y = r220_12 }
    local r220_19 = { x = r220_17, y = r220_16 }
    local r220_20 = { r220_18, r220_19 }
    for r220_21 = 0, 1 do
        local r220_22 = r220_20[r220_21 + 1]
        local r220_23 = r220_20[r220_21 + 1]
        r220_3[r220_21 + 1] = dotProduct(r220_0, r220_1, r220_22.x, r220_23.y)
        if -r220_4[r220_21 + 1] > r220_3[r220_21 + 1] then
            local r220_24 = r220_3[r220_21 + 1] + r220_4[r220_21 + 1]
            r220_2 = r220_2 + r220_24 * r220_24
            r220_3[r220_21 + 1] = -r220_4[r220_21 + 1]
        else
            local r220_25 = r220_3[r220_21 + 1]
            if r220_4[r220_21 + 1] < r220_25 then
                local r220_26 = r220_3[r220_21 + 1] - r220_4[r220_21 + 1]
                r220_2 = r220_2 + r220_26 * r220_26
                r220_3[r220_21 + 1] = r220_4[r220_21 + 1]
            end
        end
    end
    local r220_27 = { x = p220_0, y = p220_1 }
    for r220_28 = 0, 1 do
        local r220_29 = r220_20[r220_28 + 1]
        r220_27.x = r220_27.x + r220_3[r220_28 + 1] * r220_29.x
        local r220_30 = r220_20[r220_28 + 1]
        r220_27.y = r220_27.y + r220_3[r220_28 + 1] * r220_30.y
    end
    return { distance = r220_2, pointX = r220_27.x, pointY = r220_27.y }
end

-- line 6236-6264
-- proto#221 params=1 locals=19 upvalues=0 vararg=false
function checkFreezingObjects(p221_0)
    local r221_0 = objects.world[p221_0]
    if not (freezingObjects == nil or freezingObjects.objects == nil) then
        for r221_1, r221_2 in _G.pairs(freezingObjects.objects) do
            if r221_1 == p221_0 then
                local r221_3 = worldToPhysicsTransform
                local r221_4 = res.getSpriteBounds
                local r221_5, r221_6 = r221_3(r221_4(r221_0.sprite))
                if particleTable.particles.lightBuff == nil then
                    return
                end
                local r221_7 = physicsToWorldTransform
                local r221_8 = r221_0.x
                local r221_9 = r221_2.icicle.x
                local r221_10 = r221_8 + r221_9
                local r221_11 = r221_0.y
                local r221_12 = r221_2.icicle.y
                local r221_13, r221_14 = r221_7(r221_10, r221_11 + r221_12)
                putParticles({
                    particles = "lightBuff",
                    amount = 5,
                    x = r221_13,
                    y = r221_14,
                    w = r221_5,
                    h = r221_6,
                    minVel = 150,
                    maxVel = 150,
                    minAngleEmitter = (r221_2.icicle.angle - _G.math.pi) * 180 / _G.math.pi,
                    maxAngleEmitter = r221_2.icicle.angle * 180 / _G.math.pi
                })
                local r221_15 = r221_2.x * r221_2.force
                applyImpulse(r221_1, r221_15, r221_2.y * r221_2.force, r221_2.pointX, r221_2.pointY)
                freezingObjects.objects[r221_1] = nil
            end
        end
    end
end

-- line 6266-6311
-- proto#222 params=2 locals=30 upvalues=0 vararg=false
function freezeObjects(p222_0, p222_1)
    local r222_0 = false
    for r222_1, r222_2 in _G.pairs(p222_0) do
        if r222_2.timer <= 0 and objects.world[r222_1] ~= nil then
            v = objects.world[r222_1]
            if v and v.levelGoal then
                v.sprite = v.spriteUnfreeze
                setSprite(r222_1, v.sprite)
                v.material = v.materialUnfreeze
                v.disableAnimations = false
                v.frozenFromBomb = false
            end
            local r222_3 = worldToPhysicsTransform
            local r222_4 = res.getSpriteBounds
            local r222_5, r222_6 = r222_3(r222_4(v.sprite))
            local r222_7 = particleTable.particles.lightBuff
            print("Adding particles lightBuff " .. r222_2.icicle.angle .. [[
]])
            if r222_7 == nil then
                return
            end
            local r222_8 = physicsToWorldTransform
            local r222_9 = v.x
            local r222_10 = r222_2.icicle.x
            local r222_11 = r222_9 + r222_10
            local r222_12 = v.y
            local r222_13 = r222_2.icicle.y
            local r222_14, r222_15 = r222_8(r222_11, r222_12 + r222_13)
            putParticles({
                particles = "lightBuff",
                amount = 5,
                x = r222_14,
                y = r222_15,
                w = r222_5,
                h = r222_6,
                minVel = 150,
                maxVel = 150,
                minAngleEmitter = (r222_2.icicle.angle - _G.math.pi) * 180 / _G.math.pi,
                maxAngleEmitter = r222_2.icicle.angle * 180 / _G.math.pi
            })
            local r222_16 = blockTable.blocks[v.definition]
            print("FREEZING " .. v.definition .. "material: " .. r222_16.material)
            local r222_17 = r222_2.x * r222_2.force
            applyImpulse(r222_1, r222_17, r222_2.y * r222_2.force, r222_2.pointX, r222_2.pointY)
            p222_0[r222_1] = nil
        else
            local r222_18 = r222_2.timer
            r222_2.timer = r222_18 - p222_1
            r222_0 = true
        end
    end
    return r222_0
end

-- line 6313-6370
-- proto#223 params=1 locals=48 upvalues=0 vararg=false
function freezePig(p223_0)
    local r223_0 = objects.world[p223_0]
    if r223_0 ~= nil then
        addEventCall("destroy", { name = p223_0 }, 1.5)
        r223_0.spriteUnfreeze = r223_0.sprite
        r223_0.materialUnfreeze = r223_0.material
        local r223_1 = blockTable.blocks[r223_0.definition]
        r223_0.sprite = r223_1.spriteFreeze
        r223_0.material = "glass"
        r223_0.disableAnimations = true
        setSprite(p223_0, r223_0.sprite)
        r223_0.enteredState = false
        setCurrentState(r223_0, "frozenState")
        local r223_2 = objects.world[p223_0]
        if not freezingObjects then
            freezingObjects = {
                timer = 5.949999809265137,
                x = r223_2.x,
                y = r223_2.y,
                objects = {},
                sx = 0.25,
                sy = 0.25
            }
        end
        putParticles({ objectName = r223_2.name, particles = "iceExplosion" })
        local r223_3
        local r223_4
        local r223_5, r223_6, r223_7, r223_8
        if r223_0.width == nil then
            if r223_0.radius == nil then
                local r223_9 = res.getSpriteBounds
                local r223_10 = blockTable.blocks[r223_0.definition]
                r223_5, r223_6 = r223_9(r223_10.sprite)
                r223_7, r223_8 = worldToPhysicsTransform(r223_5, r223_6)
                local r223_11 = r223_8
                r223_3 = r223_7
                r223_4 = r223_11
            else
                local r223_12 = r223_0.radius
                local r223_13 = r223_0.radius
                r223_3 = r223_12
                r223_4 = r223_13
            end
        elseif r223_0.height == nil then
            if r223_0.radius == nil then
                local r223_14 = res.getSpriteBounds
                local r223_15 = blockTable.blocks[r223_0.definition]
                r223_5, r223_6 = r223_14(r223_15.sprite)
                r223_7, r223_8 = worldToPhysicsTransform(r223_5, r223_6)
                local r223_16 = r223_8
                r223_3 = r223_7
                r223_4 = r223_16
            else
                local r223_17 = r223_0.radius
                local r223_18 = r223_0.radius
                r223_3 = r223_17
                r223_4 = r223_18
            end
        else
            local r223_19 = r223_0.width
            local r223_20 = r223_0.height
            r223_3 = r223_19
            r223_4 = r223_20
        end
        local r223_21 = getSquaredDistanceFromOBBToPoint(r223_0.x, r223_0.y, r223_3, r223_4, r223_0.angle, r223_2.x, r223_2.y)
        local r223_22 = _G.math.sqrt(r223_21.distance)
        local r223_23
        local r223_24
        if r223_22 == 0 then
            r223_23 = 0
            r223_24 = -1
        else
            local r223_25, r223_26 = vNormalize(r223_21.pointX - r223_0.x, r223_21.pointY - r223_0.y)
            r223_24 = r223_26
            r223_23 = r223_25
        end
        local r223_27 = _G.math.random(1, 3)
        local r223_28 = _G.math.random(1, 5)
        local r223_29, r223_30 = worldToPhysicsTransform(res.getSpriteBounds(r223_0.sprite))
        local r223_31 = r223_0.angle
        local r223_32 = _G.math.atan2(r223_23, r223_24)
        freezingObjects.objects[p223_0] = {
            force = 0,
            x = r223_23,
            y = r223_24,
            pointX = r223_21.pointX,
            pointY = r223_21.pointY,
            icicle = {
                sprite = "P_ICICLE_" .. _G.string.format("%d", r223_27),
                angle = r223_31,
                x = r223_23 * r223_29 * 0.25,
                y = r223_24 * r223_30 * 0.25
            },
            icicles = {},
            timer = _G.math.random()
        }
        for r223_33 = 1, r223_28 do
            local r223_34 = _G.math.random(1, 3)
            local r223_35 = _G.math.random()
            local r223_36 = _G.math.random()
            local r223_37 = blockTable.blocks[r223_0.definition].type == "polygon" and true or _G.math.random() > 0.5
            freezingObjects.objects[p223_0].icicles[r223_33] = {
                sprite = "P_ICICLE_" .. _G.string.format("%d", r223_34),
                angle = r223_31,
                dm = r223_35 * 0.4000000059604645 - r223_36 * 0.4000000059604645,
                side = r223_37
            }
        end
    end
end

-- line 6372-6504
-- proto#224 params=2 locals=86 upvalues=0 vararg=false
function spawnObjects(p224_0, p224_1)
    local r224_0 = 0
    for r224_1, r224_2 in _G.ipairs(p224_0) do
        local r224_3 = p224_1.definition
        local r224_4
        if r224_3.ignoreIncrement then
            local r224_5 = p224_1.angle
            r224_4 = -r224_5
        else
            r224_4 = -p224_1.angle + _G.math.pi * 2 * r224_0 / #p224_0
        end
        local r224_6 = { x = _G.math.sin(r224_4), y = _G.math.cos(r224_4) }
        local r224_7, r224_8 = vNormalize(r224_6.x, r224_6.y)
        r224_6.y = r224_8
        r224_6.x = r224_7
        local r224_9, r224_10 = p224_1.x, p224_1.y
        local r224_11 = p224_1.definition
        local r224_12
        local r224_13
        if r224_11.spawnPositions then
            local r224_14 = p224_1.definition
            local r224_15 = r224_14.spawnPositions[r224_1]
            if r224_15 then
                local r224_16, r224_17 = r224_15[1], r224_15[2]
                local r224_18 = r224_15[1]
                local r224_19 = r224_15[1]
                local r224_20 = r224_18 * r224_19
                local r224_21 = _G.math.sqrt(r224_20 + r224_15[2] * r224_15[2])
                local r224_22 = _G.math.cos(p224_1.angle)
                local r224_23 = r224_16 * r224_22
                local r224_24 = _G.math.sin(p224_1.angle)
                local r224_25 = r224_23 - r224_17 * r224_24
                local r224_26 = _G.math.sin(p224_1.angle)
                local r224_27 = r224_16 * r224_26
                local r224_28 = _G.math.cos(p224_1.angle)
                local r224_29 = r224_27 + r224_17 * r224_28
                local r224_30 = r224_9 + r224_25
                local r224_31 = r224_10 + r224_29
                local r224_32, r224_33 = vNormalize(r224_25, r224_29)
                r224_6.y = r224_33
                r224_6.x = r224_32
                r224_12 = r224_30
                r224_13 = r224_31
            else
                r224_12 = r224_9
                r224_13 = r224_10
            end
        else
            r224_12 = r224_9
            r224_13 = r224_10
        end
        local r224_34 = nil
        local r224_35 = p224_1.definition
        local r224_36
        if r224_35.spawnAngles then
            local r224_37 = p224_1.definition
            r224_36 = r224_37.spawnAngles[r224_1]
        else
            r224_36 = r224_34
        end
        local r224_38 = p224_1.definition
        local r224_39
        local r224_40
        if r224_38.spawnDistance then
            local r224_41 = r224_6.x
            local r224_42 = p224_1.definition.spawnDistance
            local r224_43 = r224_12 + r224_41 * r224_42
            local r224_44 = r224_13 + r224_6.y * p224_1.definition.spawnDistance
            r224_39 = r224_43
            r224_40 = r224_44
        else
            r224_39 = r224_12
            r224_40 = r224_13
        end
        local r224_45 = blockTable
        local r224_46 = blockTable.blocks[r224_2]
        local r224_47 = createObject(r224_45, r224_2, r224_46.name, r224_39, r224_40)
        local r224_48 = getLevelMetadata(levelName)
        if r224_48.objectsDestroyableByTap then
            objects.destroyableByTap[#objects.destroyableByTap + 1] = r224_47
            objects.world[r224_47].isMainMenuObject = true
        end
        local r224_49 = _G.math.random(5, 30)
        if objects.world[r224_47].blinkTimer == r224_49 / 10 then
            levelGoals[r224_47] = objects.world[r224_47]
            objects.world[r224_47].timeInState = 0
            objects.world[r224_47].maxTimeInState = 0
            setObjectParameter(r224_47, 1, 1)
        end
        local r224_50 = blockTable.blocks[r224_2]
        if r224_50.levelGoal then
            levelGoals[r224_47] = objects.world[r224_47]
            setObjectParameter(r224_47, 1, 1)
        end
        local r224_51 = p224_1.definition.spawnExplosionForce
        if not r224_51 then
            local r224_52
            r224_51 = r224_52.explosionForce
        end
        if p224_1.definition.addMovingSpeedFromParent and p224_1.xVel ~= nil and p224_1.yVel ~= nil then
            setVelocity(r224_47, p224_1.xVel, p224_1.yVel)
        end
        if p224_1.definition.addRotationSpeedFromParent and p224_1.angularVelocity then
            setAngularVelocity(r224_47, p224_1.angularVelocity)
        end
        applyImpulse(r224_47, r224_6.x * r224_51, r224_6.y * r224_51, objects.world[r224_47].x, objects.world[r224_47].y)
        r224_0 = r224_0 + 1
        startAnimations(r224_47)
        local r224_53 = objects.world[r224_47]
        if blockTable.blocks[r224_53.definition] ~= nil then
            local r224_54 = blockTable.blocks[r224_53.definition]
            if r224_54.animateRotation == true then
                objects.animatedObjects[r224_47] = r224_53.name
                objects.world[r224_47].animateRotation = true
                local r224_55 = blockTable.blocks[r224_53.definition]
                if not (r224_55.minRotationFrequency == nil or blockTable.blocks[r224_53.definition].maxRotationFrequency == nil) then
                    local r224_56 = blockTable.blocks[r224_53.definition]
                    local r224_57 = blockTable.blocks[r224_53.definition]
                    local r224_58 = _G.math.random(r224_56.minRotationFrequency, r224_57.maxRotationFrequency)
                    objects.world[r224_47].rotationFrequency = r224_58 * _G.math.pi / 180
                    local r224_59 = blockTable.blocks[r224_53.definition]
                    local r224_60 = blockTable.blocks[r224_53.definition]
                    local r224_61 = _G.math.random(r224_59.minRotationAmplitude, r224_60.maxRotationAmplitude)
                    objects.world[r224_47].rotationAmplitude = r224_61 * _G.math.pi / 180
                end
            end
        end
        if p224_1.keepOriginalVelocity then
            freezePig(r224_53.name)
        end
        local r224_62 = p224_1.definition
        local r224_63
        if r224_62.copySpawnAngleFromParent then
            r224_63 = p224_1.angle
        else
            r224_63 = r224_36
        end
        if p224_1.definition.spawnedObjectsKeepRotation and not p224_1.objAngle then
            local r224_64 = p224_1.definition.objAngle
        end
        if r224_63 then
            setRotation(r224_47, r224_63)
        end
        if p224_1.definition.spawnedObjectsAreCameraTargets then
            keepAsCameraTarget(r224_47)
        end
        if p224_1.definition.spawnedObjectsAreAffectedByForceMultipliers then
            native_setTimeSinceCollision(r224_47, 0)
            native_setAffectedByForceMultipliers(r224_47, true)
        end
    end
end

-- line 6506-6540
-- proto#225 params=7 locals=16 upvalues=0 vararg=false
function makeClickExplosion(p225_0, p225_1, p225_2, p225_3, p225_4, p225_5, p225_6)
    if p225_6 ~= nil then
        res.playAudio(p225_6)
    end
    local r225_0, r225_1 = physicsToWorldTransform(p225_0, p225_1)
    putParticles({ particles = "explosion", amount = 1, x = r225_0, y = r225_1, w = 4, h = 4 })
    putParticles({ particles = "explosionBuff", amount = 1, x = r225_0, y = r225_1, w = 4, h = 4 })
    for r225_2, r225_3 in _G.pairs(objects.world) do
        local r225_4 = r225_3.x - p225_0
        local r225_5 = vLength(r225_4, r225_3.y - p225_1)
        local r225_6 = vNormalize
        local r225_7 = r225_3.x - p225_0
        local r225_8 = r225_3.y
        local r225_9, r225_10 = r225_6(r225_7, r225_8 - p225_1)
        if r225_5 < p225_3 then
            local r225_11 = physicsScale * p225_2 / r225_5
            applyImpulse(r225_2, r225_9 * r225_11, r225_10 * r225_11, r225_3.x, r225_3.y)
        end
        if r225_5 < p225_5 and r225_3.defence ~= nil and p225_4 / r225_5 > r225_3.defence then
            local r225_12 = r225_3.strength
            local r225_13 = r225_3.strength
            r225_3.strength = r225_13 - p225_4 / r225_5
            createDamageParticles(r225_3, blockTable.blocks, r225_12)
            local r225_14 = getDamageSprite(r225_3, blockTable.blocks)
            r225_3.damageSprite = r225_14.sprite
            r225_3.blinkSprite = r225_14.blink
            r225_3.smileSprite = r225_14.smile
        end
    end
end

-- line 6547-6549
-- proto#226 params=0 locals=0 upvalues=0 vararg=false
function screenToPhysicsScale()
    return physicsScale / worldScale
end

-- line 6551-6555
-- proto#227 params=2 locals=0 upvalues=0 vararg=false
function worldToPhysicsTransform(p227_0, p227_1)
    return p227_0 * physicsScale, p227_1 * physicsScale
end

-- line 6557-6561
-- proto#228 params=2 locals=3 upvalues=0 vararg=false
function worldToScreenTransform(p228_0, p228_1)
    local r228_0 = screen.left
    local r228_1 = (p228_0 - r228_0) * worldScale
    local r228_2 = screen.top
    return r228_1, (p228_1 - r228_2) * worldScale
end

-- line 6563-6567
-- proto#229 params=2 locals=5 upvalues=0 vararg=false
function screenToWorldTransform(p229_0, p229_1)
    local r229_0 = p229_0 / worldScale + screen.left
    return r229_0, p229_1 / worldScale + screen.top
end

-- line 6569-6573
-- proto#230 params=2 locals=0 upvalues=0 vararg=false
function physicsToWorldTransform(p230_0, p230_1)
    return p230_0 * physicsToWorld, p230_1 * physicsToWorld
end

-- line 6575-6579
-- proto#231 params=2 locals=0 upvalues=0 vararg=false
function physicsToScreenTransform(p231_0, p231_1)
    local r231_0, r231_1 = physicsToWorldTransform(p231_0, p231_1)
    local r231_2, r231_3 = worldToScreenTransform(r231_0, r231_1)
    return r231_2, r231_3
end

-- line 6581-6585
-- proto#232 params=2 locals=0 upvalues=0 vararg=false
function screenToPhysicsTransform(p232_0, p232_1)
    local r232_0, r232_1 = screenToWorldTransform(p232_0, p232_1)
    local r232_2, r232_3 = worldToPhysicsTransform(r232_0, r232_1)
    return r232_2, r232_3
end

-- line 6587-6591
-- proto#233 params=4 locals=3 upvalues=0 vararg=false
function distance(p233_0, p233_1, p233_2, p233_3)
    local r233_0 = p233_2 - p233_0
    local r233_1 = p233_3 - p233_1
    return _G.math.sqrt(r233_0 * r233_0 + r233_1 * r233_1)
end

-- line 6593-6596
-- proto#234 params=2 locals=1 upvalues=0 vararg=false
function normalizeVector(p234_0, p234_1)
    local r234_0 = distance(0, 0, p234_0, p234_1)
    return { x = p234_0 / r234_0, y = p234_1 / r234_0 }
end

-- line 6598-6600
-- proto#235 params=4 locals=0 upvalues=0 vararg=false
function dotProduct(p235_0, p235_1, p235_2, p235_3)
    return p235_0 * p235_2 + p235_1 * p235_3
end

-- line 6603-6637
-- proto#236 params=9 locals=0 upvalues=0 vararg=false
function checkBounds(p236_0, p236_1, p236_2, p236_3, p236_4, p236_5, p236_6, p236_7, p236_8)
    local r236_0, r236_1 = p236_0, p236_1
    if p236_7 and p236_8 then
        if p236_7 == "HCENTER" then
            r236_0 = p236_0 - p236_2 * 0.5
        elseif p236_7 == "LEFT" then
            r236_0 = p236_0 + p236_2
        elseif p236_7 == "RIGHT" then
            r236_0 = p236_0 - p236_2
        end
        if p236_8 == "VCENTER" then
            r236_1 = p236_1 - p236_3 * 0.5
        elseif p236_8 == "TOP" then
            r236_1 = p236_1 + p236_3
        elseif p236_8 == "BOTTOM" then
            r236_1 = p236_1 - p236_3
        end
    end
    if r236_0 <= p236_4 and r236_0 + p236_2 > p236_4 and r236_1 <= p236_5 and r236_1 + p236_3 > p236_5 then
        return true
    end
    return false
end

-- line 6639-6671
-- proto#237 params=3 locals=32 upvalues=0 vararg=false
function testPointInPolygon(p237_0, p237_1, p237_2)
    local r237_0 = #p237_2
    local r237_1, r237_2 = 1, 0
    while #p237_2 >= r237_1 do
        local r237_3 = _G.math.min
        local r237_4 = p237_2[r237_0]
        local r237_5 = r237_4.y
        local r237_6 = p237_2[r237_1]
        if r237_3(r237_5, r237_6.y) < p237_1 then
            local r237_7 = _G.math.max(p237_2[r237_0].y, p237_2[r237_1].y)
            if p237_1 <= r237_7 then
                local r237_8 = _G.math.max(p237_2[r237_0].x, p237_2[r237_1].x)
                if p237_0 <= r237_8 then
                    local r237_9 = p237_2[r237_0]
                    local r237_10 = r237_9.y
                    local r237_11 = p237_2[r237_1]
                    local r237_12 = r237_11.y
                    if r237_10 ~= r237_12 then
                        local r237_13 = p237_2[r237_0]
                        local r237_14 = r237_13.y
                        local r237_15 = p237_1 - r237_14
                        local r237_16 = p237_2[r237_1]
                        local r237_17 = r237_16.x
                        local r237_18 = p237_2[r237_0]
                        local r237_19 = r237_18.x
                        local r237_20 = r237_15 * (r237_17 - r237_19)
                        local r237_21 = p237_2[r237_1]
                        local r237_22 = r237_21.y
                        local r237_23 = p237_2[r237_0]
                        local r237_24 = r237_23.y
                        local r237_25 = r237_20 / (r237_22 - r237_24)
                        local r237_26 = p237_2[r237_0]
                        local r237_27 = r237_26.x
                        local r237_28 = r237_25 + r237_27
                        local r237_29 = p237_2[r237_0]
                        local r237_30 = r237_29.x
                        local r237_31 = p237_2[r237_1]
                        local r237_32 = r237_31.x
                        if r237_30 == r237_32 then
                            r237_2 = r237_2 + 1
                        elseif p237_0 < r237_28 then
                            r237_2 = r237_2 + 1
                        end
                    end
                end
            end
        end
        r237_0 = r237_1
        r237_1 = r237_1 + 1
    end
    if r237_2 % 2 == 0 then
        return false
    end
    return true
end

-- line 6682-6684
-- proto#238 params=4 locals=0 upvalues=0 vararg=false
function dampedSpring(p238_0, p238_1, p238_2, p238_3)
    return p238_0 * p238_2 - p238_1 * p238_3
end

-- line 6699-6701
-- proto#239 params=6 locals=0 upvalues=0 vararg=false
function signed2DTriArea(p239_0, p239_1, p239_2, p239_3, p239_4, p239_5)
    return (p239_0 - p239_4) * (p239_3 - p239_5) - (p239_1 - p239_5) * (p239_2 - p239_4)
end

-- line 6709-6739
-- proto#240 params=9 locals=5 upvalues=0 vararg=false
function test2DSegmentSegment(p240_0, p240_1, p240_2, p240_3, p240_4, p240_5, p240_6, p240_7, p240_8)
    local r240_0 = signed2DTriArea(p240_0, p240_1, p240_2, p240_3, p240_6, p240_7)
    local r240_1 = signed2DTriArea(p240_0, p240_1, p240_2, p240_3, p240_4, p240_5)
    if r240_0 ~= 0 and r240_1 ~= 0 and r240_0 * r240_1 < 0 then
        local r240_2 = signed2DTriArea(p240_4, p240_5, p240_6, p240_7, p240_0, p240_1)
        local r240_3 = r240_2 + r240_1 - r240_0
        if r240_2 ~= 0 and r240_3 ~= 0 and r240_2 * r240_3 < 0 then
            local r240_4 = nil
            if p240_8 == true then
                intersectionValue = r240_2 / (r240_2 - r240_3)
                r240_4 = {
                    x = p240_0 + intersectionValue * (p240_2 - p240_0),
                    y = p240_1 + intersectionValue * (p240_3 - p240_1)
                }
            end
            return true, nil, r240_4
        end
    end
    return false
end

-- line 6741-6744
-- proto#241 params=2 locals=1 upvalues=0 vararg=false
function vLength(p241_0, p241_1)
    return (_G.math.sqrt(p241_0 * p241_0 + p241_1 * p241_1))
end

-- line 6746-6752
-- proto#242 params=2 locals=2 upvalues=0 vararg=false
function vNormalize(p242_0, p242_1)
    local r242_0 = _G.math.sqrt(p242_0 * p242_0 + p242_1 * p242_1)
    if r242_0 == 0 then
        return 0, 1
    end
    return p242_0 / r242_0, p242_1 / r242_0
end

-- line 6754-6756
-- proto#243 params=1 locals=5 upvalues=0 vararg=false
function getForwardV(p243_0)
    local r243_0 = _G.math.cos
    local r243_1 = objects.world[p243_0]
    local r243_2 = r243_0(r243_1.angle)
    local r243_3 = _G.math.sin
    local r243_4 = objects.world[p243_0]
    return r243_2, r243_3(r243_4.angle)
end

-- line 6758-6760
-- proto#244 params=1 locals=5 upvalues=0 vararg=false
function getStartingForwardV(p244_0)
    local r244_0 = _G.math.cos
    local r244_1 = objects.world[p244_0]
    local r244_2 = r244_0(r244_1.startingAngle)
    local r244_3 = _G.math.sin
    local r244_4 = objects.world[p244_0]
    return r244_2, r244_3(r244_4.startingAngle)
end

-- line 6762-6764
-- proto#245 params=1 locals=5 upvalues=0 vararg=false
function getStartingUpV(p245_0)
    local r245_0 = _G.math.cos
    local r245_1 = objects.world[p245_0]
    local r245_2 = r245_0(r245_1.startingAngle)
    local r245_3 = _G.math.sin
    local r245_4 = objects.world[p245_0]
    return r245_2, r245_3(r245_4.startingAngle)
end

-- line 6766-6768
-- proto#246 params=1 locals=6 upvalues=0 vararg=false
function getUpV(p246_0)
    local r246_0 = _G.math.sin
    local r246_1 = objects.world[p246_0]
    local r246_2 = r246_0(r246_1.angle)
    local r246_3 = _G.math.cos(objects.world[p246_0].angle)
    return r246_2, -r246_3
end

-- line 6770-6783
-- proto#247 params=1 locals=5 upvalues=0 vararg=false
function setupCurrentLevelString(p247_0)
    local r247_0 = getWorldNumber(currentFolder, p247_0)
    local r247_1 = getRenderedLevelNumber(currentFolder, p247_0)
    local r247_2 = r247_1
    if r247_2 == nil then
        r247_2 = 0
    end
    local r247_3 = getLevelNamePrefix(p247_0)
    local r247_4 = getLevelMetadata(levelName)
    local r247_5 = r247_4.levelNumberSuffix
    g_currentLevelString = r247_3 .. "-" .. (r247_5 or r247_2)
end

-- line 6785-6799
-- proto#248 params=1 locals=4 upvalues=0 vararg=false
function getLevelNamePrefix(p248_0)
    local r248_0 = getWorldNumber(currentFolder, p248_0)
    local r248_1 = getEpisodeMetadata(currentFolder)
    local r248_2 = r248_1.levelNumberPrefix
    if not r248_2 then
        r248_2 = r248_0
    end
    local r248_3 = _G.type
    local r248_4
    if r248_3(r248_2) == "table" then
        if getEpisodeMetadata(currentFolder).levelNumberAdjustment < p248_0 then
            r248_4 = r248_2[2]
        else
            r248_4 = r248_2[1]
        end
    else
        r248_4 = r248_2
    end
    return r248_4
end

-- line 6802-6833
-- proto#249 params=0 locals=9 upvalues=0 vararg=false
function setPreviousLevel()
    local r249_0 = actions.myLevels[currentFolder]
    if objects.previousLevel == nil then
        if currentLevel < 2 then
            return
        end
        local r249_1 = getNextLevelName(r249_0[currentLevel - 1])
        setCurrentLevel(currentLevel - 1)
        setLevelName(r249_1)
        setupCurrentLevelString(currentLevel - 1)
        local r249_2 = getPageNumber(currentFolder, currentLevel - 1)
        SettingsWrapper:setLastLevelPage(currentFolder, r249_2 - 1)
        local r249_3 = eventManager
        local r249_4 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
        r249_3:notify(r249_4)
        return
    end
    setCurrentFolder(returnFolderId)
    setCurrentLevel(returnLevelNumber)
    setLevelFolder(returnFolder)
    local r249_5 = setLevelName
    local r249_6 = actions.myLevels[returnFolderId]
    r249_5(r249_6[returnLevelNumber])
    local r249_7 = eventManager
    local r249_8 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
    r249_7:notify(r249_8)
end

-- line 6835-6911
-- proto#250 params=2 locals=25 upvalues=0 vararg=false
function setNextLevel(p250_0, p250_1)
    local r250_0 = actions.myLevels[currentFolder]
    if objects.previousLevel == nil then
        if isBuildUnlocked() ~= true and isIapEnabled() then
            local r250_1 = p250_0 or currentFolder
            local r250_2 = actions.myLevels[r250_1]
            local r250_3 = getEpisodeMetadataWithParam(r250_1, "iapPurchaseId")
            local r250_4 = getEpisodeMetadata(r250_1)
            if r250_4.iapPurchase and r250_3 ~= nil and SettingsWrapper:isEpisodePurchased(r250_3) ~= true then
                local r250_5 = p250_1 or getNextLevelName(r250_2[currentLevel + 1])
                if getLevelMetadata(r250_5).unlockedAsDefault ~= true then
                    local r250_6 = setLevelName
                    local r250_7 = getEpisodeMetadata(r250_1)
                    r250_6(r250_7.advertisementLevelName)
                    local r250_8 = currentFolder
                    if r250_1 ~= r250_8 then
                        setCurrentFolder(r250_1)
                        setLevelFolder("levels/" .. r250_1 .. "/")
                    end
                    g_showEpisodePurchaseDialog = true
                    g_showEpisodePurchaseDialogFrom = "Trial level"
                    local r250_9 = eventManager
                    local r250_10 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
                    r250_9:notify(r250_10)
                    return
                end
            end
        end
        if getEpisodeMetadata(currentFolder).openLevelsLimit ~= nil and getEpisodeMetadata(currentFolder).openLevelsLimit + 2 <= currentLevel + 1 then
            setLevelName("LevelSelection")
            local r250_11 = eventManager
            local r250_12 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r250_11:notify(r250_12)
            eventManager:queueEvent({ id = events.EID_SCROLL_RIGHT })
            return
        end
        local r250_13 = p250_1
        if not p250_1 then
            local r250_14 = getLevelMetadata(levelName)
            r250_13 = r250_14.nextLevelName
        end
        local r250_15 = p250_0
        if not p250_0 then
            local r250_16 = getLevelMetadata(levelName)
            r250_15 = r250_16.nextLevelFolder
        end
        if r250_15 and r250_13 then
            setLevelFolder(r250_15)
            setLevelName(getNextLevelName(r250_13))
            local r250_17 = eventManager
            local r250_18 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r250_17:notify(r250_18)
            return
        end
        local r250_19 = getNextLevelName(r250_0[currentLevel + 1])
        setCurrentLevel(currentLevel + 1)
        setLevelName(r250_19)
        setupCurrentLevelString(currentLevel + 1)
        local r250_20 = getPageNumber(currentFolder, currentLevel + 1)
        SettingsWrapper:setLastLevelPage(currentFolder, r250_20 - 1)
        local r250_21 = eventManager
        local r250_22 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
        r250_21:notify(r250_22)
        return
    end
    setCurrentFolder(returnFolderId)
    setCurrentLevel(returnLevelNumber)
    setLevelFolder(returnFolder)
    local r250_23 = setLevelName
    local r250_24 = actions.myLevels[returnFolderId]
    r250_23(r250_24[returnLevelNumber])
    local r250_25 = eventManager
    local r250_26 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
    r250_25:notify(r250_26)
end

-- line 6913-6915
-- proto#251 params=0 locals=1 upvalues=0 vararg=false
function isReturnLevelAvailable()
    return objects.previousLevel ~= nil
end

-- line 6917-6925
-- proto#252 params=1 locals=12 upvalues=0 vararg=false
function updateMySensor(p252_0)
    local r252_0 = objects.world[p252_0]
    if r252_0.sensorB ~= nil then
        local r252_1 = objects.world[p252_0]
        local r252_2 = objects.world[p252_0]
        local r252_3 = objects.world[p252_0]
        setPosition(r252_1.sensorB, r252_2.x, r252_3.y)
    end
    local r252_4 = objects.world[p252_0]
    if r252_4.sensorA ~= nil then
        local r252_5 = objects.world[p252_0]
        local r252_6 = objects.world[p252_0]
        local r252_7 = objects.world[p252_0]
        setPosition(r252_5.sensorA, r252_6.x, r252_7.y)
    end
end

-- line 6927-6945
-- proto#253 params=2 locals=11 upvalues=0 vararg=false
function destroyObject(p253_0, p253_1)
    if p253_0 == nil then
        local r253_0 = "Attempted to destroy a nil object. Stack trace: "
        local r253_1 = _G.debug.traceback()
        local r253_2 = r253_0 .. r253_1
        print(r253_2)
        _G.assert(false, r253_2)
    else
        local r253_3 = objects.world[p253_0]
        if r253_3 == nil then
            local r253_4 = _G.debug.traceback()
            local r253_5 = "Object " .. p253_0 .. " not found in the world. Stack trace: " .. r253_4
            print(r253_5)
            _G.assert(false, r253_5)
        else
            deadBlocks[p253_0] = r253_3
            r253_3.strength = 0
            r253_3.ignoreGameplayActions = p253_1
        end
    end
end

-- line 6947-6949
-- proto#254 params=1 locals=1 upvalues=0 vararg=false
function checkStillInWorld(p254_0)
    local r254_0 = objects.world[p254_0]
    return r254_0 ~= nil
end

-- line 6951-6953
-- proto#255 params=3 locals=1 upvalues=0 vararg=false
function attachEventListener(p255_0, p255_1, p255_2)
    objects.world[p255_0][p255_1] = p255_2
end

-- line 6955-6962
-- proto#256 params=3 locals=3 upvalues=0 vararg=false
function addScore(p256_0, p256_1, p256_2)
    if not (p256_1 == nil or p256_2 == nil) then
        _G.table.insert(floatingScores, {
            x = p256_1,
            y = p256_2,
            text = "" .. p256_0,
            score = p256_0,
            time = 0,
            lifetime = 0.6000000238418579,
            maxScale = 0.25 + p256_0 / 3000,
            xs = 0
        })
    end
    scoreTable.blocks.score = scoreTable.blocks.score + p256_0
end

-- line 6964-6972
-- proto#257 params=2 locals=4 upvalues=0 vararg=false
function exitCollision(p257_0, p257_1)
    if not (objects.world[p257_0] == nil or objects.world[p257_0].onCollisionExit == nil) then
        fireAction(objects.world[p257_0].onCollisionExit, { name = p257_0, other = p257_1 })
    end
    if not (objects.world[p257_1] == nil or objects.world[p257_1].onCollisionExit == nil) then
        fireAction(objects.world[p257_1].onCollisionExit, { name = p257_1, other = p257_0 })
    end
end

-- line 6974-6982
-- proto#258 params=2 locals=4 upvalues=0 vararg=false
function exitTriggerCollision(p258_0, p258_1)
    if not (objects.world[p258_0] == nil or objects.world[p258_0].onTriggerExit == nil) then
        fireAction(objects.world[p258_0].onTriggerExit, { name = p258_0, other = p258_1 })
    end
    if not (objects.world[p258_1] == nil or objects.world[p258_1].onTriggerExit == nil) then
        fireAction(objects.world[p258_1].onTriggerExit, { name = p258_1, other = p258_0 })
    end
end

-- line 6984-6992
-- proto#259 params=2 locals=4 upvalues=0 vararg=false
function enterCollision(p259_0, p259_1)
    if not (objects.world[p259_0] == nil or objects.world[p259_0].onTriggerEnter == nil) then
        fireAction(objects.world[p259_0].onTriggerEnter, { name = p259_0, other = p259_1 })
    end
    if not (objects.world[p259_1] == nil or objects.world[p259_1].onTriggerEnter == nil) then
        fireAction(objects.world[p259_1].onTriggerEnter, { name = p259_1, other = p259_0 })
    end
end

-- line 6994-6996
-- proto#260 params=0 locals=0 upvalues=0 vararg=false
function getObjectsInWorld()
    return objects.world
end

-- line 7003-7012
-- proto#261 params=5 locals=0 upvalues=0 vararg=false
function newAnimation(p261_0, p261_1, p261_2, p261_3, p261_4)
    elementAnimations[p261_0] = {
        page = p261_2,
        state = p261_1,
        percentage = 0,
        speedIn = p261_3,
        speedOut = p261_4,
        name = p261_0
    }
end

-- line 7014-7033
-- proto#262 params=1 locals=7 upvalues=0 vararg=false
function updateAnimations(p262_0)
    for r262_0, r262_1 in _G.pairs(elementAnimations) do
        if r262_1.state == "ENTERING" then
            r262_1.percentage = r262_1.percentage + r262_1.speedIn * p262_0
            local r262_2 = r262_1.percentage
            if r262_2 > 100 then
                r262_1.percentage = 100
                r262_1.state = "VISIBLE"
                r262_1.page.state = "READY"
            end
        elseif r262_1.state ~= "VISIBLE" and r262_1.state == "EXITING" then
            r262_1.percentage = r262_1.percentage - r262_1.speedOut * p262_0
            if r262_1.percentage < 0 then
                r262_1.percentage = 0
                r262_1.state = "HIDDEN"
                r262_1.page.state = "DISABLED"
            end
        end
    end
end

-- line 7035-7066
-- proto#263 params=2 locals=1 upvalues=0 vararg=false
function setAnimationState(p263_0, p263_1)
    local r263_0 = elementAnimations[p263_0]
    if p263_1 == "ENTERING" then
        if r263_0.state == "HIDDEN" then
            r263_0.state = p263_1
            r263_0.percentage = 0
            r263_0.page.state = "DISABLED"
        elseif r263_0.state == "EXITING" then
            r263_0.state = p263_1
        end
    elseif p263_1 == "VISIBLE" then
        if r263_0.state == "ENTERING" or r263_0.state == "HIDDEN" or r263_0.state == "EXITING" then
            r263_0.state = p263_1
            r263_0.percentage = 100
            r263_0.page.state = "READY"
        end
    elseif p263_1 == "EXITING" then
        if r263_0.state == "VISIBLE" then
            r263_0.state = p263_1
            r263_0.percentage = 100
            r263_0.page.state = "READY"
        elseif r263_0.state == "ENTERING" then
            r263_0.state = p263_1
        end
    elseif p263_1 == "HIDDEN" and (r263_0.state == "ENTERING" or r263_0.state == "VISIBLE" or r263_0.state == "EXITING") then
        r263_0.state = p263_1
        r263_0.percentage = 0
        r263_0.page.state = "DISABLED"
    end
end

-- line 7073-7105
-- proto#264 params=1 locals=10 upvalues=0 vararg=false
function setPostedStatus(p264_0)
    local r264_0 = _G.tostring(p264_0)
    print(":::::: SetPostedStatus for episode: " .. r264_0)
    if gameCenterEnabled and gameCenter and gameCenter.leaderboards and leaderboards then
        local r264_1 = getLeaderboardNameForEpisode(p264_0)
        local r264_2 = getLeaderboardNameForTotalScore()
        if r264_1 and leaderboards[r264_1] and gameCenter.leaderboards[leaderboards[r264_1]] then
            print("Setting posted status to false for leaderboard " .. r264_1 .. [[
]])
            local r264_3 = gameCenter.leaderboards[leaderboards[r264_1]]
            r264_3.posted = false
        end
        if leaderboards[r264_2] and gameCenter.leaderboards[leaderboards[r264_2]] then
            print("Setting posted status to false for total leaderboard with name: " .. r264_2)
            local r264_4 = gameCenter.leaderboards[leaderboards[r264_2]]
            r264_4.posted = false
        end
        if powerups then
            powerUpLBoardName = getLeaderboardNameForEpisode(p264_0, true)
            powerUpLBoardNameTotal = getLeaderboardNameForTotalScore(true)
            if leaderboards[powerUpLBoardName] and gameCenter.leaderboards[leaderboards[powerUpLBoardName]] then
                print("Setting posted status to false for powerup leaderboard " .. powerUpLBoardName)
                local r264_5 = gameCenter.leaderboards[leaderboards[powerUpLBoardName]]
                r264_5.posted = false
            end
            if leaderboards[powerUpLBoardNameTotal] and gameCenter.leaderboards[leaderboards[powerUpLBoardNameTotal]] then
                print("Setting posted status to false for powerup total leaderboard with name: " .. powerUpLBoardNameTotal)
                local r264_6 = gameCenter.leaderboards[leaderboards[powerUpLBoardNameTotal]]
                r264_6.posted = false
            end
        end
    end
end

-- line 7107-7115
-- proto#265 params=0 locals=0 upvalues=0 vararg=false
function calculatePlaytime()
    if playtimeCounter == nil then
        playtimeCounter = 0
    end
    SettingsWrapper:setPlaytime(playtimeCounter)
    playtimeCounter = 0
end

-- line 7118-7125
-- proto#266 params=0 locals=3 upvalues=0 vararg=false
function refreshLocalGameCenterData()
    print([[gamelogic refreshLocalGameCenterData 
]])
    if gameCenterEnabled and leaderboards then
        for r266_0, r266_1 in _G.pairs(leaderboards) do
            getLeaderboardScoresForRange(r266_1, 1, 1)
        end
    end
end

-- line 7127-7129
-- proto#267 params=0 locals=0 upvalues=0 vararg=false
function setIndicatorPositions()

end

-- line 7131-7134
-- proto#268 params=0 locals=0 upvalues=0 vararg=false
function getMainMenuInstance()
    return (menuManager:getRoot():getChild("mainMenu"))
end

-- line 7136-7147
-- proto#269 params=0 locals=1 upvalues=0 vararg=false
function enableGameCenter()
    if menuManager == nil then
        return
    end
    local r269_0 = getMainMenuInstance()
    if r269_0 == nil then
        print("enableGameCenter - failed to get main menu instance")
    else
        r269_0:setGameCenterEnabled(true)
    end
end

-- line 7149-7160
-- proto#270 params=0 locals=1 upvalues=0 vararg=false
function disableGameCenter()
    if menuManager == nil then
        return
    end
    local r270_0 = getMainMenuInstance()
    if r270_0 == nil then
        print("disableGameCenter - failed to get main menu instance")
    else
        r270_0:setGameCenterEnabled(false)
    end
end

-- line 7164-7166
-- proto#271 params=0 locals=0 upvalues=0 vararg=false
function hideLoadingInitGameCenter()
    print([[gamelogic hideLoadingInitGameCenter
]])
end

-- line 7168-7176
-- proto#272 params=0 locals=1 upvalues=0 vararg=false
function hideLoadingLeaderboards()
    print([[gamelogic hideLoadingLeaderboards 
]])
    local r272_0 = getMainMenuInstance()
    if r272_0 ~= nil then
        r272_0:refreshGameCenterButtons()
    end
end

-- line 7178-7187
-- proto#273 params=0 locals=1 upvalues=0 vararg=false
function hideLoadingAchievements()
    print([[gamelogic hideloadingAchievements 
]])
    local r273_0 = getMainMenuInstance()
    if r273_0 ~= nil then
        r273_0:refreshGameCenterButtons()
    end
end

-- line 7189-7194
-- proto#274 params=0 locals=1 upvalues=0 vararg=false
function refreshGameCenterButtons()
    local r274_0 = getMainMenuInstance()
    if r274_0 ~= nil then
        r274_0:refreshGameCenterButtons()
    end
end

-- line 7201-7206
-- proto#275 params=3 locals=5 upvalues=0 vararg=false
function transformCoordinates(p275_0, p275_1, p275_2)
    local r275_0 = _G.math.cos(p275_0)
    local r275_1 = _G.math.sin(p275_0)
    return { x = r275_0 * p275_1 + -r275_1 * p275_2, y = r275_1 * p275_1 + r275_0 * p275_2 }
end

-- line 7209-7211
-- proto#276 params=0 locals=2 upvalues=0 vararg=false
function isInGameMode()
    local r276_0
    if actions == nil then
        r276_0 = false
    elseif getLevelMetadata(levelName).type == "comic" then
        r276_0 = false
    else
        r276_0 = getLevelMetadata(levelName).type ~= "menu"
    end
    return r276_0
end

-- line 7214-7227
-- proto#277 params=0 locals=0 upvalues=0 vararg=false
function isInGameplay()
    if isInGameMode() and not (g_tutorialShowing or isLevelEnded() or isRewardPageShowing()) then
        local r277_0 = menuManager:getRoot():getChild("gameHud")
        if r277_0 and r277_0:getChild("pausePage").visible then
            return false
        end
        return true
    end
    return false
end

-- line 7229-7231
-- proto#278 params=0 locals=2 upvalues=0 vararg=false
function isInComic()
    local r278_0
    if actions == nil then
        r278_0 = false
    elseif levelName == nil then
        r278_0 = false
    else
        r278_0 = getLevelMetadata(levelName).type == "comic"
    end
    return r278_0
end

-- line 7233-7235
-- proto#279 params=0 locals=1 upvalues=0 vararg=false
function isLevelEnded()
    return menuManager:getRoot():getChild("LevelEnd") ~= nil
end

-- line 7237-7243
-- proto#280 params=2 locals=0 upvalues=0 vararg=false
function enableGravityForBird(p280_0, p280_1)
    if p280_1 == true then
        setObjectGravityCategory(p280_0, g_gravityFiltersCategories.BIRD)
    else
        setObjectGravityCategory(p280_0, g_gravityFiltersCategories.BIRD_UNAFFECTED_BY_GRAVITY)
    end
end

-- line 7245-7252
-- proto#281 params=1 locals=1 upvalues=0 vararg=false
function getLevelMetadata(p281_0)
    assert(p281_0 ~= nil, "levelName name is nil")
    if actions.myLevelsMetadata[p281_0] == nil then
        return {}
    end
    return actions.myLevelsMetadata[p281_0]
end

-- line 7257-7264
-- proto#282 params=1 locals=1 upvalues=0 vararg=false
function getEpisodeMetadata(p282_0)
    if actions.myEpisodesMetadata[p282_0] == nil then
        return {}
    end
    return actions.myEpisodesMetadata[p282_0]
end

-- line 7267-7282
-- proto#283 params=2 locals=3 upvalues=0 vararg=false
function isLevelComic(p283_0, p283_1)
    if actions.myLevels[p283_0] == nil then
        return false
    end
    local r283_0 = actions.myLevels[p283_0]
    local r283_1 = r283_0[p283_1]
    _G.assert(actions.myLevelsMetadata ~= nil)
    if actions.myLevelsMetadata[r283_1] ~= nil and actions.myLevelsMetadata[r283_1].type == "comic" then
        return true
    end
    return false
end

-- line 7284-7296
-- proto#284 params=2 locals=3 upvalues=0 vararg=false
function getStarsRequiredToOpenLevel(p284_0, p284_1)
    if actions.myLevels[p284_0] == nil then
        return nil
    end
    local r284_0 = actions.myLevelsMetadata
    local r284_1 = actions.myLevels[p284_0]
    if r284_0[r284_1[p284_1]] ~= nil and actions.myLevelsMetadata[actions.myLevels[p284_0][p284_1]].starsUnlockLimit then
        local r284_2 = actions.myLevelsMetadata[actions.myLevels[p284_0][p284_1]]
        return r284_2.starsUnlockLimit
    end
    return nil
end

-- line 7298-7326
-- proto#285 params=2 locals=8 upvalues=0 vararg=false
function getRenderedLevelNumber(p285_0, p285_1)
    _G.assert(p285_0 ~= nil, "folder is nil at getRenderedLevelNumber")
    _G.assert(p285_1 ~= nil, "levelNumber is nil at getRenderedLevelNumber")
    if actions.myLevels[p285_0] == nil then
        return nil
    end
    if not isLevelComic(p285_0, p285_1) then
        local r285_0 = 1
        for r285_1, r285_2 in _G.ipairs(actions.myLevels[p285_0]) do
            if p285_1 <= r285_1 then
                break
            end
            if not isLevelComic(p285_0, r285_1) then
                r285_0 = r285_0 + 1
            end
        end
        local r285_3 = getEpisodeMetadata(currentFolder)
        local r285_4 = r285_3.levelNumberAdjustment
        local r285_5
        if r285_4 then
            if r285_4 < r285_0 then
                r285_5 = r285_0 - r285_4
            else
                r285_5 = r285_0
            end
        else
            r285_5 = r285_0
        end
        return r285_5
    end
    return nil
end

-- line 7328-7337
-- proto#286 params=2 locals=2 upvalues=0 vararg=false
function assert(p286_0, p286_1)
    if p286_0 == false then
        if _G.debug == nil then
            print("Assertion failed but debug is unavailable")
        else
            print(_G.debug.traceback())
        end
        _G.assert(p286_0, p286_1)
    end
end

-- line 7339-7347
-- proto#287 params=2 locals=3 upvalues=0 vararg=false
function isLastLevelOfEpisode(p287_0, p287_1)
    local r287_0 = actions.myLevels[p287_0]
    local r287_1 = r287_0[p287_1]
    if actions.myLevelsMetadata[r287_1] == nil then
        return false
    end
    local r287_2 = actions.myLevelsMetadata[r287_1]
    return r287_2.lastLevelOfEpisode
end

-- line 7349-7351
-- proto#288 params=0 locals=0 upvalues=0 vararg=false
function isEagleEnabled()
    return false
end

-- line 7354-7364
-- proto#289 params=2 locals=2 upvalues=0 vararg=false
function doesLevelHaveFeather(p289_0, p289_1)
    local r289_0 = actions.myLevels[p289_0]
    local r289_1 = r289_0[p289_1]
    if highscores[r289_1] then
        local r289_2 = highscores[r289_1]
        if r289_2.eagleScore and highscores[r289_1].eagleScore >= 100 then
            return 2
        end
        local r289_3 = highscores[r289_1]
        if r289_3.eagleScore and highscores[r289_1].eagleScore >= 50 then
            return 1
        end
    end
    return 0
end

-- line 7366-7375
-- proto#290 params=2 locals=1 upvalues=0 vararg=false
function isLevelCompletedWithPowerups(p290_0, p290_1)
    local r290_0 = actions.myLevels[p290_0]
    local r290_1 = r290_0[p290_1]
    if highscores[r290_1] and highscores[r290_1].powerUpScore and highscores[r290_1].powerUpScore > 0 then
        return true
    end
    return false
end

-- line 7377-7382
-- proto#291 params=0 locals=1 upvalues=0 vararg=false
function showEagleUIElements()
    if platformSupportsME() then
        return SettingsWrapper:isMightyEagleEnabled() or SettingsWrapper:isMEAdvertEnabled()
    end
    return false
end

-- line 7384-7386
-- proto#292 params=0 locals=0 upvalues=0 vararg=false
function platformSupportsME()
    return isIapEnabled()
end

-- line 7388-7390
-- proto#293 params=1 locals=4 upvalues=0 vararg=false
function logwarning(p293_0)
    local r293_0 = _G.tostring(p293_0)
    print("WARNING: " .. r293_0 .. [[
]])
end

-- line 7392-7394
-- proto#294 params=1 locals=4 upvalues=0 vararg=false
function logerror(p294_0)
    local r294_0 = _G.tostring(p294_0)
    print("ERROR: " .. r294_0 .. [[
]])
end

-- line 7396-7398
-- proto#295 params=1 locals=4 upvalues=0 vararg=false
function loginfo(p295_0)
    local r295_0 = _G.tostring(p295_0)
    print("INFO: " .. r295_0 .. [[
]])
end

-- line 7404-7411
-- proto#296 params=4 locals=5 upvalues=0 vararg=false
function tweenEaseCubicIn(p296_0, p296_1, p296_2, p296_3)
    local r296_0 = p296_0 / p296_3
    return p296_2 * r296_0 * r296_0 * r296_0 + p296_1
end

-- line 7413-7420
-- proto#297 params=4 locals=5 upvalues=0 vararg=false
function tweenEaseCubicOut(p297_0, p297_1, p297_2, p297_3)
    local r297_0 = p297_0 / p297_3 - 1
    return p297_2 * (r297_0 * r297_0 * r297_0 + 1) + p297_1
end

-- line 7422-7435
-- proto#298 params=4 locals=6 upvalues=0 vararg=false
function tweenEaseCubicInOut(p298_0, p298_1, p298_2, p298_3)
    local r298_0 = p298_0 / (p298_3 / 2)
    if r298_0 < 1 then
        return p298_2 / 2 * (r298_0 * r298_0 * r298_0) + p298_1
    end
    local r298_1 = r298_0 - 2
    return p298_2 / 2 * (r298_1 * r298_1 * r298_1 + 2) + p298_1
end

-- line 7437-7464
-- proto#299 params=2 locals=8 upvalues=0 vararg=false
function getPageNumber(p299_0, p299_1)
    local r299_0
    local r299_1 = actions.myLevels[p299_0]
    local r299_2 = getLevelMetadata(r299_1[p299_1])
    local r299_3, r299_4 = actions.myPages[p299_0], 1
    for r299_5, r299_6 in _G.pairs(r299_3) do
        if r299_6 < p299_1 then
            r299_4 = r299_4 + 1
        end
    end
    if r299_4 < 1 then
        r299_0 = 1
        logwarning(" cannot calculate page number correctly, myPages in levelOrder.lua might be out of date")
    end
    if r299_2 and r299_2.isAlternativePathLevel then
        return r299_2.levelPage or r299_0
    end
    return r299_0
end

-- line 7467-7476
-- proto#300 params=1 locals=8 upvalues=0 vararg=false
function printArray(p300_0)
    print("Printing array:")
    for r300_0, r300_1 in _G.pairs(p300_0) do
        if _G.type(r300_1) == "table" then
            printArray(r300_1)
        else
            local r300_2 = _G.tostring(r300_1)
            print(r300_0 .. ": " .. r300_2)
        end
    end
end

-- line 7478-7480
-- proto#301 params=0 locals=0 upvalues=0 vararg=false
function requestAd()
    print("********** requestAd called")
end

-- line 7482-7488
-- proto#302 params=1 locals=5 upvalues=0 vararg=false
function onLoadLuaFileFail(p302_0)
    if releaseBuild ~= true then
        local r302_0 = _G.tostring(p302_0)
        logwarning("onLoadLuaFileFail() " .. r302_0)
        g_warningMessages = g_warningMessages or {}
        _G.table.insert(g_warningMessages, p302_0)
    end
end

-- line 7492-7497
-- proto#303 params=1 locals=2 upvalues=0 vararg=false
function gotoMenuLevel(p303_0)
    _G.assert(p303_0 ~= nil, "invalid parameter")
    setLevelFolder("levels/")
    setLevelName(p303_0)
    local r303_0 = eventManager
    local r303_1 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
    r303_0:notify(r303_1)
end

-- line 7499-7502
-- proto#304 params=0 locals=0 upvalues=0 vararg=false
function gotoCredits()
    eventManager:notify({ id = events.EID_ABOUT_MENU_OPENED })
    gotoMenuLevel("Credits")
end

-- line 7505-7508
-- proto#305 params=0 locals=1 upvalues=0 vararg=false
function currentTime()
    return {
        d = _G.os.date("%d") * 1,
        h = _G.os.date("%H") * 1,
        m = _G.os.date("%M") * 1,
        s = _G.os.date("%S") * 1
    }
end

-- line 7511-7519
-- proto#306 params=2 locals=13 upvalues=0 vararg=false
function timeDiff(p306_0, p306_1)
    local r306_0 = p306_1.h * 60 * 60
    local r306_1 = p306_1.m
    local r306_2 = r306_0 + r306_1 * 60
    local r306_3 = p306_1.s
    local r306_4 = r306_2 + r306_3
    local r306_5 = p306_0.h * 60 * 60
    local r306_6 = p306_0.m
    local r306_7 = r306_5 + r306_6 * 60
    local r306_8 = p306_0.s
    local r306_9 = r306_7 + r306_8
    local r306_10 = p306_0.d
    local r306_11 = p306_1.d
    local r306_12
    if r306_10 == r306_11 then
        r306_12 = r306_9
    else
        r306_12 = r306_9 + 86400
    end
    return r306_12 - r306_4
end

-- line 7522-7539
-- proto#307 params=1 locals=25 upvalues=0 vararg=false
function formatTime(p307_0)
    local r307_0 = _G.string.format("%d", _G.math.floor(p307_0 / 3600))
    local r307_1 = _G.math.fmod(p307_0, 3600)
    local r307_2 = _G.string.format("%d", _G.math.floor(r307_1 / 60))
    local r307_3 = _G.string.format("%d", _G.math.fmod(_G.math.fmod(p307_0, 3600), 60))
    local r307_4
    if p307_0 >= 3600 then
        local r307_5 = "00" .. r307_2
        local r307_6 = _G.string.sub(r307_5, #r307_5 - 1, #r307_5)
        local r307_7 = "00" .. r307_3
        local r307_8 = _G.string.sub(r307_7, #r307_7 - 1, #r307_7)
        r307_4 = r307_0 .. ":" .. r307_6 .. ":" .. r307_8
    else
        local r307_9 = "00" .. r307_3
        local r307_10 = _G.string.sub(r307_9, #r307_9 - 1, #r307_9)
        r307_4 = r307_2 .. ":" .. r307_10
    end
    return r307_4
end

-- line 7541-7591
-- proto#308 params=1 locals=13 upvalues=0 vararg=false
function isEpisodeCompleted(p308_0)
    if actions.myLevels[p308_0] == nil then
        return false
    end
    local r308_0 = getEpisodeMetadata(p308_0)
    if r308_0.eggsteroidEpisode or r308_0.antennaEggEpisode or r308_0.featherBonusEpisode then
        for r308_1, r308_2 in _G.ipairs(actions.myLevels[p308_0]) do
            local r308_3 = getLevelMetadata(r308_2)
            if not (r308_3 == nil or r308_3.ignoreScore) then
                local r308_4 = true
                if r308_3.deviceRestrictions then
                    r308_4 = false
                    for r308_5, r308_6 in _G.ipairs(r308_3.deviceRestrictions) do
                        local r308_7 = deviceManufacturer
                        if r308_6 == r308_7 then
                            r308_4 = true
                            break
                        end
                    end
                end
                if r308_4 then
                    if highscores[r308_2] == nil then
                        return false
                    end
                    local r308_8 = highscores[r308_2]
                    if r308_8.score == nil and highscores[r308_2].eaglescore == nil then
                        return false
                    end
                end
            end
        end
        return true
    end
    for r308_9, r308_10 in _G.ipairs(actions.myLevels[p308_0]) do
        local r308_11 = getLevelMetadata(r308_10)
        if r308_11.lastLevelOfEpisode then
            if highscores[r308_10] == nil then
                return false
            end
            local r308_12 = highscores[r308_10]
            if r308_12.score == nil and highscores[r308_10].eaglescore == nil then
                return false
            end
        end
    end
    return true
end

-- line 7593-7598
-- proto#309 params=1 locals=0 upvalues=0 vararg=false
function appendCustomerString(p309_0)
    if customerString == "rovio" then
        return p309_0
    end
    return p309_0 .. "_" .. customerString
end

-- line 7601-7609
-- proto#310 params=3 locals=2 upvalues=0 vararg=false
function replaceTextOccurrencesInString(p310_0, p310_1, p310_2)
    local r310_0, r310_1 = _G.string.find(p310_0, p310_1)
    if r310_0 ~= nil and r310_0 >= 1 then
        return _G.string.gsub(p310_0, "(%" .. p310_1 .. ")", p310_2)
    end
    return p310_0
end

-- line 7611-7661
-- proto#311 params=1 locals=36 upvalues=0 vararg=false
function drawGravityBubble(p311_0)
    if p311_0.areaAngle == nil then
        p311_0.areaAngle = 0
    elseif not g_lineGravityVisualization then
        local r311_0 = p311_0.areaAngle
        p311_0.areaAngle = r311_0 + 0.003000000026077032
    end
    if p311_0.areaScale == nil then
        p311_0.areaScale = 0
        p311_0.increesingScale = true
    elseif p311_0.increesingScale then
        local r311_1 = p311_0.areaScale
        if r311_1 > 0.004000000189989805 then
            p311_0.increesingScale = false
        else
            local r311_2 = p311_0.areaScale
            p311_0.areaScale = r311_2 + 0.0003000000142492354
        end
    elseif p311_0.areaScale < -0.004000000189989805 then
        p311_0.increesingScale = true
    else
        local r311_3 = p311_0.areaScale
        p311_0.areaScale = r311_3 - 0.0003000000142492354
    end
    local r311_4, r311_5 = physicsToScreenTransform(p311_0.x, p311_0.y)
    local r311_6 = blockTable.blocks[p311_0.definition]
    if r311_6.type == "box" then
        if startedFromEditor then
            drawGravityFieldBounds(p311_0)
        end
    else
        local r311_7 = p311_0.radius
        local r311_8 = r311_7 * 3 * worldScale * 0.01899999938905239
        local r311_9 = r311_7 * 3 * worldScale * 0.01899999938905239
        local r311_10 = p311_0.areaAngle
        for r311_11 = 1, 4 do
            local r311_12 = blockTable.themes[currentTheme]
            setRenderState(r311_4 / r311_8, r311_5 / r311_9, r311_8, r311_9, r311_10 + (r311_11 - 1) * _G.math.pi * 0.5, res.getSpritePivot(r311_12.gravitySliceSprite))
            local r311_13 = _G.res.drawSprite
            local r311_14 = blockTable.themes[currentTheme]
            r311_13(r311_14.gravitySliceSprite, 0, 0)
        end
        local r311_15 = p311_0.areaAngle + _G.math.pi * 0.25
        for r311_16 = 1, 4 do
            local r311_17 = blockTable.themes[currentTheme]
            setRenderState(r311_4 / r311_8, r311_5 / r311_9, r311_8, r311_9, r311_15 + (r311_16 - 1) * _G.math.pi * 0.5, res.getSpritePivot(r311_17.gravitySliceSprite))
            local r311_18 = _G.res.drawSprite
            local r311_19 = blockTable.themes[currentTheme]
            r311_18(r311_19.gravitySliceSprite, 0, 0)
        end
    end
end

-- line 7664-7671
-- proto#312 params=3 locals=7 upvalues=0 vararg=false
function replaceTextOccurrences(p312_0, p312_1, p312_2)
    if p312_0 == nil then
        return
    end
    _G.assert(p312_0.lines ~= nil, "text item not clipped")
    local r312_0 = 1
    local r312_1 = p312_0.lines
    for r312_2 = r312_0, #r312_1 do
        p312_0.lines[r312_2].text = replaceTextOccurrencesInString(p312_0.lines[r312_2].text, p312_1, p312_2)
    end
end

-- line 7677-7691
-- proto#313 params=2 locals=6 upvalues=0 vararg=false
function getText(p313_0, p313_1)
    if not p313_0 then
        return
    end
    local r313_0 = _G.res.getString("TEXTS_BASIC", p313_0)
    if p313_1 then
        local r313_1, r313_2, r313_3 = _G.ipairs(p313_1)
        r313_4 = r313_0
        for r313_5, r313_6 in r313_1, r313_2, r313_3 do
            if r313_5 % 2 == 1 then
                r313_4 = _G.string.gsub(r313_4, r313_6, p313_1[r313_5 + 1])
            end
        end
    end
    local r313_4
    return r313_4
end

-- line 7694-7707
-- proto#314 params=2 locals=8 upvalues=0 vararg=false
function comicFinished(p314_0, p314_1)
    local r314_0 = false
    local r314_1 = getLevelMetadata(p314_0)
    if r314_1.episodeEndComic then
        local r314_2 = SettingsWrapper:isComicWatched(p314_0)
        local r314_3
        if r314_2 == true then
            r314_3 = r314_0
        else
            local r314_4 = getLevelMetadata(p314_0)
            r314_3 = r314_4.showEpisodeCompleteDialog
        end
        local r314_5 = getLevelMetadata(p314_0)
        local r314_6 = r314_5.lastComicOfGame
        local r314_7 = eventManager
        local r314_8 = {
            id = events.EID_INIT_EPISODE_COMPLETED_ACTIONS,
            showDialogs = r314_3,
            comicWatched = r314_2,
            lastComicOfGame = r314_6
        }
        r314_7:queueEvent(r314_8)
    end
    SettingsWrapper:storeComicWatched(p314_0)
end

-- line 7709-7711
-- proto#315 params=0 locals=1 upvalues=0 vararg=false
function isBuildUnlocked()
    local r315_0
    if releaseBuild == true then
        r315_0 = false
    else
        r315_0 = cheatsEnabled == true
    end
    return r315_0
end

-- line 7713-7734
-- proto#316 params=1 locals=11 upvalues=0 vararg=false
function drawGravityFieldBounds(p316_0)
    local r316_0, r316_1 = physicsToScreenTransform(p316_0.x, p316_0.y)
    gr = p316_0.width
    local r316_2 = worldScale
    setRenderState(r316_0 / r316_2, r316_1 / r316_2, r316_2, r316_2, 0, 0, 0)
    local r316_3 = physicsToWorldTransform
    local r316_4 = p316_0.width * 0.5
    local r316_5 = p316_0.height
    local r316_6, r316_7 = r316_3(r316_4, r316_5 * 0.5)
    local r316_8 = transformCoordinates(p316_0.angle, -r316_6, -r316_7)
    local r316_9 = transformCoordinates(p316_0.angle, r316_6, -r316_7)
    local r316_10 = transformCoordinates(p316_0.angle, -r316_6, r316_7)
    local r316_11 = transformCoordinates(p316_0.angle, r316_6, r316_7)
    local r316_12 = transformCoordinates(p316_0.angle, 0, 0)
    local r316_13 = transformCoordinates(p316_0.angle, 0, -r316_7)
    drawLine2D(r316_8.x, r316_8.y, r316_9.x, r316_9.y, 2 * gameWorldScale, 255, 255, 255, 255)
    drawLine2D(r316_9.x, r316_9.y, r316_11.x, r316_11.y, 2 * gameWorldScale, 255, 255, 255, 255)
    drawLine2D(r316_11.x, r316_11.y, r316_10.x, r316_10.y, 2 * gameWorldScale, 255, 255, 255, 255)
    drawLine2D(r316_10.x, r316_10.y, r316_8.x, r316_8.y, 2 * gameWorldScale, 255, 255, 255, 255)
    drawLine2D(r316_12.x, r316_12.y, r316_13.x, r316_13.y, 2 * gameWorldScale, 255, 255, 255, 255)
end

-- line 7738-7740
-- proto#317 params=0 locals=0 upvalues=0 vararg=false
function clearLuaForceFunctions()
    g_forceFunctions = {}
end

-- line 7743-7747
-- proto#318 params=0 locals=3 upvalues=0 vararg=false
function applyForcesAtPhysicsStep()
    for r318_0, r318_1 in _G.ipairs(g_forceFunctions) do
        r318_1()
    end
end

-- line 7749-7752
-- proto#319 params=1 locals=0 upvalues=0 vararg=false
function mightyEagleNotificationCallback(p319_0)

end

-- line 7754-7760
-- proto#320 params=5 locals=1 upvalues=0 vararg=false
function applyForce(p320_0, p320_1, p320_2, p320_3, p320_4)
    _G.table.insert(g_forceFunctions, function()
        if objects.world[p320_0] ~= nil then
            applyForceNative(p320_0, p320_1, p320_2, p320_3, p320_4)
        end
    end)
end

-- line 7764-7779
-- proto#322 params=2 locals=10 upvalues=0 vararg=false
function getJointedObjects(p322_0, p322_1)
    local r322_0 = {}
    for r322_1, r322_2 in _G.pairs(p322_0) do
        if r322_2.end1 and r322_2.end2 and (r322_2.end1 == p322_1 or r322_2.end2 == p322_1) then
            if r322_2.end1 == p322_1 then
                if r322_2.end2 ~= p322_1 then
                    _G.table.insert(r322_0, objects.world[r322_2.end2])
                end
            else
                _G.table.insert(r322_0, objects.world[r322_2.end1])
            end
        end
    end
    return r322_0
end

-- line 7783-7792
-- proto#323 params=2 locals=6 upvalues=0 vararg=false
function filterOutNeededGraphics(p323_0, p323_1)
    for r323_0 = 1, #p323_0 do
        for r323_1 = 1, #p323_1 do
            local r323_2 = p323_0[r323_0]
            local r323_3 = p323_1[r323_1]
            if r323_2 == r323_3 then
                print("filter out graphics needed for comics - filtering out: " .. p323_1[r323_1])
                _G.table.remove(p323_1, r323_1)
            end
        end
    end
end

-- line 7794-7839
-- proto#324 params=1 locals=34 upvalues=0 vararg=false
function checkAndLoadTheme(p324_0)
    local r324_0 = currentTheme
    if p324_0 == r324_0 then
        local r324_1 = _G.tostring(currentTheme)
        local r324_2 = _G.tostring(p324_0)
        loginfo("checkAndLoadTheme() theme remains the same (" .. r324_1 .. " = " .. r324_2 .. [[)
]])
    else
        local r324_3 = _G.tostring(currentTheme)
        local r324_4 = _G.tostring(p324_0)
        loginfo("checkAndLoadTheme() changing theme from " .. r324_3 .. " to " .. r324_4)
    end
    local r324_5 = getLevelMetadata(levelName)
    if r324_5.additinalLoadGroups then
        releaseImages({ g_defaultLoadGroups.ingame })
        local r324_6 = loadImages
        local r324_7 = getLevelMetadata(levelName)
        r324_6(r324_7.additinalLoadGroups)
        local r324_8 = getLevelMetadata(levelName)
        g_releaseGroups = r324_8.additinalLoadGroups
    else
        loadImages({ g_defaultLoadGroups.ingame })
    end
    if currentTheme ~= p324_0 then
        if currentTheme ~= nil then
            local r324_9 = _G.tostring(currentTheme)
            loginfo(" ------- Releasing old theme: " .. r324_9)
            local r324_10 = blockTable.themes[currentTheme]
            local r324_11 = r324_10.loadListGroup
            if getLevelMetadata(levelName).additinalLoadGroups ~= nil then
                local r324_12 = blockTable.themes[currentTheme]
                local r324_13 = r324_12.loadListGroup
                r324_11 = {}
                for r324_14 = 1, #r324_13 do
                    _G.table.insert(r324_11, r324_13[r324_14])
                end
                local r324_15 = filterOutNeededGraphics
                local r324_16 = getLevelMetadata(levelName)
                r324_15(r324_16.additinalLoadGroups, r324_11)
            end
            releaseImages(r324_11)
        end
        loginfo(" ---------- Loading theme: " .. p324_0)
        loadImages(blockTable.themes[p324_0].loadListGroup)
        currentTheme = p324_0
    end
end

-- line 7841-7843
-- proto#325 params=2 locals=1 upvalues=0 vararg=false
function contains(p325_0, p325_1)
    return find_key(p325_0, p325_1) ~= nil
end

-- line 7845-7852
-- proto#326 params=2 locals=3 upvalues=0 vararg=false
function find_key(p326_0, p326_1)
    for r326_0, r326_1 in _G.pairs(p326_0) do
        if p326_1 == r326_1 then
            return r326_0
        end
    end
    return nil
end

-- line 7855-7860
-- proto#327 params=3 locals=2 upvalues=0 vararg=false
function setInstalledApps(p327_0, p327_1, p327_2)
    possibleInstalledApps = {}
    importJSONToLuaTable(p327_2, "possibleInstalledApps")
    SettingsWrapper:setInstalledApps(p327_0, p327_1, getCurrentTime(), possibleInstalledApps)
    print("Installed Apps received: " .. p327_0 .. " with a ttl of " .. p327_1 .. [[
]])
end

-- line 7862-7866
-- proto#328 params=1 locals=7 upvalues=0 vararg=false
function setInstalledAppsOffline(p328_0)
    SettingsWrapper:setInstalledApps(p328_0)
    local r328_0 = getTimeDifferenceInSeconds(getCurrentTime(), SettingsWrapper:getInstalledAppsLastCheck())
    local r328_1 = print
    local r328_2 = SettingsWrapper:getInstalledAppsTTL()
    local r328_3 = "Installed Apps checked offline: " .. p328_0 .. ". Next app list update in " .. r328_2 - r328_0 / 3600 .. [[ hours.
]]
    r328_1(r328_3)
end

-- line 7869-7871
-- proto#329 params=1 locals=2 upvalues=0 vararg=false
function lua_onBeforeJointRemove(p329_0)
    local r329_0 = eventManager
    local r329_1 = { id = events.EID_JOINT_REMOVED, jointName = p329_0 }
    r329_0:notify(r329_1)
end

-- line 7874-7880
-- proto#330 params=1 locals=0 upvalues=0 vararg=false
function twitterWindowClosed(p330_0)
    if p330_0 then
        print("Twitter Window Closed and message sent!")
    else
        print("Twitter window closed and message NOT sent!")
    end
end

-- line 7885-7887
-- proto#331 params=0 locals=0 upvalues=0 vararg=false
function onPaymentProviderSelected()
    eventManager:notify({ id = events.EID_PAYMENT_PROVIDER_SELECTED })
end

-- line 7891-7908
-- proto#332 params=2 locals=2 upvalues=0 vararg=false
function setGameObjectActive(p332_0, p332_1)
    if checkStillInWorld(p332_0) then
        local r332_0 = objects.world[p332_0]
        r332_0.active = p332_1
        local r332_1 = getObjectDefinition(r332_0.name)
        if r332_1.onActiveStateChange then
            fireAction(r332_1.onActiveStateChange, { name = p332_0, active = p332_1 })
        end
    end
end

toggleZoom_GameLua = toggleZoomSteps

-- line 7911-7923
-- proto#333 params=0 locals=4 upvalues=0 vararg=false
function toggleZoom()
    local r333_0 = cameraAnimationSliderTarget
    local r333_1 = minWorldScale
    local r333_2
    if r333_0 == 0 then
        local r333_3 = objects.birdCameraData[deviceModel]
        r333_2 = r333_3.sx
    else
        local r333_4 = objects.castleCameraData[deviceModel]
        r333_2 = r333_4.sx
    end
    toggleZoom_GameLua(r333_1, r333_2, currentZoomedScale, 3)
end
