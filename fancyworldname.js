var line = 0;

function anyOr(it, fallback)  {
    if (it === null || it === undefined || it === '')
        return fallback;
    return it;
}

function $() {
    var world = '%player_world%'
    switch (world) {
        case 'atf10': return '&aO'; // Overworld
        case 'atf10/DIM-1': return '&cN'; // Nether
        case 'atf10/DIM1': return '&eE'; // the End
        case 'atf10/aether/the_aether': return '&3A'; // Aether
        case 'atf10/bloodmagic/dungeon': return '&9D'; // Dungeon
        case 'atf10/blue_skies/everdawn': return '&0D'; // everDawn
        case 'atf10/blue_skies/everbright': return '&0B'; // everBright
        case 'atf10/twilightforest/twilight_forest': return '&5F'; // twilight Forest
        default: return '&k?';
    }
}

$();
