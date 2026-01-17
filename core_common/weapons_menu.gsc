function WeaponsMenu()
{
    self createMenu("WeaponsMenu", "Weapons Menu");
    self addOption("WeaponsMenu", "Fully Upgrade Current Weapon", &UpgradeWeapon, []);
    self addOption("WeaponsMenu", "Camo Menu", &OpenSubMenu, "CamoMenu");
    self addOption("WeaponsMenu", "Give Normal Weapons", &OpenSubMenu, "GiveWeapons");
    self addOption("WeaponsMenu", "Give Upgraded Weapons", &OpenSubMenu, "GiveWeapons_Upgraded");
    self addOption("WeaponsMenu", "Give Specialist Weapons", &OpenSubMenu, "SpecialistWeapons");
    self addToggleOption("WeaponsMenu", "Give Teleport Gun", &StartTeleportGun, false);
    self addOption("WeaponsMenu", "Give Dev Default Weapon", &give_weapon, #"defaultweapon");
    self addOption("WeaponsMenu", "Give Nightingale", &give_weapon, #"nightingale");
    self addOption("WeaponsMenu", "Give Tesla Storm", &give_weapon, #"lightning_links");
    self addOption("WeaponsMenu", "Take Current Weapon", &TakeWeapon, []);

    self createMenu("CamoMenu", "Camo Menu");
    self addToggleOption("CamoMenu", "Disco Camo", &RainbowCamo, false);
    self addOption("CamoMenu", "Mastery Camos", &OpenSubMenu, "MasteryCamos");
    self addOption("CamoMenu", "Pack-a-Punch Camos", &OpenSubMenu, "PAPCamos");

    self createMenu("MasteryCamos", "Mastery Camos");
    self addOption("MasteryCamos", "Apply Gold Camo", &SetCamo, 61);
    self addOption("MasteryCamos", "Apply Diamond Camo", &SetCamo, 62);
    self addOption("MasteryCamos", "Apply DM Ultra Camo", &SetCamo, 63);
    self addOption("MasteryCamos", "Apply Gold (Zombies) Camo", &SetCamo, 64);
    self addOption("MasteryCamos", "Apply Diamond (Zombies) Camo", &SetCamo, 65);
    self addOption("MasteryCamos", "Apply Dark Aether Camo", &SetCamo, 66);

    self createMenu("PAPCamos", "Pack-a-Punch Camos");
    self addOption("PAPCamos", "Apply Die Maschine Camo 1", &SetCamo, 67);
    self addOption("PAPCamos", "Apply Die Maschine Camo 2", &SetCamo, 68);
    self addOption("PAPCamos", "Apply Die Maschine Camo 3", &SetCamo, 69);
    self addOption("PAPCamos", "Apply Mauer der Toten Camo 1", &SetCamo, 116);
    self addOption("PAPCamos", "Apply Mauer der Toten Camo 2", &SetCamo, 117);
    self addOption("PAPCamos", "Apply Mauer der Toten Camo 3", &SetCamo, 118);
    self addOption("PAPCamos", "Apply Forsaken Camo 1", &SetCamo, 119);
    self addOption("PAPCamos", "Apply Forsaken Camo 2", &SetCamo, 120);
    self addOption("PAPCamos", "Apply Forsaken Camo 3", &SetCamo, 121);

    self createMenu("GiveWeapons", "Give Normal Weapons");
    self addOption("GiveWeapons", "Assault Rifles", &OpenSubMenu, "AssaultRifles");
    self addOption("GiveWeapons", "SMGs", &OpenSubMenu, "SMGs");
    self addOption("GiveWeapons", "Tactical Rifles", &OpenSubMenu, "TacticalRifles");
    self addOption("GiveWeapons", "Snipers", &OpenSubMenu, "Snipers");
    self addOption("GiveWeapons", "Shotguns", &OpenSubMenu, "Shotguns");
    self addOption("GiveWeapons", "LMGs", &OpenSubMenu, "LMGs");
    self addOption("GiveWeapons", "Pistols", &OpenSubMenu, "Pistols");
    self addOption("GiveWeapons", "Melee Weapons", &OpenSubMenu, "Melee");

    BuildWeaponMenu("SpecialWonders", "Wonder Weapons", level.WonderWeaponNames, level.WonderWeapons, "player");
    self addOption("GiveWeapons", "Wonder Weapons", &OpenSubMenu, "SpecialWonders");

    BuildWeaponMenu("AssaultRifles", "Assault Rifles", level.AssaultRifleNames, level.AssaultRifles, "player");
    BuildWeaponMenu("SMGs", "SMGs", level.SMGNames, level.SMGs, "player");
    BuildWeaponMenu("TacticalRifles", "Tactical Rifles", level.TacticalRifleNames, level.TacticalRifles, "player");
    BuildWeaponMenu("Snipers", "Sniper Rifles", level.SniperNames, level.Snipers, "player");
    BuildWeaponMenu("Shotguns", "Shotguns", level.ShotgunNames, level.Shotguns, "player");
    BuildWeaponMenu("LMGs", "LMGs", level.LMGNames, level.LMGs, "player");
    BuildWeaponMenu("Pistols", "Pistols", level.PistolNames, level.Pistols, "player");
    BuildWeaponMenu("Melee", "Melee Weapons", level.MeleeNames, level.MeleeWeapons, "player");

    self createMenu("GiveWeapons_Upgraded", "Give Upgraded Weapons");
    self addOption("GiveWeapons_Upgraded", "Assault Rifles", &OpenSubMenu, "AssaultRifles_Up");
    self addOption("GiveWeapons_Upgraded", "SMGs", &OpenSubMenu, "SMGs_Up");
    self addOption("GiveWeapons_Upgraded", "Tactical Rifles", &OpenSubMenu, "TacticalRifles_Up");
    self addOption("GiveWeapons_Upgraded", "Snipers", &OpenSubMenu, "Snipers_Up");
    self addOption("GiveWeapons_Upgraded", "Shotguns", &OpenSubMenu, "Shotguns_Up");
    self addOption("GiveWeapons_Upgraded", "LMGs", &OpenSubMenu, "LMGs_Up");
    self addOption("GiveWeapons_Upgraded", "Pistols", &OpenSubMenu, "Pistols_Up");
    self addOption("GiveWeapons_Upgraded", "Melee Weapons", &OpenSubMenu, "Melee_Up");

    BuildUpgradedWeaponMenu("SpecialWonders_Up", "Wonder Weapons (PAP)", level.WonderWeaponNames, level.WonderWeapons);
    self addOption("GiveWeapons_Upgraded", "Wonder Weapons", &OpenSubMenu, "SpecialWonders_Up");

    BuildUpgradedWeaponMenu("AssaultRifles_Up", "Assault Rifles (PAP)", level.AssaultRifleNames, level.AssaultRifles);
    BuildUpgradedWeaponMenu("SMGs_Up", "SMGs (PAP)", level.SMGNames, level.SMGs);
    BuildUpgradedWeaponMenu("TacticalRifles_Up", "Tactical Rifles (PAP)", level.TacticalRifleNames, level.TacticalRifles);
    BuildUpgradedWeaponMenu("Snipers_Up", "Snipers (PAP)", level.SniperNames, level.Snipers);
    BuildUpgradedWeaponMenu("Shotguns_Up", "Shotguns (PAP)", level.ShotgunNames, level.Shotguns);
    BuildUpgradedWeaponMenu("LMGs_Up", "LMGs (PAP)", level.LMGNames, level.LMGs);
    BuildUpgradedWeaponMenu("Pistols_Up", "Pistols (PAP)", level.PistolNames, level.Pistols);
    BuildUpgradedWeaponMenu("Melee_Up", "Melee Weapons (PAP)", level.MeleeNames, level.MeleeWeapons);

    self createMenu("SpecialistWeapons", "Give Specialist Weapons");
    self addOption("SpecialistWeapons", "War Machine", &give_weapon, #"hero_pineapplegun");
    self addOption("SpecialistWeapons", "Fire Crossbow", &give_weapon, #"sig_bow_flame");
    self addOption("SpecialistWeapons", "Flamethrower", &give_weapon, #"hero_flamethrower");
    self addOption("SpecialistWeapons", "Annihilator", &give_weapon, #"hero_annihilator");
}

UpgradeWeapon()
{
    weapon = self GetCurrentWeapon();

    if ( !isdefined( weapon ) )
    {
        self iPrintlnBold("^1No weapon found.");
        return;
    }

    if ( !isDefined( self.var_2843d3cc ) )
    {
        self.var_2843d3cc = [];
    }
    else if ( !isArray( self.var_2843d3cc ) )
    {
        self.var_2843d3cc = array( self.var_2843d3cc );
    }

    if ( !isDefined( self.var_2843d3cc[ weapon ] ) )
        self.var_2843d3cc[ weapon ] = 0;

    if ( self.var_2843d3cc[ weapon ] >= 3 )
    {
        self iPrintlnBold("^1Your weapon is already fully upgraded!");
        self luinotifyevent(#"hash_8d33c3be569f08", 1, " ");
        return;
    }

    item = self item_inventory::function_230ceec4( weapon );

    if ( !isdefined( item ) )
    {
        self iPrintlnBold("^1Mystery Box / Wall Weapons Only!");
        self luinotifyevent(#"hash_8d33c3be569f08", 1, " ");
        return;
    }

    if ( isdefined( item.paplv ) )
    {
        self item_inventory::function_73ae3380( item, 3 );
    }
    else
    {
        self item_inventory::function_73ae3380( item, 1 );
        waitframe( 1 );

        weapon = self GetCurrentWeapon();
        item = self item_inventory::function_230ceec4( weapon );

        if ( !isdefined( item ) )
        {
            return;
        }

        item.paplv = 3;
        self notify( #"hash_75ec9942d2d5fd0f" );
        callback::callback( #"hash_75ec9942d2d5fd0f", { #paplv:3, #var_ca3e1138:weapon.name } );
        self setcamo( weapon, isdefined( level.var_f1662fe9 ) ? level.var_f1662fe9 : 69 );
    }

    weapon = self GetCurrentWeapon();
    if ( !isdefined( weapon ) )
        return;

    clipsize = self getweaponammoclip( weapon );
    stock    = self getweaponammostock( weapon );
    dualclip = 0;

    if ( isdefined( weapon.isdualwield ) && is_true( weapon.isdualwield ) &&
         isdefined( weapon.dualwieldweapon ) && weapon.dualwieldweapon != level.weaponnone )
    {
        dualclip = self getweaponammoclip( weapon.dualwieldweapon );
    }

    self zm_weapons::function_17e9ed37( #"epic", clipsize, stock, dualclip );

    self playsound( "zmb_powerup_chalice_gold_pickup" );

    weapon = self GetCurrentWeapon();
    self.var_2843d3cc[ weapon ] = 3;

    self iPrintlnBold("^2Your weapon has been fully upgraded!");
}

BuildWeaponMenu(menu, title, names, weapons, type)
{
    self createMenu(menu, title);
    if(type == "player"){
        for(i = 0; i < weapons.size; i++) self addOption(menu, names[i], &give_weapon, weapons[i]);
    }
    else{
        for(i = 0; i < weapons.size; i++) self addOption(menu, names[i], &GiveZombiesWeapon, weapons[i]);
    }
}

BuildUpgradedWeaponMenu(menu, title, names, weapons)
{
    self createMenu(menu, title);
    for(i = 0; i < weapons.size; i++)
        self addOption(menu, names[i] + " (Upgraded)", &give_weapon, hash(weapons[i] + "_upgraded"));
}

give_weapon(weapon_name)
{
    weapon = getweapon(isdefined(weapon_name) && ishash(weapon_name) ? weapon_name : hash(weapon_name));
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    return true;
}

SetCamo(id) {
    currentweapon = self getcurrentweapon();
    if (isdefined(currentweapon)) {
        self setcamo(currentweapon, id);
    }
}

StartTeleportGun()
{
    self.TeleportGun = isDefined(self.TeleportGun) ? undefined : true;
    if (isDefined(self.TeleportGun))
    {
        self thread DoTeleportGun();
    } 
    else 
    {
        self notify("StopTeleportGun");
    }
}

DoTeleportGun() 
{
    self endon("StopTeleportGun");
    while(isDefined(self.TeleportGun))
    {
        self waittill("weapon_fired");
        self SetOrigin(bullettrace(self GetTagOrigin("tag_weapon"), self GetTagOrigin("tag_weapon") + vector_scal(AnglesToForward(self GetPlayerAngles()), 10000), 1, self)["position"]);
        wait .1;
    }
    wait .1;
}

AmmoModifier()
{
    self.AmmoModifier = isDefined(self.AmmoModifier) ? undefined : true;
 
    if(isDefined(self.AmmoModifier))
    {
        self endon("disconnect");
        self endon("death");
        self endon("StopAmmoModifier");
 
        while(isDefined(self.AmmoModifier)) 
        {
            self.AmmoModifier = true;
            wait .15;
        }
    }
    else
        self notify("StopAmmoModifier");
        self.AmmoModifier = undefined;
}

SetAmmoMod(AmmoType){
    if(!isDefined(self.AmmoModifier))
    {
        self iPrintlnBold("^1Please enable the ammo modifier.");
        return;
    }
    
    self notify("StopAmmoModifier");
    wait 0.05;

    self endon("disconnect");
    self endon("StopAmmoModifier");
    
    while(isDefined(self.AmmoModifier)) 
    {
        self waittill(#"weapon_fired");

        MagicBullet(getWeapon(AmmoType), self getPlayerCameraPos(), BulletTrace(self getPlayerCameraPos(), self getPlayerCameraPos() + anglesToForward(self getPlayerAngles())  * 100000, false, self)["position"], self);
        wait .25;
    }
}

TakeWeapon() {
    weapon = self getcurrentweapon();
    if (isdefined(weapon) && self hasweapon(weapon)) {
        self takeweapon(weapon);
    }
}

RainbowCamo()
{
    self.RainbowCamo = isDefined(self.RainbowCamo) ? undefined : true;

    if (isDefined(self.RainbowCamo))
    {
        self endon("StopRainbowCamo");

        while (isDefined(self.RainbowCamo))
        {
            weapon = self GetCurrentWeapon();

            index = randomint(self.RainbowCamoList.size);
            camo = self.RainbowCamoList[index];

            self setcamo(weapon, camo);

            wait 0.1;
        }
    }
    else
    {
        self notify("StopRainbowCamo");
    }
}