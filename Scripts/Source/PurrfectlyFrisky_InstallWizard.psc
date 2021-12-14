scriptName PurrfectlyFrisky_InstallWizard extends InstallWizard

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
            sos.SetSchlong(Player, addon, false)
            sos.RegisterNewSchlongifiedActor(player, addon)

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
    ; ...
    NextStep()
endEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Configure Various Things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event InstallVariousThings()
    sslConfigMenu sexlabMCM = Game.GetFormFromFile(0x79840, "SexLab.esm") as sslConfigMenu
    sslSystemConfig sexlabConfig = sexlabMCM.Config

    ; TODO - Read this from JSON
    sexlabConfig.AutoAdvance = false
    sexlabConfig.UseExpressions = true
    sexlabConfig.SeparateOrgasms = true
    sexlabConfig.OrgasmEffects = true
    sexlabConfig.LimitedStrip = true
    sexlabConfig.RemoveHeelEffect = true
    sexlabConfig.ForeplayStage = true
    sexlabConfig.AllowCreatures = true

    NextStep()
endEvent

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
