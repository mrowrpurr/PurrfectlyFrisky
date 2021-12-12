scriptName PurrfectlyFrisky_Sexlab

; sslConfigMenu function GetMcmMenu() global
;     return Game.GetFormFromFile(0x79840, "SexLab.esm") as sslConfigMenu
; endFunction

; PurrfectlyFrisky property Frisky auto

; event OnInit()
;     Frisky = GetAliasByName("PlayerRef") as PurrfectlyFrisky
; endEvent

; event SexlabInstalled()
;     Frisky.ShowWizardMessage("Sexlab Installed!\n\nContinue to install Sexlab animations")
; endEvent

; function BeginInstallSexlab()
;     ; Kick off installation
;     if GetMcmMenu().SystemAlias.SetupSystem()
;         SexlabInstalled()
;     else
;         RegisterForSingleUpdate(1.0)
;     endIf
; endFunction

; event OnUpdate()
;     if GetMcmMenu().SystemAlias.SetupSystem()
;         SexlabInstalled()
;     else
;         RegisterForSingleUpdate(1.0)
;     endIf
; endEvent
