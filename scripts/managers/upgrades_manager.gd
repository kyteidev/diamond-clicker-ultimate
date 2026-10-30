extends Node

enum BoostTypes {
	MULT,
	PICK_MULT,
	COST,
	DIAMONDS,
	INSURANCE,
	HUNGER,
}

enum BoostRarities {
	COMMON,
	RARE,
	LEGENDARY,
}

const RARITY_CHANCES = {
	BoostRarities.COMMON: 0.55,
	BoostRarities.RARE: 0.30,
	BoostRarities.LEGENDARY: 0.15,
}

const COMMON_BOOSTS = [
	{
		"name": "Efficiency",
		"icon": Rect2(176.0, 128.0, 16.0, 16.0),
		"type": BoostTypes.PICK_MULT,
		"amount": 2.0,
		"caveat": null,
	},
	{
		"name": "Fortune",
		"icon": Rect2(80.0, 160.0, 16.0, 16.0),
		"type": BoostTypes.MULT,
		"amount": 1.5,
		"caveat": null,
	},
	{
		"name": "Tax Relief",
		"icon": Rect2(144.0, 160.0, 16.0, 16.0),
		"type": BoostTypes.COST,
		"amount": 0.95,
		"caveat": null,
	},
	{
		"name": "Time Warp",
		"icon": Rect2(160.0, 160.0, 16.0, 16.0),
		"type": BoostTypes.DIAMONDS,
		"amount": 0.5,
		"caveat": null,
	},
]

const RARE_BOOSTS = [
	{
		"name": "Automation",
		"icon": Rect2(96.0, 256.0, 16.0, 16.0),
		"type": BoostTypes.MULT,
		"amount": 2.5,
		"caveat": BoostTypes.PICK_MULT,
		"caveat_amount": 0.5,
	},
	{
		"name": "Click Addict",
		"icon": Rect2(144.0, 256.0, 16.0, 16.0),
		"type": BoostTypes.PICK_MULT,
		"amount": 3.0,
		"caveat": BoostTypes.MULT,
		"caveat_amount": 0.65,
	},
	{
		"name": "Jackpot",
		"icon": Rect2(160.0, 320.0, 16.0, 16.0),
		"type": BoostTypes.DIAMONDS,
		"amount": 1.0,
		"caveat": null,
	},
	{
		"name": "Endurance",
		"icon": Rect2(112.0, 320.0, 16.0, 16.0),
		"type": BoostTypes.HUNGER,
		"amount": 1.20,
		"caveat": null,
	},
]

const LEGENDARY_BOOSTS = [
	{
		"name": "Investment",
		"icon": Rect2(224.0, 336.0, 16.0, 16.0),
		"type": BoostTypes.MULT,
		"amount": 4.0,
		"caveat": BoostTypes.COST,
		"caveat_amount": 2.5,
	},
	{
		"name": "Insurance",
		"icon": Rect2(0.0, 384.0, 16.0, 16.0),
		"type": BoostTypes.INSURANCE,
		"amount": 1.0,
		"caveat": null,
	},
]

const UPGRADES = [
	{ "name": "Auto Pickaxe", "cost": 50.0, "dps": 1 },
	{ "name": "TNT", "cost": 300.0, "dps": 3 },
	{ "name": "Golem", "cost": 800.0, "dps": 5 },
	{ "name": "Farm", "cost": 2200.0, "dps": 10 },
	{ "name": "Laboratory", "cost": 5000.0, "dps": 15 },
	{ "name": "Bank", "cost": 12000.0, "dps": 25 },
	{ "name": "Monopoly", "cost": 50000.0, "dps": 60 },
	{ "name": "Portal", "cost": 200000.0, "dps": 250 },
	{ "name": "Farlands", "cost": 800000.0, "dps": 550 },
	{ "name": "4D", "cost": 1500000.0, "dps": 1200 },
	{ "name": "Creative Mode", "cost": 7000000.0, "dps": 4000 },
	{ "name": "Cheats", "cost": 25000000.0, "dps": 10000 },
	{ "name": "The End?", "cost": 200000000.0, "dps": 30000 },
]

const COST_MULT = 1.15
