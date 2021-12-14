scriptName PurrfectlyFrisky_Installer_Effect extends activemagiceffect  

event OnEffectStart(Actor target, Actor caster)
    ; PurrfectlyFrisky_Installer_Effect
    PurrfectlyFrisky theQuest = Game.GetFormFromFile(0x800, "PurrfectlyFrisky.esp") as PurrfectlyFrisky
    PurrfectlyFrisky_InstallWizard installer = theQuest.GetAliasByName("PlayerRef") as PurrfectlyFrisky_InstallWizard
    installer.Start()
endEvent
