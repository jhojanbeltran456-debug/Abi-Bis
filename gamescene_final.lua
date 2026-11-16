-- file: <unknown>
-- dialect: lua5.1
-- encoding: windows-1252
-- decompiled by unluac-rs

GameScene = ui.Frame:new()
local r0_0, r0_1, r0_2, r0_3, r0_4, r0_5, r0_6, r0_7 = "SLING_SHOT_01_FRONT", "SLING_SHOT_01_BACK", "SLING_RUBBERBAND", "SLING_HOLDER", "", "", "", ""

-- line 16-20
-- proto#1 params=1 locals=0 upvalues=0 vararg=false
function GameScene.init(p1_0)
    p1_0.currentFrame = 0
    p1_0.name = "GameScene"
    p1_0:resetSlingshotGfx()
end

-- line 22-27
-- proto#2 params=1 locals=0 upvalues=8 vararg=false
function GameScene:resetSlingshotGfx()
    r0_4 = r0_0
    r0_5 = r0_1
    r0_6 = r0_2
    r0_7 = r0_3
end

-- line 29-34
-- proto#3 params=5 locals=0 upvalues=4 vararg=false
function GameScene:setSlingshotGfx(p3_1, p3_2, p3_3, p3_4)
    r0_4 = p3_1
    r0_5 = p3_2
    r0_6 = p3_3
    r0_7 = p3_4
end

-- line 36-38
-- proto#4 params=1 locals=0 upvalues=0 vararg=false
function GameScene:resetFrameElements()
    self.children = {}
end

-- line 40-115
-- proto#5 params=1 locals=15 upvalues=0 vararg=false
function GameScene:setupFrameElements()
    loginfo("--------- GameScene:setupFrameElements() --------")
    if isPCVersion() then
        local r5_0 = getLevelMetadata(levelName)
        if not r5_0.hideRestartButton and not startedFromEditor then
            local r5_1 = ui.ScallableButton
            local r5_2 = {
                name = "restartButton",
                activateOnRelease = true,
                refuseDragTargetting = true
            }
            local r5_3 = r5_1:new(r5_2)
            local r5_4 = getLevelMetadata(levelName)
            local r5_5 = r5_4.restartButtonSprite
            local r5_6
            r5_6(r5_3, r5_5 or "BTN_RESTART")
            r5_3.returnValue = "RESTART_CLICKED"
            self:addChild(r5_3)
        end
    end
    if startedFromEditor or not getLevelMetadata(levelName).hideMEButton and not getEpisodeMetadata(currentFolder).hideMEButton and (SettingsWrapper:isTutorialShown("ME_BAIT") or SettingsWrapper:isMightyEagleEnabled() or SettingsWrapper:getTimesMFBought() > 0 or SettingsWrapper:isMEAdvertEnabled() and platformSupportsME()) then
        local r5_7 = ui.ScallableButton
        local r5_8 = { name = "MEButton", activateOnRelease = true, refuseDragTargetting = true }
        local r5_9 = r5_7:new(r5_8)
        r5_9:setImage("BTN_MIGHTY_EAGLE", "BTN_MIGHTY_EAGLE")
        r5_9.returnValue = "ME_CLICKED"
        if SettingsWrapper:getPlayerUsedEaglesCount() <= 0 then
            local r5_10 = ui.Image:new({ name = "MEGlow" })
            r5_10:setImage("EAGLE_SHINE_1")
            r5_10.scaleX = 0.5
            r5_10.scaleY = 0.5
            if isIpad3() then
                r5_10.scaleX = 0.699999988079071
                r5_10.scaleY = 0.699999988079071
            end
            self:addChild(r5_10)

            -- line 71-73
            -- proto#6 params=3 locals=1 upvalues=0 vararg=false
            function r5_10.update(p6_0, p6_1, p6_2)
                local r6_0 = p6_0.angle
                p6_0.angle = r6_0 + p6_1
            end
        end
        local r5_11 = ui.Text:new({ name = "eaglesAvailable", font = getFontHeadline })
        local r5_12 = _G.tostring
        r5_11.text = r5_12(SettingsWrapper:getMEAmount())
        r5_11.scaleX = 0.5
        r5_11.scaleY = 0.5
        local r5_13 = ui.Image:new({ name = "buyMoreImage" })
        r5_13:setImage("INGAME_POWERUP_BUY")
        local r5_14 = r5_9.h
        r5_13.y = r5_14 * 0.44999998807907104
        r5_13.visible = false
        r5_9:addChild(r5_13)
        local r5_15 = ui.Image:new({ name = "MEButtonSmallBox" })
        r5_15.scaleX = 0.75
        r5_15.scaleY = 0.75
        r5_15:setImage("BOX_FALCON_AMOUNT")
        r5_9:addChild(r5_15)
        r5_15:addChild(r5_11)
        if SettingsWrapper:getMEAmount() <= 0 then
            r5_15.visible = false
            r5_13.visible = true
        end
        self:addChild(r5_9)
    end
    self:addPowerUpUI()
    if isInGameMode() then
        local r5_16 = menuManager:getRoot()
        if r5_16 ~= nil then
            r5_16:addChild(ui.GameHud:new())
        end
    end
end

-- line 117-127
-- proto#7 params=1 locals=0 upvalues=0 vararg=false
function GameScene:addPowerUpUI()
    if PowerupManager and PowerupManager.arePowerUpsEnabled() then
        self:addChild((ui.PowerupSlider:new({ name = PowerupManager.POWERUP_SLIDER_NAME })))
        PowerupManager:addLastChanceButton()
        PowerupManager:refreshPowerupUI()
    end
end

-- line 129-137
-- proto#8 params=1 locals=0 upvalues=0 vararg=false
function GameScene:reduceEagle()
    SettingsWrapper:reduceEagle()
    SettingsWrapper:markMFUsed()
    savePurchases()
end

-- line 139-159
-- proto#9 params=1 locals=7 upvalues=0 vararg=false
function GameScene:updateMELeft()
    local r9_0 = self:getChild("eaglesAvailable")
    if r9_0 ~= nil then
        local r9_1 = SettingsWrapper:getMEAmount() - numMightyEaglesCalled + numMightyEaglesShot
        local r9_2 = _G.tostring
        r9_0.text = r9_2(r9_1)
        local r9_3 = self:getChild("MEButton")
        if r9_3 then
            local r9_4 = r9_3:getChild("MEButtonSmallBox")
            local r9_5 = r9_3:getChild("buyMoreImage")
            if r9_4 and r9_5 then
                if r9_1 <= 0 then
                    r9_4.visible = false
                    r9_5.visible = true
                else
                    r9_4.visible = true
                    r9_5.visible = false
                end
            end
        end
    end
end

-- line 161-455
-- proto#10 params=2 locals=50 upvalues=0 vararg=false
function GameScene.eventTriggered(p10_0, p10_1)
    print("GAMESCENE : EVENT TRIGGERED " .. p10_1.id)
    local r10_0 = p10_1.id
    local r10_1 = events.EID_JOINT_REMOVED
    if r10_0 == r10_1 then
        jointRemoved(p10_1.jointName)
    else
        local r10_2 = p10_1.id
        local r10_3 = events.EID_POWERUP_IAP_POPUP_CLOSED
        if r10_2 == r10_3 then
            SettingsWrapper:pupuWindowClosed()
        else
            local r10_4 = p10_1.id
            local r10_5 = events.EID_PURCHASE_CALLBACK_RECEIVED
            if r10_4 == r10_5 then
                local r10_6 = p10_0:getChild("eaglePurchasePage")
                if r10_6 then
                    local r10_7 = menuManager:getRoot()
                    local r10_8 = nil
                    if r10_7 then
                        r10_8 = r10_7:getChild("shop")
                    else
                        g_disableGameupdate = false
                        setGameOn(true)
                        setPhysicsEnabled(true)
                    end
                    if not r10_8 then
                        g_disableGameupdate = false
                        setGameOn(true)
                        setPhysicsEnabled(true)
                    end
                    p10_0:removeChild(r10_6)
                end
                local r10_9, r10_10
                if PowerupManager and p10_1.isStatusSuccess and menuManager:getRoot():getChild(PowerupManager.POWERUP_SLIDER_NAME) and menuManager:getRoot():getChild(PowerupManager.POWERUP_SLIDER_NAME):getChild(PowerupManager.CLONEBIRD_BUTTON_NAME) and r10_9:getChild(PowerupManager.CLONEBIRD_BUTTON_NAME):getChild(PowerupManager.BTN_LAST_CHANCE) and r10_10:getChild(PowerupManager.BTN_LAST_CHANCE).visible then
                    local r10_11 = ui.Shop.getDataById(p10_1.iapId)
                    local r10_12 = r10_11.powerupName
                    if r10_12 then
                        PowerupManager:activatePowerUp(r10_12)
                    end
                end
                local r10_13 = ui.Shop.getDataById(p10_1.iapId)
                if r10_13 and p10_1.isStatusSuccess and (r10_13.purchaseType == "POWERUP" or r10_13.purchaseType == "ME") then
                    SettingsWrapper:resetCurrentPupuFrequencyLevel()
                end
            else
                local r10_14 = p10_1.id
                local r10_15 = events.EID_PAUSE_CLICKED
                if r10_14 == r10_15 then
                    disableGameUpdate()
                else
                    local r10_16 = p10_1.id
                    local r10_17 = events.EID_PAUSE_PAGE_CLOSED
                    if r10_16 == r10_17 then
                        enableGameUpdate()
                        p10_0:updateMELeft()
                        processManager:setRunning(true)
                        local r10_18 = getLevelMetadata(levelName)
                        local r10_19 = r10_18.onResumeGame
                        if r10_19 then
                            fireAction(r10_19, {})
                        end
                    else
                        local r10_20 = p10_1.id
                        local r10_21 = events.EID_PAUSE_PAGE_OPENED
                        if r10_20 == r10_21 or p10_1.id == events.EID_TIMED_BUY_FREE_IOS_VERSION_POPUP_SHOWN then
                            if flyingBird and blockTable.blocks[flyingBird.definition].sounds and blockTable.blocks[flyingBird.definition].sounds.special_loop then
                                local r10_22 = blockTable.blocks[flyingBird.definition]
                                stopAudio(r10_22.sounds.special_loop)
                            end
                            processManager:setRunning(false)
                            local r10_23 = getLevelMetadata(levelName)
                            local r10_24 = r10_23.onPauseGame
                            if r10_24 then
                                fireAction(r10_24, {})
                            end
                        else
                            local r10_25 = p10_1.id
                            local r10_26 = events.EID_GAME_RESUMED
                            if r10_25 == r10_26 then
                                processManager:reset()
                            else
                                local r10_27 = p10_1.id
                                local r10_28 = events.EID_LEVEL_RESTART_CLICKED
                                if r10_27 == r10_28 then
                                    p10_0:triggerRestart()
                                else
                                    local r10_29 = p10_1.id
                                    local r10_30 = events.EID_CAPTURE_SCREEN
                                    if r10_29 == r10_30 then
                                        p10_0:initializeTransition()
                                    else
                                        local r10_31 = p10_1.id
                                        local r10_32 = events.EID_LEVEL_STARTED
                                        if r10_31 == r10_32 then
                                            p10_0:startTransition()
                                            processManager:reset()
                                        else
                                            local r10_33 = p10_1.id
                                            local r10_34 = events.EID_MIGHTY_EAGLE_BUTTON_CLICKED
                                            if r10_33 == r10_34 then
                                                if p10_1.from == "INGAME" then
                                                    local r10_35 = SettingsWrapper:getMEAmount() - numMightyEaglesCalled + numMightyEaglesShot
                                                    if r10_35 > 0 then
                                                        eventManager:notify({
                                                            id = events.EID_MIGHTY_FALCON_INITIALIZED
                                                        })
                                                        local r10_36 = p10_0:getChild("MEGlow")
                                                        if r10_36 then
                                                            p10_0:removeChild(r10_36)
                                                        end
                                                        if currentBirdName == nil then
                                                            g_meButtonMuted = true
                                                            addEventCall("changeBirdForFalcon", p)
                                                        else
                                                            local r10_37 = objects.world[currentBirdName]
                                                            if r10_37.definition == "ME_BAIT" then
                                                                replaceNextBirdWithME()
                                                            else
                                                                usedMightyEagle = true
                                                                setObjectParameter(currentBirdName, 33, 0)
                                                                replaceSelectedBirdWithME()
                                                            end
                                                        end
                                                        p10_0:updateMELeft()
                                                    elseif isIOSFree() then
                                                        eventManager:notify({
                                                            id = events.EID_OPEN_BUY_FREE_IOS_VERSION_POPUP
                                                        })
                                                    else
                                                        if iapNotAllowedOnIOS() then
                                                            return
                                                        end
                                                        local r10_38 = ui.Shop
                                                        local r10_39 = {
                                                            from = p10_1.from,
                                                            openedFrom = "mightyEagleButton"
                                                        }
                                                        local r10_40 = r10_38:new(r10_39)
                                                        r10_40:initPaymentAndPurchases()
                                                        local r10_41 = r10_40.getSmallestBundleDataByPowerupName
                                                        if r10_40:purchaseItem(r10_41("falcon")) ~= -1 then
                                                            p10_0:addChild(EaglePurchasePage:new())
                                                            g_disableGameupdate = true
                                                            disableGameUpdate()
                                                        end
                                                    end
                                                elseif p10_1.from == "MAIN_MENU" then
                                                    disableGameUpdate()
                                                    local r10_42 = eventManager
                                                    local r10_43 = {
                                                        id = events.EID_PUSH_FRAME,
                                                        target = ui.Shop:new({
                                                            from = p10_1.from,
                                                            openedFrom = "mainMenu"
                                                        })
                                                    }
                                                    r10_42:notify(r10_43)
                                                end
                                            else
                                                local r10_44 = p10_1.id
                                                local r10_45 = events.EID_MIGHTY_EAGLE_TRAILER_CLICKED
                                                if r10_44 ~= r10_45 then
                                                    local r10_46 = p10_1.id
                                                    local r10_47 = events.EID_MIGHTY_EAGLE_PURCHASE_CLOSE_CLICKED
                                                    if r10_46 == r10_47 then
                                                        eventManager:notify({
                                                            id = events.EID_POP_FRAME
                                                        })
                                                        local r10_48 = p10_1.from
                                                        if p10_1.from ~= "LEVEL_FAILED" then
                                                            enableGameUpdate()
                                                        end
                                                    else
                                                        local r10_49 = p10_1.id
                                                        local r10_50 = events.EID_POWERUP_CLICKED
                                                        if r10_49 == r10_50 then
                                                            if PowerupManager and PowerupManager:getPowerUpAmount(p10_1.powerUpName) > 0 then
                                                                PowerupManager:activatePowerUp(p10_1.powerUpName)
                                                                disableMEButton()
                                                            else
                                                                if iapNotAllowedOnIOS() then
                                                                    return
                                                                end
                                                                local r10_51 = ui.Shop:new({
                                                                    openedFrom = "powerupButton"
                                                                })
                                                                r10_51:initPaymentAndPurchases()
                                                                local r10_52 = r10_51.getSmallestBundleDataByPowerupName
                                                                if r10_51:purchaseItem(r10_52(p10_1.powerUpName)) ~= -1 then
                                                                    p10_0:addChild(EaglePurchasePage:new())
                                                                    g_disableGameupdate = true
                                                                    disableGameUpdate()
                                                                end
                                                            end
                                                        else
                                                            local r10_53 = p10_1.id
                                                            local r10_54 = events.EID_MIGHTY_EAGLE_PURCHASE_CLICKED
                                                            if r10_53 == r10_54 then
                                                                startMEPurchaseFlow(p10_1.quantity, p10_1.iapId, p10_1.openedFrom)
                                                            else
                                                                local r10_55 = p10_1.id
                                                                local r10_56 = events.EID_EPISODE_PURCHASE_CLOSE_CLICKED
                                                                if r10_55 == r10_56 then
                                                                    eventManager:notify({
                                                                        id = events.EID_POP_FRAME
                                                                    })
                                                                else
                                                                    local r10_57 = p10_1.id
                                                                    local r10_58 = events.EID_EPISODE_PURCHASE_CLICKED
                                                                    if r10_57 == r10_58 then
                                                                        startEpisodePurchaseFlow(p10_1.currentFolder, p10_1.iapId, p10_1.openedFrom)
                                                                    else
                                                                        local r10_59 = p10_1.id
                                                                        local r10_60 = events.EID_AUDIO_TOGGLED
                                                                        if r10_59 == r10_60 then
                                                                            if g_isWindowSnapped then
                                                                                metroSnapToggleAudio()
                                                                            else
                                                                                toggleAudio()
                                                                            end
                                                                        else
                                                                            local r10_61 = p10_1.id
                                                                            local r10_62 = events.EID_OPEN_URL
                                                                            if r10_61 == r10_62 then
                                                                                _G.res.openURL(p10_1.meta.url)
                                                                            else
                                                                                local r10_63 = p10_1.id
                                                                                local r10_64 = events.EID_OPEN_SHOP
                                                                                if r10_63 == r10_64 then
                                                                                    local r10_65 = ui.Shop:new({})
                                                                                    local r10_66 = eventManager
                                                                                    local r10_67 = {
                                                                                        id = events.EID_PUSH_FRAME,
                                                                                        target = r10_65
                                                                                    }
                                                                                    r10_66:queueEvent(r10_67)
                                                                                    if p10_1.shortCut then
                                                                                        r10_65:scrollToShortCut(p10_1.shortCut, p10_1.shortCutSpecifier)
                                                                                    end
                                                                                else
                                                                                    local r10_68 = p10_1.id
                                                                                    local r10_69 = events.EID_EPISODE_COMPLETED
                                                                                    if r10_68 == r10_69 then
                                                                                        SettingsWrapper:setPlayMainMusic(true)
                                                                                    else
                                                                                        local r10_70 = p10_1.id
                                                                                        local r10_71 = events.EID_OPEN_BUY_FREE_IOS_VERSION_POPUP
                                                                                        if r10_70 == r10_71 then
                                                                                            eventManager:notify({
                                                                                                id = events.EID_OPEN_FREE_IOS_VERSION_POPUP
                                                                                            })
                                                                                        else
                                                                                            local r10_72 = p10_1.id
                                                                                            local r10_73 = events.EID_INIT_EPISODE_COMPLETED_ACTIONS
                                                                                            if r10_72 == r10_73 then
                                                                                                if p10_1.showDialogs then
                                                                                                    local r10_74 = ui.ConfirmPrompt
                                                                                                    local r10_75 = {
                                                                                                        title = "TEXT_GAME_COMPLETE_TITLE",
                                                                                                        content = _G.res.getString("TEXTS_BASIC", complete_text),
                                                                                                        returnValue = events.EID_POP_FRAME,
                                                                                                        inMenuSpace = true,
                                                                                                        hideCloseButton = true
                                                                                                    }
                                                                                                    local r10_76 = r10_74:new(r10_75)
                                                                                                    local r10_77 = eventManager
                                                                                                    local r10_78 = {
                                                                                                        id = events.EID_PUSH_FRAME,
                                                                                                        target = r10_76
                                                                                                    }
                                                                                                    r10_77:notify(r10_78)
                                                                                                elseif p10_1.comicWatched ~= true then
                                                                                                    setupEpisodeCompletedActions(false, p10_1.lastComicOfGame)
                                                                                                end
                                                                                            else
                                                                                                local r10_79 = p10_1.id
                                                                                                local r10_80 = events.EID_EPISODE_THREE_STARS_POPUP_OPENED
                                                                                                if r10_79 ~= r10_80 then
                                                                                                    local r10_81 = p10_1.id
                                                                                                    local r10_82 = events.EID_MIGHTYFALCON_PURCHASED
                                                                                                    if r10_81 == r10_82 then
                                                                                                        local r10_83 = p10_0:getChild("MEButton")
                                                                                                        p10_0:updateMELeft()
                                                                                                        if r10_83 ~= nil then
                                                                                                            local r10_84 = r10_83:getChild("eaglesAvailable")
                                                                                                            if r10_84 ~= nil then
                                                                                                                r10_84.visible = true
                                                                                                            end
                                                                                                        end
                                                                                                    else
                                                                                                        local r10_85 = p10_1.id
                                                                                                        local r10_86 = events.EID_SPINNER_PAGE_CLOSING
                                                                                                        if r10_85 == r10_86 then
                                                                                                            local r10_87 = menuManager:getRoot()
                                                                                                            local r10_88 = nil
                                                                                                            if r10_87 then
                                                                                                                r10_88 = r10_87:getChild("shop")
                                                                                                            else
                                                                                                                g_disableGameupdate = false
                                                                                                            end
                                                                                                            if not r10_88 then
                                                                                                                g_disableGameupdate = false
                                                                                                            end
                                                                                                        else
                                                                                                            local r10_89 = p10_1.id
                                                                                                            local r10_90 = events.EID_SCROLL_RIGHT
                                                                                                            if r10_89 == r10_90 then
                                                                                                                if p10_1.delayed then
                                                                                                                    updatePCCameraPanningToDirection(true)
                                                                                                                else
                                                                                                                    local r10_91 = eventManager
                                                                                                                    local r10_92 = {
                                                                                                                        id = events.EID_SCROLL_RIGHT,
                                                                                                                        delayed = true
                                                                                                                    }
                                                                                                                    r10_91:queueEvent(r10_92)
                                                                                                                end
                                                                                                            else
                                                                                                                local r10_93 = p10_1.id
                                                                                                                local r10_94 = events.EID_SHOP_OPENED
                                                                                                                if r10_93 == r10_94 then
                                                                                                                    p10_0.drawTarget = p10_1.shop
                                                                                                                else
                                                                                                                    local r10_95 = p10_1.id
                                                                                                                    local r10_96 = events.EID_SHOP_CLOSED
                                                                                                                    if r10_95 == r10_96 then
                                                                                                                        if deviceModel == "android" and isIapEnabled() then
                                                                                                                            SettingsWrapper:setIAPRestoreChecked()
                                                                                                                            print([[<iap> attempting iap restore
]])
                                                                                                                            iapRestoreItems("iapRestoreCallback")
                                                                                                                        end
                                                                                                                        if not p10_0:getChild("LevelEndRoot") then
                                                                                                                            setGameOn(true)
                                                                                                                            setPhysicsEnabled(true)
                                                                                                                            if g_disableGameupdate then
                                                                                                                                g_disableGameupdate = false
                                                                                                                            end
                                                                                                                        end
                                                                                                                        p10_0.drawTarget = nil
                                                                                                                    else
                                                                                                                        local r10_97 = p10_1.id
                                                                                                                        local r10_98 = events.EID_OPEN_FREE_IOS_VERSION_POPUP
                                                                                                                        if r10_97 == r10_98 then
                                                                                                                            local r10_99 = GetFullVersionPage:new()
                                                                                                                            r10_99.openedFrom = p10_1.openedFrom
                                                                                                                            local r10_100 = eventManager
                                                                                                                            local r10_101 = {
                                                                                                                                id = events.EID_PUSH_FRAME,
                                                                                                                                target = r10_99
                                                                                                                            }
                                                                                                                            r10_100:notify(r10_101)
                                                                                                                            if isInGameMode() then
                                                                                                                                disableGameUpdate()
                                                                                                                            end
                                                                                                                        else
                                                                                                                            local r10_102 = p10_1.id
                                                                                                                            local r10_103 = events.EID_CLOSE_BUY_FREE_IOS_VERSION_POPUP
                                                                                                                            if r10_102 == r10_103 then
                                                                                                                                if isInGameMode() then
                                                                                                                                    enableGameUpdate()
                                                                                                                                end
                                                                                                                                eventManager:notify({
                                                                                                                                    id = events.EID_POP_FRAME
                                                                                                                                })
                                                                                                                            else
                                                                                                                                local r10_104 = p10_1.id
                                                                                                                                local r10_105 = events.EID_MAIN_MENU_ENTERED
                                                                                                                                if r10_104 ~= r10_105 then
                                                                                                                                    local r10_106 = p10_1.id
                                                                                                                                    local r10_107 = events.EID_SET_SLINGSHOT_GFX
                                                                                                                                    if r10_106 == r10_107 then
                                                                                                                                        p10_0:setSlingshotGfx(p10_1.front, p10_1.back, p10_1.rubberband, p10_1.holder)
                                                                                                                                    else
                                                                                                                                        local r10_108 = p10_1.id
                                                                                                                                        local r10_109 = events.EID_RESET_SLINGSHOT_GFX
                                                                                                                                        if r10_108 == r10_109 then
                                                                                                                                            p10_0:resetSlingshotGfx()
                                                                                                                                        else
                                                                                                                                            local r10_110 = p10_1.id
                                                                                                                                            local r10_111 = events.EID_LEVEL_FAILED
                                                                                                                                            if r10_110 == r10_111 then
                                                                                                                                                local r10_112 = getLevelMetadata(levelName)
                                                                                                                                                local r10_113 = r10_112.onLevelFailed
                                                                                                                                                if r10_113 then
                                                                                                                                                    fireAction(r10_113, {})
                                                                                                                                                end
                                                                                                                                            else
                                                                                                                                                local r10_114 = p10_1.id
                                                                                                                                                local r10_115 = events.EID_LEVEL_COMPLETED
                                                                                                                                                if r10_114 == r10_115 then
                                                                                                                                                    local r10_116 = getLevelMetadata(levelName)
                                                                                                                                                    local r10_117 = r10_116.onLevelComplete
                                                                                                                                                    if r10_117 then
                                                                                                                                                        fireAction(r10_117, {})
                                                                                                                                                    end
                                                                                                                                                end
                                                                                                                                            end
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                end
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- line 457-465
-- proto#11 params=2 locals=7 upvalues=0 vararg=false
function GameScene.setMainmenuItemsVisible(p11_0, p11_1)
    local r11_0 = p11_0:getChild("eagleButton")
    r11_0.visible = p11_1
    local r11_1 = p11_0:getChild("trailerButton")
    r11_1.visible = p11_1
    local r11_2 = p11_0:getChild("gameLogo")
    r11_2.visible = p11_1
    local r11_3 = p11_0:getChild("optionsSlider")
    r11_3.visible = p11_1
    local r11_4 = p11_0:getChild("optionsButton")
    r11_4.visible = p11_1
    local r11_5 = p11_0:getChild("optionsImage")
    r11_5.visible = p11_1
    local r11_6 = p11_0:getChild("playButton")
    r11_6.visible = p11_1
end

-- line 467-497
-- proto#12 params=2 locals=4 upvalues=0 vararg=false
function GameScene:checkForShowTutorial(p12_1)
    if p12_1 and queuedTutorials ~= nil and #queuedTutorials == 0 and self:getChild("AnimatedTutorial") ~= nil then
        eventManager:notify({ id = events.EID_POP_FRAME })
        setPhysicsEnabled(true)
        g_tutorialShowing = nil
        releaseImages({ "TUTORIALS" })
    end
    if queuedTutorials ~= nil then
        local r12_0 = #queuedTutorials
        if r12_0 > 0 then
            cameraFunction(0)
            setPhysicsEnabled(false)
            g_tutorialShowing = true
            if p12_1 then
                if self:getChild("AnimatedTutorial") ~= nil then
                    eventManager:notify({ id = events.EID_POP_FRAME })
                    local r12_1 = eventManager
                    local r12_2 = {
                        id = events.EID_PUSH_FRAME,
                        target = _G.table.remove(queuedTutorials, 1)
                    }
                    r12_1:notify(r12_2)
                end
            elseif self:getChild("AnimatedTutorial") == nil then
                local r12_3 = eventManager
                local r12_4 = {
                    id = events.EID_PUSH_FRAME,
                    target = _G.table.remove(queuedTutorials, 1)
                }
                r12_3:notify(r12_4)
            end
        end
    end
end

-- line 501-1423
-- proto#13 params=1 locals=819 upvalues=4 vararg=false
function GameScene:draw()
    if self.drawTarget then
        self.drawTarget:draw(0, 0)
        return
    end
    if g_showCameraDebugData then
        tempScreen = {}
        tempScreen.x = screen.x
        tempScreen.y = screen.y
        tempScreen.left = screen.left
        tempScreen.right = screen.right
        tempScreen.top = screen.top
        tempScreen.bottom = screen.bottom
        tempScreen.scale = worldScale
        local r13_0 = rightLimitWorld - leftLimitWorld
        screen.x = (rightLimitWorld + leftLimitWorld) * 0.5
        screen.y = (bottomLimitWorld + topLimitWorld) * 0.5
        local r13_1 = _G.math.min(screenWidth / r13_0, screenHeight / (bottomLimitWorld - topLimitWorld))
        worldScale = r13_1 * 0.8500000238418579
        setWorldScale(worldScale)
        defaultCamera(0)
    end
    local r13_2 = { r = 0, g = 0, b = 0 }
    if blockTable and blockTable.themes and objects and objects.theme and blockTable.themes[objects.theme] then
        local r13_3 = blockTable.themes[objects.theme]
        r13_2 = r13_3.skyColor
    end
    setBGColor(r13_2.r, r13_2.g, r13_2.b)
    setFont(getFontBasic())
    if showBG then
        drawBackgroundNative(g_layerDrawIndex or -1)
    else
        local r13_4 = -screen.left
        setRenderState(r13_4, -screen.top, worldScale, worldScale, 0)
        drawLine2D(screen.left, 0, screen.right, 0, 10, 255, 0, 0, 128)
    end
    if mightyEagleBGAlpha ~= nil then
        drawRect(0, 0, 0, mightyEagleBGAlpha, 0, 0, screenWidth, screenHeight, false)
    end
    if g_lineGravityVisualization and not getLevelMetadata(levelName).ignoreTutorial then
        for r13_5, r13_6 in _G.pairs(objects.sensorList.gravitation) do
            local r13_7, r13_8 = physicsToScreenTransform(r13_6.x, r13_6.y)
            renderGravityVisualsNative(r13_6, r13_7, r13_8, worldScale)
        end
    end
    local r13_9 = physicsToWorldTransform
    local r13_10 = rubberBandPos.x
    local r13_11, r13_12 = r13_9(r13_10 - 0.20000000298023224, rubberBandPos.y)
    local r13_13, r13_14 = physicsToWorldTransform(levelStartPosition.x, levelStartPosition.y)
    local r13_15, r13_16 = r13_11, r13_12
    if currentBirdName ~= nil and objects.world[currentBirdName] ~= nil then
        local r13_17 = objects.world[currentBirdName]
        if r13_17.type == "circle" then
            local r13_18 = objects.world[currentBirdName]
            local r13_19 = (r13_18.radius + 0.05000000074505806) * physicsToWorld
            local r13_20 = _G.math.cos(rubberBandAngle)
            r13_15 = r13_11 - r13_19 * r13_20
            local r13_21 = objects.world[currentBirdName]
            local r13_22 = (r13_21.radius + 0.05000000074505806) * physicsToWorld
            local r13_23 = _G.math.sin(rubberBandAngle)
            r13_16 = r13_12 - r13_22 * r13_23
        else
            local r13_24 = objects.world[currentBirdName]
            local r13_25 = (r13_24.width / 2 + 0.05000000074505806) * physicsToWorld
            local r13_26 = _G.math.cos(rubberBandAngle)
            r13_15 = r13_11 - r13_25 * r13_26
            local r13_27 = objects.world[currentBirdName]
            local r13_28 = (r13_27.width / 2 + 0.05000000074505806) * physicsToWorld
            local r13_29 = _G.math.sin(rubberBandAngle)
            r13_16 = r13_12 - r13_28 * r13_29
        end
        local r13_30 = physicsToScreenTransform
        local r13_31 = objects.world[currentBirdName]
        local r13_32 = r13_31.originalPosX
        local r13_33 = objects.world[currentBirdName]
        local r13_34, r13_35 = r13_30(r13_32, r13_33.originalPosY)
        local r13_36 = physicsToScreenTransform
        local r13_37 = objects.world[currentBirdName]
        local r13_38 = r13_37.x
        local r13_39 = objects.world[currentBirdName]
        local r13_40, r13_41 = r13_36(r13_38, r13_39.y)
        setRenderState(0, 0, 1, 1, 0, 0, 0)
    end
    if selectedBird == nil or selectedBird.shot then
        enableAimingAid(false)
        if streamEnabled == true then
            totalAimingTime = getAimingTime()
            streamEnabled = false
        end
        if not (flyingBird == nil or totalAimingTime == nil) then
            clearAimingAid(flightTime / totalAimingTime)
        end
    else
        enableAimingAid(true)
        streamEnabled = true
    end
    if flyingBird ~= nil and flyingBird.laserField ~= nil then
        local r13_42, r13_43 = "LASER_TRAIL_3", "LASER_EFFECT_1"
        local r13_44 = flyingBird.x
        local r13_45 = flyingBird.laserField.x
        local r13_46 = r13_44 - r13_45
        local r13_47 = flyingBird.y
        local r13_48 = flyingBird.laserField.y
        local r13_49 = r13_47 - r13_48
        local r13_50 = r13_46 * physicsToWorld
        local r13_51 = r13_49 * physicsToWorld
        local r13_52 = _G.math.atan2(r13_49, r13_46)
        local r13_53 = _G.math.pi
        local r13_54 = r13_52 / r13_53
        local r13_55, r13_56 = _G.res.getSpritePivot(r13_43)
        local r13_57 = r13_55 * worldScale
        local r13_58 = r13_56 * worldScale
        local r13_59 = physicsToScreenTransform
        local r13_60 = flyingBird.laserField.x
        local r13_61 = flyingBird.laserField
        local r13_62, r13_63 = r13_59(r13_60, r13_61.y)
        setRenderState(0, 0, worldScale, worldScale, 0, r13_57, r13_58)
        res.drawSprite(r13_43, r13_62 / worldScale, r13_63 / worldScale)
        local r13_64 = r13_62 - r13_57
        local r13_65 = r13_63 - r13_58
        local r13_66 = vLength(r13_50, r13_51)
        setRenderState(0, 0, worldScale, worldScale, r13_52)
        local r13_67, r13_68 = _G.res.getSpriteBounds(r13_42)
        local r13_69 = _G.res.getSpriteBounds
        local r13_70 = getObjectDefinition(flyingBird.name)
        local r13_71 = r13_70.sprites
        local r13_72, r13_73 = r13_69(r13_71.action)
        local r13_74 = r13_72 * worldScale
        local r13_75 = r13_73 * worldScale
        local r13_76 = r13_74 / 2
        local r13_77 = -(r13_75 / 2)
        local r13_78 = _G.math.sin(r13_52 - _G.math.pi / 2)
        local r13_79 = r13_77 * r13_78
        local r13_80 = -r13_76
        local r13_81 = _G.math.cos(r13_52 - _G.math.pi / 2)
        local r13_82 = r13_80 * r13_81
        local r13_83 = flyingBird.prevX or flyingBird.x
        local r13_84 = flyingBird.prevY or flyingBird.x
        local r13_85, r13_86 = physicsToScreenTransform(r13_83, r13_84)
        if flyingBird.hasCollided then
            local r13_87 = 0.10000000149011612
            if flyingBird.fadeEffectTimer == nil then
                flyingBird.fadeEffectTimer = r13_87
            end
            local r13_88 = flyingBird.fadeEffectTimer
            if r13_88 >= 0 then
                res.drawSprite(r13_42, (r13_85 - r13_82) / worldScale, (r13_86 - r13_79) / worldScale, "HCENTER", "VCENTER", -r13_66 * (flyingBird.fadeEffectTimer / r13_87), r13_73)
            end
        else
            res.drawSprite(r13_42, (r13_85 - r13_82) / worldScale, (r13_86 - r13_79) / worldScale, "HCENTER", "VCENTER", -r13_66, r13_73)
        end
    end
    local r13_89 = 50 / rubberBandLength
    local r13_90 = r13_89 > 25 and 25 or r13_89
    local r13_91 = r13_90 < 10 and 10 or r13_90
    local r13_92 = -screen.left
    setRenderState(r13_92, -screen.top, worldScale, worldScale, 0)
    local r13_93 = getLevelMetadata(levelName)
    if not r13_93.hideBirdsAndSlingshot then
        setRenderState(-screen.left, -screen.top, worldScale, worldScale, slingShotAngle, res.getSpritePivot(r0_5))
        res.drawSprite(r0_5, r13_13, r13_14)
    end
    local r13_94 = _G.math.cos(slingShotAngle)
    local r13_95 = r13_13 + 20 * r13_94
    local r13_96 = _G.math.sin(slingShotAngle)
    local r13_97 = r13_14 + 20 * r13_96
    local r13_98 = _G.math.cos(slingShotAngle)
    local r13_99 = r13_13 - 21 * r13_98
    local r13_100 = _G.math.sin(slingShotAngle)
    local r13_101 = r13_14 - 23 * r13_100
    local r13_102 = getLevelMetadata(levelName)
    if not r13_102.hideBirdsAndSlingshot then
        setRenderState(0, 0, 1, 1, 0, 0, 0)
        if deviceModel == "android" then
            drawRubberband((r13_95 - screen.left) * worldScale, (r13_97 - screen.top) * worldScale, (r13_15 - screen.left) * worldScale, (r13_16 - screen.top) * worldScale, r13_91 * worldScale, r0_6)
        else
            drawTexturedLine2D(r0_6, (r13_95 - screen.left) * worldScale, (r13_97 - screen.top) * worldScale, (r13_15 - screen.left) * worldScale, (r13_16 - screen.top) * worldScale, r13_91 * worldScale, 255, 255, 255, 255)
        end
    end
    local r13_103 = -screen.left
    setRenderState(r13_103, -screen.top, worldScale, worldScale, 0, 0, 0)
    if selectedBird == nil and not getLevelMetadata(levelName).hideBirdsAndSlingshot then
        res.drawSprite(r0_7, r13_15, r13_16)
    end
    local r13_104 = {}
    for r13_105, r13_106 in _G.pairs(objects.world) do
        if r13_106.isAffectedByForceTimer ~= nil then
            local r13_107 = r13_106.isAffectedByForceTimer
            if r13_107 > 0 then
                local r13_108, r13_109 = physicsToScreenTransform(r13_106.x, r13_106.y)
                local r13_110 = SettingsWrapper:getBirdLevel("BlackBird") == 3 and "FORCE_GLOW_GREEN_CIRCLE_L" or "FORCE_GLOW_BLUE_CIRCLE_L"
                local r13_111 = blockTable.blocks[r13_106.definition]
                local r13_112 = r13_111.definitionAffectedByForce or r13_110
                local r13_113 = r13_106.gravityFilterCategory
                local r13_114
                if r13_106.isAffectedByForceGlowColor then
                    r13_114 = _G.string.gsub(r13_112, "BLUE", r13_106.isAffectedByForceGlowColor)
                else
                    r13_114 = r13_112
                end
                if r13_114 ~= nil then
                    local r13_115 = blockTable.blocks[r13_106.definition]
                    local r13_116 = r13_115.scale or 1
                    local r13_117 = blockTable.blocks[r13_106.definition]
                    local r13_118 = r13_117.glowScale
                    local r13_119 = r13_116 * (r13_118 or 1) * worldScale
                    local r13_120 = r13_119 + 0.10000000149011612
                    local r13_121 = r13_106.isAffectedByForceTimer * 4
                    local r13_122 = _G.math.cos(r13_121 % (_G.math.pi * 2))
                    local r13_123 = r13_120 - r13_122 * (r13_119 * 0.10000000149011612)
                    local r13_124 = blockTable.blocks[r13_106.definition]
                    local r13_125 = r13_106.angle + (r13_124.glowRotation or 0) * _G.math.pi * 2 / 360
                    local r13_126, r13_127 = res.getSpritePivot(r13_114)
                    local r13_128 = _G.math.min(r13_106.isAffectedByForceTimer / forceGlowFadeTimer, 1)
                    setRenderState(r13_108 / r13_123, r13_109 / r13_123, r13_123, r13_123, r13_125, r13_126, r13_127, r13_128)
                    _G.res.drawSprite(r13_114, 0, 0)
                end
            end
        end
        if r13_106.gravityFilterCategory and (r13_106.gravityFilterCategory == "FORCE_OBJECT" or r13_106.gravityFilterCategory == "YODA_FORCE_OBJECT") or r13_106.isHeldByForceTimer ~= nil and r13_106.isHeldByForceTimer > 0 then
            local r13_129, r13_130 = physicsToScreenTransform(r13_106.x, r13_106.y)
            local r13_131 = r13_106.gravityFilterCategory == "YODA_FORCE_OBJECT" and true or r13_106.yodaForce
            local r13_132 = blockTable.blocks[r13_106.definition]
            local r13_133 = r13_132.definitionHeldByForce or "FORCE_GLOW_RED_CIRCLE_L"
            local r13_134
            if r13_131 then
                local r13_135 = blockTable.blocks[r13_106.definition]
                local r13_136 = r13_135.definitionHeldByYodaForce
                if r13_136 then
                    r13_134 = r13_136
                else
                    r13_134 = "FORCE_GLOW_GREEN_CIRCLE_L"
                end
                objects.world[r13_105].yodaForce = true
            end
            if r13_134 ~= nil then
                local r13_137 = r13_106.glowScale
                if not r13_137 then
                    local r13_138
                    r13_137 = r13_138.glowScale
                end
                local r13_139 = blockTable.blocks[r13_106.definition]
                local r13_140 = r13_139.scale or 1
                local r13_141 = r13_137 or 1
                local r13_142 = r13_140 * r13_141 * worldScale
                local r13_143 = r13_142 + 0.10000000149011612
                local r13_144 = self.heldByForceTimer * 2
                local r13_145 = _G.math.cos(r13_144 % (_G.math.pi * 2))
                local r13_146 = r13_143 - r13_145 * (r13_142 * 0.10000000149011612)
                local r13_147 = blockTable.blocks[r13_106.definition]
                local r13_148 = r13_106.angle + (r13_147.glowRotation or 0) * _G.math.pi * 2 / 360
                local r13_149, r13_150 = res.getSpritePivot(r13_134)
                local r13_151 = 1
                if r13_106.isHeldByForceTimer ~= nil then
                    local r13_152 = r13_106.isHeldByForceTimer
                    if r13_152 > 0 then
                        local r13_153 = _G.math.min
                        local r13_154 = r13_106.isHeldByForceTimer
                        r13_151 = r13_153(r13_154 / forceGlowFadeTimer, 1)
                    end
                end
                setRenderState(r13_129 / r13_146, r13_130 / r13_146, r13_146, r13_146, r13_148, r13_149, r13_150, r13_151)
                _G.res.drawSprite(r13_134, 0, 0)
            end
        end
        if isInGameMode() and r13_106.levelGoal and g_showTargetVisualizationTimer and g_targetVisualizationRelativeTime then
            _G.table.insert(r13_104, r13_106)
        end
    end
    for r13_155, r13_156 in _G.pairs(objects.world) do
        if r13_156 ~= nil and (r13_156.inBubble or r13_156.bubblePrimaryTarget) then
            if r13_156.reticleName or r13_156.controllable then
                local r13_157
                if r13_156.reticleName then
                    r13_157 = objects.world[r13_156.reticleName]
                else
                    r13_157 = r13_156
                end
                if r13_157 then
                    local r13_158 = blockTable.blocks[r13_157.definition]
                    setRenderState(0, 0, 1, 1, 0, 0, 0)
                    local r13_159, r13_160 = physicsToWorldTransform(r13_157.x, r13_157.y)
                    local r13_161, r13_162 = nil, nil
                    local r13_163
                    local r13_164
                    if r13_156.bubbleBeamTimer then
                        if r13_156.bubbleBeamPhase == 1 then
                            if r13_156.bubblePrimaryTarget then
                                local r13_165, r13_166 = physicsToWorldTransform(r13_156.bubbleActivationX - (r13_156.bubbleActivationX - r13_157.x) * (r13_156.bubbleBeamTimer / r13_158.specialtyBeamPhase1Time), r13_156.bubbleActivationY - (r13_156.bubbleActivationY - r13_157.y) * (r13_156.bubbleBeamTimer / r13_158.specialtyBeamPhase1Time))
                                local r13_167 = r13_166
                                r13_163 = r13_165
                                r13_164 = r13_167
                            else
                                r13_163 = r13_161
                                r13_164 = r13_162
                            end
                        else
                            local r13_168, r13_169 = physicsToWorldTransform(r13_156.x - (r13_156.x - r13_156.bubbleActivationX) * (r13_156.bubbleBeamTimer / r13_158.specialtyBeamPhase2Time), r13_156.y - (r13_156.y - r13_156.bubbleActivationY) * (r13_156.bubbleBeamTimer / r13_158.specialtyBeamPhase2Time))
                            local r13_170 = r13_169
                            r13_163 = r13_168
                            r13_164 = r13_170
                        end
                    else
                        local r13_171, r13_172 = physicsToWorldTransform(r13_156.x, r13_156.y)
                        local r13_173 = r13_172
                        r13_163 = r13_171
                        r13_164 = r13_173
                    end
                    if r13_163 then
                        drawTexturedLine2D(r13_158.specialtyBeamLineTexturePrefix .. r13_156.bubbleBeamAnimationFrame, (r13_159 - screen.left) * worldScale, (r13_160 - screen.top) * worldScale, (r13_163 - screen.left) * worldScale, (r13_164 - screen.top) * worldScale, 40 * worldScale, 255, 255, 255, 255)
                    end
                end
            end
            if r13_156.bubbleAntiGravityTimer then
                local r13_174 = r13_156.bubbleAntiGravityTimer
                if r13_174 > 0 then
                    local r13_175, r13_176 = physicsToScreenTransform(r13_156.x, r13_156.y)
                    local r13_177 = blockTable.blocks[r13_156.definition]
                    local r13_178 = r13_177.definitionLiftedByLeia
                    if not r13_178 then
                        r13_178 = "FORCE_GLOW_PINK_CIRCLE_L"
                    end
                    if r13_178 ~= nil then
                        local r13_179 = blockTable.blocks[r13_156.definition]
                        local r13_180 = r13_179.scale or 1
                        local r13_181 = blockTable.blocks[r13_156.definition]
                        local r13_182 = r13_181.glowScale
                        local r13_183 = r13_180 * (r13_182 or 1) * worldScale
                        local r13_184 = r13_183 + 0.10000000149011612
                        local r13_185 = r13_156.bubbleAntiGravityTimer * 4
                        local r13_186 = _G.math.cos(r13_185 % (_G.math.pi * 2))
                        local r13_187 = r13_184 - r13_186 * (r13_183 * 0.10000000149011612)
                        local r13_188 = blockTable.blocks[r13_156.definition]
                        local r13_189 = r13_156.angle + (r13_188.glowRotation or 0) * _G.math.pi * 2 / 360
                        local r13_190, r13_191 = res.getSpritePivot(r13_178)
                        local r13_192 = _G.math.min(r13_156.bubbleAntiGravityTimer / forceGlowFadeTimer, 1)
                        setRenderState(r13_175 / r13_187, r13_176 / r13_187, r13_187, r13_187, r13_189, r13_190, r13_191, r13_192)
                        _G.res.drawSprite(r13_178, 0, 0)
                    end
                end
            end
        end
    end
    if PowerupManager then
        PowerupManager:preDraw()
    end
    local r13_193 = -screen.left
    setRenderState(r13_193, -screen.top, worldScale, worldScale, 0)
    if g_layerDrawIndex == nil or g_layerDrawIndex == -1 then
        native_drawBackgroundParticles()
        drawGameNative(150)
        native_drawSimulationTrajectory()
        native_drawForegroundParticles()
    end
    if PowerupManager then
        PowerupManager:draw()
    end
    if forceLightningObjects and #forceLightningObjects > 0 then
        for r13_194, r13_195 in _G.ipairs(forceLightningObjects) do
            local r13_196 = r13_195.lightningSource
            if r13_196 then
                actions.drawLightning(r13_196.x, r13_196.y, r13_195.x, r13_195.y)
            end
        end
    end
    for r13_197, r13_198 in _G.ipairs(r13_104) do
        local r13_199, r13_200 = physicsToScreenTransform(r13_198.x, r13_198.y)
        local r13_201 = blockTable.blocks[r13_198.definition]
        local r13_202 = (r13_201.scale or 1) * worldScale * g_targetVisualizationEffectSpriteScale * (1 - (1 - g_targetVisualizationRelativeTime) * g_targetVisualizationEffectScale)
        local r13_203 = blockTable.blocks[r13_198.definition]
        local r13_204 = r13_203.targetVisualizationDefaultSprites
        if not r13_204 then
            r13_204 = g_targetVisualizationDefaultSprites
        end
        local r13_205 = _G.math.floor(g_targetVisualizationRelativeTime * #r13_204) + 1
        local r13_206 = _G.math.min(r13_205, #r13_204)
        local r13_207 = _G.math.max(r13_206, 1)
        local r13_208, r13_209 = res.getSpritePivot(r13_204[r13_207])
        setRenderState(r13_199 / r13_202, r13_200 / r13_202, r13_202, r13_202, r13_198.angle, r13_208, r13_209)
        if not r13_198.targetVisualDisabled then
            _G.res.drawSprite(r13_204[r13_207], 0, 0)
        end
    end
    if mightyEagleFlashAlpha ~= nil then
        drawRect(1, 1, 1, mightyEagleFlashAlpha, 0, 0, screenWidth, screenHeight, false)
    end
    for r13_210, r13_211 in _G.pairs(objects.decorationObjects) do
        local r13_212 = objects.world[r13_210]
        if r13_212 == nil then
            objects.decorationObjects[r13_210] = nil
        else
            local r13_213 = getObjectDefinition(r13_210)
            local r13_214 = r13_213.decorations.amount or 1
            local r13_215 = r13_212.angle
            local r13_216 = (r13_213.decorations.angleIncrement or 0) * _G.math.pi / 180
            for r13_217 = 1, r13_214 do
                for r13_218, r13_219 in _G.pairs(r13_213.decorations.objects) do
                    local r13_220 = r13_219.scale * worldScale
                    local r13_221 = physicsToScreenTransform
                    local r13_222 = r13_212.x
                    local r13_223 = r13_219.posX
                    local r13_224 = r13_222 + r13_223
                    local r13_225 = r13_212.y
                    local r13_226 = r13_219.posY
                    local r13_227, r13_228 = r13_221(r13_224, r13_225 + r13_226)
                    setRenderState(r13_227 / r13_220, r13_228 / r13_220, r13_220, r13_220, r13_215, res.getSpritePivot(r13_219.sprite))
                    res.drawSprite(r13_219.sprite, 0, 0)
                end
                r13_215 = r13_215 + r13_216
            end
        end
    end
    if not (flyingBird == nil or flyingBird.boostAim == nil) then
        local r13_229 = physicsToScreenTransform
        local r13_230 = flyingBird.boostAim.x
        local r13_231 = flyingBird.boostAim
        local r13_232, r13_233 = r13_229(r13_230, r13_231.y)
        local r13_234 = worldScale * 2
        setRenderState(r13_232 / r13_234, r13_233 / r13_234, r13_234, r13_234, 0, 0, 0)
        _G.res.drawSprite(flyingBird.boostAim.sprite, 0, 0)
        setRenderState(0, 0, 1, 1, 0, 0, 0)
    end
    for r13_235, r13_236 in _G.pairs(BHTrajectory) do
        local r13_237, r13_238 = physicsToScreenTransform(r13_236.x, r13_236.y)
        local r13_239 = (worldScale + 0.5) * r13_236.timer * 2
        setRenderState(r13_237 / r13_239, r13_238 / r13_239, r13_239, r13_239, 0, 0, 0)
        _G.res.drawSprite("TRAIL_BLACK_HOLE_BIRD", 0, 0)
        setRenderState(0, 0, 1, 1, 0, 0, 0)
    end
    if freezingObjects ~= nil then
        for r13_240, r13_241 in _G.pairs(freezingObjects.objects) do
            local r13_242 = objects.world[r13_240]
            if r13_242 ~= nil then
                for r13_243, r13_244 in _G.pairs(r13_241.icicles) do
                    local r13_245 = worldToPhysicsTransform
                    local r13_246 = res.getSpriteBounds
                    local r13_247, r13_248 = r13_245(r13_246(r13_242.sprite))
                    local r13_249 = blockTable.blocks[r13_242.definition]
                    local r13_250
                    local r13_251
                    if r13_249.type == "circle" then
                        local r13_252 = blockTable.blocks[r13_242.definition]
                        if r13_252.radius == nil then
                            r13_250 = r13_247
                            r13_251 = r13_248
                        else
                            local r13_253 = blockTable.blocks[r13_242.definition]
                            local r13_254 = r13_253.radius
                            local r13_255 = blockTable.blocks[r13_242.definition]
                            local r13_256 = r13_255.radius
                            r13_250 = r13_254
                            r13_251 = r13_256
                        end
                    else
                        r13_250 = r13_247
                        r13_251 = r13_248
                    end
                    local r13_257 = r13_244.dm
                    local r13_258 = r13_250 * r13_257
                    local r13_259 = _G.math.cos(r13_242.angle)
                    local r13_260 = r13_258 * r13_259
                    local r13_261 = r13_251 * 0.5
                    local r13_262 = _G.math.sin(r13_242.angle)
                    local r13_263 = r13_260 + r13_261 * r13_262
                    local r13_264 = -r13_251 * 0.5
                    local r13_265 = _G.math.cos(r13_242.angle)
                    local r13_266 = r13_264 * r13_265
                    local r13_267 = r13_244.dm
                    local r13_268 = r13_250 * r13_267
                    local r13_269 = _G.math.sin(r13_242.angle)
                    local r13_270 = r13_266 + r13_268 * r13_269
                    local r13_271 = worldScale * 2
                    if r13_244.side then
                        local r13_272, r13_273 = physicsToScreenTransform(r13_242.x - r13_263, r13_242.y - r13_270)
                        setRenderState(r13_272 / r13_271, r13_273 / r13_271, r13_271, r13_271, r13_242.angle - _G.math.pi, res.getSpritePivot(r13_244.sprite))
                        _G.res.drawSprite(r13_244.sprite, 0, 0)
                    else
                        local r13_274, r13_275 = physicsToScreenTransform(r13_242.x + r13_263, r13_242.y + r13_270)
                        setRenderState(r13_274 / r13_271, r13_275 / r13_271, r13_271, r13_271, r13_242.angle, res.getSpritePivot(r13_244.sprite))
                        _G.res.drawSprite(r13_244.sprite, 0, 0)
                    end
                end
            end
        end
    end
    local r13_276 = getLevelMetadata(levelName)
    if not r13_276.hideBirdsAndSlingshot and selectedBird ~= nil then
        setRenderState(0, 0, 1, 1, 0, 0, 0)
        if deviceModel == "android" then
            drawRubberband((r13_99 - screen.left) * worldScale, (r13_101 - screen.top) * worldScale, (r13_15 - screen.left) * worldScale, (r13_16 - screen.top) * worldScale, r13_91 * worldScale, r0_6)
        else
            drawTexturedLine2D(r0_6, (r13_99 - screen.left) * worldScale, (r13_101 - screen.top) * worldScale, (r13_15 - screen.left) * worldScale, (r13_16 - screen.top) * worldScale, r13_91 * worldScale, 255, 255, 255, 255)
        end
    end
    local r13_277 = -screen.left
    setRenderState(r13_277, -screen.top, worldScale, worldScale, 0, 0, 0)
    if selectedBird ~= nil then
        setRenderState(-screen.left, -screen.top, worldScale, worldScale, rubberBandAngle, res.getSpritePivot(r0_7))
        local r13_278 = getLevelMetadata(levelName)
        if not r13_278.hideBirdsAndSlingshot then
            res.drawSprite(r0_7, r13_15, r13_16)
        end
    end
    setRenderState(-screen.left, -screen.top, worldScale, worldScale, slingShotAngle, res.getSpritePivot(r0_4))
    local r13_279 = getLevelMetadata(levelName)
    if not r13_279.hideBirdsAndSlingshot then
        res.drawSprite(r0_4, r13_13, r13_14)
    end
    setRenderState(0, 0, 1, 1, 0)
    if showSleepingObjects then
        for r13_280, r13_281 in _G.pairs(objects.world) do
            if r13_281.sleeping == true and r13_281.sprite ~= "" and r13_281.sprite ~= nil then
                local r13_282, r13_283 = res.getSpriteBounds(r13_281.sprite)
                local r13_284 = r13_283
                local r13_285 = r13_282 * 0.5
                local r13_286 = r13_284 * 0.5
                local r13_287, r13_288 = physicsToWorldTransform(r13_281.x, r13_281.y)
                local r13_289 = r13_287 - r13_285
                local r13_290 = r13_288 - r13_286
                local r13_291 = r13_287 + r13_285
                local r13_292 = r13_288 + r13_286
                local r13_293 = -screen.left
                setRenderState(r13_293, -screen.top, worldScale, worldScale, r13_281.angle, r13_281.spritePivotX, r13_281.spritePivotY)
                drawRect(1, 0, 0, 0.5, r13_289, r13_290, r13_291, r13_292, true)
            end
        end
        if showEditor then
            EditorUtils.drawCollisionAreas()
        end
    end
    for r13_294, r13_295 in _G.pairs(objects.sensorList.stream) do
        if r13_295.sensorType == "stream" then
            local r13_296 = r13_295.nodes
            local r13_297 = #r13_296
            if r13_297 > 0 then
                local r13_298 = physicsToScreenTransform
                local r13_299 = r13_295.x
                local r13_300 = r13_295.nodes[1].x
                local r13_301 = r13_299 + r13_300
                local r13_302 = r13_295.y
                local r13_303 = r13_295.nodes[1].y
                local r13_304, r13_305 = r13_298(r13_301, r13_302 + r13_303)
                res.drawSprite("TRAIL_WHITE_1", r13_304, r13_305)
                for r13_306 = 2, #r13_296 do
                    local r13_307 = r13_295.nodes[r13_306]
                    local r13_308 = physicsToScreenTransform
                    local r13_309 = r13_295.x
                    local r13_310 = r13_307.x
                    local r13_311 = r13_309 + r13_310
                    local r13_312 = r13_295.y
                    local r13_313 = r13_307.y
                    local r13_314, r13_315 = r13_308(r13_311, r13_312 + r13_313)
                    local r13_316 = physicsToScreenTransform
                    local r13_317 = r13_295.x
                    local r13_318 = r13_307.x
                    local r13_319 = r13_317 + r13_318
                    local r13_320 = r13_295.y
                    local r13_321 = r13_307.y
                    local r13_322, r13_323 = r13_316(r13_319, r13_320 + r13_321)
                    res.drawSprite("TRAIL_WHITE_1", r13_322, r13_323)
                end
            end
            local r13_324 = r13_295.vertices
            local r13_325 = #r13_324
            if r13_325 > 0 then
                local r13_326 = physicsToScreenTransform
                local r13_327 = r13_295.x
                local r13_328 = r13_295.vertices[1].x
                local r13_329 = r13_327 + r13_328
                local r13_330 = r13_295.y
                local r13_331 = r13_295.vertices[1].y
                local r13_332, r13_333 = r13_326(r13_329, r13_330 + r13_331)
                local r13_334 = r13_332
                local r13_335 = r13_333
                for r13_336 = 2, #r13_324 do
                    local r13_337 = r13_295.vertices[r13_336]
                    local r13_338 = physicsToScreenTransform
                    local r13_339 = r13_295.x
                    local r13_340 = r13_337.x
                    local r13_341 = r13_339 + r13_340
                    local r13_342 = r13_295.y
                    local r13_343 = r13_337.y
                    local r13_344, r13_345 = r13_338(r13_341, r13_342 + r13_343)
                    drawLine2D(r13_334, r13_335, r13_344, r13_345, 3, 255, 255, 255, 255)
                    local r13_346 = physicsToScreenTransform
                    local r13_347 = r13_295.x
                    local r13_348 = r13_337.x
                    local r13_349 = r13_347 + r13_348
                    local r13_350 = r13_295.y
                    local r13_351 = r13_337.y
                    local r13_352, r13_353 = r13_346(r13_349, r13_350 + r13_351)
                    r13_335 = r13_353
                    r13_334 = r13_352
                end
            end
        end
    end
    local r13_354 = 1
    local r13_355 = { { x = 0, y = 0 }, { x = 0, y = 0 }, { x = 0, y = 0 }, { x = 0, y = 0 } }
    for r13_356, r13_357 in _G.pairs(aimingTrail) do
        local r13_358, r13_359 = physicsToScreenTransform(r13_357.x, r13_357.y)
        print([[
 auei ]] .. r13_358 .. " " .. r13_359)
        res.drawSprite("TRAIL_WHITE_1", r13_358, r13_359)
        if r13_354 < 5 then
            local r13_360 = r13_355[r13_354]
            local r13_361 = r13_355[r13_354]
            local r13_362, r13_363 = physicsToWorldTransform(r13_357.x, r13_357.y)
            r13_361.y = r13_363
            r13_360.x = r13_362
            r13_354 = r13_354 + 1
        end
    end
    for r13_364, r13_365 in _G.pairs(objects.joints) do
        if r13_365.isDrawn and (r13_365.type == 2 or r13_365.type == 3) then
            local r13_366 = { [2] = "BLOCK_JOINT_01", [3] = "BLOCK_JOINT_01" }
            local r13_367, r13_368, r13_369, r13_370 = getJointAnchorPositions(r13_365)
            r13_365.jointPosX = (r13_367 + r13_368) * 0.5
            r13_365.jointPosY = (r13_369 + r13_370) * 0.5
            local r13_371, r13_372 = physicsToScreenTransform(r13_365.jointPosX, r13_365.jointPosY)
            local r13_373, r13_374 = res.getSpritePivot(r13_366[r13_365.type])
            local r13_375 = _G.math.atan2(r13_369 - r13_370, r13_367 - r13_368)
            local r13_376 = worldScale * gameWorldScale
            setRenderState(r13_371 / r13_376, r13_372 / r13_376, r13_376, r13_376, r13_375 + _G.math.pi / 2, r13_373, r13_374, 1)
            res.drawSprite(r13_366[r13_365.type], 0, 0)
        end
    end
    for r13_377, r13_378 in _G.pairs(objects.sensorList.killing) do
        local r13_379, r13_380 = r13_378.width, worldScale
        local r13_381, r13_382 = physicsToScreenTransform(r13_378.x, r13_378.y)
        setRenderState(r13_381 / r13_380, r13_382 / r13_380, r13_380, r13_380, 0, 0, 0)
        local r13_383 = physicsToWorldTransform
        local r13_384 = r13_378.width * 0.5
        local r13_385 = r13_378.height
        local r13_386, r13_387 = r13_383(r13_384, r13_385 * 0.5)
        drawLine2D(-r13_386, -r13_387, -r13_386, r13_387, 2, 255, 255, 255, 255)
        drawLine2D(-r13_386, r13_387, r13_386, r13_387, 2, 255, 255, 255, 255)
        drawLine2D(r13_386, r13_387, r13_386, -r13_387, 2, 255, 255, 255, 255)
        drawLine2D(r13_386, -r13_387, -r13_386, -r13_387, 2, 255, 255, 255, 255)
    end
    local r13_388 = getLevelMetadata(levelName)
    if not r13_388.ignoreTutorial then
        for r13_389, r13_390 in _G.pairs(objects.sensorList.gravitation) do
            if r13_390.sensorType == "gravitation" and r13_390.active then
                drawGravityBubble(r13_390)
            end
        end
    end
    setRenderState(0, 0, 1, 1, 0)
    oldZoomLevel = zoomLevel
    for r13_391, r13_392 in _G.pairs(objects.spriteObjects) do
        local r13_393 = r13_392.x
        local r13_394 = r13_392.y
        if r13_392.guiObject == true then
            setRenderState(r13_392.x / r13_392.scaleX, r13_392.y / r13_392.scaleY, r13_392.scaleX, r13_392.scaleY, r13_392.angle, res.getSpritePivot(r13_392.sprite))
        else
            local r13_395, r13_396 = worldToScreenTransform(r13_392.x, r13_392.y)
            local r13_397, r13_398, r13_399, r13_400 = r13_396, r13_395, worldScale, r13_392.scaleX
            local r13_401 = r13_399 * r13_400
            local r13_402, r13_403 = worldScale, r13_392.scaleY
            local r13_404 = r13_402 * r13_403
            local r13_405 = r13_392.angle
            if r13_392.scaleXAdd ~= nil then
                local r13_406, r13_407
                r13_401 = r13_399 * r13_400 + r13_406 * r13_407
            end
            if r13_392.scaleYAdd ~= nil then
                local r13_408, r13_409
                r13_404 = r13_402 * r13_403 + r13_408 * r13_409
            end
            local r13_410
            if r13_392.angleAdd == nil then
                r13_410 = r13_405
            else
                local r13_411 = r13_392.angleAdd
                r13_410 = r13_405 + r13_411
            end
            setRenderState(r13_398 / r13_401, r13_397 / r13_404, r13_401, r13_404, r13_410, res.getSpritePivot(r13_392.sprite))
        end
        if r13_392.textObject then
            res.drawString("TEXT_BASIC", "DEBUG_TEXT", 0, 0, "BOTTOM", "HCENTER")
        else
            _G.res.drawSprite(r13_392.sprite, 0, 0)
        end
        setRenderState(0, 0, 1, 1, 0, 0, 0)
    end
    for r13_412, r13_413 in _G.pairs(objects.buttonObjects) do
        r13_414 = r13_413.x
        r13_415 = r13_413.y
        if r13_413.guiObject == true then
            setRenderState(r13_413.x / r13_413.scaleX, r13_413.y / r13_413.scaleY, r13_413.scaleX, r13_413.scaleY, r13_413.angle, res.getSpritePivot(r13_413.sprite))
        else
            local r13_416, r13_417 = worldToScreenTransform(r13_413.x, r13_413.y)
            local r13_418, r13_419, r13_420, r13_421 = r13_417, r13_416, worldScale, r13_413.scaleX
            local r13_422 = r13_420 * r13_421
            local r13_423, r13_424 = worldScale, r13_413.scaleY
            local r13_425 = r13_423 * r13_424
            local r13_426 = r13_413.angle
            if r13_413.scaleXAdd ~= nil then
                local r13_427, r13_428
                r13_422 = r13_420 * r13_421 + r13_427 * r13_428
            end
            if r13_413.scaleYAdd ~= nil then
                local r13_429, r13_430
                r13_425 = r13_423 * r13_424 + r13_429 * r13_430
            end
            local r13_431
            if r13_413.angleAdd == nil then
                r13_431 = r13_426
            else
                local r13_432 = r13_413.angleAdd
                r13_431 = r13_426 + r13_432
            end
            setRenderState(r13_419 / r13_422, r13_418 / r13_425, r13_422, r13_425, r13_431, res.getSpritePivot(r13_413.sprite))
        end
        _G.res.drawSprite(r13_413.sprite, 0, 0)
        setRenderState(0, 0, 1, 1, 0, 0, 0)
    end
    if popupPage ~= nil then
        drawMenuPage(popupPage)
    end
    if g_explodingBomb then
        setRenderState(0, 0, 1, 1, 0)
        for r13_433, r13_434 in _G.pairs(g_objectsInExplosionRadius) do
            if not (r13_434.definition == nil or r13_434.definition == "") then
                local r13_435 = res.getSpriteBounds
                local r13_436 = blockTable.blocks[r13_434.definition]
                local r13_437, r13_438 = r13_435(r13_436.sprite)
                local r13_439 = r13_437 * 0.5
                local r13_440 = r13_438 * 0.5
                local r13_441, r13_442 = physicsToWorldTransform(r13_434.x, r13_434.y)
                local r13_443 = r13_441 - r13_439
                local r13_444 = r13_442 - r13_440
                local r13_445 = r13_441 + r13_439
                local r13_446 = r13_442 + r13_440
                local r13_447 = res.getSpritePivot
                local r13_448 = blockTable.blocks[r13_434.definition]
                local r13_449, r13_450 = r13_447(r13_448.sprite)
                local r13_451 = -screen.left
                setRenderState(r13_451, -screen.top, worldScale, worldScale, r13_434.angle, r13_449, r13_450)
                drawRect(1, 1, 0, 0.30000001192092896, r13_443, r13_444, r13_445, r13_446, true)
            end
        end
        local r13_452 = -screen.left
        setRenderState(r13_452, -screen.top, worldScale, worldScale, 0, 0, 0)
        local r13_453, r13_454 = physicsToWorldTransform(g_explosionX, g_explosionY)
        local r13_455 = 0
        for r13_456, r13_457 in _G.pairs(objects.world) do
            if g_allObjectsDistanceToPoint[r13_456] ~= nil then
                local r13_458 = r13_457.x - g_explosionX
                local r13_459 = r13_457.y - g_explosionY
                local r13_460 = vLength(r13_458, r13_459)
                local r13_461 = g_allObjectsDistanceToPoint[r13_456].distance
                local r13_462 = r13_461 / r13_460
                local r13_463 = physicsToWorldTransform
                local r13_464 = g_allObjectsDistanceToPoint[r13_456].distance
                local r13_465 = g_allObjectsDistanceToPoint[r13_456]
                local r13_466, r13_467 = r13_463(r13_464, r13_465.distance)
                local r13_468 = g_explosionX + r13_458 * r13_462
                local r13_469 = g_explosionY + r13_459 * r13_462
                local r13_470, r13_471 = physicsToWorldTransform(g_explosionX, g_explosionY)
                local r13_472 = r13_471
                local r13_473 = r13_470
                local r13_474, r13_475 = physicsToWorldTransform(r13_468, r13_469)
                local r13_476, r13_477 = physicsToWorldTransform(r13_457.x, r13_457.y)
                local r13_478 = 5
                local r13_479 = physicsToWorldTransform
                local r13_480 = g_allObjectsDistanceToPoint[r13_456].pointX
                local r13_481 = g_allObjectsDistanceToPoint[r13_456]
                local r13_482, r13_483 = r13_479(r13_480, r13_481.pointY)
                drawLine2D(r13_473, r13_472, r13_476, r13_477, 4, 0, 0, 255, 255)
                drawRect(1, 0, 0, 1, r13_482 - r13_478, r13_483 - r13_478, r13_482 + r13_478, r13_483 + r13_478, true)
                r13_455 = r13_455 + 1
            end
        end
        setRenderState(0, 0, 1, 1, 0)
    end
    local r13_484 = screenWidth * 0.4000000059604645
    local r13_485 = screenHeight * 0.25
    setRenderState(0, 0, 0.20000000298023224, 0.20000000298023224, 0)
    if g_showCameraDebugData then
        local r13_486 = originalCameras[currentCamera + 1]
        local r13_487 = originalCameras[currentCamera + 2]
        local r13_488 = screenWidth * 0.5
        local r13_489 = tempScreen.scale
        local r13_490 = r13_488 / r13_489
        local r13_491 = screenHeight * 0.5
        local r13_492 = tempScreen.scale
        local r13_493 = r13_491 / r13_492
        local r13_494 = -screen.left
        setRenderState(r13_494, -screen.top, worldScale, worldScale, 0, 0, 0)
        drawLine2D(r13_486.px, r13_486.py, r13_487.px, r13_487.py, 3, 148, 123, 38, 255)
        local r13_495 = animationScreen.y - 15
        drawLine2D(animationScreen.x, r13_495, animationScreen.x, animationScreen.y + 15, 3, 148, 123, 38, 255)
        local r13_496 = r13_486.px
        local r13_497 = r13_487.px
        local r13_498 = r13_486.px
        local r13_499 = r13_496 + (r13_497 - r13_498) * cameraAnimationSlider
        local r13_500 = r13_486.py + (r13_487.py - r13_486.py) * cameraAnimationSlider
        drawLine2D(r13_499, r13_500 - 15, r13_499, r13_500 + 15, 3, 248, 123, 138, 255)
        drawRectLines(g_currentCameraVisualization.x - r13_490, g_currentCameraVisualization.y - r13_493, g_currentCameraVisualization.x + r13_490, g_currentCameraVisualization.y + r13_493, 3, 255, 255, 255, 255)
        local r13_501 = g_deltaCameraValues.py - 15
        drawLine2D(g_deltaCameraValues.px, r13_501, g_deltaCameraValues.px, g_deltaCameraValues.py + 15, 3, 148, 123, 38, 255)
        local r13_502 = g_deltaCameraValues.px - 15
        drawLine2D(r13_502, g_deltaCameraValues.py, g_deltaCameraValues.px + 15, g_deltaCameraValues.py, 3, 148, 123, 38, 255)
        local r13_503 = originalCameras
        for r13_504, r13_505 in _G.pairs(r13_503) do
            drawRectLines(r13_505.px - r13_505.screenWidth * 0.5 / r13_505.sx, r13_505.py - r13_505.screenHeight * 0.5 / r13_505.sy, r13_505.px + r13_505.screenWidth * 0.5 / r13_505.sx, r13_505.py + r13_505.screenHeight * 0.5 / r13_505.sy, 6, 255, 0, 0, 128)
        end
        drawLine2D(leftLimitWorld, topLimitWorld, leftLimitWorld, bottomLimitWorld, 3, 255, 23, 8, 255)
        drawLine2D(rightLimitWorld, topLimitWorld, rightLimitWorld, bottomLimitWorld, 3, 255, 23, 8, 255)
        drawLine2D(leftLimitWorld, bottomLimitWorld, rightLimitWorld, bottomLimitWorld, 3, 23, 255, 8, 255)
        drawLine2D(leftLimitWorld, topLimitWorld, rightLimitWorld, topLimitWorld, 3, 255, 23, 8, 255)
        if cameraTargetObject ~= nil then
            local r13_506 = g_cameraAnimationVisualization
            drawRectLines(r13_506.left, r13_506.top, r13_506.right, r13_506.bottom, 6, 255, 255, 0, 0.5)
            local r13_507 = g_cameraAnimationVisualizationWithBoundaries
            drawRectLines(r13_507.left, r13_507.top, r13_507.right, r13_507.bottom, 6, 128, 255, 0, 0.5)
        end
        if g_killingVolumePhysics ~= nil then
            local r13_508, r13_509 = physicsToWorldTransform(g_killingVolumePhysics.left, g_killingVolumePhysics.top)
            local r13_510, r13_511 = physicsToWorldTransform(g_killingVolumePhysics.right, g_killingVolumePhysics.bottom)
            drawRectLines(r13_508 + 5, r13_509 + 5, r13_510 - 5, r13_511 - 5, 6, 255, 255, 0, 0.5)
        end
        setRenderState(0, 0, 1, 1, 0)
        screen.x = tempScreen.x
        screen.y = tempScreen.y
        screen.left = tempScreen.left
        screen.right = tempScreen.right
        screen.top = tempScreen.top
        screen.bottom = tempScreen.bottom
        worldScale = tempScreen.scale
        setWorldScale(worldScale)
    end
    if g_killingVolumeAttributes.enableDebugging and g_killingVolumePhysics ~= nil then
        local r13_512, r13_513 = objects.birdCameraData[deviceModel], objects.castleCameraData[deviceModel]
        local r13_514, r13_515 = worldToScreenTransform(r13_512.px, r13_512.py)
        local r13_516 = worldToScreenTransform
        local r13_517 = r13_512.px
        local r13_518 = r13_512.screenWidth * 0.5
        local r13_519 = r13_512.sx
        local r13_520 = r13_517 - r13_518 / r13_519
        local r13_521 = r13_512.py
        local r13_522 = r13_512.screenHeight * 0.5
        local r13_523 = r13_512.sy
        local r13_524, r13_525 = r13_516(r13_520, r13_521 - r13_522 / r13_523)
        local r13_526 = worldToScreenTransform
        local r13_527 = r13_512.px
        local r13_528 = r13_512.screenWidth * 0.5
        local r13_529 = r13_512.sx
        local r13_530 = r13_527 + r13_528 / r13_529
        local r13_531 = r13_512.py
        local r13_532 = r13_512.screenHeight * 0.5
        local r13_533 = r13_512.sy
        local r13_534, r13_535 = r13_526(r13_530, r13_531 + r13_532 / r13_533)
        drawRect(1, 0, 0, 0.5, r13_524, r13_525, r13_534, r13_535, false)
        local r13_536 = r13_524 + (r13_534 - r13_524) / 2
        local r13_537 = r13_525 + (r13_535 - r13_525) / 2
        drawLine2D(r13_536 - 10, r13_537, r13_536 + 10, r13_537, 2, 255, 0, 0, 255)
        drawLine2D(r13_536, r13_537 - 10, r13_536, r13_537 + 10, 2, 255, 0, 0, 255)
        local r13_538, r13_539 = worldToScreenTransform(r13_513.px, r13_513.py)
        local r13_540 = worldToScreenTransform
        local r13_541 = r13_513.px
        local r13_542 = r13_513.screenWidth * 0.5
        local r13_543 = r13_513.sx
        local r13_544 = r13_541 - r13_542 / r13_543
        local r13_545 = r13_513.py
        local r13_546 = r13_513.screenHeight * 0.5
        local r13_547 = r13_513.sy
        local r13_548, r13_549 = r13_540(r13_544, r13_545 - r13_546 / r13_547)
        local r13_550, r13_551 = r13_549, r13_548
        local r13_552 = worldToScreenTransform
        local r13_553 = r13_513.px
        local r13_554 = r13_513.screenWidth * 0.5
        local r13_555 = r13_513.sx
        local r13_556 = r13_553 + r13_554 / r13_555
        local r13_557 = r13_513.py
        local r13_558 = r13_513.screenHeight * 0.5
        local r13_559 = r13_513.sy
        local r13_560, r13_561 = r13_552(r13_556, r13_557 + r13_558 / r13_559)
        local r13_562, r13_563 = r13_561, r13_560
        drawRect(0, 1, 0, 0.5, r13_551, r13_550, r13_563, r13_562, false)
        local r13_564 = r13_551 + (r13_563 - r13_551) / 2
        local r13_565 = r13_550 + (r13_562 - r13_550) / 2
        drawLine2D(r13_564 - 10, r13_565, r13_564 + 10, r13_565, 2, 0, 255, 0, 255)
        drawLine2D(r13_564, r13_565 - 10, r13_564, r13_565 + 10, 2, 0, 255, 0, 255)
        drawLine2D(0, screenHeight * 0.5, screenWidth, screenHeight * 0.5, 2, 255, 0, 0, 255)
        drawLine2D(screenWidth * 0.5, 0, screenWidth * 0.5, screenHeight, 2, 0, 255, 0, 255)
        local r13_566, r13_567 = physicsToScreenTransform(g_killingVolumePhysics.left, g_killingVolumePhysics.top)
        local r13_568 = r13_567
        local r13_569 = r13_566
        local r13_570, r13_571 = physicsToScreenTransform(g_killingVolumePhysics.right, g_killingVolumePhysics.bottom)
        drawRect(1, 1, 1, 0.5, r13_569 + 5, r13_568 + 5, r13_570 - 5, r13_571 - 5, false)
    end
    local r13_572 = 0.5
    if g_birdEmitterTargets then
        local r13_573, r13_574, r13_575 = _G.pairs(g_birdEmitterTargets)
        local r13_576 = r13_572
        for r13_577, r13_578 in r13_573, r13_574, r13_575 do
            local r13_579 = _G.math.sin((r13_578[6] or 0) * 3)
            r13_576 = r13_576 + r13_579 * r13_576 * 0.25
            setRenderState(0, 0, r13_576, r13_576, 0, 0)
            local r13_580, r13_581 = physicsToScreenTransform(r13_578[1], r13_578[2])
            _G.res.drawSprite("", r13_578[5] or "RETICLE_RED", r13_580 / r13_576, r13_581 / r13_576)
        end
    end
    setRenderState(0, 0, 1, 1, 0, 0)
    ui.Frame.draw(self, 0, 0)
    local r13_582 = getCurrentCameraIdx() + 1
    local r13_583 = levelName
    local r13_584 = getEpisodeSelectionLevelName()
    if r13_583 == r13_584 or g_drawLevelCameraIndexes and not getEpisodeMetadata(currentFolder).hideCameraIndexes then
        local r13_585 = getNumCameras()
        if r13_585 >= 2 then
            local r13_586, r13_587 = _G.res.getSpriteBounds("ICON_DOT_1")
            local r13_588 = r13_586 * 2
            local r13_589 = _G.math.floor((r13_585 - 0.5) * r13_588)
            local r13_590 = screenHeight - r13_587
            local r13_591 = self.leftButton
            if r13_591 ~= nil then
                r13_590 = r13_591.y
            end
            for r13_592 = 1, r13_585 do
                local r13_593 = -r13_589 * 0.5 + screenWidth * 0.5 + r13_588 * (r13_592 - 1) + 4
                if r13_592 == r13_582 then
                    res.drawSprite("", "ICON_DOT_2", r13_593, r13_590)
                else
                    res.drawSprite("", "ICON_DOT_1", r13_593, r13_590)
                end
            end
        end
    end
    self:drawTransition()
    self:drawFade()
    if g_queuedCursorName then
        g_currentCursorName = g_queuedCursorName
        g_queuedCursorName = nil
    end
end

-- line 1425-1432
-- proto#14 params=1 locals=1 upvalues=0 vararg=false
function GameScene:drawFade()
    if fadeTimer then
        local r14_0 = fadeColor
        if not r14_0 then
            r14_0 = {}
        end
        setRenderState(0, 0, 1, 1, 0)
        drawRect(r14_0[1], r14_0[2], r14_0[3], (fadeTotalTimer - fadeTimer) / fadeTotalTimer, 0, 0, screenWidth, screenHeight, false)
    end
end

-- line 1434-1550
-- proto#15 params=1 locals=63 upvalues=0 vararg=false
function GameScene.layout(p15_0)
    local r15_0, r15_1
    local r15_2 = 0
    local r15_3 = 0
    local r15_4 = p15_0:getChild("pauseButton")
    if r15_4 ~= nil then
        if getLevelMetadata(levelName).pauseButtonPosition == "BOTTOM_LEFT" then
            local r15_5 = FrameUtils
            local r15_6 = {
                padding = r15_4.w * 0.10000000149011612,
                item = r15_4,
                h = screenHeight,
                vanchor = "BOTTOM",
                hanchor = "LEFT"
            }
            local r15_7, r15_8 = r15_5:layoutWithAnchors(r15_6)
            r15_4.y = r15_8
            r15_4.x = r15_7
        else
            r15_4.x = r15_4.px * r15_4.maxScale
            r15_4.y = r15_4.py * r15_4.maxScale
        end
        local r15_9 = r15_4.x
        r15_3 = r15_4.y
        r15_2 = r15_9
    end
    local r15_10 = p15_0:getChild("restartButton")
    p15_0.restartButton = r15_10
    if r15_10 ~= nil then
        local r15_11 = 0
        if r15_4 ~= nil then
            if getLevelMetadata(levelName).pauseButtonPosition ~= "BOTTOM_LEFT" then
                local r15_12 = r15_4.w
                local r15_13 = r15_4.maxScale
                r15_11 = r15_12 * r15_13
            end
        end
        r15_10.x = r15_11 + r15_10.px * r15_10.maxScale
        r15_10.y = r15_10.py * r15_10.maxScale
        local r15_14 = r15_10.x
        local r15_15 = r15_10.y
    end
    local r15_16 = p15_0:getChild("MEButton")
    p15_0.MEButton = r15_16
    if r15_16 ~= nil then
        local r15_17 = 0
        if r15_4 ~= nil then
            local r15_18 = r15_4.x
            local r15_19 = r15_4.maxScale
            r15_17 = r15_18 * r15_19
        end
        r15_16.x = r15_17 + r15_16.w * r15_16.maxScale
        r15_16.y = r15_16.py * r15_16.maxScale
        local r15_20 = p15_0:getChild("MEGlow")
        p15_0.MEGlow = r15_20
        if r15_20 ~= nil then
            r15_20.x = r15_16.x
            r15_20.y = r15_16.y
        end
        local r15_21 = p15_0:getChild("MEButtonSmallBox")
        if r15_21 then
            local r15_22 = r15_16.w
            r15_21.x = r15_22 * 0.25
            local r15_23 = r15_16.h
            r15_21.y = r15_23 * 0.44999998807907104
        end
        local r15_24 = r15_16.x
        r15_1 = r15_16.y
        r15_0 = r15_24
    end
    if PowerupManager and PowerupManager.arePowerUpsEnabled then
        local r15_25 = p15_0:getChild(PowerupManager.POWERUP_SLIDER_NAME)
        if r15_25 then
            r15_25.x = r15_0 + r15_25.w * (r15_25.maxScale or 1)
            r15_25.y = r15_1
        end
        local r15_26 = p15_0:getChild(PowerupManager.CLONEBIRD_BUTTON_NAME)
        if r15_26 then
            if r15_4 then
                r15_26.x = r15_4.x
                r15_26.y = r15_4.y + r15_26.h * r15_26.maxScale
            else
                r15_26.x = 100
                r15_26.y = 100 + r15_26.h * r15_26.maxScale
            end
        end
    end
    local r15_27 = p15_0:getChild("iapWindow")
    if r15_27 then
        local r15_28 = screenWidth / 2
        r15_27.y = screenHeight / 2
        r15_27.x = r15_28
    end
    ui.Frame.layout(p15_0)
    local r15_29 = getNumCameras()
    local r15_30, r15_31 = _G.res.getSpriteBounds("ICON_DOT_1")
    local r15_32 = p15_0:getChild("leftButton")
    local r15_33 = p15_0:getChild("pauseButton")
    p15_0.pauseButton = r15_33
    if r15_32 ~= nil then
        r15_32.x = screenWidth * 0.5 - r15_30 * r15_29 - (r15_32.w - r15_32.px) * 1.2000000476837158
        p15_0.leftButton = r15_32
        if r15_33 == nil then
            r15_32.y = screenHeight - (r15_32.h - r15_32.py)
        else
            r15_32.y = screenHeight - (r15_33.h - r15_33.py)
        end
    end
    local r15_34 = p15_0:getChild("rightButton")
    p15_0.rightButton = r15_34
    if r15_34 ~= nil then
        r15_34.x = screenWidth * 0.5 + r15_30 * r15_29 + r15_32.px * 1.2000000476837158
        if r15_32 == nil then
            r15_34.y = screenHeight - screenHeight - (r15_34.h - r15_34.py)
        else
            r15_34.y = r15_32.y
        end
    end
end

-- line 1552-1760
-- proto#16 params=1 locals=27 upvalues=0 vararg=false
function GameScene.onEntry(p16_0)
    if queuedLevelFolder ~= nil then
        levelFolder = queuedLevelFolder
        queuedLevelFolder = nil
    end
    if queuedLevelName ~= nil then
        levelName = queuedLevelName
        queuedLevelName = nil
    end
    if queuedCurrentPack ~= nil then
        currentPack = queuedCurrentPack
        queuedCurrentPack = nil
    end
    if queuedCurrentLevel ~= nil then
        currentLevel = queuedCurrentLevel
        queuedCurrentLevel = nil
    end
    if queuedCurrentFolder ~= nil then
        currentFolder = queuedCurrentFolder
        queuedCurrentFolder = nil
    end
    if isInGameMode() then
        p16_0.drawEaglesAmountNumber = SettingsWrapper:getMEAmount()
    else
        p16_0.drawEaglesAmountNumber = 0
    end
    eventManager:addEventListener(events.EID_PAUSE_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_PAUSE_PAGE_CLOSED, p16_0)
    eventManager:addEventListener(events.EID_GAME_RESUMED, p16_0)
    eventManager:addEventListener(events.EID_POWERUP_ACTIVATED, p16_0)
    eventManager:addEventListener(events.EID_POWERUP_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_PAUSE_PAGE_OPENED, p16_0)
    eventManager:addEventListener(events.EID_LEVEL_RESTART_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_CAPTURE_SCREEN, p16_0)
    eventManager:addEventListener(events.EID_EPISODE_PURCHASE_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_MIGHTY_EAGLE_BUTTON_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_MIGHTY_EAGLE_PURCHASE_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_EPISODE_PURCHASE_CLOSE_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_MIGHTY_EAGLE_PURCHASE_CLOSE_CLICKED, p16_0)
    eventManager:addEventListener(events.EID_AUDIO_TOGGLED, p16_0)
    eventManager:addEventListener(events.EID_OPEN_URL, p16_0)
    eventManager:addEventListener(events.EID_INIT_EPISODE_COMPLETED_ACTIONS, p16_0)
    eventManager:addEventListener(events.EID_EPISODE_THREE_STARS_POPUP_OPENED, p16_0)
    eventManager:addEventListener(events.EID_MIGHTYFALCON_PURCHASED, p16_0)
    eventManager:addEventListener(events.EID_SPINNER_PAGE_CLOSING, p16_0)
    eventManager:addEventListener(events.EID_SCROLL_RIGHT, p16_0)
    eventManager:addEventListener(events.EID_LEVEL_STARTED, p16_0)
    eventManager:addEventListener(events.EID_SHOP_OPENED, p16_0)
    eventManager:addEventListener(events.EID_SHOP_CLOSED, p16_0)
    eventManager:addEventListener(events.EID_OPEN_SHOP, p16_0)
    eventManager:addEventListener(events.EID_EPISODE_COMPLETED, p16_0)
    eventManager:addEventListener(events.EID_OPEN_BUY_FREE_IOS_VERSION_POPUP, p16_0)
    eventManager:addEventListener(events.EID_OPEN_FREE_IOS_VERSION_POPUP, p16_0)
    eventManager:addEventListener(events.EID_CLOSE_BUY_FREE_IOS_VERSION_POPUP, p16_0)
    eventManager:addEventListener(events.EID_TIMED_BUY_FREE_IOS_VERSION_POPUP_SHOWN, p16_0)
    eventManager:addEventListener(events.EID_MAIN_MENU_ENTERED, p16_0)
    eventManager:addEventListener(events.EID_JOINT_REMOVED, p16_0)
    eventManager:addEventListener(events.EID_RESET_SLINGSHOT_GFX, p16_0)
    eventManager:addEventListener(events.EID_SET_SLINGSHOT_GFX, p16_0)
    eventManager:addEventListener(events.EID_POWERUP_IAP_POPUP_CLOSED, p16_0)
    eventManager:addEventListener(events.EID_PURCHASE_CALLBACK_RECEIVED, p16_0)
    eventManager:addEventListener(events.EID_LEVEL_FAILED, p16_0)
    eventManager:addEventListener(events.EID_LEVEL_COMPLETED, p16_0)
    resetBGInitialPosition()
    setGameOn(isInGameMode())
    setEditing(false)
    enableSmoothZooming(true)
    setPhysicsEnabled(true)
    p16_0:resetFrameElements()
    setDeltaTimeMultiplier(1)
    if p16_0.resumeLevel then
        p16_0.resumeLevel = false
    elseif startedFromEditor then
        loadLevelInternal(levelFolder .. "temp/" .. levelName .. ".temp.playtest")
    else
        loadLevelInternal(levelFolder .. levelName)
        if g_extraPlayMenuUsed ~= true then
            if levelName == g_oldLevelName then
                numberOfAttemptsInLevel = numberOfAttemptsInLevel + 1
            else
                numberOfAttemptsInLevel = 1
            end
        end
    end
    p16_0:setupFrameElements()
    g_oldLevelName = levelName
    enableInGameParticlesNative(true)
    handleLevelMusic()
    ui.Frame.onEntry(p16_0)
    if releaseBuild ~= true then
        if g_warningMessages ~= nil then
            for r16_0, r16_1 in _G.ipairs(g_warningMessages) do
                local r16_2 = eventManager
                local r16_3 = {
                    id = events.EID_PUSH_FRAME,
                    target = ui.Prompt:new({ title = "QA Message", content = r16_1 })
                }
                r16_2:notify(r16_3)
            end
        end
        g_warningMessages = nil
    end
    if g_showEpisodePurchaseDialog and isBuildUnlocked() ~= true then
        if getEpisodeMetadataWithParam(currentFolder, "iapPurchaseId") ~= nil then
            local r16_4 = ui.Shop:new({ openedFrom = "episodeSelection" })
            local r16_5 = eventManager
            local r16_6 = { id = events.EID_PUSH_FRAME, target = r16_4 }
            r16_5:queueEvent(r16_6)
            r16_4:scrollToShortCut("EPISODE")
        end
        g_showEpisodePurchaseDialogFrom = nil
        g_showEpisodePurchaseDialog = nil
    end
    local r16_7 = levelName
    local r16_8 = getEpisodeSelectionLevelName()
    if r16_7 == r16_8 or levelName == "LevelSelection" then
        local r16_9 = levelName
        local r16_10 = getEpisodeSelectionLevelName()
        local r16_11
        if r16_9 == r16_10 then
            r16_11 = SettingsWrapper:getLastOpenedEpisode()
        else
            r16_11 = SettingsWrapper:getLastLevelPage(currentFolder)
        end
        local r16_12 = r16_11
        if r16_12 == nil then
            r16_12 = 0
        end
        local r16_13 = p16_0:getChild("leftButton")
        local r16_14 = p16_0:getChild("rightButton")
        local r16_15 = getNumCameras()
        if r16_15 >= 2 then
            if r16_13 ~= nil then
                r16_13.visible = true
                r16_13:setEnabled(true)
                if r16_12 == 0 then
                    r16_13:setEnabled(false)
                end
            end
            if r16_14 ~= nil then
                r16_14.visible = true
                r16_14:setEnabled(true)
                local r16_16 = r16_15 + 1
                if r16_12 == r16_16 then
                    r16_14:setEnabled(false)
                end
            end
        elseif r16_13 and r16_14 then
            r16_13.visible = false
            r16_14.visible = false
        end
    end
    local r16_17 = subsystemsapi.daysSinceLastLevelStart(levelName)
    if not r16_17 or r16_17 > 0 then
        local r16_18 = eventManager
        local r16_19 = { id = events.EID_LEVEL_STARTED_UNIQUE, levelName = levelName }
        r16_18:notify(r16_19)
    end
    local r16_20 = eventManager
    local r16_21 = { id = events.EID_LEVEL_STARTED, levelName = levelName }
    r16_20:notify(r16_21)
    subsystemsapi.resetLevelStartDate(levelName)
    if isInGameMode() then
        if not SettingsWrapper:wasLevelStartedBefore(levelName) then
            local r16_22 = eventManager
            local r16_23 = { id = events.EID_LEVEL_STARTED_FIRST_TIME, levelName = levelName }
            r16_22:notify(r16_23)
            SettingsWrapper:levelStarted(levelName)
        end
        if highscores[levelName] == nil or highscores[levelName] ~= nil and highscores[levelName].score == nil and highscores[levelName].eagleScore == nil then
            local r16_24 = eventManager
            local r16_25 = {
                id = events.EID_FLURRY_EVENT_LEVEL_STARTED_BEFORE_COMPLETION,
                levelName = levelName
            }
            r16_24:notify(r16_25)
        end
        if isIapEnabled() and SettingsWrapper:getTimesLevelRestartedInARow(levelName) == SettingsWrapper:getCurrentPupuFrequency() and not startedFromEditor then
            ui.Shop.initPaymentAndPurchases()
            local r16_26 = ui.PowerupIAPPopup:new({ name = "PowerupIAPPopup" })
            local r16_27 = eventManager
            local r16_28 = { id = events.EID_PUSH_FRAME, target = r16_26 }
            r16_27:notify(r16_28)
            SettingsWrapper:resetTimesLevelRestartedInARow()
        end
    end
    p16_0.heldByForceTimer = 0
end

-- line 1762-1830
-- proto#17 params=7 locals=63 upvalues=0 vararg=false
function GameScene.makeClusterBird(p17_0, p17_1, p17_2, p17_3, p17_4, p17_5, p17_6)
    local r17_0 = getObjectDefinition(flyingBird.name)
    local r17_1 = flyingBird.x + p17_2
    createCircle(p17_1, r17_0.sprites.action, r17_1, flyingBird.y + p17_3, flyingBird.radius, flyingBird.density, flyingBird.friction, flyingBird.restitution, true, flyingBird.controllable, flyingBird.z_order)
    objects.world[p17_1].scale = r17_0.scale
    objects.world[p17_1].onTriggerExit = r17_0.onTriggerExit
    objects.world[p17_1].onTriggerEnter = r17_0.onTriggerEnter
    objects.world[p17_1].onCollisionEnter = r17_0.onCollisionEnter
    objects.world[p17_1].onDestroyed = r17_0.onDestroyed
    objects.world[p17_1].onCreated = r17_0.onCreated
    objects.world[p17_1].onCollisionExit = r17_0.onCollisionExit
    objects.world[p17_1].onReceivedExplosionDamage = r17_0.onReceivedExplosionDamage
    objects.world[p17_1].onReceivedExplosionForce = r17_0.onReceivedExplosionForce
    objects.world[p17_1].onDamageStateChanged = r17_0.onDamageStateChanged
    setActive(p17_1, true)
    local r17_2 = r17_0.scale or 1
    setScale(p17_1, r17_2, r17_0.scale or 1)
    setLinearDamping(p17_1, defaultPhysicsDrag)
    objects.world[p17_1].hasExploded = flyingBird.hasExploded
    objects.world[p17_1].definition = flyingBird.definition
    objects.world[p17_1].controllable = flyingBird.controllable
    objects.world[p17_1].strength = flyingBird.strength
    objects.world[p17_1].defence = flyingBird.defence
    objects.world[p17_1].material = flyingBird.material
    objects.world[p17_1].levelGoal = flyingBird.levelGoal
    objects.world[p17_1].damageFactors = flyingBird.damageFactors
    objects.world[p17_1].spritePivotX = flyingBird.spritePivotX
    objects.world[p17_1].spritePivotY = flyingBird.spritePivotY
    objects.world[p17_1].damageSprite = flyingBird.damageSprite
    objects.world[p17_1].parentName = flyingBird.name
    objects.world[p17_1].useLegacyCollisionPath = flyingBird.useLegacyCollisionPath
    objects.world[p17_1].shot = true
    objects.world[p17_1].xVel = flyingBird.xVel + p17_4
    objects.world[p17_1].yVel = flyingBird.yVel + p17_5
    objects.world[p17_1].notCollided = true
    objects.world[p17_1].startingX = flyingBird.startingX
    objects.world[p17_1].startingY = flyingBird.startingY
    objects.world[p17_1].startingAngle = flyingBird.startingAngle
    objects.world[p17_1].controlRadius = flyingBird.controlRadius
    objects.world[p17_1].damageDone = 0
    objects.world[p17_1].startNumber = flyingBird.startNumber
    setObjectParameter(p17_1, 36, r17_0.collisionGroupIndex)
    if p17_6 ~= nil then
        objects.world[p17_1].enteredGravitationArea = true
    end
    setObjectParameter(p17_1, 11, 1)
    setActive(p17_1, true)
    setRotation(p17_1, flyingBird.angle)
    local r17_3 = flyingBird.xVel + p17_4
    setVelocity(p17_1, r17_3, flyingBird.yVel + p17_5)
    birds[p17_1] = objects.world[p17_1]
    birds[p17_1].startedOutsideAtmosphere = nil
    if blockTable.blocks[objects.world[p17_1].definition].onLaunched ~= nil then
        local r17_4 = addEventCall
        local r17_5 = blockTable.blocks[objects.world[p17_1].definition]
        r17_4(r17_5.onLaunched, { name = p17_1 })
    end
    objects.world[p17_1].usePowerupParticles = flyingBird.usePowerupParticles
    objects.world[p17_1].activateCloneGlow = flyingBird.activateCloneGlow
end

-- line 1832-1877
-- proto#18 params=1 locals=1 upvalues=0 vararg=false
function GameScene.onExit(p18_0)
    clearParticlesNative()
    setGameOn(false)
    eventManager:removeEventListener(events.EID_PAUSE_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_GAME_RESUMED, p18_0)
    eventManager:removeEventListener(events.EID_JOINT_REMOVED, p18_0)
    eventManager:removeEventListener(events.EID_PAUSE_PAGE_CLOSED, p18_0)
    eventManager:removeEventListener(events.EID_PAUSE_PAGE_OPENED, p18_0)
    eventManager:removeEventListener(events.EID_LEVEL_RESTART_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_CAPTURE_SCREEN, p18_0)
    eventManager:removeEventListener(events.EID_MIGHTY_EAGLE_BUTTON_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_MIGHTY_EAGLE_PURCHASE_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_MIGHTY_EAGLE_PURCHASE_CLOSE_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_EPISODE_PURCHASE_CLOSE_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_EPISODE_PURCHASE_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_AUDIO_TOGGLED, p18_0)
    eventManager:removeEventListener(events.EID_OPEN_URL, p18_0)
    eventManager:removeEventListener(events.EID_INIT_EPISODE_COMPLETED_ACTIONS, p18_0)
    eventManager:removeEventListener(events.EID_EPISODE_THREE_STARS_POPUP_OPENED, p18_0)
    eventManager:removeEventListener(events.EID_MIGHTYFALCON_PURCHASED, p18_0)
    eventManager:removeEventListener(events.EID_SPINNER_PAGE_CLOSING, p18_0)
    eventManager:removeEventListener(events.EID_SCROLL_RIGHT, p18_0)
    eventManager:removeEventListener(events.EID_LEVEL_STARTED, p18_0)
    eventManager:removeEventListener(events.EID_SHOP_OPENED, p18_0)
    eventManager:removeEventListener(events.EID_SHOP_CLOSED, p18_0)
    eventManager:removeEventListener(events.EID_OPEN_SHOP, p18_0)
    eventManager:removeEventListener(events.EID_EPISODE_COMPLETED, p18_0)
    eventManager:removeEventListener(events.EID_OPEN_BUY_FREE_IOS_VERSION_POPUP, p18_0)
    eventManager:removeEventListener(events.EID_OPEN_FREE_IOS_VERSION_POPUP, p18_0)
    eventManager:removeEventListener(events.EID_TIMED_BUY_FREE_IOS_VERSION_POPUP_SHOWN, p18_0)
    eventManager:removeEventListener(events.EID_CLOSE_BUY_FREE_IOS_VERSION_POPUP, p18_0)
    eventManager:removeEventListener(events.EID_MAIN_MENU_ENTERED, p18_0)
    eventManager:removeEventListener(events.EID_POWERUP_CLICKED, p18_0)
    eventManager:removeEventListener(events.EID_SET_SLINGSHOT_GFX, p18_0)
    eventManager:removeEventListener(events.EID_RESET_SLINGSHOT_GFX, p18_0)
    eventManager:removeEventListener(events.EID_POWERUP_ACTIVATED, p18_0)
    eventManager:removeEventListener(events.EID_POWERUP_IAP_POPUP_CLOSED, p18_0)
    eventManager:removeEventListener(events.EID_PURCHASE_CALLBACK_RECEIVED, p18_0)
    eventManager:removeEventListener(events.EID_LEVEL_FAILED, p18_0)
    eventManager:removeEventListener(events.EID_LEVEL_COMPLETED, p18_0)
    ui.Frame.onExit(p18_0)
end

-- line 1879-1883
-- proto#19 params=3 locals=0 upvalues=0 vararg=false
function GameScene:processKeyEvent(p19_1, p19_2)
    if p19_1 == "PRESS" then
        g_keyPressed[p19_2] = false
    end
end

-- line 1885-2003
-- proto#20 params=3 locals=35 upvalues=0 vararg=false
function GameScene:onKeyEvent(p20_1, p20_2)
    local r20_0, r20_1 = ui.Frame.onKeyEvent(self, p20_1, p20_2)
    if notificationsFrame and _G.next(notificationsFrame.children) then
        notificationsFrame:onKeyEvent(p20_1, p20_2)
    end
    if p20_2 == "J" and self:getChild("keyBoard") == nil and cheatsEnabled then
        local r20_2 = getRandomDroidLevel()
    end
    if not r20_0 and p20_1 == "PRESS" then
        if not (p20_2 == "KEY_BACK" or p20_2 == "ESCAPE") or startedFromEditor then
            if p20_2 == "P" and not isLevelEnded() and isInGameMode() then
                togglePausePage()
            elseif p20_2 == "R" and isInGameMode() then
                if g_isWindowSnapped then
                    if p20_2 == "C" and isInGameMode() and cheatsEnabled then
                        g_threeStarsCheat = true
                    elseif p20_2 == "PAGEUP" and isInGameMode() and cheatsEnabled then
                        setPreviousLevel()
                    elseif p20_2 == "PAGEDOWN" and isInGameMode() and cheatsEnabled then
                        setNextLevel()
                    elseif p20_2 == "G" and isInGameMode() and cheatsEnabled then
                        levelCompleteTimer = 0.10000000149011612
                    elseif (p20_2 == "1" or p20_2 == "2" or p20_2 == "3" or p20_2 == "4") and isInGameMode() and isBuildUnlocked() then
                        if currentBirdName ~= nil then
                            local r20_3 = objects.world[currentBirdName]
                            local r20_4 = r20_3.definition
                            local r20_5 = _G.string.len(r20_4)
                            local r20_6 = _G.string.sub(r20_4, 1, r20_5 - 1) .. p20_2
                            if blockTable.blocks[r20_6] then
                                local r20_7 = objects.world[currentBirdName]
                                local r20_8 = objects.world[currentBirdName]
                                local r20_9 = createObject(blockTable, r20_6, "_" .. currentBirdName, r20_7.x, r20_8.y)
                                setupTutorial(r20_9)
                                local r20_10 = objects.world[r20_9]
                                local r20_11 = objects.world[currentBirdName]
                                r20_10.startNumber = r20_11.startNumber
                                birds[r20_9] = objects.world[r20_9]
                                objects.world[r20_9].controlRadius = 5.5
                                destroyObject(currentBirdName, true)
                                currentBirdName = r20_9
                                objects.world[r20_9].damageDone = 0
                                local r20_12 = objects.world[r20_9]
                                local r20_13 = _G.math.random(10, 30)
                                r20_12.animTimer = r20_13 / 10
                                local r20_14 = objects.world[r20_9]
                                local r20_15 = _G.math.random(10, 30)
                                r20_14.jumpTimer = r20_15 / 10
                            end
                        end
                    elseif p20_2 == "S" then
                        eventManager:notify({ id = events.EID_AUDIO_TOGGLED })
                    elseif p20_2 == "LEFT" then
                        local r20_16 = self:getChild("leftButton")
                        if r20_16 and r20_16.enabled or r20_16 == nil then
                            updatePCCameraPanningToDirection(false)
                        end
                    elseif p20_2 == "RIGHT" then
                        local r20_17 = self:getChild("rightButton")
                        if r20_17 and r20_17.enabled or r20_17 == nil then
                            updatePCCameraPanningToDirection(true)
                        end
                    end
                elseif isLevelEnded() then
                    local r20_18 = menuManager:getRoot():getChild("LevelEnd")
                    if not r20_18.hideBackToMenuButton then
                        setLevelLoadingAfterRestartFromPauseMenu()
                    end
                else
                    playAudio("ButtonProceed")
                    self:triggerRestart()
                end
            end
        else
            if deviceModel == "android" and adSystem and adSystem:isExpandableExpanded() then
                return
            end
            local r20_19 = getLevelMetadata(levelName)
            if r20_19.backButtonlevelFolder and getLevelMetadata(levelName).backButtonLevelName then
                local r20_20 = getNextLevelName
                local r20_21 = getLevelMetadata(levelName)
                local r20_22 = r20_20(r20_21.backButtonLevelName)
                local r20_23 = setLevelFolder
                local r20_24 = getLevelMetadata(levelName)
                r20_23(r20_24.backButtonlevelFolder)
                setLevelName(r20_22)
                playAudio("ButtonBack")
                local r20_25 = eventManager
                local r20_26 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
                r20_25:notify(r20_26)
            elseif isLevelEnded() then
                local r20_27 = menuManager:getRoot():getChild("LevelEnd")
                if not r20_27.hideBackToMenuButton then
                    returnToLevelSelection()
                    playAudio("ButtonBack")
                end
            elseif deviceModel == "android" then
                if isPausePageVisible() then
                    returnToLevelSelection()
                    returnLevelFolder = nil
                    playAudio("ButtonBack")
                else
                    togglePausePage()
                    playAudio("ButtonBack")
                end
            else
                togglePausePage()
                playAudio("ButtonBack")
            end
        end
    end
    if r20_0 == "TUTORIAL_SCREEN_CLOSED" then
        if _G.res.isAudioPlaying("tutorial_music") then
            _G.res.stopAudio("tutorial_music")
        end
        self:checkForShowTutorial(true)
    end
    if r20_0 then
        self:processKeyEvent(p20_1, p20_2)
    end
end

-- line 2005-2008
-- proto#21 params=1 locals=0 upvalues=0 vararg=false
function GameScene:triggerRestart()
    setLevelLoadingAfterRestartFromPauseMenu()
    checkLevelRestartAchievement(levelCompleted, levelFailed)
end

-- line 2010-2033
-- proto#22 params=4 locals=1 upvalues=0 vararg=false
function GameScene:processPointerEvent(p22_1, p22_2, p22_3)
    g_refusedDragTargetting = false
    local r22_0 = p22_1
    if p22_2 == "REFUSED_DRAG_TARGETTING" then
        g_refusedDragTargetting = true
        local r22_1
        r22_0, r22_1 = nil, nil
        object = nil
    end
    if r22_0 ~= nil then
        g_keyPressed = { LBUTTON = false, RBUTTON = false }
        g_keyReleased = { LBUTTON = false, RBUTTON = false }
        g_keyHold = { LBUTTON = false, RBUTTON = false }
    end
    currentEvent = r22_0
    if currentEvent == nil and p22_3 ~= "HOVER" and prevEvent == "BLOCK_EVENT" then
        g_keyPressed = { LBUTTON = true }
    end
    prevEvent = currentEvent
end

-- line 2035-2231
-- proto#23 params=4 locals=92 upvalues=0 vararg=false
function GameScene.onPointerEvent(p23_0, p23_1, p23_2, p23_3)
    local r23_0, r23_1, r23_2 = ui.Frame.onPointerEvent(p23_0, p23_1, p23_2, p23_3)
    p23_0:processPointerEvent(r23_0, r23_1, p23_1)
    if r23_2 ~= nil and r23_2.physicsObject ~= nil then
        local r23_3 = blockTable.blocks
        local r23_4 = r23_2.physicsObject
        local r23_5 = r23_3[r23_4.definition]
        local r23_6 = r23_5.FREE_VERSION_URL
        if r23_6 and r23_6 == "OPEN_UPSELL_POPUP" then
            local r23_7 = eventManager
            local r23_8 = {
                id = events.EID_OPEN_BUY_FREE_IOS_VERSION_POPUP,
                openedFrom = "episodeSelection"
            }
            r23_7:notify(r23_8)
        else
            local r23_9 = blockTable.blocks
            local r23_10 = r23_2.physicsObject
            local r23_11 = r23_9[r23_10.definition]
            local r23_12 = r23_11.URL
            local r23_13 = blockTable.blocks
            local r23_14 = r23_2.physicsObject
            local r23_15 = r23_13[r23_14.definition]
            local r23_16 = r23_15.TEXT_ID
            local r23_17 = blockTable.blocks
            local r23_18 = r23_2.physicsObject
            local r23_19 = r23_17[r23_18.definition]
            local r23_20 = r23_19.ICON
            if r23_12 ~= nil and r23_0 ~= "LEFT_CLICKED" and r23_0 ~= "RIGHT_CLICKED" then
                local r23_21 = false
                local r23_22
                local r23_23, r23_24
                if r23_12 == "ALEX_URL" then
                    r23_22 = ALEX_URL
                elseif r23_12 == "RENREN_URL" then
                    r23_22 = RENREN_URL
                elseif r23_12 == "NASA_URL" then
                    r23_22 = NASA_URL
                elseif r23_12 == "TWITTER_URL" then
                    r23_22 = TWITTER_URL
                elseif r23_12 == "FACEBOOK_URL" then
                    r23_22 = FACEBOOK_URL
                elseif r23_12 == "WEIBO_URL" then
                    r23_22 = WEIBO_URL
                elseif r23_12 == "QZONE_URL" then
                    r23_22 = QZONE_URL
                elseif r23_12 == "TENCENT_URL" then
                    r23_22 = TENCENT_URL
                elseif r23_12 == "EULA_URL" then
                    local r23_25 = EULA_URL
                    r23_23 = true
                    r23_22 = r23_25
                elseif r23_12 == "PRIVACY_POLICY_URL" then
                    local r23_26 = PRIVACY_POLICY_URL
                    r23_24 = true
                    r23_22 = r23_26
                else
                    r23_22 = r23_12
                end
                local r23_27
                if r23_12 == "ALEX_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "RENREN_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "NASA_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "TWITTER_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "FACEBOOK_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "WEIBO_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "QZONE_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "TENCENT_URL" then
                    r23_27 = r23_21
                elseif r23_12 == "EULA_URL" then
                    r23_27 = r23_23
                elseif r23_12 == "PRIVACY_POLICY_URL" then
                    r23_27 = r23_24
                else
                    r23_27 = r23_21
                end
                openURL(r23_22, r23_16, r23_20, r23_27, r23_12)
            end
        end
    end
    if r23_0 == "ACTIVATE_POWERUP" then
        local r23_28 = eventManager
        local r23_29 = {
            id = events.EID_POWERUP_CLICKED,
            powerUpName = r23_1,
            backgroundAlpha = 0.6000000238418579
        }
        r23_28:notify(r23_29)
    elseif r23_0 == "TOGGLE_SLIDER" then
        local r23_30 = p23_0:getChild(PowerupManager.POWERUP_SLIDER_NAME)
        if r23_30 then
            local r23_31 = eventManager
            local r23_32 = { id = events.EID_POWERUP_SLIDER_TOGGLED, state = r23_30.state }
            r23_31:notify(r23_32)
        end
    elseif r23_0 == "GOTO_LEVEL" or r23_0 == "GOTO_EPISODE" then
        local r23_33 = r23_2.disabled or r23_2.isEpisodeDisabledByDevice
        local r23_34, r23_35 = objects.world, r23_2.physicsObject
        local r23_36 = r23_34[r23_35.name]
        if (r23_36 == nil or r23_33 == true) and alwaysAllowGotoLevel ~= true then
            if r23_2.showPurchaseEpisodeDialog and isBuildUnlocked() ~= true then
                ui.Shop.initPaymentAndPurchases()
                local r23_37 = ui.Shop.getDataById(getEpisodeMetadataWithParam(currentFolder, "iapPurchaseId"))
                local r23_38 = ui.Shop.createIAPWindowForID(r23_37[ui.Shop.getIapPurchaseIdKey()])
                local r23_39 = screenWidth / 2
                r23_38.y = screenHeight / 2
                r23_38.x = r23_39
                local r23_40 = eventManager
                local r23_41 = { id = events.EID_PUSH_FRAME, target = r23_38 }
                r23_40:notify(r23_41)
            end
        else
            r23_35 = {
                startNumber = r23_2.physicsObject.startNumber,
                episodeType = r23_2.physicsObject.episodeType,
                cameraIndex = getCurrentCameraIdx()
            }
            if r23_36.episodeSelection and r23_0 == "GOTO_EPISODE" then
                local r23_42 = -1
                if r23_35.startNumber ~= nil then
                    local r23_43 = actions.myLevelFolders[actions.episodeTypeTable[r23_35.episodeType]]
                    r23_42 = r23_43[r23_35.startNumber]
                end
                local r23_44 = eventManager
                local r23_45 = { id = events.EID_GOTO_EPISODE_CLICKED, episode = r23_42 }
                r23_44:notify(r23_45)
                gotoLevelSelectionMenu(r23_35)
            elseif r23_0 == "GOTO_LEVEL" then
                local r23_46 = getEpisodeMetadata(currentFolder)
                local r23_47 = r23_46.levelsAvailableInFree
                if g_isRegistered or r23_47 and r23_35.startNumber <= r23_47 then
                    p23_0:initializeTransition()
                    addEventCall("loadLevelFromMenu", r23_35)
                else
                    local r23_48 = eventManager
                    local r23_49 = {
                        id = events.EID_SHOW_REGISTRATION_DIALOG,
                        success_call = function()
                            p23_0:initializeTransition()
                            fireAction("loadLevelFromMenu", r23_35)
                        end
                    }
                    r23_48:notify(r23_49)
                end
            end
        end
    elseif r23_0 == "GOTO_EPISODE_SELECTION" then
        gotoMenuLevel(getEpisodeSelectionLevelName())
        eventManager:notify({ id = events.EID_PLAY_BUTTON_PRESSED })
    elseif r23_0 == "TUTORIAL_SCREEN_CLICKED" then
        if _G.res.isAudioPlaying("tutorial_music") then
            _G.res.stopAudio("tutorial_music")
        end
        p23_0:checkForShowTutorial(true)
    elseif r23_0 == "PAUSE_CLICKED" then
        local r23_50 = getLevelMetadata(levelName)
        if r23_50.backButtonlevelFolder and getLevelMetadata(levelName).backButtonLevelName then
            local r23_51 = getNextLevelName
            local r23_52 = getLevelMetadata(levelName)
            local r23_53 = r23_51(r23_52.backButtonLevelName)
            local r23_54 = setLevelFolder
            local r23_55 = getLevelMetadata(levelName)
            r23_54(r23_55.backButtonlevelFolder)
            setLevelName(r23_53)
            local r23_56 = eventManager
            local r23_57 = { id = events.EID_CHANGE_SCENE, target = "GameScene" }
            r23_56:notify(r23_57)
        elseif levelName ~= "MainMenu" then
            eventManager:notify({ id = events.EID_PAUSE_CLICKED })
        end
    elseif r23_0 == "ME_CLICKED" then
        local r23_58 = eventManager
        local r23_59 = { id = events.EID_MIGHTY_EAGLE_BUTTON_CLICKED, from = "INGAME" }
        r23_58:notify(r23_59)
    elseif r23_0 == "SHOW_TUTORIALS" then
        eventManager:notify({ id = events.EID_TUTORIAL_VIEWED })
        setupLevelTutorials(true)
    elseif r23_0 == "LEFT_CLICKED" then
        updatePCCameraPanningToDirection(false)
    elseif r23_0 == "RIGHT_CLICKED" then
        updatePCCameraPanningToDirection(true)
    elseif r23_0 == "RESTART_CLICKED" then
        local r23_60 = eventManager
        local r23_61 = { id = events.EID_LEVEL_RESTART_CLICKED, levelName = levelName }
        r23_60:notify(r23_61)
    elseif r23_0 == "GOTO_SHOP_POWERUPSLIDER" then
        eventManager:notify({ id = events.EID_SHOP_ENTERED_POWERUP_SLIDER })
        local r23_62 = ui.Shop:new({ openedFrom = "powerupSlider" })
        g_disableGameupdate = true
        local r23_63 = eventManager
        local r23_64 = { id = events.EID_PUSH_FRAME, target = r23_62 }
        r23_63:notify(r23_64)
        r23_62:scrollToShortCut("POWERUP", "bundle")
    elseif r23_0 == "GOTO_SHOP" then
        p23_0.drawTarget = r23_1
        releaseImages({ "GALLERY" })
    elseif r23_0 == "PURCHASE_ITEM" then
        if iapNotAllowedOnIOS() then
            return
        end
        ui.Shop:new({ name = "shop" }):purchaseItem(r23_1)
    elseif r23_0 == "BUY_BOUNTY_MISSIONS" then
        if isIapEnabled() then
            ui.Shop.initPaymentAndPurchases()
            local r23_65 = ui.Shop.getDataById(getEpisodeMetadataWithParam("bobaFett_1", "iapPurchaseId"))
            local r23_66 = ui.Shop.createIAPWindowForID(r23_65[ui.Shop.getIapPurchaseIdKey()])
            local r23_67 = screenWidth / 2
            r23_66.y = screenHeight / 2
            r23_66.x = r23_67
            local r23_68 = eventManager
            local r23_69 = { id = events.EID_PUSH_FRAME, target = r23_66 }
            r23_68:notify(r23_69)
        else
            local r23_70 = ui.ImagePrompt
            local r23_71 = {
                content = "Find hidden Jetpacks to unlock Boba Fett missions.",
                image = "COLLECT_JETPACK_POPUP",
                background = "BIG"
            }
            local r23_72 = r23_70:new(r23_71)
            local r23_73 = eventManager
            local r23_74 = { id = events.EID_PUSH_FRAME, target = r23_72 }
            r23_73:notify(r23_74)
        end
    else
        if r23_0 == "GOTO_SHOP_EPISODESELECTION" then
            local r23_75 = ui.Shop:new({ name = "shop", openedFrom = "episodeSelectionShopButton" })
            local r23_76 = eventManager
            local r23_77 = { id = events.EID_PUSH_FRAME, target = r23_75 }
            r23_76:notify(r23_77)
            return r23_0, r23_75
        end
        if r23_0 == "EMPEROR_CLICKED" then
            local r23_78 = ui.CrimsonSupportPrompt:new({ name = "crimsonSupportPrompt" })
            local r23_79 = eventManager
            local r23_80 = { id = events.EID_PUSH_FRAME, target = r23_78 }
            r23_79:notify(r23_80)
            eventManager:notify({ id = events.EID_CRIMSON_SUPPORT_OPENED })
            local r23_81 = "BLOCK"
            local r23_82, r23_83 = nil, nil
            return r23_81, r23_82, r23_83
        end
        if r23_0 == "GOTO_CHANNEL_EPISODESELECTION" then
            rovioChannel:openView("", "episode_selection")
            local r23_84 = eventManager
            local r23_85 = { id = events.EID_OPEN_CHANNEL, openedFrom = "episodeSelection" }
            r23_84:notify(r23_85)
        end
    end
    if p23_1 == "WHEEL" and not isInGameMode() then
        local r23_86 = g_gestureMenuTriggered
        if not (r23_86 > 0) then
            if cursor.wheel < 0 then
                updatePCCameraPanningToDirection(true)
            else
                updatePCCameraPanningToDirection(false)
            end
            local r23_87 = _G.math.min
            local r23_88 = _G.math.max
            local r23_89 = cursor.wheel
            g_wheelSpeed = r23_87(r23_88(r23_89 * 30, -30), 30)
        end
    end
end

-- line 2233-2240
-- proto#25 params=2 locals=0 upvalues=0 vararg=false
function GameScene:updateURLCallbackTimer(p25_1)
    if g_urlCallbackTimer then
        g_urlCallbackTimer = g_urlCallbackTimer - p25_1
        if g_urlCallbackTimer < 0 then
            g_urlCallbackTimer = nil
        end
    end
end

-- line 2242-4225
-- proto#26 params=3 locals=627 upvalues=0 vararg=false
function GameScene:update(p26_1, p26_2)
    updateCutscene(p26_1)
    updateBulletTime(p26_1)
    updateIapTimer(p26_1)
    self:updateTransition(p26_1, p26_2)
    self:updateFade(p26_1, p26_2)
    g_dt = p26_1
    if selectedBird ~= nil then
        g_targetVisualizationUserInputWaitTimer = TARGET_VISUALIZATION_WAIT_FOR_USER_INPUT
    end
    if g_birdEmitterTargets then
        for r26_0, r26_1 in _G.pairs(g_birdEmitterTargets) do
            local r26_2 = r26_1[6]
            local r26_3 = r26_2 or 0
            local r26_4
            if isPhysicsEnabled() then
                local r26_5 = 2 * p26_1
                local r26_6 = getDeltaTimeMultiplier()
                r26_4 = r26_3 + r26_5 / r26_6
            else
                r26_4 = r26_3
            end
            r26_1[6] = r26_4
        end
    end
    g_targetVisualizationUserInputWaitTimer = g_targetVisualizationUserInputWaitTimer - p26_1
    if g_targetVisualizationUserInputWaitTimer < 0 then
        g_targetVisualizationUserInputWaitTimer = TARGET_VISUALIZATION_WAIT_FOR_USER_INPUT
        g_showTargetVisualizationTimer = TARGET_VISUALIZATION_TIMER_TIME
    end
    if g_urlCallbackTimer then
        self:updateURLCallbackTimer(p26_1)
    end
    local r26_7 = self.heldByForceTimer
    self.heldByForceTimer = r26_7 + p26_1
    if not (maxZoomLevel == true or SettingsWrapper:isZoomingMarkedUsed() == true) then
        SettingsWrapper:markZoomingUsed()
    end
    if returningAudioVolume ~= nil then
        if returningAudioVolume < 1 then
            setEffectsVolume(returningAudioVolume)
            setMusicVolume(returningAudioVolume)
            returningAudioVolume = returningAudioVolume + p26_1
        else
            setEffectsVolume(1)
            setMusicVolume(1)
            returningAudioVolume = nil
        end
    end
    if keyPressed.F8 and releaseBuild ~= true then
        ui.Shop.initPaymentAndPurchases()
        reloadCrimsonSupportLua()
        local r26_8 = ui.PowerupIAPPopup:new({ name = "PowerupIAPPopup" })
        local r26_9 = eventManager
        local r26_10 = { id = events.EID_PUSH_FRAME, target = r26_8 }
        r26_9:notify(r26_10)
    end
    if isPCVersion() ~= true and keyPressed.F5 and releaseBuild ~= true then
        loadLuaFile(scriptPath .. "/menus/level_end.lua", "", false, false)
    end
    if not isPCVersion() and keyPressed.BACKSPACE and keyHold.CONTROL then
        if usedMightyEagle then
            replaceNextBirdWithME()
        else
            usedMightyEagle = true
            replaceSelectedBirdWithME()
        end
    end
    if not (isIOSFree() and isTimedGetFullVersionPageShown() or startedFromEditor) then
        self:checkForShowTutorial(false)
    end
    local r26_11 = g_gestureMenuTriggered
    if r26_11 > 0 then
        g_gestureMenuTriggered = g_gestureMenuTriggered - p26_1
    end
    if g_gestureMenuCursorHide and (cursor.x ~= 0 or cursor.y ~= 0) then
        g_gestureMenuCursorHide = false
    end
    if isPhysicsEnabled() and not (g_disableGameupdate == true or g_gameFailedState == true or g_gameCompletedState == true) then
        if clearAimingAidTimer ~= nil then
            local r26_12 = clearAimingAidTimer
            if r26_12 > 0 then
                clearAimingAidTimer = clearAimingAidTimer - p26_1 * 1.5
                clearAimingAid(1 - clearAimingAidTimer)
            else
                clearAimingAid(1)
                clearAimingAidTimer = nil
            end
        end
        if mightyEagleDisabled then
            local r26_13 = self.MEButton
            if r26_13 ~= nil then
                self:removeChild(r26_13)
                self.MEButton = nil
                r26_13.visible = false
                local r26_14 = self.MEGlow
                if r26_14 ~= nil then
                    r26_14.visible = false
                    self:removeChild(r26_14)
                    self.MEGlow = nil
                end
            end
            mightyEagleDisabled = false
            toggleCameraControl(false)
        end
        if mightyEagleBGAlpha ~= nil and mightyEagleBGAlphaDecreese then
            local r26_15 = mightyEagleBGAlpha
            if r26_15 > 0 then
                mightyEagleBGAlpha = mightyEagleBGAlpha - p26_1 * 3
                if mightyEagleBGAlpha < 0 then
                    mightyEagleBGAlpha = nil
                end
            end
        end
        if mightyEagleBHBG ~= nil and #mightyEagleBHBG > 0 then
            for r26_16, r26_17 in _G.pairs(mightyEagleBHBG) do
                if r26_17 ~= nil then
                    if r26_17.decreesing then
                        local r26_18 = r26_17.scale
                        if r26_17.endScale < r26_18 then
                            r26_17.scale = r26_17.scale - p26_1 * r26_17.multiplier * 2
                            local r26_19 = r26_17.multiplier
                            r26_17.multiplier = r26_19 + p26_1 * 2
                            setScale(r26_17.name, r26_17.scale, r26_17.scale)
                            local r26_20 = r26_17.scale * 0.5
                            setScale(r26_17.mightyEagleBHMask.name, r26_20, r26_17.scale * 0.5)
                        elseif objects.world[r26_17.name] ~= nil then
                            setObjectParameter(r26_17.mightyEagleBHMask.name, 33, 0)
                            setObjectParameter(r26_17.name, 33, 0)
                            destroyObject(r26_17.mightyEagleBHMask.name, true)
                            destroyObject(r26_17.name, true)
                        end
                    elseif r26_17.endScale + 0.5 > r26_17.scale then
                        r26_17.scale = r26_17.scale + p26_1 * r26_17.multiplier * 2
                        local r26_21 = r26_17.multiplier
                        r26_17.multiplier = r26_21 + p26_1 * 2
                        setScale(r26_17.name, r26_17.scale, r26_17.scale)
                        local r26_22 = r26_17.scale * 0.5
                        setScale(r26_17.mightyEagleBHMask.name, r26_22, r26_17.scale * 0.5)
                        if cameraShake ~= nil then
                            cameraShake.speed = cameraShake.speed + p26_1
                        end
                    else
                        r26_17.multiplier = 4
                    end
                end
            end
        end
        for r26_23, r26_24 in _G.pairs(objects.onTap) do
            local r26_25 = objects.world[r26_24]
            if r26_25 ~= nil and isKeyPressed("LBUTTON") then
                local r26_26, r26_27 = res.getSpriteBounds(r26_25.sprite)
                local r26_28, r26_29 = physicsToScreenTransform(r26_25.x, r26_25.y)
                local r26_30 = r26_26 * worldScale
                local r26_31 = r26_27 * worldScale
                local r26_32 = r26_30 * 0.5
                local r26_33 = r26_31 * 0.5
                if r26_28 - r26_32 < cursor.x and r26_28 + r26_32 > cursor.x and r26_29 - r26_33 < cursor.y and r26_29 + r26_33 > cursor.y then
                    local r26_34 = getObjectDefinition(r26_25.name)
                    if r26_34.onTap then
                        fireAction(r26_34.onTap, { name = r26_24 })
                    end
                end
            end
        end
        for r26_35, r26_36 in _G.pairs(objects.destroyableByTap) do
            local r26_37 = objects.world[r26_36]
            if r26_37 ~= nil and isKeyPressed("LBUTTON") then
                local r26_38, r26_39 = res.getSpriteBounds(r26_37.sprite)
                local r26_40, r26_41 = physicsToScreenTransform(r26_37.x, r26_37.y)
                local r26_42 = r26_38 * worldScale
                local r26_43 = r26_39 * worldScale
                local r26_44 = r26_42 * 0.5
                local r26_45 = r26_43 * 0.5
                local r26_46 = r26_41 + r26_45
                local r26_47 = r26_41 - r26_45
                if r26_40 - r26_44 < cursor.x and r26_40 + r26_44 > cursor.x then
                    local r26_48 = cursor.y
                    if r26_47 < r26_48 and cursor.y < r26_46 then
                        local r26_49 = blockTable.blocks[r26_37.definition]
                        if r26_49.isMainMenuObject then
                            SettingsWrapper:increesePoppedMainMenuItems()
                        end
                        objDef = getObjectDefinition(r26_37.name)
                        destroyObject(r26_36)
                        if objDef.removeJointsOnTap then
                            removeBreakableJointsFromObject(r26_36, 999999995904)
                        end
                    end
                end
            end
        end
        if objects.rotatingMenuJoint ~= nil and keyPressed.RBUTTON then
            if currentMenuMotorSpeed == 0 then
                currentMenuMotorSpeed = 500000
            else
                currentMenuMotorSpeed = 0
            end
            setRevoluteJointSpeed(objects.rotatingMenuJoint, currentMenuMotorSpeed)
        end
        if changeCameraTimer ~= nil and changeCameraTimer > 0 then
            changeCameraTimer = changeCameraTimer - p26_1
        end
        if isComicLevel and isKeyReleased("LBUTTON") then
            if skipSequenceClicks == nil then
                skipSequenceClicks = 1
            else
                skipSequenceClicks = skipSequenceClicks + 1
                local r26_50 = skipSequenceClicks
                if r26_50 > 2 then
                    local r26_51 = actions.myLevels[currentFolder]
                    if r26_51[currentLevel + 1] ~= nil then
                        storeLevelProgress(currentFolder, currentLevel)
                    end
                    setNextLevel()
                end
            end
        end
        timeSpentInLevel = timeSpentInLevel + p26_1
        for r26_52, r26_53 in _G.pairs(BHTrajectory) do
            if r26_53.timer <= 0 then
                BHTrajectory[r26_52] = nil
            else
                local r26_54 = r26_53.timer
                r26_53.timer = r26_54 - p26_1
            end
        end
        if timeWithoutLevelGoals ~= nil then
            timeWithoutLevelGoals = timeWithoutLevelGoals + p26_1
        end
        if timeWithoutBirds ~= nil then
            timeWithoutBirds = timeWithoutBirds + p26_1
        end
        for r26_55, r26_56 in _G.pairs(objects.animatedObjects) do
            local r26_57 = objects.world[r26_55]
            if r26_57 == nil then
                objects.animatedObjects[r26_55] = nil
            else
                local r26_58 = getObjectDefinition(r26_55)
                if r26_57.animateScaleX ~= nil then
                    local r26_59 = _G.math.sin(p26_2 * r26_57.frequencyX)
                    local r26_60 = r26_57.amplitudeX
                    r26_57.scaleXAdd = r26_59 * r26_60
                    local r26_61 = r26_57.originalScaleX + r26_57.scaleXAdd
                    setScale(r26_55, r26_61, r26_57.scaleY or 1)
                end
                if r26_57.animateScaleY ~= nil then
                    local r26_62 = _G.math.sin(p26_2 * r26_57.frequencyY)
                    local r26_63 = r26_57.amplitudeY
                    r26_57.scaleYAdd = r26_62 * r26_63
                    local r26_64 = r26_57.scaleX or 1
                    setScale(r26_55, r26_64, r26_57.originalScaleY + r26_57.scaleYAdd)
                end
                if r26_57.animateRotation then
                    if r26_58.constantRotation then
                        if r26_57.accSpriteAngle == nil then
                            r26_57.accSpriteAngle = 0
                        end
                        r26_57.accSpriteAngle = r26_57.accSpriteAngle + r26_57.rotationFrequency * p26_1
                        setSpriteRotation(r26_55, r26_57.accSpriteAngle)
                    else
                        local r26_65 = _G.math.sin(p26_2 * r26_57.rotationFrequency)
                        setSpriteRotation(r26_55, r26_65 * r26_57.rotationAmplitude)
                    end
                end
            end
        end
        for r26_66, r26_67 in _G.pairs(objects.animatedSprites) do
            local r26_68 = objects.spriteObjects[r26_66]
            if r26_68.animateScaleX ~= nil then
                local r26_69 = _G.math.sin(p26_2 * r26_68.frequencyX)
                local r26_70 = r26_68.amplitudeX
                r26_68.scaleXAdd = r26_69 * r26_70
            end
            if r26_68.animateScaleY ~= nil then
                local r26_71 = _G.math.sin(p26_2 * r26_68.frequencyY)
                local r26_72 = r26_68.amplitudeY
                r26_68.scaleYAdd = r26_71 * r26_72
            end
            if r26_68.animateRotation ~= nil then
                local r26_73 = _G.math.sin(p26_2 * r26_68.rotationFrequency)
                local r26_74 = r26_68.rotationAmplitude
                r26_68.angleAdd = r26_73 * r26_74
            end
        end
        for r26_75, r26_76 in _G.pairs(objects.levelStars) do
            applyForce(r26_75, 0, 20, r26_76.x, r26_76.y)
        end
        if selectedBird ~= nil and levelCompleted == false then
            objects.currentTimeStep = 0.011111111380159855
            enableGravityForBird(selectedBird.name, false)
        else
            objects.currentTimeStep = 0.03333333507180214
            aimingTrail = {}
        end
        for r26_77, r26_78 in _G.pairs(spawnList) do
            spawnObjects(r26_78.spawnedObjects, r26_78.info)
        end
        spawnList = {}
        if flyingBird ~= nil and flyingBird.ignoreGravityTimer ~= nil then
            local r26_79 = flyingBird.ignoreGravityTimer
            if r26_79 > 0 then
                flyingBird.ignoreGravityTimer = flyingBird.ignoreGravityTimer - p26_1
                if flyingBird.ignoreGravityTimer <= 0 or flyingBird.hasCollided then
                    flyingBird.ignoreGravityTimer = -1
                    enableGravityForBird(flyingBird.name, true)
                end
            end
        end
        if flyingBird ~= nil and flyingBird.hasCollided == true then
            if flyingBird.timeSinceCollision == nil then
                if flyingBird.definition == "RedBigBird" then
                    flyingBird.timeSinceCollision = 8
                else
                    flyingBird.timeSinceCollision = 0
                end
            end
            flyingBird.timeSinceCollision = flyingBird.timeSinceCollision + p26_1
        end
        if not (flyingBird == nil or flyingBird.laserField == nil) then
            flyingBird.prevX = flyingBird.x
            flyingBird.prevY = flyingBird.y
        end
        if flyingBird ~= nil and flyingBird.laserBoost ~= nil then
            local r26_80 = flyingBird.laserBoost.timer
            if r26_80 > 0 then
                flyingBird.laserBoost.timer = flyingBird.laserBoost.timer - p26_1
                local r26_81 = _G.math.sin(flyingBird.laserField.time * 50)
                flyingBird.laserBoost.posX = flyingBird.laserBoost.posX + r26_81 * 0.10000000149011612
                local r26_82 = _G.math.sin(flyingBird.laserField.time * 50)
                flyingBird.laserBoost.posY = flyingBird.laserBoost.posY + r26_82 * 0.10000000149011612
                setPosition(flyingBird.name, flyingBird.laserBoost.posX, flyingBird.laserBoost.posY)
            else
                local r26_83 = flyingBird.laserBoost.x * flyingBird.laserBoost.force
                applyImpulse(flyingBird.name, r26_83, flyingBird.laserBoost.y * flyingBird.laserBoost.force, flyingBird.x, flyingBird.y)
                flyingBird.laserBoost = nil
                flyingBird.laserField.scale = 1
            end
            flyingBird.laserField.time = flyingBird.laserField.time + p26_1
        end
        local r26_84, r26_85 = screenToWorldTransform(screen.x, 0)
        if g_showTargetVisualizationTimer then
            g_showTargetVisualizationTimer = g_showTargetVisualizationTimer - p26_1
            g_targetVisualizationRelativeTime = g_showTargetVisualizationTimer / TARGET_VISUALIZATION_TIMER_TIME
            if g_showTargetVisualizationTimer <= 0 then
                g_showTargetVisualizationTimer = nil
            end
        end
        for r26_86, r26_87 in _G.pairs(levelGoals) do
            if r26_87.material == "pig" or r26_87.frozenPig then
                updateMySensor(r26_86)
                local r26_88 = timeSpentInLevel
                if r26_88 > 1 and not r26_87.insideGravity and (r26_87.linkedBubble == nil or r26_87.linkedBubble == "" or objects.world[r26_87.linkedBubble] == nil) and objects.worldGravity == nil and (blockTable.blocks[r26_87.definition].frozenInVacuum == nil or blockTable.blocks[r26_87.definition].frozenInVacuum == true) then
                    r26_87.timeOutsideAtmosphere = r26_87.timeOutsideAtmosphere and r26_87.timeOutsideAtmosphere + p26_1 or 0
                    if r26_87.timeOutsideAtmosphere > 1.5 then
                        deadBlocks[r26_86] = r26_87
                        r26_87.strength = 0
                    end
                    if not r26_87.disableAnimations then
                        r26_87.spriteUnfreeze = r26_87.sprite
                        r26_87.materialUnfreeze = r26_87.material
                        local r26_89 = blockTable.blocks[r26_87.definition]
                        r26_87.sprite = r26_89.spriteFreeze
                        r26_87.material = "glass"
                        r26_87.frozenPig = true
                        r26_87.disableAnimations = true
                        setSprite(r26_86, r26_87.sprite)
                        r26_87.enteredState = false
                        setCurrentState(r26_87, "frozenState")
                        local r26_90 = getObjectDefinition(r26_87.name)
                        local r26_91 = r26_90.freezeSound
                        if r26_91 then
                            res.playAudio(r26_91)
                        end
                        local r26_92 = objects.world[r26_86]
                        if not freezingObjects then
                            freezingObjects = {
                                timer = 5.949999809265137,
                                x = r26_92.x,
                                y = r26_92.y,
                                objects = {},
                                sx = 0.25,
                                sy = 0.25
                            }
                        end
                        putParticles({ objectName = r26_92.name, particles = "iceExplosionPig" })
                        local r26_93
                        local r26_94
                        local r26_95, r26_96, r26_97, r26_98
                        if r26_87.width == nil then
                            if r26_87.radius == nil then
                                local r26_99 = res.getSpriteBounds
                                local r26_100 = blockTable.blocks[r26_87.definition]
                                r26_95, r26_96 = r26_99(r26_100.sprite)
                                r26_97, r26_98 = worldToPhysicsTransform(r26_95, r26_96)
                                local r26_101 = r26_98
                                r26_93 = r26_97
                                r26_94 = r26_101
                            else
                                local r26_102 = r26_87.radius
                                local r26_103 = r26_87.radius
                                r26_93 = r26_102
                                r26_94 = r26_103
                            end
                        elseif r26_87.height == nil then
                            if r26_87.radius == nil then
                                local r26_104 = res.getSpriteBounds
                                local r26_105 = blockTable.blocks[r26_87.definition]
                                r26_95, r26_96 = r26_104(r26_105.sprite)
                                r26_97, r26_98 = worldToPhysicsTransform(r26_95, r26_96)
                                local r26_106 = r26_98
                                r26_93 = r26_97
                                r26_94 = r26_106
                            else
                                local r26_107 = r26_87.radius
                                local r26_108 = r26_87.radius
                                r26_93 = r26_107
                                r26_94 = r26_108
                            end
                        else
                            local r26_109 = r26_87.width
                            local r26_110 = r26_87.height
                            r26_93 = r26_109
                            r26_94 = r26_110
                        end
                        local r26_111 = getSquaredDistanceFromOBBToPoint(r26_87.x, r26_87.y, r26_93, r26_94, r26_87.angle, r26_92.x, r26_92.y)
                        local r26_112 = _G.math.sqrt(r26_111.distance)
                        local r26_113
                        local r26_114
                        if r26_112 == 0 then
                            r26_113 = 0
                            r26_114 = -1
                        else
                            local r26_115, r26_116 = vNormalize(r26_111.pointX - r26_87.x, r26_111.pointY - r26_87.y)
                            r26_114 = r26_116
                            r26_113 = r26_115
                        end
                        local r26_117 = _G.math.random(1, 3)
                        local r26_118 = _G.math.random(1, 5)
                        local r26_119, r26_120 = worldToPhysicsTransform(res.getSpriteBounds(r26_87.sprite))
                        local r26_121 = r26_87.angle
                        local r26_122 = _G.math.atan2(r26_113, r26_114)
                        freezingObjects.objects[r26_86] = {
                            force = 0,
                            x = r26_113,
                            y = r26_114,
                            pointX = r26_111.pointX,
                            pointY = r26_111.pointY,
                            icicle = {
                                sprite = "P_ICICLE_" .. _G.string.format("%d", r26_117),
                                angle = r26_121,
                                x = r26_113 * r26_119 * 0.25,
                                y = r26_114 * r26_120 * 0.25
                            },
                            icicles = {},
                            timer = _G.math.random()
                        }
                        for r26_123 = 1, r26_118 do
                            local r26_124 = _G.math.random(1, 3)
                            local r26_125 = _G.math.random()
                            local r26_126 = _G.math.random()
                            local r26_127 = blockTable.blocks[r26_87.definition].type == "polygon" and true or _G.math.random() > 0.5
                            freezingObjects.objects[r26_86].icicles[r26_123] = {
                                sprite = "P_ICICLE_" .. _G.string.format("%d", r26_124),
                                angle = r26_121,
                                dm = r26_125 * 0.4000000059604645 - r26_126 * 0.4000000059604645,
                                side = r26_127
                            }
                        end
                    end
                end
            end
            if r26_87.material == "pig" and r26_87.frozenFromBomb ~= true and r26_87.disableAnimations and r26_87.insideGravity and r26_87.currentState == "frozenState" then
                r26_87.sprite = r26_87.spriteUnfreeze
                r26_87.material = r26_87.materialUnfreeze
                r26_87.disableAnimations = false
                setSprite(r26_86, r26_87.sprite)
                r26_87.timeOutsideAtmosphere = 0
                freezingObjects.objects[r26_86].timer = 0
                freezeObjects(freezingObjects.objects, 0)
                r26_87.enteredState = false
                setCurrentState(r26_87, "idleState")
            end
        end
        local r26_128 = isPCVersion()
        updateEventCalls(p26_1)
        local r26_129 = repopulationTimer
        if r26_129 > 0 then
            repopulationTimer = repopulationTimer - p26_1
        else
            repopulationTimer = 0.10000000149011612
            rePopulateWithRandomThemeSprites()
        end
        if updateCalls ~= nil then
            for r26_130, r26_131 in _G.pairs(updateCalls) do
                if actions[r26_131.actionName] ~= nil then
                    if r26_131.params == nil then
                        r26_131.params = {}
                    end
                    r26_131.params.dt = p26_1
                    _G.assert(actions[r26_131.actionName] ~= nil, "Failed to find action " .. r26_131.actionName)
                    local r26_132 = actions[r26_131.actionName]
                    r26_132.action(r26_131.params)
                end
            end
        end
        if freezingObjects ~= nil and not (freezingObjects.timer < 0) then
            freezingObjects.timer = freezingObjects.timer - p26_1
            freezingObjects.sx = freezingObjects.sx + p26_1 * 15
            freezingObjects.sy = freezingObjects.sy + p26_1 * 15
        end
        forceLightningObjects = {}
        for r26_133, r26_134 in _G.pairs(objects.world) do
            if r26_134.bubbleSoundTimer then
                r26_134.bubbleSoundTimer = r26_134.bubbleSoundTimer - p26_1
                if r26_134.bubbleSoundTimer <= 0 then
                    r26_134.bubbleSoundTimer = nil
                    if flyingBird and blockTable.blocks[flyingBird.definition].sounds.special_loop then
                        local r26_135 = blockTable.blocks[flyingBird.definition]
                        stopAudio(r26_135.sounds.special_loop)
                    end
                end
            end
            if r26_134.inBubble or r26_134.bubblePrimaryTarget then
                if r26_134.bubbleBeamTimer then
                    r26_134.bubbleBeamTimer = r26_134.bubbleBeamTimer - p26_1
                    if r26_134.bubbleBeamTimer < 0 then
                        if r26_134.bubbleBeamPhase == 1 then
                            if r26_134.destroyWhenBeamHits then
                                destroyObject(r26_134.name)
                            else
                                r26_134.bubbleBeamPhase = 2
                                local r26_136
                                if r26_134.reticleName then
                                    r26_136 = objects.world[r26_134.reticleName]
                                else
                                    r26_136 = r26_134
                                end
                                if r26_136 then
                                    local r26_137 = blockTable.blocks[r26_136.definition]
                                    r26_134.bubbleBeamTimer = r26_134.bubbleBeamTimer + r26_137.specialtyBeamPhase2Time
                                else
                                    r26_134.bubbleBeamTimer = nil
                                end
                            end
                        else
                            r26_134.bubbleBeamTimer = nil
                        end
                        if r26_134.bubblePrimaryTarget then
                            r26_134.bubblePrimaryTarget = false
                            if not r26_134.inBubble and g_birdEmitterTargets[r26_134.reticleName] then
                                g_birdEmitterTargets[r26_134.reticleName] = nil
                            end
                        end
                    end
                end
                if r26_134.bubbleBeamAnimationTimer then
                    r26_134.bubbleBeamAnimationTimer = r26_134.bubbleBeamAnimationTimer + p26_1
                    local r26_138 = r26_134.bubbleBeamAnimationTimer
                    if r26_138 > 0.029999999329447746 then
                        r26_134.bubbleBeamAnimationTimer = r26_134.bubbleBeamAnimationTimer - 0.029999999329447746
                        r26_134.bubbleBeamAnimationFrame = r26_134.bubbleBeamAnimationFrame + 1
                        local r26_139 = r26_134.bubbleBeamAnimationFrame
                        if r26_139 > 4 then
                            r26_134.bubbleBeamAnimationFrame = 1
                        end
                    end
                end
            end
            local r26_140 = r26_134.inBubble
            local r26_141 = r26_134
            if r26_140 and r26_134.bubbleAntiGravityTimer then
                local r26_142 = r26_134.bubbleAntiGravityTimer
                if r26_142 > 0 then
                    r26_134.bubbleAntiGravityTimer = r26_134.bubbleAntiGravityTimer - p26_1
                    if objects.worldGravity then
                        r26_134.velocity = r26_134.velocity or 0
                        local r26_143 = r26_134.velocity
                        local r26_144 = r26_134.specialtyMaximumVelocity
                        if r26_143 < r26_144 and (not r26_134.gravityFilterCategory or r26_134.gravityFilterCategory ~= "IGNOREGRAVITY" and r26_134.gravityFilterCategory ~= "FORCE_OBJECT" and r26_134.gravityFilterCategory ~= "YODA_FORCE_OBJECT" and r26_134.gravityFilterCategory ~= "HOVERING_OBJECT") then
                            local r26_145 = -objects.worldGravity * r26_134.mass
                            applyForce(r26_134.name, 0, r26_145 * r26_134.specialtyClassicGravityMultiplier, r26_134.x, r26_134.y)
                        end
                    end
                else
                    if flyingBird and isAudioPlaying(blockTable.blocks[flyingBird.definition].sounds.special_loop) then
                        local r26_146 = blockTable.blocks[flyingBird.definition]
                        stopAudio(r26_146.sounds.special_loop)
                    end
                    r26_134.bubbleAntiGravityTimer = nil
                    r26_134.inBubble = nil
                    setRevertGravityWithMultiplier(r26_134.name, false, 0, 0)
                    if g_birdEmitterTargets[r26_134.reticleName] then
                        g_birdEmitterTargets[r26_134.reticleName] = nil
                    end
                    if r26_134.controllable then
                        removeBird(r26_134)
                        r26_141 = nil
                    end
                end
            end
            if r26_134.removeEmitterTargetTimer then
                r26_134.removeEmitterTargetTimer = r26_134.removeEmitterTargetTimer - p26_1
                if r26_134.removeEmitterTargetTimer <= 0 then
                    r26_134.removeEmitterTargetTimer = nil
                    if g_birdEmitterTargets[r26_134.name] ~= nil then
                        g_birdEmitterTargets[r26_134.name] = nil
                    end
                end
            end
            if r26_134.isAffectedByForceTimer ~= nil then
                local r26_147 = r26_134.isAffectedByForceTimer
                if r26_147 > 0 then
                    r26_134.isAffectedByForceTimer = r26_134.isAffectedByForceTimer - p26_1
                    if r26_134.isAffectedByForceTimer <= 0 then
                        r26_134.isAffectedByForceTimer = nil
                        if g_birdEmitterTargets[currentForceTarget] ~= nil then
                            g_birdEmitterTargets[currentForceTarget] = nil
                        end
                    end
                end
            end
            if r26_134.isHeldByForceTimer ~= nil then
                local r26_148 = r26_134.isHeldByForceTimer
                if r26_148 > 0 then
                    r26_134.isHeldByForceTimer = r26_134.isHeldByForceTimer - p26_1
                    if r26_134.isHeldByForceTimer <= 0 then
                        r26_134.isHeldByForceTimer = nil
                    end
                end
            end
            if r26_134.struckByLightning then
                _G.table.insert(forceLightningObjects, r26_134)
            end
        end
        local r26_149, r26_150 = self.pauseButton, self.restartButton
        if isPCVersion() and isInGameMode() and not g_laserBirdCursorException and selectedBird == nil and (r26_149 == nil or not r26_149:hitTest(cursor.x, cursor.y)) and (r26_150 == nil or not r26_150:hitTest(cursor.x, cursor.y)) and (flyingBird == nil or not birdSpecialtyAvailable or getObjectDefinition(flyingBird.name).specialty ~= "LAZER_SHOT" and getObjectDefinition(flyingBird.name).specialty ~= "GRAVITY_DISRUPTOR" and getObjectDefinition(flyingBird.name).specialty ~= "BOMB") then
            if isKeyHold("LBUTTON") then
                g_currentCursorName = "CURSOR_HAND_GRAB"
            else
                g_currentCursorName = "CURSOR_HAND_HOVER"
            end
        end
        if r26_128 == true then
            updatePCMouseDragging(p26_1, p26_2)
            if isInGameMode() and not isLevelEnded() then
                updatePCCameraPanning()
            end
            updatePCGesturePause(p26_1, p26_2)
            if rubberBandLength < 0.10000000149011612 then
                clearAimingAid(1)
            end
        end
        self.currentFrame = self.currentFrame + 1
        updateAnimations(p26_1)
        oldCursorWorld.x = cursorWorld.x
        oldCursorWorld.y = cursorWorld.y
        local r26_151 = cursorPhysics
        local r26_152 = cursorPhysics
        local r26_153, r26_154 = screenToPhysicsTransform(cursor.x, cursor.y)
        r26_152.y = r26_154
        r26_151.x = r26_153
        local r26_155 = cursorWorld
        local r26_156 = cursorWorld
        local r26_157, r26_158 = screenToWorldTransform(cursor.x, cursor.y)
        r26_156.y = r26_158
        r26_155.x = r26_157
        local r26_159 = p26_2 - lastTimeSetDCursor
        if r26_159 > 0.029999999329447746 then
            local r26_160 = delayedCursorPhysics
            local r26_161 = delayedCursorPhysics
            local r26_162 = cursorPhysics.x
            r26_161.y = cursorPhysics.y
            r26_160.x = r26_162
            local r26_163 = previousDelayedCursorPhysics
            local r26_164 = previousDelayedCursorPhysics
            local r26_165 = previousCursorPoint.x
            r26_164.y = previousCursorPoint.y
            r26_163.x = r26_165
            lastTimeSetDCursor = p26_2
        end
        rightSweep = false
        leftSweep = false
        quadClickTimer = quadClickTimer - p26_1
        if keyPressed.ESCAPE and not releaseBuild and startedFromEditor then
            setEditing(true)
            setPhysicsEnabled(false)
            local r26_166 = eventManager
            local r26_167 = { id = events.EID_CHANGE_SCENE, target = "editorScene" }
            r26_166:notify(r26_167)
        end
        if not isPCVersion() and keyPressed.F9 and not releaseBuild then
            initializeEventSystem()
            if not startedFromEditor then
                initializeGameMenus()
            end
            g_explodingBomb = false
            setLevelLoadingAfterRestartFromGame()
            return
        end
        if levelStartTimer == 0 then
            levelStartTimer = levelStartTimer + 0.009999999776482582
            local r26_168 = blockTable.themes[currentTheme]
            local r26_169 = r26_168.levelStartSound
            if isInGameMode() and r26_169 and r26_169 ~= "" then
                res.playAudio("level_start_military")
            end
            currentBirdIndex = 0
            fillInNextBird = true
        end
        if keyPressed.MBUTTON and showEditor then
            setWorldScale(1)
            worldScale = 1
        end
        gameTimer = gameTimer + p26_1
        if isInGameMode() then
            local r26_170 = levelCompleteTimer
            if r26_170 > 0 then
                updateLevelEnding(p26_1)
            else
                if quadClick == true and cheatsEnabled == true then
                    g_threeStarsCheat = true
                end
                if checkLevelComplete(p26_1) or g_threeStarsCheat == true and cheatsEnabled == true then
                    initLevelComplete()
                    eventManager:notify({ id = events.EID_LEVEL_WILL_END })
                end
                if checkLevelFailed() then
                    initLevelFailed(p26_1)
                end
            end
            if tapStarted then
                tapTimer = tapTimer + p26_1
                local r26_171 = tapTimer
                if r26_171 > 0.25 then
                    if tapCount == 1 and cameraAnimationSliderTarget == 1 and birdSpecialtyAvailable == false and cameraTargetObject == nil and not g_usingGestureControls then
                        local r26_172 = objects.castleCameraData[deviceModel]
                        local r26_173 = objects.birdCameraData[deviceModel]
                        moveToBirdCamera(_G.math.abs(r26_172.px - r26_173.px))
                        flyingBird = nil
                    end
                    if tapCount == 2 then
                        if cameraAnimationSliderTarget == 0 then
                            local r26_174 = objects.birdCameraData[deviceModel]
                            currentZoomedScale = r26_174.sx
                        else
                            local r26_175 = objects.castleCameraData[deviceModel]
                            currentZoomedScale = r26_175.sx
                        end
                        maxZoomLevel = true
                    end
                    tapTimer = 0
                    tapCount = 0
                    tapStarted = false
                end
            end
        end
        if flyingBird ~= nil and not flyingBird.hasCollided and isKeyHold("LBUTTON") and not levelCompleted then
            local r26_176 = getObjectDefinition(flyingBird.name)
            birdSpecialty = r26_176.specialty
        end
        if not (birdSpecialtyAvailable and g_usingGestureControls) then
            g_laserGestureMode = false
        end
        if g_laserGestureMode then
            laser_cursor.x = _G.math.min(screenWidth, _G.math.max(0, laser_cursor.x + cursor.x))
            laser_cursor.y = _G.math.min(screenHeight, _G.math.max(0, laser_cursor.y + cursor.y))
        end
        local r26_177 = false
        if (isKeyPressed("LBUTTON") or g_usingGestureControls and not g_laserGestureMode and touchcount == 1) and not levelCompleted and g_refusedDragTargetting ~= true and not ignorePlayerInput then
            draggingStartPosPhysics.x = cursorPhysics.x
            draggingStartPosPhysics.y = cursorPhysics.y
            draggingStartPosScreen.x = cursor.x
            draggingStartPosScreen.y = cursor.y
            oldCursor.x = cursor.x
            oldCursor.y = cursor.y
            if selectedBird == nil then
                delayedCursorPhysics.x = cursorPhysics.x
                delayedCursorPhysics.y = cursorPhysics.y
            end
            if flyingBird and not flyingBird.clickRegistered then
                eventManager:notify({ id = events.EID_BIRD_SPECIALTY_USED })
                flyingBird.clickRegistered = true
            end
            if flyingBird ~= nil then
                if birdSpecialtyAvailable then
                    birdSpecialtyUsed = true
                    r26_177 = true
                    g_touch_released_after_specialty = false
                    birdSpecialtyAvailable = false
                    g_laserBirdCursorException = true
                    local r26_178 = getObjectDefinition(flyingBird.name)
                    birdSpecialty = r26_178.specialty
                    local r26_179, r26_180 = screenToPhysicsTransform(cursor.x, cursor.y)
                    if birdSpecialty == "Mighty_Falcon" then
                        for r26_181, r26_182 in _G.pairs(levelGoals) do
                            setCurrentState(r26_182, "nervousState")
                        end
                        fireAction("callMightyFalcon", {
                            name = flyingBird.name,
                            specialty = birdSpecialty,
                            dt = p26_1
                        })
                        clearAimingAidTimer = 1
                    end
                    if birdSpecialty == "BOMB" and flyingBird ~= nil then
                        if r26_178.forceBomb then
                            if r26_178.forceBombTargetWithClick then
                                local r26_183, r26_184 = screenToPhysicsTransform(cursor.x, cursor.y)
                                local r26_185 = g_laserGestureMode
                                local r26_186
                                local r26_187
                                if r26_185 then
                                    local r26_188, r26_189 = screenToPhysicsTransform(laser_cursor.x, laser_cursor.y)
                                    r26_190 = r26_189
                                    r26_186 = r26_188
                                    r26_187 = r26_190
                                else
                                    r26_186 = r26_183
                                    r26_187 = r26_184
                                end
                                if r26_185 then
                                    local r26_190
                                    r26_187 = r26_190
                                else
                                    r26_187 = r26_184
                                end
                                setRotation(flyingBird.name, _G.math.atan2(r26_187 - flyingBird.y, r26_186 - flyingBird.x))
                                if g_birdEmitterTargets[currentForceTarget] ~= nil then
                                    g_birdEmitterTargets[currentForceTarget] = nil
                                end
                                g_birdEmitterTargets[flyingBird.name] = {
                                    r26_186,
                                    r26_187,
                                    nil,
                                    length,
                                    r26_178.reticleSprite
                                }
                                currentForceTarget = flyingBird.name
                            end
                            flyingBird.ignoreBomb = true
                            flyingBird.bombTimer = nil
                            flyingBird.rotateWhileFlying = false
                        end
                        addBirdSpecialParticles(flyingBird)
                        fireAction("useBombSpecialty", {
                            name = flyingBird.name,
                            specialty = birdSpecialty,
                            dt = p26_1
                        })
                        clearAimingAidTimer = 1
                        g_laserGestureMode = false
                    end
                    if birdSpecialty == "SWORD" and flyingBird ~= nil then
                        addBirdSpecialParticles(flyingBird)
                        fireAction("useSwordSpecialty", {
                            name = flyingBird.name,
                            specialty = birdSpecialty,
                            dt = p26_1
                        })
                        clearAimingAidTimer = 1
                    end
                    if birdSpecialty == "GRAVITY_DISRUPTOR" and flyingBird ~= nil then
                        local r26_191, r26_192 = screenToPhysicsTransform(cursor.x, cursor.y)
                        local r26_193 = g_laserGestureMode
                        local r26_194
                        local r26_195
                        if r26_193 then
                            local r26_196, r26_197 = screenToPhysicsTransform(laser_cursor.x, laser_cursor.y)
                            r26_198 = r26_197
                            local r26_199 = r26_196
                            g_laserGestureMode = false
                            r26_194 = r26_199
                            r26_195 = r26_198
                        else
                            r26_194 = r26_191
                            r26_195 = r26_192
                        end
                        if r26_193 then
                            local r26_198
                            r26_195 = r26_198
                        else
                            r26_195 = r26_192
                        end
                        setRotation(flyingBird.name, _G.math.atan2(r26_195 - flyingBird.y, r26_194 - flyingBird.x))
                        flyingBird.rotateWhileFlying = false
                        g_birdEmitterTargets[flyingBird.name] = {
                            r26_194,
                            r26_195,
                            nil,
                            nil,
                            r26_178.reticleSprite,
                            r26_178.specialtyDuration
                        }
                        flyingBird.removeEmitterTargetTimer = r26_178.specialtyDuration
                        fireAction("usePinkBirdSpecialty", {
                            name = flyingBird.name,
                            xPos = r26_194,
                            yPos = r26_195,
                            dt = p26_1
                        })
                    end
                    if birdSpecialty == "GLOBE" and flyingBird ~= nil then
                        addBirdSpecialParticles(flyingBird)
                        fireAction("GlobeBirdActivated", {
                            name = flyingBird.name,
                            specialty = birdSpecialty,
                            dt = p26_1
                        })
                        clearAimingAidTimer = 1
                    end
                    if birdSpecialty == "LAZER_SHOT" then
                        local r26_200 = g_laserGestureMode
                        local r26_201
                        local r26_202
                        if r26_200 then
                            local r26_203, r26_204 = screenToPhysicsTransform(laser_cursor.x, laser_cursor.y)
                            r26_205 = r26_204
                            local r26_206 = r26_203
                            g_laserGestureMode = false
                            r26_201 = r26_206
                            r26_202 = r26_205
                        else
                            r26_201 = r26_179
                            r26_202 = r26_180
                        end
                        if r26_200 then
                            local r26_205
                            r26_202 = r26_205
                        else
                            r26_202 = r26_180
                        end
                        addEventCall("useLazerShotSpecialty", {
                            name = flyingBird.name,
                            xPos = r26_201,
                            yPos = r26_202
                        })
                    end
                    if birdSpecialty == "CLUSTER_BOMB" then
                        addBirdSpecialParticles(flyingBird)
                        fireAction("useClusterSpecialty", { name = flyingBird.name, dt = p26_1 })
                    end
                    if birdSpecialty == "THREE_SPLIT" or birdSpecialty == "THREE_SPLIT_EXPLOSION" then
                        addBirdSpecialParticles(flyingBird)
                        fireAction("useClusterSpecialty", { name = flyingBird.name, dt = p26_1 })
                    end
                    if birdSpecialty == "ROBOT_3CPO" then
                        addBirdSpecialParticles(flyingBird)
                        fireAction("use3CPOSpecialty", { name = flyingBird.name, dt = p26_1 })
                    end
                    if birdSpecialty == "ROBOT_R2D2" then
                        addBirdSpecialParticles(flyingBird)
                        fireAction("useR2D2Specialty", { name = flyingBird.name, dt = p26_1 })
                    end
                elseif not g_usingGestureControls then
                    storeCameraPosition()
                    if isInGameMode() then
                        cameraAnimationSlider = getSliderPosition(getTempBirdCamera(), getTempCastleCamera(), screen.x, screen.y, false)
                    elseif dragStarted == false then
                        local r26_207, r26_208, r26_209 = findClosestCameras(screen.x, screen.y)
                        changeCameras(r26_207)
                        cameraAnimationSlider = getSliderPosition(getTempBirdCamera(), getTempCastleCamera(), screen.x, screen.y, false)
                    end
                end
            end
        end
        if not (g_usingGestureControls or not keyReleased.LBUTTON) or g_usingGestureControls and touchcount == 0 then
            g_touch_released_after_specialty = true
        end
        local r26_210
        if g_usingGestureControls then
            if touchcount == 1 then
                if dragStarted then
                    r26_210 = false
                else
                    local r26_211 = g_touch_released_after_specialty
                    if r26_211 then
                        if birdSpecialtyAvailable then
                            r26_210 = false
                        else
                            r26_210 = isTouchDragAllowed()
                        end
                    else
                        r26_210 = r26_211
                    end
                end
            else
                r26_210 = false
            end
        else
            r26_210 = isKeyPressed("LBUTTON")
        end
        if r26_210 and not r26_177 then
            if tapStarted == false and g_refusedDragTargetting ~= true then
                tapPosition.x = cursor.x
                tapPosition.y = cursor.y
                tapStarted = true
                tapTimer = 0
            end
            dragStarted = true
            dragCursorTable = {}
            dragCursorIndex = 1
            dragCursorTable[dragCursorIndex] = { dx = 0, dy = 0, dt = p26_1 }
            tapPosWorld.x = cursorWorld.x
            tapPosWorld.y = cursorWorld.y
            if touchcount == 1 and currentBirdName ~= nil and not ignorePlayerInput and not levelCompleted and not levelFailed then
                local r26_212 = objects.world[currentBirdName]
                if g_usingGestureControls or distance(r26_212.x, r26_212.y, cursorPhysics.x, cursorPhysics.y) < shootRange / worldScale * screenWidth / 480 then
                    selectedBird = r26_212
                    if cameraFunction == levelStartCamera then
                        cameraFunction = doItAllCamera
                    end
                    handleBirdSelected(p26_2, p26_1)
                    eventManager:notify({ id = events.EID_BIRD_NEW_DRAG_INITIATED })
                    if g_usingGestureControls then
                        local r26_213, r26_214 = _G.next(touches)
                        local r26_215, r26_216 = screenToPhysicsTransform(r26_214.x, r26_214.y)
                        bird_touch_begin_y = r26_216
                        bird_touch_begin_x = r26_215
                        local r26_217 = bird_touch_begin_x
                        last_touch_y = bird_touch_begin_y
                        last_touch_x = r26_217
                        local r26_218 = objects.castleCameraData[deviceModel]
                        local r26_219 = objects.birdCameraData[deviceModel]
                        moveToBirdCamera(_G.math.abs(r26_218.px - r26_219.px))
                    end
                end
            end
        end
        local r26_220, r26_221 = _G.next(touches)
        local r26_222
        if r26_128 then
            if multitouchSweep.isSweepping then
                r26_222 = false
            else
                r26_222 = touchcount < 2
            end
        else
            r26_222 = true
        end
        local r26_223
        if deviceModel == "windows" then
            r26_223 = false
        else
            r26_223 = deviceModel ~= "osx"
        end
        if g_useNewBirdLaunch and r26_223 then
            if selectedBird ~= nil and levelCompleted == false then
                updateDraggingCursorLagOnly(p26_2, p26_1)
            elseif selectedBird == nil then
                clearDraggingCursor()
            end
        elseif g_usingGestureControls then
            g_aimingAidCursor.cursorToUse = {}
            g_aimingAidCursor.cursorToUse.x = levelStartPosition.x + (last_touch_x - bird_touch_begin_x)
            g_aimingAidCursor.cursorToUse.y = levelStartPosition.y + (last_touch_y - bird_touch_begin_y)
        else
            g_aimingAidCursor.cursorToUse = {}
            g_aimingAidCursor.cursorToUse.x = cursorPhysics.x
            g_aimingAidCursor.cursorToUse.y = cursorPhysics.y
        end
        if (not (g_usingGestureControls or not isKeyHold("LBUTTON")) or g_usingGestureControls and touchcount == 1) and not levelCompleted and r26_222 then
            local r26_224 = cursorPhysics
            if g_useNewBirdLaunch then
                local r26_225
                r26_224 = r26_225.cursorToUse
            end
            if dragStarted == true then
                dragCursorIndex = dragCursorIndex + 1
                local r26_226 = dragCursorIndex
                if r26_226 > 5 then
                    dragCursorIndex = 1
                end
                dragCursorTable[dragCursorIndex] = {
                    dx = cursor.x - oldCursor.x,
                    dy = cursor.y - oldCursor.y,
                    dt = p26_1
                }
                if selectedBird == nil then
                    if not ignoreCameraSweep then
                        assert(objects.castleCameraData ~= nil)
                        assert(objects.birdCameraData ~= nil)
                        local r26_227 = objects.castleCameraData[deviceModel]
                        local r26_228 = objects.birdCameraData[deviceModel]
                        local r26_229 = _G.math.abs(r26_227.px - r26_228.px)
                        local r26_230 = objects.castleCameraData[deviceModel]
                        local r26_231 = objects.birdCameraData[deviceModel]
                        local r26_232 = _G.math.abs(r26_230.py - r26_231.py)
                        local r26_233 = getLevelMetadata(levelName)
                        if r26_233.horizontalCameraSweep then
                            r26_232 = 0
                        end
                        if r26_232 < r26_229 then
                            if r26_229 > 1 then
                                local r26_234 = dragCursorTable[dragCursorIndex]
                                local r26_235 = r26_234.dx / (r26_229 * worldScale)
                                sweepSpeed = 0
                                isSwipingCamera = true
                                cameraAnimationSlider = cameraAnimationSlider - r26_235
                                cameraFunction = doItAllCamera
                                if cameraTargetObject ~= nil and (flyingBird == nil or flyingBird.name ~= cameraTargetObject.name) then
                                    setCameraTargetObject(nil)
                                end
                            end
                        elseif r26_232 > 1 then
                            local r26_236 = dragCursorTable[dragCursorIndex]
                            local r26_237 = r26_236.dy / (r26_232 * worldScale)
                            sweepSpeed = 0
                            isSwipingCamera = true
                            cameraAnimationSlider = cameraAnimationSlider - r26_237
                            cameraFunction = doItAllCamera
                            if cameraTargetObject ~= nil and (flyingBird == nil or flyingBird.name ~= cameraTargetObject.name) then
                                setCameraTargetObject(nil)
                            end
                        end
                        local r26_238 = getNumCameras()
                        if r26_238 > 2 and not isInGameMode() then
                            local r26_239 = cameraAnimationSlider
                            if r26_239 > 1 then
                                changeCameras(currentCamera + 1)
                            elseif cameraAnimationSlider < 0 then
                                changeCameras(currentCamera - 1)
                            end
                        end
                    end
                else
                    draggingStartPosPhysics.x = levelStartPosition.x
                    draggingStartPosPhysics.y = levelStartPosition.y
                    if birdReady == true then
                        local r26_240, r26_241 = nil, nil
                        local r26_242
                        local r26_243
                        if g_usingGestureControls then
                            local r26_244, r26_245 = _G.next(touches)
                            local r26_246, r26_247 = screenToPhysicsTransform(r26_245.x, r26_245.y)
                            local r26_248 = r26_246
                            last_touch_y = r26_247
                            last_touch_x = r26_248
                            r26_242 = distance(bird_touch_begin_x, bird_touch_begin_y, r26_246, r26_247)
                            r26_243 = {
                                x = bird_touch_begin_x - r26_246,
                                y = bird_touch_begin_y - r26_247
                            }
                        else
                            r26_242 = distance(draggingStartPosPhysics.x, draggingStartPosPhysics.y, r26_224.x, r26_224.y)
                            r26_243 = {
                                x = draggingStartPosPhysics.x - r26_224.x,
                                y = draggingStartPosPhysics.y - r26_224.y
                            }
                        end
                        rubberBandAngle = _G.math.atan2(r26_243.y, r26_243.x)
                        shootMaxLength = shootRange + 3.200000047683716
                        local r26_249 = shootMaxLength
                        if r26_242 < r26_249 then
                            local r26_250 = rubberBandPos
                            local r26_251 = rubberBandPos
                            local r26_252 = r26_224.x
                            r26_251.y = r26_224.y
                            r26_250.x = r26_252
                            rubberBandLength = r26_242
                            local r26_253 = _G.math.abs(rubberBandLength - oldRubberBandLength)
                            if r26_253 > 0.10000000149011612 and res.isAudioPlaying("slingshot_stretched") == false and rubberBandLength > 0.10000000149011612 then
                                res.playAudio("slingshot_stretched")
                            end
                            oldRubberBandLength = rubberBandLength
                            if birdSelected == false then
                                birdSelected = true
                            end
                        else
                            _G.assert(r26_242 ~= 0, "Buahahaa, div by zero")
                            rubberBandPos.x = draggingStartPosPhysics.x - r26_243.x * shootMaxLength / r26_242
                            rubberBandPos.y = draggingStartPosPhysics.y - r26_243.y * shootMaxLength / r26_242
                            rubberBandLength = shootMaxLength
                            rubberBandSpeed = 0
                            if birdSelected == false then
                                res.playAudio("slingshot_stretched")
                                birdSelected = true
                            end
                        end
                        local r26_254 = 1
                        if r26_254 * shootMaxLength < rubberBandLength then
                            rubberBandPos.y = draggingStartPosPhysics.y - shootMaxLength * r26_254 * r26_243.y / r26_242
                            rubberBandLength = distance(draggingStartPosPhysics.x, draggingStartPosPhysics.y, rubberBandPos.x, rubberBandPos.y)
                        end
                        handleBirdIsBeingMoved(p26_2, p26_1)
                    end
                end
            end
        end
        if not (not (g_usingGestureControls or not isKeyReleased("LBUTTON") and isKeyHold("LBUTTON")) or g_usingGestureControls and touchcount == 0) or not r26_222 then
            if g_usingGestureControls and touchcount > 1 and dragStarted then
                cancelBirdDrag()
            end
        else
            if g_laserBirdCursorException then
                g_laserBirdCursorException = false
            end
            if dragStarted then
                dragStarted = false
                leftSweep = false
                rightSweep = false
                local r26_255
                if g_usingGestureControls then
                    r26_255 = distance(bird_touch_begin_x, bird_touch_begin_y, last_touch_x, last_touch_y)
                else
                    r26_255 = distance(draggingStartPosPhysics.x, draggingStartPosPhysics.y, cursorPhysics.x, cursorPhysics.y)
                end
                if shootMaxLength == nil or shootMaxLength <= 0 or rubberBandLength <= 0 or rubberBandLength == nil or r26_255 <= 0 then
                    selectedBird = nil
                end
                local r26_256 = g_birdDragOnTouchAttributes.shootMinLength
                if r26_255 <= r26_256 then
                    cancelBirdDrag()
                end
                if selectedBird == nil or levelCompleted then
                    local r26_257, r26_258, r26_259, r26_260 = 1, 0, 0, 0
                    while #dragCursorTable >= r26_257 do
                        r26_260 = r26_260 + dragCursorTable[r26_257].dt
                        r26_258 = r26_258 + dragCursorTable[r26_257].dx
                        r26_259 = r26_259 + dragCursorTable[r26_257].dy
                        r26_257 = r26_257 + 1
                    end
                    local r26_261 = r26_258 / r26_260
                    local r26_262 = r26_259 / r26_260
                    local r26_263
                    if r26_128 == true then
                        local r26_264 = g_mouseDragAttributes.mouseDragTime
                        if g_mouseDragAttributes.minDragTime < r26_264 then
                            local r26_265 = g_mouseDragAttributes.cummulativeDragX
                            local r26_266 = g_mouseDragAttributes.mouseDragTime
                            r26_263 = r26_265 / r26_266
                        else
                            r26_263 = 0
                        end
                    else
                        r26_263 = r26_261
                    end
                    dragCursorTable = {}
                    if r26_128 == true then
                        dragCursorIndex = 0
                    end
                    local r26_267 = distance(draggingStartPosScreen.x, draggingStartPosScreen.y, cursor.x, cursor.y)
                    if screenWidth * 0.10000000149011612 < r26_267 or _G.math.abs(r26_263) > 200 or _G.math.abs(r26_262) > 200 then
                        sweepSpeed = r26_263
                        local r26_268 = _G.math.abs(r26_263)
                        if r26_268 > 0 and not ignoreCameraSweep then
                            local r26_269, r26_270 = objects.castleCameraData[deviceModel], objects.birdCameraData[deviceModel]
                            dx = _G.math.abs(r26_269.px - r26_270.px)
                            local r26_271 = _G.math.abs
                            local r26_272 = r26_269.py
                            local r26_273 = r26_270.py
                            dy = r26_271(r26_272 - r26_273)
                            local r26_274 = dy < dx
                            local r26_275 = getLevelMetadata(levelName)
                            local r26_276 = r26_275.horizontalCameraSweep and true or r26_274
                            if r26_276 then
                                sweepSpeed = r26_263
                                local r26_277 = _G.math.abs(draggingStartPosScreen.x - cursor.x)
                                local r26_278 = _G.math.abs
                                local r26_279 = draggingStartPosScreen.y
                                local r26_280 = cursor.y
                                if r26_278(r26_279 - r26_280) < r26_277 then
                                    local r26_281 = -2
                                    if draggingStartPosScreen.x - cursor.x > 0 then
                                        local r26_282 = r26_269.px
                                        if r26_270.px < r26_282 then
                                            leftSweep = true
                                            rightSweep = false
                                        else
                                            rightSweep = true
                                            leftSweep = false
                                            r26_281 = 2
                                        end
                                    else
                                        local r26_283 = r26_269.px
                                        if r26_270.px < r26_283 then
                                            rightSweep = true
                                            leftSweep = false
                                            r26_281 = 2
                                        else
                                            leftSweep = true
                                            rightSweep = false
                                        end
                                    end
                                    for r26_284, r26_285 in _G.pairs(objects.levelStars) do
                                        local r26_286 = _G.math.random()
                                        applyImpulse(r26_284, r26_281 * r26_286, 0, r26_285.x, r26_285.y)
                                    end
                                end
                            else
                                sweepSpeed = r26_262
                                local r26_287 = _G.math.abs(draggingStartPosScreen.x - cursor.x)
                                local r26_288 = _G.math.abs(draggingStartPosScreen.y - cursor.y)
                                if r26_287 < r26_288 then
                                    local r26_289 = draggingStartPosScreen.y
                                    local r26_290 = cursor.y
                                    if r26_289 - r26_290 < 0 then
                                        leftSweep = true
                                        rightSweep = false
                                    else
                                        rightSweep = true
                                        leftSweep = false
                                    end
                                end
                            end
                            if sweepSpeed ~= 0 then
                                local r26_291 = _G.math.abs(sweepSpeed)
                                local r26_292 = g_minSweepSpeed
                                if r26_291 < r26_292 then
                                    local r26_293 = sweepSpeed
                                    local r26_294 = _G.math.abs(sweepSpeed)
                                    sweepSpeed = r26_293 / r26_294 * g_minSweepSpeed
                                else
                                    local r26_295 = _G.math.abs(sweepSpeed)
                                    if g_maxSweepSpeed < r26_295 then
                                        local r26_296 = sweepSpeed
                                        local r26_297 = _G.math.abs(sweepSpeed)
                                        sweepSpeed = r26_296 / r26_297 * g_maxSweepSpeed
                                    end
                                end
                            end
                        end
                    else
                        sweepSpeed = 0
                    end
                else
                    local r26_298, r26_299 = nil, nil
                    if g_usingGestureControls then
                        local r26_300 = distance(bird_touch_begin_x, bird_touch_begin_y, last_touch_x, last_touch_y)
                        local r26_301 = {
                            x = bird_touch_begin_x - last_touch_x,
                            y = bird_touch_begin_y - last_touch_y
                        }
                    else
                        local r26_302 = distance(draggingStartPosPhysics.x, draggingStartPosPhysics.y, cursorPhysics.x, cursorPhysics.y)
                        local r26_303 = {
                            x = draggingStartPosPhysics.x - cursorPhysics.x,
                            y = draggingStartPosPhysics.y - cursorPhysics.y
                        }
                    end
                    local r26_304 = rubberBandLength / shootMaxLength
                    local r26_305 = r26_304 < 0 and 0 or r26_304
                    if r26_305 > 1 then

                    end
                    applyForceToSelectedBird(selectedBird)
                    flightTime = -p26_1
                    setCameraTargetObject(selectedBird)
                    storeCameraPosition()
                    flyingBird = selectedBird
                    cameraFunction = doItAllCamera
                    selectedBird.shot = true
                    birdSpecialtyAvailable = true
                    birdSpecialtyUsed = false
                    doubleUsed = false
                    allowResetToBirdCamera = true
                    allowTrajectoryClearing = true
                    hasMovingObjectsZeroTolerance = true
                    birdSelected = false
                    birdReady = false
                    birdFired = true
                    birdsShot = birdsShot + 1
                    cameraResetTimer = g_defaultCameraResetTime
                    currentBirdName = nil
                    otherBirds = {}
                    birdTrajectory = { {}, {}, {} }
                    if getObjectDefinition(flyingBird.name).sprites ~= nil then
                        local r26_306 = getObjectDefinition(flyingBird.name)
                        flyingBird.sprite = r26_306.sprites.flying
                        setSprite(flyingBird.name, flyingBird.sprite)
                    end
                    if not (getObjectDefinition(selectedBird.name).sounds == nil or getObjectDefinition(selectedBird.name).sounds.launch == nil) then
                        res.playAudio("bird_shot")
                        local r26_307 = getObjectDefinition(selectedBird.name)
                        res.playAudio(r26_307.sounds.launch)
                    end
                    local r26_308 = eventManager
                    local r26_309 = { id = events.EID_BIRD_SHOT, name = selectedBird.name }
                    r26_308:notify(r26_309)
                    selectedBird = nil
                    local r26_310 = objects.world[flyingBird.name]
                    r26_310.didDamage = false
                    _G.assert(flyingBird ~= nil)
                    local r26_311 = blockTable.blocks[flyingBird.definition]
                    local r26_312 = r26_311.nextBirdTimer
                    nextBirdTimer = r26_312 or 1
                    local r26_313 = r26_311 ~= nil
                    _G.assert(r26_313, "bird definition undefined for bird " .. flyingBird.definition)
                    local r26_314 = r26_311.normalTrailSprite ~= nil
                    _G.assert(r26_314, "normalTrailSprite undefined for bird " .. flyingBird.definition)
                    local r26_315 = r26_311.specialTrailSprite ~= nil
                    _G.assert(r26_315, "specialTrailSprite undefined for bird " .. flyingBird.definition)
                    local r26_316 = r26_311.aimingAidSprite ~= nil
                    _G.assert(r26_316, "aimingAidSprite undefined for bird " .. flyingBird.definition)
                    setNormalTrailSprite(r26_311.normalTrailSprite)
                    setSpecialTrailSprite(r26_311.specialTrailSprite)
                    if g_usingGestureControls and (r26_311.specialty == "LAZER_SHOT" or r26_311.specialty == "BOMB" or r26_311.specialty == "GRAVITY_DISRUPTOR") then
                        g_laserGestureMode = true
                        local r26_317 = laser_cursor
                        local r26_318 = laser_cursor
                        local r26_319 = screenWidth * 0.5
                        r26_318.y = screenHeight * 0.5
                        r26_317.x = r26_319
                    end
                end
                if leftSweep == true and sweepSpeed < 0 then
                    setCameraTargetObject(nil)
                    cameraFunction = doItAllCamera
                    if cameraAnimationSlider < 0 then
                        cameraAnimationSlider = 0
                    end
                    cameraAnimationSliderTarget = 1
                    doubleClickTimer = 0
                end
                if rightSweep == true and sweepSpeed > 0 then
                    moveToBirdCamera(sweepSpeed)
                    doubleClickTimer = 0
                end
                if tapStarted and vLength(cursor.x - tapPosition.x, cursor.y - tapPosition.y) < tapRadius then
                    tapCount = tapCount + 1
                    tapTimer = 0
                end
            end
        end
        if (releaseBuild ~= true or cheatsEnabled == true) and isKeyPressed("LBUTTON") then
            local r26_320 = quadClickTimer
            if r26_320 > 0 and screenWidth - 120 < cursor.x and screenHeight - 80 < cursor.y then
                quadClickCounter = quadClickCounter + 1
                quadClickTimer = 0.5
                local r26_321 = quadClickCounter
                if r26_321 >= 4 then
                    quadClick = true
                end
            else
                local r26_322 = quadClickTimer
                if r26_322 > 0 and cursor.x < 120 and screenHeight - 80 < cursor.y then
                    quadClickFalconCounter = quadClickFalconCounter + 1
                    quadClickTimer = 0.5
                    local r26_323 = quadClickFalconCounter
                    if r26_323 >= 4 then
                        addMightyEagles(10)
                        quadClickFalconCounter = 1
                    end
                else
                    quadClick = false
                    g_threeStarsCheat = false
                    quadClickTimer = 0.5
                    quadClickCounter = 1
                    quadClickFalconCounter = 1
                end
            end
        end
        if allowResetToBirdCamera == true and levelCompleted == false and birdSpecialtyAvailable == false then
            if hasMovingObjects == true then
                for r26_324, r26_325 in _G.pairs(birds) do
                    if r26_325.controllable and r26_325.shot then
                        cameraResetTimer = g_defaultCameraResetTime
                    end
                end
                for r26_326, r26_327 in _G.pairs(otherBirds) do
                    if r26_327.controllable and r26_327.shot then
                        cameraResetTimer = g_defaultCameraResetTime
                    end
                end
            end
            cameraResetTimer = cameraResetTimer - p26_1
            if cameraResetTimer <= 0 then
                local r26_328 = objects.castleCameraData[deviceModel]
                local r26_329 = objects.birdCameraData[deviceModel]
                moveToBirdCamera(r26_328.px - r26_329.px)
                flyingBird = nil
            end
        end
        animateBirdToSlingShot(p26_1)
        local r26_330 = false
        if flyingBird ~= nil then
            flightTime = flightTime + p26_1
            if flyingBird.recordTrajectory == false then
                if flyingBird.BHTrajectory == true then
                    if flyingBird.BHTrajectoryTimer <= 0 then
                        BHTrajectory[#BHTrajectory + 1] = {
                            x = flyingBird.x,
                            y = flyingBird.y,
                            timer = 0.699999988079071
                        }
                        flyingBird.BHTrajectoryTimer = 0.11999999731779099
                    else
                        flyingBird.BHTrajectoryTimer = flyingBird.BHTrajectoryTimer - p26_1
                    end
                end
            else
                r26_330 = true
                local r26_331, r26_332 = physicsToWorldTransform(flyingBird.x, flyingBird.y)
                local r26_333 = birdTrajectory[1]
                if #r26_333 < 1 or vLength(r26_331 - r26_333[#r26_333].x, r26_332 - r26_333[#r26_333].y) > 80 then
                    _G.table.insert(r26_333, { x = r26_331, y = r26_332 })
                    addToTrajectory(1, r26_331, r26_332)
                end
                local r26_334 = getObjectDefinition(flyingBird.name)
                if r26_334.rotateWhileFlying then
                    rotateFlyingBird(flyingBird.name)
                end
            end
        end
        if otherBirds ~= nil then
            local r26_335 = 1
            local r26_336 = 2
            local r26_337 = 1
            r26_330 = r26_330
            for r26_338 = r26_335, r26_336, r26_337 do
                local r26_339 = objects.world[otherBirds[r26_338]]
                if r26_339 ~= nil then
                    local r26_340 = r26_339.recordTrajectory
                    local r26_341 = false
                    local r26_342
                    r26_330 = r26_342
                    if r26_340 ~= r26_341 and flyingBird and flyingBird.recordTrajectory ~= false then
                        r26_330 = true
                        local r26_343, r26_344 = physicsToWorldTransform(r26_339.x, r26_339.y)
                        local r26_345 = birdTrajectory[r26_338 + 1]
                        if #r26_345 < 1 or vLength(r26_343 - r26_345[#r26_345].x, r26_344 - r26_345[#r26_345].y) > 80 then
                            _G.table.insert(r26_345, { x = r26_343, y = r26_344 })
                            addToTrajectory(r26_338 + 1, r26_343, r26_344)
                        end
                        local r26_346 = getObjectDefinition(r26_339.name)
                        if r26_346.rotateWhileFlying then
                            rotateFlyingBird(r26_339.name)
                        end
                    end
                    if r26_339.collision ~= true and r26_339.timerDragEnabled ~= true then
                        r26_339.enableDragTimer = r26_339.enableDragTimer and r26_339.enableDragTimer - p26_1 or birdDragTimer
                        if r26_339.enableDragTimer <= 0 then
                            setLinearDamping(r26_339.name, defaultPhysicsDrag)
                            for r26_347, r26_348 in _G.pairs(otherBirds) do
                                setLinearDamping(r26_348, defaultPhysicsDrag)
                            end
                            r26_339.timerDragEnabled = true
                        end
                    end
                end
            end
        end
        if r26_330 == false and allowTrajectoryClearing == true then
            startNewTrajectory()
            allowTrajectoryClearing = false
        end
        if g_delayedBirdFocusLost and cameraTargetObject ~= nil and cameraTargetObject.delayedRemovalTimer ~= nil then
            cameraTargetObject.delayedRemovalTimer = cameraTargetObject.delayedRemovalTimer - p26_1
            if cameraTargetObject.delayedRemovalTimer <= 0 then
                setCameraTargetObject(nil)
            end
        end
        if birdFired then
            local r26_349 = _G.math.min(p26_1, 0.05000000074505806)
            while r26_349 > 0 do
                local r26_350 = not (r26_349 < 0.05000000074505806) and 0.05000000074505806 or r26_349
                r26_349 = r26_349 - r26_350
                local r26_351 = distance(levelStartPosition.x, levelStartPosition.y, rubberBandPos.x, rubberBandPos.y)
                local r26_352 = {
                    x = levelStartPosition.x - rubberBandPos.x,
                    y = levelStartPosition.y - rubberBandPos.y
                }
                rubberBandAngle = _G.math.atan2(r26_352.y, r26_352.x)
                rubberBandLength = r26_351
                local r26_353 = rubberBandSpeed
                local r26_354 = dampedSpring(springConstant, springDampening, r26_351, rubberBandSpeed)
                rubberBandSpeed = r26_353 + r26_354 * 0.05000000074505806 * physicsScale
                if r26_351 > 0 then
                    rubberBandPos.x = rubberBandPos.x + r26_352.x / r26_351 * rubberBandSpeed * r26_350
                    rubberBandPos.y = rubberBandPos.y + r26_352.y / r26_351 * rubberBandSpeed * r26_350
                    rubberBandLength = distance(levelStartPosition.x, levelStartPosition.y, rubberBandPos.x, rubberBandPos.y)
                end
            end
        end
        for r26_355, r26_356 in _G.pairs(birds) do
            local r26_357 = r26_356
            if r26_357.hasCollided and r26_357.fadeEffectTimer ~= nil and r26_357.fadeEffectTimer >= 0 then
                r26_357.fadeEffectTimer = r26_357.fadeEffectTimer - p26_1
            end
            if r26_357.specialtyTimer ~= nil and r26_357.specialtyTimer > 0 and (flyingBird == nil or r26_357.name == flyingBird.name) then
                local r26_358 = getDeltaTimeMultiplier()
                r26_357.specialtyTimer = r26_357.specialtyTimer - p26_1 / r26_358
                if r26_357.specialtyTimer < 0 then
                    if getObjectDefinition(r26_355).specialty ~= "NONE" and not r26_357.tutorialSpecialtyHandled then
                        r26_357.tutorialSpecialtyHandled = true
                        if birdSpecialtyUsed then
                            print("specialty RESET: " .. r26_357.definition)
                            local r26_359 = SettingsWrapper
                            r26_359:resetBirdPowerNotUsed(r26_357.definition)
                        elseif not r26_357.ignoreTutorialPowerUsage then
                            print("NOT used specialty: " .. r26_357.definition)
                            local r26_360 = SettingsWrapper
                            r26_360:birdPowerNotUsed(r26_357.definition)
                        end
                    end
                    birdSpecialtyAvailable = false
                    local r26_361 = getObjectDefinition(r26_357.name)
                    if r26_361 and r26_361.specialty == "LAZER_SHOT" and r26_357.emitterBody and r26_357.emitterBody.emitter then
                        local r26_362 = r26_357.emitterBody
                        r26_362.emitter.deleteEmitterAfterEmitting = true
                    end
                end
            end
            if objects.world[r26_357.name] ~= nil then
                local r26_363 = getObjectDefinition(r26_355)
                if r26_356.bombTimer == nil then
                    if r26_356.controllable and r26_356.shot == true then
                        if r26_357.collision ~= true and r26_357.timerDragEnabled ~= true then
                            r26_357.enableDragTimer = r26_357.enableDragTimer and r26_357.enableDragTimer - p26_1 or birdDragTimer
                            if r26_357.enableDragTimer <= 0 then
                                setLinearDamping(r26_357.name, defaultPhysicsDrag)
                                for r26_364, r26_365 in _G.pairs(otherBirds) do
                                    setLinearDamping(r26_365, defaultPhysicsDrag)
                                end
                                r26_357.timerDragEnabled = true
                            end
                        end
                        if r26_356.isReadyForRemoveTimer ~= nil and vLength(r26_356.xVel, r26_356.yVel) < 0.3499999940395355 then
                            r26_356.isReadyForRemoveTimer = r26_356.isReadyForRemoveTimer - p26_1
                        else
                            r26_356.isReadyForRemoveTimer = 2
                        end
                        if r26_356.isReadyForRemoveTimer < 0 then
                            if cameraTargetObject ~= nil and r26_356.name == cameraTargetObject.name and flyingBird ~= nil then
                                setCameraTargetObject(nil)
                            end
                            removeBird(r26_356)
                        end
                    end
                else
                    r26_356.bombTimer = r26_356.bombTimer - p26_1
                    local r26_366 = getObjectDefinition(r26_355)
                    if r26_366.specialty == "BOMB" then
                        if r26_356.bombTimer < 0 then
                            addBirdSpecialParticles(r26_356)
                            local r26_367 = blockTable.blocks[r26_356.definition]
                            makeExplosion(r26_356, r26_366, r26_367.sounds.special)
                            removeBird(r26_356)
                        elseif r26_366.sprites.timer ~= nil then
                            if r26_356.bombTimer < 0.07000000029802322 then
                                r26_356.damageSprite = r26_366.sprites.timer[3]
                                setSprite(r26_356.name, r26_356.damageSprite)
                            elseif r26_356.bombTimer < 0.11999999731779099 then
                                r26_356.damageSprite = r26_366.sprites.timer[2]
                                setSprite(r26_356.name, r26_356.damageSprite)
                            elseif r26_356.bombTimer < 0.20000000298023224 then
                                r26_356.damageSprite = r26_366.sprites.timer[1]
                                setSprite(r26_356.name, r26_356.damageSprite)
                            end
                        end
                    elseif r26_356.bombTimer < 0 then
                        addBirdSpecialParticles(r26_356)
                        fireAction("useR2D2Specialty", { name = r26_355, dt = p26_1 })
                        r26_356.bombTimer = nil
                    end
                end
            end
        end
        for r26_368, r26_369 in _G.pairs(objects.world) do
            if r26_369.controllable ~= true then
                if r26_369.gravityFilterCategory == "IGNOREGRAVITY" then
                    setObjectParameter(r26_369.name, 16, 1)
                end
                if r26_369.usingForceDrag or r26_369.gravityFilterCategory and (r26_369.gravityFilterCategory == "FORCE_OBJECT" or r26_369.gravityFilterCategory == "YODA_FORCE_OBJECT" or r26_369.gravityFilterCategory == "HOVERING_OBJECT") then
                    if r26_369.usingForceDrag then
                        if not (r26_369.gravityFilterCategory and (r26_369.gravityFilterCategory == "FORCE_OBJECT" or r26_369.gravityFilterCategory == "YODA_FORCE_OBJECT" or r26_369.gravityFilterCategory == "HOVERING_OBJECT")) then
                            setLinearDamping(r26_369.name, defaultPhysicsDrag)
                            setAngularDamping(r26_369.name, defaultAngularDrag)
                            r26_369.usingMinorDrag = false
                            r26_369.usingForceDrag = false
                            setObjectParameter(r26_369.name, 16, 0)
                            r26_369.isHeldByForceTimer = forceGlowFadeTimer
                        end
                    else
                        local r26_370, r26_371 = defaultForceDrag, defaultForceDrag
                        local r26_372
                        local r26_373
                        if r26_369.gravityFilterCategory then
                            if r26_369.gravityFilterCategory == "YODA_FORCE_OBJECT" then
                                local r26_374 = defaultYodaForceDrag
                                local r26_375 = defaultYodaForceDrag
                                r26_372 = r26_374
                                r26_373 = r26_375
                            elseif r26_369.gravityFilterCategory then
                                if r26_369.gravityFilterCategory == "HOVERING_OBJECT" then
                                    local r26_376 = defaultHoveringForceDrag
                                    local r26_377 = defaultHoveringForceDrag
                                    r26_372 = r26_376
                                    r26_373 = r26_377
                                else
                                    r26_372 = r26_370
                                    r26_373 = r26_371
                                end
                            else
                                r26_372 = r26_370
                                r26_373 = r26_371
                            end
                        elseif r26_369.gravityFilterCategory then
                            if r26_369.gravityFilterCategory == "HOVERING_OBJECT" then
                                local r26_378 = defaultHoveringForceDrag
                                local r26_379 = defaultHoveringForceDrag
                                r26_372 = r26_378
                                r26_373 = r26_379
                            else
                                r26_372 = r26_370
                                r26_373 = r26_371
                            end
                        else
                            r26_372 = r26_370
                            r26_373 = r26_371
                        end
                        setLinearDamping(r26_369.name, r26_372)
                        setAngularDamping(r26_369.name, r26_373)
                        r26_369.usingForceDrag = true
                        r26_369.usingMinorDrag = false
                        setObjectParameter(r26_369.name, 16, 1)
                    end
                elseif isPhysicsEnabled() and r26_369.velocity and r26_369.velocity <= dragVelocityThreshold then
                    if not r26_369.usingMinorDrag then
                        setLinearDamping(r26_369.name, minorPhysicsDrag)
                        r26_369.usingMinorDrag = true
                    end
                elseif r26_369.usingMinorDrag or r26_369.usingMinorDrag == nil then
                    setLinearDamping(r26_369.name, defaultPhysicsDrag)
                    r26_369.usingMinorDrag = false
                end
            end
            if r26_369 ~= nil and r26_369.frozen then
                fireAllObjectTriggerEvents(r26_369.name)
                if r26_369.onDestroyed ~= nil then
                    fireAction(r26_369.onDestroyed, { obj = r26_369 }, "onDestroyed")
                end
                if r26_369.controllable then
                    removeBird(r26_369)
                else
                    if objects.worldGravity and not r26_369.isSensor then
                        local r26_380 = blockDestroyedScoreIncrement
                        local r26_381 = blockTable.blocks[r26_369.definition]
                        local r26_382
                        if r26_381.destroyedScoreInc then
                            local r26_383 = blockTable.blocks[r26_369.definition]
                            r26_382 = r26_383.destroyedScoreInc
                        else
                            r26_382 = r26_380
                        end
                        scoreTable.blocks.score = scoreTable.blocks.score + r26_382
                    end
                    objects.world[r26_368] = nil
                    removeObject(r26_368)
                    levelGoals[r26_368] = nil
                    animatedObjects[r26_368] = nil
                end
            end
        end
        if g_lineGravityVisualization then
            for r26_384, r26_385 in _G.pairs(objects.sensorList.gravitation) do
                if r26_385.sensorType == "gravitation" and r26_385.active then
                    local r26_386 = blockTable.blocks[r26_385.definition]
                    if r26_386.type == "circle" then
                        r26_385.addVisualTimer = r26_385.addVisualTimer and r26_385.addVisualTimer - p26_1 or 0
                        r26_385.gravityVisuals = r26_385.gravityVisuals or {}
                        if r26_385.addVisualTimer <= 0 then
                            r26_385.addVisualTimer = 4.5
                            local r26_387 = {
                                sprite = blockTable.themes[currentTheme].gravitySliceSpriteFaded,
                                x = 0,
                                y = 0,
                                scale = 1,
                                timer = 9
                            }
                            _G.table.insert(r26_385.gravityVisuals, r26_387)
                        end
                        for r26_388, r26_389 in _G.pairs(r26_385.gravityVisuals) do
                            local r26_390 = r26_389.timer
                            r26_389.scale = r26_390 / 9 * 0.9700000286102295
                            local r26_391 = r26_389.timer
                            r26_389.timer = r26_391 - p26_1
                            if r26_389.timer <= 0 then
                                _G.table.remove(r26_385.gravityVisuals, r26_388)
                            end
                        end
                    else
                        local r26_392 = blockTable.blocks[r26_385.definition]
                        if r26_392.type == "box" then
                            r26_385.addVisualTimer = r26_385.addVisualTimer and r26_385.addVisualTimer - p26_1 or 0
                            if r26_385.gravityVisuals == nil then
                                r26_385.gravityVisuals = {}
                                for r26_393 = 1, 3 do
                                    local r26_394 = {
                                        sprite = blockTable.themes[currentTheme].gravitySliceBoxSpriteFaded,
                                        x = 0,
                                        y = 0,
                                        pos = 1,
                                        timer = 12 - r26_393 * 3
                                    }
                                    _G.table.insert(r26_385.gravityVisuals, r26_394)
                                end
                            end
                            if r26_385.addVisualTimer <= 0 then
                                r26_385.addVisualTimer = 3
                                local r26_395 = {
                                    sprite = blockTable.themes[currentTheme].gravitySliceBoxSpriteFaded,
                                    x = 0,
                                    y = 0,
                                    pos = 1,
                                    timer = 9
                                }
                                _G.table.insert(r26_385.gravityVisuals, r26_395)
                            end
                            for r26_396, r26_397 in _G.pairs(r26_385.gravityVisuals) do
                                r26_397.pos = r26_397.timer / 9 * 0.9700000286102295
                                local r26_398 = r26_397.timer
                                r26_397.timer = r26_398 - p26_1
                                if r26_397.timer <= 0 then
                                    _G.table.remove(r26_385.gravityVisuals, r26_396)
                                end
                            end
                        end
                    end
                end
            end
        end
        if r26_128 == true and isInGameMode() then
            updateMultitouchSweep(p26_1, p26_2)
        end
        if not (cameraFunction == nil or cameraDisabled) then
            cameraFunction(p26_1)
        end
        if isPCVersion() and g_drawLevelCameraIndexes then
            local r26_399, r26_400 = self.leftButton, self.rightButton
            local r26_401 = getCurrentCameraIdx() + 1
            if r26_399 then
                r26_399.setEnabled(r26_399, r26_401 ~= 1)
            end
            if r26_400 then
                local r26_402 = "setEnabled"
                r26_400[r26_402](r26_400, r26_401 ~= getNumCameras())
            end
        end
        for r26_403, r26_404 in _G.pairs(objects.joints) do
            if r26_404.backAndForth then
                checkJointLimits(r26_404.name)
            end
        end
        ui.Frame.update(self, p26_1, p26_2)
        if not isComicLevel then
            updateCharacterAnimations(p26_1)
            updateThemeSpriteAnimations(p26_1)
            updateCameraShake(p26_1)
        end
        oldCursor.x = cursor.x
        oldCursor.y = cursor.y
        local r26_405 = g_wheelSpeed
        local r26_406 = _G.math.pow
        local r26_407 = _G.math.min(1, _G.math.max(0.05000000074505806, p26_1))
        local r26_408 = r26_406(1 - r26_407, 1.25)
        g_wheelSpeed = r26_405 * r26_408
        if not (flyingBird == nil or flyingBird.resetAngle == nil) then
            setRotation(flyingBird.name, flyingBird.resetAngle)
            flyingBird.resetAngle = nil
        end
        local r26_409 = "getChild"
        local r26_410 = self[r26_409](self, "MEButton")
        if r26_410 then
            if g_meButtonMuted then
                r26_410.clickSound = nil
            else
                r26_410.clickSound = "ButtonProceed"
            end
        end
        if selectedBird and not levelCompleted and g_aimingAidAttributes.enabled == true then
            simulateTrajectory()
        end
        if PowerupManager then
            PowerupManager:update(p26_1)
        end
        return
    end
    if isPhysicsEnabled() then
        setPhysicsEnabled(false)
    end
    ui.Frame.update(self, p26_1, p26_2)
end

-- line 4228-4235
-- proto#27 params=0 locals=0 upvalues=0 vararg=false
function checkOnePigLeftAchievement()
    if countKeys(levelGoals) == 1 then
        SettingsWrapper:failedWithOnePigLeft()
        local r27_0 = SettingsWrapper:getTimesFailedWithOnePigLeft()
        if getAchievementLimit("Pork side of the Force") <= r27_0 then
            registerAchievement("Pork side of the Force")
        end
    end
end

-- line 4237-4254
-- proto#28 params=3 locals=0 upvalues=0 vararg=false
function GameScene:updateFade(p28_1, p28_2)
    if fadeTimer then
        if fadeIsFadeIn then
            fadeTimer = fadeTimer + p28_1
            local r28_0 = fadeTimer
            if fadeTotalTimer < r28_0 then
                fadeTimer = nil
                fadeTotalTimer = nil
            end
        else
            fadeTimer = fadeTimer - p28_1
            if fadeTimer < 0 then
                fadeTimer = nil
                fadeTotalTimer = nil
            end
        end
    end
end

TRANSITION_TYPE_SWIPE_FROM_LEFT = 1
TRANSITION_TYPE_SWIPE_FROM_RIGHT = 2
TRANSITION_TYPE_SWIPE_FROM_TOP = 3
TRANSITION_TYPE_SWIPE_FROM_BOTTOM = 4
transitionTimes = { 1, 1, 1, 1 }

-- line 4263-4274
-- proto#29 params=3 locals=1 upvalues=0 vararg=false
function GameScene:updateTransition(p29_1, p29_2)
    if transitionStarted then
        transitionTimer = transitionTimer + p29_1
        local r29_0 = transitionTimer
        if transitionTimes[transitionType] <= r29_0 then
            transitionTimer = nil
            transitionBGColor = nil
            transitionStarted = nil
            _G.res.releaseSpriteSheet("CAPTURED_SCREENSHOT")
        end
    end
end

-- line 4276-4318
-- proto#30 params=1 locals=21 upvalues=0 vararg=false
function GameScene:drawTransition()
    if transitionTimer ~= nil then
        local r30_0, r30_1 = 0, screenHeight
        local r30_2 = deviceModel == "wp8" and -1 or 0
        local r30_3 = transitionType
        local r30_4 = TRANSITION_TYPE_SWIPE_FROM_LEFT
        local r30_5
        local r30_6
        if r30_3 == r30_4 then
            local r30_7 = transitionTimer / transitionTimes[transitionType] * screenWidth
            r30_5 = r30_7
            r30_6 = _G.math.ceil(screenWidth - r30_7)
        elseif transitionType == TRANSITION_TYPE_SWIPE_FROM_RIGHT then
            r30_6 = screenWidth - transitionTimer / transitionTimes[transitionType] * screenWidth
        elseif transitionType == TRANSITION_TYPE_SWIPE_FROM_TOP then
            local r30_8 = transitionTimer / transitionTimes[transitionType] * screenHeight
            r30_1 = _G.math.ceil(screenHeight - r30_8)
        elseif transitionType == TRANSITION_TYPE_SWIPE_FROM_BOTTOM then
            r30_1 = screenHeight - transitionTimer / transitionTimes[transitionType] * screenHeight
        end
        setRenderState(0, 0, 1, 1, 0, 0, 0, 1)
        _G.res.setClipRect(r30_5, r30_0, r30_6, r30_1)
        if not (transitionBGColor == nil or deviceModel == "wp7") then
            drawRect(0, 0, 0, 1, r30_5, r30_0, r30_5 + r30_6, r30_0 + r30_1, true)
        end
        _G.res.drawSprite("CAPTURED_SCREENSHOT", 0, r30_2)
        _G.res.setClipRect(0, 0, screenWidth, screenHeight)
    end
end

-- line 4320-4335
-- proto#31 params=1 locals=2 upvalues=0 vararg=false
function GameScene:initializeTransition()
    transitionTimer = 0
    transitionType = _G.math.random(#transitionTimes)
    if shouldDrawCursor() then
        g_queuedCursorName = g_currentCursorName
        g_currentCursorName = ""
        ui.LevelButton.batchesDrawn = false
        self:draw(0, 0)
    end
    transitionBGColor = {}
    local r31_0 = transitionBGColor
    local r31_1 = transitionBGColor
    local r31_2 = transitionBGColor
    local r31_3, r31_4, r31_5 = getBGColor()
    r31_2.b = r31_5
    r31_1.g = r31_4
    r31_0.r = r31_3
    _G.res.captureSprite("CAPTURED_SCREENSHOT")
end

-- line 4337-4341
-- proto#32 params=1 locals=0 upvalues=0 vararg=false
function GameScene:startTransition()
    if transitionTimer then
        transitionStarted = true
    end
end

-- line 4343-4347
-- proto#33 params=1 locals=0 upvalues=0 vararg=false
function GameScene.endTransition(p33_0)
    if transitionTimer then
        transitionTimer = transitionTimes[transitionType]
    end
end
