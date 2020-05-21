require "/scripts/status.lua"

function init()
	if animator then
		self.listener = damageListener("damageTaken", function()
			animator.setAnimationState("shield", "hit")
		end)
	end
	
	local elementaltypes=root.assetJson("/damage/elementaltypes.config")
	local buffer={}
	local resists={}
	
	
	for element,data in pairs(elementaltypes) do
		if data.resistanceStat then
			buffer[data.resistanceStat]=true
		end
	end
	
	table.insert(resists,{stat = "protection", amount = 100.0})
	
	for resist,_ in pairs(buffer) do
		table.insert(resists,{stat = resist, amount = 100.0})
	end
	cultistshieldhandler=effect.addStatModifierGroup(resists)
end

function update(dt)
	if animator then self.listener:update() end
end

function uninit()
	effect.removeStatModifierGroup(cultistshieldhandler)
end