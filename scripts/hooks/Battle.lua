---@class Battle
---
---@field bleed_timer               number                         Bleed Time. Bleed when time. Time when bleed. BLEED.
---@field bleeders                  PartyBattler[]                 Party Members who bleed.
---@field graze_heal                number                         How much grazing heals you.
---@field bleed_amount              number                         How much health you lose per bleed. (Maybe can be a float?? idk)
-- @field party                     PartyBattler[]                 A table of all the `PartyBattler`s in the current battle -- for reference

local Battle, super = Class("Battle")

--[[function Battle:onStateChange(old,new)
    super.onStateChange(self,old,new)
    if new == "DEFENDING" then
        self.timer:every(4/30,function()

        end)
    end
end]]

function Battle:init()
	super.init(self)
    self.bleed_timer = 4/30 -- Every four frames
    self.bleeders = {self.party[1]}
end

function Battle:update()
	super.update(self)

    local bleeders = Game.bleeders or (self.bleeders or {self.party[1]}) -- There, if you wanna change it, it's easy. -- self.bleeder uses PartyBattlers and numbers, Game.bleeders only uses numbers
    local bleed = (self.do_bleed or Game.do_bleed) ~= false
    local bleed_amount = self.bleed_amount or (Game.bleed_amount or 1)
    
    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
        
        if bullet.tp ~= 0 and bullet:collidesWith(self.soul.graze_collider) and bullet.grazed == false and self.soul.inv_timer == 0 then -- Bullet tp is not 0 and bullet is grazing and bullet is not already been grazed and soul does not have inv time
            
            local graze_heal = bullet.graze_heal or (bullet.attacker.graze_heal or (self.soul.graze_heal or (self.graze_heal or (Game.bleed_graze_heal or 10+Utils.random(0,2,1) )))) -- HELL
            -- It seems that in the original mod, the graze heal is determined by bullet/enemy so uhh set it.

            for _,bleeder in ipairs(bleeders) do
                if not bleed then break end
                if type(bleeder) == "number" then bleeder = self.party[bleeder] end

                if not bleeder.is_down then                

                    bleeder.chara:setHealth( bleeder.chara:getHealth() + graze_heal )

                    if bleeder.chara:getHealth() >= bleeder.chara:getStat("health") then
                        bleeder.chara:setHealth(bleeder.chara:getStat("health"))
                    end

                end
            end
        end
    end

    if self:getState() == "DEFENDING" then
        if self.bleed_timer <= 0 then

            for _,bleeder in ipairs(bleeders) do
                if not bleed then break end
                if type(bleeder) == "number" then bleeder = self.party[bleeder] end
                bleeder:removeHealth(bleed_amount)
            end

            self.bleed_timer = (self.soul:isMoving() and 2 or 4)/30
        end
        self.bleed_timer = self.bleed_timer - DT
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
