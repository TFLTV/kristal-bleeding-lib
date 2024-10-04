---@class Soul
local Soul, super = Class(Soul)

function Soul:update(...)
    local bullet_grazed = {}
    for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
        table.insert(bullet_grazed, bullet.grazed)
    end

    super.update(self, ...)

    if Game.battle then
        local bleed = (Game.battle.do_bleed or Game.do_bleed) ~= false
        local bleeders = Game.battle.bleeders or (Game.bleeders or {Game.battle.party[1]})
        Object.startCache()
        for _,bullet in ipairs(Game.stage:getObjects(Bullet)) do
            if self.inv_timer == 0 then
                if bullet.tp ~= 0 and bullet:collidesWith(self.graze_collider) then
                    if not bullet_grazed[_] then
                        local graze_heal =
                        bullet.graze_heal or 

                        ((bullet.wave and bullet.wave.graze_heal) or 

                        ((bullet.attacker and bullet.attacker.graze_heal) or 

                        (self.graze_heal or 

                        (Game.battle.graze_heal or 

                        (Game.bleed_graze_heal or 

                        10+Utils.random(0,2,1) ))))) -- HELL
                        -- The lower it is on the list, the less priority it has (Higher values on the list 'overwrite' the lower ones if they exist, the bottom value will always exist).

                        -- It seems that in the original mod, the graze heal is determined by bullet/enemy so uhh set it.

                        for _,bleeder in ipairs(bleeders) do
                            if not bleed then break end
                            if type(bleeder) == "number" then bleeder = Game.battle.party[bleeder] end

                            if not bleeder.is_down then

                                bleeder.chara:setHealth( bleeder.chara:getHealth() + graze_heal )

                                if bleeder.chara:getHealth() >= bleeder.chara:getStat("health") then
                                    bleeder.chara:setHealth(bleeder.chara:getStat("health"))
                                end
                            end
                        end
                    end
                end
            end
        end
        Object.endCache()
    end
end

return Soul
