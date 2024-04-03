name = "堆叠数量调整/Stack Tweak"
description = ""
author = "瑶光 & C"
version = "1.0.0"
forumthread = ""
api_version = 10
dst_compatible = true
all_clients_require_mod = true 
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"gekko stack"}

local function AddOption(desc, dat, hover)	
	if dat == nil then dat = desc end
	if hover then
		return {description = desc, data = dat, hover = hover}
	else 
		return {description = desc, data = dat}
	end
end

local CommonBoolOptions = 
{
	AddOption("是/Yes",		true,		"启用功能/Enabled"),
	AddOption("否/No",		false,		"禁用功能/Disabled")
}

local CommonNumberOptions999 = 
{
	--这些选项的范围是1～999，包括了 1~20, 2^0~2^9, 10^1-1 ~ 10^3-1,
	--还有 1*10~9*10, 1*25~9*25, 1*30~12*30, 1*45~8*45, 1*50~5*50, 1*100~9*100, 1*250~4*250,
	AddOption(1), AddOption(2), AddOption(3), AddOption(4), AddOption(5),
	AddOption(6), AddOption(7), AddOption(8), AddOption(9), AddOption(10),
	AddOption(11), AddOption(12), AddOption(13), AddOption(14), AddOption(15),
	AddOption(16), AddOption(17), AddOption(18), AddOption(19), AddOption(20),
	AddOption(25), AddOption(30), AddOption(32), AddOption(40), AddOption(45),
	AddOption(50), AddOption(60), AddOption(64), AddOption(70), AddOption(75),
	AddOption(80), AddOption(90), AddOption(99), AddOption(100), AddOption(120),
	AddOption(125), AddOption(128), AddOption(135), AddOption(150), AddOption(175),
	AddOption(180), AddOption(200), AddOption(210), AddOption(225), AddOption(240),
	AddOption(250), AddOption(256), AddOption(270), AddOption(300), AddOption(315),
	AddOption(330), AddOption(360), AddOption(400), AddOption(500), AddOption(512),
	AddOption(600), AddOption(625), AddOption(700), AddOption(750), AddOption(800),
	AddOption(900), AddOption(999)
}

local function AddTitle(title)	--AddTitle("标题")
	return {
		name = "null", 
		label = title, 
		hover = nil, 
		options = {
				{ description = "", data = 0 }
		}, 
		default = 0, 
	}
end

local function AddGeneralSwitch(codename, labelname)	--AddGeneralSwitch("codename", "标签名字")，默认true
	return {
		name = codename,
        label = "总开关/General Switch",
		hover = labelname.."·总开关",
        options = CommonBoolOptions,
        default = true,
	}
end

configuration_options = 
{
    AddTitle("堆叠数量调整/Stack Tweak"),
    AddGeneralSwitch("tweak_enabled", "堆叠数量调整"),
    
    {
		name = "stack_tweak_largeitem",
		label = "大型物品堆叠数/Stack Size For Large Items",
		hover = "默认10",
		options = CommonNumberOptions999,
		default = 999,
	},
	{
		name = "stack_tweak_meditem",
		label = "中型物品堆叠数/Stack Size For Medium Items",
		hover = "默认20",
		options = CommonNumberOptions999,
		default = 999,
	},
	{
		name = "stack_tweak_smallitem",
		label = "小型物品堆叠数/Stack Size For Small Items",
		hover = "默认40",
		options = CommonNumberOptions999,
		default = 999,
	},
	{
		name = "stack_tweak_tinyitem",
		label = "微型物品堆叠数/Stack Size For Tiny Items",
		hover = "默认60",
		options = CommonNumberOptions999,
		default = 999,
	},
	{
		name = "stack_tweak_soul",
		label = "小恶魔最大灵魂数/Wortox's Max Soul",
		hover = "灵魂属于小型物品，默认上限20，超限还是掉一半",
		options = CommonNumberOptions999,
		default = 20,
	},
    AddTitle("可能影响游戏体验的功能/Risky Options")
    {
        name = "ignore_max_stack",
        label = "所有物品无视最大堆叠数/Ignore Max Stack Size",
        hover = "所有可堆叠物品都可以无限堆叠，会影响游戏机制，详见README.txt",
        options = CommonBoolOptions,
        default = false,
    },
}

