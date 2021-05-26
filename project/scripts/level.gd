extends Node2D
# ---------------------- EXPORTS ----------------------
export(Array, PackedScene) var flowers
# ---------------------- ONREADY VAR ----------------------
var test_score = 0
onready var basket_position = $TestBasket.position
onready var holes = $Holes.get_children()
# ---------------------- VAR ----------------------

func _ready():
	$HUD.set_flowers_count(test_score)
	generate_flowers()

func _picked_handler():
	test_score = test_score + 1
	$HUD.set_flowers_count(test_score)

func generate_flowers():
	for hole in holes:
		var flower = get_flower().instance()
		flower.position = hole.position
		$Flowers.add_child(flower)
		print(hole.position)
		
func get_flower():
	return flowers[0]
