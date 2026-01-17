function ForgeMenu() {
    self createMenu("ForgeMenu", "Forge Menu");
    self addToggleOption("ForgeMenu", "Forge Mode", &StartForgeMode, false);
    self addOption("ForgeMenu", "Spawn Structures", &OpenSubMenu, "SpawnStructures");
    self addOption("ForgeMenu", "Spawn Perk Machine Models", &OpenSubMenu, "SpawnPerkMachineModels");
    self addOption("ForgeMenu", "Spawn Misc. Zombies Mode Models", &OpenSubMenu, "MiscZombiesModels");

    self createMenu("SpawnStructures", "Spawn Structures");
    if (self isHost() || self.isCohost) self addOption("SpawnStructures", "Ride A Roller Coaster", &SpawnRollerCoaster, []);
    self addOption("SpawnStructures", "Spawn Drop Tower", &SpawnDropTower, []);
    self addOption("SpawnStructures", "Spawn Merry-Go-Round", &SpawnMerryGoRound, []);
    self addOption("SpawnStructures", "Spawn Wall", &SpawnWall, []);
    self addOption("SpawnStructures", "Spawn Staircase", &SpawnStaircase, []);
    self addToggleOption("SpawnStructures", "Spawn Trampoline", &SpawnTrampoline, false);

    self createMenu("SpawnPerkMachineModels", "Spawn Perk Machine Models");
    self addOption("SpawnPerkMachineModels", "Spawn Juggernog Machine", &SpawnModel, #"hash_11bef33a8a5054ee");
    self addOption("SpawnPerkMachineModels", "Spawn Quick Revive Machine", &SpawnModel, #"hash_2669ca65b6e4ca23");
    self addOption("SpawnPerkMachineModels", "Spawn Deadshot Daiquiri Machine", &SpawnModel, #"hash_28d8a85986bbda22");
    self addOption("SpawnPerkMachineModels", "Spawn Speed Cola Machine", &SpawnModel, #"hash_2f293ab613dccf35");
    self addOption("SpawnPerkMachineModels", "Spawn Stamin-Up Machine", &SpawnModel, #"hash_16ef834db3900f05");
    self addOption("SpawnPerkMachineModels", "Spawn Elemental Pop Machine", &SpawnModel, #"hash_18d70e9caff351e1");

    self createMenu("MiscZombiesModels", "Spawn Misc. Zombies Mode Models");
    if (util::get_map_name() == "zm_silver") self addOption("MiscZombiesModels", "Spawn Die Maschine Tank", &SpawnModel, #"hash_329a3eeb989e26e6");
    self addOption("MiscZombiesModels", "Spawn Hellhound Statue", &SpawnModel, #"c_t9_zmb_hellhound");
    self addOption("MiscZombiesModels", "Spawn Zombie Statue", &SpawnModel, #"c_t9_zmb_posed_quest_zombie");
    self addOption("MiscZombiesModels", "Spawn Ammo Refill Crate", &SpawnModel, #"hash_94b3a8b935248d0");
    self addOption("MiscZombiesModels", "Spawn Crafting Table", &SpawnModel, #"hash_847710b9f01fee3");
    self addOption("MiscZombiesModels", "Spawn Snowman", &SpawnModel, #"p9_nt6x_win_snowman");
    self addOption("MiscZombiesModels", "Spawn Armor Build Station", &SpawnModel, #"hash_74c59e8a4df12e7f");
    self addOption("MiscZombiesModels", "Spawn Deathray Sphere", &SpawnModel, #"p7_zm_ctl_deathray_sphere");
    self addOption("MiscZombiesModels", "Spawn Mystery Box Bunny", &SpawnModel, #"p9_zm_platinum_magic_box_bunny");
    self addOption("MiscZombiesModels", "Spawn Yellow Stuffed Dragon", &SpawnModel, #"p8_stuffed_dragon_yellow");
    self addOption("MiscZombiesModels", "Spawn Christmas Tree", &SpawnModel, "p9_zm_silver_foliage_tree_christmas_full");
    self addOption("MiscZombiesModels", "Spawn Rocket", &SpawnModel, #"p9_sur_machine_rocket_01");
    self addOption("MiscZombiesModels", "Spawn Arcade Machine", &SpawnModel, #"p9_machine_arcade_02");
}

SpawnModel(Model){
    Model = ishash(Model) ? Model : hash(Model);
    Look = self GetLookPosition();
    Object = spawn("script_model", Look);
    Object setModel(Model);

    self iprintln("Spawned Object at: " + Look);
}

StartForgeMode()
{
    if (!isDefined(self.ForgeMode) || !self.ForgeMode) {
        self.ForgeMode = true;
        self iPrintLnBold("^3Forge Mode ^2activated.");
        self thread MonitorForgeMode();
    } else {
        self.ForgeMode = undefined;
        self notify("StopForgeMode");
        self iPrintLnBold("^3Forge Mode ^1deactivated.");
    }
}

MonitorForgeMode() {
    self endon("death");
    self endon("StopForge");

    while (self.ForgeMode) {
        while(self adsbuttonpressed())
		{
            trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
            while(self adsbuttonpressed())
            {
                trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
				trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
				wait 0.05;

			}

		}
		wait 0.05;
    }
}

SpawnRollerCoaster()
{
    self endon("disconnect");

    if (level.coasterExists)
    {
        self iPrintLnBold("^1You can only spawn 1 roller coaster per match!");
        return;
    }

    level.coasterExists = true;

    startPos = self.origin;

    path = [];
    path[0] = startPos + (0, 0, 0);
    path[1] = startPos + (0, 0, 300);
    path[2] = startPos + (0, 0, 600);
    path[3] = startPos + (0, 0, 900);
    path[4] = startPos + (0, 0, 1200);

    loopRadius = 300;
    loopSteps = 12;
    for(i = 0; i < loopSteps; i++)
    {
        angle = (i / (loopSteps - 1.0)) * 360;
        rad = angle * (3.14159 / 180);
        x = (sin(rad) * loopRadius);
        z = (cos(rad) * loopRadius);
        path[path.size] = startPos + (200 + x, 0, 1200 + z);
    }

    path[path.size] = startPos + (600, 200, 700);
    path[path.size] = startPos + (900, 600, 400);
    path[path.size] = startPos + (700, 900, 200);
    path[path.size] = startPos + (350, 1000, 75);
    path[path.size] = startPos + (0, 900, 100);
    path[path.size] = startPos + (0, 600, 0);
    path[path.size] = startPos + (0, 300, 0);
    path[path.size] = startPos + (0, 0, 0);

    cart = spawn("script_model", path[0]);
    cart setModel(#"hash_12e47c6c01f2ff59");

    self linkTo(cart);
    self SetOrigin(cart.origin + (0, 0, 65));
    self.allowAds = true;
    self.allowweapons = true;
    self EnableInvulnerability();
    self.oobdisabled = 1;

    self iPrintLnBold("^3Roller Coaster! Press Jump to get off!");
    self thread MonitorCoasterExit(cart);

    cur = 0;
    next = 1;

    while (isDefined(cart))
    {
        start = path[cur];
        end = path[next];

        dir = VectorNormalize(end - start);
        totalDist = Distance(start, end);
        moved = 0;

        slope = (end[2] - start[2]) * 0.05;
        speed = 60 + slope;
        if(speed < 35) speed = 35;
        if(speed > 100) speed = 100;

        cart.angles = VectorToAngles(dir);

        while (moved < totalDist && isDefined(cart))
        {
            cart.origin += dir * speed;
            moved += speed;
            wait 0.01;
        }

        cur = next;
        next++;
        if (next >= path.size)
            next = 0;
    }
}

MonitorCoasterExit(cart)
{
    self endon("disconnect");

    while (isDefined(cart))
    {
        if (self jumpButtonPressed())
        {
            self unlink();
            self DisableInvulnerability();
            self.oobdisabled = 0;

            if (isDefined(cart))
            {
                cart delete();
            }

            self iPrintLnBold("^1You jumped out!");
            break;
        }
        wait 0.05;
    }
}

SpawnDropTower()
{
    self endon("disconnect");

    basePos = self.origin;
    towerHeight = 11;
    spacing = 60;
    dropSpeed = 8.0;
    liftSpeed = 2.5;
    waitTime = 1.5;

    platformOffset = 40;

    platformHeight = basePos[2] + (towerHeight * spacing);
    dropHeight = basePos[2];

    for (i = 0; i < towerHeight; i++)
    {
        pos = (basePos[0], basePos[1], basePos[2] + (i * spacing));
        obj = spawn("script_model", pos);
        obj setModel(#"hash_12e47c6c01f2ff59");
    }

    platform = spawn("script_model", (basePos[0] + platformOffset, basePos[1], platformHeight));
    platform setModel(#"hash_12e47c6c01f2ff59");

    wait 2;

    while (1)
    {
        for (z = dropHeight; z <= platformHeight; z += liftSpeed)
        {
            platform.origin = (basePos[0] + platformOffset, basePos[1], z);
            wait 0.05;
        }

        wait waitTime;

        for (z = platformHeight; z >= dropHeight; z -= dropSpeed)
        {
            platform.origin = (basePos[0] + platformOffset, basePos[1], z);
            wait 0.03;
        }

        wait 2;
    }
}

SpawnMerryGoRound()
{
    self endon("disconnect");

    centerPos = self.origin;
    radius = 175;
    numSeats = 6;
    rotationSpeed = 4;

    seats = [];
    angleStep = 360 / numSeats; 

    for (i = 0; i < numSeats; i++)
    {
        angle = i * angleStep;
        x = centerPos[0] + (radius * cos(angle));
        y = centerPos[1] + (radius * sin(angle));
        z = centerPos[2];

        seat = spawn("script_model", (x, y, z));
        seat setModel(#"hash_12e47c6c01f2ff59");
        seats[i] = seat;
    }

    self iprintlnBold("^3Merry-Go-Round Starting! Hold on!");
    
    seatIndex = randomInt(numSeats);
    self linkTo(seats[seatIndex]);

    wait 2;

    self thread MonitorJumpToExit();
    
    BuildCentralStructure(centerPos);

    while (1)
    {
        for (rotation = 0; rotation < 360; rotation += rotationSpeed)
        {
            for (i = 0; i < numSeats; i++)
            {
                angle = (i * angleStep) + rotation;
                x = centerPos[0] + (radius * cos(angle));
                y = centerPos[1] + (radius * sin(angle));

                seats[i].origin = (x, y, centerPos[2]);
            }

            wait 0.05;
        }
    }
}

MonitorJumpToExit()
{
    self endon("disconnect");
    while (1)
    {
        if (self jumpbuttonpressed())
        {
            self unlink();
            self iprintlnBold("^1You jumped off!");
            break;
        }
        wait 0.05;
    }
}

BuildCentralStructure(origin)
{
    wallModels = [];
    wallModels[0] = #"hash_12e47c6c01f2ff59";
    wallModels[1] = #"hash_12e47c6c01f2ff59";
    wallModels[2] = #"hash_12e47c6c01f2ff59";
    wallModels[3] = #"hash_12e47c6c01f2ff59";

    wallPositions = [];
    wallPositions[0] = (origin[0] + 100, origin[1], origin[2]);
    wallPositions[1] = (origin[0] - 100, origin[1], origin[2]);
    wallPositions[2] = (origin[0], origin[1] + 100, origin[2]);
    wallPositions[3] = (origin[0], origin[1] - 100, origin[2]);

    wallAngles = [];
    wallAngles[0] = (0, 90, 0);
    wallAngles[1] = (0, -90, 0);
    wallAngles[2] = (0, 0, 0);
    wallAngles[3] = (0, 180, 0);

    for (i = 0; i < 4; i++)
    {
        wall = spawn("script_model", wallPositions[i]);
        wall setModel(wallModels[i]);
        wall.angles = wallAngles[i];
    }

    roof = spawn("script_model", (origin[0], origin[1], origin[2] + 100));
    roof setModel(#"hash_12e47c6c01f2ff59");
}

SpawnTrampoline()
{
    if (!isDefined(self.Trampoline) || !self.Trampoline) {
        trampoline = spawn("script_model", self.origin);
        trampoline setmodel( #"hash_12e47c6c01f2ff59");
        self thread MonitorTrampoline(trampoline);
    } else {
        self notify("StopTrampoline");
        trampoline delete();
    }
}

MonitorTrampoline(trampoline)
{
	self endon("disconnect");
    self endon("StopTrampoline");
	trampolineRadius = 130;

    while (self.trampe) {
        if (distance(self.origin, trampoline.origin) < trampolineRadius) {
            vel = self getVelocity();
            if (vel[2] < -50) {
                self iPrintLnBold("^2BOING!");
                z = randomIntRange(700, 900);
                self setVelocity((vel[0], vel[1], z));
            }
        }
		wait 0.5;
	}
}

SpawnWall() {
    carePackageModel = #"hash_12e47c6c01f2ff59";
    spacing = 25;

    width = 10;
    height = 3;
    for (x = 0; x < width; x++)
    {
        for (z = 0; z < height; z++)
        {
            position = (self.origin[0] + (x * spacing), self.origin[1], self.origin[2] + (z * spacing));
            package = spawn("script_model", position);
            package setModel(carePackageModel);
        }
    }
    forward = anglesToForward(self getAngles());
    newPosition = self.origin + (forward * 128);
    self setOrigin(newPosition);
} 

SpawnStaircase() 
{
    StaircaseBuild(self.origin, 100, 5, 20, 10);
}

StaircaseBuild(origin, totalPackages, height, radiusIncrement, angleIncrement)
{
    carePackageModel = #"hash_12e47c6c01f2ff59";
    radius = 10;
    pi = 3.141592653589793;
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