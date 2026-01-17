ItemDropMenu()
{
    self createMenu("ItemDropMenu", "Item Drop Menu");

    self addOption("ItemDropMenu", "Support Items", &OpenSubMenu, "SupportDropMenu");
    self addOption("ItemDropMenu", "Misc. Game Items Menu (Salvage / Scrap, Armor, etc.)", &OpenSubMenu, "MiscGameItemsMenu");

    self createMenu("SupportDropMenu", "Support Items");

    foreach(entry in level.SupportItems)
    {
        name = entry[0];
        item = entry[1];

        self addOption("SupportDropMenu", name, &DropItem, item);
    }

    self createMenu("MiscGameItemsMenu", "Misc. Game Items Menu (Salvage / Scrap, Armor, etc.)");

    foreach(entry in level.MiscGameItems)
    {
        name = entry[0];
        item = entry[1];

        self addOption("MiscGameItemsMenu", name, &DropItem, item);
    }
}

DropItem(Item)
{
    scpBundle = getscriptbundle(Item);
    point = function_4ba8fde(Item);
    weap = (isDefined(scpBundle) && isDefined(scpBundle.weapon)) ? getweapon(Item) : undefined;

    if (isDefined(point))
    {
        cleanName = Item;
        cleanName = StrReplace(cleanName, "_item_sr", "");
        cleanName = StrReplace(cleanName, "_orange", "");
        cleanName = StrReplace(cleanName, "_purple", "");
        cleanName = StrReplace(cleanName, "_blue", "");
        cleanName = StrReplace(cleanName, "_white", "");

        angle  = self getangles();
        origin = self GetLookPosition();

        self item_drop::drop_item(
            0,
            (isDefined(weap) ? weap : undefined),
            1,
            (isDefined(weap) ? weap.maxammo : 0),
            point.id,
            origin,
            angle,
            3
        );

        playsoundatposition("zmb_powerup_eqp_spawn", origin);
        self iPrintlnBold("^5Item Dropped: ^2" + cleanName);
        wait 0.1;
    }
    else
    {
        self iPrintlnBold("Item Not Found: ^1" + Item);
    }
}
