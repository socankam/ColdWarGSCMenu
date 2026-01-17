function CharacterMenu() {
    self createMenu("CharacterMenu", "Character Menu");
    self addOption("CharacterMenu", "Change Character Skin", &OpenSubMenu, "ChangeSkin");
    //self addOption("CharacterMenu", "Change Character Outfit", &OpenSubMenu, "ChangeOutfit");

    self createMenu("ChangeSkin", "Change Skin");
    self addOption("ChangeSkin", "Invisible", &ChangeCharacterSkin, 0);
    self addOption("ChangeSkin", "Adler", &ChangeCharacterSkin, 1);
    self addOption("ChangeSkin", "Portnova", &ChangeCharacterSkin, 2);
    self addOption("ChangeSkin", "Garcia", &ChangeCharacterSkin, 3);
    self addOption("ChangeSkin", "Baker", &ChangeCharacterSkin, 4);
    self addOption("ChangeSkin", "Sims", &ChangeCharacterSkin, 5);
    self addOption("ChangeSkin", "Hunter", &ChangeCharacterSkin, 6);
    self addOption("ChangeSkin", "Vargas", &ChangeCharacterSkin, 7);
    self addOption("ChangeSkin", "Stone", &ChangeCharacterSkin, 8);
    self addOption("ChangeSkin", "Song", &ChangeCharacterSkin, 9);
    self addOption("ChangeSkin", "Powers", &ChangeCharacterSkin, 10);
    self addOption("ChangeSkin", "Baker (2)", &ChangeCharacterSkin, 11);
    self addOption("ChangeSkin", "Zeyna", &ChangeCharacterSkin, 12);
    self addOption("ChangeSkin", "Wolf", &ChangeCharacterSkin, 13);
    self addOption("ChangeSkin", "Beck", &ChangeCharacterSkin, 14);
    self addOption("ChangeSkin", "Knight", &ChangeCharacterSkin, 15);
    self addOption("ChangeSkin", "Antonov", &ChangeCharacterSkin, 16);
    self addOption("ChangeSkin", "Park", &ChangeCharacterSkin, 17);
    self addOption("ChangeSkin", "Stitch", &ChangeCharacterSkin, 18);
    self addOption("ChangeSkin", "Bulldozer", &ChangeCharacterSkin, 19);
    self addOption("ChangeSkin", "CDL (Male?)", &ChangeCharacterSkin, 20);
    self addOption("ChangeSkin", "CDL (Female?)", &ChangeCharacterSkin, 21);
    self addOption("ChangeSkin", "Woods", &ChangeCharacterSkin, 22);
    self addOption("ChangeSkin", "Rivas", &ChangeCharacterSkin, 23);
    self addOption("ChangeSkin", "Naga", &ChangeCharacterSkin, 24);
    self addOption("ChangeSkin", "Maxis", &ChangeCharacterSkin, 25);
    self addOption("ChangeSkin", "John Doe (BO4 Zombies)", &ChangeCharacterSkin, 26);
    self addOption("ChangeSkin", "Jane Doe (BO4 Zombies)", &ChangeCharacterSkin, 27);
    self addOption("ChangeSkin", "Nude (Male)", &ChangeCharacterSkin, 28);
    self addOption("ChangeSkin", "Nude (Female)", &ChangeCharacterSkin, 29);
    self addOption("ChangeSkin", "Wraith", &ChangeCharacterSkin, 30);
    self addOption("ChangeSkin", "Baker (3)", &ChangeCharacterSkin, 31);
    self addOption("ChangeSkin", "Park (2)", &ChangeCharacterSkin, 32);
    self addOption("ChangeSkin", "Price", &ChangeCharacterSkin, 33);
    self addOption("ChangeSkin", "John McClane", &ChangeCharacterSkin, 34);
    self addOption("ChangeSkin", "Rambo", &ChangeCharacterSkin, 35);
    self addOption("ChangeSkin", "Weaver", &ChangeCharacterSkin, 36);
    self addOption("ChangeSkin", "Jackal", &ChangeCharacterSkin, 37);
    self addOption("ChangeSkin", "Salah", &ChangeCharacterSkin, 38);
    self addOption("ChangeSkin", "Kitsune", &ChangeCharacterSkin, 39);
    self addOption("ChangeSkin", "Stryker", &ChangeCharacterSkin, 40);
    self addOption("ChangeSkin", "Arthur Kingsley", &ChangeCharacterSkin, 41);
    self addOption("ChangeSkin", "Hudson", &ChangeCharacterSkin, 42);
    self addOption("ChangeSkin", "Mason", &ChangeCharacterSkin, 43);
    self addOption("ChangeSkin", "Scream", &ChangeCharacterSkin, 44);
    self addOption("ChangeSkin", "Fuze", &ChangeCharacterSkin, 45);
    self addOption("ChangeSkin", "Zombies (Female)", &ChangeCharacterSkin, 46);
    self addOption("ChangeSkin", "Zombies (Male)", &ChangeCharacterSkin, 47);
    self addOption("ChangeSkin", "Lazar", &ChangeCharacterSkin, 48);

    self createMenu("ChangeOutfit", "Change Character Outfit");
    for (i = 0; i < 24; i++) {
        self addOption("ChangeOutfit", "Outfit " + i, &ChangeCharacterOutfit, i);
    }
}

ChangeCharacterSkin(id) {
    self setspecialistindex(id);
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

    self iPrintLnBold("^3Skin changed");
}


ChangeCharacterOutfit(id) {
    self setcharacteroutfit(id);
    self setcharacterwarpaintoutfit(0);
    self function_ab96a9b5("head", 0);
    self function_ab96a9b5("headgear", 0);
    self function_ab96a9b5("arms", 0);
    self function_ab96a9b5("torso", 0);
    self function_ab96a9b5("legs", 0);
    self function_ab96a9b5("palette", 0);
    self function_ab96a9b5("warpaint", 0);
    self function_ab96a9b5("decal", 0);

    self iPrintLnBold("^3Outfit changed");
}