dofile("data/scripts/lib/mod_settings.lua")
local atw_common = dofile_once("mods/cxredix_animated_tower_wands/atw_common.lua")

local mod_settings = {
    {
        id = "multitudes_particles",
        ui_name = "Multitude Particles",
        ui_description = "Enables fancy cosmetic particles on Wand of Multitudes because it deserves it.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    }
}

function ModSettingsUpdate( init_scope )
	mod_settings_update( atw_common.settings_mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( atw_common.settings_mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( atw_common.settings_mod_id, mod_settings, gui, in_main_menu )
end
