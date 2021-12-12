scriptname PurrfectlyFrisky extends Quest

; ; Basic config
; string property JsonConfigFileDirectoryPath = "Data/PurrfectlyFrisky/Config" autoReadonly
; string property CurrentlyInstalledVersion auto

; ; Scripts
; PurrfectlyFrisky_Sexlab property PurrfectlyFrisky_Sexlab_Script auto

; ; Messages
; Message property PurrfectlyFrisky_WizardMessage1 auto

; ; Message Text Form
; Form property PurrfectlyFrisky_MessageText_BaseForm auto

; ; Global Variables
; GlobalVariable property PurrfectlyFrisky_MessageButton_Back auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_BeginMyJourney auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Cancel auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Disable auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_DisableAll auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Enable auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_EnableAll auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Exit auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Install auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Next auto
; GlobalVariable property PurrfectlyFrisky_MessageButton_Ok auto

; ; Wizard Button Values
; int BUTTON_BEGIN_JOURNEY = 0
; int BUTTON_BACK = 1
; int BUTTON_INSTALL = 2
; int BUTTON_ENABLE_ALL = 3
; int BUTTON_ENABLE = 4
; int BUTTON_DISABLE = 5
; int BUTTON_DISABLE_ALL = 6
; int BUTTON_NEXT = 7
; int BUTTON_CANCEL = 8
; int BUTTON_EXIT = 9

; string function GetCurrentVersion() global
;     return "0.1"
; endFunction

; ;
; ; Mod Installation
; ;
; event OnInit()
;     CurrentlyInstalledVersion = GetCurrentVersion()
;     ; We'll wait for you to finish your RaceMenu character creation
;     RegisterForMenu("RaceSex Menu")
; endEvent

; ;
; ; Load Game (may have previous version installed)
; ;
; event OnPlayerLoadGame()
;     _jsonConfigData = 0 ; Force refresh of JSON files
;     ; Debug.
; endEvent

; ;
; ; Main Entry Point to JSON config files loaded from disk
; ;
; int _jsonConfigData
; int property JsonConfigData
;     int function get()
;         if ! _jsonConfigData
;             _jsonConfigData = JValue.readFromDirectory(JsonConfigFileDirectoryPath)
;         endIf
;         return _jsonConfigData
;     endFunction
; endProperty

; ; Begin installation Wizard when RaceMenu is closed
; event OnMenuClose(string menuName)
;     if menuName == "RaceSex Menu"
;         UnregisterForMenu("RaceSex Menu")
;         BeginSetup()
;     endIf
; endEvent

; function BeginSetup()
;     if ShowWizardMessage("~ Welcome to Purrfectly Frisky ~\n\nAre you ready to begin?", begin = true, exit = true) == BUTTON_BEGIN_JOURNEY
;         if ShowWizardMessage("Install Sexlab", install = true, cancel = true) == BUTTON_INSTALL
;             PurrfectlyFrisky_Sexlab_Script.BeginInstallSexlab()
;         else
;             ; TODO
;         endIf
;     else
;         ; TODO
;     endIf
; endFunction

; int function ShowWizardMessage(string text, bool back = false, bool begin = false, bool cancel = false, bool disable = false, bool disableAll = false, bool enable = false, bool enableAll = false, bool exit = false, bool install = false, bool next = false, bool ok = false)
;     PurrfectlyFrisky_MessageText_BaseForm.SetName(text)
;     PurrfectlyFrisky_MessageButton_Back.Value = back as int
;     PurrfectlyFrisky_MessageButton_BeginMyJourney.Value = begin as int
;     PurrfectlyFrisky_MessageButton_Cancel.Value = cancel as int
;     PurrfectlyFrisky_MessageButton_Disable.Value = disable as int
;     PurrfectlyFrisky_MessageButton_DisableAll.Value = disableAll as int
;     PurrfectlyFrisky_MessageButton_Enable.Value = enable as int
;     PurrfectlyFrisky_MessageButton_EnableAll.Value = enableAll as int
;     PurrfectlyFrisky_MessageButton_Exit.Value = exit as int
;     PurrfectlyFrisky_MessageButton_Install.Value = install as int
;     PurrfectlyFrisky_MessageButton_Next.Value = next as int
;     PurrfectlyFrisky_MessageButton_Ok.Value = ok as int
;     return PurrfectlyFrisky_WizardMessage1.Show()
; endFunction
