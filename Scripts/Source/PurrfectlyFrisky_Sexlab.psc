scriptName PurrfectlyFrisky_Sexlab extends Quest

sslConfigMenu function GetMcmMenu() global
    return Game.GetFormFromFile(0x79840, "SexLab.esm") as sslConfigMenu
endFunction

function BeginInstallSexlab()
    ; Listen for installation to finish
    RegisterForModEvent("SexLabInstalled", "SexlabInstalled")
    
    ; Kick off installation
    if GetMcmMenu().SystemAlias.SetupSystem()
        Debug.Notification("SEXLAB INSTALLED")
    else
        Debug.Notification("Installing Sexlab...")
        RegisterForSingleUpdate(1.0)
    endIf
endFunction

event OnUpdate()
    if GetMcmMenu().SystemAlias.SetupSystem()
        Debug.MessageBox("SEXLAB INSTALLED")
    else
        RegisterForSingleUpdate(1.0)
    endIf
endEvent

event SexlabInstalled(int version)
    Debug.MessageBox("Sexlab installed!")
endEvent
