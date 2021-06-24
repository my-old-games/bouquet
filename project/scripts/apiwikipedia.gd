extends Node2D
# ---------------------- SIGNALS -----------------------
signal got_song
# ---------------------- FUNCTIONS ---------------------
func getSong(url):
	$GetSong.request(url)
# ---------------------- HANDLERS ----------------------
func _on_GetSong_request_completed(result, response_code, headers, body):
	if response_code == 200:
		emit_signal("got_song",body)
