scriptname PurrfectlyFrisky extends ReferenceAlias

string property JsonConfigFileDirectoryPath = "Data/PurrfectlyFrisky/Config" autoReadonly
string property CurrentlyInstalledVersion auto

string function GetCurrentVersion() global
    return "0.1"
endFunction

;
; Mod Installation
;
event OnInit()
    CurrentlyInstalledVersion = GetCurrentVersion()
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
