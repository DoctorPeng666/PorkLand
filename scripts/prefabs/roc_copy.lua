---大鹏会被虚空卡主
require "stategraphs/SGroc"

local assets =
{
	Asset("ANIM", "anim/roc_shadow.zip"),
}

local prefabs =
{
	"roc_leg",
	"roc_head",
	"roc_tail",
}

local ROC_SPEED = 20
local ROC_SHADOWRANGE = 8
local ROC_LEGDSIT = 6

local function setstage(inst, stage)
	if stage == 1 then
		inst.Transform:SetScale(0.35, 0.35, 0.35)
		inst.components.locomotor.runspeed = 5
	elseif stage == 2 then
		inst.Transform:SetScale(0.65, 0.65, 0.65)
		inst.components.locomotor.runspeed = 7.5
	else
		inst.Transform:SetScale(1, 1, 1)
		inst.components.locomotor.runspeed = 10
	end
end


local function scalefn(inst, scale)
	inst.components.locomotor.runspeed = ROC_SPEED * scale
end

local function OnRemoved(inst)
	local self = TheWorld.components.rocmanager --为什么可能检测不到呢
	if self then
		self:RemoveRoc(inst)
		self.nexttime = self:GetNextSpawnTime()
	end
end

local function OnEntitySleep(inst)
	local self = inst.components.roccontroller
	print(self.stage, "check entity sleep stage!!!!!!!!!!!")
	inst:DoTaskInTime(1, function(inst) --延迟一下再移除，也是保证重新加载存档时正常执行 (保证self.stage load完毕)
		if self and (self.stage ~= self._stages.finding_object) then
			if self.head then
				self.head:Remove()
				print("removehead!!!")
			end
			if self.tail then
				self.tail:Remove()
				print("remove1!!!")
			end
			if self.leg1 then
				self.leg1:Remove()
				print("remove2!!!")
			end
			if self.leg2 then
				self.leg2:Remove()
				print("remove3!!!")
			end


			inst.bodyparts = nil
			inst:Remove()
		end
	end)
end

local function MakeNoPhysics(inst, mass, rad)
    local physics = inst.entity:AddPhysics()
    physics:SetMass(mass)
    physics:SetCapsule(rad, 1)
    inst.Physics:SetFriction(0)
    inst.Physics:SetDamping(5)
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
end

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local physics = inst.entity:AddPhysics()
	local sound = inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeNoPhysics(inst, 10, 1.5)
	RemovePhysicsColliders(inst)


	inst.Transform:SetScale(1.5, 1.5, 1.5)

	inst:AddTag("roc")
	inst:AddTag("roc_body")
	inst:AddTag("canopytracker")
	inst:AddTag("noteleport")
	inst:AddTag("NOCLICK")

	anim:SetBank("roc")
	anim:SetBuild("roc_shadow")
	anim:PlayAnimation("ground_loop")

	anim:SetOrientation(ANIM_ORIENTATION.OnGround)
	anim:SetLayer(LAYER_WORLD) -----覆盖在人物上层，达到阴影效果
	anim:SetSortOrder(1)

	anim:SetMultColour(1, 1, 1, 0.5)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("colourtweener")
	if not TheWorld.state.isnight and not inst:HasTag("under_leaf_canopy") then
		inst.components.colourtweener:StartTween({ 1, 1, 1, 0.5 }, 3)
	else
		inst.components.colourtweener:StartTween({ 1, 1, 1, 0 }, 3)
	end
	inst:WatchWorldState("isday", function()
		if not inst:HasTag("under_leaf_canopy") then
			inst.components.colourtweener:StartTween({ 1, 1, 1, 0.5 }, 3)
		end
	end)

	inst:WatchWorldState("isnight", function()
		inst.components.colourtweener:StartTween({ 1, 1, 1, 0 }, 3)
	end)

	inst:AddComponent("knownlocations")

	inst:AddComponent("areaaware") --不是area_aware

	inst:ListenForEvent("onremove", OnRemoved)

	inst:ListenForEvent("onchangecanopyzone", function()
		if inst:HasTag("under_leaf_canopy") then
			inst.components.colourtweener:StartTween({ 1, 1, 1, 0 }, 1)
		else
			if not TheWorld.state.isnight then
				inst.components.colourtweener:StartTween({ 1, 1, 1, 0.5 }, 1)
			end
		end
	end, TheWorld)

	inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.runspeed = ROC_SPEED

	inst:AddComponent("roccontroller")
	inst.components.roccontroller:Setup(ROC_SPEED, 0.35, 3)
	inst.components.roccontroller:Start()
	inst.components.roccontroller.scalefn = scalefn



	inst:SetStateGraph("SGroc")

	-- inst:AddComponent("health")
	-- inst.components.health:SetMaxHealth(10000)
	--inst.components.health.poison_damage_scale = 0 -- immune to poison

	-- inst:ListenForEvent("attacked", OnAttacked)
	-- inst:ListenForEvent("onattackother", OnAttackOther)
	inst.setstage = setstage
	inst.OnEntitySleep = OnEntitySleep

	return inst
end

return Prefab("monsters/roc", fn, assets, prefabs)
