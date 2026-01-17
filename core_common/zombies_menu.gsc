function ZombiesMenu() {
    self createMenu("ZombiesMenu", "Zombies Menu");
    self addOption("ZombiesMenu", "Fun Zombie Options", &OpenSubMenu, "FunZombieOptions");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Change Round", &OpenSubMenu, "RoundMenu");
    self addOption("ZombiesMenu", "Points Menu", &OpenSubMenu, "PointsMenu");
    self addOption("ZombiesMenu", "Powerups Menu", &OpenSubMenu, "PowerupsMenu");
    self addOption("ZombiesMenu", "Apply Ammo Mods", &OpenSubMenu, "AmmoModifier");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Mystery Box Menu", &OpenSubMenu, "MysteryBoxMenu");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Zombie / Boss Spawn Menu", &OpenSubMenu, "ZombieSpawnMenu");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Give Zombies Weapons", &OpenSubMenu, "GiveZombiesWeapons");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Zombie Speed Modifier", &OpenSubMenu, "ZombieSpeedMenu");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Zombie Eye Color Modifier", &OpenSubMenu, "ZombieEyeColorMenu");
    if (self isHost() || self.isCohost) self addOption("ZombiesMenu", "Zombie Model Changer", &OpenSubMenu, "ZombieModels");

    self createMenu("PointsMenu", "Points Menu");
    self addOption("PointsMenu", "5,000 Points", &EditPoints, "5000");
    self addOption("PointsMenu", "10,000 Points", &EditPoints, "10000");
    self addOption("PointsMenu", "25,000 Points", &EditPoints, "25000");
    self addOption("PointsMenu", "50,000 Points", &EditPoints, "50000");
    self addOption("PointsMenu", "75,000 Points", &EditPoints, "75000");
    self addOption("PointsMenu", "100,000 Points", &EditPoints, "100000");
    self addOption("PointsMenu", "Give Max Points", &EditPoints, "999999");
    self addOption("PointsMenu", "Take All Points", &EditPoints, "0");

    self createMenu("PowerupsMenu", "Powerups Menu");
    self addOption(
        "PowerupsMenu",
        "Give All Powerups",
        &GivePowerup,
        "all"
    );
    self addOption("PowerupsMenu", "Give Insta-kill", &GivePowerup, "insta_kill");
    self addOption("PowerupsMenu", "Give Max Ammo", &GivePowerup, "full_ammo");
    self addOption("PowerupsMenu", "Give Double Points", &GivePowerup, "double_points");
    self addOption("PowerupsMenu", "Give Nuke", &GivePowerup, "nuke");
    self addOption("PowerupsMenu", "Give Carpenter", &GivePowerup, "carpenter");
    self addOption("PowerupsMenu", "Give Fire Sale", &GivePowerup, "fire_sale");
    if (util::get_map_name() == "zm_tungsten") self addOption("PowerupsMenu", "Give Bonfire Sale", &GivePowerup, "bonfire_sale");
    self addOption("PowerupsMenu", "Give Free Perk", &GivePowerup, "free_perk");
    self addOption("PowerupsMenu", "Give Bonus Points (Team)", &GivePowerup, "bonus_points_team");
    self addOption("PowerupsMenu", "Give Bonus Points (Just You)", &GivePowerup, "bonus_points_player");
    self addOption("PowerupsMenu", "Give Full Power", &GivePowerup, "hero_weapon_power");

    self createMenu("MysteryBoxMenu", "Mystery Box Menu");
    if (self isHost() || self.isCohost) self addToggleOption("MysteryBoxMenu", "Free Mystery Box", &FreeMysteryBox, false);
    self addToggleOption("MysteryBoxMenu", "Mystery Box Doesn't Move", &FreezeMysteryBox, false);
    self addOption("MysteryBoxMenu", "Teleport To Mystery Box", &TeleportToMysteryBox, "me");
    if (self isHost()) self addOption("MysteryBoxMenu", "Teleport Everyone To Mystery Box", &TeleportToMysteryBox, "all");

    self createMenu("FunZombieOptions", "Fun Zombie Options");
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "Kill Aura", &ToggleKillAura, false);// Credit to TheUnknownCod3r
    self addToggleOption("FunZombieOptions", "Stuffed Animal Companions", &ToggleCompanions, false);
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "One Hit Zombies", &OneHitZombies, false);
    self addToggleOption("FunZombieOptions", "Zombies Ignore You", &NoTarget, false);
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "Zombies Ignore All Players", &NoTargetAll, false);
    self addOption("FunZombieOptions", "Headless Zombies", &HeadlessZombies, []);
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "Invisible Zombies", &InvisibleZombies, false);
    if (self isHost() || self.isCohost) self addOption("FunZombieOptions", "Deformed Zombies", &ZombieAttachModel, "c_t9_zmb_posed_quest_zombie");
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "Freeze All Zombies", &FreezeZombies, false);
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "Zombies Have Hellhound FX", &ZombieDogFX, false);
    if (self isHost() || self.isCohost) self addToggleOption("FunZombieOptions", "Zombies Have Tesla FX", &ZombieTeslaDeathFX, false);
    self addToggleOption("FunZombieOptions", "Zombies Have Frostbite", &toggleFrostBlastZombies, false);
    self addToggleOption("FunZombieOptions", "Frenzied Guard Zombies", &toggleFrenziedGuardZombies, false);
    self addOption("FunZombieOptions", "Perk Drinking Animation", &give_weapon, #"zombie_perk_bottle_revive");
    if (self isHost() || self.isCohost) self addOption("FunZombieOptions", "Kill All Zombies", &KillAllZombies, []);

    self createMenu("ZombieSpawnMenu", "Zombie / Boss Spawn Menu");
    if (ArrayContains(self.allMaps, self.mapName)){
        self addOption("ZombieSpawnMenu", "Spawn Fire Hound", &SpawnBoss, #"spawner_bo5_zombie_dog_molotov");
        self addOption("ZombieSpawnMenu", "Spawn Plague Hound", &SpawnBoss, #"spawner_bo5_zombie_dog_plague");
        self addOption("ZombieSpawnMenu", "Spawn Abomination", &SpawnBoss, #"spawner_bo5_abom");
        self addOption("ZombieSpawnMenu", "Spawn Mecha", &SpawnBoss, #"spawner_bo5_mechz_sr");
        self addOption("ZombieSpawnMenu", "Spawn Mecha Type 2", &SpawnBoss, #"hash_3ff43755c44e6d3d");
        self addOption("ZombieSpawnMenu", "Spawn Mimic", &SpawnBoss, #"spawner_bo5_mimic");
        self addOption("ZombieSpawnMenu", "Spawn Avogadro", &SpawnBoss, #"spawner_bo5_avogadro_sr");
        self addOption("ZombieSpawnMenu", "Spawn Chungus", &SpawnBoss, #"spawner_zm_steiner");
        self addOption("ZombieSpawnMenu", "Spawn Orlov (Steiner)", &SpawnBoss, #"spawner_zm_steiner_f");
        self addOption("ZombieSpawnMenu", "Spawn Disciple", &SpawnBoss, #"spawner_bo5_soa");
        self addOption("ZombieSpawnMenu", "Spawn Tormentor", &SpawnBoss, #"spawner_zm_tormentor");
    }
    if (self.mapName == "zm_tungsten") self addOption("ZombieSpawnMenu", "Spawn Ronnie Raygun", &SpawnBoss, #"spawner_bo5_zombie_sr_ronnie_raygun");

    self createMenu("GiveZombiesWeapons", "Give Zombies Weapons");
    self addOption("GiveZombiesWeapons", "Assault Rifles", &OpenSubMenu, "ZombiesAssaultRifles");
    self addOption("GiveZombiesWeapons", "SMGs", &OpenSubMenu, "ZombiesSMGs");
    self addOption("GiveZombiesWeapons", "Tactical Rifles", &OpenSubMenu, "ZombiesTacticalRifles");
    self addOption("GiveZombiesWeapons", "Snipers", &OpenSubMenu, "ZombiesSnipers");
    self addOption("GiveZombiesWeapons", "Shotguns", &OpenSubMenu, "ZombiesShotguns");
    self addOption("GiveZombiesWeapons", "LMGs", &OpenSubMenu, "ZombiesLMGs");
    self addOption("GiveZombiesWeapons", "Pistols", &OpenSubMenu, "ZombiesPistols");
    self addOption("GiveZombiesWeapons", "Wonder Weapons", &OpenSubMenu, "ZombiesSpecialWonders");

    BuildWeaponMenu("ZombiesSpecialWonders", "Wonder Weapons", level.WonderWeaponNames, level.WonderWeapons, "zombies");
    BuildWeaponMenu("ZombiesAssaultRifles", "Assault Rifles", level.AssaultRifleNames, level.AssaultRifles, "zombies");
    BuildWeaponMenu("ZombiesSMGs", "SMGs", level.SMGNames, level.SMGs, "zombies");
    BuildWeaponMenu("ZombiesTacticalRifles", "Tactical Rifles", level.TacticalRifleNames, level.TacticalRifles, "zombies");
    BuildWeaponMenu("ZombiesSnipers", "Sniper Rifles", level.SniperNames, level.Snipers, "zombies");
    BuildWeaponMenu("ZombiesShotguns", "Shotguns", level.ShotgunNames, level.Shotguns, "zombies");
    BuildWeaponMenu("ZombiesLMGs", "LMGs", level.LMGNames, level.LMGs, "zombies");
    BuildWeaponMenu("ZombiesPistols", "Pistols", level.PistolNames, level.Pistols, "zombies");


    self createMenu("ZombieSpeedMenu", "Zombie Speed Modifier");
    self addOption("ZombieSpeedMenu", "Zombies Walk", &ZombieSpeed, "walk");
    self addOption("ZombieSpeedMenu", "Zombies Run", &ZombieSpeed, "run");
    self addOption("ZombieSpeedMenu", "Zombies Sprint", &ZombieSpeed, "sprint");
    self addOption("ZombieSpeedMenu", "Zombies Super-Sprint", &ZombieSpeed, "super_sprint");

    self createMenu("ZombieEyeColorMenu", "Zombie Eye Color Modifier");
    InitZombieEyeColorSystem();
    self addToggleOption("ZombieEyeColorMenu", "Rainbow Eyes", &ToggleRainbowZombieEyes, false);
    self addOption("ZombieEyeColorMenu", "Cycle Zombie Eye Color", &CycleZombieEyeColor, []);
    self addOption("ZombieEyeColorMenu", "Default Eyes", &SetZombieEyeColorIndex, 1);
    self addOption("ZombieEyeColorMenu", "Blue Eyes", &SetZombieEyeColorIndex, 2);
    self addOption("ZombieEyeColorMenu", "Green Eyes", &SetZombieEyeColorIndex, 3);
    self addOption("ZombieEyeColorMenu", "Orange Eyes", &SetZombieEyeColorIndex, 4);
    self addOption("ZombieEyeColorMenu", "No Eyes", &SetZombieEyeColorIndex, 0);
     
    self createMenu("ZombieModels", "Zombie Model Changer");
    self addOption("ZombieModels", "Snowman Zombie Models", &ZombieAttachModel, #"p9_nt6x_win_snowman");
    self addOption("ZombieModels", "Yellow Stuffed Dragon Zombie Models", &ZombieAttachModel, #"p8_stuffed_dragon_yellow");
    self addOption("ZombieModels", "Mystery Box Bunny Zombie Models", &ZombieAttachModel, #"p9_zm_platinum_magic_box_bunny");
    self addOption("ZombieModels", "Juggernog Machine Zombie Models", &ZombieAttachModel, #"hash_11bef33a8a5054ee");
    self addOption("ZombieModels", "Christmas Tree Zombie Models", &ZombieAttachModel, "p9_zm_silver_foliage_tree_christmas_full");
    self addOption("ZombieModels", "Arcade Machine Zombie Models", &ZombieAttachModel, #"p9_machine_arcade_02");
    self addOption("ZombieModels", "Hellhound Statue Zombie Models", &ZombieAttachModel, #"c_t9_zmb_hellhound");
    self addOption("ZombieModels", "Deathray Sphere Zombie Models", &ZombieAttachModel, #"p7_zm_ctl_deathray_sphere");
    self addOption("ZombieModels", "Rocket Zombie Models", &ZombieAttachModel, #"p9_sur_machine_rocket_01");
    self addOption("ZombieModels", "Pink Car Zombie Models", &ZombieAttachModel, "defaultvehicle");

    self createMenu("RoundMenu", "Change Round");
    self addOption("RoundMenu", "Set Round To 5", &SetRound, 5);
    self addOption("RoundMenu", "Set Round To 10", &SetRound, 10);
    self addOption("RoundMenu", "Set Round To 25", &SetRound, 25);
    self addOption("RoundMenu", "Set Round To 50", &SetRound, 50);
    self addOption("RoundMenu", "Set Round To 75", &SetRound, 75);
    self addOption("RoundMenu", "Set Round To 100", &SetRound, 100);
    self addOption("RoundMenu", "Set Round To 150", &SetRound, 150);
    self addOption("RoundMenu", "Set Round To 200", &SetRound, 200);
    self addOption("RoundMenu", "Set Round To 255 (Max)", &SetRound, 255);

    self createMenu("AmmoModifier", "Apply Ammo Mods");
    self addOption("AmmoModifier", "Brain Rot", &GiveWeaponAAT, #"ammomod_brainrot");
    self addOption("AmmoModifier", "Cryofreeze", &GiveWeaponAAT, #"ammomod_cryofreeze");
    self addOption("AmmoModifier", "Dead Wire", &GiveWeaponAAT, #"ammomod_deadwire");
    self addOption("AmmoModifier", "Napalm Burst", &GiveWeaponAAT, #"ammomod_napalmburst");
    self addOption("AmmoModifier", "Shatter Blast", &GiveWeaponAAT, #"ammomod_shatterblast");

}

OneHitZombies()
{
    self.OneHitZombies = isDefined(self.OneHitZombies) ? undefined : true;

    zombies = GetAiSpeciesArray("axis", "all");

    for (i = 0; i < zombies.size; i++)
    {
        z = zombies[i];
        if (!isDefined(z)) continue;

        if (isDefined(self.OneHitZombies))
        {
            if (!isDefined(z._origMaxHealth))
                z._origMaxHealth = z.maxhealth;

            z.maxhealth = 1;
            z.health = 1;
            z._oneHitApplied = true;
        }
        else
        {
            if (isDefined(z._origMaxHealth))
            {
                z.maxhealth = z._origMaxHealth;
                z.health = z._origMaxHealth;
            }

            z._oneHitApplied = undefined;
        }
    }
}

OneHitZombies_SpawnWatcher()
{
    level endon("game_ended");

    while (true)
    {
        if (isDefined(self.OneHitZombies))
        {
            zombies = GetAiSpeciesArray("axis", "all");

            for (i = 0; i < zombies.size; i++)
            {
                z = zombies[i];
                if (!isDefined(z)) continue;

                if (!isDefined(z._oneHitApplied))
                {
                    if (!isDefined(z._origMaxHealth))
                        z._origMaxHealth = z.maxhealth;

                    z.maxhealth = 1;
                    z.health = 1;
                    z._oneHitApplied = true;
                }
            }
        }

        wait 0.2;
    }
}

GiveZombiesWeapon( weaponName )
{
    weapon = ishash( weaponName ) ? getweapon( weaponName ) : getweapon( weaponName );
    if ( !isDefined( weapon ) )
        return;

    if ( !isDefined( level.weaponnone ) )
        level.weaponnone = getweapon( "none" );

    level.zmb_magic_weapon = weapon;

    zombies = GetAiSpeciesArray( "axis", "all" );
    if ( !isDefined( zombies ) || zombies.size <= 0 )
        return;

    foreach ( z in zombies )
    {
        if ( !isDefined( z ) || !isAlive( z ) )
            continue;

        if ( !isDefined( z.weaponinfo ) )
            z.weaponinfo = [];

        if ( !isDefined( z.a ) )
            z.a = spawnstruct();

        if ( !isDefined( z.a.weaponpos ) )
            z.a.weaponpos = [];

        if ( !isDefined( z.weapon_positions ) )
            z.weapon_positions = array( "left", "right", "chest", "back" );

        for ( i = 0; i < z.weapon_positions.size; i++ )
        {
            pos = z.weapon_positions[i];
            if ( !isDefined( z.a.weaponpos[ pos ] ) )
                z.a.weaponpos[ pos ] = level.weaponnone;
        }

        z init::initweapon( weapon );
        z shared::placeweaponon( weapon, "right" );

        if ( isDefined( z.zmb_magic_thread ) && z.zmb_magic_thread )
            continue;

        z.zmb_magic_thread = true;
        z thread MagicShootLoop();
    }
}

MagicShootLoop()
{
    self endon( "disconnect" );
    self endon( "death" );

    range = 1500;
    fireDelay = 1;
    dmg = 2;

    while ( isAlive( self ) )
    {
        p = GetVisiblePlayer( self, range );

        if ( isDefined( p ) )
        {
            start = self.origin + (0,0,55);
            end   = p.origin + (0,0,55);

            magicbullet( level.zmb_magic_weapon, start, end, self );

            DealFixedDamage( p, self, dmg, level.zmb_magic_weapon );
        }

        wait fireDelay;
    }

    self.zmb_magic_thread = undefined;
}

GetVisiblePlayer( z, maxDist )
{
    ents = GetPlayers();
    if ( !isDefined( ents ) || ents.size <= 0 )
        return undefined;

    best = undefined;
    bestDist = 999999;

    foreach ( p in ents )
    {
        if ( !isDefined( p ) || !isAlive( p ) )
            continue;

        if ( isDefined( p.classname ) && p.classname != "player" )
            continue;

        if ( !isDefined( p.pers ) )
            continue;

        if ( isDefined( p.sessionstate ) && p.sessionstate != "playing" )
            continue;

        pTeam = undefined;
        if ( isDefined( p.team ) ) pTeam = p.team;
        else if ( isDefined( p.pers["team"] ) ) pTeam = p.pers["team"];

        zTeam = undefined;
        if ( isDefined( z.team ) ) zTeam = z.team;
        else if ( isDefined( z.a ) && isDefined( z.a.team ) ) zTeam = z.a.team;

        if ( isDefined( pTeam ) && isDefined( zTeam ) && pTeam == zTeam )
            continue;

        d = distance( z.origin, p.origin );
        if ( d > maxDist )
            continue;

        start = z.origin + (0,0,55);
        end   = p.origin + (0,0,55);

        if ( !sighttracepassed( start, end, 0, z ) )
            continue;

        if ( d < bestDist )
        {
            bestDist = d;
            best = p;
        }
    }

    return best;
}

DealFixedDamage( victim, attacker, amount, weapon )
{
    if ( !isDefined( victim ) || !isAlive( victim ) )
        return;

    point = victim.origin + (0,0,55);
    dir = VecNormalize( point - (attacker.origin + (0,0,55)) );

    victim doDamage( amount, attacker, attacker, dir, point, "MOD_RIFLE_BULLET", weapon, "torso_upper" );
}

ZombieAttachModel(model)
{
    model = ishash(model) ? model : hash(model);

    zombies = GetAiSpeciesArray("axis", "all");
    if (!isDefined(zombies) || zombies.size <= 0)
        return;

    for (i = 0; i < zombies.size; i++)
    {
        z = zombies[i];

        if (!isDefined(z) || !isAlive(z))
            continue;

        if (model == #"c_t9_zmb_posed_quest_zombie")
        {
            z attach(model, "j_head");
            z attach(model, "j_spineupper");
            z attach(model, "j_spinelower");
            z attach(model, "tag_back");
        }
        else
        {
            z DetachAll();
            z setModel(model);
        }
    }
}

FreezeZombies()
{

    self.FreezeZombies = isDefined(self.FreezeZombies) ? undefined : true;

    if (isDefined(self.FreezeZombies))
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z setentitypaused(1);
        }
    }
    else
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z setentitypaused(0);
        }
    }
}

ZombieDogFX()
{

    self.ZombieDogFX = isDefined(self.ZombieDogFX) ? undefined : true;

    if (isDefined(self.ZombieDogFX))
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("dog_fx", 1);
                zombies[a] clientfield::set("sr_dog_fx", 1);
        }
    }
    else
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("dog_fx", 0);
                zombies[a] clientfield::set("sr_dog_fx", 0);
        }
    }
}

ZombieTeslaDeathFX()
{
    self.ZombieTeslaDeathFX = isDefined(self.ZombieTeslaDeathFX) ? undefined : true;

    if (isDefined(self.ZombieTeslaDeathFX))
    {
        self iPrintlnBold("^2Tesla Death FX (sticky) ENABLED");
        self thread ZombieTeslaDeathFX_Loop();
    }
    else
    {
        self iPrintlnBold("^1Tesla Death FX DISABLED");
        self notify("StopTeslaDeathFX");
        ZombieTeslaDeathFX_Apply(0);
    }
}

ZombieTeslaDeathFX_Loop()
{
    self endon("disconnect");
    self endon("StopTeslaDeathFX");

    while (isDefined(self.ZombieTeslaDeathFX))
    {
        ZombieTeslaDeathFX_Apply(1);
        wait 4;
        ZombieTeslaDeathFX_Apply(0);
        wait 0.5;
        ZombieTeslaDeathFX_Apply(1);
    }
}

ZombieTeslaDeathFX_Apply(val)
{
    zombies = GetAITeamArray(level.zombie_team);
    if (!isDefined(zombies) || zombies.size <= 0)
        return;

    for (a = 0; a < zombies.size; a++)
    {
        z = zombies[a];
        if (!isDefined(z) || !isAlive(z))
            continue;

        z clientfield::set("tesla_death_fx", val);
        z clientfield::set("tesla_shock_eyes_fx", val);
    }
}

InvisibleZombies()
{

    self.InvisibleZombies = isDefined(self.InvisibleZombies) ? undefined : true;

    if (isDefined(self.InvisibleZombies))
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z hide();
        }
    }
    else
    {
        zombies = GetAiSpeciesArray("axis", "all");
        for (i = 0; i < zombies.size; i++)
        {
            z = zombies[i];
            z show();
        }
    }
}

InitZombieEyeColorSystem()
{
    if (isDefined(level.zombieEyeColorSystemInit))
        return;

    level.zombieEyeColorSystemInit = true;

    if (!isDefined(level.zombieEyeColorIndex))
        level.zombieEyeColorIndex = 1;

    level thread ZombieEyeColorLoop();
}

ZombieEyeColorLoop()
{
    level endon("end_game");

    while (true)
    {
        if (!isDefined(level.zombieEyeColorIndex))
        {
            wait 1.0;
            continue;
        }

        ai_array = getaiarray();

        foreach (ai in ai_array)
        {
            if (!isDefined(ai))
                continue;
            if (!isactor(ai))
                continue;
            if (!isDefined(ai.zombie_move_speed))
                continue;

            ai clientfield::set("zombie_eye_glow", level.zombieEyeColorIndex);
        }

        wait 1.0;
    }
}

SetZombieEyeColorIndex(index)
{
    if (index < 0)
        index = 0;
    if (index > 4)
        index = 4;

    level.zombieEyeColorIndex = index;

    if (!isDefined(level.zombieEyeColorSystemInit))
        InitZombieEyeColorSystem();

    ai_array = getaiarray();
    foreach (ai in ai_array)
    {
        if (!isDefined(ai) || !isactor(ai) || !isDefined(ai.zombie_move_speed))
            continue;

        ai clientfield::set("zombie_eye_glow", level.zombieEyeColorIndex);
    }

    colorName = GetZombieEyeColorName(level.zombieEyeColorIndex);
}

GetZombieEyeColorName(index)
{
    switch (index)
    {
        case 0: return "Clear";
        case 1: return "Default";
        case 2: return "Blue";
        case 3: return "Green";
        case 4: return "Orange";
    }

    return "Unknown (" + index + ")";
}

CycleZombieEyeColor()
{
    if (!isDefined(level.zombieEyeColorIndex))
        level.zombieEyeColorIndex = 1;

    level.zombieEyeColorIndex = (level.zombieEyeColorIndex + 1) % 5;

    SetZombieEyeColorIndex(level.zombieEyeColorIndex);
}

ToggleRainbowZombieEyes()
{
    self.RainbowZombieEyes = isDefined(self.RainbowZombieEyes) ? undefined : true;

    if (isDefined(self.RainbowZombieEyes))
    {
        self iPrintlnBold("^2Rainbow Zombie Eyes ENABLED");
        self notify("StopRainbowZombieEyes");
        self thread ZombieEyeColorAutoCycleLoop();
    }
    else
    {
        self iPrintlnBold("^1Rainbow Zombie Eyes DISABLED");
        self notify("StopRainbowZombieEyes");
    }
}

ZombieEyeColorAutoCycleLoop()
{
    self endon("disconnect");
    self endon("StopRainbowZombieEyes");

    if (!isDefined(level.zombieEyeColorSystemInit))
        InitZombieEyeColorSystem();

    while (isDefined(self.RainbowZombieEyes))
    {
        CycleZombieEyeColor();
        wait 0.5;
    }
}

ToggleKillAura()
{
    self.killAura = isDefined(self.killAura) ? undefined : true;

    if (isDefined(self.killAura))
    {
        self thread KillAura();
        self iPrintlnBold("Kill Aura ^2Enabled");
    }
    else
    {
        self notify("end_kill_aura");
        self iPrintlnBold("Kill Aura ^1Disabled");
    }
}

KillAura()
{
    self endon("disconnect");
    self endon("end_game");
    self endon("end_kill_aura");

    for (;;)
    {
        radius   = 150;
        hitBone  = "head";
        radiusSq = radius * radius;

        zombies = GetAITeamArray(level.zombie_team);

        foreach (zombie in zombies)
        {
            if (!isDefined(zombie) || !isDefined(zombie.origin) || !isDefined(zombie.health) || zombie.health <= 0)
                continue;

            if (distanceSquared(zombie.origin, self.origin) <= radiusSq)
            {
                damage = zombie.health + 1;

                zombie DoDamage(
                    damage,
                    self.origin,
                    self,
                    undefined,
                    hitBone,
                    "MOD_EXPLOSIVE"
                );

                playfx("zm_weapons/fx9_aat_bul_impact_explosive", zombie.origin + (0, 0, 30));
            }
        }

        wait 0.05;
    }
}

GivePowerup(powerup)
{
    if (powerup == "all")
    {
        if (!isDefined(level.zombie_powerups) || !isDefined(level.PowerupDrops) || !isArray(level.PowerupDrops))
        {
            self iPrintlnBold("^1Powerup list not initialized!");
            return;
        }

        pos = self GetLookPosition();

        for (i = 0; i < level.PowerupDrops.size; i++)
        {
            key = level.PowerupDrops[i];

            if (!isDefined(level.zombie_powerups[key]))
                continue;

            self zm_powerups::specific_powerup_drop(key, pos, undefined, undefined, undefined, 1);
        }

        self iPrintlnBold("^5Spawned ALL Powerups");
        return;
    }
    pos = self GetLookPosition();
    self zm_powerups::specific_powerup_drop(powerup, pos, undefined, undefined, undefined, 1);

    self iPrintlnBold("^5Spawned Powerup");
}

ToggleInfiniteArmor()
{
    self.infArmor = isDefined(self.infArmor) ? undefined : true;

    if (isDefined(self.infArmor))
    {
        self iPrintlnBold("Infinite Tier 3 Armor ^2ENABLED");
        self thread InfiniteArmorLoop();
    }
    else
    {
        self iPrintlnBold("Infinite Tier 3 Armor ^1DISABLED");
        self notify("StopInfArmor");
    }
}

InfiniteArmorLoop()
{
    self endon("disconnect");
    self endon("StopInfArmor");

    while (!isDefined(self.maxarmor) || !isDefined(self.armor))
        wait 0.05;

    tier = 3;
    max = 300;

    self armor::set_armor(max, max, tier, 0.4, 1, 0.5, 0, 1, 1, 1);

    self clientfield::set_player_uimodel("hudItems.armorType", tier);
    self clientfield::set_player_uimodel("hudItems.armorPercent", 1.0);

    self callback::callback("equip_armor", { #tier:tier });

    while (isDefined(self.infArmor))
    {
        if (self.armor < max)
        {
            self armor::set_armor(max, max, tier, 0.4, 1, 0.5, 0, 1, 1, 1);
        }

        if (self.maxarmor != max || self.armortier != tier)
        {
            self armor::set_armor(max, max, tier, 0.4, 1, 0.5, 0, 1, 1, 1);
        }

        self clientfield::set_player_uimodel("hudItems.armorType", tier);
        self clientfield::set_player_uimodel("hudItems.armorPercent", 1.0);

        wait 0.05;
    }
}

ToggleCompanions()
{
    self.CompanionsEnabled = isDefined(self.CompanionsEnabled) ? undefined : true;

    if (isDefined(self.CompanionsEnabled))
    {
        self iPrintLnBold("^2Companions Activated!");
        self thread SpawnCompanions();
    }
    else
    {
        self iPrintLnBold("^1Companions Deactivated!");
        self notify("StopCompanions");
    }
}

SpawnCompanions()
{
    self endon("disconnect");
    self endon("StopCompanions");

    models = array(
        #"p9_zm_platinum_magic_box_bunny",
        #"p9_zm_platinum_magic_box_bunny",
        #"p8_stuffed_dragon_yellow",
        #"p7_zm_teddybear"
    );

    self.companions = [];

    for (i = 0; i < models.size; i++)
    {
        ent = spawn("script_model", self.origin + (0, 0, 40));
        ent setModel(models[i]);
        ent.owner = self;
        ent.orbitOffset = (i * 90);
        ent thread CompanionOrbitLogic();
        self.companions[self.companions.size] = ent;
        wait 0.05;
    }

    self thread CompanionTargetingLoop();
}

CompanionOrbitLogic()
{
    self endon("disconnect");
    self.owner endon("StopCompanions");

    angleOffset = self.orbitOffset;
    dist = 100;
    height = 40;

    while (isDefined(self.owner) && isDefined(self.owner.CompanionsEnabled))
    {
        basePos = self.owner.origin;
        time = gettime() / 1000.0;

        angle = (time * 60 + angleOffset);
        x = cos(angle) * dist;
        y = sin(angle) * dist;

        self.origin = (basePos[0] + x, basePos[1] + y, basePos[2] + height);
        self.angles = (0, angle + 90, 0);

        wait 0.05;
    }

    self delete();
}

CompanionAttack(target)
{
    if (!isDefined(self) || !isDefined(target) || !isAlive(target))
        return;

    weapons = array(
        #"ww_mega_barrel_fullauto_copycat_t9",
        #"ww_ray_rifle_t9",
        #"ww_axe_gun_melee_t9"
    );
    chosenWeapon = weapons[RandomInt(weapons.size)];

    for (i = 0; i < 5; i++)
    {
        if (!isDefined(target) || !isAlive(target))
            break;

        dir = vectornormalize(target.origin - self.origin);
        self.origin += dir * 30;
        wait 0.05;
    }

    if (isDefined(target) && isAlive(target))
    {
        MagicBullet(GetWeapon(chosenWeapon), self.origin, target.origin);
        target DoDamage(250, self.owner);
    }
}

CompanionTargetingLoop()
{
    self endon("disconnect");
    self endon("StopCompanions");

    while (isDefined(self.CompanionsEnabled))
    {
        aiArray = GetAITeamArray(level.zombie_team);

        nearest = undefined;
        nearestDist = 999999;

        foreach (zombie in aiArray)
        {
            if (!isDefined(zombie) || !isAlive(zombie))
                continue;

            dist = distance(self.origin, zombie.origin);

            if (dist > 150)
                continue;

            if (!bullettracepassed(self.origin + (0, 0, 40), zombie.origin + (0, 0, 40), false, undefined))
                continue;

            if (dist < nearestDist)
            {
                nearestDist = dist;
                nearest = zombie;
            }
        }

        if (isDefined(nearest))
        {
            closest = undefined;
            bestDist = 999999;

            foreach (comp in self.companions)
            {
                if (!isDefined(comp))
                    continue;

                cd = distance(comp.origin, nearest.origin);
                if (cd < bestDist)
                {
                    bestDist = cd;
                    closest = comp;
                }
            }

            if (isDefined(closest))
                closest thread CompanionAttack(nearest);
        }

        wait 0.6;
    }

    foreach (c in self.companions)
        if (isDefined(c)) c delete();

    self.companions = [];
}

toggleFrenziedGuardZombies()
{
    level.FrenziedGuardActive = isDefined(level.FrenziedGuardActive) ? undefined : true;

    if (isDefined(level.FrenziedGuardActive))
    {
        iPrintLnBold("^5[Frenzied Guard]^7 FX Enabled");

        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("fx_frenzied_guard_actor_clientfield", 1);
        }

        level thread monitorNewZombiesForFrenziedGuard();
    }
    else
    {
        iPrintLnBold("^5[Frenzied Guard]^7 FX Disabled");

        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("fx_frenzied_guard_actor_clientfield", 0);
        }

        level notify("stop_frenzied_guard_monitor");
    }
}

monitorNewZombiesForFrenziedGuard()
{
    level endon("stop_frenzied_guard_monitor");
    level endon("end_game");

    while (isDefined(level.FrenziedGuardActive) && level.FrenziedGuardActive)
    {
        zombies = GetAITeamArray(level.zombie_team);

        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("fx_frenzied_guard_actor_clientfield", 1);
        }

        wait(1);
    }
}

toggleFrostBlastZombies()
{
    level.FrostBlastActive = isDefined(level.FrostBlastActive) ? undefined : true;

    if (isDefined(level.FrostBlastActive))
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("fx_frost_blast_clientfield", 1);
        }

        level thread monitorNewZombiesForFrost();
    }
    else
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("fx_frost_blast_clientfield", 0);
        }
        level notify("stop_frost_monitor");
    }
}

monitorNewZombiesForFrost()
{
    level endon("stop_frost_monitor");

    while (isDefined(level.FrostBlastActive))
    {
        zombies = GetAITeamArray(level.zombie_team);
        for (a = 0; a < zombies.size; a++)
        {
            if (IsDefined(zombies[a]) && IsAlive(zombies[a]))
                zombies[a] clientfield::set("fx_frost_blast_clientfield", 1);
        }
        wait 2;
    }
}

MaxScrap()
{
    if (!isDefined(self) || !isAlive(self))
        return;

    while (!isDefined(self.var_595a11bc) || !isDefined(self.var_72d64cfd))
        wait 0.05;

    self.var_595a11bc = 9999;
    self.var_72d64cfd = 9999;

    self clientfield::set_player_uimodel("hudItems.scrap", self.var_595a11bc);
    self clientfield::set_player_uimodel("hudItems.rareScrap", self.var_72d64cfd);

    self hud::function_8577b83e();
    self hud::function_32de5fc7();

    self iprintlnbold("^2[Scrap]^7 Maxed out! (Won't show on scoreboard)");
}

GiveWeaponAAT(aat)
{
    self endon("disconnect");
    a = self getcurrentweapon();
    self aat::acquire(a, aat);
}

ZombieSpeed(speed) {
    if (!isdefined(speed)) {
        level.var_43fb4347 = undefined; 
        level.var_102b1301 = undefined;
        a_e_zombies = getaiarray();
        foreach(e_zombie in a_e_zombies) {
            if (isdefined(e_zombie.zombie_move_speed_backupobj)) {
                e_zombie.zombie_move_speed = e_zombie.zombie_move_speed_backupobj;
            } else {
                e_zombie.zombie_move_speed = "walk";
            }
        }
    } else {
        a_e_zombies = getaiarray();
        foreach(e_zombie in a_e_zombies) {
            e_zombie.zombie_move_speed_backupobj = e_zombie.zombie_move_speed;
            e_zombie.zombie_move_speed = speed;
        }
        level.var_43fb4347 = speed; 
        level.var_102b1301 = speed;
    }
}

SetRound(round)
{
    round -= 1;
    if(round >= 255)
        round = 254;
    if(round <= 0)
        round = 1;
    
    level.round_number = round;
    world.roundnumber  = round ^ 115;
    game.roundsplayed = round;
    SetRoundsPlayed(round + 1);
    
    level.zombie_total = 0;
    for(a=0;a<3;a++)
    {
        zombies = GetAISpeciesArray(level.zombie_team, "all");
        for(b=0;b<zombies.size;b++)
        {
            if(isDefined(zombies[b]) && IsAlive(zombies[b]))
                zombies[b] DoDamage(zombies[b].health + 99, zombies[b].origin);
        }
        wait .13;
    }
}

TriggerExfil()
{
    level flag::set(#"hash_3e765c26047c9f54");
}

EditPoints(Points){
    self.score = int(Points);
    self zm_score::add_to_player_score(Points);
}

HeadlessZombies()
{
    zombies = GetAITeamArray(level.zombie_team);
    
    for(a = 0; a < zombies.size; a++)
    {
        if(IsDefined(zombies[a]) && IsAlive(zombies[a]))
            zombies[a] DetachAll();
    }
}

SpawnBoss(boss){
    boss = ishash(boss) ? boss : hash(boss);
    spawnactor(boss, self.origin, self.angles);
}

TeleportToMysteryBox(Type)
{
    Chest = level.chests[level.chest_index];
    origin = Chest.zbarrier.origin;
    FORWARD = AnglesToForward(Chest.zbarrier.angles);
    right = AnglesToRight(Chest.zbarrier.angles);
    var_d9191ee9 = VectorToAngles(right);
    var_f2857d87 = origin - 48 * right;
    switch(randomInt(3))
    {
        case 0:
            var_f2857d87 = var_f2857d87 + 16 * right;
            break;
        case 1:
            var_f2857d87 = var_f2857d87 + 16 * FORWARD;
            break;
        case 2:
            var_f2857d87 = var_f2857d87 - 16 * right;
            break;
        case 3:
            var_f2857d87 = var_f2857d87 - 16 * FORWARD;
            break;
    }
    if(Type == "me"){
        self SetOrigin(var_f2857d87);
        self SetPlayerAngles(var_d9191ee9);
    }
    if(Type == "all"){
        players = getPlayers();
        foreach (p in players)
        {
            if (isDefined(p))
            {
                p SetOrigin(var_f2857d87);
                p SetPlayerAngles(var_d9191ee9);
            }
        }
    }
}

NoTarget()
{
    self.NoTarget = isDefined(self.NoTarget) ? undefined : true;
    if (isDefined(self.NoTarget))
        self.ignoreme = true;
    else
        self.ignoreme = false;
}

NoTargetAll()
{
    self.NoTargetAll = isDefined(self.NoTargetAll) ? undefined : true;
    players = getPlayers();
    if (isDefined(self.NoTargetAll)){
        foreach (p in players)
        {
            if (isDefined(p))
            {
                p.ignoreme = true;
            }
        }
    }
    else{
        foreach (p in players)
        {
            if (isDefined(p))
            {
                p.ignoreme = false;
            }
        }
    }
}

KillAllZombies() {
    if (!isdefined(level.zombie_team)) {
        return;
    }
    foreach(zombie in getaiteamarray(level.zombie_team)) 
    {
        if (isdefined(zombie)) {
            zombie dodamage(zombie.maxhealth + 666, zombie.origin, self);
        }
    }
}

FreeMysteryBox()
{
    self.FreeBox = isDefined(self.FreeBox) ? undefined : true;
 
    if(isDefined(self.FreeBox))
    {
        self endon("disconnect");
 
        foreach(chest in level.chests) chest.zombie_cost = 0;
    }
    else
        foreach(chest in level.chests) chest.zombie_cost = 950;
}

FreezeMysteryBox()
{
    self.FreezeBox = isDefined(self.FreezeBox) ? undefined : true;
 
    if(isDefined(self.FreezeBox))
    {
        self endon("disconnect");
 
        level.chests[level.chest_index].no_fly_away = true;
    }
    else
        level.chests[level.chest_index].no_fly_away = false;
}