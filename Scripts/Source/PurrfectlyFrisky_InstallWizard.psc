scriptName PurrfectlyFrisky_InstallWizard extends InstallWizard

int _raceMenuCloseCountToTriggerInstall = 1 ; Listen for RaceMenu then start installer

event OnWizardInit()
    WizardName = "PurrfectlyFrisky"

    ; Listen for RaceMenu (we'll start installer afterwards)
    RegisterForMenu("RaceSex Menu")
    if Game.IsPluginInstalled("PurrfectlyNeko.esp")
        _raceMenuCloseCountToTriggerInstall += 1
    endIf
endEvent

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
