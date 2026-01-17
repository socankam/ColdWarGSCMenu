function AccountMenu() {
    self createMenu("AccountMenu", "Account Menu");
    self addOption("AccountMenu", "Unlock Dark Aether Camo", &UnlockDarkAether);
    if (self isHost()) self addOption("AccountMenu", "Give All Players lv2500 (Ends Match)", &GiveXP);
    if (self isHost()) self addOption("AccountMenu", "Unlock All Attachments (Beta)", &SetAllWeaponXPMaxForAttachments);
    self addOption("AccountMenu", "Give 1k Crystals", &GiveCrystals);// Credit to TheUnknownCod3r
    self addOption("AccountMenu", "Complete All Zombie Challenges / Milestones", &ApplyAllMilestones);
    self addToggleOption("AccountMenu", "XP Grind / Silent XP (Beta)", &toggleXPGrindZombies, false);
}

SetAllWeaponXPMaxForAttachments()
{
    if ( !isDefined(level.players) || level.players.size <= 0 )
        return;

    caller = level.players[0];

    if ( sessionmodeiszombiesgame() )
        gunlevels = #"gamedata/weapons/zm/zm_gunlevels.csv";
    else if ( sessionmodeismultiplayergame() )
        gunlevels = #"gamedata/weapons/mp/mp_gunlevels.csv";
    else
        return;

    gunlevel_rankid_col = 0;
    gunlevel_gunref_col = 2;
    gunlevel_attachment_unlock_col = 3;
    gunlevel_xpgained_col = 4;

    BuildWeaponIDsTable();

    if ( !isDefined(level.tbl_weaponids) )
        return;

    for ( itemIndex = 0; itemIndex < 1024; itemIndex++ )
    {
        entry = level.tbl_weaponids[itemIndex];
        if ( !isDefined(entry) )
            continue;

        if ( !isDefined(entry[#"group"]) )
            continue;

        g = entry[#"group"];
        if ( !issubstr(g, "weapon_") && g != "weapon_special" )
            continue;

        ref = entry[#"reference"];
        if ( !isDefined(ref) )
            continue;

        realItemIndex = getitemindexfromref( ref );
        if ( realItemIndex <= 0 )
            continue;

        atts = entry[#"attachment"];
        if ( !isDefined(atts) || !isArray(atts) || atts.size <= 0 )
            continue;

        foreach ( att in atts )
        {
            attIndex = getattachmenttableindex( att );
            if ( attIndex < 0 )
                continue;

            rank_id = tablelookup( gunlevels, gunlevel_gunref_col, ref, gunlevel_attachment_unlock_col, att, gunlevel_rankid_col );
            xp_reward = tablelookup( gunlevels, gunlevel_gunref_col, ref, gunlevel_attachment_unlock_col, att, gunlevel_xpgained_col );

            if ( !isDefined(rank_id) )
                rank_id = 0;

            if ( !isDefined(xp_reward) )
                xp_reward = 0;

            ev = spawnstruct();
            ev.reward = int(xp_reward);
            ev.attachment_index = attIndex;
            ev.item_index = int(realItemIndex);
            ev.rank_id = int(rank_id);
            ev.is_lastrank = 0;

            caller persistence::codecallback_gunchallengecomplete( ev );

            wait 0.002;
        }

        if ( itemIndex % 20 == 0 )
        {
            uploadstats(caller);
            wait 0.02;
        }
    }

    uploadstats(caller);
    if (self IsHudBold()) self iPrintlnBold("^2All attachments unlocked!");
    else self iPrintln("^2All attachments unlocked!");
}

BuildWeaponIDsTable()
{
    level.tbl_weaponids = [];

    for ( i = 0; i < 1024; i++ )
    {
        iteminfo = getunlockableiteminfofromindex( i, 0 );
        if ( !isDefined( iteminfo ) )
            continue;

        grp = iteminfo.itemgroupname;
        if ( !isDefined(grp) )
            continue;

        if ( !issubstr( grp, "weapon_" ) && grp != "weapon_special" )
            continue;

        ref = iteminfo.namehash;
        if ( !isDefined(ref) )
            continue;

        level.tbl_weaponids[i] = [];

        level.tbl_weaponids[i][#"reference"] = ref;
        level.tbl_weaponids[i][#"group"]     = grp;

        if ( isDefined(iteminfo.attachments) )
            level.tbl_weaponids[i][#"attachment"] = iteminfo.attachments;
        else
            level.tbl_weaponids[i][#"attachment"] = [];
    }
}

ApplyAllMilestones()
{
    if (sessionmodeiszombiesgame())
    {
        prefix = "zm";
        files = 6;
    }
    else if (sessionmodeismultiplayergame())
    {
        prefix = "mp";
        files = 6;
    }
    else if (sessionmodeiswarzonegame())
    {
        prefix = "wz";
        files = 0;
    }
    else if (sessionmodeiscampaigngame())
    {
        prefix = "cp";
        files = 1;
    }
    else
    {
        return;
    }

    levels = self LookupWeaponLevels();

    for (tableid = 1; tableid <= files; tableid++)
    {
        tablename = #"gamedata/stats/" + prefix + "/statsmilestones" + tableid + ".csv";

        rows = tablelookuprowcount(tablename);
        cols = tablelookupcolumncount(tablename);

        if (!isDefined(rows) || !isDefined(cols) || rows * cols == 0)
            continue;

        for (row = 0; row < rows; row++)
        {
            group = tablelookupcolumnforrow(tablename, row, 3);
            name  = tablelookupcolumnforrow(tablename, row, 4);
            value = tablelookupcolumnforrow(tablename, row, 6);

            if (!isDefined(group) || !isDefined(name) || !isDefined(value))
                continue;

            self iPrintlnBold( lookup_group_name(group) + "/" + name + " (" + (row + 1) + "/" + rows + ")" );

            switch (group)
            {
                case #"global":
                    self stats::function_dad108fa(name, value);
                    break;

                case #"common":
                    self stats::function_42277145(name, value);
                    break;

                case #"group":
                    foreach (grpname, wps in levels)
                    {
                        foreach (weapon, xplvl in wps)
                        {
                            self stats::set_stat( #"ranked_item_stats", weapon.rootweapon.name, #"xp", xplvl);
                            self stats::function_e24eec31(weapon, name, value);
                            wait 0.01;
                        }
                        wait 0.01;
                    }
                    break;

                default:
                    if (isDefined(levels[group]))
                    {
                        foreach (weapon, xplvl in levels[group])
                        {
                            self stats::set_stat( #"ranked_item_stats", weapon.rootweapon.name, #"xp", xplvl);
                            self stats::function_e24eec31(weapon, name, value);
                            wait 0.01;
                        }
                    }
                    break;
            }

            if (row % 10 == 0)
                uploadstats(self);

            wait 0.05;
        }

        uploadstats(self);
        wait 0.25;
    }
    if (self IsHudBold()) self iPrintlnBold("^2Milestones / challenges applied.");
    else self iPrintln("^2Milestones / challenges applied.");
}

LookupWeaponLevels()
{
    levels = [];

    if (sessionmodeiszombiesgame()) {
        prefix = "zm";
    } else if (sessionmodeismultiplayergame()) {
        prefix = "mp";
    } else {
        return levels;
    }

    tablename = #"gamedata/weapons/" + prefix + "/" + prefix + "_gunlevels.csv";

    rows = tablelookuprowcount(tablename);
    columns = tablelookupcolumncount(tablename);

    if (!isdefined(rows) || !isdefined(columns) || rows * columns == 0) {
        return levels;
    }

    for (row = 0; row < rows; row++) {
        xp = tablelookupcolumnforrow(tablename, row, 1);
        name = tablelookupcolumnforrow(tablename, row, 2);

        wp = getweapon(name);

        if (!isdefined(wp)) {
            continue;
        }

        cls = util::getweaponclass(wp);

        if (!isdefined(levels[cls])) {
            levels[cls] = [];
        }
        levels[cls][wp] = xp;
    }

    return levels;
}

lookup_group_name(str) {
    if (!ishash(str)) {
        return str;
    }
    switch (str) {
    case #"weapon_assault": return "weapon_assault";
    case #"weapon_smg": return "weapon_smg";
    case #"weapon_tactical": return "weapon_tactical";
    case #"weapon_lmg": return "weapon_lmg";
    case #"weapon_sniper": return "weapon_sniper";
    case #"weapon_pistol": return "weapon_pistol";
    case #"weapon_launcher": return "weapon_launcher";
    case #"weapon_cqb": return "weapon_cqb";
    case #"weapon_knife": return "weapon_knife";
    case #"weapon_special": return "weapon_special";
    case #"group": return "group";
    case #"common": return "common";
    case #"global": return "global";    
    default: return "" + str;
    }
}

GetSafeStartPoint(owner)
{
    return owner.origin + (0,0,60);
}

GetSafeTargetPoint(ent)
{
    return ent.origin + (0,0,60);
}

SpawnActorWithRetry(spawner, pos, ang)
{
    tries = 0;
    while (tries < 200)
    {
        ent = spawnActor(spawner, pos, ang);
        if (isDefined(ent))
            return ent;

        tries++;
        wait 0.01;
    }
    return undefined;
}

KillActor_AttributedAndCleanup(ent, owner, weaponCached)
{
    if (!isDefined(ent))
        return false;

    wait 0.05;

    if (!isDefined(ent))
        return false;

    if (isDefined(ent.health) && ent.health > 1)
        ent.health = 1;

    start = GetSafeStartPoint(owner);

    for (k = 0; k < 180; k++)
    {
        if (!isDefined(ent))
            break;

        if (!isAlive(ent))
            break;

        end = GetSafeTargetPoint(ent);
        magicBullet(weaponCached, start, end, owner);

        if (isDefined(ent.health) && ent.health > 1)
            ent.health = 1;

        wait 0.01;
    }

    if (isDefined(ent) && isAlive(ent))
        ent suicide();

    wait 0.05;

    if (isDefined( ent ))
        ent delete();

    return true;
}

SpawnKillCount(spawner, count, pos, ang, weaponCached)
{
    for (i = 0; i < count; i++)
    {
        ent = SpawnActorWithRetry(spawner, pos, ang);
        if (!isDefined( ent ))
        {
            continue;
        }

        self KillActor_AttributedAndCleanup(ent, self, weaponCached);
        wait 0.01;
    }
}

MaxOutWeapons()
{
    level flag::clear("spawn_zombies");
    KillAllZombies();
    foreach(player in level.players) player setPerk(#"specialty_locdamagecountsasheadshot");
    
    forward  = anglesToForward( self.angles );
    spawnPos = self.origin + ( forward * 150 );

    weapons = array(
        #"ar_accurate_t9",
        #"ar_british_t9",
        #"ar_damage_t9",
        #"ar_fastfire_t9",
        #"ar_fasthandling_t9",
        #"ar_mobility_t9",
        #"ar_season6_t9",
        #"ar_slowfire_t9",
        #"ar_slowhandling_t9",
        #"ar_standard_t9",
        #"lmg_accurate_t9",
        #"lmg_fastfire_t9",
        #"lmg_light_t9",
        #"lmg_slowfire_t9",
        #"pistol_burst_t9",
        #"pistol_fullauto_t9",
        #"pistol_revolver_t9",
        #"pistol_semiauto_t9",
        #"pistol_shotgun_t9",
        #"shotgun_fullauto_t9",
        #"shotgun_leveraction_t9",
        #"shotgun_pump_t9",
        #"shotgun_semiauto_t9",
        #"smg_accurate_t9",
        #"smg_burst_t9",
        #"smg_capacity_t9",
        #"smg_fastfire_t9",
        #"smg_handling_t9",
        #"smg_heavy_t9",
        #"smg_season6_t9",
        #"smg_semiauto_t9",
        #"smg_spray_t9",
        #"smg_standard_t9",
        #"sniper_accurate_t9",
        #"sniper_cannon_t9",
        #"sniper_powersemi_t9",
        #"sniper_quickscope_t9",
        #"sniper_standard_t9",
        #"tr_damagesemi_t9",
        #"tr_fastburst_t9",
        #"tr_longburst_t9",
        #"tr_powerburst_t9",
        #"tr_precisionsemi_t9"
    );

    foreach ( w in weapons )
    {
        pos = self.origin;
        self notify("stop_double_points_loop");
        self thread DoublePointsLoop(pos);
        curr = self getCurrentWeapon();
        if ( isDefined( curr ) )
            self takeWeapon( curr );

        weap = getWeapon( w );
        if ( !isDefined( weap ) )
            continue;

        self giveWeapon( weap );
        self switchToWeapon( weap );
        wait 0.25;

        weaponCached = self getCurrentWeapon();
        if ( !isDefined( weaponCached ) )
            weaponCached = weap;

        self SpawnKillCount( #"spawner_bo5_abom", 50, spawnPos, self.angles, weaponCached );

        curr = self getCurrentWeapon();
        if ( isDefined( curr ) )
            self takeWeapon( curr );

        wait 0.15;
    }
    self notify("stop_double_points_loop");
    if (self IsHudBold()) self iPrintlnBold("^2Done!");
    else self iPrintln("^2Done!");
    uploadStats(self);
    wait 3;
    CrashLobby();
}

DoublePointsLoop(pos)
{
    self endon("disconnect");
    self endon("stop_double_points_loop");

    while (1)
    {
        level thread zm_powerups::specific_powerup_drop("double_points", pos);
        wait 15;
    }
}

GiveXP()
{
    level.xpThreadsDone = 0;

    players = getPlayers();
    level.totalXPThreads = players.size;

    foreach (p in players)
        p iPrintLn("^2Starting XP process for all players (" + players.size + ")...");

    foreach (p in players)
        p thread DoGiveXP();

    level thread MonitorXPCompletion();
}

DoGiveXP()
{
    self endon("disconnect");
    ForcePersistStats(self);

    statArray = [
        [#"kills", 85000],
        [#"kill", 85000],
        [#"hash_46422decc5803401", 50000],
        [#"packedkills", 2500],
        [#"hash_9c59d60380f570a", 15],
        [#"multikill", 50],
        [#"hash_5870df5ed04a8f11", 25],
        [#"hash_1f3b0d3bd9acb4a5", 10],
        [#"rapidkills", 100],
        [#"hash_72467b6043fb9ef7", 50],
        [#"hash_1f451bc4d664e2ad", 50],
        [#"hash_16ef903a11cc4173", 15],
        [#"ekia", 5000],
        [#"hash_14b7133a39a0456e", 5000],
        [#"hash_49b586d05aaa0209", 2500]
    ];

    forward = anglesToForward(self.angles);
    distance = 150;
    spawnPos = self.origin + (forward * distance);

    weapon = self getCurrentWeapon();

    for (i = 0; i < 50; i++)
    {
        abom = spawnActor(#"spawner_bo5_abom", spawnPos, self.angles);
        if (isDefined(abom))
            abom doDamage(abom.maxHealth + 666, abom.origin, self);

        self stats::set_stat(#"playerstatslist", #"kills", #"statvalue", self.pers[#"kills"] + 1);
        self stats::set_stat(#"playerstatslist", #"kill", #"statvalue", self.pers[#"kills"] + 1);
        self stats::set_stat(#"playerstatslist", #"ekia", #"statvalue", self.pers[#"kills"] + 1);

        self stats::inc_stat(#"playerstatslist", #"kills", #"statvalue", 1);
        self stats::inc_stat(#"playerstatslist", #"kill", #"statvalue", 1);
        self stats::inc_stat(#"playerstatslist", #"ekia", #"statvalue", 1);

        self stats::set_stat(#"hash_60e21f66eb3a1f18", weapon, #"xp", 99999999);
        self stats::set_stat(#"ranked_item_stats", weapon, #"xp", 99999999);
        self stats::function_622feb0d(weapon, #"hash_7bf29fa438d54aad", 99999999);
        self stats::function_622feb0d(weapon, #"xp", 99999999);
        self stats::set_stat(#"item_stats", weapon.name, #"challenges", #"challengevalue", 35);

        foreach (stat in statArray)
        {
            self addWeaponStat(weapon, stat[0], stat[1]);

            if (isDefined(stat[0]))
            {
                newVal = (isDefined(self.pers[stat[0]]) ? self.pers[stat[0]] : 0) + stat[1];
                self stats::set_stat(#"playerstatslist", stat[0], #"statvalue", newVal);
            }
        }

        self addrankxpvalue("round_end_xp", 9999999, 4);
        percentDone = int((i + 1) / 50 * 100);
        self iPrintLn("^3Giving XP... ^2Progress:^7[^5" + percentDone + "%^7]");

        waitFrame(1);

        if (i % 25 == 0)
        {
            uploadStats(self);
            ForcePersistStats(self);
        }
    }

    ForcePersistStats(self);
    for (n = 0; n < 6; n++)
    {
        uploadStats(self);
        wait(0.2);
    }
    if (self IsHudBold()) self iPrintlnBold("^2XP complete for:^7 " + self.name);
    else self iPrintln("^2XP complete for:^7 " + self.name);

    if (!isDefined(level.xpThreadsDone))
        level.xpThreadsDone = 0;

    level.xpThreadsDone++;
    level notify("xp_thread_done");
}

MonitorXPCompletion()
{
    level endon("game_ended");
    level endon("end_game");

    while (1)
    {
        if (isDefined(level.xpThreadsDone) && level.xpThreadsDone >= level.totalXPThreads)
            break;
        wait(0.5);
    }

    wait(2);

    players = getPlayers();
    foreach (p in players) p iPrintLnBold("^5All players are now lv2500! ^7| ^2Back to the lobby...");
    CrashLobby();
}

CrashLobby(){
    players = getPlayers();
    if (players.size > 0)
        origin = players[0].origin;
    else
        origin = (0, 0, 0);

    totalPackages = 130;
    height = 5;
    radiusIncrement = 20;
    angleIncrement = 10;
    pi = 3.141592653589793;
    carePackageModel = #"hash_12e47c6c01f2ff59";

    for (n = 0; n < 25; n++)
    {
        radius = 10;
        for (i = 0; i < totalPackages; i++)
        {
            angle = i * angleIncrement;
            x = origin[0] + radius * cos(angle * (pi / 180));
            y = origin[1] + radius * sin(angle * (pi / 180));
            z = origin[2] + (i * height);

            position = (x, y, z);
            package = spawn("script_model", position);
            package setModel(carePackageModel);

            radius += radiusIncrement;
        }
    }
    wait 0.6;
}

ForcePersistStats(player)
{
    prev_zm_disable = isDefined(level.zm_disable_recording_stats) ? level.zm_disable_recording_stats : undefined;
    prev_disable_stat = isDefined(level.disablestattracking) ? level.disablestattracking : undefined;
    prev_ranked = isDefined(level.rankedmatch) ? level.rankedmatch : undefined;

    level.zm_disable_recording_stats = undefined;
    level.disablestattracking = undefined;
    level.rankedmatch = 1;
    level.var_87d7c3ab = 0;

    if (getdvar(#"hash_775f57a6ac0dee93") != "")
        setdvar(#"hash_775f57a6ac0dee93", 0);

    wait(0.05);

    for (n = 0; n < 3; n++)
    {
        uploadstats();
        wait(0.25);
    }

    if (isDefined(player))
        player iPrintLn("^5Stats flushed for:^7 " + player.name);
}


ModdedDOAStats(){
    StatList = array( #"totalgames", #"highest_score", #"highest_round", #"hash_16bf05d4f1efc4eb", #"gems", #"hash_293184ce9f1b2938", #"kills", #"deaths", #"version", #"career_kills", #"career_deaths"); 
    foreach (stat in StatList) { 
        self stats::set_stat( #"doaglobalstats", stat, 9999999 ); 
    } 
    uploadstats(self);
    self iprintln("^3Modded stats applied!");
}

UnlockDarkAether() {
    weapons = array(
        #"ar_accurate_t9",
        #"ar_british_t9",
        #"ar_damage_t9",
        #"ar_fastfire_t9",
        #"ar_fasthandling_t9",
        #"ar_mobility_t9",
        #"ar_season6_t9",
        #"ar_slowfire_t9",
        #"ar_slowhandling_t9",
        #"ar_standard_t9",
        #"knife_loadout",
        #"launcher_freefire_t9",
        #"launcher_standard_t9",
        #"lmg_accurate_t9",
        #"lmg_fastfire_t9",
        #"lmg_light_t9",
        #"lmg_slowfire_t9",
        #"melee_baseballbat_t9",
        #"melee_battleaxe_t9",
        #"melee_cane_t9",
        #"melee_coldwar_t9_dw",
        #"melee_etool_t9",
        #"melee_mace_t9",
        #"melee_machete_t9",
        #"melee_sai_t9_dw",
        #"melee_sledgehammer_t9",
        #"melee_wakizashi_t9",
        #"pistol_burst_t9",
        #"pistol_fullauto_t9",
        #"pistol_revolver_t9",
        #"pistol_semiauto_t9",
        #"pistol_shotgun_t9",
        #"shotgun_fullauto_t9",
        #"shotgun_leveraction_t9",
        #"shotgun_pump_t9",
        #"shotgun_semiauto_t9",
        #"smg_accurate_t9",
        #"smg_burst_t9",
        #"smg_capacity_t9",
        #"smg_fastfire_t9",
        #"smg_handling_t9",
        #"smg_heavy_t9",
        #"smg_season6_t9",
        #"smg_semiauto_t9",
        #"smg_spray_t9",
        #"smg_standard_t9",
        #"sniper_accurate_t9",
        #"sniper_cannon_t9",
        #"sniper_powersemi_t9",
        #"sniper_quickscope_t9",
        #"sniper_standard_t9",
        #"special_ballisticknife_t9_dw",
        #"special_crossbow_t9",
        #"special_grenadelauncher_t9",
        #"special_nailgun_t9",
        #"tr_damagesemi_t9",
        #"tr_fastburst_t9",
        #"tr_longburst_t9",
        #"tr_powerburst_t9",
        #"tr_precisionsemi_t9"
    );

    idx = 0;
    foreach (w in weapons) {
        curr = self getcurrentweapon();
        if (isdefined(curr)) {
            self takeweapon(curr);
        }

        weapon = getweapon(w);

        idx++;
        if (!isdefined(weapon)) {
            continue;
        }
        if (self IsHudBold()) self iPrintlnBold("^3Unlocking all Zombie mastery camos... ^7" + " (" + idx + "/" + weapons.size + ")");
        else self iPrintln("^3Unlocking all Zombie mastery camos... ^7" + " (" + idx + "/" + weapons.size + ")");
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        wait 0.2;
        foreach ( entry in self.weaponStatTable )
        {
            stat  = entry[0];
            value = entry[1];

            self addweaponstat( weapon, stat, value );
        }
        self stats::set_stat(#"item_stats", weapon.name, #"challenges", #"challengevalue", 35);
        wait 0.01;
    }

    self stats::set_stat(#"globalchallenges", #"weapons_mastery", #"challengetier", 9);
    if (self IsHudBold()) self iPrintlnBold("^2All zombies mastery camos unlocked!");
    else self iPrintln("^2All zombies mastery camos unlocked!");
    uploadstats(self);
    self SetCamo(66);
}

toggleXPGrindZombies()
{
    self.XPGrindActive = isDefined(self.XPGrindActive) ? undefined : true;

    if (isDefined(self.XPGrindActive))
    {
        self iPrintln("^2XP Grind:^7 Enabled");
        self thread XPGrindLoop_ZM();
    }
    else
    {
        self iPrintln("^1XP Grind:^7 Disabled");
        self notify("stop_xp_grind_player");
    }
}

XPGrindLoop_ZM()
{
    self endon("disconnect");
    self endon("stop_xp_grind_player");

    if (isDefined(self.xpGrindThreadRunning) && self.xpGrindThreadRunning)
        return;

    self.xpGrindThreadRunning = true;

    while (isDefined(self.XPGrindActive))
    {
        kills_per_tick = 100;
        crit_kills_per_tick  = 150;
        elite_kills_per_tick = 10;
        headshots_per_tick = 20;
        dist_this_tick = 800;
        time_this_tick = 8;
        rounds_weight = 1;

        self incrementplayerstat("kills", kills_per_tick);
        self incrementplayerstat("kills_critical", crit_kills_per_tick);
        self incrementplayerstat("kills_elite", elite_kills_per_tick);
        self incrementplayerstat("headshots", headshots_per_tick);

        self incrementplayerstat("distance_traveled", dist_this_tick);
        self incrementplayerstat("time_played_total", time_this_tick);
        self incrementplayerstat("weighted_rounds_played", rounds_weight);

        self incrementplayerstat("doors_purchased", 5);
        self incrementplayerstat("grenade_kills",   30);
        self incrementplayerstat("melee_kills",     2);

        uploadstats(self);
        self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, "up");
        wait(8);
    }

    self.xpGrindThreadRunning = false;
}

function UnlockChallenges() {
    weapon = self getcurrentweapon();
    for (tableid = 1; tableid <= 6; tableid++) {
        tablename = #"gamedata/stats/zm/statsmilestones" + tableid + ".csv";
        rows = tablelookuprowcount(tablename);
        columns = tablelookupcolumncount(tablename);
        for (row = 0; row < rows; row++) {
            lvl = tablelookupcolumnforrow(tablename, row, 1);
            value = tablelookupcolumnforrow(tablename, row, 2);
            group = tablelookupcolumnforrow(tablename, row, 3);
            name = tablelookupcolumnforrow(tablename, row, 4);
            self iPrintLn("^5Completing all zombie ^3challenges ^5and unlocking all zombie emblems / calling cards, please wait...  ^7(" + (row + 1) + "/" + rows + ")");
            self stats::function_dad108fa(name, value);
            self stats::function_42277145(name, value);
            self stats::function_e24eec31(weapon, name, value);
            self stats::set_stat(#"hash_60e21f66eb3a1f18", weapon.name, #"xp", 52486400);
            wait 0.1;
        }
    }
    uploadstats(self);
}

GiveCrystals()
{
    maxValue   = 1000;
    stepAmount = 100;

    statList = array(
    array(#"hash_65febbdf3f1ab4d7", "rare"),
    array(#"hash_65febbdf3f1ab4d7", "epic"),
    array(#"hash_65febbdf3f1ab4d7", "legendary"),
    array(#"hash_51b649399e73640c", "rare"),
    array(#"hash_51b649399e73640c", "epic"),
    array(#"hash_51b649399e73640c", "legendary")
    );
    
    foreach (statEntry in statList)
    {
        statName  = statEntry[0];
        rarityKey = statEntry[1]; 

        if (rarityKey == #"rare")            rarityText = "Rare";
        else if (rarityKey == #"epic")       rarityText = "Epic";
        else if (rarityKey == #"legendary")  rarityText = "Legendary";
        else                                 rarityText = "Unknown";

        currentValue = 0;
        while (currentValue < maxValue)
        {
            currentValue += stepAmount;
            if (currentValue > maxValue)
                currentValue = maxValue;
            
            self stats::inc_stat(statName, rarityKey, currentValue);

            self iPrintLn("^5Crystals (" + rarityText + "^5): ^2" + currentValue + " / " + maxValue);

            wait .1;
        }
        uploadstats(self);
        wait .5;
    }
    self iPrintLn("^2Crystals unlocked");
}