/*
made by nick dont redistrubte please :)
*/

if SERVER then
	AddCSLuaFile()
end


SWEP.PrintName = "Spawn Creator"
SWEP.Spawnable = true
SWEP.Category = "goober"
SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.NextOutput = CurTime() + 1

SWEP.Spawns = {}

function SWEP:PrimaryAttack()
	if CLIENT then return end
	table.ForceInsert(self.Spawns, self.Owner:GetPos())
end

function SWEP:Reload()
	if CLIENT then return end
	if CurTime() < self.NextOutput then return end
	print("---------------OUTPUT------------------")
	for i,spawn in ipairs(self.Spawns) do
		local v = "Vector(" .. spawn.x .. "," .. spawn.y .. "," .. spawn.z .. ")"
		if !(i == #self.Spawns) then
			v = v .. ","
		end
		print(v)
	end
	print("-------------END OUTPUT----------------")
	self.Owner:ChatPrint("Check Console for Output.")
	self.NextOutput = CurTime() + 1
end