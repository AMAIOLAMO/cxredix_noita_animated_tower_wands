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

local wand_comp_append_paths = {
    ["data/entities/items/wands/wand_good/wand_good_1.xml"] = atw_common.assets_path .. "swiftness/",
    ["data/entities/items/wands/wand_good/wand_good_2.xml"] = atw_common.assets_path .. "destruction/",
    ["data/entities/items/wands/wand_good/wand_good_3.xml"] = atw_common.assets_path .. "multitudes/",
}

local nxml_wand_animation_comp = ([[
    <LuaComponent
        _enabled="1"
        _tags="enabled_in_world,enabled_in_hand"
        execute_every_n_frame="30"
        script_source_file="%s"
    />
]]):format(atw_common.assets_path .. "atw_animated_replace.lua")

for wand_xml_path, wand_assets_path in pairs(wand_comp_append_paths) do
    ModEntityFileAddComponent(wand_xml_path, nxml_wand_animation_comp)

    ModEntityFileAddComponent(wand_xml_path, ([[
    <LuaComponent
        _enabled="1"
        _tags="enabled_in_world,enabled_in_hand"
        execute_every_n_frame="30"
        script_source_file="%s/script.lua"
    />
    ]]):format(wand_assets_path))
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
