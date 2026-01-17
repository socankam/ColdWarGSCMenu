Zombies() {
    return sessionmodeiszombiesgame();
}

Multiplayer() {
    return sessionmodeismultiplayergame();
}

Warzone() {
    return sessionmodeiswarzonegame();
}

Distance(a, b)
{
    return length(b - a);
}

StartsWith(str, prefix)
{
    return getSubStr(str, 0, prefix.size) == prefix;
}

ArrayContains(arr, value)
{
    foreach(item in arr)
    {
        if (item == value)
            return true;
    }

    return false;
}

GetCurrentMapType()
{
    cur = util::get_map_name();

    if (StartsWith(cur, "zm_"))
        return "zm";

    if (StartsWith(cur, "wz_"))
        return "wz";

    return "unknown";
}

RegisterCurrentWeaponAsItem(weapon)
{
    if (!isDefined(weapon))
        return undefined;

    drop = self item_drop::function_fd9026e4(0, weapon);

    if (isDefined(drop) && isEntity(drop))
    {
        self item_world::consume_item(drop);
        waitframe(1);
        return drop;
    }

    return undefined;
}

GetLookPosition()
{
    return self GetLookTrace()["position"];
}

GetLookTrace()
{
    eyePos = self geteye();
    aimDir = AnglesToForward(self GetPlayerAngles());

    maxDistance = 10000;

    return bullettrace(eyePos, eyePos + vectorscale(aimDir, maxDistance), true, self);
}

VecNormalize( v )
{
    l = length( v );
    if ( l <= 0.001 )
        return (0,0,0);

    return vector_scal( v, 1 / l );
}

vector_scal(vec, scale) 
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}

EndGame()
{
    KillServer();
}

RestartMap()
{
    map_restart(0);
}

BuildScrollBar(count,str)
{
    if(count >1 ){
        part = str;
        out = "";

        for (i = 0; i < count; i++) out += part;
        return out;
    }
    else{
        return str;
    }
}

IsHudBold()
{
    if (!isDefined(self.menu) || !isDefined(self.menu["hudStyle"])) return true;

    return (self.menu["hudStyle"] == 1);
}