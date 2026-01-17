VisionMenu()
{
    self createMenu("VisionMenu", "Vision Menu");

    self addToggleOption("VisionMenu", "Last Stand Vision", &LastStandPostFX, false);
    self addToggleOption("VisionMenu", "Fire Vision", &FireVision, false);
    self addToggleOption("VisionMenu", "Enter Stargate", &Stargate, false);
    if(util::get_map_name() == "zm_silver" && self isHost()) self addToggleOption("VisionMenu", "Green Fog", &GreenFog, false);
    self addToggleOption("VisionMenu", "Dead Ops Arcade Vision", &DeadOpsArcade, false);
    self addToggleOption("VisionMenu", "Drunk Vision", &DrunkMode, false);
    self addToggleOption("VisionMenu", "Drown Blur Overlay", &DrownBlur, false);
    self addToggleOption("VisionMenu", "Vortex Blur Overlay", &VortexBlur, false);
}

DrownBlur() { VisionToggle("overlay", "drown_blur", 80); }
VortexBlur() { VisionToggle("overlay", "zm_idgun_vortex_blur", 80); }

LastStandPostFX()
{
    self.LastStandPostFX = isDefined(self.LastStandPostFX) ? undefined : true;

    if (isDefined(self.LastStandPostFX))
        self clientfield::set("zm_last_stand_postfx", 1);
    else
        self clientfield::set("zm_last_stand_postfx", 0);
}

GreenFog()
{
    self.GreenFog = isDefined(self.GreenFog) ? undefined : true;
 
    if(isDefined(self.GreenFog))
    {
        self endon("disconnect");
        
        level thread clientfield::set("dog_round_fog_bank", 1);
    }
    else{
        level thread clientfield::set("dog_round_fog_bank", 0);
    }
}

Stargate()
{
    self.Stargate = isDefined(self.Stargate) ? undefined : true;
    if(isDefined(self.Stargate)){
        self clientfield::set_to_player("player_stargate_fx", 1);
	    self clientfield::set_to_player("fasttravel_teleport_sfx", 1);
    }
    else{
        self clientfield::set_to_player("player_stargate_fx", 0);
	    self clientfield::set_to_player("fasttravel_teleport_sfx", 0);
    }
}

FireVision()
{
    self.Fire = isDefined(self.Fire) ? undefined : true;
    if(isDefined(self.Fire)){
        self clientfield::set("burn", 1);
    }
    else{
        self clientfield::set("burn", 0);
    }
}

initializeVision()
{
    self endon("disconnect");

    while (true)
    {
        level visionset_mgr::set_state_active(self, 1);
        wait 0.05;
    }
}

VisionForceOn(type, name, priority)
{
    if (!ishash(name))
        name = hash(name);

    visionset_mgr::register_info(type, name, 1, priority, 1, 1);

    self visionset_mgr::activate(type, name, self, 0.25, 9999, 0.25);

    self iPrintlnBold("^2Vision Enabled: ^7" + name);
}

VisionForceOff(type, name)
{
    if (!ishash(name))
        name = hash(name);

    self visionset_mgr::deactivate(type, name, self);

    self iPrintlnBold("^1Vision Disabled: ^7" + name);
}

VisionToggle(type, name, priority)
{
    if (!isDefined(self.visionStates))
        self.visionStates = [];

    current = self.visionStates[name];

    if (!isDefined(current) || current == false)
    {
        self.visionStates[name] = true;
        VisionForceOn(type, name, priority);
    }
    else
    {
        self.visionStates[name] = false;
        VisionForceOff(type, name);
    }
}

DeadOpsArcade() {
    self.DeadOpsArcade = isDefined(self.DeadOpsArcade) ? undefined : true;
    if(isDefined(self.DeadOpsArcade))
    {
        self endon("EndDeadOpsArcade");
        while(isDefined(self.DeadOpsArcade))
        {
            birdsEyeCamera = spawn("script_model", self.origin + (0, 0, 600));
            birdsEyeCamera.angles = (90, 90, 0);
            birdsEyeCamera setModel("tag_origin");
            self CameraSetLookAt(birdsEyeCamera);
            self CameraSetPosition(birdsEyeCamera);
            self CameraActivate(true);
            
            temporaryOffset = 600;
            for(;;) {
                sightPassed = SightTracePassed(self.origin + (0, 0, 600), self.origin, false, birdsEyeCamera);
                if (sightPassed && birdsEyeCamera.origin[2] - self.origin[2] < 600) {
                    temporaryOffset = birdsEyeCamera.origin[2] - self.origin[2];
                    while (temporaryOffset < 600) {
                        temporaryOffset += 10;
                        birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
                        wait 0.01;
                    }
                }
                while (!SightTracePassed(self.origin + (0, 0, temporaryOffset), self.origin, false, birdsEyeCamera)) {
                    temporaryOffset -= 20;
                    birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
                    wait 0.01;
                }
                self SetPlayerAngles(self GetPlayerAngles() * (0, 1, 0));
                birdsEyeCamera.origin = self.origin + (0, 0, temporaryOffset);
                wait 0.01;
            }
        }
            
    }
    else{
         self notify("EndDeadOpsArcade");
         self CameraActivate(false);
    }
}

DrunkMode()
{
    self.Drunk = isDefined(self.Drunk) ? undefined : true;
 
    if(isDefined(self.Drunk))
    {
        if(Zombies()) {
            give_weapon(#"zombie_perk_bottle_revive");
            wait 3;
        }
        self thread DrunkMonitor();
    }
    else
        self notify("SoberUp");
        self SetBlur(0, .01);
        self setPlayerAngles(self.angles+(0,0,0));
}

DrunkMonitor()
{
	self endon("disconnect");
    self endon("SoberUp");
    self endon("death");


	while(self.Drunk)
	{
		self setPlayerAngles(self.angles+(0,0,0));
        wait 0.1;
        self setstance("prone");
        wait 0.1;
        self SetBlur(10.3,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,5));
        wait 0.1;
        self setstance("stand");
        wait 0.1;
        self SetBlur(9.1,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,10));
        wait 0.1;
        self setstance("prone");
        wait 0.1;
        self SetBlur(6.2,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,15));
        wait 0.1;
        self setBlur(5.2,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,20));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,25));
        wait 0.1;
        self setBlur(4.2,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,30));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,35));
        wait 0.1;
        self setBlur(3.2,1.0);
        wait 0.1;
        self setstance("crouch");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,30));
        wait 0.1;
        self setstance("prone");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,25));
        wait 0.1;
        self setBlur(2.2,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,20));
        wait 0.1;
        self setstance("crouch");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,15));
        wait 0.1;
        self setBlur(1.2,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,10));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,5));
        wait 0.1;
        self setBlur(0.5,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-5));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-10));
        wait 0.1;
        self setBlur(0,1.0);
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-15));
        wait 0.1;
        self setstance("prone");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-20));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-25));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-30));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-35));
        wait 0.1;
        self setstance("stand");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-30));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-25));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-20));
        wait 0.1;
        self setstance("crouch");
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-15));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-10));
        wait 0.1;
        self setPlayerAngles(self.angles+(0,0,-5));
        wait 0.1;
	}
}