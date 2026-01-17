on_player_connect() {
    self endon("disconnect");
    level endon(#"end_game", #"game_ended");

    if (!isDefined(level.coasterExists)) level.coasterExists = false;

    initializeVars();
    initializeMenu();
    initializeItems();
    initializeStrings();

    if (self isHost()) {
        self.isVerified = true;
        self.isCohost = true;
    }

    setupMenu();
}

on_player_spawned() {
    self endon("disconnect");
    level endon(#"end_game", #"game_ended");

    self notify("stop_menu_threads");
    self thread initializeVision();
    wait 0.25;
    GetPlayerStatus(self);

    self thread menu_think_loop();
    self.menu["dynamicVars"]["Noclip"] = false;
    self.noclip_on = false;
}

initializeMenu() {
    if (!isDefined(level.MainMenuRegistry)) level.MainMenuRegistry = [];
    level.MainMenuRegistry["HostMenu"] = &HostMenu;
    level.MainMenuRegistry["AccountMenu"] = &AccountMenu;
    level.MainMenuRegistry["PersonalMenu"] = &PersonalMenu;
    level.MainMenuRegistry["ZombiesMenu"] = &ZombiesMenu;
    level.MainMenuRegistry["WeaponsMenu"] = &WeaponsMenu;
    level.MainMenuRegistry["ItemDropMenu"] = &ItemDropMenu;
    level.MainMenuRegistry["ForgeMenu"] = &ForgeMenu;
    level.MainMenuRegistry["CharacterMenu"] = &CharacterMenu;
    level.MainMenuRegistry["VehiclesMenu"] = &VehiclesMenu;
    level.MainMenuRegistry["VisionMenu"] = &VisionMenu;
    level.MainMenuRegistry["MessagesMenu"] = &MessagesMenu;
    level.MainMenuRegistry["LuiDebugMenu"] = &LuiDebugMenu;

    if (!isDefined(self.menu)) {
        self.menu = [];
        self.menu["items"] = [];
        self.menu["currentMenu"] = "";
        self.menu["currentIndex"] = 0;
        self.menu["menuIsOpen"] = false;
        self.menu["dynamicVars"] = [];
        self.menu["menuStack"] = [];
    }

    if (!isDefined(self.dynamic_color_index)) self.dynamic_color_index = 0;

    // 1 = hintTrigger / default, 2 = iPrintlnBold
    if (!isDefined(self.menu["hudStyle"])) self.menu["hudStyle"] = 1;

    if (!isDefined(self.menu["needsRedraw"])) self.menu["needsRedraw"] = false;
    if (!isDefined(self.menu["lastHudSig"])) self.menu["lastHudSig"] = "";
    if (!isDefined(self.menu["lastHudPrintTime"])) self.menu["lastHudPrintTime"] = 0;
    if (!isDefined(self.menu["lastKeepAliveTime"])) self.menu["lastKeepAliveTime"] = 0;
    if (!isDefined(self.menu["printLines"])) self.menu["printLines"] = [];
}

setupMenu() {
    self createMenu("Main", "Main Menu");

    if (self isHost() || self.isCohost) self addOption("Main", "Host Menu", &OpenSubMenu, "HostMenu");
    if(Zombies()) self addOption("Main", "Account Menu", &OpenSubMenu, "AccountMenu");
    self addOption("Main", "Personal Menu", &OpenSubMenu, "PersonalMenu");
    if(Zombies()) self addOption("Main", "Zombies Menu", &OpenSubMenu, "ZombiesMenu");
    self addOption("Main", "Weapons Menu", &OpenSubMenu, "WeaponsMenu");
    self addOption("Main", "Item Drop Menu", &OpenSubMenu, "ItemDropMenu");
    self addOption("Main", "Forge Menu", &OpenSubMenu, "ForgeMenu");
    self addOption("Main", "Character Menu", &OpenSubMenu, "CharacterMenu");
    self addOption("Main", "Vehicles Menu", &OpenSubMenu, "VehiclesMenu");
    self addOption("Main", "Vision Menu", &OpenSubMenu, "VisionMenu");
    if (self isHost() || self.isCohost) self addOption("Main", "Messages Menu", &OpenSubMenu, "MessagesMenu");
    if (self isHost()) self addOption("Main", "LUI Debug Menu", &OpenSubMenu, "LuiDebugMenu");
    self addOption("Main", "Menu Style", &ChangeMenuStyle, undefined);

    foreach (menuKey, initFunction in level.MainMenuRegistry) {
        [[initFunction]]();
    }
}

update_dynamic_color() {
    self endon("stop_menu_threads");
    self endon("disconnect");
    while (true) {
        self.dynamic_color_index = (self.dynamic_color_index + 1) % self.colors.size;
        wait 0.1;
    }
}

menu_think_loop()
{
    self endon("stop_menu_threads");
    self endon("disconnect");

    self thread update_dynamic_color();

    while (true)
    {
        if (!self.menu["menuIsOpen"])
        {
            tryOpenMenu(self);
        }

        if (self.menu["menuIsOpen"])
        {
            handleMenuNavigation(self);
        }

        wait 0.05;
    }
}

tryOpenMenu(player)
{
    giveBriefcase = false;
    openWithMenu = false;

    if (player ADSButtonPressed() && player MeleeButtonPressed())
    {
        giveBriefcase = true;
        openWithMenu = true;
    }
    else if (player getStance() == "crouch" && player MeleeButtonPressed())
    {
        openWithMenu = true;
    }

    if (openWithMenu)
    {
        if (!isDefined(player.isVerified) || !player.isVerified)
        {
            player iPrintlnBold(self.notVerified);
            while (player MeleeButtonPressed()) wait 0.05;
            return;
        }
        player thread openMenu(player, giveBriefcase);
        while (player MeleeButtonPressed()) wait 0.05;
    }
}

openMenu(player, withBriefcase)
{
    player.menu["menuIsOpen"] = true;
    player.menu["menuStack"] = [];
    player.menu["currentMenu"] = "Main";
    player.menu["currentIndex"] = 0;

    if (!isDefined(player.menu["hudStyle"])) player.menu["hudStyle"] = 1;

    player.menu["needsRedraw"] = true;
    player.menu["lastHudSig"] = "";
    player.menu["lastHudPrintTime"] = 0;
    player.menu["lastKeepAliveTime"] = 0;

    if (player.menu["hudStyle"] == 1)
    {
        if (!isDefined(player.hintTrigger))
        {
            player.hintTrigger = spawn("trigger_radius", player.origin, 0, 200, 200, 200);
            player.hintTrigger triggerignoreteam();
            player.hintTrigger setvisibletoplayer(player);
        }
    }
    else
    {
        if (isDefined(player.hintTrigger))
            player.hintTrigger delete();
        player.hintTrigger = undefined;
        player thread menu_print_refresh_loop();
    }

    entry = self.clientfields[0];
    field = entry[0];
    if (ishash(field))
        field = "" + field;
    player clientfield::set(field, 1);

    if (withBriefcase){
        self luinotifyevent(#"hash_2f5757ad20bc3ae", 1, " ");
        player disableweaponfire();
        player.savedWeapon = player getCurrentWeapon();
        wait 0.15;
        player giveWeapon(getWeapon("inventory_ac130"));
        wait 0.15;
        player switchToWeapon(getWeapon("inventory_ac130"));
    }

    player.menu["currentMenu"] = "Main";
    player.menu["currentIndex"] = 0;
    updateMenuHUD(player, player.menu["items"]["Main"]);

    player thread menu_hud_instructions();
}

PrintVerticalMenu(lines)
{
    for (i = 0; i < 10; i++)
        self iPrintlnBold(".");

    for (i = 0; i < lines.size; i++)
        self iPrintlnBold(lines[i]);
}

menu_print_refresh_loop()
{
    self endon("stop_menu_threads");
    self endon("disconnect");
    self endon("menu_closed");

    while (self.menu["menuIsOpen"] && self.menu["hudStyle"] == 2)
    {
        now = gettime();

        canDrawFast = (now - self.menu["lastHudPrintTime"]) > 350;
        keepAlive = (now - self.menu["lastKeepAliveTime"]) > 4000;

        if ((isDefined(self.menu["needsRedraw"]) && self.menu["needsRedraw"] && canDrawFast) || keepAlive)
        {
            currentKey = self.menu["currentMenu"];
            if (isDefined(self.menu["items"][currentKey]))
                updateMenuHUD(self, self.menu["items"][currentKey]);

            self PrintVerticalMenu(self.menu["printLines"]);

            self.menu["needsRedraw"] = false;
            self.menu["lastHudPrintTime"] = now;
            self.menu["lastKeepAliveTime"] = now;
        }

        wait 0.1;
    }
}

handleMenuNavigation(player)
{
    if (!player.menu["menuIsOpen"])
        return;

    currentMenuKey = player.menu["currentMenu"];
    menu = player.menu["items"][currentMenuKey];

    if (!isDefined(menu))
        return;

    changed = false;

    if (player AttackButtonPressed())
    {
        player.menu["currentIndex"]++;
        if (player.menu["currentIndex"] >= menu["options"].size)
            player.menu["currentIndex"] = 0;

        changed = true;
        while (player AttackButtonPressed()) wait 0.1;
    }
    else if (player ADSButtonPressed())
    {
        player.menu["currentIndex"]--;
        if (player.menu["currentIndex"] < 0)
            player.menu["currentIndex"] = menu["options"].size - 1;

        changed = true;
        while (player ADSButtonPressed()) wait 0.1;
    }
    else if (player StanceButtonPressed() || player MeleeButtonPressed())
    {
        handleMenuBack(player);
        changed = true;

        while (player StanceButtonPressed() || player MeleeButtonPressed())
            wait 0.1;

        if (!player.menu["menuIsOpen"])
            return;
    }
    else if (player UseButtonPressed())
    {
        if (isDefined(player.savedWeapon))
        {
            for (i = 1; i < self.clientfields.size; i++)
            {
                entry = self.clientfields[i];

                field = entry[0];
                kind  = entry[1];

                if (ishash(field))
                    field = "" + field;

                switch (kind)
                {
                    case "player":
                        player clientfield::set_to_player(field, 1);
                        break;

                    default:
                        player clientfield::set(field, 1);
                        break;
                }
            }
        }

        selectOption(player.menu["currentMenu"]);
        changed = true;

        while (player UseButtonPressed()) wait 0.1;

        if (!player.menu["menuIsOpen"])
            return;
    }

    if (changed)
        player.menu["needsRedraw"] = true;

    currentMenuKey = player.menu["currentMenu"];
    if (!isDefined(player.menu["items"][currentMenuKey]))
        return;

    menu = player.menu["items"][currentMenuKey];

    updateMenuHUD(player, menu);
}

handleMenuBack(player)
{
    currentMenu = player.menu["currentMenu"];
    if (currentMenu != "Main")
    {
        if (player.menu["menuStack"].size > 0)
        {
            lastIndex = player.menu["menuStack"].size - 1;
            last = player.menu["menuStack"][lastIndex];
            player.menu["menuStack"][lastIndex] = undefined;

            newStack = [];
            for(i = 0; i < lastIndex; i++)
                newStack[i] = player.menu["menuStack"][i];
            player.menu["menuStack"] = newStack;

            player.menu["currentMenu"] = last[0];
            player.menu["currentIndex"] = last[1];
        }
        else
        {
            player.menu["currentMenu"] = "Main";
            player.menu["currentIndex"] = 0;
        }
    }
    else CloseMenu();
}

updateMenuHUD(player, menu)
{
    if (!isDefined(player.menu["hudStyle"])) player.menu["hudStyle"] = 1;

    itemsPerPage = (player.menu["hudStyle"] == 2) ? 4 : 15;

    numOptions = menu["options"].size;
    totalPages = ceil(numOptions / itemsPerPage);
    if (totalPages < 1) totalPages = 1;

    currentPage = int(player.menu["currentIndex"] / itemsPerPage) + 1;
    startIndex = (currentPage - 1) * itemsPerPage;
    endIndex = min(startIndex + itemsPerPage, numOptions);

    color = player.colors[player.dynamic_color_index];

    if (player.menu["hudStyle"] == 1)
    {
        menu_display = "^5(" + menu["title"] + ")^7";

        for (i = startIndex; i < endIndex; i++)
        {
            option = menu["options"][i];
            str = option[0];

            if (option[0] == "Menu Style")
            {
                styleName = (player.menu["hudStyle"] == 1) ? "Default" : "iPrintlnBold";
                str += " ^7(" + styleName + ")" + color;
            }

            if (isDefined(player.menu["dynamicVars"][option[0]]))
            {
                state = player.menu["dynamicVars"][option[0]];
                str += " " + (state ? "^2[ON]" + color : "^1[OFF]" + color);
            }
            else if (isDefined(option[3]))
                str += " " + option[3];

            if (i == player.menu["currentIndex"])
                str = "^3|" + color + "<[" + str + "]>";
            else
                str = "^3|^7" + str;

            menu_display += str;
        }

        arrowDisplay = " ^3[Page " + currentPage + "/" + totalPages + "]";
        if (player.menu["currentMenu"] == "Main") arrowDisplay += " ([{+stance}] or Knife = Close Menu | [{+reload}] = Select)";
        else arrowDisplay += " ([{+stance}] or Knife = Back | [{+reload}] = Select)";

        menu_display += arrowDisplay;

        if (!isDefined(player.hintTrigger))
        {
            player.hintTrigger = spawn("trigger_radius", player.origin, 0, 200, 200, 200);
            player.hintTrigger triggerignoreteam();
            player.hintTrigger setvisibletoplayer(player);
        }

        player.hintTrigger sethintstring(menu_display);
        player.hintTrigger.origin = player.origin;
        return;
    }

    if (isDefined(player.hintTrigger))
        player.hintTrigger delete();
    player.hintTrigger = undefined;

    lines = [];
    lines[lines.size] = "^3[" + menu["title"] + "]";

    for (i = startIndex; i < endIndex; i++)
    {
        option = menu["options"][i];
        str = option[0];

        if (option[0] == "Menu Style")
        {
            styleName = (player.menu["hudStyle"] == 1) ? "Default" : "iPrintlnBold";
            str += " ^7(" + styleName + ")" + color;
        }

        if (isDefined(player.menu["dynamicVars"][option[0]]))
        {
            state = player.menu["dynamicVars"][option[0]];
            str += " " + (state ? "^2[ON]" + color : "^1[OFF]" + color);
        }
        else if (isDefined(option[3]))
            str += " " + option[3];

        if (i == player.menu["currentIndex"])
            lines[lines.size] = self.scrollbar + "^3---> ^5" + str + " ^3<---" + self.scrollbar;
        else
            lines[lines.size] = "^7" + str;
    }

    arrowDisplay = " ^3[Page " + currentPage + "/" + totalPages + "] [{+reload}] = ^2Select ^3| [{+stance}] or Knife = ^2Back";
    lines[lines.size] = arrowDisplay;

    sig = menu["title"] + "|" + player.menu["currentMenu"] + "|" + player.menu["currentIndex"] + "|" + currentPage + "|" + player.menu["hudStyle"];

    player.menu["printLines"] = lines;

    if (!isDefined(player.menu["lastHudSig"])) player.menu["lastHudSig"] = "";
    if (sig != player.menu["lastHudSig"])
    {
        player.menu["lastHudSig"] = sig;
        player.menu["needsRedraw"] = true;
    }
}

menu_hud_instructions() {
    self endon("stop_menu_threads");
    self endon("disconnect");
    if(self.menu["menuIsOpen"]) self iPrintln("^5Created by: ^1SoCanKam");
    while (self.menu["menuIsOpen"]) {
        wait 5;
    }
}

createMenu(menuKey, title) {
    if (!isDefined(self.menu["items"][menuKey])) {
        self.menu["items"][menuKey] = [];
        self.menu["items"][menuKey]["title"] = title;
        self.menu["items"][menuKey]["options"] = [];
        self.menu["items"][menuKey]["menuIsOpen"] = false;
    }
}

addOption(menuKey, name, func, params) {
    menu = self.menu["items"][menuKey];
    idx = menu["options"].size;
    menu["options"][idx] = [];
    menu["options"][idx][0] = name;
    menu["options"][idx][1] = func;
    menu["options"][idx][2] = params;
}

addToggleOption(menuKey, name, func, initialState) {
    menu = self.menu["items"][menuKey];
    idx = menu["options"].size;
    menu["options"][idx] = [];

    if (isDefined(self.menu["dynamicVars"][name])) initialState = self.menu["dynamicVars"][name];
    else self.menu["dynamicVars"][name] = initialState;

    menu["options"][idx][0] = name;
    menu["options"][idx][1] = func;
    menu["options"][idx][2] = undefined;
    menu["options"][idx][4] = initialState;
}

selectOption(menuKey) {
    menu = self.menu["items"][menuKey];
    selectedOption = menu["options"][self.menu["currentIndex"]];

    if (isDefined(selectedOption[1])) {
        if (isDefined(self.menu["dynamicVars"][selectedOption[0]])) {
            currentState = self.menu["dynamicVars"][selectedOption[0]];
            self.menu["dynamicVars"][selectedOption[0]] = !currentState;
            self thread [[selectedOption[1]]](!currentState);
        } else {
            self thread [[selectedOption[1]]](selectedOption[2]);
        }
    }
}

CloseMenu() {
    if (isDefined(self.hintTrigger)) {
        self.hintTrigger delete();
    }

    foreach (entry in self.clientfields)
    {
        field = entry[0];
        kind = entry[1];

        if (ishash(field))
            field = "" + field;

        switch (kind)
        {
            case "player":
                self clientfield::set_to_player(field, 0);
                break;

            default:
                self clientfield::set(field, 0);
                break;
        }
    }

    if (isDefined(self.savedWeapon)) {
        self enableweaponfire();
        self giveWeapon(self.savedWeapon);
        wait 0.1;
        self switchToWeapon(self.savedWeapon);
        self.savedWeapon = undefined;
    }

    self.menu["currentMenu"] = "";
    self.menu["currentIndex"] = 0;
    self.menu["menuIsOpen"] = false;
    self.menu["menuStack"] = [];

    self.menu["needsRedraw"] = false;
    self.menu["lastHudSig"] = "";
    self.menu["lastHudPrintTime"] = 0;
    self.menu["lastKeepAliveTime"] = 0;

    for (i = 0; i < 10; i++) self iPrintlnBold(".");

    self notify("menu_closed");
    for( i = 0;i <= 55;i++ ) self iPrintln("");
}

OpenSubMenu(menuKey)
{
    if (!isDefined(self.menu["items"][menuKey])) return;

    idx = self.menu["menuStack"].size;
    self.menu["menuStack"][idx] = [self.menu["currentMenu"], self.menu["currentIndex"]];

    self.menu["currentMenu"] = menuKey;
    self.menu["currentIndex"] = 0;
}

GoBack(targetMenu) {
    if (!isDefined(targetMenu) || targetMenu == "") targetMenu = "Main";
    self.menu["currentMenu"] = targetMenu;
    self.menu["currentIndex"] = 0;
}

ChangeMenuStyle(desiredStyle)
{
    if (!isDefined(self.menu["hudStyle"])) self.menu["hudStyle"] = 1;

    if (isDefined(desiredStyle))
    {
        if (desiredStyle != 1 && desiredStyle != 2)
            desiredStyle = 1;

        self.menu["hudStyle"] = desiredStyle;
    }
    else
    {
        self.menu["hudStyle"] = (self.menu["hudStyle"] == 1) ? 2 : 1;
    }

    if (self.menu["hudStyle"] == 1)
    {
        if (!isDefined(self.hintTrigger))
        {
            self.hintTrigger = spawn("trigger_radius", self.origin, 0, 200, 200, 200);
            self.hintTrigger triggerignoreteam();
            self.hintTrigger setvisibletoplayer(self);
        }
    }
    else
    {
        if (isDefined(self.hintTrigger))
            self.hintTrigger delete();
        self.hintTrigger = undefined;

        self.menu["lastHudText"] = "";
        self.menu["lastHudPrintTime"] = 0;
    }

    if (isDefined(self.menu) && isDefined(self.menu["menuIsOpen"]) && self.menu["menuIsOpen"])
    {
        currentKey = self.menu["currentMenu"];
        if (isDefined(self.menu["items"][currentKey]))
            updateMenuHUD(self, self.menu["items"][currentKey]);
    }
    self CloseMenu();
    wait 1;
    self thread openMenu(self, false);
}