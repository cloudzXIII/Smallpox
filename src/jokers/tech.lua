SMODS.Atlas({
    key = "poxofthewild", 
    path = "jokers/poxofthewild.png", 
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

loc_colour()
G.ARGS.LOC_COLOURS.rainbow_badge = SMODS.Gradient {
	key = "rainbow_badge",
	update = function(self, dt)
        local rgb = SPOX.hsl2rgb(math.fmod((G.TIMERS.REAL) * 50, 360), 1, 0.75, 1)
		for i, color in ipairs(rgb) do
			self[i] = color
		end
	end
}

SMODS.Joker {
        key = "poxofthewild",
    blueprint_compat = true,
    rarity = 4,
    cost = 8,
    atlas = "poxofthewild",
	pools = {["Smallpox"] = true,["Disease"] = true,},
    pos = { x = 0, y = 0 },
	soul_pos = {
        x = 1, y = 0, draw = function (card, scale_mod, rotate_mod)
            card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod,0,0 - 0.1,nil, 0.2)
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod,0,0-0.2)
        end
    },
    config = { 
		extra = { 
			cxmult = 1, 
			uxmult = 1.5, 
			rxmult = 2, 
			lxmult = 3,
			pmult = 0.5,
			rlr=1, 
			retriggers = 0
		} 
	},
    loc_vars = function(self, info_queue, card)
		--[[
		info_queue[#info_queue+1] = {
			set = "tooltips", 
			key = "tt_smallpox_potw_table", 
			vars = {
				card.ability.extra.cxmult, 
				card.ability.extra.uxmult, 
				card.ability.extra.rxmult, 
				card.ability.extra.lxmult
			}
		}
		]]
        return { 
			vars = {
				card.ability.extra.cxmult, 
				card.ability.extra.uxmult, 
				card.ability.extra.rxmult, 
				card.ability.extra.lxmult, 
				card.ability.extra.pmult, 
				card.ability.extra.rlr
			} 
		}
    end,
     calculate = function(self, card, context)
        if context.joker_main then
			local tmult = 0
			local retriggers = 0
			for _, j in ipairs(G.jokers.cards) do
				if j ~= card and j.config.center.pools and j.config.center.pools['Smallpox'] then
					local r = j.config.center.rarity
					local p = j.config.center.pools
					if r == 1 or r == "Common" then 
					tmult = tmult + card.ability.extra.cxmult 
					end
					if r == 2 or r == "Uncommon" then 
					tmult = tmult + card.ability.extra.uxmult 
					end
					if r == 3 or r == "Rare" then 
						tmult = tmult + card.ability.extra.rxmult 
						retriggers = retriggers + card.ability.extra.rlr 
					end
					if r == 4 or r == "Legendary" then 
						tmult = tmult + card.ability.extra.lxmult 
						retriggers = retriggers + card.ability.extra.rlr 
					end
					if p['Meme'] or p['Disease'] then
						tmult = tmult + card.ability.extra.pmult
					end
				end
			end
			card.ability.extra.retriggers = retriggers
			return { xmult = math.max(1,tmult), sound = "smallpox_poxofthewild_pop", pitch = 1 }
		end

		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card then
			return{
				repetitions = card.ability.extra.retriggers,
				sound = "smallpox_poxofthewild_pop",
			}
		end
    end,
    smallpox_credits = {
		{
			text = {
                "By: Tech",
                "Code: LasagnaFelidae",
				"Art: Plasma"
            },
            color = G.ARGS.LOC_COLOURS.rainbow_badge,
		},
	},
}
