-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

episodeTypeIndexIncrement = 100
defaultForceDrag = 3.5
defaultAngularDrag = 2
defaultForceAngularDrag = 5
defaultYodaForceDrag = 2
defaultYodaForceAngularDrag = 2
defaultHoveringForceDrag = 0.5
TARGET_VISUALIZATION_TIMER_TIME = 2
TARGET_VISUALIZATION_WAIT_LEVEL_START = 2
TARGET_VISUALIZATION_WAIT_FOR_USER_INPUT = 10
g_targetVisualizationUserInputWaitTimer = TARGET_VISUALIZATION_WAIT_LEVEL_START
g_targetVisualizationDefaultSprites = {
    "P_TARGET_MARKER_5",
    "P_TARGET_MARKER_4",
    "P_TARGET_MARKER_3",
    "P_TARGET_MARKER_2",
    "P_TARGET_MARKER_1",
    "P_TARGET_MARKER_1",
    "P_TARGET_MARKER_1"
}
g_targetVisualizationEffectScale = 0.5
g_targetVisualizationEffectSpriteScale = 2
g_useNewBirdLaunch = true
birdLevels = {}
g_defaultLoadGroups = {
    achievements = "ACHIEVEMENTS",
    buttons = "BUTTONS",
    ingame = "INGAME",
    menu = "MENU",
    menu_common = "MENU_COMMON",
    theme_common = "THEME_COMMON",
    splashes = "SPLASHES",
    tutorials_powerups = "TUTORIALS_POWERUP"
}
forceGlowFadeTimer = 0.30000001192092896

-- line 49-51
-- proto#1 params=0 locals=2 upvalues=0 vararg=false
function isPlatformLimited()
    local r1_0
    if deviceModel == "wp8" then
        r1_0 = true
    elseif deviceModel == "osx" then
        r1_0 = true
    elseif deviceModel == "blackberry" then
        r1_0 = true
    elseif deviceModel == "android" then
        r1_0 = not isIapEnabled()
    else
        r1_0 = false
    end
    return r1_0
end

-- line 54-75
-- proto#2 params=0 locals=0 upvalues=0 vararg=false
function initializeGame()
    birdLevels = SettingsWrapper:getBirdLevels()
    if birdLevels == nil then
        birdLevels = {}
        birdLevels.RedBird = 1
        birdLevels.SmallBlueBird = 1
        birdLevels.RedBigBird = 1
        birdLevels.BlackBird = 1
        birdLevels.LaserBird = 1
        birdLevels.PinkBird = 1
        birdLevels.LandoBird = 1
        SettingsWrapper:levelUpBird("RedBird", 1)
        SettingsWrapper:levelUpBird("SmallBlueBird", 1)
        SettingsWrapper:levelUpBird("RedBigBird", 1)
        SettingsWrapper:levelUpBird("BlackBird", 1)
        SettingsWrapper:levelUpBird("LaserBird", 1)
        SettingsWrapper:levelUpBird("PinkBird", 1)
        SettingsWrapper:levelUpBird("LandoBird", 1)
    end
    initializeBulletTime()
end

-- line 77-83
-- proto#3 params=0 locals=0 upvalues=0 vararg=false
function isRetinaPC()
    if deviceModel == "osx" and getFullScreenWidth() >= 2048 then
        return true
    end
    return false
end

-- line 85-92
-- proto#4 params=0 locals=0 upvalues=0 vararg=false
function initializeBulletTime()
    bulletTimeDuration = 0
    bulletTimeSmoothIn = 0
    bulletTimeSmoothOut = 0
    bulletTimeMultiplier = 1
    bulletTimeTimer = 0
    setDeltaTimeMultiplier(1)
end

-- line 94-101
-- proto#5 params=4 locals=1 upvalues=0 vararg=false
function activateBulletTime(p5_0, p5_1, p5_2, p5_3)
    local r5_0 = p5_0 + p5_1 + p5_2
    bulletTimeTimer = r5_0
    bulletTimeDuration = r5_0
    bulletTimeSmoothIn = p5_0
    bulletTimeSmoothOut = p5_2
    bulletTimeMultiplier = p5_3
end

-- line 103-125
-- proto#6 params=1 locals=3 upvalues=0 vararg=false
function updateBulletTime(p6_0)
    if bulletTimeTimer <= 0 then
        return
    end
    local r6_0 = bulletTimeTimer
    local r6_1 = getDeltaTimeMultiplier()
    bulletTimeTimer = r6_0 - p6_0 / r6_1
    local r6_2 = bulletTimeTimer
    local r6_3
    if r6_2 > 0 then
        if bulletTimeDuration - bulletTimeTimer <= bulletTimeSmoothIn then
            r6_3 = 1 - (bulletTimeDuration - bulletTimeTimer) / bulletTimeSmoothIn * (1 - bulletTimeMultiplier)
        elseif bulletTimeTimer <= bulletTimeSmoothOut then
            r6_3 = 1 - (1 - bulletTimeMultiplier) * (bulletTimeTimer / bulletTimeSmoothOut)
        else
            r6_3 = bulletTimeMultiplier
        end
    else
        bulletTimeTimer = 0
        r6_3 = 1
    end
    setDeltaTimeMultiplier(r6_3)
end

-- line 127-314
-- proto#7 params=0 locals=9 upvalues=0 vararg=false
function initializeGameMenus()
    loadLuaFileToObject(commonScriptPath .. "/ui_components/Frame.lua", this, "ui")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/AnchorFrame.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/TextButton.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/Image.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/BGBox.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/BackgroundBox.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/ImageButton.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/Rectangle.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/ScallableButton.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/CounterButton.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/StaticButton.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/ProgressBar.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/ToggleButton.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/GridFrame.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/SliderFrame.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/ScrollFrame2.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/ui_components/Slider.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/Prompt.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/ImagePrompt.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/ConfirmPrompt.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/CrimsonSupportPrompt.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/PowerupIAPPopup.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/RewardPopup.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/GameHud.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/LevelButton.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/MightyFalcon.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/EpisodeButton.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/BobaEpisodeButton.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/EpisodeSelectionFrame.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/PausePage.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/AnimatedTutorial.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/main_menu.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/CreditsFrame.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/PowerupSlider.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/PulsatingCounterButton.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/PowerUpMachineFrame.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/Text.lua", this.ui, "")
    if this.gamerService == nil then
        if this.gamerService == nil and deviceModel == "wp8" then
            GAMERSERVICE_DEVMODE = true
            loadLuaFile(scriptPath .. "/xboxlive/achievements.lua", "", false, false)
            loadLuaFile(scriptPath .. "/xboxlive/leaderboards.lua", "", false, false)
            loadLuaFileToObject(commonScriptPath .. "/timer.lua", this, "util")
            loadLuaFileToObject(commonScriptPath .. "/gamerservice/GamerService.lua", this, "gamerService")
            loadLuaFileToObject(commonScriptPath .. "/devmode/GamerService.lua", this.gamerService, "")
            loadLuaFileToObject(scriptPath .. "/gamerservice/GamerServices.lua", this.gamerService, "")
            loadLuaFileToObject(scriptPath .. "/devmode/GamerService.lua", this.gamerService, "")
            this.gamerService:init()
        end
    else
        loadLuaFileToObject(commonScriptPath .. "/timer.lua", this, "util")
        loadLuaFileToObject(commonScriptPath .. "/gamerservice/GamerService.lua", this, "gamerService")
        loadLuaFileToObject(scriptPath .. "/gamerservice/GamerServices.lua", this.gamerService, "")
        this.gamerService:init()
    end
    if deviceModel == "metro" then
        loadLuaFileToObject(commonScriptPath .. "/ui_components/MetroSnapBar.lua", this.ui, "")
    end
    loadLuaFile(scriptPath .. "/iap.lua", "", false, false)
    loadLuaFileToObject(scriptPath .. "/menus/KeyBoard.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/TrophyRoomData.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/TrophyRoom.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/pause.lua", this, "pause")
    loadLuaFileToObject(scriptPath .. "/menus/StartSequencePage.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/comicPage1.lua", this.ui, "")
    loadLuaFileToObject(scriptPath .. "/menus/WarpTransition.lua", this.ui, "")
    loadLuaFileToObject(commonScriptPath .. "/game_center.lua", this.ui, "")
    loadLuaFile(scriptPath .. "/menus/ProcessManager.lua", "", false, false)
    loadLuaFile(scriptPath .. "/menus/MEPage.lua", "", false, false)
    loadLuaFile(scriptPath .. "/menus/TrialVersionPopup.lua", "", false, false)
    if cheatsEnabled then
        loadLuaFile(scriptPath .. "/menus/QAPage.lua", "", false, false)
    end
    loadLuaFile(commonScriptPath .. "/utils.lua", "", false, false)
    loadLuaFile(commonScriptPath .. "/math.lua", "", false, false)
    loadLuaFile(commonScriptPath .. "/ui_components/FrameUtils.lua", "", false, false)
    initializeIapSystem()
    loadLuaFileToObject(commonScriptPath .. "/trackpad.lua", this, "OSX")
    local r7_0 = _G.tostring(showEditor)
    print("showEditor == " .. r7_0)
    if showEditor then
        loadLuaFile(commonScriptPath .. "/../editor/EditorUtils.lua", "", false, false)
        loadLuaFileToObject(commonScriptPath .. "/../editor/EditorScene.lua", this.ui, "")
        loadLuaFileToObject(commonScriptPath .. "/../editor/editableAttributes.lua", this, "editableAttributes")
        keyDefinitions = {}
        loadLuaFileToObject(commonScriptPath .. "/../editor/KeyDefinitions.lua", this.keyDefinitions, "")
        propertyDefinitions = {}
        loadLuaFileToObject(commonScriptPath .. "/../editor/PropertyDefinitions.lua", this.propertyDefinitions, "")
        loadLuaFileToObject(commonScriptPath .. "/../editor/JointDefinitions.lua", this.ui, "")
        loadLuaFileToObject(commonScriptPath .. "/../editor/JointPage.lua", this.ui, "")
        loadLuaFileToObject(commonScriptPath .. "/../editor/BlockAttributesPage.lua", this.ui, "")
        loadLuaFileToObject(commonScriptPath .. "/../editor/EditorLevelSelection.lua", this.ui, "")
        loadLuaFileToObject(commonScriptPath .. "/../editor/PropertyEditor.lua", this.ui, "")
        ui.EditorScene.groupOrders = {}
        loadLuaFileToObject(scriptPath .. "/editor/GroupOrders.lua", this.ui, "")
    end
    if channelEnabled then
        loadLuaFile(scriptPath .. "/channel/ChannelManager.lua", "", false, false)
        loadLuaFileToObject(scriptPath .. "/channel/ChannelButton.lua", this.ui, "")
        loadLuaFileToObject(scriptPath .. "/channel/LoadingScreen.lua", this.ui, "")
        loadLuaFileToObject(scriptPath .. "/channel/ChannelIntroPopup.lua", this.ui, "")
    end
    if _G.RovioShelf then
        print("_G.RovioShelf available")
    end
    if RovioShelf then
        print("loading Rovio shelf lua file")
        loadLuaFile(commonScriptPath .. "/RovioShelf.lua", "", false, false)
    end
    loadLuaFileToObject(scriptPath .. "/shop/Shop.lua", this.ui, "")
    local r7_1 = scriptPath .. "/shop/ShopData.lua"
    loadLuaFileToObject(r7_1, this.ui.Shop, "")
    g_isRegistered = true
    if gamerService then
        g_isRegistered = not gamerService:isTrial()
    elseif g_registrationEnabled then
        if steam then
            g_isRegistered = not not steam.registered
        else
            loadLuaFileToObject(scriptPath .. "/menus/RegistrationDialog.lua", this, "DRM")
            loadLuaFileToObject(scriptPath .. "/PC_DRM.lua", this.DRM, "")
            g_isRegistered = DRM.checkRegistration()
        end
    end
    if isPCVersion() then
        loadLuaFileToObject(scriptPath .. "/menus/resolution.lua", this, "")
        loadLuaFileToObject(scriptPath .. "/menus/UpdatePrompt.lua", this.ui, "")
        loadLuaFileToObject(scriptPath .. "/menus/GesturePausePage.lua", this.ui, "")
        g_gesturePausePage = ui.GesturePausePage:new()
        eventManager:addEventListener(events.EID_LEVEL_FAILED, gesturePausePageEventListener)
        eventManager:addEventListener(events.EID_LEVEL_COMPLETED, gesturePausePageEventListener)
    end
    if isIOSFree() then
        loadLuaFile(scriptPath .. "/menus/GetFullVersionPage.lua", "", false, false)
        loadLuaFile(scriptPath .. "/menus/TimedGetFullVersionPage.lua", "", false, false)
    end
    eventManager:addEventListener(events.EID_GAME_PAUSED, pauseGameEventListener)
    eventManager:addEventListener(events.EID_PAYMENT_PROVIDER_SELECTED, paymentProviderSelectedEventListener)
    processManager = ProcessManager:new()
    notificationsFrame = ui.Frame:new()
    if isIapEnabled() then
        loadLuaFileToObject(scriptPath .. "/PowerupManager.lua", this, "")
        loadLuaFileToObject(scriptPath .. "/menus/PowerupIAPPopup.lua", this.ui, "")
        powerups = true
    end
end

paymentProviderSelectedEventListener = {
    eventTriggered = function(p8_0, p8_1)
        _G.assert(p8_1.id == "EID_PAYMENT_PROVIDER_SELECTED")
        if deviceModel == "android" and isIapEnabled() then
            SettingsWrapper:setIAPRestoreChecked()
            print([[<iap> attempting iap restore
]])
            iapRestoreItems("iapRestoreCallback")
        end
    end
}
pauseGameEventListener = {
    eventTriggered = function(p9_0, p9_1)
        cancelBirdDrag()
    end
}
gesturePausePageEventListener = {
    eventTriggered = function(p10_0, p10_1)
        _G.assert(p10_1.id == "EID_LEVEL_COMPLETED" and true or p10_1.id == "EID_LEVEL_FAILED")
        print("gesturePausePageEventListener " .. p10_1.id .. [[.
]])
        if not g_gesturePausePage.visible then
            return
        end
        g_gesturePausePage:close()
    end
}

-- line 351-360
-- proto#11 params=0 locals=0 upvalues=0 vararg=false
function loadGameCenter()
    loadLuaFile(scriptPath .. "/achievementsLogic.lua", "", false, false)
    loadLuaFile(scriptPath .. "/menus/AchievementPopup.lua", "", false, false)
    loadLuaFile(scriptPath .. "/leaderboardsLogic.lua", "", false, false)
    initializeAchievements()
    initializeLeaderboards()
end

-- line 362-371
-- proto#12 params=0 locals=3 upvalues=0 vararg=false
function startInitialLoading()
    initializeGame()
    createAssets()
    restoreSettings()
    local r12_0 = SettingsWrapper:daysSinceLastPlay()
    local r12_1 = eventManager
    local r12_2 = { id = events.EID_GAME_SESSION_START, daysSinceLastPlay = r12_0 }
    r12_1:notify(r12_2)
    SettingsWrapper:resetSessionStartTime()
end

-- line 374-376
-- proto#13 params=0 locals=0 upvalues=0 vararg=false
function reloadCrimsonSupportLua()
    loadLuaFileToObject(scriptPath .. "/menus/PowerupIAPPopup.lua", this.ui, "")
end

-- line 379-396
-- proto#14 params=0 locals=0 upvalues=0 vararg=false
function startSequenceEnded()
    loadLuaFile(scriptPath .. "/menus/level_end.lua", "", false, false)
    menuManager:addLink("GameScene", GameScene:new())
    if showEditor == true and releaseBuild ~= true then
        menuManager:addLink("editorScene", ui.EditorScene:new())
    end
    gotoMenuLevel("MainMenu")
    splashShown = true
    handleResolutionPopup()
    if PowerupManager and not SettingsWrapper:wereInitialPowerupsGiven() then
        PowerupManager:giveInitialPowerups()
        SettingsWrapper:setInitialPowerupsGiven()
    end
end

-- line 398-494
-- proto#15 params=0 locals=32 upvalues=0 vararg=false
function initializeEventSystem()
    actions = {}
    loadLuaFileToObject(scriptPath .. "/actions.lua", this, "actions")
    loadLuaFileToObject(scriptPath .. "/actions_birds.lua", this, "bird_actions")
    loadLuaFileToObject(scriptPath .. "/actions_trenchrun.lua", this, "trenchrun_actions")
    loadLuaFileToObject(scriptPath .. "/actions_mynockLogic.lua", this, "mynock_actions")
    loadLuaFileToObject(scriptPath .. "/actions_empire_strikes_back_bf.lua", this, "actions_empire_strikes_back_bf")
    loadLuaFileToObject(scriptPath .. "/actions_deathstar_2_bf.lua", this, "actions_deathstar_2_bf")
    loadLuaFileToObject(scriptPath .. "/actions_levelGoalsLogic.lua", this, "levelGoals_actions")
    loadLuaFileToObject(scriptPath .. "/actions_bonus.lua", this, "bonus_actions")
    loadLuaFileToObject(scriptPath .. "/actions_menuStructure.lua", this, "menuStructure_actions")
    loadLuaFileToObject(scriptPath .. "/actions_powerups.lua", this, "powerups_actions")
    if isIOSFree() then
        loadLuaFileToObject(scriptPath .. "/levelOrder_free.lua", this.menuStructure_actions, "")
    else
        loadLuaFileToObject(scriptPath .. "/levelOrder.lua", this.menuStructure_actions, "")
    end
    loadLuaFileToObject(scriptPath .. "/actions_pigEmotions.lua", this, "pigEmotions_actions")
    loadLuaFileToObject(scriptPath .. "/buildSettings.lua", this, "buildSettings")
    buildSettings.Initialize()
    actions.Initialize()
    bird_actions.Initialize()
    trenchrun_actions.Initialize()
    bonus_actions.Initialize()
    menuStructure_actions.Initialize()
    pigEmotions_actions.Initialize()
    mynock_actions.Initialize()
    actions_empire_strikes_back_bf.Initialize()
    powerups_actions.Initialize()
    actions_deathstar_2_bf.Initialize()
    for r15_0, r15_1 in _G.pairs(mynock_actions) do
        actions[r15_0] = r15_1
    end
    for r15_2, r15_3 in _G.pairs(actions_empire_strikes_back_bf) do
        actions[r15_2] = r15_3
    end
    for r15_4, r15_5 in _G.pairs(actions_deathstar_2_bf) do
        actions[r15_4] = r15_5
    end
    for r15_6, r15_7 in _G.pairs(levelGoals_actions) do
        actions[r15_6] = r15_7
    end
    for r15_8, r15_9 in _G.pairs(bird_actions) do
        actions[r15_8] = r15_9
    end
    for r15_10, r15_11 in _G.pairs(trenchrun_actions) do
        actions[r15_10] = r15_11
    end
    for r15_12, r15_13 in _G.pairs(bonus_actions) do
        actions[r15_12] = r15_13
    end
    for r15_14, r15_15 in _G.pairs(menuStructure_actions) do
        actions[r15_14] = r15_15
    end
    for r15_16, r15_17 in _G.pairs(pigEmotions_actions) do
        actions[r15_16] = r15_17
    end
    for r15_18, r15_19 in _G.pairs(powerups_actions) do
        actions[r15_18] = r15_19
    end
    bird_actions = nil
    trenchrun_actions = nil
    bonus_actions = nil
    menuStructure_actions = nil
    pigEmotions_actions = nil
    eventCalls = {}
    numEventCalls = 0
    updateCalls = {}
    if buildSettings.getEpisodeSelectionName() ~= "EpisodeSelection" then
        actions.myLevelsMetadata[buildSettings.getEpisodeSelectionName()] = actions.myLevelsMetadata.EpisodeSelection
    end
end

-- line 496-508
-- proto#16 params=0 locals=3 upvalues=0 vararg=false
function getPCSplashGroup()
    local r16_0
    if SettingsWrapper:getScreenWidth() then
        if SettingsWrapper:getScreenHeight() then
            local r16_1 = SettingsWrapper:getScreenWidth()
            local r16_2 = SettingsWrapper:getScreenHeight()
            r16_0 = r16_1 / r16_2
        else
            r16_0 = screenWidth / screenHeight
        end
    else
        r16_0 = screenWidth / screenHeight
    end
    if r16_0 < 1.4500000476837158 then
        return "1024x768"
    end
    return "pc"
end

-- line 510-668
-- proto#17 params=1 locals=2 upvalues=0 vararg=false
function selectAssetProfile(p17_0)
    local r17_0
    local r17_1 = p17_0 == "TUTORIALS" or p17_0 == "BUTTONS" or p17_0 == "SPLASHES" or p17_0 == "MENU" or p17_0 == "MENU_COMPOSPRITES" or p17_0 == "PANAMA_AD" or p17_0 == "TUTORIALS_POWERUP"
    local r17_2 = p17_0 == "TUTORIALS_POWERUP" or p17_0 == "EPISODE_SELECTION" or p17_0 == "GALLERY" or p17_0 == "INGAME" or p17_0 == "MENU_COMMON" or p17_0 == "THEME_COMMON" or _G.string.find(p17_0, "^STORY_") or _G.string.find(p17_0, "^THEME_")
    if deviceModel == "iphone" then
        r17_0 = "480x320"
        if isLiteVersion then
            r17_0 = r17_0 .. "_free"
        end
    elseif deviceModel == "iphone4" or deviceModel == "iphone5" then
        r17_0 = p17_0 == "SPLASHES" and screenWidth == 1136 and "1280x800" or r17_1 and "960x640" or "480x320"
        if isLiteVersion then
            r17_0 = r17_0 .. "_free"
        end
    elseif deviceModel == "ipad" then
        r17_0 = "1024x768"
        if isIpad3() then
            if r17_1 then
                r17_0 = "2048x1536"
            else
                r17_0 = r17_0
            end
        else
            r17_0 = r17_0
        end
        if isLiteVersion then
            r17_0 = r17_0 .. "_free"
        end
    elseif deviceModel == "n900" then
        r17_0 = "864x480"
        if isLiteVersion then
            r17_0 = r17_0 .. "_free"
        end
    elseif deviceModel == "s60" then
        r17_0 = applyChinaRestictions and p17_0 == "CHINA" and "640x360_china" or "640x360"
        if isLiteVersion and p17_0 ~= "CHINA" then
            r17_0 = r17_0 .. "_free"
        end
    elseif deviceModel == "windows" or deviceModel == "osx" then
        if isRetinaPC() then
            r17_0 = "pc_retina"
        elseif p17_0 == "SPLASHES" then
            r17_0 = getPCSplashGroup()
        else
            r17_0 = "pc"
        end
    elseif deviceModel == "metro" then
        r17_0 = "w8"
    elseif deviceModel == "palm" then
        local r17_3 = screenWidth
        if r17_3 >= 480 then
            r17_0 = "480x320"
            if isLiteVersion then
                r17_0 = r17_0 .. "_free"
            end
        else
            r17_0 = "400x320"
            if isLiteVersion then
                r17_0 = r17_0 .. "_free"
            end
        end
    elseif deviceModel == "android" then
        if r17_2 then
            if p17_0 == "TUTORIALS_POWERUP" and isHDVersion and screenWidth >= 2048 then
                r17_0 = "2048x1536"
            else
                r17_0 = "android_common"
            end
        elseif isHDVersion and screenWidth >= 2048 then
            local r17_4 = screenWidth / screenHeight
            r17_0 = "1280x800"
            if r17_1 and p17_0 == "SPLASHES" and screenWidth / screenHeight > 1.4500000476837158 then
                r17_0 = "1280x800"
            end
        elseif p17_0 == "MENU" and screenWidth == 1024 and screenHeight <= 600 then
            if isHDVersion then
                r17_0 = "1024x600"
            else
                r17_0 = "854x480"
            end
        elseif p17_0 == "SPLASHES" then
            if isHDVersion then
                if screenWidth / screenHeight <= 1.649999976158142 and screenWidth >= 2048 then
                    r17_0 = "2048x1536"
                else
                    r17_0 = "1280x800"
                end
            elseif screenWidth <= 480 then
                r17_0 = "480x320_android"
            else
                r17_0 = "854x480"
            end
        elseif isHDVersion and screenHeight >= 1536 then
            r17_0 = "2048x1536"
        elseif isHDVersion or screenHeight >= 720 then
            r17_0 = "1280x800"
        else
            local r17_5 = screenHeight
            if r17_5 >= 480 then
                r17_0 = "854x480"
            else
                r17_0 = "480x320_android"
            end
        end
    elseif deviceModel == "blackberry" then
        r17_0 = "Blackberry"
    elseif deviceModel == "wp7" then
        r17_0 = "800x480_wp7"
    elseif deviceModel == "wp8" then
        r17_0 = "800x480_wp8"
    end
    return r17_0
end

-- line 671-733
-- proto#18 params=0 locals=5 upvalues=0 vararg=false
function selectFontProfile()
    local r18_0 = "480x320"
    if deviceModel == "iphone" then
        local r18_1 = "480x320"
        if deviceModel == "palm" then
            if screenWidth < 480 then
                r18_0 = "400x320"
            else
                r18_0 = r18_1
            end
        else
            r18_0 = r18_1
        end
    elseif deviceModel == "palm" then
        local r18_2 = "480x320"
        if deviceModel == "palm" then
            if screenWidth < 480 then
                r18_0 = "400x320"
            else
                r18_0 = r18_2
            end
        else
            r18_0 = r18_2
        end
    elseif deviceModel == "iphone4" then
        r18_0 = "960x640"
    elseif deviceModel == "ipad" then
        local r18_3 = "1024x768"
        if isIpad3() then
            r18_0 = "2048x1536"
        else
            r18_0 = r18_3
        end
    elseif deviceModel == "n900" then
        r18_0 = "864x480"
    elseif deviceModel == "s60" then
        r18_0 = "640x360"
    elseif deviceModel == "windows" then
        if isRetinaPC() then
            r18_0 = "pc_retina"
        else
            r18_0 = "pc"
        end
    elseif deviceModel == "osx" then
        if isRetinaPC() then
            r18_0 = "pc_retina"
        else
            r18_0 = "pc"
        end
    elseif deviceModel == "metro" then
        if isRetinaPC() then
            r18_0 = "pc_retina"
        else
            r18_0 = "pc"
        end
    elseif deviceModel == "android" then
        local r18_4, r18_5
        if isHDVersion then
            local r18_6 = screenWidth
            if r18_6 >= 2048 then
                r18_0 = "2048x1536"
            elseif isHDVersion then
                r18_0 = "1024x768"
            else
                r18_4 = screenHeight
                if r18_4 >= 720 then
                    r18_0 = "1024x768"
                else
                    r18_5 = screenHeight
                    if r18_5 >= 480 then
                        r18_0 = "854x480"
                    else
                        r18_0 = "480x320"
                    end
                end
            end
        elseif isHDVersion then
            r18_0 = "1024x768"
        else
            r18_4 = screenHeight
            if r18_4 >= 720 then
                r18_0 = "1024x768"
            else
                r18_5 = screenHeight
                if r18_5 >= 480 then
                    r18_0 = "854x480"
                else
                    r18_0 = "480x320"
                end
            end
        end
    elseif deviceModel == "bada" then
        if screenHeight < 480 then
            r18_0 = "480x320"
        else
            r18_0 = "854x480"
        end
    elseif deviceModel == "blackberry" then
        r18_0 = "1024x768"
    elseif deviceModel == "wp7" then
        r18_0 = "854x480"
    elseif deviceModel == "wp8" then
        r18_0 = "854x480"
    end
    return r18_0
end

FONT_BASIC = "FONT_SPACE_BASIC"

-- line 737-739
-- proto#19 params=0 locals=0 upvalues=0 vararg=false
function getFontScore()
    return "FONT_SPACE_SCORE_TEXT"
end

-- line 741-743
-- proto#20 params=0 locals=0 upvalues=0 vararg=false
function getFontLevelselection()
    return "FONT_SPACE_LS"
end

-- line 745-747
-- proto#21 params=0 locals=0 upvalues=0 vararg=false
function getFontScoreSmall()
    return "FONT_SPACE_SCORE_SMALL"
end

-- line 749-751
-- proto#22 params=0 locals=0 upvalues=0 vararg=false
function getFontPrice()
    return "FONT_SW_PRICE"
end

-- line 753-755
-- proto#23 params=0 locals=0 upvalues=0 vararg=false
function getFontScoreBig()
    return "FONT_SPACE_SCORE_BIG"
end

-- line 757-759
-- proto#24 params=0 locals=0 upvalues=0 vararg=false
function getFontBasic()
    return "FONT_SPACE_BASIC"
end

-- line 761-763
-- proto#25 params=0 locals=0 upvalues=0 vararg=false
function getFontHeadline()
    return "FONT_SW_BIG_HEADLINE"
end

-- line 765-767
-- proto#26 params=0 locals=0 upvalues=0 vararg=false
function getFontMenu()
    return "FONT_SPACE_BASIC"
end

-- line 769-783
-- proto#27 params=0 locals=19 upvalues=0 vararg=false
function loadFonts()
    local r27_0 = selectFontProfile()
    print("Loading fonts for profile " .. r27_0)
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SPACE_SCORE_BIG.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SPACE_SCORE_TEXT.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SW_BIG_HEADLINE.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SPACE_BASIC.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SPACE_LS.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SPACE_SCORE_SMALL.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SPACE_BASIC_SMALL.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_CREDITS.dat")
    _G.res.createBitmapFont(fontPath .. "/" .. r27_0 .. "/FONT_SW_PRICE.dat")
end

-- line 786-790
-- proto#28 params=2 locals=1 upvalues=0 vararg=false
function generateRedirectURL(p28_0, p28_1)
    local r28_0 = "http://cloud.rovio.com/link/redirect/?d=" .. deviceModel .. "&p=" .. gameId .. "&a=" .. p28_0 .. "&v=" .. gameVersionNumber .. "&t=" .. p28_1 .. "&r=game&c=" .. customerString
    print("game.lua: redirect url: " .. r28_0)
    return r28_0
end

-- line 792-807
-- proto#29 params=0 locals=4 upvalues=0 vararg=false
function getVariant()
    local r29_0 = isLiteVersion and "lite" or "full"
    local r29_1 = isHDVersion and "HD" or r29_0
    local r29_2
    if applyChinaRestictions then
        r29_2 = r29_1 .. "_china"
    else
        r29_2 = r29_1
    end
    return r29_2
end

-- line 809-984
-- proto#30 params=0 locals=25 upvalues=0 vararg=false
function createStartUpAssets()
    local r30_0, r30_1
    if deviceModel == "osx" then
        g_cameraProfileList = { "ipad", "iphone" }
    elseif deviceModel == "metro" or deviceModel == "windows" then
        g_cameraProfileList = { "windows", "ipad", "iphone" }
    elseif deviceModel == "android" then
        local r30_2 = screenWidth / screenHeight
        if r30_2 > 1.399999976158142 and screenWidth < 1024 then
            g_cameraProfileList = { deviceModel, "iphone", "ipad" }
        else
            g_cameraProfileList = { deviceModel, "ipad", "iphone" }
        end
    else
        g_cameraProfileList = { deviceModel, "iphone", "ipad" }
    end
    wantedResolution = "HALF"
    changeResolution = true
    print([[------------- create startup assets ------------ 
]])
    defaultMenuFont = "FONT_SPACE_BASIC"
    LEVEL_SELECTION_VIEW_AREA_SCALE_X = 0.800000011920929
    LEVEL_SELECTION_VIEW_AREA_SCALE_Y = 0.699999988079071
    LEVEL_SELECTION_PAGE_ALIGNMENT_Y = 0.25
    LEVEL_SELECTION_PAGE_ALIGNMENT_X = 0.5
    LEVEL_SELECTION_PAGE_MAX_COLS = 5
    LEVEL_SELECTION_PAGE_MAX_ROWS = 3
    local r30_3 = isLiteVersion and "lite" or "full"
    local r30_4 = isHDVersion and "HD" or r30_3
    local r30_5
    if applyChinaRestictions then
        r30_5 = r30_4 .. "_china"
    else
        r30_5 = r30_4
    end
    local r30_6 = ""
    if customerString ~= "rovio" then
        r30_6 = "_" .. customerString
    end
    local r30_7, r30_8, r30_9, r30_10 = "originalfull", "halloweenfull", "angrybirdsstarwars2full", customerString
    local r30_11
    local r30_12
    local r30_13
    if r30_10 == "rovio" then
        r30_11 = r30_7
        r30_12 = r30_8
        r30_13 = r30_9
    else
        local r30_14 = r30_7 .. "_" .. customerString
        r30_0 = r30_8 .. "_" .. customerString
        r30_1 = r30_9 .. "_" .. customerString
        r30_11 = r30_14
        r30_12 = r30_0
        r30_13 = r30_1
    end
    if r30_10 == "rovio" then
        r30_12 = r30_8
    else
        r30_12 = r30_0
    end
    if r30_10 == "rovio" then
        r30_13 = r30_9
    else
        r30_13 = r30_1
    end
    ROVIO_WEBSITE_URL = generateRedirectURL(r30_5, "rovio")
    MOVIE_URL = generateRedirectURL(r30_5, "starwarstrailer")
    TOY_SHOP_REDIRECT_URL = generateRedirectURL(r30_5, "abswshop")
    CRIMSON_REDIRECT_URL = generateRedirectURL(r30_5, r30_13)
    FULL_GAME_URL = generateRedirectURL(r30_5, "angrybirdsstarwarsfull" .. r30_6)
    NASA_URL = generateRedirectURL(r30_5, "nasa")
    WEIBO_URL = generateRedirectURL(r30_5, "weibo")
    FACEBOOK_URL = generateRedirectURL(r30_5, "facebook")
    TWITTER_URL = generateRedirectURL(r30_5, "twitterfollow")
    TWITTER_TWEET_URL = "http://angrybirds.com/trophy/?sw="
    SAMSUNG_URL = generateRedirectURL(r30_5, "galaxyvideo")
    QZONE_URL = generateRedirectURL(r30_5, "qzone")
    TENCENT_URL = generateRedirectURL(r30_5, "tencentweibo")
    PRIVACY_POLICY_URL = generateRedirectURL(r30_5, "privacypolicy")
    EULA_URL = generateRedirectURL(r30_5, "eula")
    ROVIO_UPDATE_URL_S60 = generateRedirectURL(r30_5, "checklatestfull")
    APP_STORE_SEASONS_URL = generateRedirectURL(r30_5, r30_12)
    APP_STORE_ABCLASSIC_URL = generateRedirectURL(r30_5, r30_11)
    APPLE_GIFT_PURCHASE_URL = generateRedirectURL(r30_5, "purchasegift")
    RINGTONE_PURCHASE_URL = generateRedirectURL(r30_5, "ringtone")
    RENREN_URL = generateRedirectURL(r30_5, "renren")
    ALEX_URL = generateRedirectURL(r30_5, "amazingalexfull")
    if releaseBuild == true then
        CHECK_APPLICATIONS_URL = "http://cloud.rovio.com/content/embed/gameList/?d=" .. deviceModel .. "&p=abc&a=" .. r30_5
    else
        CHECK_APPLICATIONS_URL = "http://smoke.rovio.com/content/embed/gameList/?d=" .. deviceModel .. "&p=abc&a=" .. r30_5
    end
    loadImages({ "SPLASHES" })
    loadCompoSprites({ "SPLASHES_COMPOSPRITES" })
    if isPCVersion() == true then
        res.createAudioOutput(2, 16, 44100)
    else
        res.createAudioOutput(1, 16, 16000)
    end
    local r30_15 = getTimeDifferenceInSeconds(getCurrentTime(), SettingsWrapper:getInstalledAppsLastCheck()) / 3600
    if SettingsWrapper:getInstalledAppsTTL() < r30_15 then
        checkInstalledAppsOnline(CHECK_APPLICATIONS_URL)
    else
        possibleInstalledApps = SettingsWrapper:getPossibleAppsList()
        if possibleInstalledApps then
            checkInstalledAppsOffline(exportLuaTableAsJSON("possibleInstalledApps"))
        end
    end
    local r30_16 = ui.StartSequencePage:new({ name = "startSequencePage" })
    local r30_17 = eventManager
    local r30_18 = { id = events.EID_CHANGE_SCENE, target = r30_16 }
    r30_17:notify(r30_18)
    print("------------- setGameParameters ------------")
    setGameParameters({ deterministicPhysics = deterministicPhysics })
    loadFonts()
    defaultMenuFont = "FONT_SPACE_BASIC"
    setFont(defaultMenuFont)
    print("------------- end of create startup assets ------------")
    if deviceModel == "windows" or deviceModel == "osx" then
        if SettingsWrapper:getFullScreen() == nil then
            SettingsWrapper:setFullScreen(true)
            setFullScreenMode(SettingsWrapper:getFullScreen())
        elseif SettingsWrapper:getFullScreen() then
            setFullScreenMode(SettingsWrapper:getFullScreen())
        else
            local r30_19, r30_20 = 1024, 600
            if SettingsWrapper:getScreenWidth() == nil then
                SettingsWrapper:setScreenWidth(r30_19)
            end
            if SettingsWrapper:getScreenHeight() == nil then
                SettingsWrapper:setScreenHeight(r30_20)
            end
            local r30_21 = _G.math.max(r30_19, SettingsWrapper:getScreenWidth())
            local r30_22 = _G.math.max(r30_20, SettingsWrapper:getScreenHeight())
            setResolution(r30_21, r30_22)
        end
    end
    _G.res.createTextGroupSet(localizationPath .. "/TEXTS_BASIC.dat")
end

-- line 986-992
-- proto#31 params=1 locals=2 upvalues=0 vararg=false
function getBGInitialPosition(p31_0)
    if not p31_0 then
        p31_0 = 0
    end
    local r31_0, r31_1 = res.getSpriteBounds("MAIN_BG_SKY")
    mainMenuBGMoved = mainMenuBGMoved + p31_0
    return -r31_0 * 0.20000000298023224 + mainMenuBGMoved
end

-- line 994-1026
-- proto#32 params=0 locals=11 upvalues=0 vararg=false
function createAssets()
    for r32_0, r32_1 in _G.pairs(g_defaultLoadGroups) do
        loadImages({ r32_1 })
    end
    if isPCVersion() then
        loadImages({ "CURSORS" })
    end
    if showEditor == true then
        themes = {}
        loadLuaFileToObject(scriptPath .. "/themes.lua", this.themes, "")
        local r32_2 = {}
        for r32_3, r32_4 in _G.pairs(themes) do
            for r32_5, r32_6 in _G.ipairs(r32_4.loadListGroup) do
                _G.table.insert(r32_2, r32_6)
            end
        end
        loadImages(r32_2)
        loadImages({ "EPISODE_SELECTION" })
    end
    initializeSoundManager()
    soundManager.createAudioAssets()
    if PowerupManager then
        PowerupManager:initialize()
    end
end

-- line 1028-1030
-- proto#33 params=0 locals=3 upvalues=0 vararg=false
function shouldDrawCursor()
    local r33_0
    if g_usingGestureControls then
        if deviceModel == "windows" then
            r33_0 = true
        elseif deviceModel == "metro" then
            r33_0 = not isPCTouchState()
        else
            r33_0 = false
        end
    elseif cursor.x == 0 then
        if cursor.y == 0 then
            if deviceModel == "windows" then
                r33_0 = true
            elseif deviceModel == "metro" then
                r33_0 = not isPCTouchState()
            else
                r33_0 = false
            end
        else
            r33_0 = true
        end
    else
        r33_0 = true
    end
    return r33_0
end

-- line 1032-1054
-- proto#34 params=0 locals=3 upvalues=0 vararg=false
function drawPCCursor()
    if isInGameMode() then
        setIsMultitouchMouseWheelSimulationEnabled(false)
        if g_usingGestureControls or isPCTouchState() then
            if g_laserGestureMode then
                _G.res.drawSprite("RETICLE_RED", laser_cursor.x, laser_cursor.y)
            end
        elseif shouldDrawCursor then
            setRenderState(0, 0, 1, 1, 0)
            _G.res.drawSprite(g_currentCursorName, cursor.x, cursor.y)
        end
    else
        setIsMultitouchMouseWheelSimulationEnabled(true)
        if not (g_gestureMenuCursorHide or deviceModel == "metro" and isPCTouchState()) then
            setRenderState(0, 0, 1, 1, 0)
            _G.res.drawSprite(g_currentCursorName, cursor.x, cursor.y)
        end
    end
end

-- line 1057-1067
-- proto#35 params=0 locals=0 upvalues=0 vararg=false
function updateValues()
    defaultForce = -300
    boostForce = defaultForce
    collisionParticleForceThreshold = 10
    collisionSoundForceThreshold = 3
    blockDestroyedScoreIncrement = 300
    pigletteDestroyedScoreIncrement = 5000
    birdsLeftScoreIncrement = 10000
    hardLimitSimultaneousParticles = 150
    softLimitSimultaneousParticles = 75
end

-- line 1069-1080
-- proto#36 params=1 locals=6 upvalues=0 vararg=false
function addMightyEagles(p36_0)
    if platformSupportsME() then
        local r36_0 = _G.res.getString("TEXTS_BASIC", "TEXT_FALCON_AWARD")
        local r36_1 = MERewardPopup:new("x" .. p36_0, replaceTextOccurrencesInString(r36_0, "$FALCONS_GAINED", _G.tostring(p36_0)), "BTN_MIGHTY_EAGLE")
        r36_1.name = "eaglepopup"
        notificationsFrame:addChild(r36_1)
        r36_1:onEntry()
        r36_1:layout()
        SettingsWrapper:addMightyEagles(p36_0)
        savePurchases()
    end
end

-- line 1082-1091
-- proto#37 params=1 locals=3 upvalues=0 vararg=false
function startWarpTransition(p37_0)
    local r37_0 = ui.WarpTransition:new({ name = "warpT" })
    if p37_0 == true and r37_0 ~= nil then
        r37_0.reverseT = true
    end
    local r37_1 = eventManager
    local r37_2 = { id = events.EID_CHANGE_SCENE, target = r37_0 }
    r37_1:notify(r37_2)
end

-- line 1093-1272
-- proto#38 params=0 locals=30 upvalues=0 vararg=false
function removeBlocks()
    if objects.world == nil then
        return
    end
    for r38_0, r38_1 in _G.pairs(deadBlocks) do
        for r38_2, r38_3 in _G.ipairs(getJointedObjects(objects.joints, r38_1.name)) do
            if getObjectDefinition(r38_3.name).shotData ~= nil then
                destroyEmitter(r38_3)
            end
        end
        if r38_1.isEmittedParticle then
            createDestroyParticles(getObjectDefinition(r38_0), r38_1, r38_0)
            removeUpdateCall(r38_1.name)
            removeObject(r38_1.name)
            deadBlocks[r38_0] = nil
            objects.world[r38_0] = nil
        elseif r38_1.isSword then
            removeObject(r38_1.name)
            objects.world[r38_0] = nil
            dummyTable[r38_0] = nil
            deadBlocks[r38_0] = nil
        elseif r38_1.isSensor then
            if r38_1.sensorType == "dummy" then
                removeObject(r38_1.name)
                objects.world[r38_0] = nil
                dummyTable[r38_0] = nil
            elseif r38_1.sensorType == "gravitation" then
                local r38_4 = objects.sensorList
                r38_4.gravitation[r38_1.name] = nil
                removeObject(r38_1.name)
                objects.world[r38_0] = nil
                deadBlocks[r38_0] = nil
                dummyTable[r38_0] = nil
            elseif not (r38_1.name == "BLOCK_MIGHTY_EAGLE_1" or r38_1.name == "BLOCK_MIGHTY_EAGLE_2_2") then
                removeObject(r38_1.name)
                objects.world[r38_0] = nil
            end
        elseif r38_1 ~= nil and r38_1.strength ~= nil and r38_1.name ~= "killingBox" and r38_1.strength <= 0 and r38_1.destroyed ~= true then
            if r38_1.onDestroyed ~= nil then
                fireAction(r38_1.onDestroyed, { obj = r38_1 }, "onDestroyed")
                local r38_5 = actions[r38_1.onDestroyed]
                if r38_5.params.continueExec == false then
                    return
                end
            end
            checkFreezingObjects(r38_0)
            if r38_1.ignoreGameplayActions then
                if r38_1.controllable == true then
                    removeBird(r38_1)
                end
            else
                local r38_6 = getObjectDefinition(r38_0)
                local r38_7 = blockTable.blocks[r38_1.definition]
                local r38_8
                if r38_7.destroyedScoreInc == nil then
                    if r38_1.levelGoal then
                        timeWithoutLevelGoals = 0
                        r38_8 = pigletteDestroyedScoreIncrement
                        if r38_1.sensorB ~= nil then
                            removeBird(objects.world[r38_1.sensorB])
                        end
                        if r38_1.sensorA ~= nil then
                            removeBird(objects.world[r38_1.sensorA])
                        end
                    end
                else
                    local r38_9 = blockTable.blocks[r38_1.definition]
                    r38_8 = r38_9.destroyedScoreInc
                end
                local r38_10 = blockTable.blocks[r38_1.definition]
                if r38_10.spriteScore == nil then
                    if r38_8 > 0 then
                        _G.table.insert(floatingScores, {
                            x = r38_1.x,
                            y = r38_1.y,
                            text = "" .. r38_8,
                            score = r38_8,
                            time = 0,
                            lifetime = 0.6000000238418579,
                            maxScale = 0.25 + r38_8 / 3000,
                            xs = 0
                        })
                    end
                else
                    _G.table.insert(floatingScores, {
                        x = r38_1.x,
                        y = r38_1.y,
                        sprite = blockTable.blocks[r38_1.definition].spriteScore,
                        score = r38_8,
                        time = 0,
                        lifetime = 0.8999999761581421,
                        maxScale = 1,
                        xs = 0
                    })
                end
                scoreTable.blocks.score = scoreTable.blocks.score + r38_8
                local r38_11 = getLevelMetadata(levelName)
                if not r38_11.objectsDestroyableByTap then
                    if r38_1.material == "wood" then
                        SettingsWrapper:destroyedBlock("wood")
                    elseif r38_1.material == "stone" then
                        SettingsWrapper:destroyedBlock("stone")
                    elseif r38_1.material == "glass" then
                        SettingsWrapper:destroyedBlock("glass")
                    elseif r38_1.material == "bubble" or r38_1.material == "bossBubble" then
                        SettingsWrapper:destroyedBlock("bubble")
                    elseif r38_1.material == "pig" then
                        SettingsWrapper:destroyedBlock("pig")
                        if isStormTrooper(r38_1.definition) then
                            SettingsWrapper:destroyedBlock("stormTrooper")
                            local r38_12 = SettingsWrapper:getDestroyedBlocks("stormTrooper")
                            if getAchievementLimit("Simple Pigs and Nonsense") < r38_12 then
                                registerAchievement("Simple Pigs and Nonsense")
                            end
                        end
                    elseif r38_1.material == "popcorn_seed" then
                        SettingsWrapper:destroyedBlock("popcorn_seed")
                        local r38_13 = SettingsWrapper:getDestroyedBlocks("popcorn_seed")
                        if getAchievementLimit("Popcorn Popper") < r38_13 then
                            registerAchievement("Popcorn Popper")
                        end
                    end
                    SettingsWrapper:destroyedAnyBlock()
                end
                createDestroyParticles(r38_6, r38_1, r38_0)
                if r38_6 and r38_6.specialty == "BOMB" and not r38_6.avoidBombOnDestroy then
                    local r38_14 = blockTable.materials[r38_6.material]
                    local r38_15 = r38_14.destroyedSound or r38_6.destroyedSound
                    if not objects.worldGravity then
                        local r38_16 = r38_6.destroyedSoundZeroGravity
                        if r38_16 then
                            r38_15 = r38_16
                        else
                            local r38_17 = blockTable.materials[r38_6.material]
                            local r38_18 = r38_17.destroyedSoundZeroGravity
                            if r38_18 then
                                r38_15 = r38_18
                            end
                        end
                    end
                    local r38_19 = r38_15 or "tnt_explodes"
                    makeExplosion(deadBlocks[r38_0], r38_6, r38_19)
                end
                if r38_6 then
                    local r38_20 = r38_6.destroyedSound
                    if not r38_20 then
                        local r38_21
                        r38_20 = r38_21.destroyedSound
                    end
                    if r38_20 == nil then
                        local r38_22 = blockTable.materials[r38_1.material]
                        local r38_23 = r38_22.specialDestroyedSound
                        if r38_23 ~= nil then
                            res.playAudio(r38_23)
                        end
                    else
                        res.playAudio(r38_20)
                    end
                    if r38_1.currentState == "frozenState" and r38_6.frozenKilledSound ~= nil then
                        res.playAudio(r38_6.frozenKilledSound)
                    end
                end
                g_scoreAddedTime = 6
            end
            if r38_1.levelGoal == true then
                levelGoals[r38_0] = nil
                eventManager:notify({ id = events.EID_LEVELGOAL_DESTROYED })
            end
            removeObject(r38_0)
            if objects.world[r38_0] == flyingBird then
                flyingBird = nil
            end
            animatedObjects[r38_0] = nil
            objects.world[r38_0] = nil
            deadBlocks[r38_0] = nil
        end
    end
end

-- line 1274-1311
-- proto#39 params=3 locals=15 upvalues=0 vararg=false
function createDestroyParticles(p39_0, p39_1, p39_2)
    if not p39_0 then
        return
    end
    local r39_0, r39_1 = p39_0.particlesDestroyed, p39_0.particleAmount
    local r39_2 = r39_1 ~= nil and true or false
    local r39_3
    if objects.worldGravity == nil then
        if p39_0.particlesDestroyedZeroGravity then
            r39_3 = p39_0.particlesDestroyedZeroGravity
        else
            local r39_4 = blockTable.materials[p39_1.material]
            if r39_4.particlesDestroyedZeroGravity == nil then
                r39_3 = r39_0
            else
                local r39_5 = blockTable.materials[p39_1.material]
                r39_3 = r39_5.particlesDestroyedZeroGravity
            end
        end
    else
        r39_3 = r39_0
    end
    local r39_6 = r39_3
    if r39_6 == nil then
        local r39_7 = blockTable.materials[p39_1.material]
        r39_6 = r39_7.particlesDestroyed
    end
    if r39_6 ~= nil then
        local r39_8 = r39_6[1] == nil and { r39_6 } or r39_6
        local r39_9, r39_10, r39_11 = _G.pairs(r39_8)
        local r39_12 = r39_1
        for r39_13, r39_14 in r39_9, r39_10, r39_11 do
            local r39_15
            if r39_2 == true then
                r39_15 = r39_12
            else
                r39_15 = particleTable.particles[r39_14].amount
            end
            putParticles({ objectName = p39_2, particles = r39_14, amount = r39_15 or 12 })
        end
    end
end

-- line 1313-1654
-- proto#40 params=3 locals=127 upvalues=0 vararg=false
function makeExplosion(p40_0, p40_1, p40_2)
    if g_debugExplosion then
        g_explodingBomb = true
        g_explosionX = p40_0.x
        g_explosionY = p40_0.y
        g_bombingBirdDefinition = p40_0.definition
        g_objectsInExplosionRadius = {}
        g_allObjectsDistanceToPoint = {}
        g_singleStep = true
    end
    local r40_0 = p40_0.explosionForce
    if not r40_0 then
        r40_0 = p40_1.explosionForce
    end
    local r40_1 = p40_0.explosionMinForce
    if not r40_1 then
        r40_1 = p40_1.explosionMinForce or 0.00009999999747378752
    end
    local r40_2 = p40_0.explosionRadius
    if not r40_2 then
        r40_2 = p40_1.explosionRadius
    end
    local r40_3 = p40_0.smallExplosionForce or p40_1.smallExplosionForce
    local r40_4 = p40_0.smallExplosionMinForce or p40_1.smallExplosionMinForce or 0.00009999999747378752
    local r40_5 = p40_0.smallExplosionRadius
    if not r40_5 then
        r40_5 = p40_1.smallExplosionRadius or 0.00009999999747378752
    end
    local r40_6 = p40_0.explosionDamageRadius
    if not r40_6 then
        r40_6 = p40_1.explosionDamageRadius
    end
    local r40_7 = p40_0.explosionDamage or p40_1.explosionDamage
    local r40_8 = r40_4 == 0 and 0.00009999999747378752 or r40_4
    if p40_1.spawningBomb then
        local r40_9 = {
            definition = p40_1,
            x = p40_0.x,
            y = p40_0.y,
            angle = p40_0.angle + (p40_1.angleOffset or 0),
            xVel = p40_0.startingXVel,
            yVel = p40_0.startingYVel,
            keepOriginalVelocity = p40_1.keepOriginalVelocity
        }
        local r40_10, r40_11 = getLinearVelocity(p40_0.name)
        if r40_9.xVel == nil then
            r40_9.xVel = r40_10
        end
        if r40_9.yVel == nil then
            r40_9.yVel = r40_11
        end
        spawnObjects(p40_1.spawnedObjects, r40_9)
        return
    end
    if r40_0 ~= nil then
        if p40_2 ~= nil then
            res.playAudio(p40_2)
        end
        local r40_12 = 18000
        addCameraShake(cameraShakeModeSine, 150, r40_0 / r40_12 * 4, r40_0 / r40_12 * 0.4000000059604645)
        if p40_1.forceBomb then
            if not p40_1.ignoreParticles and p40_1.explosionParticles then
                putParticles({ x = p40_0.x, y = p40_0.y, particles = p40_1.explosionParticles })
            end
            p40_0.isAffectedByForceTimer = p40_1.forceEffectDuration
        elseif not p40_1.ignoreParticles then
            if p40_1.explosionParticles then
                if p40_1.explosionParticles ~= "" then
                    putParticles({ x = p40_0.x, y = p40_0.y, particles = p40_1.explosionParticles })
                end
            else
                putParticles({ objectName = p40_0.name, particles = "explosionBuff", 1 })
                putParticles({ objectName = p40_0.name, particles = "explosion", 1 })
            end
        end
        local r40_13 = _G.math.max(r40_2, r40_6, r40_5)
        local r40_14 = getIntersectingObjects
        local r40_15 = {
            x = p40_0.x,
            y = p40_0.y,
            left = -r40_13,
            right = r40_13,
            down = -r40_13,
            up = r40_13
        }
        local r40_16 = r40_14(r40_15)
        local r40_17 = r40_2 == 0 and 0.00009999999747378752 or r40_2
        local r40_18 = r40_5 == 0 and 0.00009999999747378752 or r40_5
        local r40_19, r40_20, r40_21 = _G.pairs(r40_16)
        local r40_22, r40_23 = r40_17, r40_7
        for r40_24, r40_25 in r40_19, r40_20, r40_21 do
            local r40_26 = objects.world[r40_25]
            if r40_26 ~= nil and not r40_26.resistsExplosion and not r40_26.controllable and p40_0 ~= r40_26 and r40_26.name ~= "killingBox" and not (r40_26.isProjectile and not p40_1.forceBomb) then
                local r40_27
                local r40_28
                local r40_29, r40_30, r40_31, r40_32
                if r40_26.width == nil then
                    if r40_26.radius == nil then
                        local r40_33 = res.getSpriteBounds
                        local r40_34 = blockTable.blocks[r40_26.definition]
                        r40_29, r40_30 = r40_33(r40_34.sprite)
                        r40_31, r40_32 = worldToPhysicsTransform(r40_29, r40_30)
                        local r40_35 = r40_32
                        r40_27 = r40_31
                        r40_28 = r40_35
                    else
                        local r40_36 = r40_26.radius
                        local r40_37 = r40_26.radius
                        r40_27 = r40_36
                        r40_28 = r40_37
                    end
                elseif r40_26.height == nil then
                    if r40_26.radius == nil then
                        local r40_38 = res.getSpriteBounds
                        local r40_39 = blockTable.blocks[r40_26.definition]
                        r40_29, r40_30 = r40_38(r40_39.sprite)
                        r40_31, r40_32 = worldToPhysicsTransform(r40_29, r40_30)
                        local r40_40 = r40_32
                        r40_27 = r40_31
                        r40_28 = r40_40
                    else
                        local r40_41 = r40_26.radius
                        local r40_42 = r40_26.radius
                        r40_27 = r40_41
                        r40_28 = r40_42
                    end
                else
                    local r40_43 = r40_26.width
                    local r40_44 = r40_26.height
                    r40_27 = r40_43
                    r40_28 = r40_44
                end
                local r40_45 = getSquaredDistanceFromOBBToPoint(r40_26.x, r40_26.y, r40_27, r40_28, r40_26.angle, p40_0.x, p40_0.y)
                local r40_46 = _G.math.sqrt(r40_45.distance)
                local r40_47
                local r40_48
                if r40_46 == 0 then
                    r40_47 = 0
                    r40_48 = -1
                else
                    local r40_49, r40_50 = vNormalize(r40_45.pointX - p40_0.x, r40_45.pointY - p40_0.y)
                    r40_48 = r40_50
                    r40_47 = r40_49
                end
                local r40_51
                if r40_22 == 0 then
                    r40_22 = 0.00009999999747378752
                    r40_51 = r40_22
                else
                    r40_51 = r40_22
                end
                local r40_52 = 1 - r40_46 / r40_51
                local r40_53 = false
                if p40_1.forceBomb then
                    local r40_54 = _G.math.atan2(r40_48, r40_47)
                    local r40_55 = p40_0.angle
                    local r40_56 = p40_1.forceArcWidth / 2
                    local r40_57 = r40_55 - r40_54
                    local r40_58 = -_G.math.pi
                    local r40_59
                    if r40_57 < r40_58 then
                        r40_59 = _G.math.abs(r40_55 - r40_54 + _G.math.pi * 2)
                    elseif _G.math.pi < r40_57 then
                        r40_59 = _G.math.abs(r40_55 - r40_54 - _G.math.pi * 2)
                    else
                        r40_59 = r40_57
                    end
                    if _G.math.abs(r40_59) <= r40_56 then
                        r40_53 = true
                    end
                end
                if p40_1.forceBomb and r40_46 < r40_18 and r40_26.definition and not r40_26.isProjectile then
                    if g_debugExplosion then
                        g_allObjectsDistanceToPoint[r40_25] = {
                            distance = r40_46,
                            pointX = r40_45.pointX,
                            pointY = r40_45.pointY
                        }
                    end
                    local r40_60 = physicsScale * (r40_8 + (r40_3 - r40_8) * (1 - r40_46 / r40_18))
                    removeBreakableJointsFromObject(r40_25, _G.math.abs(r40_60))
                    applyImpulse(r40_25, r40_47 * r40_60, r40_48 * r40_60, r40_45.pointX, r40_45.pointY)
                    local r40_61 = blockTable.blocks[r40_26.definition]
                    if r40_61.material ~= "sensor" and blockTable.blocks[r40_26.definition].material ~= "dynamicSensor" and isObjectAffectedByForce(r40_26, blockTable.materials[blockTable.blocks[r40_26.definition].material]) then
                        r40_26.isAffectedByForceTimer = p40_1.forceEffectDuration
                        r40_26.isAffectedByForceGlowColor = p40_1.forceGlowColor
                    end
                    if g_debugExplosion then
                        g_objectsInExplosionRadius[r40_26.name] = r40_26
                    end
                end
                if r40_46 < r40_51 and p40_1.forceBomb and r40_26.definition and r40_53 then
                    if g_debugExplosion then
                        g_allObjectsDistanceToPoint[r40_25] = {
                            distance = r40_46,
                            pointX = r40_45.pointX,
                            pointY = r40_45.pointY
                        }
                    end
                    local r40_62 = physicsScale * (r40_1 + (r40_0 - r40_1) * r40_52)
                    removeBreakableJointsFromObject(r40_25, _G.math.abs(r40_62))
                    local r40_63 = blockTable.blocks[r40_26.definition]
                    if r40_63.material ~= "lazerProjectile" then
                        applyImpulse(r40_25, r40_47 * r40_62, r40_48 * r40_62, r40_45.pointX, r40_45.pointY)
                    end
                    local r40_64 = blockTable.blocks[r40_26.definition]
                    if r40_64.material == "lazerProjectile" then
                        local r40_65 = _G.math.atan2(r40_26.y - p40_0.y, r40_26.x - p40_0.x)
                        r40_26.bounceAngle = r40_65
                        local r40_66 = _G.math.cos
                        r40_26.movementAngleX = r40_66(r40_65)
                        local r40_67 = _G.math.sin
                        r40_26.movementAngleY = r40_67(r40_65)
                        local r40_68 = blockTable.blocks[r40_26.definition]
                        local r40_69 = r40_68.particlesCollision
                        if r40_69 then
                            putParticles({ x = r40_26.x, y = r40_26.y, particles = r40_69 })
                        end
                    else
                        local r40_70 = blockTable.blocks[r40_26.definition]
                        if r40_70.material ~= "sensor" then
                            local r40_71 = blockTable.blocks[r40_26.definition]
                            if r40_71.material ~= "dynamicSensor" and isObjectAffectedByForce(r40_26, blockTable.materials[blockTable.blocks[r40_26.definition].material]) then
                                r40_26.isAffectedByForceTimer = p40_1.forceEffectDuration
                                r40_26.isAffectedByForceGlowColor = p40_1.forceGlowColor
                                if r40_26.material ~= pig then
                                    SettingsWrapper:blockThrownByForce()
                                end
                            end
                        end
                    end
                    if r40_26.onReceivedExplosionForce ~= nil then
                        fireAction(r40_26.onReceivedExplosionForce, {
                            name = r40_26.name,
                            force = r40_62,
                            forceBomb = p40_1.forceBomb,
                            definition = p40_1.definition
                        })
                    end
                    if g_debugExplosion then
                        g_objectsInExplosionRadius[r40_26.name] = r40_26
                    end
                end
                if r40_46 < r40_51 and not p40_1.forceBomb then
                    if p40_1.isMightyEagle and r40_26 ~= nil and blockTable.blocks[r40_26.definition] ~= nil and (blockTable.blocks[r40_26.definition].isBubble or blockTable.blocks[r40_26.definition].destroyWithMEForce) then
                        destroyObject(r40_26.name)
                    end
                    if p40_0.damageDone ~= nil then
                        local r40_72 = p40_0.damageDone
                        p40_0.damageDone = r40_72 + 10
                    end
                    if g_debugExplosion then
                        g_allObjectsDistanceToPoint[r40_25] = {
                            distance = r40_46,
                            pointX = r40_45.pointX,
                            pointY = r40_45.pointY
                        }
                    end
                    local r40_73 = physicsScale * r40_0 * r40_52
                    print("Exploding " .. r40_26.name)
                    applyImpulse(r40_25, r40_47 * r40_73, r40_48 * r40_73, r40_45.pointX, r40_45.pointY)
                    if r40_26.onReceivedExplosionForce ~= nil then
                        fireAction(r40_26.onReceivedExplosionForce, {
                            name = r40_26.name,
                            force = r40_73,
                            definition = p40_1.definition
                        })
                    end
                    removeBreakableJointsFromObject(r40_25, _G.math.abs(r40_73))
                    if g_debugExplosion then
                        g_objectsInExplosionRadius[r40_26.name] = r40_26
                    end
                end
                local r40_74 = r40_6
                if getObjectDefinition(r40_25) ~= nil then
                    local r40_75 = getObjectDefinition(r40_25)
                    local r40_76
                    if r40_75.extendedExplosionDamageRadius == true then
                        r40_76 = r40_51
                    else
                        r40_76 = r40_74
                    end
                    local r40_77 = r40_76 == 0 and 0.00009999999747378752 or r40_76
                    local r40_78 = 1 - r40_46 / r40_77
                    if r40_46 < r40_77 then
                        if r40_26.onReceivedExplosionDamage ~= nil then
                            fireAction(r40_26.onReceivedExplosionDamage, {
                                name = r40_26.name,
                                damage = r40_23 * r40_78
                            })
                        end
                        if r40_26.defence == nil then
                            r40_26.defence = r40_23 * r40_78
                        end
                        if r40_23 * r40_78 > r40_26.defence then
                            if p40_1.explosionFactors == nil then
                                r40_23 = r40_23
                            else
                                local r40_79 = blockTable.blocks[r40_26.definition]
                                local r40_80 = r40_79.material
                                local r40_81 = blockTable.damageFactors[p40_1.explosionFactors]
                                if r40_81.damageMultiplier[material] == nil then
                                    r40_23 = r40_23
                                elseif p40_1.explosionFactors[material] == nil then
                                    r40_23 = r40_23
                                else
                                    r40_23 = r40_23 * blockTable.damageFactors[p40_1.explosionFactors].damageMultiplier[material]
                                    r40_23 = r40_23
                                end
                            end
                            local r40_82 = r40_26.strength
                            local r40_83 = r40_26.strength
                            r40_26.strength = r40_83 - r40_23 * r40_78
                            if scoreTable[r40_26.name] == nil then
                                scoreTable[r40_26.name] = {}
                                local r40_84 = scoreTable[r40_26.name]
                                r40_84.score = 0
                            end
                            local r40_85 = _G.math.ceil(_G.math.min(r40_23 * r40_78, r40_82))
                            local r40_86 = _G.math.max(r40_85, 0)
                            local r40_87 = scoreTable[r40_26.name]
                            local r40_88 = scoreTable[r40_26.name]
                            r40_87.score = r40_88.score + r40_86 * worldAttributes.scoreDamageMultiplier
                            if r40_26.strength <= 0 then
                                deadBlocks[r40_25] = r40_26
                            end
                            local r40_89 = getDamageSprite(r40_26, blockTable.blocks)
                            r40_26.damageSprite = r40_89.sprite
                            r40_26.blinkSprite = r40_89.blink
                            r40_26.smileSprite = r40_89.smile
                            createDamageParticles(r40_26, blockTable.blocks, r40_82)
                            local r40_90 = getObjectDefinition(r40_25)
                            local r40_91 = r40_90.damageParticles
                            if r40_91 ~= nil then
                                putParticles({
                                    objectName = object1,
                                    particles = r40_91,
                                    amount = _G.math.ceil(r40_23 * r40_78 / 10)
                                })
                            end
                            local r40_92 = getObjectDefinition(r40_25)
                            if blockTable.materials[r40_92.material].damageSound ~= nil then
                                local r40_93 = res.playAudio
                                local r40_94 = blockTable.materials
                                local r40_95 = getObjectDefinition(r40_25)
                                local r40_96 = r40_94[r40_95.material]
                                r40_93(r40_96.damageSound)
                            end
                        end
                    end
                end
                if r40_26 ~= nil and blockTable.blocks[r40_26.definition] ~= nil and blockTable.blocks[r40_26.definition].destroyWithExplosionForce then
                    destroyObject(r40_26.name)
                end
            end
        end
        local r40_97 = SettingsWrapper:getNumBlocksThrownByForce()
        if getAchievementLimit("Force Learner") <= r40_97 then
            registerAchievement("Force Learner")
        end
    end
end

-- line 1656-1678
-- proto#41 params=2 locals=4 upvalues=0 vararg=false
function isObjectAffectedByForce(p41_0, p41_1)
    local r41_0, r41_1
    local r41_2 = false
    if p41_1 and p41_1.collision ~= nil and p41_1.collision == false then
        r41_2 = false
    end
    local r41_3 = blockTable.blocks[p41_0.definition]
    local r41_4
    if r41_3.density == nil then
        r41_0 = blockTable.blocks[p41_0.definition]
        if r41_0.density then
            r41_4 = true
        else
            r41_4 = r41_2
        end
    else
        local r41_5 = blockTable.blocks[p41_0.definition]
        if r41_5.density == 0 then
            r41_4 = false
        else
            r41_0 = blockTable.blocks[p41_0.definition]
            if r41_0.density then
                r41_4 = true
            else
                r41_4 = r41_2
            end
        end
    end
    local r41_6 = blockTable.blocks[p41_0.definition]
    local r41_7
    if r41_6.collision == nil then
        r41_1 = blockTable.blocks[p41_0.definition]
        if r41_1.collision then
            r41_7 = true
        else
            r41_7 = r41_4
        end
    else
        local r41_8 = blockTable.blocks[p41_0.definition]
        if r41_8.collision == false then
            r41_7 = false
        else
            r41_1 = blockTable.blocks[p41_0.definition]
            if r41_1.collision then
                r41_7 = true
            else
                r41_7 = r41_4
            end
        end
    end
    return r41_7
end

-- line 1680-1702
-- proto#42 params=0 locals=11 upvalues=0 vararg=false
function checkForLevelCompleteRewards()
    local r42_0 = 5
    if platformSupportsME() then
        local r42_1 = getLevelMetadata(levelName)
        if r42_1.setMEAdvertPossible and not SettingsWrapper:isStoryFalconGiven() then
            SettingsWrapper:markStoryFalconGiven()
            if SettingsWrapper:isMEAdvertEnabled() == true then
                local r42_2 = ui.RewardPopup
                local r42_3 = {
                    name = "falconUnlocked",
                    falcons = r42_0,
                    inMenuSpace = false,
                    returnValue = ""
                }
                local r42_4 = r42_2:new(r42_3)
                local r42_5 = eventManager
                local r42_6 = { id = events.EID_PUSH_FRAME, target = r42_4 }
                r42_5:notify(r42_6)
                SettingsWrapper:addMightyEagles(r42_0)
                savePurchases()
            else
                local r42_7 = ui.RewardPopup
                local r42_8 = {
                    name = "falconUnlocked",
                    falcons = r42_0,
                    inMenuSpace = false,
                    returnValue = ""
                }
                local r42_9 = r42_7:new(r42_8)
                local r42_10 = eventManager
                local r42_11 = { id = events.EID_PUSH_FRAME, target = r42_9 }
                r42_10:notify(r42_11)
                SettingsWrapper:addMightyEagles(r42_0)
                savePurchases()
                fireAction("setMEAdvertPossible", {})
            end
        end
    end
end

-- line 1704-1710
-- proto#43 params=0 locals=0 upvalues=0 vararg=false
function checkForBirdsShotAchievement()
    local r43_0 = SettingsWrapper:getBirdsShot()
    if getAchievementLimit("Fly Bird Fly") <= r43_0 then
        registerAchievement("Fly Bird Fly")
    end
end

-- line 1712-1764
-- proto#44 params=0 locals=9 upvalues=0 vararg=false
function checkForLevelCompleteAchievements()
    if levelCompleted then
        if birdsShot == 1 and not isEagleUsedInLevel() then
            SettingsWrapper:levelFinishedUsingOneBird(levelName)
            local r44_0 = SettingsWrapper:getTimesLevelFinishedUsingOneBird()
            if getAchievementLimit("The Birds Will Be With You") <= r44_0 then
                registerAchievement("The Birds Will Be With You")
            end
        end
        local r44_1 = getLevelMetadata(levelName)
        if r44_1.levelAchievement then
            local r44_2 = registerAchievement
            local r44_3 = getLevelMetadata(levelName)
            r44_2(r44_3.levelAchievement)
        end
        local r44_4, r44_5, r44_6, r44_7, r44_8, r44_9 = calculateEpisodeScoreAndStars(SettingsWrapper:getLastOpenedEpisodeType(), SettingsWrapper:getLastOpenedEpisodeIndex())
        if r44_5 == r44_6 and getEpisodeMetadata(currentFolder).starAchievement then
            local r44_10 = registerAchievement
            local r44_11 = getEpisodeMetadata(currentFolder)
            r44_10(r44_11.starAchievement)
        end
        local r44_12 = getEpisodeMetadata(currentFolder)
        local r44_13 = r44_12.scoreAchievement
        if r44_13 ~= nil and (getAchievementLimit(r44_13) <= r44_4 or getAchievementLimit(r44_13) <= r44_9) then
            registerAchievement(r44_13)
        end
    end
    calculatePlaytime()
    local r44_14 = SettingsWrapper:getPlaytime() * 1
    if getAchievementLimit("Star Bird Fan") <= r44_14 then
        registerAchievement("Star Bird Fan")
    end
    local r44_15 = SettingsWrapper:getPlaytime() * 1
    if getAchievementLimit("True Star Bird Fan") <= r44_15 then
        registerAchievement("True Star Bird Fan")
    end
    local r44_16 = SettingsWrapper:getPlaytime() * 1
    if getAchievementLimit("Star Bird Addict") <= r44_16 then
        registerAchievement("Star Bird Addict")
    end
    local r44_17, r44_18 = calculateStarsForAllEpisodes()
end

-- line 1766-1773
-- proto#45 params=0 locals=1 upvalues=0 vararg=false
function checkForDroidLevelAchievements()
    local r45_0 = SettingsWrapper:getNumDroidLevelUnlockedThroughEggsteroid()
    if getAchievementLimit("Probe Gatherer") <= r45_0 then
        registerAchievement("Probe Gatherer")
    elseif r45_0 >= 1 then
        registerAchievement("Probe Explorer")
    end
end

-- line 1775-1787
-- proto#46 params=1 locals=7 upvalues=0 vararg=false
function getPowerupLeaderboardNameForEpisode(p46_0)
    local r46_0 = getLeaderboardNameForEpisode(p46_0)
    if r46_0 then
        if PowerupManager then
            local r46_1 = r46_0
            local r46_2 = PowerupManager:getPowerupLeaderboardSuffix()
            return r46_1 .. r46_2
        end
        return
    end
    local r46_3 = _G.tostring(p46_0)
    print("getPowerupLeaderboardNameForEpisode: lboardName nil for episode: " .. r46_3)
end

-- line 1791-1829
-- proto#47 params=2 locals=4 upvalues=0 vararg=false
function getLeaderboardNameForEpisode(p47_0, p47_1)
    if p47_1 then
        return getPowerupLeaderboardNameForEpisode(p47_0)
    end
    local r47_0 = nil
    local r47_1
    if p47_0 == 1 then
        r47_1 = "tatoiine_1_LBNAME"
    elseif p47_0 == 2 then
        r47_1 = "deathstar_1_LBNAME"
    elseif p47_0 == 3 then
        r47_1 = "hoth_1_LBNAME"
    elseif p47_0 == 4 then
        r47_1 = "bespin_1_LBNAME"
    elseif p47_0 == 5 then
        r47_1 = "endor_1_LBNAME"
    elseif p47_0 == 6 then
        r47_1 = "deathstar_2_LBNAME"
    else
        local r47_2 = episodeTypeIndexIncrement + 1
        if p47_0 == r47_2 then
            r47_1 = "iap_1_LBNAME"
        else
            local r47_3 = episodeTypeIndexIncrement + 2
            if p47_0 == r47_3 then
                r47_1 = "bobaFett_1_LBNAME"
            else
                local r47_4 = 2 * episodeTypeIndexIncrement + 1
                if p47_0 ~= r47_4 then
                    return r47_0
                end
                r47_1 = "droid_1_LBNAME"
            end
        end
    end
    local r47_5
    if deviceModel == "ipad" then
        r47_5 = r47_1 .. "HD"
    else
        r47_5 = r47_1
    end
    local r47_6
    if isLiteVersion then
        r47_6 = r47_5 .. "Free"
    else
        r47_6 = r47_5
    end
    return r47_6
end

-- line 1831-1839
-- proto#48 params=0 locals=3 upvalues=0 vararg=false
function getPowerupLeaderBoardNameForTotalScore()
    local r48_0 = getLeaderboardNameForTotalScore()
    if not PowerupManager then
        return
    end
    local r48_1 = r48_0
    local r48_2 = PowerupManager:getPowerupLeaderboardSuffix()
    return r48_1 .. r48_2
end

-- line 1841-1854
-- proto#49 params=1 locals=3 upvalues=0 vararg=false
function getLeaderboardNameForTotalScore(p49_0)
    if p49_0 then
        return getPowerupLeaderBoardNameForTotalScore()
    end
    local r49_0 = "totalScore"
    local r49_1
    if deviceModel == "ipad" then
        r49_1 = r49_0 .. "HD"
    elseif isIpad3() then
        r49_1 = r49_0 .. "HD"
    else
        r49_1 = r49_0
    end
    local r49_2
    if isIOSFree() then
        r49_2 = r49_1 .. "Free"
    else
        r49_2 = r49_1
    end
    return r49_2
end

-- line 1856-1872
-- proto#50 params=0 locals=0 upvalues=0 vararg=false
function getEpisodeSelectionLevelName()
    if isDagobahAvailableForDevice() then
        if deviceModel == "metro" or deviceModel == "windows" then
            return "EpisodeSelection_Windows8"
        end
        return "EpisodeSelection"
    end
    if isIOSFree() then
        return "EpisodeSelection_Free"
    end
    if deviceModel == "wp8" or deviceModel == "wp7" or deviceModel == "blackberry" then
        return "EpisodeSelection_WindowsPhone"
    end
    return "EpisodeSelection_noDagobah"
end

-- line 1874-1882
-- proto#51 params=0 locals=0 upvalues=0 vararg=false
function showPopupAfterDZ()
    if deviceModel == "windows" then
        return true
    end
    if isAndroidSamsungDevice() then
        return true
    end
    return false
end

-- line 1884-1891
-- proto#52 params=2 locals=0 upvalues=0 vararg=false
function checkOpenLevelLimit(p52_0, p52_1)
    if getEpisodeMetadata(p52_0).openLevelsLimit ~= nil and getEpisodeMetadata(p52_0).openLevelsLimit + 2 <= p52_1 then
        return false
    end
    return true
end

-- line 1893-1973
-- proto#53 params=2 locals=11 upvalues=0 vararg=false
function isLevelUnlocked(p53_0, p53_1)
    assert(p53_0 ~= nil, "folder is nil at isLevelUnlocked")
    assert(p53_1 ~= nil, "levelNumber is nil at isLevelUnlocked")
    if checkOpenLevelLimit(p53_0, p53_1) then
        if releaseBuild == false then
            return true
        end
        local r53_0 = actions.myLevels[p53_0]
        local r53_1 = r53_0[p53_1]
        local r53_2 = actions.myLevels[p53_0][p53_1 - 1]
        local r53_3 = getEpisodeMetadata(p53_0)
        local r53_4 = r53_3.droidEpisode
        local r53_5 = getLevelMetadata(r53_1)
        if r53_5.unlockedAsDefault then
            return true
        end
        if r53_4 then
            local r53_6 = SettingsWrapper:isDroidLevelUnlocked(r53_1) or SettingsWrapper:isThreeStarLevelUnlocked(r53_1)
            return r53_6
        end
        if isEpisodeFolder(p53_0) and (p53_1 == 1 or r53_2 ~= nil and SettingsWrapper:isComicWatched(r53_2)) then
            return true
        end
        local r53_7 = getEpisodeMetadata(p53_0)
        local r53_8 = getEpisodeMetadataWithParam(p53_0, "iapPurchaseId")
        local r53_9 = SettingsWrapper:isEpisodePurchased(r53_8)
        if r53_8 ~= nil and r53_7.iapPurchase then
            if isPCVersion() then
                if not g_isRegistered then
                    return false
                end
            elseif not r53_9 then
                loginfo("\t<isLevelUnlocked> is IAP purchase, returning false")
                return false
            end
        end
        local r53_10 = SettingsWrapper:getLevelProgress(p53_0)
        if p53_1 <= r53_10 then
            loginfo("\t<isLevelUnlocked> level is already unlocked by prgress, returning true")
            return true
        end
        if highscores and highscores[r53_1] then
            loginfo("\t<isLevelUnlocked> existing highscore from level, returning true")
            return true
        end
        loginfo("\t<isLevelUnlocked> no conditions met, returning false")
        return false
    end
    return false
end

-- line 1975-2038
-- proto#54 params=2 locals=30 upvalues=0 vararg=false
function calculateEpisodeScoreAndStars(p54_0, p54_1)
    local r54_0 = actions.myLevelFolders
    local r54_1 = actions.episodeTypeTable
    local r54_2 = r54_0[r54_1[p54_0]]
    local r54_3 = r54_2[p54_1]
    local r54_4 = 0
    local r54_5 = 0
    local r54_6 = 0
    local r54_7 = 0
    local r54_8 = 0
    local r54_9 = 0
    if r54_3 then
        local r54_10 = {}
        local r54_11 = _G.ipairs
        local r54_12 = actions.myLevels
        local r54_13, r54_14, r54_15 = r54_11(r54_12[r54_3])
        local r54_16, r54_17, r54_18, r54_19, r54_20, r54_21 = r54_4, r54_5, r54_6, r54_7, r54_8, r54_9
        for r54_22, r54_23 in r54_13, r54_14, r54_15 do
            local r54_24 = getLevelMetadata(r54_23)
            if r54_24.type ~= "comic" and checkOpenLevelLimit(r54_3, r54_22) then
                local r54_25 = getLevelStarsFromHighscores(r54_23)
                r54_18 = r54_18 + r54_25
                local r54_26 = false
                if r54_24.deviceRestrictions ~= nil then
                    r54_26 = true
                    for r54_27, r54_28 in _G.ipairs(r54_24.deviceRestrictions) do
                        local r54_29 = deviceManufacturer
                        if r54_28 == r54_29 then
                            r54_26 = false
                            break
                        end
                    end
                end
                if not r54_24.ignoreScore and r54_26 ~= true then
                    if isPlatformLimited() then
                        if not r54_24.unavailableOnNonIaps then
                            r54_19 = r54_19 + 3
                            r54_21 = r54_21 + 1
                        end
                    else
                        r54_19 = r54_19 + 3
                        r54_21 = r54_21 + 1
                    end
                end
                if highscores[r54_23] then
                    r54_16 = r54_16 + (highscores[r54_23].score or 0)
                    r54_17 = r54_17 + (highscores[r54_23].powerUpScore or 0)
                    local r54_30 = highscores[r54_23]
                    if r54_30.eagleScore and highscores[r54_23].eagleScore >= 100 then
                        r54_20 = r54_20 + 1
                    end
                end
            end
        end
        if steam then
            if r54_3 == "theme1" then
                setStat("spaceEpisode1Score", r54_16)
                setStat("spaceEpisode1Stars", r54_18)
            elseif r54_3 == "theme2" then
                setStat("spaceEpisode2Score", r54_16)
                setStat("spaceEpisode2Stars", r54_18)
            elseif r54_3 == "dangerZone" then
                setStat("dangerZone1Score", r54_16)
                setStat("dangerZone1Stars", r54_18)
            end
        end
        return r54_16, r54_18, r54_19, r54_20, r54_21, r54_17
    end
    return nil
end

-- line 2040-2042
-- proto#55 params=1 locals=0 upvalues=0 vararg=false
function isBobaEpisode(p55_0)
    return p55_0 == "bobaFett_1"
end

-- line 2044-2051
-- proto#56 params=1 locals=4 upvalues=0 vararg=false
function isBobaLevel(p56_0)
    for r56_0, r56_1 in _G.pairs(actions.myLevels.bobaFett_1) do
        if r56_1 == p56_0 then
            return true
        end
    end
    return false
end

-- line 2053-2057
-- proto#57 params=1 locals=1 upvalues=0 vararg=false
function unlockBobaLevel(p57_0)
    local r57_0 = isBobaLevel(p57_0)
    assert(r57_0 ~= true, "trying to unlock boba level, but this isn't one!")
    SettingsWrapper:storeBobaFettLevelUnlocked(p57_0)
end

-- line 2060-2064
-- proto#58 params=0 locals=4 upvalues=0 vararg=false
function unlockAllBobaLevels()
    for r58_0, r58_1 in _G.pairs(actions.myLevels.bobaFett_1) do
        SettingsWrapper:storeBobaFettLevelUnlocked(r58_1)
    end
end

-- line 2066-2070
-- proto#59 params=1 locals=1 upvalues=0 vararg=false
function unlockDroidLevel(p59_0)
    local r59_0 = isDroidLevel(p59_0)
    assert(r59_0 ~= true, "not a droid level")
    SettingsWrapper:storeDroidLevelUnlocked(p59_0)
end

-- line 2072-2078
-- proto#60 params=1 locals=4 upvalues=0 vararg=false
function isDroidLevel(p60_0)
    for r60_0, r60_1 in _G.pairs(actions.myLevels.bonus) do
        if r60_0 == p60_0 then
            return true
        end
    end
end

-- line 2080-2085
-- proto#61 params=1 locals=1 upvalues=0 vararg=false
function isDroidLevelUnlocked(p61_0)
    local r61_0 = isDroidLevel(p61_0)
    assert(r61_0 ~= true, "not a droid level")
    return SettingsWrapper:isDroidLevelUnlocked(p61_0)
end

-- line 2087-2134
-- proto#62 params=1 locals=7 upvalues=0 vararg=false
function isEpisodeDisabled(p62_0)
    local r62_0 = getEpisodeMetadata(p62_0)
    if p62_0 == "nextEpisode" then
        return true
    end
    if releaseBuild == false then
        loginfo("<isEpisodeDisabled> releaseBuild is false, episode " .. p62_0 .. " is unlocked")
        return false
    end
    if r62_0.unlockedAsDefault then
        loginfo("<isEpisodeDisabled> episode " .. p62_0 .. " is unlockedAsDefault")
        return false
    end
    if r62_0.droidEpisode then
        for r62_1, r62_2 in _G.pairs(actions.myLevels[p62_0]) do
            if isDroidLevelUnlocked(r62_2) then
                loginfo("<isEpisodeDisabled> episode " .. p62_0 .. " is unlocked")
                return false
            end
        end
        loginfo("<isEpisodeDisabled> episode " .. p62_0 .. " is locked, none of the bonus levels is open")
        return true
    end
    if episodeIapId and SettingsWrapper:isEpisodePurchased(episodeIapId) then
        return false
    end
    local r62_3 = isEpisodeCompleted
    local r62_4 = actions.myLevelFolders[actions.episodeTypeTable[1]]
    if r62_3(r62_4[1]) and not r62_0.lockedAfterFirstEpisode then
        loginfo("<isEpisodeDisabled> episode " .. p62_0 .. " is unlocked, first episode is unlocked")
        return false
    end
    loginfo("<isEpisodeDisabled> episode " .. p62_0 .. " is disabled (does not meet any conditions)")
    return true
end

-- line 2136-2193
-- proto#63 params=0 locals=24 upvalues=0 vararg=false
function restoreSettings()
    if platformSupportsME() then
        SettingsWrapper:enableMEAdvertPossibility()
    end
    for r63_0, r63_1 in _G.pairs(highscores) do
        local r63_2 = getEpisodeForLevel(r63_0)
        if r63_2 ~= nil and getEpisodeMetadata(r63_2).droidEpisode then
            SettingsWrapper:storeDroidLevelUnlocked(r63_0)
        end
    end
    if platformSupportsME() then
        for r63_3, r63_4 in _G.pairs(actions.myLevelFolders) do
            for r63_5, r63_6 in _G.pairs(r63_4) do
                for r63_7, r63_8 in _G.pairs(actions.myLevels[r63_6]) do
                    if highscores[r63_8] ~= nil and getLevelMetadata(r63_8).setMEAdvertPossible == true then
                        SettingsWrapper:enableMEAdvertPossibility()
                    end
                end
            end
        end
    end
    if isIapEnabled() then
        for r63_9, r63_10 in _G.pairs(actions.myLevelFolders) do
            for r63_11, r63_12 in _G.pairs(r63_10) do
                local r63_13 = getEpisodeMetadata(r63_12)
                if r63_13.iapPurchase then
                    for r63_14, r63_15 in _G.pairs(actions.myLevels[r63_12]) do
                        if highscores[r63_15] ~= nil then
                            local r63_16 = getEpisodeMetadataWithParam(r63_12, "iapPurchaseId")
                            if not (r63_16 == nil or getLevelMetadata(r63_15).unlockedAsDefault == true) then
                                loginfo("Restored episode purchase : " .. r63_16)
                                SettingsWrapper:purchaseEpisode(r63_16)
                                checkForDagobahAchievement(r63_16)
                                savePurchases()
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

-- line 2195-2201
-- proto#64 params=1 locals=1 upvalues=0 vararg=false
function checkForDagobahAchievement(p64_0)
    local r64_0 = ui.Shop.getDataById(p64_0)
    if r64_0 and r64_0.episode == "dagobah_1" then
        registerAchievement("Dangerous It Will Be")
    end
end

-- line 2203-2205
-- proto#65 params=0 locals=2 upvalues=0 vararg=false
function isDagobahAvailableForDevice()
    local r65_0
    if isPlatformLimited() then
        r65_0 = false
    else
        r65_0 = not isIOSFree()
    end
    return r65_0
end

-- line 2207-2250
-- proto#66 params=0 locals=0 upvalues=0 vararg=false
function loadBlockData()
    loadLuaFile(scriptPath .. "/materials.lua", "materials", true, false)
    loadLuaFile(scriptPath .. "/damagefactors.lua", "damageFactors", true, false)
    loadLuaFile(scriptPath .. "/blocks_levelgoals.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_dagobah.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/birds.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_hazard.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_wood.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_menu.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_comic.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_bonusLevels.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_bosses.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_stone.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_mynockBossfight.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_glass.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_gameElements.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_static.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_planets.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_asteroids.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_decorations.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_sensors.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_tatooine.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_deathStar.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_deathStar_2.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_endor.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_hoth.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_bespin.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_powerups.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/blocks_items.lua", "blockTable", true, true)
    loadLuaFile(scriptPath .. "/themes.lua", "themes", true, false)
    loadLuaFile(scriptPath .. "/textures.lua", "textures", false, false)
    loadLuaFile(scriptPath .. "/worldAttributes.lua", "worldAttributes", false, false)
    loadLuaFile(scriptPath .. "/particles.lua", "particleTable", false, false)
    if showEditor then
        loadLuaFileToObject(scriptPath .. "/menus/AnimatedTutorial.lua", this.ui, "")
    end
    createForceGlowProperties()
end

-- line 2252-2271
-- proto#67 params=0 locals=12 upvalues=0 vararg=false
function createForceGlowProperties()
    for r67_0, r67_1 in _G.pairs(blockTable) do
        if _G.type(r67_1) == "table" then
            for r67_2, r67_3 in _G.pairs(r67_1) do
                if r67_3.definitionHeldByForce and not r67_3.definitionHeldByYodaForce then
                    local r67_4 = _G.string.gsub
                    r67_3.definitionHeldByYodaForce = r67_4(r67_3.definitionHeldByForce, "RED", "GREEN")
                end
                if r67_3.definitionHeldByForce then
                    local r67_5 = blockTable.blocks["BlackBird_" .. SettingsWrapper:getBirdLevel("BlackBird")]
                    r67_3.definitionAffectedByForce = _G.string.gsub(r67_3.definitionHeldByForce, "RED", r67_5.forceGlowColor or "BLUE")
                end
                if r67_3.definitionHeldByForce and not r67_3.definitionLiftedByLeia then
                    r67_3.definitionLiftedByLeia = _G.string.gsub(r67_3.definitionHeldByForce, "RED", "PINK")
                end
            end
        end
    end
end

-- line 2277-4014
-- proto#68 params=1 locals=800 upvalues=0 vararg=false
function loadLevelInternal(p68_0)
    eventManager:notify({ id = events.EID_BEFORE_LEVEL_LOAD })
    g_vader_bird_created = false
    g_disableGameupdate = false
    g_gameFailedState = false
    g_gameCompletedState = false
    initializeEventSystem()
    native_initPaymentProvider()
    g_birdEmitterTargets = {}
    g_queuedEventCalls = {}
    clearLuaForceFunctions()
    local r68_0 = getLevelMetadata(levelName)
    if r68_0 == nil then
        res.stopAllAudio()
    elseif r68_0.playMainMusic then
        local r68_1 = { "level start military a1", "level start military a2" }
        for r68_2 = 1, #r68_1 do
            if res.isAudioPlaying(r68_1[r68_2]) then
                res.stopAudio(r68_1[r68_2])
            end
        end
    else
        res.stopAllAudio()
    end
    if r68_0 ~= nil and r68_0.erasePreviousLevel then
        objects.previousLevel = nil
    end
    if r68_0 then
        local r68_3, r68_4 = r68_0.birdLevelUpType, r68_0.birdLevelUpLevel
        if not (r68_3 == nil or r68_4 == nil) then
            for r68_5 = 1, #r68_3 do
                local r68_6 = SettingsWrapper:getBirdLevel(r68_3[r68_5])
                local r68_7 = r68_4[r68_5]
                if r68_6 < r68_7 then
                    SettingsWrapper:levelUpBird(r68_3[r68_5], r68_4[r68_5])
                    for r68_8 = 1, r68_6 do
                        SettingsWrapper:markTutorialShown(r68_3[r68_5] .. "_" .. r68_8)
                    end
                end
            end
        end
    end
    fireAction("onBeforeLevelLoad", {})
    if g_releaseGroups ~= nil then
        releaseImages(g_releaseGroups)
        g_releaseGroups = nil
    end
    if rewardPopup then
        rewardPopup:reset()
    end
    gameTimer = 0
    g_threeStarsCheat = false
    quadClick = false
    quadClickCounter = 0
    quadClickFalconCounter = 0
    lastTimeSetDCursor = 0
    delayedCursorPhysics = { x = 0, y = 0 }
    previousDelayedCursorPhysics = { x = 0, y = 0 }
    freezingObjects = nil
    forceObjects = nil
    myCameras = nil
    numMightyEaglesCalled = 0
    numMightyEaglesShot = 0
    usedMightyEagle = false
    mightyEagleBird = nil
    mightyEagleBird2 = nil
    mightyEagleBGAlpha = nil
    mightyEagleFlashAlpha = nil
    mightyEagleBGAlphaDecreese = nil
    mightyEagleFlashAlphaDecreese = nil
    mightyEagleDisabled = false
    inEggsteroidTransition = false
    ignorePlayerInput = false
    mightyEagleBHBG = {}
    numMEFired = 0
    numberOfMightyFalcons = 0
    birdToSlingshotAnimationTimer = 0
    local r68_9 = _G.math.pi
    birdToSlingshotAnimationAngle = 0.75 * r68_9
    birdToSlingshotSurplusAngle = birdToSlingshotAnimationAngle - _G.math.pi * 0.5
    birdToSlingshotAnimationHeight = 0
    birdToSlingshotAnimationStartX = 0
    birdToSlingshotAnimationStartY = 0
    birdToSlingshotBirdName = nil
    local r68_10 = 0
    bird_touch_begin_y = 0
    bird_touch_begin_x = r68_10
    local r68_11 = 0
    last_touch_y = 0
    last_touch_x = r68_11
    g_touch_released_after_specialty = true
    g_laserGestureMode = false
    laser_cursor = { x = 0, y = 0 }
    isComicLevel = r68_0.type == "comic"
    currentBirdIndex = 1
    currentBirdName = nil
    flyingBird = nil
    birdSpecialtyAvailable = false
    birdFired = false
    birdReady = false
    fillInNextBird = false
    birdSelected = false
    birdsShot = 0
    g_blueBirdDidDamage = {}
    g_cameraShakes = {}
    g_cameraShakePosition = { x = 0, y = 0 }
    mightyEagleCameraShake = addCameraShake(cameraShakeModeMightyEagle)
    mightyEagleCameraShake.running = false
    g_cameraSpringForceConstant = 3.5
    g_cameraSpringForceConstantNoTarget = 2
    g_deltaCameraValues = { px = 0, py = 0, sx = 0, timer = 0 }
    tapStarted = false
    tapCount = 0
    tapTimer = 0
    tapPosition = { x = 0, y = 0 }
    doubleClickTimer = 0
    levelCompleteTimer = 0
    levelCompleted = false
    levelFailed = false
    levelFailedTimer = 0
    birdBuffTimer = 0
    castleCameraTimer = 0
    dragCursorIndex = 1
    dragCursorTable = { { dx = 0, dy = 0, dt = 1 } }
    rubberBandAngle = 0
    rubberBandLength = 0
    oldRubberBandLength = 0
    cameraResetTimer = g_defaultCameraResetTime
    nextBirdTimer = 0.5
    zoomLevel = 0
    oldZoomLevel = 0
    worldScale = 1
    sweepSpeed = 0
    particleAmount = 0
    currentCamera = -1
    timeWithoutLevelGoals = nil
    skipSequenceClicks = nil
    ignoreCameraSweep = false
    ignoreCameraMovement = false
    levelLeftEdgePhysics = 10000
    levelRightEdgePhysics = -10000
    levelTopEdgePhysics = 10000
    levelBottomEdgePhysics = -10000
    numGravitationParticles = 0
    aimingTrail = {}
    dummyTable = {}
    dummyPositions = {}
    numDummies = 0
    maxDumies = 5
    timeBetweenDummies = 0.30000001192092896
    timeBetweenDots = 0.05000000074505806
    maxDots = 20
    deadBlocks = {}
    birdsCounter = 0
    objectCounts = {}
    floatingScores = {}
    score = 0
    scoreTable = {}
    scoreTable.blocks = { score = 0, blockDestroyedScore = blockDestroyedScoreIncrement }
    scoreTable.birds = { score = 0 }
    selectedObjects = {}
    cameraTargetObject = nil
    allowResetToBirdCamera = false
    originalCameras = {}
    particles = {}
    timeSpentInLevel = 0
    lastBirdFailedTime = -2
    BHTrajectory = {}
    objects.levelStars = {}
    cameraShakeOn = true
    screen.deltaX = 0
    screen.deltaY = 0
    if objects.world ~= nil then
        for r68_12, r68_13 in _G.pairs(objects.world) do
            objects.world[r68_12] = nil
        end
    end
    birds = {}
    levelGoals = {}
    animatedObjects = {}
    birdTrajectory = { {}, {}, {} }
    otherBirds = {}
    timeWithoutBirds = nil
    initializeBulletTime()
    fireAction("onLevelLoad", {})
    print("LOAD  LEVEL filename  = : " .. p68_0)
    local r68_14 = _G.tostring(levelFolder)
    print("LOAD  LEVEL currentFolder: " .. r68_14)
    local r68_15, r68_16 = showEditor, p68_0
    if r68_15 ~= true then
        local r68_17 = checkGetLevelFileName()
        if r68_17 ~= nil then
            r68_16 = r68_17
        end
    end
    if g_notFirstTimeLoad ~= true or showEditor == true then
        loadBlockData()
    else
        createForceGlowProperties()
    end
    loadLevel(r68_16)
    g_notFirstTimeLoad = true
    if not (currentFolder == "bonus" or objects.previousLevel == nil) then
        objects.previousLevel = nil
        objects.previousScoreTable = nil
    end
    objects.animatedSprites = {}
    objects.animatedObjects = {}
    objects.decorationObjects = {}
    objects.spriteObjects = {}
    objects.buttonObjects = {}
    objects.world = {}
    objects.joints = {}
    objects.sensorList = {
        gravitation = {},
        destroyer = {},
        portal = {},
        stream = {},
        killing = {}
    }
    objects.counts = {}
    objects.destroyableByTap = {}
    objects.onTap = {}
    objects.physicsToWorld = physicsToWorld
    objects.theme = "theme_deathstar_space_1"
    objects.castleCameraData = nil
    objects.birdCameraData = nil
    objects.frameObjects = {}
    objects.rotatingMenuJoint = nil
    if loadedObjects == nil then
        objects.compounds = {}
    else
        objects.compounds = loadedObjects.compounds
        objects.gravityForceMultiplier = loadedObjects.gravityForceMultiplier
    end
    setWorldScale(worldScale)
    screen.x = 0
    screen.y = 0
    levelStartPosition.x = 0
    levelStartPosition.y = 0
    rubberBandPos.x = 0
    rubberBandPos.y = 0
    rubberBandSpeed = 0
    loadSpecificLevelAudioAssets()
    if loadedObjects == nil then
        if showEditor == true then
            currentTheme = "theme_deathstar_space_1"
        else
            assert(false, "Level: " .. r68_16 .. " not found.")
            checkAndLoadTheme("theme_deathstar_space_1")
        end
        setTheme(currentTheme)
        return
    end
    if loadedObjects.counts ~= nil then
        for r68_18, r68_19 in _G.pairs(loadedObjects.counts) do
            objects.counts[r68_18] = r68_19
        end
    end
    local r68_20 = 100
    if loadedObjects.physicsToWorld ~= nil then
        r68_20 = loadedObjects.physicsToWorld
    end
    scaleFactor = r68_20 / physicsToWorld
    if loadedObjects.theme ~= nil then
        objects.theme = loadedObjects.theme
        local r68_21 = levelName
        local r68_22 = getEpisodeSelectionLevelName()
        if r68_21 == r68_22 then
            loadImages({ "EPISODE_SELECTION" })
        elseif not showEditor then
            releaseImages({ "EPISODE_SELECTION" })
        end
        if showEditor == true then
            currentTheme = objects.theme
            checkAndLoadTheme(currentTheme)
            setTheme(currentTheme)
        else
            if levelName == "MainMenu" then
                local r68_23 = getMainMenuTheme()
                checkAndLoadTheme(r68_23)
                setTheme(r68_23)
            else
                local r68_24 = getLevelMetadata(levelName)
                if r68_24.usesGlobalTheme then
                    local r68_25 = SettingsWrapper
                    globalTheme = r68_25:getCurrentTheme()
                    checkAndLoadTheme(globalTheme)
                    setTheme(globalTheme)
                else
                    checkAndLoadTheme(objects.theme)
                    if getLevelMetadata(levelName).type ~= "comic" then
                        setTheme(objects.theme)
                    end
                end
            end
            local r68_26 = getLevelMetadata(levelName)
            if not (r68_26.doesNotchangeGlobalTheme and loadedObjects.previousLevel == nil) then
                globalTheme = currentTheme
                local r68_27 = SettingsWrapper
                r68_27:setCurrentTheme(currentTheme)
            end
        end
    end
    themeSpriteObjects = {}
    loadedObjects.world.killingBox = nil
    local r68_28 = SettingsWrapper
    birdLevels = r68_28:getBirdLevels()
    if loadedObjects.world ~= nil then
        for r68_29, r68_30 in _G.pairs(loadedObjects.world) do
            local r68_31 = r68_30
            if not startedFromEditor then
                local r68_32 = getEpisodeMetadata(currentFolder)
                local r68_33 = r68_32.activateLightsaberAlways
                local r68_34
                if r68_33 then
                    r68_34 = getEpisodeMetadata(currentFolder).activateLightsaberAlways == true
                else
                    r68_34 = r68_33
                end
                for r68_35, r68_36 in _G.pairs(birdLevels) do
                    if _G.string.find(r68_31.definition, "_") then
                        local r68_37 = _G.string.find(r68_31.definition, "_")
                        local r68_38 = _G.string.sub(r68_31.definition, 1, r68_37 - 1)
                        if r68_35 == r68_38 then
                            r68_31.definition = r68_35 .. "_" .. r68_36
                            if r68_38 == "RedBird" and r68_34 and r68_36 < 2 then
                                r68_31.definition = r68_35 .. "_2"
                            end
                        end
                    end
                end
            end
            if not blockTable.blocks[r68_31.definition] then
                print("Object definition is not in blocks: " .. r68_31.definition .. [[
]])
            end
            local r68_39 = getLevelMetadata(levelName)
            local r68_40 = r68_39.type
            if not r68_40 then
                local r68_41 = blockTable.blocks[r68_31.definition]
                if r68_41 and r68_41.trophy then
                    checkStoreLevelTrophy(r68_41.trophy)
                end
            end
            local r68_42 = getEpisodeMetadata("bonus")
            local r68_43 = r68_42.levelNumberAdjustment
            if r68_31.name ~= "ground" and (blockTable.blocks[r68_31.definition].ignoreFromLevelFile ~= true or getLevelMetadata(levelName).type == "bonus" and objects.previousLevel ~= nil and blockTable.blocks[r68_31.definition].createFromTransition) and isObjectAvailableForDevice(r68_31.definition) then
                if not startedFromEditor and blockTable.blocks[r68_31.definition].spriteObject == true then
                    local r68_44 = blockTable.blocks[r68_31.definition]
                    local r68_45
                    local r68_46
                    if r68_44.guiObject == true then
                        local r68_47, r68_48 = physicsToScreenTransform(r68_31.x, r68_31.y)
                        r68_46 = r68_48
                        r68_45 = r68_47
                    else
                        local r68_49, r68_50 = physicsToWorldTransform(r68_31.x, r68_31.y)
                        r68_46 = r68_50
                        r68_45 = r68_49
                    end
                    local r68_51 = blockTable.blocks[r68_31.definition]
                    local r68_52 = r68_51.scale
                    if not r68_52 then
                        r68_52 = 1
                    end
                    objects.spriteObjects[r68_31.name] = {
                        name = r68_31.name,
                        x = r68_45,
                        y = r68_46,
                        angle = r68_31.angle,
                        sprite = blockTable.blocks[r68_31.definition].sprite,
                        scaleX = r68_52,
                        scaleY = r68_52,
                        onCreated = blockTable.blocks[r68_31.definition].onCreated,
                        guiObject = blockTable.blocks[r68_31.definition].guiObject,
                        definition = r68_31.definition
                    }
                    local r68_53 = objects.spriteObjects[r68_31.name]
                    if r68_53.onCreated ~= nil then
                        local r68_54 = addEventCall
                        local r68_55 = objects.spriteObjects[r68_31.name]
                        r68_54(r68_55.onCreated, { name = r68_31.name })
                    end
                    local r68_56 = blockTable.blocks[r68_31.definition]
                    if r68_56.animateRotation == true then
                        objects.animatedSprites[r68_31.name] = r68_31.name
                    end
                    local r68_57 = blockTable.blocks[r68_31.definition]
                    if r68_57.animateScaleX == true then
                        objects.animatedSprites[r68_31.name] = r68_31.name
                        local r68_58 = objects.spriteObjects[r68_31.name]
                        r68_58.animateScaleX = true
                        local r68_59 = objects.spriteObjects[r68_31.name]
                        local r68_60 = "frequencyX"
                        local r68_61 = blockTable.blocks[r68_31.definition]
                        r68_59[r68_60] = r68_61.scaleXFrequency
                        local r68_62 = objects.spriteObjects[r68_31.name]
                        local r68_63 = "amplitudeX"
                        local r68_64 = blockTable.blocks[r68_31.definition]
                        r68_62[r68_63] = r68_64.scaleXAmplitude
                    end
                    local r68_65 = blockTable.blocks[r68_31.definition]
                    if r68_65.animateScaleY == true then
                        objects.animatedSprites[r68_31.name] = r68_31.name
                        local r68_66 = objects.spriteObjects[r68_31.name]
                        r68_66.animateScaleY = true
                        local r68_67 = objects.spriteObjects[r68_31.name]
                        local r68_68 = "frequencyY"
                        local r68_69 = blockTable.blocks[r68_31.definition]
                        r68_67[r68_68] = r68_69.scaleYFrequency
                        local r68_70 = objects.spriteObjects[r68_31.name]
                        local r68_71 = "amplitudeY"
                        local r68_72 = blockTable.blocks[r68_31.definition]
                        r68_70[r68_71] = r68_72.scaleYAmplitude
                    end
                    local r68_73 = blockTable.blocks[r68_31.definition]
                    if r68_73.animateRotation == true then
                        objects.animatedSprites[r68_31.name] = r68_31.name
                        local r68_74 = objects.spriteObjects[r68_31.name]
                        r68_74.animateRotation = true
                        local r68_75 = objects.spriteObjects[r68_31.name]
                        local r68_76 = blockTable.blocks[r68_31.definition]
                        local r68_77 = blockTable.blocks[r68_31.definition]
                        local r68_78 = _G.math.random(r68_76.minRotationFrequency, r68_77.maxRotationFrequency)
                        r68_75.rotationFrequency = r68_78 * _G.math.pi / 180
                        local r68_79 = objects.spriteObjects[r68_31.name]
                        local r68_80 = blockTable.blocks[r68_31.definition]
                        r68_79.rotationAmplitude = r68_80.rotationAmplitude * _G.math.pi / 180
                    end
                elseif not ((showEditor ~= true or releaseBuild == true) and not startedFromEditor and (blockTable.blocks[r68_31.definition].isEggsteroid == true or blockTable.blocks[r68_31.definition].isRocketPack == true or blockTable.blocks[r68_31.definition].levelFilterProperty ~= nil) and (blockTable.blocks[r68_30.definition].isEggsteroid ~= true or SettingsWrapper:isDroidLevelUnlocked(actions.myLevels.bonus[r68_31.startNumber + r68_43]) == true) and (blockTable.blocks[r68_30.definition].isRocketPack ~= true or SettingsWrapper:isBobaFettLevelUnlocked(levelName) or isBobaFettEpisodeUnlocked() or deviceModel == "osx")) or blockTable.blocks[r68_30.definition].levelFilterProperty ~= nil and SettingsWrapper:isObjectFilterPropertyStored(blockTable.blocks[r68_31.definition].levelFilterProperty) ~= true then
                    local r68_81 = r68_31.scaleX
                    if not r68_81 then
                        r68_81 = r68_30.scale
                    end
                    local r68_82 = r68_31.scaleY
                    if not r68_82 then
                        r68_82 = r68_30.scale
                    end
                    local r68_83 = blockTable
                    local r68_84 = r68_31.x * scaleFactor
                    local r68_85 = createObject(r68_83, r68_31.definition, r68_31.name, r68_84, r68_31.y * scaleFactor, r68_30.radius, r68_30.width, r68_30.height, r68_81, r68_82, r68_31.vertices)
                    local r68_86 = objects.world[r68_85]
                    local r68_87 = getObjectDefinition(r68_85)
                    r68_86.gravityFilterCategory = r68_31.gravityFilterCategory or r68_87.gravityFilterCategory
                    if r68_31.triggerEvents then
                        r68_86.triggerEvents = {}
                        for r68_88, r68_89 in _G.pairs(r68_31.triggerEvents) do
                            r68_86.triggerEvents[r68_88] = r68_86.triggerEvents[r68_88] or {}
                            for r68_90, r68_91 in _G.pairs(r68_89) do
                                r68_86.triggerEvents[r68_88][r68_90] = r68_86.triggerEvents[r68_88][r68_90] or {}
                                for r68_92, r68_93 in _G.ipairs(r68_91) do
                                    local r68_94 = r68_86.triggerEvents
                                    local r68_95 = r68_94[r68_88]
                                    _G.table.insert(r68_95[r68_90], r68_93)
                                end
                            end
                        end
                    end
                    local r68_96 = blockTable.blocks[r68_31.definition]
                    local r68_97 = r68_96.densityInWater
                    if not r68_97 then
                        local r68_98
                        r68_97 = r68_98.density
                    end
                    local r68_99 = r68_97 ~= nil
                    assert(r68_99, "Could not get water density for " .. r68_31.definition .. [[.
]])
                    native_setWaterDensity(r68_85, r68_97)
                    local r68_100 = blockTable.blocks[r68_31.definition]
                    if r68_100.disableRotation == true then
                        setObjectParameter(r68_85, 10, 1)
                    end
                    if startedFromEditor ~= true and blockTable.blocks[r68_31.definition].isVisible == false then
                        setObjectParameter(r68_85, 33, 0)
                    end
                    local r68_101 = getLevelMetadata(levelName)
                    if r68_101.ignoreGravityCenters and blockTable.blocks[r68_31.definition].sensorType == "gravitation" then
                        setObjectParameter(r68_85, 33, 0)
                    end
                    if blockTable.blocks[r68_31.definition] ~= nil then
                        local r68_102 = blockTable.blocks[r68_31.definition]
                        if r68_102.animateRotation == true then
                            objects.animatedObjects[r68_85] = r68_31.name
                            objects.world[r68_85].animateRotation = true
                            local r68_103 = blockTable.blocks[r68_31.definition]
                            if not (r68_103.minRotationFrequency == nil or blockTable.blocks[r68_31.definition].maxRotationFrequency == nil) then
                                local r68_104 = blockTable.blocks[r68_31.definition]
                                local r68_105 = blockTable.blocks[r68_31.definition]
                                local r68_106 = _G.math.random(r68_104.minRotationFrequency, r68_105.maxRotationFrequency)
                                objects.world[r68_85].rotationFrequency = r68_106 * _G.math.pi / 180
                                local r68_107 = blockTable.blocks[r68_31.definition]
                                local r68_108 = blockTable.blocks[r68_31.definition]
                                local r68_109 = _G.math.random(r68_107.minRotationAmplitude, r68_108.maxRotationAmplitude)
                                objects.world[r68_85].rotationAmplitude = r68_109 * _G.math.pi / 180
                            end
                        end
                    end
                    local r68_110 = blockTable.blocks[r68_31.definition]
                    if r68_110.animateScaleX == true then
                        objects.world[r68_85].animateScaleX = true
                        objects.animatedObjects[r68_85] = r68_31.name
                        local r68_111 = blockTable.blocks[r68_31.definition]
                        objects.world[r68_85].originalScaleX = r68_111.scale or 1
                        local r68_112 = blockTable.blocks[r68_31.definition]
                        objects.world[r68_85].frequencyX = r68_112.scaleXFrequency
                        local r68_113 = blockTable.blocks[r68_31.definition]
                        objects.world[r68_85].amplitudeX = r68_113.scaleXAmplitude
                    end
                    local r68_114 = blockTable.blocks[r68_31.definition]
                    if r68_114.animateScaleY == true then
                        objects.world[r68_85].animateScaleY = true
                        objects.animatedObjects[r68_85] = r68_31.name
                        local r68_115 = blockTable.blocks[r68_31.definition]
                        objects.world[r68_85].originalScaleY = r68_115.scale or 1
                        local r68_116 = blockTable.blocks[r68_31.definition]
                        objects.world[r68_85].frequencyY = r68_116.scaleYFrequency
                        local r68_117 = blockTable.blocks[r68_31.definition]
                        objects.world[r68_85].amplitudeY = r68_117.scaleYAmplitude
                    end
                    local r68_118 = blockTable.blocks[r68_31.definition]
                    if not (r68_118.pivotOffsetX == nil and blockTable.blocks[r68_31.definition].pivotOffsetY == nil) then
                        local r68_119 = blockTable.blocks[r68_31.definition]
                        local r68_120 = blockTable.blocks[r68_31.definition]
                        setPivotOffset(r68_31.name, r68_119.pivotOffsetX or 0, r68_120.pivotOffsetY or 0)
                    end
                    local r68_121 = blockTable.blocks[r68_31.definition]
                    if r68_121.decorations ~= nil then
                        setDecorationObjects(r68_85)
                    end
                    local r68_122 = blockTable.blocks[r68_31.definition]
                    if r68_122.isLevelButton then
                        local r68_123 = blockTable.blocks[r68_31.definition]
                        local r68_124 = r68_123.meta
                        if r68_31.startNumber == nil then
                            objects.world[r68_85].startNumber = 1
                        else
                            objects.world[r68_85].startNumber = r68_31.startNumber
                        end
                        if r68_31.episodeType == nil then
                            objects.world[r68_85].episodeType = 1
                        else
                            objects.world[r68_85].episodeType = r68_31.episodeType
                        end
                        if r68_124 == "URL_BUTTON" then
                            local r68_125 = ui.ScallableButton
                            local r68_126 = {
                                physicsObject = r68_31,
                                name = r68_85,
                                inWorld = true
                            }
                            local r68_127 = r68_125:new(r68_126)
                            r68_127.floorCoordinates = false
                            r68_127.returnValue = "URL_BUTTON_CLICKED"
                            local r68_128 = menuManager
                            if r68_128:getRoot() ~= nil then
                                menuManager:getRoot():addChild(r68_127)
                            end
                        elseif levelName == "LevelSelection" and not startedFromEditor then
                            local r68_129 = ui.LevelButton:new({
                                name = r68_85,
                                physicsObject = r68_31
                            })
                            setVisible(r68_85, false)
                            r68_129.myFeather = doesLevelHaveFeather(currentFolder, r68_31.startNumber)
                            r68_129.floorCoordinates = false
                            r68_129.currentFolder = currentFolder
                            local r68_130 = "showStartNumber"
                            local r68_131 = blockTable.blocks[r68_31.definition]
                            r68_129[r68_130] = r68_131.showStartNumber
                            local r68_132 = "originalImageLocked"
                            local r68_133 = blockTable.blocks[r68_31.definition]
                            r68_129[r68_132] = r68_133.spriteLocked
                            local r68_134 = getStarsRequiredToOpenLevel(currentFolder, r68_31.startNumber)
                            local r68_135 = "disabled"
                            local r68_136 = isLevelUnlocked(currentFolder, r68_31.startNumber)
                            r68_129[r68_135] = not r68_136
                            if r68_134 then
                                r68_129.openedWithStars = true
                                if r68_129.disabled then
                                    r68_129.renderLevelNumber = r68_134
                                else
                                    r68_129.renderLevelNumber = getRenderedLevelNumber(currentFolder, r68_31.startNumber)
                                end
                            else
                                r68_129.renderLevelNumber = getRenderedLevelNumber(currentFolder, r68_31.startNumber)
                            end
                            local r68_137 = nil
                            if isIapEnabled() then
                                local r68_138
                                r68_137 = r68_138
                            end
                            if isBuildUnlocked() ~= true and r68_137 ~= nil and r68_129.disabled then
                                local r68_139 = getEpisodeMetadata(currentFolder)
                                if r68_139.iapPurchase then
                                    local r68_140 = SettingsWrapper
                                    if not r68_140:isEpisodePurchased(r68_137) then
                                        r68_129.showPurchaseEpisodeDialog = true
                                        assert(r68_137 ~= nil, "iap id not defined for this episode")
                                        r68_129.iapId = r68_137
                                        local r68_141 = blockTable.blocks[r68_31.definition]
                                        r68_129.originalImageLocked = r68_141.spriteBeforePurchase or r68_129.originalImageLocked
                                        r68_129.currentFolder = currentFolder
                                    end
                                end
                            end
                            r68_129.returnValue = "GOTO_LEVEL"
                            local r68_142 = menuManager
                            if r68_142:getRoot() ~= nil and (not isPlatformLimited() or isStarLevelAvailableOnThisPlatform(currentFolder, r68_31.startNumber)) then
                                menuManager:getRoot():addChild(r68_129)
                            end
                            local r68_143 = actions.myLevels[currentFolder]
                            r68_129.stars = getLevelStarsFromHighscores(r68_143[r68_31.startNumber])
                        else
                            local r68_144 = levelName
                            local r68_145 = getEpisodeSelectionLevelName()
                            if r68_144 == r68_145 and r68_124 == nil then
                                local r68_146, r68_147, r68_148, r68_149, r68_150, r68_151 = calculateEpisodeScoreAndStars(r68_31.episodeType, r68_31.startNumber)
                                local r68_152 = actions.myLevelFolders
                                local r68_153 = actions.episodeTypeTable
                                local r68_154 = r68_152[r68_153[r68_31.episodeType]]
                                local r68_155 = r68_154[r68_31.startNumber]
                                local r68_156 = getEpisodeMetadata(r68_155)
                                local r68_157 = r68_156.droidEpisode
                                local r68_158 = getObjectDefinition(r68_31.name)
                                setVisible(r68_31.name, false)
                                local r68_159 = r68_158.lockedImage
                                local r68_160
                                if isBobaEpisode(r68_155) then
                                    local r68_161 = ui.BobaEpisodeButton
                                    local r68_162 = {
                                        noEagleElements = r68_157,
                                        name = r68_85,
                                        physicsObject = r68_31,
                                        totalScore = r68_146,
                                        totalPowerupScore = r68_151,
                                        totalStars = r68_147,
                                        maxStars = r68_148,
                                        feathers = r68_149,
                                        maxFeathers = r68_150,
                                        lockedImage = r68_159,
                                        episodeName = r68_155
                                    }
                                    r68_160 = r68_161:new(r68_162)
                                else
                                    local r68_163 = ui.EpisodeButton
                                    local r68_164 = {
                                        noEagleElements = r68_157,
                                        name = r68_85,
                                        physicsObject = r68_31,
                                        totalScore = r68_146,
                                        totalPowerupScore = r68_151,
                                        totalStars = r68_147,
                                        maxStars = r68_148,
                                        feathers = r68_149,
                                        maxFeathers = r68_150,
                                        lockedImage = r68_159,
                                        episodeName = r68_155
                                    }
                                    r68_160 = r68_163:new(r68_164)
                                end
                                r68_160.floorCoordinates = false
                                local r68_165 = actions.myLevelFolders[actions.episodeTypeTable[r68_31.episodeType]]
                                r68_160.disabled = isEpisodeDisabled(r68_165[r68_31.startNumber])
                                local r68_166 = blockTable.blocks[r68_31.definition]
                                if r68_166.spriteLocked then
                                    r68_160.lockedImage = r68_158.spriteLocked
                                end
                                local r68_167 = getEpisodeMetadataWithParam(r68_155, "iapPurchaseId")
                                local r68_168
                                if r68_167 then
                                    local r68_169 = SettingsWrapper
                                    r68_168 = r68_169:isEpisodePurchased(r68_167)
                                else
                                    r68_168 = r68_167
                                end
                                if r68_167 and r68_168 and r68_160.disabled then
                                    r68_160.disabled = false
                                end
                                if r68_167 and SettingsWrapper:isEpisodePurchased(r68_167) and r68_160.disabled then
                                    r68_160.disabled = false
                                end
                                local r68_170 = r68_156.isAvailableForDeviceFunction
                                if r68_170 ~= nil then
                                    local r68_171 = "isEpisodeDisabledByDevice"
                                    local r68_172 = this[r68_170]
                                    local r68_173 = r68_172()
                                    r68_160[r68_171] = r68_173 ~= true
                                end
                                if r68_160.isEpisodeDisabledByDevice and r68_160.disabled ~= true then
                                    r68_160.disabled = true
                                end
                                if not r68_156.unlockedAsDefault and r68_167 and not r68_168 and not isBuildUnlocked() then
                                    r68_160.returnValue = "BUY_BOUNTY_MISSIONS"
                                    r68_160.originalReturnValue = "BUY_BOUNTY_MISSIONS"
                                else
                                    r68_160.returnValue = "GOTO_EPISODE"
                                    r68_160.originalReturnValue = "GOTO_EPISODE"
                                end
                                local r68_174 = menuManager
                                if r68_174:getRoot() ~= nil then
                                    menuManager:getRoot():addChild(r68_160)
                                end
                            end
                        end
                    end
                    local r68_175 = blockTable.blocks[r68_31.definition]
                    if r68_175.isEggsteroid or blockTable.blocks[r68_31.definition].isRocketPack then
                        if r68_31.startNumber == nil then
                            objects.world[r68_85].startNumber = 1
                        else
                            objects.world[r68_85].startNumber = r68_31.startNumber
                        end
                    end
                    local r68_176 = getLevelMetadata(levelName)
                    if r68_176.objectsDestroyableByTap and blockTable.blocks[r68_31.definition].destroyableByTap then
                        objects.destroyableByTap[#objects.destroyableByTap + 1] = r68_85
                    end
                    local r68_177 = getLevelMetadata(levelName)
                    if r68_177.objectsDestroyableByTap and blockTable.blocks[r68_31.definition].onTap then
                        objects.onTap[#objects.onTap + 1] = r68_85
                    end
                    r68_31.angle = _G.math.fmod(r68_31.angle, _G.math.pi * 2)
                    if r68_31.angle < 0 then
                        r68_31.angle = r68_31.angle + _G.math.pi * 2
                    end
                    objects.world[r68_85].startingAngle = r68_31.angle
                    if not (r68_81 == nil and r68_82 == nil) then
                        if r68_81 == nil then
                            setScale(r68_85, 1, r68_82)
                        elseif r68_82 == nil then
                            setScale(r68_85, r68_81, 1)
                        else
                            setScale(r68_85, r68_81, r68_82)
                        end
                    end
                    setRotation(r68_85, r68_31.angle)
                    setMaterial(r68_85, objects.world[r68_85].material)
                    if r68_31.gravityFilterCategory then
                        objects.world[r68_85].gravityFilterCategory = r68_31.gravityFilterCategory
                        if g_gravityFiltersCategories[objects.world[r68_85].gravityFilterCategory] ~= nil then
                            setObjectGravityCategory(r68_85, g_gravityFiltersCategories[objects.world[r68_85].gravityFilterCategory])
                        end
                    end
                    local r68_178 = blockTable.blocks[objects.world[r68_85].definition]
                    if r68_178.themed then
                        local r68_179 = blockTable.blocks[r68_31.definition]
                        local r68_180 = blockTable.blocks[r68_31.definition]
                        if r68_180.useCurrentTheme == nil then
                            local r68_181 = r68_31.themeTexture
                            local r68_182
                            if r68_181 then
                                r68_182 = r68_181
                            else
                                local r68_183 = r68_179.themeTexture
                                if r68_183 then
                                    r68_182 = r68_183
                                else
                                    local r68_184 = blockTable.themes[objects.theme]
                                    r68_182 = r68_184.texture
                                end
                            end
                            setTexture(r68_85, r68_182)
                            objects.world[r68_85].themeTexture = r68_182
                            local r68_185 = blockTable.themes[currentTheme]
                            local r68_186 = r68_185.textureScale or 1
                            setTextureScale(r68_85, r68_186)
                        else
                            local r68_187 = blockTable.themes[currentTheme]
                            local r68_188 = r68_187.texture
                            setTexture(r68_85, r68_188)
                            objects.world[r68_85].themeTexture = r68_188
                            local r68_189 = blockTable.themes[currentTheme]
                            local r68_190 = r68_189.textureScale or 1
                            setTextureScale(r68_85, r68_190)
                        end
                    end
                    local r68_191 = objects.world[r68_85]
                    if r68_191.isSensor then
                        local r68_192 = objects.world[r68_85]
                        if r68_192.sensorType == "stream" then
                            if r68_30.nodes ~= nil then
                                objects.world[r68_85].nodes = r68_30.nodes
                                objects.world[r68_85].radius = r68_30.radius
                                objects.world[r68_85].force = r68_30.force
                                local r68_193 = objects.world[r68_85]
                                print("LOADING STREAM NODES FROM LEVEL Force: " .. r68_193.force)
                                for r68_194, r68_195 in _G.pairs(objects.world[r68_85].nodes) do
                                    print("x: " .. r68_195.x .. " Y: " .. r68_195.y)
                                end
                            end
                            if r68_30.vertices ~= nil then
                                objects.world[r68_85].vertices = r68_30.vertices
                            end
                        end
                    end
                    local r68_196 = objects.world[r68_85]
                    if r68_196.isSensor then
                        local r68_197 = objects.world[r68_85]
                        if r68_197.sensorType == "gravitation" then
                            local r68_198, r68_199 = physicsToWorldTransform(objects.world[r68_85].x, objects.world[r68_85].y)
                            if blockTable.blocks[objects.world[r68_85].definition].type == "box" then
                                objects.world[r68_85].gravitationMinForce = r68_30.gravitationMinForce
                                objects.world[r68_85].gravitationMaxForce = r68_30.gravitationMaxForce
                                objects.world[r68_85].waterDensityZeroLevel = r68_30.waterDensityZeroLevel
                                objects.world[r68_85].height = r68_30.height
                                objects.world[r68_85].width = r68_30.width
                                objects.world[r68_85].forceAngle = r68_30.forceAngle
                                local r68_200 = _G.math.sin
                                local r68_201 = objects.world[r68_85]
                                local r68_202 = r68_200(r68_201.angle)
                                local r68_203 = _G.math.cos
                                local r68_204 = objects.world[r68_85]
                                local r68_205, r68_206 = vNormalize(r68_202, r68_203(r68_204.angle))
                                local r68_207 = print
                                local r68_208 = "CREATING BOX GRAVITY: " .. objects.world[r68_85].width .. ", " .. objects.world[r68_85].height .. [[
]]
                                r68_207(r68_208)
                            else
                                objects.world[r68_85].gravitationMinForce = r68_30.gravitationMinForce
                                objects.world[r68_85].gravitationMaxForce = r68_30.gravitationMaxForce
                                objects.world[r68_85].waterDensityZeroLevel = r68_30.waterDensityZeroLevel
                                objects.world[r68_85].radius = r68_30.radius
                            end
                            if r68_30.waterDensityZeroLevel then
                                native_setIsWater(r68_85, true)
                                native_setWaterDensity(r68_85, r68_30.waterDensityZeroLevel)
                            end
                        else
                            local r68_209 = objects.world[r68_85]
                            if r68_209.sensorType == "killing" then
                                objects.world[r68_85].height = r68_30.height
                                objects.world[r68_85].width = r68_30.width
                            end
                        end
                        objects.world[r68_85].shotData = r68_30.shotData
                        objects.world[r68_85].shotPattern = r68_30.shotPattern
                        if r68_30.active == nil then
                            local r68_210 = blockTable.blocks[objects.world[r68_85].definition]
                            objects.world[r68_85].active = r68_210.active
                        else
                            objects.world[r68_85].active = r68_30.active
                        end
                        local r68_211 = objects.world[r68_85]
                        if r68_211.active == true then
                            setObjectParameter(r68_85, 22, 1)
                        else
                            local r68_212 = objects.world[r68_85]
                            if r68_212.active == false then
                                setObjectParameter(r68_85, 22, 0)
                            end
                        end
                        setObjectParameter(r68_85, 20, 1)
                        local r68_213 = objects.world[r68_85]
                        if r68_213.sensorType == "gravitation" then
                            setObjectParameter(r68_85, 21, 2)
                            local r68_214 = objects.world[r68_85]
                            if r68_214.gravitationMinForce ~= nil then
                                local r68_215 = objects.world[r68_85]
                                setObjectParameter(r68_85, 25, r68_215.gravitationMinForce)
                            end
                            local r68_216 = objects.world[r68_85]
                            if r68_216.gravitationMaxForce ~= nil then
                                local r68_217 = objects.world[r68_85]
                                setObjectParameter(r68_85, 26, r68_217.gravitationMaxForce)
                            end
                            setObjectParameter(r68_85, 32, 1)
                        else
                            local r68_218 = objects.world[r68_85]
                            if r68_218.sensorType == "stream" then
                                setObjectParameter(r68_85, 21, 3)
                            else
                                local r68_219 = objects.world[r68_85]
                                if r68_219.sensorType == "projectile" then
                                    setObjectParameter(r68_85, 21, 5)
                                end
                            end
                        end
                        local r68_220 = objects.world[r68_85]
                        if not (r68_220.gravityCollisionMask == nil or g_gravityFiltersMasks[objects.world[r68_85].gravityCollisionMask] == nil) then
                            setSensorGravityMask(r68_85, g_gravityFiltersMasks[objects.world[r68_85] .. gravityCollisionMask])
                        end
                        local r68_221 = objects.world[r68_85]
                        if not (r68_221.gravityFilterCategory == nil or g_gravityFiltersCategories[objects.world[r68_85].gravityFilterCategory] == nil) then
                            setObjectGravityCategory(r68_85, g_gravityFiltersCategories[objects.world[r68_85].gravityFilterCategory])
                        end
                        local r68_222 = objects.world[r68_85]
                        if r68_222.active == true then
                            setObjectParameter(r68_85, 22, 1)
                        else
                            setObjectParameter(r68_85, 22, 0)
                        end
                        if blockTable.blocks[objects.world[r68_85].definition].type == "box" then
                            setObjectParameter(r68_85, 24, 1)
                            local r68_223 = objects.world[r68_85]
                            setObjectParameter(r68_85, 28, r68_223.width)
                            local r68_224 = objects.world[r68_85]
                            setObjectParameter(r68_85, 35, r68_224.height)
                            local r68_225 = objects.world[r68_85]
                            if r68_225.forceAngle ~= nil then
                                local r68_226 = objects.world[r68_85]
                                setObjectParameter(r68_85, 29, r68_226.forceAngle)
                            end
                        elseif blockTable.blocks[objects.world[r68_85].definition].type ~= "polygon" then
                            setObjectParameter(r68_85, 24, 0)
                            local r68_227 = objects.world[r68_85]
                            if r68_227.radius ~= nil then
                                local r68_228 = objects.world[r68_85]
                                setObjectParameter(r68_85, 27, r68_228.radius)
                            end
                        end
                    end
                    local r68_229 = objects.world[r68_85]
                    if r68_229.levelGoal then
                        objects.world[r68_85].useEmotionSensor = r68_30.useEmotionSensor
                    end
                    local r68_230 = objects.world[r68_85]
                    if r68_230.canBeEdited then
                        if r68_30.explosionRadius ~= nil then
                            objects.world[r68_85].explosionRadius = r68_30.explosionRadius
                        end
                        if r68_30.explosionForce ~= nil then
                            objects.world[r68_85].explosionForce = r68_30.explosionForce
                        end
                        if r68_30.explosionDamageRadius ~= nil then
                            objects.world[r68_85].explosionDamageRadius = r68_30.explosionDamageRadius
                        end
                        if r68_30.explosionDamage ~= nil then
                            objects.world[r68_85].explosionDamage = r68_30.explosionDamage
                        end
                        if r68_30.startingForce ~= nil then
                            objects.world[r68_85].startingForce = r68_30.startingForce
                        end
                        if r68_30.forceAngle ~= nil then
                            objects.world[r68_85].forceAngle = r68_30.forceAngle
                        end
                        local r68_231 = objects.world[r68_85]
                        if r68_231.startingForce ~= nil then
                            local r68_232 = {
                                x = objects.world[r68_85].startingForce * _G.math.sin(objects.world[r68_85].forceAngle),
                                y = objects.world[r68_85].startingForce * _G.math.cos(objects.world[r68_85].forceAngle)
                            }
                            local r68_233 = objects.world[r68_85]
                            local r68_234 = objects.world[r68_85]
                            applyImpulse(r68_85, r68_232.x, r68_232.y, r68_233.x, r68_234.y)
                        end
                    end
                    local r68_235 = objects.world[r68_85]
                    if r68_235.definition == "BLOCK_LEVEL_STARS_3" then
                        objects.levelStars[r68_85] = objects.world[r68_85]
                    end
                    local r68_236 = objects.world[r68_85]
                    if r68_236.controllable then
                        birdsCounter = birdsCounter + 1
                        if r68_31.startNumber == nil then
                            objects.world[r68_85].startNumber = birdsCounter
                        else
                            objects.world[r68_85].startNumber = r68_31.startNumber
                        end
                        local r68_237 = getLevelMetadata(levelName)
                        if r68_237.hideBirdsAndSlingshot then
                            setObjectParameter(r68_85, 33, 0)
                        end
                    end
                    local r68_238 = objects.world[r68_85]
                    local r68_239 = r68_238.width
                    local r68_240 = objects.world[r68_85]
                    local r68_241 = r68_240.height
                    if r68_239 == nil then
                        local r68_242
                        r68_239 = r68_242.radius
                    end
                    if r68_241 == nil then
                        local r68_243
                        r68_241 = r68_243.radius
                    end
                    if objects.world[r68_85].x - r68_239 < levelLeftEdgePhysics then
                        levelLeftEdgePhysics = objects.world[r68_85].x - r68_239
                    end
                    if objects.world[r68_85].x + r68_239 > levelRightEdgePhysics then
                        levelRightEdgePhysics = objects.world[r68_85].x + r68_239
                    end
                    if objects.world[r68_85].y - r68_239 < levelTopEdgePhysics then
                        levelTopEdgePhysics = objects.world[r68_85].y - r68_241
                    end
                    if objects.world[r68_85].y + r68_239 > levelBottomEdgePhysics then
                        levelBottomEdgePhysics = objects.world[r68_85].y + r68_241
                    end
                end
            end
        end
    end
    for r68_244, r68_245 in _G.pairs(objects.world) do
        local r68_246 = getObjectDefinition(r68_244)
        if r68_246.shotData then
            local r68_247 = getJointedObjects(loadedObjects.joints, r68_244)
            local r68_248 = r68_247[1]
            if r68_248 ~= nil then
                fireAction("initEmitter", {
                    name = r68_244,
                    objectCreated = true,
                    parent = r68_248.name
                })
            end
        end
    end
    setupLevelTutorials()
    local r68_249 = getLevelMetadata(levelName)
    local r68_250 = r68_249.additionalChild
    if r68_250 then
        local r68_251 = ui[r68_250.className]
        local r68_252 = { name = r68_250.name or "" }
        local r68_253 = r68_251:new(r68_252)
        menuManager:getRoot():addChild(r68_253)
    end
    if not startedFromEditor then
        for r68_254, r68_255 in _G.pairs(loadedObjects.joints) do
            if r68_255.end1 and r68_255.end2 then
                if objects.world[r68_255.end1] == nil or objects.world[r68_255.end2] == nil then
                    if objects.world[r68_255.end2] == nil then
                        if objects.world[r68_255.end1] ~= nil then
                            objects.levelStars[r68_255.end1] = nil
                            setObjectParameter(r68_255.end1, 33, 0)
                        end
                    else
                        objects.levelStars[r68_255.end2] = nil
                        setObjectParameter(r68_255.end2, 33, 0)
                    end
                    loadedObjects.joints[r68_254] = nil
                else
                    local r68_256 = blockTable.blocks
                    local r68_257 = objects.world[r68_255.end1]
                    local r68_258 = r68_256[r68_257.definition]
                    local r68_259 = blockTable.blocks[objects.world[r68_255.end2].definition]
                    local r68_260, r68_261 = nil, nil
                    local r68_262
                    local r68_263
                    if r68_258.levelStars then
                        local r68_264 = objects.world[r68_255.end2]
                        local r68_265 = objects.world[r68_255.end1]
                        r68_262 = r68_264
                        r68_263 = r68_265
                    elseif r68_259.levelStars then
                        local r68_266 = objects.world[r68_255.end1]
                        local r68_267 = objects.world[r68_255.end2]
                        r68_262 = r68_266
                        r68_263 = r68_267
                    else
                        r68_262 = r68_260
                        r68_263 = r68_261
                    end
                    if r68_262 and r68_263 then
                        local r68_268 = objects.world[r68_262.name]
                        if r68_268.startNumber then
                            setVisible(r68_263.name, true)
                            local r68_269 = actions.myLevels[currentFolder]
                            local r68_270 = objects.world[r68_262.name]
                            local r68_271 = r68_269[r68_270.startNumber]
                            local r68_272 = getLevelStarsFromHighscores(r68_271)
                            if r68_272 == 0 then
                                r68_263.sprite = "BUTTON_LEVEL_STAR_0"
                                local r68_273 = objects.world[r68_262.name]
                                if not isLevelUnlocked(currentFolder, r68_273.startNumber) then
                                    setVisible(r68_263.name, false)
                                end
                                if not (highscores[r68_271] == nil or highscores[r68_271].eagleScore == nil) then
                                    setVisible(r68_263.name, true)
                                end
                                local r68_274 = SettingsWrapper
                                local r68_275 = "getLevelProgress"
                                if r68_274[r68_275](r68_274, currentFolder) == objects.world[r68_262.name].startNumber then
                                    setVisible(r68_263.name, true)
                                    local r68_276 = getEpisodeMetadata(currentFolder)
                                    if r68_276.openLevelsLimit and objects.world[r68_262.name].startNumber >= getEpisodeMetadata(currentFolder).openLevelsLimit + 2 then
                                        setVisible(r68_263.name, false)
                                    end
                                end
                            elseif r68_272 == 1 then
                                r68_263.sprite = "BUTTON_LEVEL_STAR_1"
                            elseif r68_272 == 2 then
                                r68_263.sprite = "BUTTON_LEVEL_STAR_2"
                            elseif r68_272 == 3 then
                                r68_263.sprite = "BUTTON_LEVEL_STAR_3"
                            end
                            if getEpisodeMetadata(currentFolder).iapPurchase == true and getEpisodeMetadataWithParam(currentFolder, "iapPurchaseId") ~= nil and SettingsWrapper:isEpisodePurchased(getEpisodeMetadataWithParam(currentFolder, "iapPurchaseId")) ~= true and highscores[r68_271] == nil then
                                setVisible(r68_263.name, false)
                            end
                            local r68_277 = getEpisodeMetadata(currentFolder)
                            if r68_277.droidEpisode and SettingsWrapper:isDroidLevelUnlocked(r68_271) ~= true and highscores[r68_271] == nil then
                                setVisible(r68_263.name, false)
                            end
                            setVisible(r68_263.name, false)
                            setSprite(r68_263.name, r68_263.sprite)
                        end
                    end
                end
            end
        end
    end
    connectPortals()
    objects.worldGravity = loadedObjects.worldGravity
    setWorldGravity(0, objects.worldGravity or 0)
    spawnList = {}
    if loadedObjects.themeSprites then
        for r68_278, r68_279 in _G.pairs(loadedObjects.themeSprites) do
            addThemeSprite(r68_278, r68_279, r68_279.layer)
            if not objects.themeSprites then
                objects.themeSprites = {}
            end
            objects.themeSprites[r68_279.name] = {
                definition = r68_279.definition,
                name = r68_279.name,
                x = r68_279.x,
                y = r68_279.y,
                layer = r68_279.layer,
                angle = r68_279.angle,
                scale = { x = r68_279.scale.x, y = r68_279.scale.y },
                screenX = r68_279.screenX,
                screenY = r68_279.screenY
            }
        end
    end
    if loadedObjects.joints ~= nil then
        createJoints(loadedObjects.joints)
    end
    objects.castleCameraData = loadedObjects.castleCameraData
    objects.birdCameraData = loadedObjects.birdCameraData
    objects.doNotWaitForMovingObjects = loadedObjects.doNotWaitForMovingObjects
    selectedBird = nil
    local r68_280 = 0
    for r68_281, r68_282 in _G.pairs(objects.world) do
        if r68_282.controllable == true then
            r68_282.damageDone = 0
            local r68_283 = "animTimer"
            local r68_284 = _G.math.random(10, 30)
            r68_282[r68_283] = r68_284 / 10
            local r68_285 = "jumpTimer"
            local r68_286 = _G.math.random(10, 30)
            r68_282[r68_285] = r68_286 / 10
            setObjectParameter(r68_282.name, 2, 0)
            birds[r68_281] = r68_282
        end
        if r68_282.levelGoal then
            local r68_287 = "blinkTimer"
            local r68_288 = _G.math.random(5, 30)
            r68_282[r68_287] = r68_288 / 10
            levelGoals[r68_281] = r68_282
            setObjectParameter(r68_281, 1, 1)
            if r68_282.useEmotionSensor == nil then
                r68_282.useEmotionSensor = true
            end
        end
        local r68_289 = getObjectDefinition(r68_281)
        if r68_289.isBubble then
            setObjectParameter(r68_281, 34, 1)
        end
        if r68_282.definition ~= "compound" then
            if getObjectDefinition(r68_281).animations ~= nil then
                animatedObjects[r68_281] = r68_282
                setObjectParameter(r68_281, 13, 1)
            end
            local r68_290 = blockTable.blocks[r68_282.definition]
            local r68_291 = r68_290.bounceAmplitudeMultiplier or 0
            local r68_292 = blockTable.blocks[r68_282.definition]
            local r68_293 = r68_292.bounceFrequencyMultiplier or 0
            setObjectParameter(r68_282.name, 6, r68_291)
            setObjectParameter(r68_282.name, 7, r68_293)
            local r68_294 = getDamageSprite(r68_282, blockTable.blocks)
            r68_282.damageSprite = r68_294.sprite
            r68_282.blinkSprite = r68_294.blink
            r68_282.smileSprite = r68_294.smile
            r68_282.frozen = false
            local r68_295 = blockTable.blocks[r68_282.definition]
            local r68_296 = r68_295.destroyedScoreInc
            if r68_296 == nil then
                r68_296 = pigletteDestroyedScoreIncrement
            end
            if r68_282.controllable then
                r68_280 = r68_280 + birdsLeftScoreIncrement
            elseif r68_282.levelGoal then
                local r68_297 = r68_282.strength
                r68_280 = r68_280 + r68_297 * 10 + r68_296
            elseif r68_282.defence <= 1000 then
                local r68_298 = r68_282.strength
                local r68_299 = r68_280 + r68_298 * 10
                destroyedBonus = blockDestroyedScoreIncrement
                local r68_300 = blockTable.blocks[r68_282.definition]
                if r68_300.destroyedScoreInc ~= nil then
                    local r68_301 = blockTable.blocks[r68_282.definition]
                    destroyedBonus = r68_301.destroyedScoreInc
                end
                r68_280 = r68_299 + destroyedBonus
            end
        end
    end
    local r68_302 = r68_280 - birdsLeftScoreIncrement
    levelStartTimer = 0
    for r68_303, r68_304 in _G.pairs(birds) do
        setObjectParameter(r68_303, 2, 1)
        r68_304.controlRadius = 5.5
        if not (r68_304.originalPosX and r68_304.originalPosY) then
            r68_304.originalPosX = r68_304.x
            r68_304.originalPosY = r68_304.y
        end
    end
    local r68_305 = getNextBird(1)
    if r68_305 ~= nil then
        setObjectParameter(r68_305, 2, 1)
    end
    if currentFolder ~= "bonus" and resumingOldLevel then
        levelStartPosition.x = oldLevelStartPosition.x
        levelStartPosition.y = oldLevelStartPosition.y
        rubberBandPos.x = oldLevelStartPosition.x - 0.10000000149011612
        rubberBandPos.y = oldLevelStartPosition.y - 0.10000000149011612
        slingShotAngle = oldSlingShotAngle
        resumingOldLevel = false
    elseif r68_305 ~= nil and objects.world[r68_305] ~= nil then
        local r68_306, r68_307 = res.getSpritePivot("SLING_SHOT_01_BACK")
        local r68_308, r68_309 = res.getSpriteBounds("SLING_SHOT_01_BACK")
        local r68_310 = objects.world[r68_305]
        local r68_311 = r68_310.radius
        if r68_311 == nil then
            r68_311 = 0
        end
        levelStartPosition.x = objects.world[r68_305].x
        levelStartPosition.y = objects.world[r68_305].y - (r68_309 - r68_307) * physicsScale + r68_311 + 0.20000000298023224
        rubberBandPos.x = levelStartPosition.x - 0.10000000149011612
        rubberBandPos.y = levelStartPosition.y - 0.10000000149011612
        slingShotAngle = objects.world[r68_305].angle
        g_slingshotStandingPosition = {}
        local r68_312, r68_313 = physicsToScreenTransform(levelStartPosition.x, levelStartPosition.y)
        local r68_314 = r68_313 + (r68_309 - r68_307) / slingshotScale
        local r68_315 = g_slingshotStandingPosition
        local r68_316 = g_slingshotStandingPosition
        local r68_317, r68_318 = screenToPhysicsTransform(r68_312, r68_314)
        r68_316.y = r68_318
        r68_315.x = r68_317
    end
    local r68_319 = blockTable.themes[objects.theme]
    local r68_320 = r68_319.skyColor
    setBGColor(r68_320.r, r68_320.g, r68_320.b)
    cameraFunction = levelStartCamera
    if objects.castleCameraData == nil then
        objects.castleCameraData = {}
        objects.castleCameraData[deviceModel] = {}
        local r68_321 = objects.castleCameraData[deviceModel]
        r68_321.sx = 1
        r68_321.sy = 1
        r68_321.px = screen.x
        r68_321.py = screen.y
    else
        for r68_322 = 1, #g_cameraProfileList do
            local r68_323 = g_cameraProfileList[r68_322]
            if objects.castleCameraData[r68_323] ~= nil then
                local r68_324 = deviceModel
                if r68_323 ~= r68_324 then
                    objects.castleCameraData[deviceModel] = {}
                    local r68_325 = objects.castleCameraData[deviceModel]
                    local r68_326 = objects.castleCameraData[r68_323]
                    r68_325.px = r68_326.px
                    local r68_327 = objects.castleCameraData[deviceModel]
                    local r68_328 = objects.castleCameraData[r68_323]
                    r68_327.py = r68_328.py
                    local r68_329 = objects.castleCameraData[deviceModel]
                    local r68_330 = objects.castleCameraData[r68_323]
                    r68_329.sx = r68_330.sx
                    local r68_331 = objects.castleCameraData[deviceModel]
                    r68_331.sy = objects.castleCameraData[r68_323].sy
                    local r68_332 = objects.castleCameraData[deviceModel]
                    r68_332.screenWidth = objects.castleCameraData[r68_323].screenWidth
                    local r68_333 = objects.castleCameraData[deviceModel]
                    r68_333.screenHeight = objects.castleCameraData[r68_323].screenHeight
                    local r68_334 = objects.castleCameraData[deviceModel]
                    r68_334.otherCameras = objects.castleCameraData[r68_323].otherCameras
                end
                break
            end
        end
        local r68_335
        if r68_335 == false then
            if objects.castleCameraData.px == nil then
                objects.castleCameraData[deviceModel] = {}
                local r68_336 = objects.castleCameraData[deviceModel]
                r68_336.px = screen.x
                local r68_337 = objects.castleCameraData[deviceModel]
                r68_337.py = screen.y
                local r68_338 = objects.castleCameraData[deviceModel]
                r68_338.sx = 1
                local r68_339 = objects.castleCameraData[deviceModel]
                r68_339.sy = 1
                local r68_340 = objects.castleCameraData[deviceModel]
                r68_340.screenWidth = screenWidth
                local r68_341 = objects.castleCameraData[deviceModel]
                r68_341.screenHeight = screenHeight
            else
                objects.castleCameraData[deviceModel] = {}
                local r68_342 = objects.castleCameraData[deviceModel]
                r68_342.px = objects.castleCameraData.px
                local r68_343 = objects.castleCameraData[deviceModel]
                r68_343.py = objects.castleCameraData.py
                local r68_344 = objects.castleCameraData[deviceModel]
                r68_344.sx = objects.castleCameraData.sx
                local r68_345 = objects.castleCameraData[deviceModel]
                r68_345.sy = objects.castleCameraData.sy
                local r68_346 = objects.castleCameraData[deviceModel]
                r68_346.screenWidth = objects.castleCameraData.screenWidth
                local r68_347 = objects.castleCameraData[deviceModel]
                r68_347.screenHeight = objects.castleCameraData.screenHeight
                local r68_348 = objects.castleCameraData[deviceModel]
                local r68_349 = "otherCameras"
                local r68_350 = objects.castleCameraData[cameraProfile]
                r68_348[r68_349] = r68_350.otherCameras
            end
        end
        local r68_351 = objects.castleCameraData[deviceModel]
        if r68_351.screenWidth == nil then
            r68_351.screenWidth = 1680
        end
        if r68_351.screenHeight == nil then
            r68_351.screenHeight = 1050
        end
        originalCameras[2] = {}
        originalCameras[2].px = r68_351.px
        originalCameras[2].py = r68_351.py
        originalCameras[2].sx = r68_351.sx
        originalCameras[2].sy = r68_351.sy
        originalCameras[2].left = r68_351.px - r68_351.screenWidth * 0.5 / r68_351.sx
        originalCameras[2].right = r68_351.px + r68_351.screenWidth * 0.5 / r68_351.sx
        originalCameras[2].top = r68_351.py - r68_351.screenHeight * 0.5 / r68_351.sy
        originalCameras[2].bottom = r68_351.py + r68_351.screenHeight * 0.5 / r68_351.sy
        originalCameras[2].screenWidth = r68_351.screenWidth
        originalCameras[2].screenHeight = r68_351.screenHeight
        originalCameras[2].otherCameras = r68_351.otherCameras
        worldScale = r68_351.sx
        setWorldScale(worldScale)
        screen.x = r68_351.px
        screen.y = r68_351.py
        screen.left = screen.x - screenWidth * 0.5 / worldScale
        screen.top = screen.y - screenHeight * 0.5 / worldScale
        screen.right = screen.x + screenWidth * 0.5 / worldScale
        screen.bottom = screen.y + screenHeight * 0.5 / worldScale
    end
    local r68_352 = objects.castleCameraData[deviceModel]
    r68_352.top = screen.top
    r68_352.left = screen.left
    r68_352.right = screen.right
    r68_352.bottom = screen.bottom
    cameraAnimationSlider = 1
    cameraAnimationSliderTarget = 1
    defaultCamera()
    if objects.birdCameraData == nil then
        objects.birdCameraData = {}
        objects.birdCameraData[deviceModel] = {}
        local r68_353 = objects.birdCameraData[deviceModel]
        r68_353.sx = 1
        r68_353.sy = 1
        r68_353.px = screen.x
        r68_353.py = screen.y
        r68_353.left = r68_353.px - screenWidth * 0.5
        r68_353.top = r68_353.py - screenHeight * 0.5
        r68_353.right = screen.left + screenWidth
        r68_353.bottom = screen.top + screenHeight
    else
        for r68_354 = 1, #g_cameraProfileList do
            local r68_355 = g_cameraProfileList[r68_354]
            if objects.birdCameraData[r68_355] ~= nil then
                local r68_356 = deviceModel
                if r68_355 ~= r68_356 then
                    objects.birdCameraData[deviceModel] = {}
                    local r68_357 = objects.birdCameraData[deviceModel]
                    local r68_358 = objects.birdCameraData[r68_355]
                    r68_357.px = r68_358.px
                    local r68_359 = objects.birdCameraData[deviceModel]
                    local r68_360 = objects.birdCameraData[r68_355]
                    r68_359.py = r68_360.py
                    local r68_361 = objects.birdCameraData[deviceModel]
                    local r68_362 = objects.birdCameraData[r68_355]
                    r68_361.sx = r68_362.sx
                    local r68_363 = objects.birdCameraData[deviceModel]
                    r68_363.sy = objects.birdCameraData[r68_355].sy
                    local r68_364 = objects.birdCameraData[deviceModel]
                    r68_364.screenWidth = objects.birdCameraData[r68_355].screenWidth
                    local r68_365 = objects.birdCameraData[deviceModel]
                    r68_365.screenHeight = objects.birdCameraData[r68_355].screenHeight
                end
                break
            end
        end
        local r68_366
        if r68_366 == false then
            if objects.birdCameraData.px == nil then
                objects.birdCameraData[deviceModel] = {}
                local r68_367 = objects.birdCameraData[deviceModel]
                r68_367.px = screen.x
                local r68_368 = objects.birdCameraData[deviceModel]
                r68_368.py = screen.y
                local r68_369 = objects.birdCameraData[deviceModel]
                r68_369.sx = 1
                local r68_370 = objects.birdCameraData[deviceModel]
                r68_370.sy = 1
                local r68_371 = objects.birdCameraData[deviceModel]
                r68_371.screenWidth = screenWidth
                local r68_372 = objects.birdCameraData[deviceModel]
                r68_372.screenHeight = screenHeight
            else
                objects.birdCameraData[deviceModel] = {}
                local r68_373 = objects.birdCameraData[deviceModel]
                r68_373.px = objects.birdCameraData.px
                local r68_374 = objects.birdCameraData[deviceModel]
                r68_374.py = objects.birdCameraData.py
                local r68_375 = objects.birdCameraData[deviceModel]
                r68_375.sx = objects.birdCameraData.sx
                local r68_376 = objects.birdCameraData[deviceModel]
                r68_376.sy = objects.birdCameraData.sy
                local r68_377 = objects.birdCameraData[deviceModel]
                r68_377.screenWidth = objects.birdCameraData.screenWidth
                local r68_378 = objects.birdCameraData[deviceModel]
                r68_378.screenHeight = objects.birdCameraData.screenHeight
            end
        end
        local r68_379 = objects.birdCameraData[deviceModel]
        if r68_379.screenWidth == nil then
            r68_379.screenWidth = 1680
        end
        if r68_379.screenHeight == nil then
            r68_379.screenHeight = 1050
        end
        originalCameras[1] = {}
        originalCameras[1].px = r68_379.px
        originalCameras[1].py = r68_379.py
        originalCameras[1].sx = r68_379.sx
        originalCameras[1].sy = r68_379.sy
        originalCameras[1].left = r68_379.px - r68_379.screenWidth * 0.5 / r68_379.sx
        originalCameras[1].right = r68_379.px + r68_379.screenWidth * 0.5 / r68_379.sx
        originalCameras[1].top = r68_379.py - r68_379.screenHeight * 0.5 / r68_379.sy
        originalCameras[1].bottom = r68_379.py + r68_379.screenHeight * 0.5 / r68_379.sy
        originalCameras[1].screenWidth = r68_379.screenWidth
        originalCameras[1].screenHeight = r68_379.screenHeight
        r68_379.left = r68_379.px - screenWidth * 0.5 / r68_379.sx
        r68_379.top = r68_379.py - screenHeight * 0.5 / r68_379.sy
        r68_379.right = screen.left + screenWidth / r68_379.sx
        r68_379.bottom = screen.top + screenHeight / r68_379.sy
    end
    local r68_380 = objects.castleCameraData[deviceModel]
    r68_381 = r68_380.px
    local r68_382 = objects.castleCameraData[deviceModel]
    r68_383 = r68_382.py
    local r68_384 = objects.birdCameraData[deviceModel]
    r68_385 = r68_384.px
    local r68_386 = objects.birdCameraData[deviceModel]
    r68_387 = r68_386.py
    local r68_388 = objects.birdCameraData[deviceModel]
    g_toggleLevelCameraControl = false
    local r68_389 = originalCameras[2]
    if r68_389.left == nil then
        originalCameras[2].left = 200
        originalCameras[2].right = 400
        originalCameras[2].screenWidth = 400
        originalCameras[2].screenHeight = 400
        originalCameras[2].right = 400
        originalCameras[2].top = 200
        originalCameras[2].bottom = 0
    end
    local r68_390 = originalCameras[1]
    if r68_390.left == nil then
        originalCameras[1].left = 0
        originalCameras[1].screenWidth = 400
        originalCameras[1].screenHeight = 400
        originalCameras[1].right = 400
        originalCameras[1].top = 200
        originalCameras[1].bottom = 0
    end
    local r68_391 = objects.castleCameraData[deviceModel]
    if r68_391.otherCameras ~= nil then
        local r68_392 = 3
        local r68_393 = _G.pairs
        local r68_394 = objects.castleCameraData[deviceModel]
        for r68_395, r68_396 in r68_393(r68_394.otherCameras) do
            if r68_396 ~= nil then
                originalCameras[r68_392] = {}
                originalCameras[r68_392].px = r68_396.px
                originalCameras[r68_392].py = r68_396.py
                originalCameras[r68_392].sx = r68_396.sx
                originalCameras[r68_392].sy = r68_396.sy
                originalCameras[r68_392].screenWidth = r68_396.screenWidth
                originalCameras[r68_392].screenHeight = r68_396.screenHeight
                originalCameras[r68_392].left = r68_396.px - r68_396.screenWidth * 0.5 / r68_396.sx
                originalCameras[r68_392].right = r68_396.px + r68_396.screenWidth * 0.5 / r68_396.sx
                originalCameras[r68_392].top = r68_396.py - r68_396.screenHeight * 0.5 / r68_396.sy
                originalCameras[r68_392].bottom = r68_396.py + r68_396.screenHeight * 0.5 / r68_396.sy
                r68_392 = r68_392 + 1
            end
        end
    end
    native_refreshThemeSystem()
    changeCameras(0)
    cameraAnimationSlider = 1
    if g_oldLevelName ~= levelName or numberOfAttemptsInLevel == 0 or startedFromEditor == true then
        local r68_397, r68_398 = objects.castleCameraData[deviceModel], objects.birdCameraData[deviceModel]
        local r68_399 = r68_397.sx
        local r68_400
        if r68_398.sx < r68_399 then
            local r68_401 = r68_397.sx
            if r68_401 then
                r68_400 = r68_401
            else
                r68_400 = r68_398.sx
            end
        else
            r68_400 = r68_398.sx
        end
        currentZoomedScale = r68_400
        maxZoomLevel = true
        animationScreen.x = r68_397.px
        animationScreen.y = r68_397.py
        animationWorldScale = worldScale
        animationWorldScale2 = worldScale
    end
    setMaxWorldScale(_G.math.min(r68_388.sx, r68_352.sx))
    _G.collectgarbage("collect")
    for r68_402, r68_403 in _G.pairs(activeSensors) do
        r68_403.touchingObjects = nil
    end
    activeSensors = {}
    populateWithRandomThemeSprites()
    ClearSimulationTrajectory()
    if objects.rotatingMenuJoint ~= nil then
        setRevoluteJointSpeed(objects.rotatingMenuJoint, 0)
    end
    local r68_404 = getLevelMetadata(levelName)
    g_drawLevelCameraIndexes = r68_404.drawCameraIndexes
    local r68_405 = getLevelMetadata(levelName)
    if r68_405.triggerEventList ~= nil then
        for r68_406, r68_407 in _G.pairs(r68_405.triggerEventList) do
            addEventCall(r68_407.name, r68_407.params)
        end
    end
    local r68_408 = getLevelMetadata(levelName)
    if not r68_408.hidePauseButton and not startedFromEditor then
        local r68_409 = ui.ScallableButton
        local r68_410 = {
            name = "pauseButton",
            activateOnRelease = true,
            refuseDragTargetting = true
        }
        local r68_411 = r68_409:new(r68_410)
        r68_411.clickSound = "ButtonBack"
        local r68_412 = "setImage"
        local r68_413 = getLevelMetadata(levelName)
        r68_411[r68_412](r68_411, r68_413.backButtonSprite or "BTN_PAUSE")
        r68_411.returnValue = "PAUSE_CLICKED"
        local r68_414 = menuManager:getRoot()
        if r68_414 ~= nil then
            r68_414:addChild(r68_411)
        end
    end
    local r68_415 = getLevelMetadata(levelName)
    if r68_415.showScrollButtons and isPCVersion() and (currentFolder ~= "bobaFett_1" or levelName ~= "LevelSelection") then
        local r68_416 = ui.ScallableButton:new({ name = "leftButton", activateOnRelease = true })
        r68_416:setImage("BTN_ARROW_LEFT_SMALL", "BTN_SCROLL_INACTIVE_LEFT")
        r68_416.returnValue = "LEFT_CLICKED"
        local r68_417 = ui.ScallableButton:new({ name = "rightButton", activateOnRelease = true })
        r68_417:setImage("BTN_ARROW_RIGHT_SMALL", "BTN_SCROLL_INACTIVE_RIGHT")
        r68_417.returnValue = "RIGHT_CLICKED"
        local r68_418 = menuManager:getRoot()
        if r68_418 ~= nil then
            r68_418:addChild(r68_416)
            r68_418:addChild(r68_417)
        end
    end
    if getLevelMetadata(levelName).ignoreTutorial ~= true then
        calculateRewardState()
    end
    if not objects.worldGravity and not getLevelMetadata(levelName).ignoreKillingVolume and (not startedFromEditor or physicsEnabled) then
        print([[< Creating KillingBox >
]])
        if loadedObjects.killingBox == nil or loadedObjects.killingBox[deviceModel] == nil then
            addKillingBox()
        else
            local r68_419 = loadedObjects.killingBox[deviceModel]
            local r68_420 = loadedObjects.killingBox[deviceModel]
            addKillingBox(r68_419.offsetW, r68_420.offsetH)
        end
    else
        print([[< Not Creating KillingBox >
]])
    end
    for r68_421, r68_422 in _G.pairs(loadedObjects) do
        loadedObjects[r68_421] = nil
    end
    loadedObjects.cameraData = nil
    loadedObjects = nil
    setupComic()
    local r68_423 = SettingsWrapper
    r68_423:setCurrentVersion(gameVersionNumber)
    resetMouseWheelScale(10)
    if (g_oldLevelName ~= levelName or numberOfAttemptsInLevel == 0) and deviceModel == "iphone4" then
        currentZoomedScale = 10
        maxZoomLevel = true
    end
    local r68_424 = objects
    local r68_425 = objects.gravityForceMultiplier or worldAttributes.defaultGravityForceMultiplier
    r68_424.gravityForceMultiplier = r68_425
    levelStartCamera(0)
    g_targetVisualizationUserInputWaitTimer = TARGET_VISUALIZATION_WAIT_LEVEL_START
    g_showTargetVisualizationTimer = nil
    local r68_426 = getLevelMetadata(levelName)
    local r68_427 = r68_426.trophy
    if _G.type(r68_427) == "table" then
        for r68_428, r68_429 in _G.ipairs(r68_427) do
            checkStoreLevelTrophy(r68_429)
        end
    else
        checkStoreLevelTrophy(r68_427)
    end
    native_onLevelInitComplete()
    eventManager:notify({ id = events.EID_LEVEL_LOADING_DONE })
    createForegroundParticles(levelName)
end

-- line 4017-4043
-- proto#69 params=1 locals=14 upvalues=0 vararg=false
function createForegroundParticles(p69_0)
    local r69_0 = getLevelMetadata(p69_0)
    local r69_1 = r69_0.foregroundParticleEffect
    if r69_1 then
        local r69_2 = screenWidth / screenHeight
        local r69_3, r69_4, r69_5 = levelLeftEdgePhysics, levelRightEdgePhysics, levelTopEdgePhysics
        local r69_6 = levelBottomEdgePhysics
        local r69_7 = r69_4 - r69_3
        local r69_8 = r69_6 - r69_5
        local r69_9 = r69_7 / physicsScale
        local r69_10 = r69_8 / physicsScale
        local r69_11 = r69_10 * r69_2 - r69_10
        putParticles({
            particles = r69_1,
            amount = particleTable.particles[r69_1].amount,
            worldX = r69_3 / physicsScale + r69_9 * 0.5,
            worldY = r69_11 * 0.5 + (r69_5 / physicsScale - r69_11 * 0.5) + r69_10 * 0.5,
            w = r69_9,
            h = r69_10 + r69_11,
            mode = 1
        })
    end
end

-- line 4045-4050
-- proto#70 params=1 locals=0 upvalues=0 vararg=false
function checkStoreLevelTrophy(p70_0)
    if p70_0 and not SettingsWrapper:isLevelTrophyStored(p70_0) then
        SettingsWrapper:storeLevelTrophy(p70_0)
        SettingsWrapper:setLevelTrophyAvailabilityStatus(true)
    end
end

-- line 4052-4067
-- proto#71 params=2 locals=2 upvalues=0 vararg=false
function isStarLevelAvailableOnThisPlatform(p71_0, p71_1)
    if actions.myLevels[p71_0] == nil then
        return true
    end
    local r71_0 = actions.myLevelsMetadata
    local r71_1 = actions.myLevels[p71_0]
    if r71_0[r71_1[p71_1]] == nil then
        return true
    end
    local r71_2 = actions.myLevelsMetadata[actions.myLevels[p71_0][p71_1]]
    if r71_2.unavailableOnNonIaps and isPlatformLimited() then
        return false
    end
    return true
end

-- line 4070-4079
-- proto#72 params=0 locals=4 upvalues=0 vararg=false
function setupComic()
    levelMD = getLevelMetadata(levelName)
    if levelMD.type == "comic" then
        local r72_0 = ui.comicPage1
        local r72_1 = {
            name = "comicsPage",
            levelName = levelName,
            currentFolder = currentFolder,
            animName = levelMD.comicAnimName
        }
        comicPage = r72_0:new(r72_1)
        local r72_2 = eventManager
        local r72_3 = { id = events.EID_PUSH_FRAME, target = comicPage }
        r72_2:notify(r72_3)
    end
end

-- line 4081-4095
-- proto#73 params=1 locals=8 upvalues=0 vararg=false
function copyProjectileTable(p73_0)
    local r73_0 = {}
    for r73_1, r73_2 in _G.pairs(p73_0) do
        if _G.type(r73_2) == "table" then
            r73_0[r73_1] = {}
            for r73_3, r73_4 in _G.pairs(r73_2) do
                r73_0[r73_1][r73_3] = r73_4
            end
        else
            r73_0[r73_1] = r73_2
        end
    end
    return r73_0
end

-- line 4097-4108
-- proto#74 params=1 locals=4 upvalues=0 vararg=false
function deepCopy(p74_0)
    local r74_0 = _G.type
    local r74_1
    if r74_0(p74_0) == "table" then
        r74_1 = {}
        for r74_2, r74_3 in _G.pairs(p74_0) do
            r74_1[r74_2] = deepCopy(r74_3)
        end
    else
        r74_1 = p74_0
    end
    return r74_1
end

-- line 4110-4206
-- proto#75 params=1 locals=19 upvalues=0 vararg=false
function removeBird(p75_0)
    if p75_0.controllable and p75_0.damageDone == 0 then
        lastBirdFailedTime = timeSpentInLevel
    end
    if p75_0.name == currentForceTarget and g_birdEmitterTargets[currentForceTarget] ~= nil then
        g_birdEmitterTargets[currentForceTarget] = nil
    end
    p75_0.startedOutsideAtmosphere = nil
    local r75_0 = p75_0.name
    if not (p75_0.linkedObject == nil or objects.world[p75_0.linkedObject] == nil) then
        local r75_1 = objects.world[p75_0.linkedObject]
        r75_1.linkedObject = nil
        removeBird(objects.world[p75_0.linkedObject])
    end
    if not p75_0.didDamage and p75_0.doNotCount ~= true and getObjectDefinition(r75_0).specialty == "CLUSTER_BOMB" and (_G.string.sub(r75_0, _G.string.len(r75_0), _G.string.len(r75_0)) == "a" or _G.string.sub(r75_0, _G.string.len(r75_0), _G.string.len(r75_0)) == "b" or _G.string.sub(r75_0, _G.string.len(r75_0), _G.string.len(r75_0)) == "c") then
        local r75_2 = _G.string.len(r75_0)
        local r75_3 = _G.string.sub(r75_0, 1, r75_2 - 1)
        if g_blueBirdDidDamage == nil then
            g_blueBirdDidDamage = {}
        end
        if g_blueBirdDidDamage[r75_3] == nil then
            g_blueBirdDidDamage[r75_3] = 1
        else
            g_blueBirdDidDamage[r75_3] = g_blueBirdDidDamage[r75_3] + 1
        end
        if g_blueBirdDidDamage[r75_3] < 3 then

        end
    end
    local r75_4 = objects.world[r75_0]
    local r75_5 = r75_4.emitterBody
    if r75_5 ~= nil then
        destroyEmitter(r75_5)
    end
    putParticles({
        objectName = r75_0,
        particles = getObjectDefinition(r75_0).particlesDestroyed,
        amount = 10
    })
    if cameraTargetObject == p75_0 then
        setCameraTargetObject(nil)
    end
    if currentBirdName == r75_0 then
        currentBirdName = nil
    end
    if flyingBird == p75_0 then
        local r75_6 = blockTable.blocks[flyingBird.definition]
        local r75_7 = r75_6.sounds.special_loop
        if r75_7 then
            stopAudio(r75_7)
        end
        if flyingBird.removeEmitterTargetTimer and g_birdEmitterTargets[flyingBird.name] then
            g_birdEmitterTargets[flyingBird.name] = nil
        end
        flyingBird = nil
        birdSpecialtyAvailable = false
    end
    local r75_8 = blockTable.blocks[p75_0.definition]
    if r75_8.sounds.destroy then
        local r75_9 = blockTable.blocks[p75_0.definition]
        res.playAudio(r75_9.sounds.destroy)
    end
    removeObject(r75_0)
    objects.world[r75_0] = nil
    birds[r75_0] = nil
    otherBirds[r75_0] = nil
    animatedObjects[r75_0] = nil
end

-- line 4208-4439
-- proto#76 params=0 locals=94 upvalues=0 vararg=false
function gotoLevelEnding()
    if startedFromEditor then
        local r76_0 = eventManager
        local r76_1 = { id = events.EID_CHANGE_SCENE, target = "editorScene" }
        r76_0:notify(r76_1)
        return
    end
    local r76_2 = 0
    local r76_3
    if PowerupManager then
        if PowerupManager:werePowerupsUsed() then
            if highscores[levelName] == nil then
                if highscores[levelName] ~= nil then
                    r76_3 = highscores[levelName]
                    if r76_3.score ~= nil then
                        local r76_4 = highscores[levelName]
                        r76_2 = r76_4.score
                    end
                end
            else
                local r76_5 = highscores[levelName]
                if r76_5.powerUpScore == nil then
                    if highscores[levelName] ~= nil then
                        r76_3 = highscores[levelName]
                        if r76_3.score ~= nil then
                            local r76_6 = highscores[levelName]
                            r76_2 = r76_6.score
                        end
                    end
                else
                    local r76_7 = highscores[levelName]
                    r76_2 = r76_7.powerUpScore
                end
            end
        elseif highscores[levelName] ~= nil then
            r76_3 = highscores[levelName]
            if r76_3.score ~= nil then
                local r76_8 = highscores[levelName]
                r76_2 = r76_8.score
            end
        end
    elseif highscores[levelName] ~= nil then
        r76_3 = highscores[levelName]
        if r76_3.score ~= nil then
            local r76_9 = highscores[levelName]
            r76_2 = r76_9.score
        end
    end
    local r76_10 = eventManager
    local r76_11 = { id = events.EID_PUSH_FRAME, target = LevelEndRoot:new() }
    r76_10:notify(r76_11)
    disableGameUpdate()
    clearParticlesNative()
    enableInGameParticlesNative(false)
    local r76_12 = getEpisodeMetadata(currentFolder)
    local r76_13 = r76_12.droidEpisode
    if levelCompleted then
        local r76_14 = actions.myLevels[currentFolder]
        if r76_14[currentLevel + 1] == nil then
            if currentFolder == "theme1" then
                storeLevelProgress(currentFolder, currentLevel)
            end
        else
            storeLevelProgress(currentFolder, currentLevel)
        end
        local r76_15 = isEagleUsedInLevel()
        local r76_16 = getLevelStarsFromHighscores(levelName)
        local r76_17 = getLevelStars(levelName, score)
        local r76_18 = nil
        local r76_19 = eventManager
        local r76_20 = {
            id = events.EID_LEVEL_COMPLETED,
            isBonusLevel = r76_13,
            levelCompleted = true,
            levelName = levelName,
            stars = r76_17,
            eagleUsed = r76_15,
            score = score
        }
        r76_19:notify(r76_20)
        if not r76_15 then
            local r76_21 = SettingsWrapper
            r76_21:addCollectedStars(_G.tostring(currentFolder), _G.math.max(0, r76_17 - r76_16))
        end
        if r76_17 == 3 and r76_16 < 3 and not r76_15 then
            local r76_22, r76_23, r76_24 = calculateEpisodeScoreAndStars(SettingsWrapper:getLastOpenedEpisodeType(), SettingsWrapper:getLastOpenedEpisodeIndex())
            local r76_25 = 0
            local r76_26 = r76_23 - r76_16 + r76_17
            if r76_24 <= r76_26 then
                if not r76_13 then
                    local r76_27 = r76_25 + 1
                    for r76_28, r76_29 in _G.ipairs(actions.myLevelFolders.normalLevelFolders) do
                        local r76_30 = currentFolder
                        if r76_29 ~= r76_30 then
                            local r76_31, r76_32, r76_33 = calculateEpisodeScoreAndStars(1, r76_28)
                            if r76_33 <= r76_32 then
                                r76_27 = r76_27 + 1
                            end
                        end
                    end
                    if r76_27 == #actions.myLevelFolders.normalLevelFolders and isDagobahAvailableForDevice() and not isDagobahUnlocked() then
                        unlockDagobah()
                        dagobahUnlockedWithStars = true
                    end
                end
                if getEpisodeMetadata(currentFolder).threeStarsReward ~= nil then
                    local r76_34 = getLevelMetadata(levelName)
                    local r76_35 = getEpisodeMetadata(currentFolder)
                    local r76_36 = actions.myLevels[currentFolder]
                    local r76_37 = getLevelUnlockedWithStars(r76_36[currentLevel])
                    local r76_38 = EpisodeThreeStars
                    local r76_39 = {
                        content = _G.res.getString("TEXTS_BASIC", "TEXT_EPISODE_PERFECT_TITLE") .. [[
]] .. _G.res.getString("TEXTS_BASIC", "TEXT_EPISODE_PERFECT"),
                        meta = {},
                        inMenuSpace = inMenuSpace,
                        contentImage = r76_35.threeStarsReward,
                        episode = currentFolder,
                        lastLevelOfEpisode = r76_34.lastLevelOfEpisode,
                        starLevelReached = r76_37 ~= nil
                    }
                    local r76_40
                    r76_18 = r76_40(r76_38, r76_39)
                end
            end
        end
        if r76_15 then
            local r76_41 = getLevelEagleScoreLimit(levelName)
            local r76_42 = getEagleScoreFromHighscores(levelName)
            local r76_43 = _G.math.floor
            local r76_44 = _G.math.min(score, r76_41)
            local r76_45 = r76_43(r76_44 / r76_41 * 100)
            if g_threeStarsCheat then
                r76_45 = 100
            end
            loginfo("Level Finished with eagle: score = " .. r76_45 .. " old score = " .. r76_42)
            assert(r76_42 ~= nil)
            assert(r76_45 ~= nil)
            if r76_45 >= 100 then
                registerAchievement("Falcon Escape")
                SettingsWrapper:falconTotalDestruction()
                local r76_46 = SettingsWrapper:getFalconTotalDestructionCount()
                if getAchievementLimit("Hyper Space") <= r76_46 then
                    registerAchievement("Hyper Space")
                end
            end
            local r76_47 = r76_18
            if r76_42 < r76_45 then
                local r76_48, r76_49, r76_50, r76_51, r76_52 = calculateEpisodeScoreAndStars(SettingsWrapper:getLastOpenedEpisodeType(), SettingsWrapper:getLastOpenedEpisodeIndex())
                highscores[levelName] = highscores[levelName] or {}
                local r76_53 = highscores[levelName]
                r76_53.eagleScore = r76_45
                if getEpisodeMetadata(currentFolder).allFeathersGainedReward == nil then
                    r76_47 = r76_18
                elseif r76_45 >= 100 then
                    if r76_42 < 100 then
                        local r76_54 = r76_52 - 1
                        if r76_51 == r76_54 then
                            local r76_55 = getEpisodeMetadata(currentFolder)
                            local r76_56 = r76_55.allFeathersGainedReward
                            local r76_57 = EpisodeAllFeathers
                            local r76_58 = {
                                content = _G.res.getString("TEXTS_BASIC", "TEXT_EPISODE_FEATHERED_TITLE") .. [[
]] .. _G.res.getString("TEXTS_BASIC", "TEXT_EPISODE_FEATHERED"),
                                meta = {},
                                inMenuSpace = inMenuSpace,
                                contentImage = r76_56,
                                episode = currentFolder,
                                lastLevelOfEpisode = lastLevelOfEpisode
                            }
                            r76_47 = r76_57:new(r76_58)
                        else
                            r76_47 = r76_18
                        end
                    else
                        r76_47 = r76_18
                    end
                else
                    r76_47 = r76_18
                end
                if r76_45 >= 100 then
                    local r76_59 = eventManager
                    local r76_60 = {
                        id = events.EID_FALCON_FEATHER_GAINED,
                        levelName = levelName,
                        eaglesUsed = numMightyEaglesShot
                    }
                    r76_59:notify(r76_60)
                end
            end
            local r76_61 = getLevelMetadata(levelName)
            r76_62 = r76_63(EagleScore, nil, levelName, r76_2 ~= 0, r76_45, r76_42, r76_61.lastLevelOfEpisode, r76_13, r76_47, isNextLevelComic())
        else
            local r76_64 = getLevelMetadata(levelName)
            local r76_65 = r76_64.nextButtonURL
            local r76_66 = getLevelMetadata(levelName)
            local r76_67 = r76_66.lastLevelOfEpisode
            local r76_68 = r76_67 and r76_2 == 0
            if r76_2 == 0 then
                checkRewardMightyEagles(levelName)
            end
            if r76_67 == true then
                if SettingsWrapper:getPlayerUsedEaglesCount() == 0 and r76_2 == 0 then
                    local r76_69 = eventManager
                    local r76_70 = {
                        id = events.EID_EPISODE_COMPLETED_WITHOUT_FALCONS,
                        episode = currentFolder
                    }
                    r76_69:notify(r76_70)
                end
                if SettingsWrapper:isZoomingMarkedUsed() ~= true and r76_2 == 0 then
                    local r76_71 = eventManager
                    local r76_72 = {
                        id = events.EID_EPISODE_COMPLETED_WITHOUT_ZOOMING_OUT,
                        episode = currentFolder
                    }
                    r76_71:notify(r76_72)
                end
                local r76_73 = eventManager
                local r76_74 = { id = events.EID_EPISODE_COMPLETED, episode = currentFolder }
                r76_73:notify(r76_74)
            end
            local r76_75 = _G.math.floor(score * 0.10000000149011612)
            r76_62 = r76_76(LevelComplete, nil, levelName, r76_2 ~= 0, r76_17, r76_75 * 10, r76_2, r76_16, r76_18, r76_65, r76_13, r76_68, r76_67, isNextLevelComic())
        end
        g_disableGameupdate = true
        g_gameCompletedState = true
        local r76_77 = eventManager
        local r76_62, r76_63, r76_76
        local r76_78 = { id = events.EID_PUSH_FRAME, target = r76_62 }
        r76_77:notify(r76_78)
    else
        local r76_79 = getLevelMetadata(levelName)
        local r76_80 = r76_79.lastLevelOfEpisode
        local r76_81 = getLevelMetadata(levelName)
        local r76_82
        local r76_83 = r76_82(LevelFailed, levelName, false, r76_2 ~= 0, score, r76_80, r76_81.levelFailedImage, r76_13, isNextLevelComic())
        g_disableGameupdate = true
        g_gameFailedState = true
        local r76_84 = eventManager
        local r76_85 = {
            id = events.EID_LEVEL_FAILED,
            levelName = levelName,
            isBonusLevel = r76_13
        }
        r76_84:notify(r76_85)
        local r76_86 = eventManager
        local r76_87 = { id = events.EID_PUSH_FRAME, target = r76_83 }
        r76_86:notify(r76_87)
        checkOnePigLeftAchievement()
    end
    if levelCompleted then
        if highscores[levelName] == nil then
            highscores[levelName] = {}
        end
        local r76_88 = highscores[levelName]
        local r76_89 = highscores[levelName]
        local r76_90 = r76_89.score
        r76_88.score = r76_90 or 0
        local r76_91 = highscores[levelName]
        local r76_92 = highscores[levelName]
        local r76_93 = r76_92.powerUpScore
        r76_91.powerUpScore = r76_93 or 0
        if isEagleUsedInLevel() ~= true then
            local r76_94 = _G.math.floor(score * 0.10000000149011612) * 10
            local r76_95 = PowerupManager
            if r76_95 then
                r76_95 = PowerupManager:werePowerupsUsed()
            end
            if r76_95 and highscores[levelName].powerUpScore < score then
                local r76_96 = highscores[levelName]
                r76_96.powerUpScore = r76_94
            end
            if not r76_95 and highscores[levelName].score < score then
                local r76_97 = highscores[levelName]
                r76_97.score = r76_94
            end
        end
        if r76_2 ~= nil then
            local r76_98 = score
            if r76_2 < r76_98 then
                local r76_99 = eventManager
                local r76_100 = {
                    id = events.EID_NEW_HIGHSCORE,
                    oldHighScore = r76_2,
                    score = score,
                    levelName = levelName,
                    isBonusLevel = r76_13,
                    eagleUsed = isEagleUsedInLevel()
                }
                r76_99:notify(r76_100)
                if gameCenterSupported then
                    setPostedStatus(getCurrentFolderIndex(currentFolder))
                    postTotalHighScores()
                elseif steam or gamerService then
                    postTotalHighScores()
                end
            end
        end
    end
    savePersistentLuaFileWrapper("settings.lua", "settings")
    savePersistentLuaFileWrapper("highscores.lua", "highscores")
    storePersistentData()
    if not startedFromEditor and editor == nil then
        checkForLevelCompleteAchievements()
    end
end

-- line 4441-4725
-- proto#77 params=4 locals=83 upvalues=0 vararg=false
function birdCollision(p77_0, p77_1, p77_2, p77_3)
    local r77_0, r77_1 = objects.world[p77_0], objects.world[p77_1]
    local r77_2 = blockTable.blocks[r77_0.definition]
    local r77_3 = blockTable.blocks[r77_1.definition]
    local r77_4 = r77_0.hasCollided
    if r77_0.controllable and r77_1.onCollisionEnter and actions[r77_1.onCollisionEnter].params.continueExec == false then
        return
    end
    if r77_1.controllable and r77_0.onCollisionEnter and actions[r77_0.onCollisionEnter].params.continueExec == false then
        return
    end
    if r77_2.stopAnimationsAfterCollision then
        objects.animatedObjects[p77_0] = nil
    end
    if r77_3.stopAnimationsAfterCollision then
        objects.animatedObjects[p77_1] = nil
    end
    if r77_0.onCollisionEnter ~= nil then
        fireAction(r77_0.onCollisionEnter, {
            name = p77_0,
            other = p77_1,
            force = p77_2,
            wasDamageDone = wasDamageDone,
            dot = dot,
            damage = p77_3
        })
        local r77_5 = actions[r77_0.onCollisionEnter]
        if r77_5.params.continueExec == false then
            return
        end
    end
    if r77_1.onCollisionEnter ~= nil then
        fireAction(r77_1.onCollisionEnter, {
            name = p77_1,
            other = p77_0,
            force = p77_2,
            wasDamageDone = wasDamageDone,
            dot = dot,
            damage = p77_3
        })
        local r77_6 = actions[r77_1.onCollisionEnter]
        if r77_6.params.continueExec == false then
            return
        end
    end
    if r77_2.collisionSpawn ~= nil then
        local r77_7 = {
            definition = r77_2,
            x = r77_0.x,
            y = r77_0.y,
            angle = r77_0.angle + (r77_2.angleOffset or 0)
        }
        spawnList[#spawnList + 1] = {
            spawnedObjects = r77_7.definition.collisionSpawn,
            info = r77_7
        }
    end
    if r77_3.collisionSpawn ~= nil then
        local r77_8 = {
            definition = r77_3,
            x = r77_1.x,
            y = r77_1.y,
            angle = r77_1.angle + (r77_3.angleOffset or 0)
        }
        spawnList[#spawnList + 1] = {
            spawnedObjects = r77_8.definition.collisionSpawn,
            info = r77_8
        }
    end
    if p77_3 > 0 then
        cameraResetTimer = g_defaultCameraResetTime
        if p77_3 > 25 then
            local r77_9 = 10000000
            local r77_10 = _G.math.min(p77_3 * p77_3 * p77_3, r77_9)
            addCameraShake(cameraShakeModeSine, 150, r77_10 / r77_9 * 4, r77_10 / r77_9 * 0.5)
        end
    end
    if p77_0 ~= nil then
        local r77_11, r77_12 = birds[p77_0], 0
        if p77_1 ~= nil and r77_3.material == "immovable" and r77_11 ~= nil and r77_11.xVel ~= nil and r77_11.yVel ~= nil then
            local r77_13 = vLength(r77_11.xVel, r77_11.yVel)
            local r77_14 = r77_11.mass
            r77_12 = r77_13 * r77_14 / 10
        end
        if collisionParticleForceThreshold < p77_2 or collisionParticleForceThreshold < r77_12 then
            local r77_15 = blockTable.materials[r77_3.material]
            if r77_15 ~= nil then
                local r77_16 = r77_3.collisionSound or r77_15.collisionSound
                if p77_3 > 10 then
                    local r77_17 = r77_3.damageSound
                    if r77_17 then
                        r77_16 = r77_17
                    else
                        local r77_18 = r77_15.damageSound
                        if r77_18 then
                            r77_16 = r77_18
                        end
                    end
                end
                if r77_16 ~= nil then
                    res.playAudio(r77_16)
                end
            end
            local r77_19 = r77_2.particlesCollision
            if r77_19 ~= nil then
                local r77_20 = particleTable.particles[r77_19]
                local r77_21 = r77_20.amount
                if r77_21 == nil then
                    r77_21 = _G.math.random(12, 20)
                end
                putParticles({ objectName = p77_0, particles = r77_19, amount = r77_21 })
            end
            local r77_22 = r77_3.damageParticles
            if p77_1 == "ground" then
                putParticles({
                    objectName = p77_0,
                    particles = r77_2.groundCollisionParticles,
                    amount = 1
                })
            elseif r77_22 ~= nil then
                putParticles({
                    objectName = p77_1,
                    particles = r77_22,
                    amount = _G.math.ceil(p77_2 / 10)
                })
            end
            if r77_11 ~= nil then
                local r77_23 = r77_11.mass
                local r77_24 = 60 * r77_23 / 10
                local r77_25 = blockTable.damageFactors[r77_11.damageFactors]
                local r77_26 = r77_25.damageMultiplier[r77_3.material]
                local r77_27
                if r77_26 == nil then
                    r77_27 = r77_24
                elseif r77_26 > 1 then
                    r77_27 = r77_24 * r77_26
                else
                    r77_27 = r77_24
                end
                local r77_28 = _G.math.max
                local r77_29 = _G.math.max(p77_2, r77_12)
                local r77_30 = r77_28(r77_29 / r77_27, 0.20000000298023224)
            end
            if r77_3 and not r77_3.preventBirdCollision and r77_2.sounds ~= nil and r77_2.sounds.collision ~= nil then
                res.playAudio(r77_2.sounds.collision)
            end
        end
    end
    if not (not r77_0.controllable or not r77_3.preventBirdCollision) or r77_1.controllable and r77_2.preventBirdCollision then
        return
    end
    if r77_0.controllable and p77_3 > 0 then
        local r77_31 = r77_0
        local r77_32 = worldAttributes.scoreDamageMultiplier
        local r77_33 = p77_3 * r77_32
        if r77_31.hasCollided then
            _G.table.insert(floatingScores, {
                x = r77_31.x,
                y = r77_31.y,
                text = "" .. r77_33,
                score = r77_33,
                time = 0,
                lifetime = 0.6000000238418579,
                maxScale = 0.25 + r77_33 / 3000,
                xs = 0
            })
        end
        if scoreTable[p77_0] == nil then
            scoreTable[p77_0] = {}
            scoreTable[p77_0].score = 0
        end
        scoreTable[p77_0].score = scoreTable[p77_0].score + r77_33
        r77_0.didDamage = true
    end
    if r77_0.shot and r77_0.controllable and not r77_0.hasCollided then
        local r77_34 = r77_0.damageDone
        r77_0.damageDone = r77_34 + p77_3
    end
    if r77_1.shot and r77_1.controllable and not r77_1.hasCollided then
        local r77_35 = r77_1.damageDone
        r77_1.damageDone = r77_35 + p77_3
    end
    local r77_36 = false
    if not (r77_0.shot and r77_1.shot) then
        if r77_0.shot and not r77_0.hasCollided then
            r77_36 = true
            r77_0.hasCollided = true
            setLinearDamping(r77_0.name, defaultBirdsDrag)
        elseif r77_1.shot and not r77_0.hasCollided then
            r77_36 = true
            r77_1.hasCollided = true
            setLinearDamping(r77_1.name, defaultBirdsDrag)
        end
    end
    if (r77_0.controllable ~= true or r77_1.controllable ~= true) and cameraTargetObject ~= nil and (cameraTargetObject.name == r77_0.name or cameraTargetObject.name == r77_1.name) then
        if g_delayedBirdFocusLost then
            if cameraTargetObject.delayedRemovalTimer == nil then
                cameraTargetObject.delayedRemovalTimer = g_delayedBirdFocusLostTimeLimit
            end
        else
            setCameraTargetObject(nil)
        end
    end
    if not r77_36 then
        if r77_0.controllable then
            if r77_0.timeSinceCollision ~= nil then
                setObjectParameter(r77_0.name, 31, r77_0.timeSinceCollision * 2)
            end
        elseif r77_1.controllable and r77_1.timeSinceCollision ~= nil then
            setObjectParameter(r77_1.name, 31, r77_1.timeSinceCollision * 2)
        end
    end
    local r77_37 = r77_0
    for r77_38 = 1, 2 do
        local r77_39 = getObjectDefinition(r77_37.name)
        if r77_37.controllable and r77_39.sprites ~= nil and r77_37.shot == true then
            local r77_40 = r77_39.specialty
            if r77_39.sprites.collision ~= nil and (r77_0.notCollided ~= true or r77_1.notCollided ~= true) then
                local r77_41 = objects.world[r77_37.name]
                if r77_41.shot == true then
                    local r77_42 = objects.world[r77_37.name]
                    r77_42.sprite = r77_39.sprites.collision
                    local r77_43 = objects.world[r77_37.name]
                    setSprite(r77_37.name, r77_43.sprite)
                end
                r77_0.notCollided = nil
                r77_1.notCollided = nil
                setObjectParameter(p77_0, 11, 0)
                setObjectParameter(p77_1, 11, 0)
            end
            if flyingBird ~= nil then
                local r77_44 = r77_37.name
                local r77_45 = flyingBird.name
                if r77_44 == r77_45 and r77_40 ~= "Mighty_Falcon" then
                    if r77_39.specialtyActivationDelay == nil then
                        birdSpecialtyAvailable = false
                    else
                        local r77_46 = objects.world[flyingBird.name]
                        if r77_46.specialtyTimer == nil then
                            local r77_47 = objects.world[flyingBird.name]
                            r77_47.specialtyTimer = r77_39.specialtyActivationDelay
                        end
                    end
                end
            end
            if r77_40 == "THREE_SPLIT_EXPLOSION" and r77_37.hasExploded ~= true and r77_1.controllable ~= true then
                local r77_48 = nil
                if r77_39.sounds ~= nil then
                    r77_48 = r77_39.sounds.explosion
                end
                makeExplosion(r77_37, r77_39, r77_48)
                r77_37.hasExploded = true
            end
            if r77_37.collision ~= true then
                setLinearDamping(r77_37.name, defaultPhysicsDrag)
                for r77_49, r77_50 in _G.pairs(otherBirds) do
                    setLinearDamping(r77_50, defaultPhysicsDrag)
                end
            end
            r77_37.collision = true
        end
        r77_37 = r77_1
    end
    if r77_0.shot and r77_0.controllable then
        r77_0.collision = true
        if r77_1.controllable ~= true then
            r77_0.recordTrajectory = false
        end
    end
    if r77_1.shot and r77_1.controllable then
        r77_1.collision = true
        if r77_0.controllable ~= true then
            r77_1.recordTrajectory = false
        end
    end
    local r77_51 = _G.math.random(12, 20)
    if r77_1.controllable ~= true then
        local r77_52 = getDamageSprite(r77_1, blockTable.blocks)
        r77_1.damageSprite = r77_52.sprite
        r77_1.blinkSprite = r77_52.blink
        r77_1.smileSprite = r77_52.smile
        createDamageParticles(r77_1, blockTable.blocks, r77_1.strength + p77_3)
    end
end

-- line 4727-4737
-- proto#78 params=1 locals=11 upvalues=0 vararg=false
function getEpisodeForLevel(p78_0)
    for r78_0, r78_1 in _G.ipairs(actions.episodeTypeTable) do
        for r78_2, r78_3 in _G.ipairs(actions.myLevelFolders[r78_1]) do
            for r78_4, r78_5 in _G.ipairs(actions.myLevels[r78_3]) do
                if r78_5 == p78_0 then
                    return r78_3
                end
            end
        end
    end
end

-- line 4739-4750
-- proto#79 params=1 locals=11 upvalues=0 vararg=false
function getLevelNumberForLevelName(p79_0)
    for r79_0, r79_1 in _G.ipairs(actions.episodeTypeTable) do
        for r79_2, r79_3 in _G.ipairs(actions.myLevelFolders[r79_1]) do
            for r79_4, r79_5 in _G.ipairs(actions.myLevels[r79_3]) do
                if r79_5 == p79_0 then
                    return r79_4
                end
            end
        end
    end
end

-- line 4752-4765
-- proto#80 params=2 locals=1 upvalues=0 vararg=false
function setupEpisodeCompletedActions(p80_0, p80_1)
    if p80_1 ~= true then
        sweepCameraRight()
        SettingsWrapper:setLevelTrophyAvailabilityStatus(true)
    end
    if p80_0 == true and not isBuildUnlocked() then
        local r80_0 = {
            from = "After episode complete",
            episodeIdx = actions.myLevelFolders[getCurrentCameraIdx() + 2]
        }
        addEventCall("checkForIApPurchaseEpisode", r80_0, 1.75)
    end
end

-- line 4767-4780
-- proto#81 params=2 locals=10 upvalues=0 vararg=false
function getWorldNumber(p81_0, p81_1)
    _G.assert(p81_0 ~= nil)
    _G.assert(p81_1 ~= nil)
    for r81_0, r81_1 in _G.ipairs(actions.episodeTypeTable) do
        for r81_2, r81_3 in _G.ipairs(actions.myLevelFolders[r81_1]) do
            if r81_3 == p81_0 then
                return r81_2
            end
        end
    end
    local r81_4 = "could not get world number for theme " .. p81_0 .. ", level #" .. p81_1
    assert(false, r81_4)
end

-- line 4782-4790
-- proto#82 params=1 locals=7 upvalues=0 vararg=false
function isEpisodeFolder(p82_0)
    for r82_0, r82_1 in _G.ipairs(actions.episodeTypeTable) do
        for r82_2, r82_3 in _G.ipairs(actions.myLevelFolders[r82_1]) do
            if r82_3 == p82_0 then
                return true
            end
        end
    end
    return false
end

-- line 4792-4811
-- proto#83 params=0 locals=8 upvalues=0 vararg=false
function calculateStarsForAllEpisodes()
    local r83_0, r83_1 = 0, 0
    local r83_2 = 1
    local r83_3 = actions.episodeTypeTable
    for r83_4 = r83_2, #r83_3 do
        local r83_5 = 1
        local r83_6 = actions.myLevelFolders[actions.episodeTypeTable[r83_4]]
        for r83_7 = r83_5, #r83_6 do
            local r83_8, r83_9, r83_10, r83_11, r83_12 = calculateEpisodeScoreAndStars(r83_4, r83_7)
            r83_0 = r83_0 + r83_9
            r83_1 = r83_1 + r83_11
        end
    end
    if steam then
        setStat("totalStars", r83_0)
        setStat("totalFeathers", r83_1)
    end
    return r83_0, r83_1
end

-- line 4813-4825
-- proto#84 params=1 locals=8 upvalues=0 vararg=false
function getCurrentFolderIndex(p84_0)
    local r84_0 = 0
    for r84_1, r84_2 in _G.ipairs(actions.episodeTypeTable) do
        for r84_3, r84_4 in _G.ipairs(actions.myLevelFolders[r84_2]) do
            if r84_4 == p84_0 then
                return r84_3 + r84_0
            end
        end
        r84_0 = r84_0 + episodeTypeIndexIncrement
    end
    assert(false, "could not resolve current folder index from current folder")
end

-- line 4827-4837
-- proto#85 params=1 locals=3 upvalues=0 vararg=false
function getEpisodeName(p85_0)
    local r85_0, r85_1 = p85_0, 1
    while episodeTypeIndexIncrement < r85_0 do
        r85_1 = r85_1 + 1
        r85_0 = r85_0 - episodeTypeIndexIncrement
    end
    local r85_2 = actions.myLevelFolders[r85_1]
    return r85_2[r85_0]
end

-- line 4839-4867
-- proto#86 params=1 locals=15 upvalues=0 vararg=false
function gotoLevelSelectionMenu(p86_0)
    local r86_0 = actions.myLevelFolders
    local r86_1 = actions.episodeTypeTable
    local r86_2 = r86_0[r86_1[p86_0.episodeType]]
    local r86_3 = r86_2[p86_0.startNumber]
    local r86_4 = getEpisodeMetadata(r86_3).levelsAvailableInFree ~= nil
    local r86_5 = getEpisodeMetadata(r86_3)
    local r86_6 = r86_5.iapPurchase
    local r86_7
    if deviceModel == "windows" or gamerService then
        local r86_8 = g_isRegistered
        if r86_8 then
            r86_7 = r86_8
        else
            r86_7 = r86_4
        end
    elseif isIOSFree() then
        local r86_9 = getEpisodeMetadata(r86_3)
        r86_7 = r86_9.availableInIOSFree
    end
    if r86_7 then
        fireAction("loadLevelSelectionMenu", p86_0)
    elseif deviceModel == "windows" or gamerService then
        local r86_10 = eventManager
        local r86_11 = {
            id = events.EID_SHOW_REGISTRATION_DIALOG,
            success_call = function()
                fireAction("loadLevelSelectionMenu", p86_0)
            end
        }
        r86_10:notify(r86_11)
    elseif isIOSFree() then
        local r86_12 = eventManager
        local r86_13 = { id = events.EID_OPEN_BUY_FREE_IOS_VERSION_POPUP, openedFrom = r86_3 }
        r86_12:notify(r86_13)
    end
end

-- line 4869-4877
-- proto#88 params=0 locals=0 upvalues=0 vararg=false
function calculateRewardState()
    local r88_0, r88_1, r88_2, r88_3, r88_4 = calculateEpisodeScoreAndStars(SettingsWrapper:getLastOpenedEpisodeType(), SettingsWrapper:getLastOpenedEpisodeIndex())
    maxStarsObtained = r88_1 == r88_2
end

-- line 4879-4897
-- proto#89 params=0 locals=6 upvalues=0 vararg=false
function checkForEpisodeStarAchievements()
    local r89_0, r89_1, r89_2, r89_3, r89_4 = calculateEpisodeScoreAndStars(SettingsWrapper:getLastOpenedEpisodeType(), SettingsWrapper:getLastOpenedEpisodeIndex())
    print("checkForEpisodeStarAchievements totalStars " .. r89_1 .. ", maxStars " .. r89_2)
    local r89_5 = getEpisodeMetadata(currentTheme)
    local r89_6 = r89_5.starAchievement
    if r89_6 == nil then
        print("No episodeStarAchievement available")
    else
        print("episodeStarAchievement " .. r89_6)
    end
    if r89_1 == r89_2 and r89_6 ~= nil then
        local r89_7 = registerAchievement
        local r89_8 = getEpisodeMetadata(currentTheme)
        r89_7(r89_8.starAchievement)
    end
end

-- line 4900-4909
-- proto#90 params=1 locals=3 upvalues=0 vararg=false
function getEpisodeNumber(p90_0)
    local r90_0 = actions.episodeTypeTable[SettingsWrapper:getLastOpenedEpisodeType()]
    local r90_1 = 1
    local r90_2 = actions.myLevelFolders[r90_0]
    for r90_3 = r90_1, #r90_2 do
        local r90_4 = actions.myLevelFolders[r90_0]
        if r90_4[r90_3] == p90_0 then
            return r90_3
        end
    end
end

-- line 4911-4915
-- proto#91 params=0 locals=0 upvalues=0 vararg=false
function disableGameUpdate()
    initializeBulletTime()
    setGameOn(false)
    setPhysicsEnabled(false)
end

-- line 4917-4919
-- proto#92 params=0 locals=0 upvalues=0 vararg=false
function getEmptyButtonSpriteName()
    return "BTN_BG_SW"
end

-- line 4921-4952
-- proto#93 params=3 locals=5 upvalues=0 vararg=false
function setupTutorial(p93_0, p93_1, p93_2)
    if g_showTutorials and not getLevelMetadata(levelName).ignoreTutorial and (not SettingsWrapper:isTutorialShown(p93_0) or SettingsWrapper:getTimesBirdPowerNotUsed(p93_0) >= 5 or p93_1) then
        local r93_0 = p93_0
        if not p93_2 then
            local r93_1
            r93_0 = r93_1.definition
        end
        local r93_2 = SettingsWrapper:isTutorialShown(r93_0)
        if not (r93_2 or r93_0 == "ME_BAIT") then
            SettingsWrapper:setLevelTrophyAvailabilityStatus(true)
        end
        local r93_3 = r93_0 == "RedBird_1" or r93_0 == "SmallBlueBird_1" or r93_0 == "RedBigBird_1" or r93_0 == "LaserBird_1" or r93_0 == "BlackBird_1" or r93_0 == "Bird3CPO_1" or r93_0 == "BirdR2D2_1" or r93_0 == "ME_BAIT" or r93_0 == "PinkBird_1" or r93_0 == "cloneBird" or r93_0 == "detonator" or r93_0 == "blasterDroid" or r93_0 == "lightsaberSling" or r93_0 == "Lando_1" or r93_2
        loadImages({ "TUTORIALS" })
        local r93_4 = ui.AnimatedTutorial:new(r93_0, not r93_3)
        queuedTutorials = queuedTutorials or {}
        _G.table.insert(queuedTutorials, r93_4)
        SettingsWrapper:markTutorialShown(r93_0)
        SettingsWrapper:resetBirdPowerNotUsed(r93_0)
        return true
    end
    return false
end

-- line 4956-4960
-- proto#94 params=2 locals=0 upvalues=0 vararg=false
function nativecallback_urlResponse(p94_0, p94_1)
    loginfo("<native_urlCallback> URL = " .. p94_0)
    loginfo("<native_urlCallback> STATUS = " .. p94_1)
    checkToyCodeLevelUnlock(p94_0, p94_1)
end

-- line 4962-5033
-- proto#95 params=2 locals=12 upvalues=0 vararg=false
function checkToyCodeLevelUnlock(p95_0, p95_1)
    if g_toyCodeURLs[p95_0] ~= nil then
        local r95_0, r95_1 = parseToyResponseParameters(p95_1)
        local r95_2 = _G.tostring(r95_0)
        local r95_3 = _G.tostring(r95_1)
        loginfo("<native_urlCallback> status = " .. r95_2 .. " message = " .. r95_3)
        local r95_4 = isDagobahAvailableForDevice() or deviceModel ~= "windows"
        local r95_5
        local r95_6
        local r95_7
        if r95_0 and (r95_0 == "1" or not r95_4 and r95_0 == "2") then
            r95_5 = "1"
            if SettingsWrapper:isToyKeyUsed(g_toyCodeURLs[p95_0]) then
                print("<checkToyCodeLevelUnlock> toy code already entered")
                r95_5 = "0"
                r95_6 = getText("TEXT_TOYCODE_ALREADY_ENTERED")
            else
                SettingsWrapper:storeToyUnlock(g_toyCodeURLs[p95_0])
                if noDagobahAvailable then
                    SettingsWrapper:addMightyEagles(30)
                    r95_6 = "Gave 30 falcons from toycode"
                    r95_7 = getText("TEXT_TOYCODE_FALCON_LARGE_UNLOCKED")
                else
                    SettingsWrapper:addMightyEagles(10)
                    r95_6 = "Gave 10 falcons from toycode"
                    r95_7 = getText("TEXT_TOYCODE_FALCON_SMALL_UNLOCKED")
                end
            end
        elseif r95_5 and r95_5 == "2" then
            if isDagobahUnlocked() then
                SettingsWrapper:addMightyEagles(30)
                SettingsWrapper:storeToyUnlock(g_toyCodeURLs[p95_0])
                r95_5 = "DAGOBAH_ALREADY_UNLOCKED"
                r95_7 = getText("TEXT_TOYCODE_FALCON_LARGE_UNLOCKED")
                r95_6 = "Dagobah already unlocked, gave 30 falcons instead"
            else
                print("<checkToyCodeLevelUnlock> dagobah not yet unlocked, unlocking")
                unlockDagobah()
                SettingsWrapper:storeToyUnlock(g_toyCodeURLs[p95_0])
                r95_6 = "Dagobah Unlocked"
            end
        elseif r95_5 and r95_5 == "3" then
            SettingsWrapper:storeToyUnlock(g_toyCodeURLs[p95_0])
            SettingsWrapper:addMightyEagles(1)
            r95_6 = "Gave 1 falcon from toycode"
            r95_7 = getText("TEXT_TOYCODE_FALCON_SINGLE_UNLOCKED")
        elseif r95_5 and r95_5 == "4" then
            if isBobaFettEpisodeUnlocked() then
                SettingsWrapper:addMightyEagles(30)
                SettingsWrapper:storeToyUnlock(g_toyCodeURLs[p95_0])
                r95_5 = "BOBA_EPISODE_ALREADY_UNLOCKED"
                r95_7 = getText("TEXT_TOYCODE_FALCON_LARGE_UNLOCKED")
                r95_6 = "Boba Fett episode already unlocked, gave 30 falcons instead"
            else
                unlockBobaFettEpisode()
                SettingsWrapper:storeToyUnlock(g_toyCodeURLs[p95_0])
                print("<checkToyCodeLevelUnlock> boba fett Episode not yet unlocked, unlocking")
                r95_6 = "Boba Fett Episode unlocked"
            end
        end
        if r95_5 then
            local r95_8 = eventManager
            local r95_9 = {
                id = events.EID_TOY_URL_CALLBACK_RECEIVED,
                status = r95_5,
                message = r95_7,
                flurryMessage = r95_6
            }
            r95_8:notify(r95_9)
        end
        g_toyCodeURLs[p95_0] = nil
    end
end

-- line 5036-5044
-- proto#96 params=0 locals=5 upvalues=0 vararg=false
function isBobaFettEpisodeUnlocked()
    if isEpisodeUnlockedByPlatform() then
        return true
    end
    local r96_0 = getEpisodeMetadataWithParam("bobaFett_1", "iapPurchaseId")
    local r96_1 = _G.tostring(r96_0)
    print("<isBobaFettUnlocked> id = " .. r96_1 .. [[
]])
    return SettingsWrapper:isEpisodePurchased(r96_0)
end

-- line 5047-5052
-- proto#97 params=0 locals=0 upvalues=0 vararg=false
function isEpisodeUnlockedByPlatform()
    if deviceModel == "android" and isIapEnabled() == false then
        return true
    end
    return false
end

-- line 5054-5066
-- proto#98 params=0 locals=5 upvalues=0 vararg=false
function isDagobahUnlocked()
    if deviceModel == "blackberry" then
        return false
    end
    if isEpisodeUnlockedByPlatform() or deviceModel == "metro" or deviceModel == "windows" then
        return true
    end
    local r98_0 = getEpisodeMetadataWithParam("dagobah_1", "iapPurchaseId")
    local r98_1 = _G.tostring(r98_0)
    print("<isDagobahUnlocked> dagobahIapId = " .. r98_1 .. [[
]])
    return SettingsWrapper:isEpisodePurchased(r98_0)
end

-- line 5068-5082
-- proto#99 params=0 locals=9 upvalues=0 vararg=false
function isRandomDroidLevelAvailable()
    for r99_0, r99_1 in _G.ipairs(actions.myLevelFolders.droidLevelFolders) do
        for r99_2, r99_3 in _G.ipairs(actions.myLevels[r99_1]) do
            local r99_4 = getEpisodeMetadata("bonus")
            if not (r99_4.ignoreToyUnlockLevels[r99_3] or SettingsWrapper:isDroidLevelUnlocked(r99_3)) then
                return true
            end
        end
    end
    return false
end

-- line 5084-5117
-- proto#100 params=0 locals=23 upvalues=0 vararg=false
function getRandomDroidLevel()
    local r100_0 = {}
    local r100_1 = {}
    for r100_2, r100_3 in _G.ipairs(actions.myLevelFolders.droidLevelFolders) do
        r100_0[r100_3] = {}
        for r100_4, r100_5 in _G.ipairs(actions.myLevels[r100_3]) do
            local r100_6 = getEpisodeMetadata("bonus")
            if not (r100_6.ignoreToyUnlockLevels[r100_5] or SettingsWrapper:isDroidLevelUnlocked(r100_5)) then
                _G.table.insert(r100_0[r100_3], r100_5)
                _G.table.insert(r100_1, r100_3)
            end
        end
    end
    local r100_7 = nil
    local r100_8 = #r100_1
    if r100_8 > 0 then
        local r100_9 = _G.math.random
        randomFolder = r100_1[r100_9(1, #r100_1)]
        local r100_10 = r100_0[randomFolder]
        r100_7 = r100_10[_G.math.random(1, #r100_0[randomFolder])]
        local r100_11 = _G.tostring(r100_7)
        loginfo("<unlockRandomDroidLevel> unlocking random level " .. r100_11)
    else
        loginfo("<unlockRandomDroidLevel> No available random levels to be unlocked")
    end
    return r100_7
end

-- line 5119-5169
-- proto#101 params=1 locals=3 upvalues=0 vararg=false
function parseToyResponseParameters(p101_0)
    print("<parseToyResponseParameters> return value = " .. p101_0 .. [[
]])
    local r101_0 = "-1"
    local r101_1 = getText("TEXT_TOYCODE_UKNOWN_ERROR")
    if _G.string.find(p101_0, "type=HSBR2012") == nil then
        if _G.string.find(p101_0, "status=0") ~= nil then
            r101_0 = "0"
            print([[<parseToyResponseParameters> status = 0
]])
            if _G.string.find(p101_0, "msg=invalid[-]key") == nil then
                if _G.string.find(p101_0, "msg=max[-]uses[-]exceeded") ~= nil then
                    r101_1 = getText("TEXT_TOYCODE_ALREADY_USED")
                    print([[<parseToyResponseParameters> max uses of code exceeded
]])
                end
            else
                r101_1 = getText("TEXT_TOYCODE_INVALID_KEY")
                print([[<parseToyResponseParameters> invalid key
]])
            end
        end
    elseif _G.string.find(p101_0, "status=1") ~= nil then
        print([[<parseToyResponseParameters> status = 1
]])
        if _G.string.find(p101_0, "group=bonus") == nil then
            if _G.string.find(p101_0, "group=dagobah") == nil then
                if _G.string.find(p101_0, "group=falcon") == nil then
                    if _G.string.find(p101_0, "group=bobafett") == nil then
                        print("<parseToyResponseParameters> server returned invalid group")
                    else
                        r101_0 = "4"
                        r101_1 = getText("TEXT_TOYCODE_BOUNTYMISSIONS_UNLOCKED")
                        print([[<parseToyResponseParameters> group = Boba Fett 
]])
                    end
                else
                    r101_0 = "3"
                    r101_1 = getText("TEXT_TOYCODE_FALCON_SINGLE_UNLOCKED")
                    print([[<parseToyResponseParameters> group = falcon
]])
                end
            else
                r101_0 = "2"
                r101_1 = getText("TEXT_TOYCODE_PATHOFTHEJEDI_UNLOCKED")
                print([[<parseToyResponseParameters> group = dagobah
]])
            end
        else
            r101_0 = "1"
            r101_1 = getText("TEXT_TOYCODE_LEVEL_UNLOCKED")
            print([[<parseToyResponseParameters> group = bonus
]])
        end
    end
    return r101_0, r101_1
end

g_toyCodeURLs = {}

-- line 5172-5184
-- proto#102 params=1 locals=2 upvalues=0 vararg=false
function startCheckToyCodeServerURL(p102_0)
    if releaseBuild == true then
        TOY_CODE_SERVER_URL = "http://cloud.rovio.com"
    else
        TOY_CODE_SERVER_URL = "http://smoke.rovio.com"
    end
    local r102_0 = getUnlockRequestChecksum(uniqueDeviceId, p102_0, 0)
    local r102_1 = TOY_CODE_SERVER_URL .. "/drm/checkKey/?d=" .. deviceModel .. "&key=" .. p102_0 .. "&types=HSBR2012TS&uid=" .. uniqueDeviceId .. "&p=abw&h=" .. r102_0
    g_toyCodeURLs[r102_1] = p102_0
    startURLCheck(r102_1)
end

-- line 5188-5191
-- proto#103 params=1 locals=0 upvalues=0 vararg=false
function startURLCheck(p103_0)
    g_urlCallbackTimer = 15
    native_startURLThread(p103_0, nativecallback_urlResponse)
end

-- line 5194-5206
-- proto#104 params=1 locals=4 upvalues=0 vararg=false
function getIapMetadata(p104_0)
    if deviceModel == "ipad" or deviceModel == "ipad3" then
        return getEpisodeMetadata(p104_0).iapPurchaseIdHD
    end
    if deviceModel == "iphone" or deviceModel == "iphone4" then
        return getEpisodeMetadata(p104_0).iapPurchaseId
    end
    if deviceModel ~= "android" then
        return
    end
    if isHDVersion then
        return getEpisodeMetadata(p104_0).iapPurchaseIdAndroidHD
    end
    return getEpisodeMetadata(p104_0).iapPurchaseIdAndroid
end

-- line 5214-5267
-- proto#105 params=3 locals=39 upvalues=0 vararg=false
function iosPurchaseRestoreCallback(p105_0, p105_1, p105_2)
    local r105_0 = print
    local r105_1 = _G.tostring(p105_0)
    local r105_2 = _G.tostring(p105_1)
    local r105_3 = _G.tostring(p105_2)
    local r105_4 = "<iap> restore callback; pid: " .. r105_1 .. " status: " .. r105_2 .. " error: " .. r105_3 .. [[
]]
    r105_0(r105_4)
    local r105_5 = {}
    for r105_6, r105_7 in _G.pairs(actions.myLevelFolders.iapLevelFolders) do
        local r105_8 = _G.tostring(getIapMetadata(r105_7))
        print("<iap> inserting to list " .. r105_8 .. [[
]])
        _G.table.insert(r105_5, getIapMetadata(r105_7))
    end
    local r105_9 = false
    if isEaglePurchaseSpinnerPageShowing() then
        local r105_10 = eventManager
        local r105_11 = { id = events.EID_POP_FRAME, target = "eaglePurchasePage" }
        r105_10:notify(r105_11)
    else
        r105_9 = true
    end
    local r105_12 = false
    local r105_13 = BUY_CALLBACK_STATUS_SUCCESS
    local r105_14
    if p105_1 == r105_13 or p105_1 == BUY_CALLBACK_STATUS_PENDING or p105_1 == BUY_CALLBACK_STATUS_RESTORED then
        local r105_15, r105_16, r105_17 = _G.ipairs(r105_5)
        local r105_18 = r105_12
        for r105_19, r105_20 in r105_15, r105_16, r105_17 do
            if p105_0 == r105_20 and not r105_18 then
                print("<iap> restore item.." .. r105_20 .. [[
]])
                SettingsWrapper:purchaseEpisode(r105_20)
                savePurchases()
                checkForDagobahAchievement(p105_0)
                local r105_21 = ui.Prompt
                local r105_22 = {
                    name = "purchaseRestoreSuccessfulPrompt",
                    content = _G.res.getString("TEXTS_BASIC", "TEXT_DAGOBAH_RESTORE_SUCCESS")
                }
                r105_14 = r105_21:new(r105_22)
                r105_18 = true
            end
        end
        if not r105_18 then
            local r105_23 = ui.Prompt
            local r105_24 = {
                name = "restoreNotSuccessfulPrompt",
                title = "Error 3",
                content = _G.res.getString("TEXTS_BASIC", "TEXT_DAGOBAH_RESTORE_FAILURE")
            }
            r105_14 = r105_23:new(r105_24)
        end
    else
        print([[<iap> restore failed?
]])
        local r105_25 = "Error restoring purchase"
        local r105_26 = ui.Prompt
        local r105_27 = {
            name = "purchaseRestoreFailedPrompt",
            title = r105_25,
            content = _G.res.getString("TEXTS_BASIC", "TEXT_DAGOBAH_RESTORE_FAILURE")
        }
        r105_14 = r105_26:new(r105_27)
    end
    if not (r105_9 or r105_14 == nil) then
        local r105_28 = eventManager
        local r105_29 = { id = events.EID_PUSH_FRAME, target = r105_14 }
        r105_28:queueEvent(r105_29)
    end
end

-- line 5270-5276
-- proto#106 params=0 locals=5 upvalues=0 vararg=false
function countCollectedStars()
    local r106_0 = 0
    for r106_1, r106_2 in _G.pairs(actions.myLevels) do
        local r106_3 = SettingsWrapper:getCollectedStars(r106_1)
        r106_0 = r106_0 + r106_3
    end
    return r106_0
end

-- line 5278-5306
-- proto#107 params=0 locals=12 upvalues=0 vararg=false
function calculateNextReward()
    local r107_0
    local r107_1 = countCollectedStars()
    local r107_2 = 99999
    if platformSupportsME() then
        local r107_3, r107_4, r107_5 = _G.ipairs(starTargetsForFalcons)
        r107_0 = r107_2
        for r107_6, r107_7 in r107_3, r107_4, r107_5 do
            local r107_8 = r107_7[1]
            if r107_1 < r107_8 and r107_7[1] < r107_0 then
                r107_0 = r107_7[1]
            end
        end
    end
    r107_2 = r107_0
    for r107_9, r107_10 in _G.pairs(actions.myLevels) do
        for r107_11, r107_12 in _G.ipairs(r107_10) do
            local r107_13 = getLevelMetadata(r107_12)
            if r107_13.starsUnlockLimit and getLevelMetadata(r107_12).starsUnlockLimit > r107_1 and getLevelMetadata(r107_12).starsUnlockLimit < r107_2 and (not isPlatformLimited() or not getLevelMetadata(r107_12).unavailableOnNonIaps) then
                local r107_14 = getLevelMetadata(r107_12)
                r107_2 = r107_14.starsUnlockLimit
            end
        end
    end
    if r107_2 == 99999 then
        return nil
    end
    return r107_2
end

-- line 5309-5321
-- proto#108 params=0 locals=3 upvalues=0 vararg=false
function calculateStarsNeededForNextReward()
    local r108_0 = countCollectedStars()
    local r108_1 = calculateNextReward()
    local r108_2
    if r108_1 == 99999 then
        r108_2 = nil
    else
        r108_2 = r108_1 - r108_0
    end
    return r108_2
end

-- line 5323-5334
-- proto#109 params=0 locals=9 upvalues=0 vararg=false
function getLevelUnlockedWithStars()
    local r109_0 = countCollectedStars()
    for r109_1, r109_2 in _G.pairs(actions.myLevels) do
        for r109_3, r109_4 in _G.ipairs(r109_2) do
            local r109_5 = getLevelMetadata(r109_4)
            if r109_5.starsUnlockLimit then
                if getLevelMetadata(r109_4).starsUnlockLimit <= r109_0 and not (isPlatformLimited() and getLevelMetadata(r109_4).unavailableOnNonIaps or SettingsWrapper:isThreeStarLevelUnlocked(r109_4)) then
                    local r109_6 = r109_4
                    local r109_7 = getLevelMetadata(r109_4)
                    return r109_6, r109_7.starsUnlockLimit
                end
            end
        end
    end
end

-- line 5336-5341
-- proto#110 params=0 locals=0 upvalues=0 vararg=false
function checkDagobahUnlock()
    if dagobahUnlockedWithStars then
        return true
    end
    return false
end

-- line 5343-5373
-- proto#111 params=0 locals=9 upvalues=0 vararg=false
function checkFalconsFromStars()
    if platformSupportsME() then
        local r111_0 = countCollectedStars()
        local r111_1 = SettingsWrapper:getNextStarGoalIndex()
        local r111_2 = starTargetsForFalcons[r111_1]
        local r111_3, r111_4 = r111_2[1], 0
        while r111_3 <= r111_0 do
            r111_4 = r111_4 + starTargetsForFalcons[r111_1][2]
            r111_1 = r111_1 + 1
            r111_3 = starTargetsForFalcons[r111_1][1]
        end
        if r111_4 > 0 then
            if not SettingsWrapper:isMEAdvertEnabled() then
                print("Falcon has not yet been activated, activate it now")
                fireAction("setMEAdvertPossible", {})
            end
            SettingsWrapper:setNextStarGoalIndex(r111_1)
            local r111_5 = r111_4
            local r111_6 = starTargetsForFalcons[r111_1 - 1]
            return r111_5, r111_6[1]
        end
        return 0, 0
    end
    return 0, 0
end

-- line 5375-5385
-- proto#112 params=2 locals=6 upvalues=0 vararg=false
function addMightyFalconsFromStars(p112_0, p112_1)
    print([[ADDED FALCONS
]])
    if platformSupportsME() then
        local r112_0 = calculateNextReward()
        local r112_1 = ui.RewardPopup
        local r112_2 = {
            rewardStars = p112_1,
            nextReward = r112_0,
            falcons = p112_0,
            inMenuSpace = false,
            returnValue = ""
        }
        local r112_3 = r112_1:new(r112_2)
        local r112_4 = eventManager
        local r112_5 = { id = events.EID_PUSH_FRAME, target = r112_3 }
        r112_4:notify(r112_5)
        SettingsWrapper:addMightyEagles(p112_0)
        savePurchases()
    end
end

-- line 5387-5395
-- proto#113 params=1 locals=6 upvalues=0 vararg=false
function getFolderNameForLevel(p113_0)
    for r113_0, r113_1 in _G.pairs(actions.myLevels) do
        for r113_2, r113_3 in _G.pairs(r113_1) do
            if r113_3 == p113_0 then
                return r113_0
            end
        end
    end
end

-- line 5398-5409
-- proto#114 params=0 locals=5 upvalues=0 vararg=false
function unlockBobaFettEpisode()
    local r114_0 = getEpisodeMetadataWithParam("bobaFett_1", "iapPurchaseId")
    print("unlockBobaFett: id = " .. r114_0)
    SettingsWrapper:purchaseEpisode(r114_0)
    savePurchases()
    unlockAllBobaLevels()
    print("<unlockBobaFettEpisode> unlocked")
    local r114_1 = _G.tostring(r114_0)
    print("<unlockBobaFettEpisode> IapId: " .. r114_1)
end

-- line 5412-5420
-- proto#115 params=0 locals=1 upvalues=0 vararg=false
function unlockDagobah()
    local r115_0 = getEpisodeMetadataWithParam("dagobah_1", "iapPurchaseId")
    print("unlockDagobah: dagobahIapId = " .. r115_0)
    SettingsWrapper:purchaseEpisode(r115_0)
    savePurchases()
    registerAchievement("Dangerous It Will Be")
    print("<unlockDagobah> Dagobah unlocked")
    print("<unlockDagobah> IapId: " .. r115_0)
end

-- line 5422-5438
-- proto#116 params=2 locals=8 upvalues=0 vararg=false
function isEpisodeThreeStarred(p116_0, p116_1)
    local r116_0 = actions.episodeTypeTable[p116_0]
    local r116_1 = nil
    for r116_2, r116_3 in _G.ipairs(actions.myLevelFolders[r116_0]) do
        if r116_3 == p116_1 then
            r116_1 = r116_2
        end
    end
    local r116_4, r116_5, r116_6 = calculateEpisodeScoreAndStars(p116_0, r116_1)
    local r116_7 = print
    local r116_8 = "<isEpisodeThreeStarred> Episode: " .. p116_1 .. " totalStars = " .. r116_5 .. " maxStars = " .. r116_6 .. [[
]]
    r116_7(r116_8)
    if r116_6 <= r116_5 then
        return true
    end
    return false
end

-- line 5440-5457
-- proto#117 params=2 locals=8 upvalues=0 vararg=false
function isEpisodeFalconed(p117_0, p117_1)
    local r117_0 = actions.episodeTypeTable[p117_0]
    local r117_1 = nil
    for r117_2, r117_3 in _G.ipairs(actions.myLevelFolders[r117_0]) do
        if r117_3 == p117_1 then
            r117_1 = r117_2
        end
    end
    local r117_4, r117_5, r117_6, r117_7, r117_8 = calculateEpisodeScoreAndStars(p117_0, r117_1)
    local r117_9 = print
    local r117_10 = "<isEpisodeThreeStarred> Episode: " .. p117_1 .. " totalStars = " .. r117_5 .. " maxStars = " .. r117_6 .. [[
]]
    r117_9(r117_10)
    if r117_8 <= r117_7 then
        return true
    end
    return false
end

-- line 5459-5473
-- proto#118 params=0 locals=6 upvalues=0 vararg=false
function getMainMenuTheme()
    local r118_0 = SettingsWrapper:getLastOpenedEpisodeIndex()
    local r118_1 = SettingsWrapper:getLastOpenedEpisodeType()
    if r118_0 and r118_1 then
        local r118_2 = actions.episodeTypeTable
        local r118_3 = actions.myLevelFolders[r118_2[r118_1]]
        local r118_4 = r118_3[r118_0]
        print("<getMainMenuTheme> episodeNameFolder = " .. r118_4 .. [[
]])
        return getEpisodeMetadata(r118_4).mainMenuTheme
    end
    return "theme_menu_main_1"
end

-- line 5477-5491
-- proto#119 params=0 locals=0 upvalues=0 vararg=false
function getTitleTheme()
    if _G.res.isAudioPlaying("mainThemeAndMenuMusic") or SettingsWrapper:getPlayMainMusic() or levelName == "MainMenu" then
        if SettingsWrapper:getPlayMainMusic() then
            SettingsWrapper:setPlayMainMusic(false)
        end
        return "mainThemeAndMenuMusic"
    end
    return "menu_lounge"
end

-- line 5493-5507
-- proto#120 params=0 locals=4 upvalues=0 vararg=false
function isNextLevelComic()
    local r120_0 = actions.myLevels[currentFolder]
    if r120_0[currentLevel + 1] then
        local r120_1 = getLevelMetadata
        local r120_2 = actions.myLevels[currentFolder]
        local r120_3 = r120_1(r120_2[currentLevel + 1])
        if r120_3.type then
            local r120_4 = getLevelMetadata
            local r120_5 = actions.myLevels[currentFolder]
            local r120_6 = r120_4(r120_5[currentLevel + 1])
            if r120_6.type == "comic" then
                return true
            end
            return false
        end
        return false
    end
    return false
end

-- line 5509-5543
-- proto#121 params=2 locals=1 upvalues=0 vararg=false
function getEpisodeMetadataWithParam(p121_0, p121_1)
    if p121_1 == "iapPurchaseId" then
        local r121_0 = getEpisodeMetadata(p121_0)
        if deviceModel == "android" then
            if customerString == "amazon" then
                if isHDVersion then
                    if isPremium then
                        return r121_0.iapPurchaseIdAndroidAmazonHDPremium
                    end
                    return r121_0.iapPurchaseIdAndroidAmazonHDFree
                end
                if isPremium then
                    return r121_0.iapPurchaseIdAndroidAmazonPremium
                end
                return r121_0.iapPurchaseIdAndroidAmazonFree
            end
            if isHDVersion then
                return r121_0.iapPurchaseIdAndroidHD
            end
            return r121_0.iapPurchaseIdAndroid
        end
        if deviceModel == "iphone" then
            return r121_0.iapPurchaseId
        end
        if deviceModel == "iphone4" then
            return r121_0.iapPurchaseId
        end
        if deviceModel == "ipad" then
            return r121_0.iapPurchaseIdHD
        end
        if p121_0 == "bobaFett_1" and buildSettings.isBobaFettMissionsUnlockable() then
            return "DUMMY_IAP_ID_FOR_" .. p121_0
        end
        if p121_0 == "dagobah_1" and buildSettings.isPathOfJediAvailable() and (deviceModel == "metro" or deviceModel == "windows") then
            return "DUMMY_IAP_ID_FOR_" .. p121_0
        end
    end
end

TIE_FIGHTER_MAX_SPAWN_TIME = 7
currentShowTime = TIE_FIGHTER_MAX_SPAWN_TIME * 0.75
tieFighters = {}
MAX_TIEFIGHTERS = 3
g_currentTieFighterIndex = 0
TIEFIGHTER_FLY_TIME = 4

-- line 5555-5559
-- proto#122 params=0 locals=0 upvalues=0 vararg=false
function resetMainMenuTiefighers()
    tieFighters = {}
    g_currentTieFighterIndex = 0
    currentShowTime = TIE_FIGHTER_MAX_SPAWN_TIME * 0.75
end

g_timeSinceLastTie = 0
g_lastTieDirection = nil
TIE_DT_LIMIT = 0.009999999776482582
g_currentTieRandomDt = 0

-- line 5567-5598
-- proto#123 params=1 locals=3 upvalues=0 vararg=false
function updateMainMenuTieFighter(p123_0)
    currentShowTime = currentShowTime + p123_0
    g_timeSinceLastTie = g_timeSinceLastTie + p123_0
    local r123_0 = currentShowTime
    if TIE_FIGHTER_MAX_SPAWN_TIME < r123_0 then
        currentShowTime = 0
    end
    g_currentTieRandomDt = g_currentTieRandomDt + p123_0
    local r123_1 = g_currentTieRandomDt
    if TIE_DT_LIMIT < r123_1 then
        g_currentTieRandomDt = 0
        local r123_2 = _G.math.random() * currentShowTime
        if TIE_FIGHTER_MAX_SPAWN_TIME * 0.8999999761581421 < r123_2 then
            local r123_3 = g_timeSinceLastTie
            if r123_3 > 5 then
                g_lastTieDirection = nil
            end
            g_timeSinceLastTie = 0
            if not g_lastTieDirection then
                local r123_4 = _G.math.random()
                if r123_4 > 0.5 then
                    g_lastTieDirection = "R_TO_L"
                else
                    g_lastTieDirection = "L_TO_R"
                end
            end
            spawnTieFigher(g_lastTieDirection)
        end
    end
end

-- line 5604-5736
-- proto#124 params=1 locals=33 upvalues=0 vararg=false
function spawnTieFigher(p124_0)
    if not p124_0 then
        p124_0 = "R_TO_L"
    end
    g_currentTieFighterIndex = g_currentTieFighterIndex + 1
    local r124_0 = g_currentTieFighterIndex
    if MAX_TIEFIGHTERS < r124_0 then
        g_currentTieFighterIndex = 1
    end
    local r124_1 = "TIEFIGHTER_" .. g_currentTieFighterIndex
    if tieFighters[r124_1] then
        return
    end
    local r124_2 = ui.ImageButton:new({ name = r124_1, activateOnRelease = false })
    r124_2.rotateTime = 0
    local r124_3 = _G.math.random()
    if r124_3 > 0.5 then
        r124_2.moveFunc = _G.math.cos
    else
        r124_2.moveFunc = _G.math.sin
    end
    playAudio("tie_flyby")
    r124_2.from = p124_0
    r124_2.returnValue = "CLICKED_TIE"
    r124_2:setImage("MENU_TIE_FIGHTER_1")
    local r124_4 = screenWidth
    local r124_5 = _G.res.getSpriteBounds("MENU_TIE_FIGHTER_1")
    r124_2.x = r124_4 + r124_5
    local r124_6 = r124_2.x
    r124_2.flyX = r124_6 - screenWidth * 0.5
    if p124_0 == "L_TO_R" then
        local r124_7 = _G.res.getSpriteBounds("MENU_TIE_FIGHTER_1")
        r124_2.x = -r124_7 * 0.5
        local r124_8 = r124_2.x - screenWidth * 0.5
        local r124_9 = _G.res.getSpriteBounds("MENU_TIE_FIGHTER_1")
        r124_2.flyX = r124_8 - r124_9
    end
    local r124_10 = screenHeight
    local r124_11 = _G.math.random()
    r124_2.y = r124_10 * (0.30000001192092896 + r124_11 * 0.5)
    local r124_12 = r124_2.y
    r124_2.flyY = r124_12 - screenHeight * 0.5
    r124_2.endScreenX = screenWidth * 0.5
    local r124_13 = screenHeight
    local r124_14 = _G.math.random()
    r124_2.endScreenY = r124_13 * (0.4000000059604645 + r124_14 * 0.15000000596046448)
    local r124_15 = r124_2.endScreenY
    if screenHeight * 0.3499999940395355 <= r124_15 and r124_2.endScreenY <= screenHeight * 0.699999988079071 then
        if p124_0 == "R_TO_L" then
            local r124_16 = screenWidth * 0.30000001192092896
            local r124_17 = _G.math.random()
            r124_2.endScreenX = r124_16 + r124_17 * 0.05000000074505806
            r124_2.flyX = r124_2.x - r124_2.endScreenX
        end
        if p124_0 == "L_TO_R" then
            local r124_18 = _G.res.getSpriteBounds("MENU_TIE_FIGHTER_1")
            r124_2.x = -r124_18 * 0.5
            local r124_19 = screenWidth * 0.6000000238418579
            local r124_20 = _G.math.random()
            r124_2.endScreenX = r124_19 + r124_20 * 0.05000000074505806
        end
    end
    r124_2.time = 0
    local r124_21 = menuManager:getRoot()

    -- line 5668-5707
    -- proto#125 params=3 locals=39 upvalues=0 vararg=false
    function r124_2.update(p125_0, p125_1, p125_2)
        p125_0.travelledRelative = (TIEFIGHTER_FLY_TIME - p125_0.time) / TIEFIGHTER_FLY_TIME
        local r125_0 = p125_0.time
        if r125_0 > 2 then
            local r125_1 = p125_0.rotateTime
            p125_0.rotateTime = r125_1 + p125_1 * 0.5
        end
        local r125_2 = _G.math.cos(p125_0.time)
        p125_0.x = p125_0.endScreenX + (0.15000000596046448 + r125_2 * 0.8500000238418579) * p125_0.flyX * p125_0.travelledRelative
        local r125_3 = p125_0.moveFunc(p125_0.time)
        p125_0.y = p125_0.endScreenY + r125_3 * p125_0.flyY * p125_0.travelledRelative * 2
        local r125_4 = _G.math.max(p125_0.travelledRelative, 0.009999999776482582)
        p125_0.time = p125_0.time + p125_1 * 2 * r125_4
        local r125_5 = p125_0.travelledRelative
        p125_0.scaleX = r125_5 * 0.6499999761581421
        local r125_6 = p125_0.travelledRelative
        p125_0.scaleY = r125_6 * 0.6499999761581421
        if p125_0.from == "L_TO_R" then
            local r125_7 = p125_0.moveFunc(p125_0.time * 2) * 0.30000001192092896
            local r125_8 = _G.math.sin(_G.math.min(p125_0.rotateTime, 1.2000000476837158))
            p125_0.angle = r125_7 - r125_8 * 3.1414999961853027
        else
            local r125_9 = p125_0.moveFunc(p125_0.time * 2) * 0.30000001192092896
            local r125_10 = _G.math.sin(_G.math.min(p125_0.rotateTime, 1.2000000476837158))
            p125_0.angle = r125_9 + r125_10 * 3.1414999961853027
        end
        if TIEFIGHTER_FLY_TIME - p125_0.time <= 0 then
            tieFighters[p125_0.name] = nil
            local r125_11 = menuManager:getRoot()
            if r125_11 then
                local r125_12 = r125_11:getChild("mainMenu")
                if r125_12 then
                    r125_12:getChild("tieFighterFrame"):removeChild(p125_0)
                end
            end
        end
        ui.ImageButton.update(p125_0, p125_1, p125_2)
    end

    -- line 5709-5724
    -- proto#126 params=4 locals=6 upvalues=0 vararg=false
    function r124_2.onPointerEvent(p126_0, p126_1, p126_2, p126_3)
        local r126_0, r126_1 = ui.ImageButton.onPointerEvent(p126_0, p126_1, p126_2, p126_3)
        if not r126_0 then
            return
        end
        _G.res.playAudio("pigs_tie_fighter_destroyed")
        local r126_2, r126_3 = screenToWorldTransform(p126_0.x, p126_0.y)
        local r126_4, r126_5 = r126_3, r126_2
        local r126_6 = p126_0.travelledRelative * 3
        putParticles({
            particles = "blackExplosionBuff",
            amount = 10,
            worldX = r126_5,
            worldY = r126_4,
            minScaleBegin = r126_6,
            minScaleEnd = r126_6,
            maxScaleBegin = r126_6,
            maxScaleEnd = r126_6
        })
        putParticles({
            particles = "junkPieceExplosionZeroG",
            amount = 10,
            worldX = r126_5,
            worldY = r126_4,
            minScaleBegin = r126_6 * 0.5,
            minScaleEnd = 0,
            maxScaleBegin = r126_6 * 0.5,
            maxScaleEnd = 0
        })
        p126_0.visible = false
        return -1
    end

    local r124_22 = menuManager:getRoot()
    if r124_22 then
        local r124_23 = r124_22:getChild("mainMenu")
        if r124_23 then
            r124_23:getChild("tieFighterFrame"):addChild(r124_2)
            tieFighters[r124_2.name] = r124_2
        end
    end
end

-- line 5739-5741
-- proto#127 params=0 locals=1 upvalues=0 vararg=false
function isPowerupIAPPageShown()
    return menuManager:getRoot():getChild("PowerupIAPPopup") ~= nil
end

-- line 5743-5745
-- proto#128 params=0 locals=0 upvalues=0 vararg=false
function getEmptyButtonSpriteName()
    return "LS_BUTTON_BG_1"
end

-- line 5747-5749
-- proto#129 params=0 locals=1 upvalues=0 vararg=false
function isEpisodeRewardShown()
    return menuManager:getRoot():getChild("EpisodeRewardPage") ~= nil
end

-- line 5751-5753
-- proto#130 params=0 locals=1 upvalues=0 vararg=false
function isFalconUnlockShown()
    return menuManager:getRoot():getChild("falconUnlocked") ~= nil
end

-- line 5756-5758
-- proto#131 params=0 locals=4 upvalues=0 vararg=false
function isTimedGetFullVersionPageShown()
    local r131_0 = isIOSFree()
    local r131_1
    if r131_0 then
        local r131_2 = menuManager:getRoot()
        local r131_3 = TimedGetFullVersionPage.getName
        r131_1 = r131_2:getChild(r131_3()) ~= nil
    else
        r131_1 = r131_0
    end
    return r131_1
end

-- line 5761-5763
-- proto#132 params=0 locals=0 upvalues=0 vararg=false
function isTutorialShown()
    return g_tutorialShowing
end

-- line 5765-5767
-- proto#133 params=0 locals=1 upvalues=0 vararg=false
function isDailyRewardShown()
    return menuManager:getRoot():getChild("PowerupMachineFrame") ~= nil
end

-- line 5770-5772
-- proto#134 params=0 locals=4 upvalues=0 vararg=false
function isGetFullVersionPageShown()
    local r134_0 = isIOSFree()
    local r134_1
    if r134_0 then
        local r134_2 = menuManager:getRoot()
        local r134_3 = GetFullVersionPage.getName
        r134_1 = r134_2:getChild(r134_3()) ~= nil
    else
        r134_1 = r134_0
    end
    return r134_1
end

-- line 5774-5805
-- proto#135 params=1 locals=10 upvalues=0 vararg=false
function calculateEpisodeSelectionScale(p135_0)
    local r135_0
    local r135_1 = objects.world[p135_0]
    local r135_2 = blockTable.blocks[r135_1.definition]
    local r135_3 = r135_2.episodeScalingValues
    local r135_4 = r135_2.scale or 1
    local r135_5 = screenWidth
    local r135_6, r135_7 = physicsToScreenTransform(r135_1.x, r135_1.y)
    local r135_8
    if r135_5 > 1024 then
        local r135_9 = r135_6 - (r135_5 - 1024) / 2
        r135_0 = 1024
        if r135_9 < 0 then
            r135_8 = 0
        elseif r135_0 < r135_9 then
            r135_8 = r135_0
        else
            r135_8 = r135_9
        end
    else
        r135_8 = r135_6
    end
    local r135_10 = r135_5 > 1024 and r135_0 or r135_5
    local r135_11 = r135_8 / r135_10
    return calculateScaleFactor(r135_11, r135_3), r135_11, r135_4
end

-- line 5807-5823
-- proto#136 params=2 locals=16 upvalues=0 vararg=false
function calculateScaleFactor(p136_0, p136_1)
    local r136_0 = p136_1.leftMinimumLocation
    if p136_0 <= r136_0 then
        scaleFactor = p136_1.leftMinimumScale
    else
        local r136_1 = p136_1.leftMaximumLocation
        if p136_0 < r136_1 then
            scaleFactor = p136_1.leftMinimumScale + (p136_0 - p136_1.leftMinimumLocation) / (p136_1.leftMaximumLocation - p136_1.leftMinimumLocation) * (p136_1.centerScale - p136_1.leftMinimumScale)
        else
            local r136_2 = p136_1.rightMaximumLocation
            if p136_0 <= r136_2 then
                scaleFactor = p136_1.centerScale
            else
                local r136_3 = p136_1.rightMinimumLocation
                if p136_0 <= r136_3 then
                    scaleFactor = p136_1.rightMinimumScale + (p136_1.rightMinimumLocation - p136_0) / (p136_1.rightMinimumLocation - p136_1.rightMaximumLocation) * (p136_1.centerScale - p136_1.rightMinimumScale)
                else
                    scaleFactor = p136_1.rightMinimumScale
                end
            end
        end
    end
    return scaleFactor
end

-- line 5826-5828
-- proto#137 params=1 locals=0 upvalues=0 vararg=false
function lua_addParticlesToJoint(p137_0)

end

-- line 5830-5836
-- proto#138 params=1 locals=9 upvalues=0 vararg=false
function getJointAnchorPositions(p138_0)
    local r138_0 = objects.world[p138_0.end1]
    local r138_1 = objects.world[p138_0.end2]
    local r138_2, r138_3 = vec2Rotate(p138_0.x1, p138_0.y1, getAngle(r138_0.name))
    local r138_4, r138_5 = vec2Rotate(p138_0.x2, p138_0.y2, getAngle(r138_1.name))
    local r138_6 = r138_0.x + r138_2
    local r138_7 = r138_1.x + r138_4
    local r138_8 = r138_0.y + r138_3
    local r138_9 = r138_1.y
    return r138_6, r138_7, r138_8, r138_9 + r138_5
end

-- line 5838-5854
-- proto#139 params=1 locals=3 upvalues=0 vararg=false
function jointRemoved(p139_0)
    local r139_0 = objects.joints[p139_0]
    if checkStillInWorld(r139_0.end1) then
        local r139_1 = objects.world[r139_0.end1]
        if r139_1.onJointRemoved then
            fireAction(r139_1.onJointRemoved, { name = r139_1.name, jointName = p139_0 })
        end
    end
    if checkStillInWorld(r139_0.end2) then
        local r139_2 = objects.world[r139_0.end2]
        if r139_2.onJointRemoved then
            fireAction(r139_2.onJointRemoved, { name = r139_2.name, jointName = p139_0 })
        end
    end
end

-- line 5857-5861
-- proto#140 params=1 locals=0 upvalues=0 vararg=false
function checkSetPhysicsState(p140_0)
    if not isPausePageVisible() then
        setPhysicsEnabled(p140_0)
    end
end

-- line 5863-5869
-- proto#141 params=3 locals=1 upvalues=0 vararg=false
function weldObjects(p141_0, p141_1, p141_2)
    local r141_0 = {
        name = p141_0,
        type = 2,
        end1 = p141_1,
        end2 = p141_2,
        x1 = 0,
        y1 = 0,
        x2 = 0,
        y2 = 0,
        collideConnected = false
    }
    createJoint(r141_0)
end

-- line 5871-5876
-- proto#142 params=1 locals=2 upvalues=0 vararg=false
function setLocale(p142_0)
    g_currentLocale = p142_0
    _G.res.loadLocale("TEXTS_BASIC", g_currentLocale)
    _G.res.useLocale(g_currentLocale)
end

-- line 5878-5892
-- proto#143 params=0 locals=3 upvalues=0 vararg=false
function isRovioNewsShowAllowed()
    if isInGameMode() and not (menuManager == nil or menuManager:getRoot() == nil) then
        local r143_0 = menuManager:getRoot():getChild("pausePage")
        local r143_1
        if r143_0 == nil then
            r143_1 = false
        else
            local r143_2 = r143_0.visible
            if r143_2 then
                if r143_0.extendState == 1 then
                    if g_tutorialShowing == true then
                        r143_1 = false
                    else
                        r143_1 = not g_showingChannelOrID
                    end
                else
                    r143_1 = false
                end
            else
                r143_1 = r143_2
            end
        end
        return r143_1
    end
    return false
end

-- line 5895-5898
-- proto#144 params=0 locals=4 upvalues=0 vararg=false
function canShowAd()
    local r144_0 = haveInGameAds()
    local r144_1
    if r144_0 then
        local r144_2 = isInGameMode()
        if r144_2 then
            if isPausePageVisible() then
                r144_1 = false
            elseif isTutorialShown() then
                r144_1 = false
            else
                local r144_3 = SettingsWrapper:hasAnyLevelBeenCompleted()
                if r144_3 then
                    r144_1 = not g_tutorialShowing
                else
                    r144_1 = r144_3
                end
            end
        else
            r144_1 = r144_2
        end
    else
        r144_1 = r144_0
    end
    return r144_1
end

-- line 5900-5910
-- proto#145 params=0 locals=5 upvalues=0 vararg=false
function getRemainingBirds()
    local r145_0 = {}
    for r145_1, r145_2 in _G.pairs(birds) do
        if not r145_2.shot then
            _G.table.insert(r145_0, r145_2)
        end
    end
    return r145_0
end

-- line 5913-5918
-- proto#146 params=1 locals=0 upvalues=0 vararg=false
function getButtonImageNameBlack(p146_0)
    if p146_0 == "buttonX" then
        return "BTN_X"
    end
    return ""
end

-- line 5920-5932
-- proto#147 params=0 locals=2 upvalues=0 vararg=false
function disableMEButton()
    local r147_0 = menuManager:getRoot():getChild("MEButton")
    if r147_0 then
        r147_0:setEnabled(false)
        r147_0.alpha = 0.5
        local r147_1 = menuManager:getRoot():getChild("MEGlow")
        if r147_1 then
            r147_1.visible = false
        end
    end
end

-- line 5934-5936
-- proto#148 params=0 locals=4 upvalues=0 vararg=false
function iapNotAllowedOnIOS()
    local r148_0 = isIOSVersion()
    local r148_1
    if r148_0 then
        local r148_2 = g_iOSVersion
        if r148_2 then
            local r148_3 = _G.tonumber
            local r148_4 = _G.string.sub
            if r148_3(r148_4(g_iOSVersion, 1, 1)) < 6 then
                r148_1 = not iapIsAllowed()
            else
                r148_1 = false
            end
        else
            r148_1 = r148_2
        end
    else
        r148_1 = r148_0
    end
    return r148_1
end
