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


-- Initialize wand lua scripts
for atw_id = ATW_ID.BEGIN, ATW_ID.END do
    -- append individual script files for each tower wand
    local tower_wand = atw_common.get_wand_info(atw_id)

    tower_wand:append_raw_entity_components(([[
    <LuaComponent
        _enabled="1"
        _tags="enabled_in_world,enabled_in_hand"
        execute_every_n_frame="30"
        script_source_file="%s"
    />
    ]]):format(tower_wand.asset_path .. "script.lua"))
end


-- MULTITUDES PARTICLE EMITTERS --
atw_common.get_wand_info(ATW_ID.multitudes):append_raw_entity_components([[
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

-- )
-- ModEntityFileAddComponent(
--     atw_common.tower_wands[ATW_ID.multitudes].noita_wand_entity_path, )
