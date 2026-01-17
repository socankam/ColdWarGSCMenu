initializeStrings(){
    self.printlnInstructions = "[^3Crouch And Melee / Knife To Open Menu^7 | ^5Old School Style = Aim And Melee / Knife^7]";
    self.printlnBoldInstructions = "^BHUD_OBIT_DEATH_SUICIDE^ [ ^2Aim = Up ^7| [{+attack}] ^3= Down ^7| [{+reload}] ^5= Select ^7| [{+stance}] ^1= Back^7 ] ^BHUD_OBIT_DEATH_SUICIDE^";
    self.notVerified = "^1You are not verified to use this menu.";

    self.messages = [
        ["Stop Spamming Options", "^2Stop ^1spamming ^2options!"],
        ["Enjoy The Lobby", "^2Enjoy ^3the ^5lobby"],
        ["Menu Creator", "^2Menu created by ^3SoCanKam"],
        ["Derank Scare", "^2You've been ^1deranked!"],
        ["Stop Being Annoying", "^5Stop being ^1annoying!"],
        ["Menu Open Instructions", self.printlnInstructions],
        ["Menu Control Instructions", self.printlnBoldInstructions]
    ];
}