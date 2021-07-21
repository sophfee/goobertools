/*
made by nick dont redistrubte please :)
*/

if SERVER then
	AddCSLuaFile()
end


SWEP.PrintName = "Vehicle Spawn Creator"
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
	table.ForceInsert(self.Spawns, {
		["pos"] = self.Owner:GetPos(),
		["ang"] = Angle(0,self.Owner:EyeAngles().y,0)
	})
end

function SWEP:Reload()
	if CLIENT then return end
	if CurTime() < self.NextOutput then return end
	print("---------------OUTPUT------------------")
	for i,spawn in ipairs(self.Spawns) do
		local v = "{[\"pos\"]=Vector(" .. spawn.pos.x .. "," .. spawn.pos.y .. "," .. spawn.pos.z .. "),[\"ang\"]=Angle(0," .. spawn.ang.y .. ", 0)}"
		if !(i == #self.Spawns) then
			v = v .. ","
		end
		print(v)
	end
	print("-------------END OUTPUT----------------")
	self.Owner:ChatPrint("Check Console for Output.")
	self.NextOutput = CurTime() + 1
end