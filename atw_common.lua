local M = {
    settings_mod_id = "CxRedix Animated Tower Wands",
    mod_root_path = "mods/cxredix_animated_tower_wands/",
}

M.assets_path = M.mod_root_path .. "assets/"

M.wand_img_file_replace = {
    ["data/items_gfx/wands/custom/good_01.xml"] = M.assets_path .. "swiftness/animated.xml",
    ["data/items_gfx/wands/custom/good_02.xml"] = M.assets_path .. "destruction/animated.xml",
    ["data/items_gfx/wands/custom/good_03.xml"] = M.assets_path .. "multitudes/animated.xml",
}

return M
