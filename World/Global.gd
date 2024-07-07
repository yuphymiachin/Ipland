extends Node

signal add_selection_option_requested(key, text, callback)

signal remove_selection_option_requested(key)

enum {
	APPLE,
	COFFEE_BEAN
}

var inventory = {
	"Apple": 0,
	"Coffee Bean": 0,
	"Coconut": 0,
	"Firewood": 0
}

func get_inventory(item):
	return inventory[item]

func add_inventory(item, count):
	inventory[item] += count
	print(inventory)

func remove_inventory(item, count):
	inventory[item] -= count
	print(inventory)
