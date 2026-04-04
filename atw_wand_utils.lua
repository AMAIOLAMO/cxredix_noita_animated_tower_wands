dofile_once("data/scripts/lib/utilities.lua")

--- ### Sets the UI sprite and game sprite for a given wand entity
--- ***
--- @param ui_sprite_path string the sprite path for the UI for the entity to display within the inventory hud
--- @param game_sprite_path string the sprite path for the in game wand sprite that displays within the game (held by entities)
function set_wand_entity_sprites(entity_id, ui_sprite_path, game_sprite_path)
    -- UI SPRITE COMPONENT --
    local ability_comp_id = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")

    if ability_comp_id ~= nil then
        ComponentSetValue(
            ability_comp_id, "sprite_file", ui_sprite_path
        )
    end

    -- IN GAME SPRITE COMPONENT --
    local sprite_comp_id = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")

    if sprite_comp_id ~= nil then
        -- HACK for animated sprites, the default sprites are static for UI purposes.
        ComponentSetValue(
            sprite_comp_id, "image_file", game_sprite_path
        )
    end
end
