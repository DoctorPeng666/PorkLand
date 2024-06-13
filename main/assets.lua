local TheNet = GLOBAL.TheNet

PrefabFiles = {
    "adult_flytrap",
    "alloy",
    "aporkalypse_clock",
    "armor_metalplate",
    "asparagus_planted",
    "basefan",
    "bill_quill",
    "bill",
    "boat_torch",
    "boatcontainer_classified",
    "boatrepairkit",
    "boats",
    "bonestaff",
    "chitin",
    "deep_jungle_fern_noise",
    "dungball",
    "dungbeetle",
    "dungpile",
    "fast_farmplot_planted",
    "flotsam",
    "flower_rainforest",
    "floweroflife",
    "gaze_beam",
    "glowfly",
    "gold_dust",
    "goldpan",
    "grabbing_vine",
    "grass_tall",
    "halberd",
    "hanging_vine_patch",
    "hanging_vine",
    "hippo_antler",
    "hippopotamoose",
    "inv_vine",
    "iron",
    "inv_vine",
    "pl_wave_shore",
    "jungle_border_vine",
    "lilypad",
    "lotus",
    "lotus_flower",
    "machete",
    "mandrakehouse",
    "mandrakeman",
    "mean_flytrap",
    "nectar_pod",
    "nettle",
    "pangolden",
    "peagawk",
    -- "peagawk_spawner",
    "piko",
    "pl_frog",
    "pl_froglegs",
    "pl_planted_tree",
    "pl_preparedfoods",
    "pl_veggies",
    "pl_foodbuffs",
    "peagawkfeather",
    "poisonbubble",
    "porkland_network",
    "porkland",
    "pugalisk_fountain",
    "pugalisk_ruins_pillar",
    "pugalisk_skull",
    "pugalisk_trap_door",
    "pugalisk",
    "rabid_beetle",
    "rowboat_wake",
    "sail",
    "sedimentpuddle",
    "shears",
    "smelter",
    "snake",
    "snakeskin",
    "snakeoil",
    "snake_bone",
    "teatree_nut",
    "teatrees",
    "tree_pillar",
    -- "tuber",
    -- "tubertrees",
    "wave_ripple",
    "venomgland",
    "venus_stalk",
    "walkingstick",
    "waterdrop",
    "weevole_carapace",
    "weevole",

    --roc related prefabs
    "roc_nest",

    "birdwhistle",

    "roc",
    "roc_leg",
    "roc_head",
    "roc_tail",

    "ro_bin",
    "ro_bin_gizzard_stone",
    "roc_robin_egg",


}

Assets = {
    -- minimap
    Asset("ATLAS", "images/minimap/pl_minimap.xml"),

    -- inventoryimages
    Asset("ATLAS", "images/hud/pl_inventoryimages.xml"),
    Asset("ATLAS_BUILD", "images/hud/pl_inventoryimages.xml", 256), -- for minisign

    -- boat
    Asset("ATLAS", "images/hud/pl_hud.xml"),
    Asset("IMAGE", "images/hud/pl_hud.tex"),

    -- crafting menu icons
    Asset("ATLAS", "images/hud/pl_crafting_menu_icons.xml"),

    -- hud
    Asset("ATLAS", "images/overlays/fx3.xml"),         -- poison, boat_over
    Asset("IMAGE", "images/overlays/fx3.tex"),
    Asset("ATLAS", "images/overlays/fx4.xml"),         -- pollen(hayfever)
    Asset("IMAGE", "images/overlays/fx4.tex"),
    Asset("ATLAS", "images/overlays/fx5.xml"),         -- fog
    Asset("IMAGE", "images/overlays/fx5.tex"),
    Asset("ANIM", "anim/leaves_canopy2.zip"),          --canopy

    Asset("ANIM", "anim/moon_aporkalypse_phases.zip"), -- blood moon

    -- player_actions
    Asset("ANIM", "anim/player_idles_poison.zip"),
    Asset("ANIM", "anim/player_mount_idles_poison.zip"),
    Asset("ANIM", "anim/player_actions_hack.zip"),
    Asset("ANIM", "anim/player_actions_shear.zip"),
    Asset("ANIM", "anim/player_sneeze.zip"),
    Asset("ANIM", "anim/player_mount_sneeze.zip"),
    Asset("ANIM", "anim/player_actions_panning.zip"),
    Asset("ANIM", "anim/player_boat_onoff.zip"),
    Asset("ANIM", "anim/swap_paddle.zip"),
    Asset("ANIM", "anim/player_action_sailing.zip"),
    Asset("ANIM", "anim/player_boat_death.zip"),
    Asset("ANIM", "anim/werebeaver_boat_death.zip"),
    Asset("ANIM", "anim/player_lifeplant.zip"),

    Asset("ANIM", "anim/player_actions_bucked.zip"),
    Asset("ANIM", "anim/player_teleport_bfb.zip"),
    Asset("ANIM", "anim/player_teleport_bfb2.zip"),

    -- boat ui
    Asset("ANIM", "anim/boat_health.zip"),
    Asset("ANIM", "anim/boat_hud_raft.zip"),
    Asset("ANIM", "anim/boat_hud_row.zip"),
    Asset("ANIM", "anim/boat_hud_cargo.zip"),
    Asset("ANIM", "anim/boat_inspect_raft.zip"),
    Asset("ANIM", "anim/boat_inspect_row.zip"),
    Asset("ANIM", "anim/boat_inspect_cargo.zip"),

    -- boat sail visual
    Asset("ANIM", "anim/sail_visual.zip"),
    Asset("ANIM", "anim/sail_visual_idle.zip"),
    Asset("ANIM", "anim/sail_visual_trawl.zip"),

    -- floater
    Asset("ANIM", "anim/ripple_build.zip"),

    Asset("ANIM", "anim/meat_rack_food_pl.zip"),
}

ToolUtil.RegisterInventoryItemAtlas("images/hud/pl_inventoryimages.xml")
AddMinimapAtlas("images/minimap/pl_minimap.xml")

local sounds = {
    Asset("SOUND", "sound/DLC003_AMB_stream.fsb"),
    Asset("SOUND", "sound/DLC003_music_stream.fsb"),
    Asset("SOUND", "sound/DLC003_sfx.fsb"),
    Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev")
}

if not TheNet:IsDedicated() then
    for _, asset in ipairs(sounds) do
        table.insert(Assets, asset)
    end
end
