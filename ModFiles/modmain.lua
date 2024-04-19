--rawget
GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})


--tweak
if GetModConfigData("tweak_enabled") then

    TUNING.STACK_SIZE_LARGEITEM = GetModConfigData("stack_tweak_largeitem")
    TUNING.STACK_SIZE_MEDITEM = GetModConfigData("stack_tweak_meditem")
    TUNING.STACK_SIZE_SMALLITEM = GetModConfigData("stack_tweak_smallitem")
    TUNING.STACK_SIZE_TINYITEM = GetModConfigData("stack_tweak_tinyitem")
    TUNING.WORTOX_MAX_SOULS = GetModConfigData("stack_tweak_soul")


    if not GetModConfigData("compatibility_mode_enabled") then
        local stackable_replica = GLOBAL.require("components/stackable_replica")
        stackable_replica._ctor = function(self, inst)
            self.inst = inst
            -- legacy --
            -- self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
            -- self._maxsize = GLOBAL.net_tinybyte(inst.GUID, "stackable._maxsize")
            -- new --
            self._stacksize = net_smallbyte(inst.GUID, "stackable._stacksize", "stacksizedirty")
            self._stacksizeupper = net_smallbyte(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
            self._ignoremaxsize = net_bool(inst.GUID, "stackable._ignoremaxsize")
            self._maxsize = net_tinybyte(inst.GUID, "stackable._maxsize")

            if not TheWorld.ismastersim then
                inst:ListenForEvent("stacksizedirty", OnStackSizeDirty)
            end
        end
    end

    if GetModConfigData("ignore_max_stack") then
        -----这一段是群友 @C 提供的解决方案-----
        AddPrefabPostInitAny(function(inst)
            if TheNet:GetIsServer() then
                if inst.components.stackable then
                    inst.components.stackable:SetIgnoreMaxSize(true)
                end
            end
        end)
        ------------------------------------
    end
end