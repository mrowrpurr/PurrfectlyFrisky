scriptName PurrfectlyNeko extends Quest

string RaceMenuName = "RaceSex Menu"
string RaceMenuPlayerPreset = "PurrfectlyNeko"

int up = 200
int down = 208
int left = 203
int right = 205
int enter = 28
int accept = 19 ; R

event OnInit()  
    SetupCharacter()
endEvent

; In the real version, we'll hide this under a full-screen HTML intro...
function SetupCharacter()
    ARTH_QF_LALStartQuest_02000DAF chargenQuest = Game.GetFormFromFile(0xdaf, "Alternate Start - Live Another Life.esp") as ARTH_QF_LALStartQuest_02000DAF
    chargenQuest.SetStage(10)
    OpenAndCloseRaceMenu()
    CharGen.LoadPreset(RaceMenuPlayerPreset)
    DressCharacter()
endFunction

function FinishSetupCharacter()
    Utility.WaitMenuMode(1)
    Game.ForceThirdPerson()
    Utility.WaitMenuMode(1)
    CharGen.LoadPreset(RaceMenuPlayerPreset)
    Game.ShowRaceMenu()
    Utility.WaitMenuMode(1)
    CharGen.LoadPreset(RaceMenuPlayerPreset)
endFunction

function DressCharacter()
    ; Form armbinder = Game.GetFormFromFile(0xd4d6, "Devious Devices - Expansion.esm")
    Form gloves = Game.GetFormFromFile(0x159ac, "Devious Devices - Expansion.esm")
    Form boots = Game.GetFormFromFile(0x159ae, "Devious Devices - Expansion.esm")
    Form dress = Game.GetFormFromFile(0x293a0, "Devious Devices - Expansion.esm")
    ; Form wrist = Game.GetFormFromFile(0x, "Devious Devices - Expansion.esm")
    Form arm = Game.GetFormFromFile(0xd4e1, "Devious Devices - Expansion.esm")
    Form ankle = Game.GetFormFromFile(0xd4e3, "Devious Devices - Expansion.esm")
    Form collar = Game.GetFormFromFile(0xd4df, "Devious Devices - Expansion.esm")
    Form corset = Game.GetFormFromFile(0x159a8, "Devious Devices - Expansion.esm")
    Form shoes = Game.GetFormFromFile(0xb811, "Crea_AtaHighHeels.esp")
    Form stockings = Game.GetFormFromFile(0x182b, "EquipableStockings.esp")

    Form panties = Game.GetFormFromFile(0x804, "CBBE Standalone Underwear.esp")
    Form bra = Game.GetFormFromFile(0x805, "CBBE Standalone Underwear.esp")

    Actor player = Game.GetPlayer()
    
    player.UnequipAll()
    player.RemoveAllItems()
    ; player.AddItem(gloves, abSilent = true)
    ; player.AddItem(boots, abSilent = true)
    ; player.AddItem(dress, abSilent = true)
    player.AddItem(arm, abSilent = true)
    player.AddItem(ankle, abSilent = true)
    player.AddItem(collar, abSilent = true)
    player.AddItem(corset, abSilent = true)
    player.AddItem(panties, abSilent = true)
    player.AddItem(bra, abSilent = true)
    player.AddItem(shoes, abSilent = true)
    ; player.AddItem(stockings, abSilent = true)
    ; player.EquipItemEx(gloves)
    ; player.EquipItemEx(boots)
    ; player.EquipItemEx(dress)
    player.EquipItemEx(arm)
    player.EquipItemEx(ankle)
    player.EquipItemEx(collar)
    player.EquipItemEx(corset)
    player.EquipItemEx(panties)
    player.EquipItemEx(bra)
    player.EquipItemEx(shoes)
    ; player.EquipItemEx(stockings)
endFunction

function OpenAndCloseRaceMenu()
    ; Right now assumes RaceMenu.esp, will update to also support vanilla.
    ; If BetterMessageBoxControls not detected, show a notification instead of opening menu at all.
    RegisterForMenu(RaceMenuName)
    Game.ShowRaceMenu()
endFunction

event OnMenuOpen(string menuName)
    RaceMenuAcceptAndClose()
endEvent

function RaceMenuAcceptAndClose()
    Wait()
    SendKey(accept)
    SendKey(enter)
    SendKey(enter)
endFunction

event OnMenuClose(string menuName)
    UnregisterForMenu(RaceMenuName)
    FinishSetupCharacter()
endEvent

function SendKey(int keyCode)
    Input.TapKey(keyCode)
    Wait()
endFunction

function Wait()
    Utility.WaitMenuMode(0.1)
endFunction
