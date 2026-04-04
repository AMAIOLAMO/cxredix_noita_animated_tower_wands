dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/cxredix_animated_tower_wands/atw_wand_utils.lua")

local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

local entity_id = GetUpdatedEntityID()

local wand_info = atw_common.get_wand_info(ATW_ID.multitudes)

local ui_sprite_path = get_wand_entity_ui_sprite_path(entity_id)

-- updates the wand sprite
if ui_sprite_path == wand_info.noita_sprite_path then
    set_wand_entity_sprites(
        entity_id,
        wand_info:get_asset("static_01.xml"),
        wand_info:get_asset("animated.xml")
    )
end

-- particles
local emitters = EntityGetComponent(entity_id, "ParticleEmitterComponent")

if emitters ~= nil then
    local should_emit = ModSettingGet(atw_common.settings_mod_id .. ".multitudes_particles")

    for emitter_i, emitter_id in ipairs(emitters) do
        if ComponentHasTag(emitter_id, "tower_wand_emitter") then
            ComponentSetValue(emitter_id, "is_emitting", should_emit and 1 or 0)
        end
    end
end
