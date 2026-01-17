LuiDebugMenu()
{
    self createMenu("LuiDebugMenu", "LUI Debug Menu");

    self addOption("LuiDebugMenu", "Level Up Popup", &LuiDebugSend, #"hash_1739c4bd5baf83bc");
    self addOption("LuiDebugMenu", "UI Error", &LuiDebugSend, #"hash_1fc4832b89307895");
    self addOption("LuiDebugMenu", "Custom Mutations", &LuiDebugSend, #"hash_2f5757ad20bc3ae");
    self addOption("LuiDebugMenu", "Screen Fade", &LuiDebugSend, #"hash_300ac247ca9e52d3");
    self addOption("LuiDebugMenu", "Challenge Text", &LuiDebugSend, #"hash_8d33c3be569f08");
    self addOption("LuiDebugMenu", "Objective Timer", &ObjectiveTimer, []);
}

LuiDebugSend(hashVal)
{
    self endon("disconnect");

    testText = "^3LUI Test^7 from ^5" + self.name;

    self luinotifyevent(hashVal, 1, testText);

    self iPrintlnBold("^5[LUI DEBUG]^7 Sent to " + get_lui_hash_string(hashVal));
}

ObjectiveTimer(){ self thread objective_manager::function_b8278876(10, "pizza_delivery");}

get_lui_hash_string(hashVal)
{
    if (hashVal == #"hash_1006ebdc62e14847") return "'Zone Lost' Popup";
    if (hashVal == #"hash_14ebcb39234f4126") return "'Available' Popup";
    if (hashVal == #"hash_1739c4bd5baf83bc") return "Level Up Popup";
    if (hashVal == #"hash_175f8739ed7a932") return "Screen Fade";
    if (hashVal == #"hash_1fc4832b89307895") return "UI Error";
    if (hashVal == #"hash_296febf8f9af74a6") return "'Killer Chosen' Popup";
    if (hashVal == #"hash_2977456e1832eba6") return "'Bombs Detonated' Popup";
    if (hashVal == #"hash_2f5757ad20bc3ae") return "Custom Mutations";
    if (hashVal == #"hash_2fa61b57b75f2625") return "'Final Survivor' Popup";
    if (hashVal == #"hash_300ac247ca9e52d3") return "Screen Fade";
    if (hashVal == #"hash_76e8cddd9789122c") return "UI Error";
    if (hashVal == #"hash_7adc508fd96535c9") return "Display Perks";
    if (hashVal == #"hash_8d33c3be569f08") return "Challenge Text";
    if (hashVal == #"hash_c893e57629c7648") return "Change Class";
    return "Unknown LUI Hash";
}
