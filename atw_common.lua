dofile_once("data/scripts/lib/utilities.lua")

local M = {
    settings_mod_id = "CxRedix Animated Tower Wands",
    mod_root_path = "mods/cxredix_animated_tower_wands/",
}

M.assets_path = M.mod_root_path .. "assets/"

function M:get_setting(setting_id)
    return ModSettingGet(self.settings_mod_id .. "." .. setting_id)
end

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

function WandInfo:get_asset(relative_path)
    return self.asset_path .. relative_path
end

function WandInfo:set_static_sprite(static_sprite_file_name_relative)
    local static_sprite = ModTextFileGetContent(self.asset_path .. static_sprite_file_name_relative)
    ModTextFileSetContent(self.noita_sprite_path, static_sprite)
end

-- tower wand enum
ATW_ID = {
    BEGIN = 1,

    swiftness = 1,
    destruction = 2,
    multitudes = 3,

    END = 3
}

local noita_wand_sprite_base_path = "data/items_gfx/wands/custom/"
local noita_wand_entity_base_path = "data/entities/items/wands/wand_good/"

local swiftness = WandInfo.new(
    noita_wand_sprite_base_path .. "good_01.xml",
    noita_wand_entity_base_path .. "wand_good_1.xml",
    (M.assets_path .. "swiftness/")
)

local destruction = WandInfo.new(
    noita_wand_sprite_base_path .. "good_02.xml",
    noita_wand_entity_base_path .. "wand_good_2.xml",
    (M.assets_path .. "destruction/")
)

local multitudes = WandInfo.new(
    noita_wand_sprite_base_path .. "good_03.xml",
    noita_wand_entity_base_path .. "wand_good_3.xml",
    (M.assets_path .. "multitudes/")
)

local tower_wand_infos = {
    [ATW_ID.swiftness]   = swiftness,
    [ATW_ID.destruction] = destruction,
    [ATW_ID.multitudes]  = multitudes
}

function M.get_wand_info(atw_id)
    return tower_wand_infos[atw_id]
end

return M
