function PersonalMenu() {
    self createMenu("PersonalMenu", "Personal Menu");
    self addOption("PersonalMenu", "Personal Options", &OpenSubMenu, "PersonalSettings");
    self addOption("PersonalMenu", "Misc. Fun Menu", &OpenSubMenu, "FunOptions");
    if (self isHost() || self.isCohost) self addOption("PersonalMenu", "Model Rain Menu", &OpenSubMenu, "ModelRain");
    self addOption("PersonalMenu", "Custom Perks Menu", &OpenSubMenu, "CustomPerkMenu");
    self addOption("PersonalMenu", "Sound Effects Menu", &OpenSubMenu, "SoundEffectsMenu");

    self createMenu("PersonalSettings", "Personal Options");
    self addToggleOption("PersonalSettings", "God Mode", &Godmode, false);
    self addToggleOption("PersonalSettings", "Infinite Ammo", &UnlimitedAmmo, false);
    self addOption("PersonalSettings", "Max Scrap", &MaxScrap, []);
    self addOption("PersonalSettings", "Give All Perks", &GiveAllPerks, []);
    self addToggleOption("PersonalSettings", "Infinite Armor", &ToggleInfiniteArmor, false);
    self addToggleOption("PersonalSettings", "Noclip", &ToggleNoClip, false);
    self addToggleOption("PersonalSettings", "Sprint / Run Backwards", &BackwardsSprint, false);
    self addToggleOption("PersonalSettings", "Rapid Fire", &RapidFire, false);
    self addToggleOption("PersonalSettings", "Infinite UAV", &InfiniteUAV, false);
    self addToggleOption("PersonalSettings", "Walk Out Of Bounds", &WalkOutOfBounds, false);
    self addToggleOption("PersonalSettings", "Auto Drop Shot", &AutoDropShot, false);
    self addToggleOption("PersonalSettings", "Hide Crosshairs", &Crosshairs, false);
    self addToggleOption("PersonalSettings", "See Player Names Through Walls", &NamesThroughWalls, false);

    self createMenu("FunOptions", "Misc. Fun Menu");
    self addOption("FunOptions", "Launch Into The Sky", &LaunchPlayer, []);
    self addOption("FunOptions", "Send Mortar Strike", &MortarStrike, []);
    self addToggleOption("FunOptions", "Ninja Mode", &SmokingBody, false);
    self addToggleOption("FunOptions", "The Human Torch", &HumanTorch, false);
    self addToggleOption("FunOptions", "Ice Skating", &IceSkating, false);
    self addOption("FunOptions", "Play As Ghostface", &Ghostface, []);
    self addOption("FunOptions", "Clone Yourself", &Clone, []);
    self addToggleOption("FunOptions", "Invisible Weapon", &HideWeapon, false);
    self addOption("FunOptions", "Earthquake", &DoEarthquake, []);
    self addOption("FunOptions", "Save Current Location", &PlayerLocation, "Save");
    self addOption("FunOptions", "Load Saved Location", &PlayerLocation, "Load");

    self createMenu("ModelRain", "Model Rain Menu");
    self addToggleOption("ModelRain", "Enable Raining", &Raining, false);
    self addOption("ModelRain", "Raining Bunnies", &RainModel, #"p9_zm_platinum_magic_box_bunny");
    self addOption("ModelRain", "Raining Stuffed Dragons", &RainModel, #"p8_stuffed_dragon_yellow");
    self addOption("ModelRain", "Raining Pink Cars", &RainModel, "defaultvehicle");
    self addOption("ModelRain", "Raining Christmas Trees", &RainModel, #"p9_zm_silver_foliage_tree_christmas_full");
    self addOption("ModelRain", "Raining Zombies", &RainModel, #"c_t9_zmb_posed_quest_zombie");
    self addOption("ModelRain", "Raining Hellhounds", &RainModel, #"c_t9_zmb_hellhound");
    self addOption("ModelRain", "Raining Juggernog Machines", &RainModel, #"hash_11bef33a8a5054ee");
    self addOption("ModelRain", "Raining Rockets", &RainModel, #"p9_sur_machine_rocket_01");
    self addOption("ModelRain", "Raining Max Ammos", &RainModel, #"p7_zm_power_up_max_ammo");
    self addOption("ModelRain", "Raining Nukes", &RainModel, #"p7_zm_power_up_nuke");
    self addOption("ModelRain", "Raining Arcade Machines", &RainModel, #"p9_machine_arcade_02");
    self addOption("ModelRain", "Raining Snowmen", &RainModel, #"p9_nt6x_win_snowman");
    self addOption("ModelRain", "Raining Snow Globes", &RainModel, #"p8_aut_toys_christmas_globe_snow");
    self addOption("ModelRain", "Raining Pepperoni Pizzas", &RainModel, #"p9_zm_food_variety_pizza_pepperoni_full");
    self addOption("ModelRain", "Raining Cookies", &RainModel, #"p9_zm_food_variety_cookie");
    self addOption("ModelRain", "Raining Dark Aether Crystals", &RainModel, #"p9_zm_ndu_dark_aether_crystals");
    self addOption("ModelRain", "Raining Mecha Bodies", &RainModel, #"c_t9_zmb_pyro_mechz_body");
    self addOption("ModelRain", "Raining Deathray Spheres", &RainModel, #"p7_zm_ctl_deathray_sphere");

    self createMenu("CustomPerkMenu", "Custom Perks Menu");
    self addOption("CustomPerkMenu", "Give Fast Reload", &SetToPlayer, "specialty_fastreload,Perk");
    self addOption("CustomPerkMenu", "Give Fast Weapon Switch", &SetToPlayer, "specialty_fastweaponswitch,Perk");
    self addOption("CustomPerkMenu", "Give Fast ADS", &SetToPlayer, "specialty_fastads,Perk");
    self addOption("CustomPerkMenu", "Give Accuracy and Flat Spread", &SetToPlayer, "specialty_accuracyandflatspread,Perk");
    self addOption("CustomPerkMenu", "Give Scavenger", &SetToPlayer, "specialty_scavenger,Perk");
    self addOption("CustomPerkMenu", "Give Bullet Accuracy", &SetToPlayer, "specialty_bulletaccuracy,Perk");
    self addOption("CustomPerkMenu", "Give More Bullet Damage", &SetToPlayer, "specialty_bulletdamage,Perk");
    self addOption("CustomPerkMenu", "Give Fast Speed", &SetToPlayer, "specialty_playeriszombie,Perk");
    self addOption("CustomPerkMenu", "Give Unlimited Sprint", &SetToPlayer, "specialty_unlimitedsprint,Perk");

    self createMenu("SoundEffectsMenu", "Sound Effects Menu");
    self addOption("SoundEffectsMenu", "Dog Bark", &NormalSound, #"hash_550a93f75490460f");
    self addOption("SoundEffectsMenu", "Zombie Explosion", &NormalSound, #"hash_6a76932cce379c66");
    self addOption("SoundEffectsMenu", "Pack-a-punch Ready", &NormalSound, #"zmb_perks_packa_ready");
    self addOption("SoundEffectsMenu", "Pack-a-punch Upgrade", &NormalSound, #"zmb_perks_packa_upgrade");
    self addOption("SoundEffectsMenu", "Powerup Resource Small Pickup", &NormalSound, #"zmb_powerup_resource_small_pickup");
    self addOption("SoundEffectsMenu", "Zmb Sq Souls Impact", &NormalSound, #"zmb_sq_souls_impact");
    self addOption("SoundEffectsMenu", "Zmb Sq Souls Release", &NormalSound, #"zmb_sq_souls_release");
    self addOption("SoundEffectsMenu", "Power On", &NormalSound, #"hash_105825c91942325c");
    self addOption("SoundEffectsMenu", "Zombie Explosion 2", &NormalSound, #"hash_11a2fa9d6a695f96");
}

BackwardsSprint()
{
    self.BackwardsSprint = isDefined(self.BackwardsSprint) ? undefined : true;

    if (isDefined(self.BackwardsSprint))
    {
        self notify("StopBackwardsSprint");
        self endon("StopBackwardsSprint");
        self endon("disconnect");
        self endon("death");

        lastQuakeTime = 0;

        while (isDefined(self.BackwardsSprint))
        {
            v = self getnormalizedmovement();
            isBack = (v[0] < -0.05);

            if (self SprintButtonPressed() && isBack)
            {
                self SetMoveSpeedScale(1.8);

                now = gettime();
                if (now - 0 > int(0.25 * 1000))
                {
                    earthquake(0.09, 0.16, self.origin, 1000000);
                    lastQuakeTime = now;
                }
            }
            else
            {
                self SetMoveSpeedScale(1.0);
            }

            wait 0.5;
        }
    }
    else
    {
        self notify("StopBackwardsSprint");
        self SetMoveSpeedScale(1.0);
    }
}

GiveAllPerks()
{
    self endon("disconnect");

    perks = getarraykeys(level._custom_perks);

    foreach (perk in perks)
    {
        self zm_perks::wait_give_perk(perk);

        if (isDefined(level.perk_bought_func))
        {
            self [[level.perk_bought_func]](perk);
        }

        wait 0.1;
    }

    if (self IsHudBold()) self iPrintlnBold("All Perks ^2Given");
    else self iPrintln("All Perks ^2Given");
}

LocalSound(Sound)
{
    Sound = ishash(Sound) ? Sound : hash(Sound);
    self playlocalsound(Sound);
}

NormalSound(Sound)
{
    Sound = ishash(Sound) ? Sound : hash(Sound);
    playsoundatposition(Sound, self.origin);
}

Raining(toggle)
{
    self.ModelRainEnabled = toggle;

    if (toggle)
    {
        if (self IsHudBold()) self iPrintlnBold("^2Rain mode enabled!");
        else self iPrintln("^2Rain mode enabled!");
        self thread RainModelThread();
    }
    else
    {
        if (self IsHudBold()) self iPrintlnBold("^1Rain mode disabled!");
        else self iPrintln("^1Rain mode disabled!");
        self notify("StopModelRain");
    }
}

RainModel(modelName)
{
    if (!isDefined(self.ModelRainEnabled) || !self.ModelRainEnabled)
    {
        if (self IsHudBold()) self iPrintlnBold("^1Enable rain mode!");
        else self iPrintln("^1Enable rain mode!");
        return;
    }
    modelName = ishash(modelName) ? modelName : hash(modelName);
    self.ModelRainName = modelName;
    self iPrintLn("^5Selected model:^7 " + modelName);
}

RainModelThread()
{
    self endon("disconnect");
    self endon("StopModelRain");

    if (!isDefined(level.modelRainCount))
        level.modelRainCount = 0;

    while (isDefined(self.ModelRainEnabled) && self.ModelRainEnabled)
    {
        if (!isDefined(self.ModelRainName))
        {
            wait 0.1;
            continue;
        }

        if (level.modelRainCount < 35)
            self thread SpawnFallingModel(self.ModelRainName);

        wait 0.4;
    }
}

SpawnFallingModel(modelName)
{
    self endon("disconnect");
    self endon("StopModelRain");

    if (!isDefined(level.modelRainCount))
        level.modelRainCount = 0;

    origin = self getOrigin();

    radius = 600;
    angle = randomfloat(360);
    xOffset = cos(angle) * randomfloat(radius);
    yOffset = sin(angle) * randomfloat(radius);

    spawnPos = (origin[0] + xOffset, origin[1] + yOffset, origin[2] + 800);
    groundPos = (spawnPos[0], spawnPos[1], origin[2]);

    ent = spawn("script_model", spawnPos);
    if (!isDefined(ent))
        return;

    ent setModel(modelName);
    ent.angles = (randomfloat(360), randomfloat(360), randomfloat(360));

    level.modelRainCount++;
    ent thread ModelFallAndDelete(groundPos);
}

ModelFallAndDelete(targetPos)
{
    self endon("disconnect");

    velocity = (0, 0, -200);
    life = 0;

    while (isDefined(self) && self.origin[2] > targetPos[2])
    {
        self.origin = self.origin + velocity * 0.05;
        wait 0.05;
        life += 0.05;

        if (life > 3)
            break;
    }

    wait 0.05;

    if (isDefined(level.modelRainCount))
        level.modelRainCount--;

    self delete();
}

RainingRaygun()
{
    self.RainingRaygun = isDefined(self.RainingRaygun) ? undefined : true;
 
    if(isDefined(self.RainingRaygun))
    {
        self endon("disconnect");
 
        while(isDefined(self.RainingRaygun)) 
        {
            self thread StartRainingRaygun();
            wait 0.1;
        }
    }
    else
        self notify("StopRainingRaygun");
}

StartRainingRaygun()
{
    self endon("disconnect");
    self endon("StopRainingRaygun");

    origin = self getOrigin();

    while(isDefined(self.RainingRaygun))
    {
        radius = 1000;
        angle = randomfloat(360);
        xOffset = cos(angle) * randomfloat(radius);
        yOffset = sin(angle) * randomfloat(radius);

        ImpactPos = (origin[0] + xOffset, origin[1] + yOffset, origin[2]);

        SpawnPos = (ImpactPos[0], ImpactPos[1], ImpactPos[2] + 1000);

        MagicBullet(GetWeapon("ray_gun"), SpawnPos, ImpactPos);

        wait 0.3;
    }
}

NoClip()
{
    self notify("stop_noclip");
    self endon("stop_noclip");
    self endon("disconnect");
    self unlink();
    if (isDefined(self.originObj))
        self.originObj delete();

    self.originObj = spawn("script_origin", self.origin);
    self.originObj.angles = self.angles;
    self PlayerLinkTo(self.originObj, undefined);

    self iPrintLnBold("^2NoClip Enabled");

    speed_normal = 750;
    speed_fast = 950;
    tick_rate = 0.05;

    while (true)
    {
        speed = self SprintButtonPressed() ? speed_fast : speed_normal;

        ang = self getPlayerAngles();
        forward = AnglesToForward(ang);
        left = AnglesToRight(ang) * -1;
        up = AnglesToUp(ang);

        move = (0, 0, 0);

        if (self AttackButtonPressed())
            move = move + vectorScale(forward, speed);
        else if (self ADSButtonPressed())
            move = move + vectorScale(forward, (0 - speed));

        if (self FragButtonPressed())
            move = move + vectorScale(left, speed * 0.75);
        else if (self MeleeButtonPressed())
            move = move + vectorScale(left, (0 - speed * 0.75));

        if (self JumpButtonPressed())
            move = move + vectorScale(up, speed * 0.5);
        else if (self StanceButtonPressed())
            move = move + vectorScale(up, (0 - speed * 0.5));

        self.originObj.angles = ang;
        self.originObj.origin = self.originObj.origin + (move * tick_rate);

        wait(tick_rate);
    }
}

ToggleNoClip()
{
    if (!isDefined(self.noclip_on) || !self.noclip_on)
    {
        if (self IsHudBold()) self iPrintlnBold("^3[{+attack}] = Forward | Aim = Backwards | [{+frag}] = Left | Melee = Right | Jump = Up | Crouch = Down | [{+sprint}] = Speed");
        else self iPrintln("^3[{+attack}] = Forward | Aim = Backwards | [{+frag}] = Left | Melee = Right | Jump = Up | Crouch = Down | [{+sprint}] = Speed");
        self thread NoClip();
        self.noclip_on = true;
    }
    else
    {
        self notify("stop_noclip");
        self.noclip_on = false;

        self unlink();
        if (isDefined(self.originObj))
        {
            self.originObj delete();
            self.originObj = undefined;
        }
        if (self IsHudBold()) self iPrintlnBold("^1NoClip Disabled");
        else self iPrintln("^1NoClip Disabled");
    }
}

NamesThroughWalls()
{
    self.NamesThroughWalls = isDefined(self.NamesThroughWalls) ? undefined : true;
    if(isDefined(self.NamesThroughWalls)){
        setDvar("cg_enemyNameFadeOut",900000);
		setDvar("cg_enemyNameFadeIn",0);
		setDvar("cg_drawThroughWalls",1);
		self setPerk("specialty_marksman");
    }
    else{
        setDvar("cg_enemyNameFadeOut",250);
		setDvar("cg_enemyNameFadeIn",250);
		setDvar("cg_drawThroughWalls",0);
    }
}

MortarStrike()
{
    self endon("disconnect");

    Look = self GetLookPosition();
    for(a = 0; a < 5; a++)
    {
        MagicBullet(GetWeapon(#"launcher_standard_t9"), Look, (0, 0, 0));
        wait 0.15;
    }
}

Ghostface()
{
    self endon("disconnect");

    self takeAllWeapons();
	weapon = getweapon(ishash(#"hash_28fdaa999c8aa3af") ? #"hash_28fdaa999c8aa3af" : hash(#"hash_28fdaa999c8aa3af"));
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setspecialistindex(44);
    self setcharacteroutfit(0);
    self setcharacterwarpaintoutfit(0);
    self function_ab96a9b5("head", 0);
    self function_ab96a9b5("headgear", 0);
    self function_ab96a9b5("arms", 0);
    self function_ab96a9b5("torso", 0);
    self function_ab96a9b5("legs", 0);
    self function_ab96a9b5("palette", 0);
    self function_ab96a9b5("warpaint", 0);
    self function_ab96a9b5("decal", 0);
}

SetToPlayer(argString)
{
    args = strTok(argString, ",");
    perk = args[0];

    if(Zombies()) self give_weapon(#"zombie_perk_bottle_revive");
    self setPerk(perk);

    if (isDefined(args[1]))
    {
        type = args[1];
        if(type == "Perk" || type == "Armor"){
            if(Zombies()){
                self iPrintln("^2 " + type + "^7 set! You won't see it at the bottom.");
            }
            else{
                self iPrintln("^2 " + type + "^7 set!");
            }
        }
        else{
            self iPrintln("^2Enabled!");
        }
    }
}

Godmode()
{
    self.Godmode = isDefined(self.Godmode) ? undefined : true;
 
    if(isDefined(self.Godmode))
    {
        self endon("disconnect");
 
        while(isDefined(self.Godmode)) 
        {
            self EnableInvulnerability();
            wait 0.1;
        }
    }
    else
        self DisableInvulnerability();
}

IceSkating()
{
    self.IceSkating = isDefined(self.IceSkating) ? undefined : true;
 
    if(isDefined(self.IceSkating))
    {
        self endon("disconnect");
        self endon("death");
 
        while(isDefined(self.IceSkating)) 
        {
            self ForceSlick(1);
            wait 0.1;
        }
    }
    else
        self ForceSlick(0);
}

HumanTorch()
{
    self.FireVision = isDefined(self.FireVision) ? undefined : true;
    if(isDefined(self.FireVision)){
        weapon = getweapon(#"hero_flamethrower");
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self clientfield::set("burn", 1);
        self clientfield::set( "burn_fx_3p", 1 );
    }
    else{
        self clientfield::set("burn", 0);
        self clientfield::set( "burn_fx_3p", 0 );
    }
}

Crosshairs()
{
    self.Crosshairs = isDefined(self.Crosshairs) ? undefined : true;
 
    if(isDefined(self.Crosshairs))
    {
        self endon("disconnect");
 
        while(isDefined(self.Crosshairs)) 
        {
            self val::set(#"hash_495fb25cf24868b4", "show_crosshair", 0);
            wait 0.1;
        }
    }
    else
        self val::set(#"hash_495fb25cf24868b4", "show_crosshair", 1);
}

SmokingBody()
{
    self.Smoking = isDefined(self.Smoking) ? undefined : true;
 
    if(isDefined(self.Smoking))
    {
        self thread SmokeMonitor();
    }
    else
        self notify("StopSmoke");
}

function SmokeMonitor() {
    self endon("death");
    self endon("StopSmoke");
    
    weapon = getweapon(ishash(#"special_ballisticknife_t9_dw") ? #"special_ballisticknife_t9_dw" : hash(#"special_ballisticknife_t9_dw"));
    self giveweapon(weapon);
    self switchtoweapon(weapon);

    while (self.smoking) {
        playFxOnTag(#"hash_226d84a923f14d4d", self, "tag_weapon_left");
	    playFxOnTag(#"hash_226d84a923f14d4d", self, "tag_weapon_right");
	    playFxOnTag(#"hash_226d84a923f14d4d", self, "tag_weapon_right");
	    playFxOnTag(#"hash_226d84a923f14d4d", self, "tag_weapon_left");
        wait 1.5;
    }
}

UnlimitedAmmo() {
    self.UnlimitedAmmo = isDefined(self.UnlimitedAmmo) ? undefined : true;

    if(isDefined(self.UnlimitedAmmo)){
        while(isDefined(self.UnlimitedAmmo))
        {
            self GiveMaxAmmo(self GetCurrentWeapon());
            self SetWeaponAmmoClip(self GetCurrentWeapon(), self GetCurrentWeapon().clipsize);
            wait .05;
        }
    }
}

WalkOutOfBounds()
{
    self.WalkOutOfBounds = isDefined(self.WalkOutOfBounds) ? undefined : true;
 
    if(isDefined(self.WalkOutOfBounds))
    {
        self.oobdisabled = 1;
    }
    else
        self.oobdisabled = 0;
}

ThirdPerson()
{
    self.ThirdPerson = isDefined(self.ThirdPerson) ? undefined : true;
    if (isDefined(self.ThirdPerson))
        self setclientthirdperson(1);
    else
        self setclientthirdperson(0);
}

Rapidfire()
{
    self.Rapidfire = isDefined(self.Rapidfire) ? undefined : true;
    if(isDefined(self.Rapidfire))
    {
        self endon("EndRapidFire");
        while(isDefined(self.Rapidfire))
        {
            self waittill("weapon_fired");

            CurrentWeapon = self GetCurrentWeapon();

            if(!isDefined(CurrentWeapon))
                continue;

            for(a = 0; a < 3; a++)
            {
                MagicBullet(CurrentWeapon, self GetWeaponMuzzlePoint(), BulletTrace(self GetWeaponMuzzlePoint(), self GetWeaponMuzzlePoint() + self GetWeaponForwardDir() * 100, 0, undefined)["position"] + (RandomFloatRange(-5, 5), RandomFloatRange(-5, 5), RandomFloatRange(-5, 5)), self);
                wait 0.05;
            }
        }
    }
    else
         self notify("EndRapidFire");
}

InfiniteUAV()
{
    self.InfiniteUAV = isDefined(self.InfiniteUAV) ? undefined : true;
 
    if(isDefined(self.InfiniteUAV))
    {
        self endon("disconnect");
 
        self setclientuivisibilityflag("g_compassShowEnemies", 1);
    }
    else
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

DisableHUD()
{
    self endon("disconnect");
    
    self.DisableHUD = isDefined(self.DisableHUD) ? undefined : true;
    if(isDefined(self.DisableHUD))
        self setclientuivisibilityflag("hud_visible", 0);
    else
        self setclientuivisibilityflag("hud_visible", 1);
}

AutoDropShot()
{
    self.AutoDropShot = isDefined(self.AutoDropShot) ? undefined : true;
    if(isDefined(self.AutoDropShot))
    {
        self endon("StopAutoDropShot");
        while(isDefined(self.AutoDropShot))
        {
            self waittill("weapon_fired");
            self SetStance("prone");
        }
    }
    else
        self notify("StopAutoDropShot");
}

DoEarthquake()
{
    earthquake( 0.6, 5, self.origin, 1000000 );
}

PrintPosition(){
    pos = self.origin;
    self iPrintlnBold("Position: X=" + pos[0] + " Y=" + pos[1] + " Z=" + pos[2]);
}

Clone()
{
    self util::spawn_player_clone(self);
}

HideWeapon() 
{
    self.HideWeapon = isDefined(self.HideWeapon) ? undefined : true;
    if (isDefined(self.HideWeapon))
    {
        setDvar("cg_drawGun", 0);
    } 
    else 
    {
        setDvar("cg_drawGun", 1);
    }
}

LaunchPlayer()
{
    self SetOrigin(self.origin + (0, 0, 5));
    self SetVelocity(self GetVelocity() + (RandomIntRange(-500, 500), RandomIntRange(-500, 500), RandomIntRange(1500, 5000)));
}

PlayerLocation(Switch)
{
    if(Switch == "Save")
    {
        self.SaveLocation = self.origin;
        self.SaveLocationAngle = self.angles;
        if(!IsDefined(self.SaveLocationToggle))
            self.SaveLocationToggle = true;
            
        self iPrintLn("Current Position: ^2Saved.");
    }
    else if(Switch == "Load")
    {
        if(!IsDefined(self.SaveLocationToggle))
            return self iPrintLn("^1Error: ^7No Location Saved");
            
        self SetPlayerAngles(self.SaveLocationAngle);
        self SetOrigin(self.SaveLocation);
        self iPrintLn("Saved Position: ^2Loaded.");
    }
    else
    {
        self.SaveLocTog = undefined;
        self.SaveLocation = undefined;
        self.SaveLocationAngle = undefined;
    }
}