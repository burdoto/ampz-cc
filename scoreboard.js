var line = 0;

function anyOr(it, fallback)  {
    if (it === null || it === undefined || it === '')
        return fallback;
    return it;
}

function $() {
    // get arguments
    if (args.length >= 1)
        line = parseInt(args[0]);

    // line 4 is static
    if (line === 4)
        return '&fâ— &7Use &d/rg info&7 for details';

    // lines 1-3 only change if a user enters a region
    var region = '%worldguard_region_name%' !== '';
    switch (line) { // no region
        case 1: return region ? '&7You are in &e%worldguard_region_name_capitalized%' : '&7You are in &aWilderness';
        case 2: return region ? '&fâ— &7Owner: &d'+anyOr('%worldguard_region_owner%','none') : '&fâ— &7Select Area with &d//pos1&7 and &d//pos2';
        case 3: return region ? '&fâ— &7Members: &d'+anyOr('%worldguard_region_members%','none') : '&fâ— &7Create claim with &d/rg claim [id]';
    }

    // line 5 tells whether the region has pvp or not
    if (line === 5) {
        var pvp = '%worldguard_region_has_flag_pvp_allow%';
        // fallback value for pvp is 'allow'
        if (pvp === '') return '&fâ— &7PvP: &cyes';
        var pre = pvp === 'yes' ? '&c&m' : '&a&m';
        pvp = pre + pvp;
        return (region ? '&fâ— &7&mPvP: ' : '&fâ— &7&mPvP: ') + pvp + '&7 (WIP inside claims)';
    }
    return 'invalid line';
}

$();
