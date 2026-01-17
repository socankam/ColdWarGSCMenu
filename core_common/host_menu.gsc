function HostMenu() {
    self createMenu("HostMenu", "Host Menu");
    CreatePlayerMenu();

    self addOption("HostMenu", "Player Menu", &OpenSubMenu, "PlayerMenu");
    self addOption("HostMenu", "All Players Menu", &OpenSubMenu, "AllPlayersMenu");
    self addOption("HostMenu", "Lobby Settings", &OpenSubMenu, "LobbySettings");
    self addOption("HostMenu", "Server Settings", &OpenSubMenu, "ServerSettings");
    self addOption("HostMenu", "Aimbot Menu", &OpenSubMenu, "AimbotMenu");
    self addOption("HostMenu", "Change Map", &OpenSubMenu, "MapMenu");
    self addOption("HostMenu", "Debug / Dev Menu", &OpenSubMenu, "DevMenu");

    self createMenu("AllPlayersMenu", "All Players Menu");
    self addOption("AllPlayersMenu", "Verify All Players", &VerifyAllPlayers, []);
    self addOption("AllPlayersMenu", "Promote All to Cohosts", &PromoteAllCohosts, []);
    self addOption("AllPlayersMenu", "Unverify All Players", &UnverifyAllPlayers, []);
    self addToggleOption("AllPlayersMenu", "Give Everyone God Mode", &GodmodeAll, false);
    self addOption("AllPlayersMenu", "Give Everyone Weapons", &OpenSubMenu, "GiveEveryoneWeapons");
    self addOption("AllPlayersMenu", "Freeze Everyone's Game", &FreezeEveryonesGame, []);
    self addOption("AllPlayersMenu", "Give Everyone UI Error", &GiveEveryoneUIError, []);
    self addOption("AllPlayersMenu", "Give Everyone Max Points", &EditAllPoints, "999999");
    self addOption("AllPlayersMenu", "Take Everyone's Points", &EditAllPoints, "0");
    self addOption("AllPlayersMenu", "Teleport Everyone To You", &TeleportAllPlayersToHost, []);
    self addOption("AllPlayersMenu", "Mortar Strike All Players", &MortarStrikeAll, []);
    self addOption("AllPlayersMenu", "Shake Everyone's Screens", &ShakeScreens, []);
    self addToggleOption("AllPlayersMenu", "Walk Out Of Bounds (Everyone)", &WalkOutOfBoundsAll, false);
    self addToggleOption("AllPlayersMenu", "Make Everyone Invisible", &MakeEveryoneInvisible, false);
    self addToggleOption("AllPlayersMenu", "Disable Shooting", &DisableShooting, false);
    self addToggleOption("AllPlayersMenu", "Freeze Controls", &FreezeControls, false);
    self addToggleOption("AllPlayersMenu", "Disable Sliding", &DisableSliding, false);
    self addToggleOption("AllPlayersMenu", "Disable Everyone's Crosshairs", &DisableEveryonesCrosshairs, false);
    self addOption("AllPlayersMenu", "Kill All Players", &KillAllPlayers, []);
    self addOption("AllPlayersMenu", "Kick All Players", &KickAllPlayers, []);

    self createMenu("GiveEveryoneWeapons", "Give Everyone Weapons");
    self addOption("GiveEveryoneWeapons", "Give Everyone A Raygun", &GiveEveryoneWeapons, #"ray_gun");
    self addOption("GiveEveryoneWeapons", "Give Everyone A Chrysalax", &GiveEveryoneWeapons, #"hash_18696150427f2efb");
    self addOption("GiveEveryoneWeapons", "Give Everyone A Crbr", &GiveEveryoneWeapons, #"hash_386308ed987052a4");
    self addOption("GiveEveryoneWeapons", "Give Everyone A RAI K-84", &GiveEveryoneWeapons, #"ww_ray_rifle_t9");
    self addOption("GiveEveryoneWeapons", "Give Miniguns", &GiveEveryoneWeapons, #"sig_lmg");
    self addOption("GiveEveryoneWeapons", "Give Flamethrowers", &GiveEveryoneWeapons, #"hero_flamethrower");
    self addOption("GiveEveryoneWeapons", "Give Grenade Launchers", &GiveEveryoneWeapons, #"hero_pineapplegun");
    self addOption("GiveEveryoneWeapons", "Give Annihilators", &GiveEveryoneWeapons, #"hero_annihilator");
    self addOption("GiveEveryoneWeapons", "Give Fire Crossbows", &GiveEveryoneWeapons, #"sig_bow_flame");
    self addOption("GiveEveryoneWeapons", "Give Scream Knives", &GiveEveryoneWeapons, #"hash_28fdaa999c8aa3af");
    self addOption("GiveEveryoneWeapons", "Give Baseball Bats", &GiveEveryoneWeapons, #"melee_baseballbat_t9");

    self createMenu("LobbySettings", "Lobby Settings");
    self addOption("LobbySettings", "Open All Doors", &OpenAllDoors, []);
    self addOption("LobbySettings", "Turn Power On", &TurnPowerOn, []);
    self addOption("LobbySettings", "Complete Main Quest / Easter Egg", &CompleteMainQuest, []);
    if (util::get_map_name() == "zm_tungsten") self addOption("LobbySettings", "Start Boss Fight (Beta)", &ForceForsakenBossFull, []);
    if (util::get_map_name() == "zm_silver") self addToggleOption("LobbySettings", "Dance Party Easter Egg", &DanceParty, false);
    self addToggleOption("LobbySettings", "Super Jump", &SuperJump, false);
    self addToggleOption("LobbySettings", "Super Speed", &SuperSpeed, false);
    self addToggleOption("LobbySettings", "Slow Motion", &Slowmotion, false);
    self addToggleOption("LobbySettings", "Low Gravity", &LowGravity, false);
    if (util::get_map_name() == "zm_silver") self addOption("LobbySettings", "Holliday / Christmas Mode", &HollidayMode, []);
    self addToggleOption("LobbySettings", "Dark Aether", &DarkAetherEffects, false);
    self addOption("LobbySettings", "Trigger Exfil", &TriggerExfil, []);
    if (util::get_map_name() == "zm_silver") self addOption("LobbySettings", "Giant Jellyfishes", &RestartMap, []);
    self addToggleOption("LobbySettings", "Disable Zombie Spawning", &DisableZombieSpawning, false);
    self addOption("LobbySettings", "Reset Round", &ResetRound, []);
    self addToggleOption("LobbySettings", "Floating Dead Bodies", &FloatingBodies, false);

    self createMenu("ServerSettings", "Server Settings");
    self addToggleOption("ServerSettings", "Anti-Quit", &AntiQuit, false);
    self addToggleOption("ServerSettings", "Friendly Fire", &FriendlyFire, false);
    self addToggleOption("ServerSettings", "All Kills Count As Headshots", &KillsAreHeadshots, false);
    self addOption("ServerSettings", "End Match / Kill Server", &EndGame, []);

    self createMenu("AimbotMenu", "Aimbot Menu");
    self addToggleOption("AimbotMenu", "Aimbot (Rage)", &StartRageAimbot, false);
    self addToggleOption("AimbotMenu", "Aimbot (No Aim)", &StartNoAimAimbot, false);
    self addToggleOption("AimbotMenu", "Knifebot", &StartKnifebot, false);
    self addToggleOption("AimbotMenu", "Wallbang Everything", &WallbangEverything, false);

    self createMenu("DevMenu", "Debug / Dev Menu");
    self addOption("DevMenu", "Print Position / Coordinates", &PrintPosition, []);
    self addToggleOption("DevMenu", "Model Hash Print (Caution)", &ADSModelPrint, false);
    self addOption("DevMenu", "Show Host's XUID", &PrintMyXUID, []);

    self createMenu("MapMenu", "Change Map");
    mapType = GetCurrentMapType();

    if (mapType == "zm")
    {
        foreach(entry in self.zombieMapNames)
            self addOption("MapMenu", entry[0], &ChangeMap, entry[1]);
    }
    else if (mapType == "wz")
    {
        foreach(entry in self.outbreakMapNames)
            self addOption("MapMenu", entry[0], &ChangeMap, entry[1]);
    }
}

GodmodeAll()
{
    self.GodmodeAll = isDefined(self.GodmodeAll) ? undefined : true;
 
    if(isDefined(self.GodmodeAll))
    {
        self endon("disconnect");
 
        while(isDefined(self.GodmodeAll)) 
        {
            foreach(player in level.players) player EnableInvulnerability();
            wait 0.1;
        }
    }
    else
        foreach(player in level.players) player DisableInvulnerability();
}

WalkOutOfBoundsAll()
{
    self.WalkOutOfBoundsAll = isDefined(self.WalkOutOfBoundsAll) ? undefined : true;
 
    if(isDefined(self.WalkOutOfBoundsAll))
    {
        self endon("disconnect");
        foreach(player in level.players) player.oobdisabled = 1;
    }
    else{
        foreach(player in level.players) player.oobdisabled = 0;
    }
}

ForceForsakenBossFull()
{
    if (!isDefined(level.ForsakenDoorsOpened))
    {
        level.ForsakenDoorsOpened = true;
        OpenAllDoors();
    }

    level flag::init(#"quest_started");
    level flag::set(#"quest_started");

    level flag::init(#"power_on");
    level flag::set(#"power_on");

    level flag::init(#"boss_vote_complete");
    level flag::set(#"boss_vote_complete");

    level flag::init(#"device_done");
    level flag::set(#"device_done");
    level notify(#"device_done");

    pc = [
        #"function_f11e26f9",
        #"function_34a8b2f1",
        #"function_20f8dd11",
        #"function_692bb75c"
    ];

    foreach(fn in pc)
    {
        if (isDefined(fn))
        {
            level thread [[fn]]();
            break;
        }
    }

    if (!isDefined(level.forsakenFightStarted))
    {
        level.forsakenFightStarted = true;
        level thread StartForsakenFightPhases();
    }
    bossArenaOrigin = (9010.17, 4273.54, -519.875);  
    bossArenaAngles = (0, 180, 0);

    foreach(player in level.players)
    {
        if (!isDefined(player) || !isAlive(player))
            continue;

        ox = randomInt(80) - 40;
        oy = randomInt(80) - 40;

        player SetOrigin((bossArenaOrigin[0] + ox,
                     bossArenaOrigin[1] + oy,
                     bossArenaOrigin[2]));

        player SetPlayerAngles(bossArenaAngles);
    }
    self iPrintlnBold("^5[Forsaken]^7 Boss fight started.");
}

StartForsakenFightPhases()
{
    level endon("end_game");

    wait 0.2;
    level flag::init(#"fight_phase_1_ready");
    level flag::set(#"fight_phase_1_ready");
    level notify(#"fight_phase_1_ready");

    wait 0.5;
    level flag::init(#"fight_phase_2_ready");
    level flag::set(#"fight_phase_2_ready");
    level notify(#"fight_phase_2_ready");

    wait 0.5;
    level flag::init(#"fight_phase_3_ready");
    level flag::set(#"fight_phase_3_ready");
    level notify(#"fight_phase_3_ready");
}

StartNoAimAimbot()
{
    if (!isDefined(self.Aimbot2) || !self.Aimbot2) {
        self.Aimbot2 = true;
        self iPrintLnBold("^3Aimbot ^2activated.");
        self thread StartNoAimAimbotMonitor();
    } else {
        self.Aimbot2 = undefined;
        self notify("StopAimbot2");
        self iPrintLnBold("^3Aimbot ^1deactivated.");
    }
}

StartNoAimAimbotMonitor()
{
    self endon("StopAimbot2");
    self endon("disconnect");

    var_fire_cooldown = 0.12;
    var_shot_timer = 0;

    while (isDefined(self.Aimbot2) && self.Aimbot2) {
        aimAt = undefined;

        if (Zombies()) {
            aiArray = GetAITeamArray(level.zombie_team);
            foreach (zombie in aiArray) {
                if (!isDefined(zombie) || !IsAlive(zombie))
                    continue;
                if (isDefined(aimAt)) {
                    if (closer(self getTagOrigin("j_head"), zombie getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                        aimAt = zombie;
                } else {
                    aimAt = zombie;
                }
            }
        } else {
            foreach (player in level.players) {
                if ((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
                    continue;

                if (isDefined(aimAt)) {
                    if (closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                        aimAt = player;
                } else {
                    aimAt = player;
                }
            }
        }

        if (var_shot_timer > 0)
            var_shot_timer = max(0, var_shot_timer - 0.05);

        if (isDefined(aimAt) && IsAlive(aimAt) && self attackbuttonpressed() && var_shot_timer == 0) {
            targetOrigin = undefined;
            if (isDefined(aimAt getTagOrigin("j_head")))
                targetOrigin = aimAt getTagOrigin("j_head");
            else
                targetOrigin = aimAt.origin;

            if (isDefined(targetOrigin)) {
                self setplayerangles(VectorToAngles(targetOrigin - (self getTagOrigin("j_head"))));

                aimAt thread [[level.callbackplayerdamage]](
                    aimAt,
                    self,
                    999,
                    0,
                    "MOD_HEAD_SHOT",
                    self GetCurrentWeapon(),
                    targetOrigin,
                    (0,0,0),
                    "j_head",
                    (self getTagOrigin("j_head")),
                    0,
                    0,
                    (0,0,0)
                );
                var_shot_timer = var_fire_cooldown;
            }
        }

        wait 0.05;
    }
}

CompleteMainQuest(){
    level flag::set("ww_quest_completed");
    level flag::set("open_wonder_weapon_room");
    level flag::set(#"main_quest_completed");
}

DanceParty()
{
    if (!isDefined(level.DancePartyToggledOn)) level.DancePartyToggledOn = false;
    if (!isDefined(level.DancePartyToggledOff)) level.DancePartyToggledOff = false;

    if (!isDefined(self.DanceParty) && !level.DancePartyToggledOn)
    {
        self.DanceParty = true;
        level.DancePartyToggledOn = true;

        if (!isDefined(level.DoorsOpened) || !level.DoorsOpened)
        {
            OpenAllDoors();
            level.DoorsOpened = true;
        }

        level flag::set(#"hash_76b83a765dea94a5");
        level notify(#"dance_party_light_on");
        level clientfield::set("" + #"hash_195f6fa038980aca", 1);

        level flag::set(#"hash_2aecb7319e5a0d11");
        level notify(#"dance_party_start");

        baseOrigin = (442.138, -853.485, -415.875);
        spreadRadius = 25;

        foreach (p in getPlayers())
        {
            if (!isDefined(p) || !isAlive(p)) continue;

            offsetX = randomInt(spreadRadius * 2) - spreadRadius;
            offsetY = randomInt(spreadRadius * 2) - spreadRadius;
            newOrigin = (baseOrigin[0] + offsetX, baseOrigin[1] + offsetY, baseOrigin[2]);

            p setOrigin(newOrigin);
            p setPlayerAngles((0, randomInt(360), 0));
        }
    }
    else if (isDefined(self.DanceParty) && !level.DancePartyToggledOff)
    {
        self.DanceParty = undefined;
        level.DancePartyToggledOff = true;

        level flag::clear(#"hash_76b83a765dea94a5");
        level notify(#"dance_party_light_off");
        level clientfield::set("" + #"hash_195f6fa038980aca", 0);

        level flag::clear(#"hash_2aecb7319e5a0d11");
        level notify(#"dance_party_end");
    }
    else
    {
        self iPrintlnBold("^1You can only toggle the Dance Party ON and OFF once per game!");
    }
}

ResetRound(){
    level flag::set("round_reset");
}

DisableZombieSpawning(){
    self.DisableZombieSpawning = isDefined(self.DisableZombieSpawning) ? undefined : true;
 
    if(isDefined(self.DisableZombieSpawning))
    {
        level flag::clear("spawn_zombies");
    }
    else
        level flag::set("spawn_zombies");
}

DarkAetherEffects()
{
    self.ForceDarkAether = isDefined(self.ForceDarkAether) ? undefined : true;

    if (isDefined(self.ForceDarkAether))
    {
        if (!level flag::get(#"dark_aether_active"))
        {
            level notify(#"dark_aether_active");
        }

        level notify(#"into_the_dark_side");

        level flag::set(#"dark_aether_active");
        level flag::set(#"in_dark_side");

        if (level clientfield::is_registered("" + #"dark_aether_light_on"))
        {
            level clientfield::set("" + #"dark_aether_light_on", 1);
        }
        if (level clientfield::is_registered("" + #"dark_aether"))
        {
            foreach (player in level.players)
            {
                if (!isDefined(player) || !isPlayer(player))
                    continue;

                player clientfield::set_to_player("" + #"dark_aether", 1);
            }
        }
    }
    else
    {
        level notify(#"dark_side_timeout");

        if (level flag::get(#"dark_aether_active"))
            level flag::clear(#"dark_aether_active");

        if (level flag::get("in_dark_side"))
            level flag::clear("in_dark_side");
        if (level clientfield::is_registered("" + #"dark_aether_light_on"))
        {
            level clientfield::set("" + #"dark_aether_light_on", 0);
        }
        if (level clientfield::is_registered("" + #"dark_aether"))
        {
            foreach (player in level.players)
            {
                if (!isDefined(player) || !isPlayer(player))
                    continue;

                if (player clientfield::get_to_player("" + #"dark_aether"))
                {
                    player clientfield::set_to_player("" + #"dark_aether", 0);
                }
            }
        }
    }
}

TurnPowerOn(){
    setdvar(#"zombie_unlock_all", 1);
	level flag::set("power_on");
	level clientfield::set("zombie_power_on", 1);
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::set("power_on" + trig.script_int);
			level clientfield::set("zombie_power_on", trig.script_int + 1);
		}
	}
}

HollidayMode()
{
    if ( isDefined(level.xmasModeEnabled) && level.xmasModeEnabled )
    {
        return;
    }
    level.xmasModeEnabled = true;

    setdvar(#"hash_34cae673a047c202", 1);

    namespace_679a22ba::function_3ba2f5dd(#"hash_9c00f9e4e4bd95a",  #"silver_ai_zombie_xmas");
    namespace_679a22ba::function_3ba2f5dd(#"hash_539facc2c096b82", #"silver_ai_zombie_heavy_xmas");
    namespace_679a22ba::function_3ba2f5dd(#"hash_208e2483f559ccd2", #"silver_ai_dog_xmas");
    namespace_679a22ba::function_3ba2f5dd(#"hash_47bae14a2b1b4511", #"silver_ai_zombie_mega_xmas");

    level.var_9d098364 = #"hash_43b8d4f24851653e";
    level.var_c42bdd1b = #"hash_2c0da7720a1c2f90";
    level.var_dc38daf  = #"hash_16d309f1ce9e015a";
    level.var_d3d40dcb = #"hash_156c697af81feaf9";
    level.var_68b26ea  = #"hash_2c0da7720a1c2f90";
    level.var_887c5017 = #"hash_16d309f1ce9e015a";

    level.var_9e513533 = #"c_t9_zmb_zombie_heavy_helmet_xmas";
    level.var_eea9f85a = #"c_t9_zmb_zombie_heavy_torso_armor_xmas";

    level.var_1a4cc228[#"hash_796dff2ea842c1ac"] = [
        #"hash_7f5ab1dc6cfb5e8b",
        #"hash_7d3fe2134df8b974",
        #"hash_7808152e8467362f",
        #"hash_50645fbb1e049528",
        #"hash_4cc6bea1049efc55",
        #"hash_9c9737cf22069a5",
        #"hash_55cd178e8d6db2aa"
    ];

    level.var_8f576c00 = [
        #"hash_5214ebcccbd95a36":#"hash_796dff2ea842c1ac",
        #"hash_19ef16d1ba01a5" :#"hash_7725a0435b44b1e5",
        #"hash_12a17ab3df5889eb":#"hash_2792674ef4fce09f",
        #"hash_53f4e0daa341a161":#"hash_156c697af81feaf9",
        #"spawner_zm_steiner"  :#"hash_43b8d4f24851653e",
        #"hash_7f957e36b4f6160f":#"hash_5e24e4aa952bb1bb",
        #"spawner_zm_steiner_split_radiation_blast":#"hash_2c0da7720a1c2f90",
        #"hash_6904f5c7bef64405":#"hash_1d599c94a087ca05",
        #"spawner_zm_steiner_split_radiation_bomb":#"hash_16d309f1ce9e015a"
    ];

    level.var_1a4cc228[#"hash_2792674ef4fce09f"] = [#"hash_7247a6e723dbd7ab"];
    level.var_1a4cc228[#"hash_2c0da7720a1c2f90"] = [#"hash_78bcaad275fa3c26"];
    level.var_1a4cc228[#"hash_16d309f1ce9e015a"] = [#"hash_5392a8401b0e3133"];
    level.var_1a4cc228[#"hash_7725a0435b44b1e5"] = [#"hash_4062a2032d2c9a34"];

    level.var_f546b995 = "winter";

    level.overridezombiespawn = &namespace_3bb7295f::function_767a6a84;

    level thread namespace_3bb7295f::function_3a268da9();

    callback::on_ai_damage(&namespace_3bb7295f::on_ai_damaged);
    callback::on_ai_killed(&namespace_3bb7295f::on_ai_killed);

    if ( !isDefined(level.var_77143112) )
        level.var_77143112 = [];
    if ( !isDefined(level.var_76dd228a) )
        level.var_76dd228a = [];

    namespace_3bb7295f::function_bf79a643();
    namespace_3bb7295f::function_a05df3a7();
    level thread namespace_3bb7295f::function_128f3b6b();

    level.var_162c45e4 = 1;
    level.var_72182681 = 1;

    thread namespace_3bb7295f::function_e71942eb();
    callback::on_spawned(&namespace_3bb7295f::function_8f677e13);

    KillAllZombies();

    self iPrintlnBold("^2Christmas Mode ENABLED.");
}

VerifyAllPlayers()
{
    foreach (p in level.players)
    {
        if (!isDefined(p) || !isPlayer(p)) continue;

        p.isVerified = true;
        p iPrintlnBold("^2You have been Verified!");
    }
    iPrintlnBold("^3All players are now Verified!");
}

UnverifyAllPlayers()
{
    foreach (p in level.players)
    {
        if (!isDefined(p) || !isPlayer(p)) continue;

        if (p == level.host) continue;

        p.isVerified = false;
        p.isCohost = false;
        p iPrintlnBold("^1Your verification has been removed.");
    }
    iPrintlnBold("^3All non-host players have been Unverified.");
}

PromoteAllCohosts()
{
    foreach (p in level.players)
    {
        if (!isDefined(p) || !isPlayer(p)) continue;

        p.isVerified = true;
        p.isCohost = true;
        p iPrintlnBold("^2You have been promoted to Cohost!");
    }
    iPrintlnBold("^3All players are now Cohosts!");
}

toggleHeadshotCycler()
{
    if (!isDefined(level.HeadshotCyclerRunning) || !level.HeadshotCyclerRunning)
    {
        level.HeadshotCyclerRunning = true;

        level.customXPValue = 10;
        level.var_3426461d = &GetXPMultiplier;

        players = getPlayers();
        if (isDefined(players))
        {
            foreach (p in players)
            {
                if (isDefined(p))
                {
                    p iPrintLnBold("^3XP Lobby ^2Enabled!");
                    p EnableInvulnerability();
                }
            }
        }

        level thread HeadshotCyclerMain();
        //level thread HeadshotAbomSpawner();
        level thread HeadshotRoundToggle();
    }
    else
    {
        level.HeadshotCyclerRunning = false;

        players = getPlayers();
        if (isDefined(players))
        {
            foreach (p in players)
            {
                if (isDefined(p))
                {
                    p iPrintLnBold("^3XP Lobby ^1Disabled!");
                    p DisableInvulnerability();
                }
            }
        }

        level.customXPValue = undefined;
        level.var_3426461d = &GetXPMultiplier;
        level notify("stop_headshot_cycler");
        level notify("stop_force_headshots");
        level notify("stop_abom_spawner");
    }
}

HeadshotCyclerMain()
{
    level endon("stop_headshot_cycler");
    level endon("end_game");

    level.headshotIndex = 0;
    level.headshotPlayer = undefined;

    while (level.HeadshotCyclerRunning)
    {
        players = getPlayers();
        if (!isDefined(players) || players.size <= 0)
        {
            wait(1);
            continue;
        }

        if (level.headshotIndex >= players.size)
            level.headshotIndex = 0;

        level.headshotPlayer = players[level.headshotIndex];
        active = level.headshotPlayer;

        if (!isDefined(active))
        {
            level.headshotIndex++;
            wait(1);
            continue;
        }

        level thread ForceHeadshotKills(active);

        //level thread SpawnMobsForPlayer(active);

        active addrankxpvalue("round_end_xp", 1000, 4);
        active addrankxpvalue("kill_xp", 1000, 4);
        active addrankxpvalue("ekia_xp", 1000, 4);
        active rank::updaterank();
        uploadStats(active);

        wait(10);
        level notify("stop_force_headshots");
        level.headshotIndex++;
    }
}

ForceHeadshotKills(player)
{
    level endon("stop_force_headshots");
    level endon("stop_headshot_cycler");
    level endon("end_game");

    while (isDefined(player) && player.sessionstate == "playing")
    {
        zombies = getAIArray();
        foreach (z in zombies)
        {
            if (isAlive(z))
            {
                z.health = 0;
                z.headshot = true;
                z DoDamage(z.health + 99, player.origin, player);
            }
        }
        wait(1);
    }
}

SpawnMobsForPlayer(active)
{
    level endon("stop_abom_spawner");
    level endon("stop_headshot_cycler");
    level endon("end_game");

    if (isDefined(active))
    {
        for (i = 0; i < 5; i++)
        {
            forward = anglesToForward(active.angles);
            distance = 120 + randomIntRange(-50, 50);
            right = anglesToRight(active.angles);
            sideOffset = right * randomIntRange(-100, 100);
            spawnPos = active.origin + (forward * distance) + sideOffset;

            spawnActor(#"spawner_bo5_abom", spawnPos, active.angles);
            wait 0.03;
        }
        for (i = 0; i < 3; i++)
        {
            spawnPos = active.origin + (anglesToForward(active.angles) * (120 + randomIntRange(-50,50))) 
                                     + (anglesToRight(active.angles) * randomIntRange(-100,100));
            spawnActor(#"spawner_bo5_mechz_sr", spawnPos, active.angles);
            wait 0.03;
        }
        for (i = 0; i < 3; i++)
        {
            spawnPos = active.origin + (anglesToForward(active.angles) * (120 + randomIntRange(-50,50))) 
                                     + (anglesToRight(active.angles) * randomIntRange(-100,100));
            spawnActor(#"spawner_bo5_mimic", spawnPos, active.angles);
            wait 0.03;
        }
    }
}

HeadshotAbomSpawner()
{
    level endon("stop_abom_spawner");
    level endon("stop_headshot_cycler");
    level endon("end_game");

    while (level.HeadshotCyclerRunning)
    {
        active = level.headshotPlayer;
        if (isDefined(active))
        {
            level thread SpawnMobsForPlayer(active);
        }
        wait(5);
    }
}

HeadshotRoundToggle()
{
    level endon("stop_headshot_cycler");
    level endon("end_game");

    currentRound = 50;
    SetRound(currentRound);

    while (level.HeadshotCyclerRunning)
    {
        if (currentRound < 100)
        {
            currentRound++;
            SetRound(currentRound);
        }
        else
        {
            level flag::set(#"hash_3e765c26047c9f54");
            players = getPlayers();
            if (isDefined(players))
            {
                foreach (p in players)
                {
                    if (isDefined(p))
                    {
                        p EnableInvulnerability();
                    }
                }
            }
            break;
        }

        wait(20);
    }
}

WallbangEverything()
{
    self.WallbangToggle = !isDefined(self.WallbangToggle) || !self.WallbangToggle;

    if (self.WallbangToggle)
    {
        self thread _WallbangLoop();
    }
    else
    {
        self notify("stop_wallbang");
    }
}

_WallbangLoop()
{
    self endon("disconnect");
    self endon("stop_wallbang");

    while (isDefined(self.WallbangToggle))
    {
        weapon = self waittill("weapon_fired");

        anglesf = anglestoforward(self getplayerangles());
        eye = self geteye();

        savedpos = [];
        for (i = 0; i < 10; i++)
        {
            if (i == 0)
            {
                result = bullettrace(eye, vectorscale(anglesf, 1000000), false, self);
                savedpos[i] = result["position"];
            }
            else
            {
                result = bullettrace(savedpos[i - 1], vectorscale(anglesf, 1000000), true, self);
                savedpos[i] = result["position"];

                while (distance(savedpos[i - 1], savedpos[i]) < 1)
                    savedpos[i] += vectorscale(anglesf, 0.25);
            }

            if (i > 0 && savedpos[i] != savedpos[i - 1])
                magicbullet(self getcurrentweapon(), savedpos[i], vectorscale(anglesf, 1000000), self);
        }

        waitframe(1);
    }
}

DisableEveryonesCrosshairs()
{
    self.DisableEveryonesCrosshairs = isDefined(self.DisableEveryonesCrosshairs) ? undefined : true;
 
    if(isDefined(self.DisableEveryonesCrosshairs))
    {
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player val::set(#"hash_495fb25cf24868b4", "show_crosshair", 0);
            }
        }
    }
    else{
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player val::set(#"hash_495fb25cf24868b4", "show_crosshair", 1);
            }
        }
    }
}

ADSModelPrint(){
    self.ADSModelPrint = isDefined(self.ADSModelPrint) ? undefined : true;
 
    if(isDefined(self.ADSModelPrint))
    {
        self endon("disconnect");
        self iPrintln("^2ADS at an object to print its hash value.");
        while(isDefined(self.ADSModelPrint)) 
        {
            self thread StartModelPrint();
            wait 0.1;
        }
    }
    else
        self notify("StopModelPrint");
}

StartModelPrint()
{
    self endon("disconnect");
    self endon("StopModelPrint");

    lastModel = "";

    while (isDefined(self.ADSModelPrint))
    {
        while (self adsbuttonpressed()) 
        {
            trace = bulletTrace(self GetTagOrigin("j_head"), self GetTagOrigin("j_head") + anglesToForward(self GetPlayerAngles()) * 1000000, true, self);
            
            if (isDefined(trace["entity"]) && isDefined(trace["entity"].model)) 
            {
                if (trace["entity"].model != lastModel)
                {
                    self iprintln("Model: hash_" + trace["entity"].model);
                    lastModel = trace["entity"].model;
                    wait 0.5;
                }
            } 
            else if (lastModel != "No entity hit") 
            {
                self iprintlnbold("No entity hit");
                lastModel = "No entity hit";
            }

            wait 0.1;
        }
        wait 0.05;
    }
}

StartTrickshotAimbot()
{
    if (!isDefined(self.TrickshotAimbot) || !self.TrickshotAimbot) {
        self.TrickshotAimbot = true;
        self iPrintLnBold("^3Trickshot Aimbot ^2activated.");
        self thread TrickshotAimbotMonitor();
    } else {
        self.TrickshotAimbot = undefined;
        self notify("EndTrickshotAimbot");
        self notify("EndAutoAim1");
        self iPrintLnBold("^3Trickshot Aimbot ^1deactivated.");
    }
}

TrickshotAimbotMonitor()
{
    self endon("EndTrickshotAimbot");
    self endon("EndAutoAim1");
    self endon("disconnect");

    while (isDefined(self.TrickshotAimbot) && self.TrickshotAimbot)
    {
        aimAt = undefined;

        foreach (player in level.players)
        {
            if ((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]) || (player isHost()))
                continue;

            if (isDefined(aimAt))
            {
                if (closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                    aimAt = player;
            }
            else
                aimAt = player;
        }

        if (isDefined(aimAt))
        {
            if (self attackbuttonpressed())
            {
                currentClosest = undefined;
                foreach (p2 in level.players)
                {
                    if ((p2 == self) || (!isAlive(p2)) || (level.teamBased && self.pers["team"] == p2.pers["team"]) || (p2 isHost()))
                        continue;

                    if (isDefined(currentClosest))
                    {
                        if (closer(self getTagOrigin("j_head"), p2 getTagOrigin("j_head"), currentClosest getTagOrigin("j_head")))
                            currentClosest = p2;
                    }
                    else currentClosest = p2;
                }

                if (!isDefined(currentClosest))
                {
                    wait 0.01;
                    continue;
                }

                self setplayerangles(VectorToAngles((currentClosest getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));

                wait 0.01;

                attempts = 0;
                maxAttempts = 4;
                while (attempts < maxAttempts && isDefined(currentClosest) && isAlive(currentClosest))
                {
                    currentClosest thread [[level.callbackPlayerDamage]](
                        self,
                        self,
                        100,
                        0,
                        "MOD_HEAD_SHOT",
                        self getCurrentWeapon(),
                        (0,0,0),
                        (0,0,0),
                        "head",
                        0,
                        0
                    );

                    attempts = attempts + 1;

                    wait 0.08;

                    if (!isDefined(currentClosest) || !isAlive(currentClosest))
                        break;
                }
                wait 0.6;
            }
        }

        wait 0.01;
    }
}

MakeEveryoneInvisible()
{
    self.MakeEveryoneInvisible = isDefined(self.MakeEveryoneInvisible) ? undefined : true;
 
    if(isDefined(self.MakeEveryoneInvisible))
    {
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player hide();
            }
        }
    }
    else{
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player show(); 
            }
        }
    }
}

PrintMyXUID()
{
    self iPrintLn("^2XUID: ^7" + self GetXUID());
}

GiveEveryoneWeapons(weapon_name)
{
    weapon = getweapon(isdefined(weapon_name) && ishash(weapon_name) ? weapon_name : hash(weapon_name));
    foreach (player in level.players) {
        player giveweapon(weapon);
        player switchtoweapon(weapon);
    }
}

EditAllPoints(Points)
{
    foreach (player in level.players) {
        player.score = int(Points);
    }
}

LaunchAllPlayers()
{
    foreach (player in level.players) {
        if (player getEntityNumber() != 0) {
            player SetOrigin(player.origin + (0, 0, 5));
            player SetVelocity(player GetVelocity() + (RandomIntRange(-500, 500), RandomIntRange(-500, 500), RandomIntRange(1500, 5000)));
        }
    }
}

ShakeScreens()
{
    foreach (player in level.players) {
        earthquake( 0.6, 5, player.origin, 1000000 );
    }
}

TeleportAllPlayersToHost()
{
    hostPos = self.origin;

    foreach (player in level.players)
    {
        if (!isDefined(player)) continue;
        if (player == self) continue;

        player freezeControls(true);
        player SetOrigin(hostPos);
        wait 0.05;
        player freezeControls(false);
    }

}

KickAllPlayers()
{
    foreach(player in level.players){
        if(!player IsHost()){
            Kick(player GetEntityNumber());
        }
    }
}

KillAllPlayers()
{
    foreach(player in level.players){
        if(!player IsHost()){
            player suicide();
        }
    }
}

FreezeEveryonesGame()
{
    foreach(player in level.players){
        if(!player IsHost()){
            player luinotifyevent(#"hash_6b67aa04e378d681", 1, "lol");
        }
    }
}

GiveEveryoneUIError()
{
    foreach(player in level.players){
        if(!player IsHost()){
            if(Zombies()) player luinotifyevent(#"hash_1fc4832b89307895", 1, "lol");
            if(Multiplayer()) player luinotifyevent(#"hash_76e8cddd9789122c", 1, "lol");
        }
    }
}

DisableShooting()
{
    self.DisableShooting = isDefined(self.DisableShooting) ? undefined : true;
 
    if(isDefined(self.DisableShooting))
    {
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player disableWeapons();
            }
        }
    }
    else{
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player enableWeapons(); 
            }
        }
    }
}

DisableSliding()
{
    self.DisableSliding = isDefined(self.DisableSliding) ? undefined : true;
 
    if(isDefined(self.DisableSliding))
    {
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player allowslide(0);
            }
        }
    }
    else{
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player allowslide(1); 
            }
        }
    }
}

FreezeControls()
{
    self.FreezeControls = isDefined(self.FreezeControls) ? undefined : true;
 
    if(isDefined(self.FreezeControls))
    {
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player freezeControls(true);
            }
        }
    }
    else{
        foreach (player in level.players) {
            if (player getEntityNumber() != 0) {
                player freezeControls(false); 
            }
        }
    }
}

MortarStrikeAll()
{
    self endon("disconnect");
    foreach(player in level.players){
        if (player getEntityNumber() != 0) {
            for(a = 0; a < 5; a++)
            {
                MagicBullet(GetWeapon(#"launcher_standard_t9"), player.origin + (0, 0, 2500), player.origin);
                wait 0.15;
            }
        }
    }
}

OpenAllDoors() 
{
    setdvar(#"zombie_unlock_all", 1);
    players = getplayers();
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!is_true(zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:players[0]});
        }
        if (is_true(zombie_doors[i].power_door_ignore_flag_wait)) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
        waitframe(1);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (isdefined(zombie_debris[i])) {
            zombie_debris[i] notify(#"trigger", {#activator:players[0]});
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    wait(1);
    setdvar(#"zombie_unlock_all", 0);
}

ChangeMap(map) {
    setDvar("ls_mapname", map);
    setDvar("mapname", map);
    setDvar("party_mapname", map);
    setDvar("ui_mapname", map);
    setDvar("ui_currentmap", map);
    setDvar("ui_previewmap", map);
    setDvar("ui_showmap", map);
    map(map);
    wait(1);
    switchmap_switch();
}

KillsAreHeadshots(){
    self.KillsAreHeadshots = isDefined(self.KillsAreHeadshots) ? undefined : true;
    if(isDefined(self.KillsAreHeadshots))
        foreach(player in level.players) player setPerk(#"specialty_locdamagecountsasheadshot");
    else 
        foreach(player in level.players) player unsetPerk(#"specialty_locdamagecountsasheadshot");
}

XPLobby()
{
    self.XPLobby = isDefined(self.XPLobby) ? undefined : true;

    if(isDefined(self.XPLobby))
    {
        self endon("disconnect");
        self iprintlnbold("^5XP Lobby ^2Enabled.");
        level.customXPValue = 100;
        level.var_3426461d = &GetXPMultiplier;
    }
    else
    {
        level.customXPValue = undefined;
        self iprintlnbold("^5XP Lobby ^1Disabled.");
        level.var_3426461d = &GetXPMultiplier;
    }
}

GetXPMultiplier() 
{
    self endon(#"disconnect", #"end_game");
    if(isDefined(level.customXPValue) && level.customXPValue >= 1){ return level.customXPValue;}
    else return 2;
}

StartKnifebot()
{
    if (!isDefined(self.knifebot) || !self.knifebot) {
        self.knifebot = true;
        self iPrintLnBold("^3Knifebot ^2activated.");
        self thread KnifebotMonitorUnified();
    } else {
        self.knifebot = undefined;
        self notify("StopKnifebot");
        self iPrintLnBold("^3Knifebot ^1deactivated.");
    }
}

KnifebotMonitorUnified()
{
    self endon("StopKnifebot");
    self endon("disconnect");

    knifewep = getweapon(ishash(#"hash_28fdaa999c8aa3af") ? #"hash_28fdaa999c8aa3af" : hash(#"hash_28fdaa999c8aa3af"));
    self giveweapon(knifewep);
    self switchtoweapon(knifewep);

    while (isDefined(self.knifebot) && self.knifebot) {
        if (self meleebuttonpressed()) {
            while (self meleebuttonpressed()) wait 0.03;

            nearest = undefined;
            if (Zombies()) {
                targets = GetAITeamArray(level.zombie_team);
            } else {
                targets = level.players;
            }

            foreach (t in targets) {
                if (!isDefined(t) || !isAlive(t)) continue;

                if (!Zombies()) {
                    if (t == self) continue;
                    if (level.teamBased && isDefined(self.pers["team"]) && self.pers["team"] == t.pers["team"]) continue;
                }

                if (isDefined(nearest)) {
                    nOrigin = nearest getTagOrigin("j_head");
                    tOrigin = t getTagOrigin("j_head");
                    if (isDefined(nOrigin) && isDefined(tOrigin)) {
                        if (closer(self getTagOrigin("j_head"), tOrigin, nOrigin))
                            nearest = t;
                    }
                } else nearest = t;
            }

            if (isDefined(nearest)) {
                targetHead = nearest getTagOrigin("j_head");
                targetOrigin = nearest.origin;

                if (isDefined(targetHead)) {
                    teleportPos = targetHead;
                } else {
                    teleportPos = targetOrigin;
                }

                teleportPos = teleportPos + (0,0,5);

                self setOrigin(teleportPos);
                if (isDefined(targetHead)) {
                    self setplayerangles(VectorToAngles(targetHead - (self getTagOrigin("j_head"))));
                } else {
                    self setplayerangles(VectorToAngles(teleportPos - (self getTagOrigin("j_head"))));
                }

                nearest thread [[level.callbackPlayerDamage]](
                    self,
                    self,
                    2147483600,
                    8,
                    "MOD_MELEE",
                    knifewep,
                    (0,0,0),
                    (0,0,0),
                    "none",
                    0,
                    0
                );
            }
        }

        wait 0.05;
    }
}

StartRageAimbot()
{
    if (!isDefined(self.Aimbot) || !self.Aimbot) {
        self.Aimbot = true;
        self iPrintLnBold("^3Aimbot ^2activated.");
        self thread AimbotMonitorUnified();
    } else {
        self.Aimbot = undefined;
        self notify("StopAimbot");
        self iPrintLnBold("^3Aimbot ^1deactivated.");
    }
}

AimbotMonitorUnified()
{
    self endon("StopAimbot");
    self endon("disconnect");

    while (isDefined(self.Aimbot) && self.Aimbot) {
        aimAt = undefined;

        if (Zombies()) {
            aiArray = GetAITeamArray(level.zombie_team);
            foreach (zombie in aiArray) {
                if (!isDefined(zombie) || !isAlive(zombie))
                    continue;

                if (isDefined(aimAt)) {
                    if (closer(self getTagOrigin("j_head"), zombie getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                        aimAt = zombie;
                } else {
                    aimAt = zombie;
                }
            }
        } else {
            foreach (player in level.players) {
                if ((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
                    continue;

                if (isDefined(aimAt)) {
                    if (closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                        aimAt = player;
                } else {
                    aimAt = player;
                }
            }
        }

        if (isDefined(aimAt) && self adsbuttonpressed()) {
            self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));

            if (self attackbuttonpressed()) {
                aimAt thread [[level.callbackPlayerDamage]](
                    self,
                    self,
                    100,
                    0,
                    "MOD_HEAD_SHOT",
                    self getCurrentWeapon(),
                    (0,0,0),
                    (0,0,0),
                    "head",
                    0,
                    0
                );
            }
        }

        wait 0.05;
    }
}

SuperJump()
{
    level.SuperJump = isDefined(level.SuperJump) ? undefined : true;

    if(isDefined(level.SuperJump))
    {
        foreach(player in level.players)
        {
            if (!isDefined(player.superjump_thread))
                player.superjump_thread = player thread AllSuperJump();
        }
    }
    else
    {
        foreach(player in level.players)
        {
            if (isDefined(player.superjump_thread))
            {
                player notify("stop_superjump");
                player.superjump_thread = undefined;
            }
        }
    }
}

AllSuperJump()
{
    self endon("disconnect");
    self endon("stop_superjump");

    while(isDefined(level.SuperJump))
    {
        if(self JumpButtonPressed())
        {
            for(i = 0; i < 5; i++)
                self SetVelocity(self GetVelocity() + (0, 0, 140));

            while(!self IsOnGround())
                wait .05;
        }
        wait .05;
    }
}

SuperSpeed()
{
    self.SuperSpeed = isDefined(self.SuperSpeed) ? undefined : true;
 
    if(isDefined(self.SuperSpeed))
    {
        self endon("disconnect");
 
        while(isDefined(self.SuperSpeed)) 
        {
            setDvar("g_speed", 500);
            wait 0.1;
        }
    }
    else
        setDvar("g_speed", 200);
}

Slowmotion()
{
    self.Slowmotion = isDefined(self.Slowmotion) ? undefined : true;
 
    if(isDefined(self.Slowmotion))
    {
        self endon("disconnect");
 
        while(isDefined(self.Slowmotion)) 
        {
            setslowmotion(1, 0.2, 0.25, 1, 1);
            wait 0.1;
        }
    }
    else
        setslowmotion(0.1, 1, 0.5, 1, 1);
}

LowGravity()
{
    self.LowGravity = isDefined(self.LowGravity) ? undefined : true;
    if(isDefined(self.LowGravity))
        SetDvar("bg_gravity", 100);
    else 
        SetDvar("bg_gravity", 350);
}

FloatingBodies()
{
    if(!isDefined(self.FloatingBodies))
    {
        self.FloatingBodies = true;
        setDvar("phys_gravity", 100);
    }
    else 
    {
        self.FloatingBodies = undefined;
        setDvar("phys_gravity", 800);
    }
}

FriendlyFire() 
{

    self.FriendlyFire = isDefined(self.FriendlyFire) ? undefined : true;
    if(isDefined(self.FriendlyFire))
    {
        setdvar(#"ui_friendlyfire", 1);
        foreach(player in level.players) 
        {
            player iprintln("Friendly fire ^2enabled!");
        }
    } 
    else 
    {
        setdvar(#"ui_friendlyfire", 0);
        foreach(player in level.players) 
        {
            player iprintln("Friendly fire ^1disabled!");
        }
    }
}

AntiQuit() 
{

    self.AntiQuit = isDefined(self.AntiQuit) ? undefined : true;
    if(isDefined(self.AntiQuit))
    {
        SetMatchFlag("disableIngameMenu", 1);
        foreach(player in level.players) 
        {
            player CloseInGameMenu();
        }
    } 
    else 
    {
        SetMatchFlag("disableIngameMenu", 0);
    }
}