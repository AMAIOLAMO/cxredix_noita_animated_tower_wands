dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/cxredix_animated_tower_wands/atw_wand_utils.lua")

local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

local entity_id = GetUpdatedEntityID()

local wand_info = atw_common.get_wand_info(ATW_ID.swiftness)

-- updates the wand sprite
set_wand_entity_sprites(
    entity_id,
    wand_info:get_asset("static_01.xml"),
    wand_info:get_asset("animated.xml")
)
