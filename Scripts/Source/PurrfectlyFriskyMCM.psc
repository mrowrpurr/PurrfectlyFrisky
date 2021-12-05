scriptName PurrfectlyFriskyMCM extends SKI_ConfigBase

event OnConfigInit()
    ModName = "Purrfectly Frisky"
    Pages = new string[1]
    Pages[0] = "Settings"
endEvent

event OnPageReset(string page)
    AddToggleOption("Hello, world!", true)
endEvent
