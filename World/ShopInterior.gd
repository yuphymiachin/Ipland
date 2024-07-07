extends StaticBody2D


func _ready():
	pass # Replace with function body.


func _process(delta):
	get_node("AppleNumber").text = "x" + str(Global.get_inventory(Global.Item.APPLE))
	get_node("FirewoodNumber").text = "x" + str(Global.get_inventory(Global.Item.FIREWOOD))
	get_node("CoconutNumber").text = "x" + str(Global.get_inventory(Global.Item.COCONUT))
	get_node("CoffeeBeanNumber").text = "x" + str(Global.get_inventory(Global.Item.COFFEE_BEAN))
