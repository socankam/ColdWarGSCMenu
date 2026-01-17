function MessagesMenu() {
    self createMenu("MessagesMenu", "Messages Menu");

    for (i = 0; i < self.messages.size; i++) {
        label = self.messages[i][0];
        msg = self.messages[i][1];

        self addOption("MessagesMenu", label, &DisplayMessage, msg);
    }
}

DisplayMessage(message){
    foreach(player in level.players){
        if (!isDefined(message)) return;
        if (player IsHudBold()) player iPrintlnBold(message);
        else player iPrintln(message);
    }
}