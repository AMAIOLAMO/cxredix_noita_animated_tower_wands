dofile_once("data/scripts/lib/utilities.lua")
local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent")

if sprite_comps ~= nil then
    for sprite_comp_i, sprite_comp_id in ipairs(sprite_comps) do
        local img_file_str = ComponentGetValue(sprite_comp_id, "image_file")

        -- HACK for animated sprites, the default sprites are static for UI purposes.
        if atw_common.wand_img_file_replace[img_file_str] ~= nil then
            ComponentSetValue(
                sprite_comp_id, "image_file", atw_common.wand_img_file_replace[img_file_str]
            )
        end
    end
end
