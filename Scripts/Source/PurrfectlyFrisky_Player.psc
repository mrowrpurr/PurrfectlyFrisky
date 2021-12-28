scriptName PurrfectlyFrisky_Player extends ReferenceAlias

event OnPlayerLoadGame()
    (GetOwningQuest() as PurrfectlyFrisky).OnPlayerLoadGame()
endEvent
