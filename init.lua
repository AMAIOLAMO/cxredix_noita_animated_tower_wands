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

-- WAND INFO SETUP
local WandInfo = {}
WandInfo.__index = WandInfo

function WandInfo.new(noita_sprite_path, noita_wand_entity_path, asset_path)
    return setmetatable({
        noita_sprite_path = noita_sprite_path,
        noita_wand_entity_path = noita_wand_entity_path,
        asset_path = asset_path,
    }, WandInfo)
end

--- ### appends a string within the entity nxml tags.
--- ***
--- @param nxml_str string the raw nxml string to append within the wand entity.
function WandInfo:append_raw_entity_components(nxml_str)
    ModEntityFileAddComponent(
        self.noita_wand_entity_path, nxml_str
    )
end

function WandInfo:set_static_sprite(static_sprite_file_name_relative)
    local static_sprite = ModTextFileGetContent(self.asset_path .. static_sprite_file_name_relative)
    ModTextFileSetContent(self.noita_sprite_path, static_sprite)
end

-- tower wand id
local TW_ID = {
    TW_ID_BEGIN = 1,

    swiftness = 1,
    destruction = 2,
    multitudes = 3,

    TW_ID_END = 3,
}

local noita_wand_sprite_base_path = "data/items_gfx/wands/custom/"
local noita_wand_entity_base_path = "data/entities/items/wands/wand_good/"

local swiftness = WandInfo.new(
    noita_wand_sprite_base_path .. "good_01.xml",
    noita_wand_entity_base_path .. "wand_good_1.xml",
    (atw_common.assets_path .. "swiftness/")
)

local destruction = WandInfo.new(
    noita_wand_sprite_base_path .. "good_02.xml",
    noita_wand_entity_base_path .. "wand_good_2.xml",
    (atw_common.assets_path .. "destruction/")
)

local multitudes = WandInfo.new(
    noita_wand_sprite_base_path .. "good_03.xml",
    noita_wand_entity_base_path .. "wand_good_3.xml",
    (atw_common.assets_path .. "multitudes/")
)

local tower_wands = {
    [TW_ID.swiftness]   = swiftness,
    [TW_ID.destruction] = destruction,
    [TW_ID.multitudes]  = multitudes
}

for tw_id, tower_wand in pairs(tower_wands) do
    -- append individual script files for each tower wand
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
ModEntityFileAddComponent(
    tower_wands[TW_ID.multitudes].noita_wand_entity_path, [[
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
