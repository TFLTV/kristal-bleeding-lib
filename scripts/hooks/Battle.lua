---@class Battle
---
---@field bleed_timer               number                         How much time there is before you bleed again, in seconds.
---@field bleeders                  PartyBattler[]                 Party Members who bleed.
---@field graze_heal                number                         How much grazing heals you.
---@field bleed_amount              number                         How much health you lose per bleed. (Maybe can be a float?? idk)
---@field do_bleed                  boolean                        If bleeding is toggled. (Also controls graze heal)
---@field idle_bleed_time           number                         The time for bleeding while idle. Defaults to 4/30
---@field moving_bleed_time         number                         The time for bleeding while moving. Defaults to 2/30

local Battle, super = Class("Battle")

function Battle:init()
	super.init(self)
    self.bleed_timer = 4/30 -- Every four frames
    self.bleeders = {self.party[1]}
end

function Battle:update()
	super.update(self)

    local bleeders = self.bleeders or (Game.bleeders or {self.party[1]}) -- There, if you wanna change it, it's easy. -- self.bleeder uses PartyBattlers and numbers, Game.bleeders only uses numbers
    local bleed = (self.do_bleed or Game.do_bleed) ~= false
    local bleed_amount = self.bleed_amount or (Game.bleed_amount or 1)
    
    if self:getState() == "DEFENDING" then
        local soul_moving = self.soul and self.soul:isMoving() or false

        local bleed_time = (soul_moving and 
        (self.moving_bleed_time or (Game.moving_bleed_time or 2/30))) or 
        (self.idle_bleed_time or (Game.idle_bleed_time or 4/30))

        self.bleed_time = bleed_time

        if self.bleed_timer >= self.bleed_time then
            
            for _,bleeder in ipairs(bleeders) do
                if not bleed then break end
                if type(bleeder) == "number" then bleeder = self.party[bleeder] end
                bleeder:removeHealth(bleed_amount)
            end

            self.bleed_timer = 0 --(self.soul:isMoving() and 2 or 4)/30
        end

        self.bleed_timer = self.bleed_timer + DT
    end
    
    for _,bleeder in ipairs(bleeders) do
        if not bleed then break end
        if type(bleeder) == "number" then bleeder = self.party[bleeder] end
        if bleeder.is_down then
            Game:gameOver(self:getSoulLocation())
        end
    end
end

return Battle
