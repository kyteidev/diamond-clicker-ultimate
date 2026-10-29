extends VBoxContainer

const ITEM_SCENE = preload("res://scenes/shop_item.tscn")

var um := UpgradesManager


func _ready() -> void:
	# set up shop items
	var item: ShopItem = ITEM_SCENE.instantiate()
	for upgrade in um.UPGRADES:
		var data = ShopItemData.new()
		data.name = upgrade.name
		data.cost = upgrade.cost
		data.count = 0
		data.dps = upgrade.dps

		add_child(item)
		item.setup(data)
