extends Node

signal add_selection_option_requested(key, text, callback)

signal remove_selection_option_requested(key)

enum Item {
	APPLE,
	COFFEE_BEAN,
	COCONUT,
	FIREWOOD
}

const item_display_names := {
	Item.APPLE: "Apple",
	Item.COFFEE_BEAN: "Coffee Bean",
	Item.COCONUT: "Coconut",
	Item.FIREWOOD: "Firewood"
}


func get_item_display_name(item: Item) -> String:
	if item_display_names.has(item):
		return item_display_names[item]
	else:
		return ""


var inventory = {}


func get_inventory(item: Item):
	if item not in inventory:
		return 0
	return inventory[item]

func add_inventory(item: Item, count: int):
	if item not in inventory:
		inventory[item] = count
	else:
		inventory[item] += count
	print(inventory)

func remove_inventory(item: Item, count: int):
	if item in inventory:
		inventory[item] -= count
	print(inventory)
