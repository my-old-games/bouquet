extends Node2D
# ---------------------- EXPORTS ----------------------
export(Array, PackedScene) var flowers
export(PackedScene) var next_level
export(int)    var time
export(bool)   var time_mode
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
	$HTTPRequest.request("https://api.deezer.com/track/3135556")
	generate_flowers()
	$HUD.set_timer_count(time)
	$HUD.set_theme(theme)
	if time_mode:
		set_flowers_goals()
	else:
		$HUD.hide_goals()


func _picked_handler(tag):
	picked += 1
	if time_mode: 
		if check_goals(tag):
			$HUD.showModal(true)
	else:
		time += 3

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
	var bouquet   = $Bouquets/Bouquet
	var bflowers  = bouquet.get_flowers()
	var quantity  = bouquet.get_quantity()
	for i in bflowers.size():
		var goal = quantity[i] * bouquet.get_goal()
		$HUD.set_flowers_count(goal, bflowers[i])
		goals.append(goal)

func check_goals(tag):
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
	return is_win()

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
		if time_mode: 
			if !is_win():
				$HUD.showModal(false)
		else:
			$HUD.showModal(true)


func _on_Music_finished():
	if !time_mode: 
		$HUD.showModal(true)


func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	$HTTPRequest2.request(json.result.preview)
	


func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	var mp3_stream  = AudioStreamMP3.new()
	mp3_stream.data = body
	$Music.set_stream(mp3_stream)
	$Music.play()
