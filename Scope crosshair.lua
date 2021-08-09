local line_color_in_game = ui.add_color_edit("Color", "line_color_in_game", true, color_t.new(255, 0, 0, 255))
local line_color_in_game_second = ui.add_color_edit("Color second", "line_color_in_game_second", true, color_t.new(255, 0, 0, 0))
local line_width = ui.add_slider_int("Line width", "line_width", 0, 1000, 100)
local line_length = ui.add_slider_int("Line length", "line_length", 0, 1000, 10)

local visuals_other_removals = ui.get_multi_combo_box("visuals_other_removals")
visuals_other_removals:set_value(0, false)

local function on_paint()
    player = entitylist.get_local_player()
    is_scoped = player:get_prop_bool( se.get_netvar( "DT_CSPlayer", "m_bIsScoped" ) )

    local r_drawvgui = se.get_convar("r_drawvgui")

    if is_scoped then
        local screen = engine.get_screen_size()

        local line_color = line_color_in_game:get_value()
        local r_first = line_color.r
        local g_first = line_color.g
        local b_first = line_color.b
        local a_first = line_color.a

        local line_color_second = line_color_in_game_second:get_value()
        local r_second = line_color_second.r
        local g_second = line_color_second.g
        local b_second = line_color_second.b
        local a_second = line_color_second.a

        local width = line_width:get_value()
        local length = line_length:get_value()

		renderer.rect_filled_fade(vec2_t.new(screen.x/2 + width, screen.y/2 + 1),                   vec2_t.new(screen.x/2 + length, screen.y/2),      color_t.new(r_second, g_second, b_second, a_second), color_t.new(r_first, g_first, b_first, a_first), color_t.new(r_first, g_first, b_first, a_first),     color_t.new(r_second, g_second, b_second, a_second)) -- LEFT
        renderer.rect_filled_fade(vec2_t.new(screen.x/2 - width, screen.y/2 + 1),    vec2_t.new(screen.x/2 - length, screen.y/2),      color_t.new(r_second, g_second, b_second, a_second), color_t.new(r_first, g_first, b_first, a_first), color_t.new(r_first, g_first, b_first, a_first),     color_t.new(r_second, g_second, b_second, a_second)) -- RIGHT
        renderer.rect_filled_fade(vec2_t.new(screen.x/2 + 1, screen.y/2 - length), vec2_t.new(screen.x/2, screen.y/2 - width), color_t.new(r_first, g_first, b_first, a_first),     color_t.new(r_first, g_first, b_first, a_first), color_t.new(r_second, g_second, b_second, a_second), color_t.new(r_second, g_second, b_second, a_second)) -- UP
        renderer.rect_filled_fade(vec2_t.new(screen.x/2 + 1, screen.y/2 + length), vec2_t.new(screen.x/2, screen.y/2 + width), color_t.new(r_first, g_first, b_first, a_first),     color_t.new(r_first, g_first, b_first, a_first), color_t.new(r_second, g_second, b_second, a_second), color_t.new(r_second, g_second, b_second, a_second)) -- DOWN

        r_drawvgui:set_float(0)
    else
        r_drawvgui:set_float(1)
    end
end
client.register_callback("paint", on_paint)

