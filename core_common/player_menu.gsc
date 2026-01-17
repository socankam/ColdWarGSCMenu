CreatePlayerMenu()
{
    self createMenu("PlayerMenu", "Player Menu");

    self.playerSubmenus = [];

    self thread updatePlayerMenu();
}

updatePlayerMenu()
{
    self endon("disconnect");

    while (true)
    {
        if (!isDefined(self.menu["items"]["PlayerMenu"]))
        {
            wait 1;
            continue;
        }

        foreach (player in level.players)
        {
            if (!isDefined(player) || !isAlive(player))
                continue;

            entNum = player getEntityNumber();

            if (!isDefined(self.playerSubmenus[entNum]))
            {
                BuildPlayerSubMenu(player);
            }
        }

        self.menu["items"]["PlayerMenu"]["options"] = [];

        foreach (player in level.players)
        {
            if (!isDefined(player) || !isAlive(player))
                continue;

            entNum = player getEntityNumber();
            if (!isDefined(self.playerSubmenus[entNum]))
                continue;

            displayName = player.name;

            if (player == level.host)
                displayName = "(Host) " + player.name;
            else if (isDefined(player.isCohost) && player.isCohost)
                displayName = "(Cohost) " + player.name;
            else if (isDefined(player.isVerified) && player.isVerified)
                displayName = "(Verified) " + player.name;

            self addOption("PlayerMenu", displayName, &OpenSubMenu, self.playerSubmenus[entNum]);
        }

        for (entNum = 0; entNum < self.playerSubmenus.size; entNum++)
        {
            if (!isDefined(self.playerSubmenus[entNum]))
                continue;

            stillHere = false;
            foreach (player in level.players)
            {
                if (player getEntityNumber() == entNum)
                {
                    stillHere = true;
                    break;
                }
            }

            if (!stillHere)
                self.playerSubmenus[entNum] = undefined;
        }

        wait 1;
    }
}

BuildPlayerSubMenu(player)
{
    entNum = player getEntityNumber();
    menuName = "PlayerMenu_" + entNum;

    self createMenu(menuName, player.name);
    self.playerSubmenus[entNum] = menuName;

    self.menu["items"][menuName]["options"] = [];

    if (self isHost() || self.isCohost)
    {
        self addOption(menuName, "Set As Verified", &SetPlayerVerified, player);
        if (self isHost())
            self addOption(menuName, "Set As Cohost", &SetPlayerCohost, player);
        self addOption(menuName, "Remove Verification", &RemovePlayerVerification, player);

        self addOption(menuName, "Freeze Player's Game", &FreezePlayersGame, player);
        self addOption(menuName, "Give UI Error", &GivePlayerUIError, player);
        self addOption(menuName, "Teleport Player To Me", &TeleportPlayerToMe, player);
        self addOption(menuName, "Mortar Strike Player", &MortarStrikePlayer, player);
        self addOption(menuName, "Show Player's XUID", &PrintPlayerXUID, player);
        self addOption(menuName, "Kill Player", &KillPlayer, player);
        self addOption(menuName, "Kick Player", &KickPlayer, player);
    }
}


SetPlayerVerified(player)
{
    if (!isDefined(player)) return;
    player.isVerified = true;
    if (!self isHost()) player iPrintlnBold("^2You have been verified by the host.");
    self iPrintln("^3" + player.name + " ^7has been set as ^2Verified.");
}

SetPlayerCohost(player)
{
    if (!isDefined(player)) return;
    player.isVerified = true;
    player.isCohost = true;
    if (!self isHost()) player iPrintlnBold("^5You have been promoted to ^3Cohost^7!");
    self iPrintln("^3" + player.name + " ^7is now a ^5Cohost^7.");
}

RemovePlayerVerification(player)
{
    if (!isDefined(player)) return;
    player.isVerified = false;
    player.isCohost = false;
    if (!self isHost()) player iPrintlnBold("^1Your verification has been removed.");
    self iPrintln("^3" + player.name + " ^7is no longer verified.");
}

GetPlayerStatus(player)
{
    if (!isDefined(player))
    {
        self iPrintln("^1That player is not defined!");
        return;
    }

    level.status = "^7Unverified";

    if (player isHost())
        level.status = "^2Host";
    else if (isDefined(player.isCohost) && player.isCohost)
        level.status = "^3Cohost";
    else if (isDefined(player.isVerified) && player.isVerified)
        level.status = "^6Verified";

}

FreezePlayersGame(player)
{
    player luinotifyevent(#"hash_6b67aa04e378d681", 1, "lol");
}

GivePlayerUIError(player)
{
    if(Zombies()) player luinotifyevent(#"hash_1fc4832b89307895", 1, "lol");
    if(Multiplayer()) player luinotifyevent(#"hash_76e8cddd9789122c", 1, "lol");
}

PrintPlayerXUID(player)
{
    self iPrintLn("^2" + player.name + "'s XUID: ^7" + player GetXUID());
}

TeleportPlayerToMe(player)
{
    player SetOrigin(self GetOrigin());
}

KillPlayer(player)
{
    player Suicide();
}

KickPlayer(player)
{
    Kick(player GetEntityNumber());
}

MortarStrikePlayer(player)
{
    self endon("disconnect");
    for(a = 0; a < 5; a++)
    {
        MagicBullet(GetWeapon(#"launcher_standard_t9"), player.origin + (0, 0, 2500), player.origin);
        wait 0.15;
    }
}
