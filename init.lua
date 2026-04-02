dofile_once("data/scripts/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")
local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

--- ### Adds a component to an entity file.
--- ***
--- @param file_path string The path to the file you wish to add a component to.
--- @param comp string The component you wish to add.
function ModEntityFileAddComponent(file_path, comp)
    local file_contents = ModTextFileGetContent(file_path)
    local contents = file_contents:gsub("</Entity>$", function() return comp .. "</Entity>" end)
    ModTextFileSetContent(file_path, contents)
end

ModEntityFileAddComponent(
    "data/entities/items/wands/wand_good/wand_good_3.xml", [[
    <ParticleEmitterComponent 
        _tags="enabled_in_world,enabled_in_hand,tower_wand_emitter"

        emitted_material_name="plasma_fading_pink"
        offset.x="8.0"
        offset.y="0.0"
        gravity.y="0.0"
        lifetime_min="0.2"
        lifetime_max="0.8"
        x_vel_min="-50"
        x_vel_max="-20"
        y_vel_min="-10"
        y_vel_max="10"
        count_min="1"
        count_max="2"
        direction_random_deg="50"
        trail_gap="0.5"
        render_on_grid="1"
        attractor_force="1"
        fade_based_on_lifetime="1"
        area_circle_radius.max="5"
        airflow_force="0.051"
        airflow_time="1.01"
        airflow_scale="0.03"
        emission_interval_min_frames="8"
        emission_interval_max_frames="10"
        emit_cosmetic_particles="1"
        emit_real_particles="0"
        is_emitting="0"
    />

    <ParticleEmitterComponent 
        _tags="enabled_in_world,enabled_in_hand,tower_wand_emitter"

        emitted_material_name="plasma_fading_green"
        offset.x="8.0"
        offset.y="0.0"
        gravity.y="0.0"
        lifetime_min="0.2"
        lifetime_max="0.4"
        x_vel_min="-50"
        x_vel_max="-20"
        y_vel_min="-10"
        y_vel_max="10"
        count_min="1"
        count_max="2"
        trail_gap="0.5"
        render_on_grid="1"
        attractor_force="1"
        fade_based_on_lifetime="1"
        area_circle_radius.max="5"
        airflow_force="0.051"
        airflow_time="1.01"
        airflow_scale="0.03"
        emission_interval_min_frames="8"
        emission_interval_max_frames="10"
        emit_cosmetic_particles="1"
        emit_real_particles="0"
        is_emitting="0"
    />
    ]]
)

local tower_wand_update_frame = 0
local TOWER_WAND_UPDATE_FREQ_FRAME = 30

function OnWorldPreUpdate()
    tower_wand_update_frame = tower_wand_update_frame + 1
    
    while tower_wand_update_frame >= TOWER_WAND_UPDATE_FREQ_FRAME do
        tower_wand_update_frame = tower_wand_update_frame - TOWER_WAND_UPDATE_FREQ_FRAME

        tower_wands_update()
    end
end

-- replacing static sprites into animated ones
local TOWER_WAND_IMAGE_FILE_PATH_REPLACE = {
    ["data/items_gfx/wands/custom/good_01.xml"] = "mods/cxredix_animated_tower_wands/assets/swiftness/animated.xml",
    ["data/items_gfx/wands/custom/good_02.xml"] = "mods/cxredix_animated_tower_wands/assets/destruction/animated.xml",
    ["data/items_gfx/wands/custom/good_03.xml"] = "mods/cxredix_animated_tower_wands/assets/multitudes/animated.xml",

}

function tower_wands_update()
    local wands = EntityGetWithTag("wand")

    if wands ~= nil then
        local should_emit = ModSettingGet(atw_common.settings_mod_id .. ".multitudes_particles")

        for wand_i, wand_id in ipairs(wands) do
            
            -- display emitters
            local emitters = EntityGetComponent(wand_id, "ParticleEmitterComponent")

            if emitters ~= nil then
                for emitter_i, emitter_id in ipairs(emitters) do
                    if ComponentHasTag(emitter_id, "tower_wand_emitter") then
                        ComponentSetValue(emitter_id, "is_emitting", should_emit and 1 or 0)
                    end
                end
            end


            -- change sprite to animated
            local sprite_comps = EntityGetComponent(wand_id, "SpriteComponent")

            if sprite_comps ~= nil then
                for sprite_comp_i, sprite_comp_id in ipairs(sprite_comps) do
                    local img_file_str = ComponentGetValue(sprite_comp_id, "image_file")

                    -- HACK for animated sprites, the default sprites are static for UI purposes.
                    if TOWER_WAND_IMAGE_FILE_PATH_REPLACE[img_file_str] ~= nil then
                        ComponentSetValue(
                            sprite_comp_id, "image_file", TOWER_WAND_IMAGE_FILE_PATH_REPLACE[img_file_str]
                        )
                    end
                end
            end


        end
    end
end




