dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/cxredix_animated_tower_wands/atw_wand_utils.lua")

local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

-- updates the wand sprite
set_wand_entity_sprites(
    entity_id,
    (atw_common.assets_path .. "swiftness/static_01.xml"),
    (atw_common.assets_path .. "swiftness/animated.xml")
)


