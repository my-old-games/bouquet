extends Node2D
# ---------------------- EXPORTS ----------------------
export(Array, PackedScene) var flowers
export(int) var time
# ---------------------- ONREADY VAR ----------------------
var test_score = 0
onready var basket_position = $TestBasket.position
onready var trash_position  = $TestTrash.position
onready var holes = $Holes.get_children()
# ---------------------- VAR ----------------------

func _ready():
	$HUD.set_flowers_count(test_score)
	$HUD.set_timer_count(time)
	generate_flowers()

func _picked_handler():
	test_score += 1
	$HUD.set_flowers_count(test_score)

func generate_flowers():
	for hole in holes:
		var flower = get_flower().instance()
		flower.position = hole.position
		$Flowers.add_child(flower)

func get_flower():
	return flowers[0]


func _on_Clock_timeout():
	time -= 1
	$HUD.set_timer_count(time)
	if time == 0:
		$Clock.stop()
		print('GAME OVER')
