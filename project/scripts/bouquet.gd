extends Node2D
# ---------------------- EXPORTS ----------------------
export var bouquet = {
	"flowers": [],
	"quantity": [],
	"pattern": [],
	"goal": 1
}
# ---------------------- FUNCTIONS ----------------------
func get_goal():
	return bouquet.goal

func get_pattern():
	return bouquet.pattern

func get_quantity():
	return bouquet.quantity

func get_flowers():
	return bouquet.flowers
