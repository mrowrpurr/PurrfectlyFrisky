scriptName PurrfectlyFrisky_InstallWizard extends InstallWizard

bool _schlongified
int _raceMenuCloseCountToTriggerInstall = 1 ; Listen for RaceMenu then start installer

event OnWizardInit()
    WizardName = "PurrfectlyFrisky"

    ; TODO update InstalLWizard to register for these automatically
    HandleEvent("InstallSexlab")
    HandleEvent("InstallVariousThings")
    HandleEvent("Schlongify")
    HandleEvent("DefaultAnimations")

    BeginInstallerAfterRacemenu()
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Update Polling for variety of things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bool _waitForSexlab

event OnUpdate()
    if _waitForSexlab
        InstallSexlab()
    endIf
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Install Sexlab
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event InstallSexlab()
    sslConfigMenu sexlabMCM = Game.GetFormFromFile(0x79840, "SexLab.esm") as sslConfigMenu
    if sexlabMCM.SystemAlias.SetupSystem()
        _waitForSexlab = false
        Debug.MessageBox("Sexlab Installation Complete")
        NextStep()
    else
        _waitForSexlab = true
        RegisterForSingleUpdate(1)
    endIf
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Schlongification
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event Schlongify()
    SOS_SetupQuest_Script sos = Game.GetFormFromFile(0xd62, "Schlongs of Skyrim.esp") as SOS_SetupQuest_Script

    int addonCount = SOS_Data.CountAddons()
    bool done
    int i = 0
    while i < addonCount && ! done
        SOS_AddonQuest_Script addon = SOS_Data.GetAddon(i)
        if StringUtil.Find(addon.GetName(), "Futa") > -1
        ; if StringUtil.Find(addon.GetName(), "TRX") > -1
            sos.SetSchlong(Player, addon, false)
            sos.RegisterNewSchlongifiedActor(player, addon)
            _schlongified = true

            ; Put panties back on if the player has these ~ the schlongification takes the off (this is for Neko players)
            Form panties = Game.GetFormFromFile(0x804, "CBBE Standalone Underwear.esp")
            if Player.GetItemCount(panties) > 0
                Utility.WaitMenuMode(0.1)
                Player.EquipItem(panties, abSilent = true)
            endIf
            done = true
        endIf
        i += 1
    endWhile
    
    NextStep()
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Animations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event DefaultAnimations()
    slalMCM slalConfig = Game.GetFormFromFile(0x12c4, "SLAnimLoader.esp") as slalMCM
    EnableAnimationCategory("Billyy_Human")
    EnableAnimationCategory("Billyy_HumanFurnitureInvis")
    EnableAnimationCategory("AyasatoAnims")
    EnableAnimationCategory("FunnyBiznessRape")
    EnableAnimationCategory("K4Anims")
    if _schlongified
        EnableAnimationCategory("Billyy_HumanFuta")
    endIf
    int animCount = slalConfig.Loader.registerAnimations()
    Debug.MessageBox("Registered " + animCount + " Animations")
    NextStep()
endEvent

function EnableAnimationCategory(string categoryName)
  int enableState = slalData.getEnableState()
  int anims = slalData.getAnimations()
  int catAnims = slalData.getCategoryAnims(categoryName)
  int numAnims = JArray.count(catAnims)
  int n = 0
  int numRegistered = 0
  while n < numAnims
    string animID = JArray.getStr(catAnims, n)
    int animInfo = JMap.getObj(anims, animID)
    JMap.setInt(enableState, animID, true as int)
    n += 1
  endWhile
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Configure Various Things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event InstallVariousThings()
    VariousThings_Sexlab()
    VariousThings_Cumshot()
    NextStep()
endEvent

function VariousThings_Sexlab()
    sslConfigMenu sexlabMCM = Game.GetFormFromFile(0x79840, "SexLab.esm") as sslConfigMenu
    sslSystemConfig sexlabConfig = sexlabMCM.Config

    ; TODO - Read this from JSON
    sexlabConfig.AutoAdvance = false
    sexlabConfig.UseExpressions = true
    sexlabConfig.UseLipSync = false
    sexlabConfig.SeparateOrgasms = true
    sexlabConfig.OrgasmEffects = true
    sexlabConfig.LimitedStrip = true
    sexlabConfig.RemoveHeelEffect = true
    sexlabConfig.ForeplayStage = true
    sexlabConfig.AllowCreatures = true
    sexlabConfig.UnregisterForKey(sexlabConfig.ToggleFreeCamera)
    sexlabConfig.ToggleFreeCamera = 199 ; Home
    sexlabConfig.RegisterForKey(199)    ; Home
    sexlabConfig.AskBed = 0
endFunction

function VariousThings_Cumshot()
    CS2ConfigScript cumshotConfig = Game.GetFormFromFile(0x1c724, "Cumshot.esp") as CS2ConfigScript
    cumshotConfig.ejaculationMode = 4
    cumshotConfig.alwaysShowEjac = true ; Wish I didn't need to set this, but I'm having issues without it...
    
    ; If ejaculationMode == 1
    ;     ejacModeInfo = "Animated mesh - Same as in previous versions. Four spurts and an optional drip. Can be precisely positioned, but doesn't follow gravity."
    ; ElseIf ejaculationMode == 2
    ;     ejacModeInfo = "Particles - A particle emitter that sends showers of drop particles. They react to gravity, but not to anything else."
    ; ElseIf ejaculationMode == 3
    ;     ejacModeInfo = "Drop objects - A varying number of spurts that consist of cum drop objects. Ejaculations are highly customizable. Drops follow gravity and collide with world objects (but not with actors).\nWARNING - can cause high script usage."
    ; ElseIf ejaculationMode == 4
    ;     ejacModeInfo = "Projectiles - A series of spells is fired from the penis, with cum spurts as projectiles. The spurts leave cum splashes on the ground and on objects."
    ; EndIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Trigger install after Race Menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function BeginInstallerAfterRacemenu()
    ; Listen for RaceMenu (we'll start installer afterwards)
    RegisterForMenu("RaceSex Menu")
    if Game.IsPluginInstalled("PurrfectlyNeko.esp")
        _raceMenuCloseCountToTriggerInstall += 1
    endIf
endFunction

; Listen for RaceMenu to close (then start installer)
event OnMenuClose(string menuName)
    if menuName == "RaceSex Menu"
        _raceMenuCloseCountToTriggerInstall -= 1
        if _raceMenuCloseCountToTriggerInstall == 0
            UnregisterForMenu("RaceSex Menu")
            Start()
        endIf
    endIf
endEvent
