--[[
DO NOT DELETE OUR CHUD SON EXAMPLE JOKER
DO NOT DELETE OUR CHUD SON EXAMPLE JOKER
DO NOT DELETE OUR CHUD SON EXAMPLE JOKER
DO NOT DELETE OUR CHUD SON EXAMPLE JOKER
]]

-- Example Joker Atlas
SMODS.Atlas({
    key = "examplejoker", 
    path = "jokers/ExampleJoker.png", 
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

-- Example Joker
SMODS.Joker {
    key = "examplejoker",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    pools = {["Smallpox"]= true}, -- must always have smallpox pool, check pools.lua for other defined pools
    discovered = true,
    config = { extra = { mult = 5 }, },
    atlas = 'examplejoker',
    pronouns = 'he_they', -- "she_her" "he_him" "they_them" "any_all" "it_its" "she_they" "he_they"
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                message = "test!",
                colour = HEX('a4eaf4')
            }
        end
    end
}


