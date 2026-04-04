dofile_once("data/scripts/lib/utilities.lua")

--- ### Sets the UI sprite and game sprite for a given wand entity
--- ***
--- @param ui_sprite_path string the sprite path for the UI for the entity to display within the inventory hud
--- @param game_sprite_path string the sprite path for the in game wand sprite that displays within the game (held by entities)
function set_wand_entity_sprites(entity_id, ui_sprite_path, game_sprite_path)
    -- UI SPRITE COMPONENT --
    set_wand_entity_ui_sprite_path(entity_id, ui_sprite_path)

    -- IN GAME SPRITE COMPONENT --
    set_wand_entity_game_sprite_path(entity_id, game_sprite_path)
end

function set_wand_entity_ui_sprite_path(entity_id, sprite_path)
    local comp_id = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")

    if comp_id ~= nil then
        ComponentSetValue(
            comp_id, "sprite_file", sprite_path
        )

        return true
    end

    return false
end

function set_wand_entity_game_sprite_path(entity_id, sprite_path)
    local comp_id = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")

    if comp_id ~= nil then
        ComponentSetValue(
            comp_id, "image_file", sprite_path
        )

        return true
    end

    return false
end

function get_wand_entity_ui_sprite_path(entity_id)
    local comp_id = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")

    if comp_id ~= nil then
        return ComponentGetValue(
            comp_id, "sprite_file"
        )
    end

    return nil
end

function get_wand_entity_game_sprite_path(entity_id)
    local comp_id = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")

    if comp_id ~= nil then
        return ComponentGetValue(
            comp_id, "image_file"
        )
    end

    return nil
end
