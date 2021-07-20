/*
made by nick dont redistrubte please :)
*/

if SERVER then
	AddCSLuaFile()
end


SWEP.PrintName = "Loot Creator"
SWEP.Spawnable = true
SWEP.Category = "goober"
SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.State = 1
SWEP.ModelIndex = 1

SWEP.Models = {
	"models/props_c17/oildrum001.mdl",
	"models/props_c17/FurnitureWashingmachine001a.mdl",
	"models/props_lab/filecabinet02.mdl",
	"models/props_junk/wood_crate002a.mdl",
	"models/props_c17/Lockers001a.mdl",
	"models/props_c17/FurnitureFridge001a.mdl",
	""
}

SWEP.Ents = {}
SWEP.NextOutput = CurTime() + 1

function SWEP:PrimaryAttack()
	if CLIENT then return end
	local ent = ents.Create("prop_physics")
	ent:SetModel(self.Models[self.ModelIndex])
	ent:SetPos(self.Owner:EyePos())
	ent:SetAngles(self.Owner:EyeAngles())
	ent:Spawn()
	table.ForceInsert(self.Ents, ent)
end

function SWEP:Reload()
	if CLIENT then return end
	if (CurTime()<self.NextOutput) then return end
	local o = ""
	local ref = {}
	for _,e in ipairs(self.Ents) do
		if not IsValid(e) then continue end
		table.ForceInsert(ref, {
			["pos"] = e:GetPos(),
			["ang"] = e:GetAngles(),
			["model"] = e:GetModel()
		})
	end
	for _,ent in ipairs(ref) do
		local pos = "Vector("..ent.pos.x..", "..ent.pos.y..", "..ent.pos.z..")"
		local ang = "Angle("..ent.ang.p..", "..ent.ang.y..", "..ent.ang.r..")"
		local output = '{[\"model\"] = "'..ent.model..'", [\"pos\"] = '..pos..', [\"ang\"] = '..ang..'}'				
		//o = o .. output // too long, console cuts it
		print(output)
 	end
	
	self.Owner:ChatPrint("Check Console for Output")
	self.NextOutput = CurTime() + 1
	--SetClipboardText(o)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	local i = self.ModelIndex
	if i+1 > #self.Models then
		self.ModelIndex = 1
		self.Owner:ChatPrint("Model Index: " .. tostring(self.ModelIndex))
		return
	end
	self.ModelIndex = i+1
	self.Owner:ChatPrint("Model Index: " .. tostring(self.ModelIndex))
end