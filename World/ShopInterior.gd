extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("AppleNumber").text = "x" + str(Global.get_inventory("Apple"))
	get_node("FirewoodNumber").text = "x" + str(Global.get_inventory("Firewood"))
	get_node("CoconutNumber").text = "x" + str(Global.get_inventory("Coconut"))
	get_node("CoffeeBeanNumber").text = "x" + str(Global.get_inventory("Coffee Bean"))
