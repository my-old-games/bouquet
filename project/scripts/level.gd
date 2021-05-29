extends Node2D
# ---------------------- EXPORTS ----------------------
export(Array, PackedScene) var flowers
export(int) var time
export(String) var theme
# ---------------------- ONREADY VAR ----------------------
onready var score = 0
onready var basket_position = $HUD.basket_position()
onready var trash_position  = $TestTrash.position
onready var holes = $Holes.get_children()
# ---------------------- VAR ----------------------
var rng = RandomNumberGenerator.new()
var picked = 0
var goals = []
# ---------------------- FUNCTIONS ----------------------
func _ready():
	set_flowers_goals()
	$HUD.set_timer_count(time)
	$HUD.set_theme(theme)
	generate_flowers()

func _picked_handler(tag):
	picked += 1
	match tag:
		"F0":
			if goals[0] > 0: 
				goals[0] -= 1
				$HUD.set_flowers_count(goals[0],tag)
		"F1":
			if goals[1] > 0: 
				goals[1] -= 1
				$HUD.set_flowers_count(goals[1],tag)
		"F2":
			if goals[2] > 0: 
				goals[2] -= 1
				$HUD.set_flowers_count(goals[2],tag)
	print(is_win())

func generate_flowers():
	for hole in holes:
		var flower = get_flower().instance()
		flower.reset_position = hole.position
		$Flowers.add_child(flower)

func get_flower():
	rng.randomize()
	var random_index = rng.randi_range(0, (flowers.size() - 1))
	return flowers[random_index]

func update_basket():
	if  picked > 0  and  picked < 3 :
		$HUD.update_basket('ONE')
	elif picked > 3 and  picked < 5:
		$HUD.update_basket('HALF')
	elif picked > 5:
		$HUD.update_basket('FULL')
	else:
		print("Fail!")

func set_flowers_goals():
	var bouquet  = $Bouquets/Bouquet
	var flowers  = bouquet.get_flowers()
	var quantity = bouquet.get_quantity()
	for i in flowers.size():
		var goal = quantity[i] * bouquet.get_goal()
		$HUD.set_flowers_count(goal, flowers[i])
		goals.append(goal)

func is_win():
	for goal in goals:
		if goal > 0:
			return false
	return true

func _on_Clock_timeout():
	time -= 1
	$HUD.set_timer_count(time)
	if time == 0:
		$Clock.stop()
		print('GAME OVER')
