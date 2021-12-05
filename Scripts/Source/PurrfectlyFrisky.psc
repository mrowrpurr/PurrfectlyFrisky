scriptname PurrfectlyFrisky extends ReferenceAlias

; Basic config
string property JsonConfigFileDirectoryPath = "Data/PurrfectlyFrisky/Config" autoReadonly
string property CurrentlyInstalledVersion auto

; Scripts
PurrfectlyFrisky_Sexlab property PurrfectlyFrisky_Sexlab_Script auto

; Messages
Message property PurrfectlyFrisky_Welcome auto

string function GetCurrentVersion() global
    return "0.1"
endFunction

;
; Mod Installation
;
event OnInit()
    CurrentlyInstalledVersion = GetCurrentVersion()
    ; We'll wait for you to finish your RaceMenu character creation
    RegisterForMenu("RaceSex Menu")
endEvent

;
; Load Game (may have previous version installed)
;
event OnPlayerLoadGame()
    _jsonConfigData = 0 ; Force refresh of JSON files
    ; Debug.
endEvent

;
; Main Entry Point to JSON config files loaded from disk
;
int _jsonConfigData
int property JsonConfigData
    int function get()
        if ! _jsonConfigData
            _jsonConfigData = JValue.readFromDirectory(JsonConfigFileDirectoryPath)
        endIf
        return _jsonConfigData
    endFunction
endProperty

; Begin installation Wizard when RaceMenu is closed
event OnMenuClose(string menuName)
    if menuName == "RaceSex Menu"
        PurrfectlyFrisky_Welcome.Show()
        UnregisterForMenu("RaceSex Menu")
        PurrfectlyFrisky_Sexlab_Script.BeginInstallSexlab()
    endIf
endEvent
