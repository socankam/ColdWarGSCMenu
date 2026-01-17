function VehiclesMenu() {
    self createMenu("VehiclesMenu", "Spawn Vehicles");
    self addOption("VehiclesMenu", "Enter Vehicle", &EnterVehicle, []);
    self addOption("VehiclesMenu", "Spawn Gunship", &SpawnVehicle, #"veh_t8_ac130_gunship_mp");
    self addOption("VehiclesMenu", "Spawn Care Package Helicopter", &SpawnVehicle, #"vehicle_t9_mil_helicopter_care_package");
    self addOption("VehiclesMenu", "Spawn Racing RCXD", &SpawnVehicle, #"vehicle_t9_rcxd_racing_alt");
}

SpawnVehicle(vehicleType)
{
    vehicleType = ishash(vehicleType) ? vehicleType : hash(vehicleType);
    load = isAssetLoaded("vehicle", vehicleType);

    if (!isDefined(load) || !load)
    {
        self iPrintln("^1Vehicle Asset Not Loaded!");
        return;
    }

    pos = self GetLookPosition();
    veh = spawnVehicle(vehicleType, pos, (0, 0, 0));

    if (!isDefined(veh))
    {
        self iPrintln("^1Failed to spawn vehicle!");
        return;
    }

    veh makeUsable();

    if (isDefined(veh.isPhysicsVehicle) && veh.isPhysicsVehicle)
        veh SetBrake(1);

    if (isDefined(veh.vehicleClass) && veh.vehicleClass == #"helicopter")
        veh.origin += (0, 0, veh.height);

    if (isAirborne(veh))
        veh SetRotorSpeed(1.0);

    self iPrintln("^2Vehicle Spawned!");
}

EnterVehicle()
{
    trace = self GetLookTrace();
    ent = trace["entity"];

    if (isDefined(ent) && isVehicle(ent))
    {
        ent UseVehicle(self, 0);
        self CloseMenu();
    }
    else
    {
        self iPrintln("^1No Vehicle Found!");
    }
}
