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

# Define required quantities for new visitor
const REQUIRED_APPLES = 2
const REQUIRED_COFFEE_BEANS = 1
const REQUIRED_COCONUTS = 2
const REQUIRED_FIREWOOD = 3

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

var visitor_count = 0
var new_visitor_count = 0

func update_new_visitor_count():
	# Define required quantities for new visitor
	const REQUIRED_APPLES = 2
	const REQUIRED_COFFEE_BEANS = 1
	const REQUIRED_COCONUTS = 2
	const REQUIRED_FIREWOOD = 3
	
	# Check current inventory
	var apples = get_inventory(Item.APPLE)
	var coffee_beans = get_inventory(Item.COFFEE_BEAN)
	var coconuts = get_inventory(Item.COCONUT)
	var firewood = get_inventory(Item.FIREWOOD)
	
	# Calculate possible visitors based on each item type
	var visitors_from_apples = apples / REQUIRED_APPLES
	var visitors_from_coffee_beans = coffee_beans / REQUIRED_COFFEE_BEANS
	var visitors_from_coconuts = coconuts / REQUIRED_COCONUTS
	var visitors_from_firewood = firewood / REQUIRED_FIREWOOD
	
	# Find the minimum number of visitors possible based on inventory
	var possible_visitors = min(visitors_from_apples, visitors_from_coffee_beans, visitors_from_coconuts, visitors_from_firewood)
	
	# Update new visitor count
	new_visitor_count += possible_visitors
	
	print("New visitor count updated. Total new visitors: %d" % new_visitor_count)

# Define how many new visitors can come to the island
func get_new_visitor_count():
	return new_visitor_count


func report_new_visitors(count):
	visitor_count += count
	new_visitor_count -= count
	for i in range(count):
		remove_inventory(Item.APPLE, REQUIRED_APPLES)
		remove_inventory(Item.COFFEE_BEAN, REQUIRED_COFFEE_BEANS)
		remove_inventory(Item.COCONUT, REQUIRED_COCONUTS)
		remove_inventory(Item.FIREWOOD, REQUIRED_FIREWOOD)
	print(inventory)
