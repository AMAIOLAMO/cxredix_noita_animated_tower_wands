dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/cxredix_animated_tower_wands/atw_wand_utils.lua")

local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
SetRandomSeed( x, y )

local wand_info = atw_common.get_wand_info(ATW_ID.multitudes)

local ui_sprite_path = get_wand_entity_ui_sprite_path(entity_id)

local RAND_SPRITE_PAIRS = {
    {"static_01.xml", "animated.xml"},
    {"static_02.xml", "static_02.xml"},
    {"static_03.xml", "static_03.xml"}
}

local DEFAULT_SPRITE_PAIRS = {
    {"static_01.xml", "animated.xml"},
}

-- updates the wand sprite
if ui_sprite_path == wand_info.noita_sprite_path then

    local sprite_pairs = atw_common:get_setting("randomize_wand_sprites") and RAND_SPRITE_PAIRS or DEFAULT_SPRITE_PAIRS

    local sprite_pair = sprite_pairs[Random(#sprite_pairs)]

    set_wand_entity_ui_sprite_path(
        entity_id, wand_info:get_asset(sprite_pair[1])
    )
    set_wand_entity_game_sprite_path(
        entity_id, wand_info:get_asset(sprite_pair[2])
    )
end

-- particles
local emitters = EntityGetComponent(entity_id, "ParticleEmitterComponent")

if emitters ~= nil then
    local should_emit = atw_common:get_setting("multitudes_particles")

    for _, emitter_id in ipairs(emitters) do
        if ComponentHasTag(emitter_id, "tower_wand_emitter") then
            ComponentSetValue(emitter_id, "is_emitting", should_emit and 1 or 0)
        end
    end
end
