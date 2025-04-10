extends CanvasLayer

var game: PackedScene;

func _ready():
	game = load("res://Scenes/game.tscn")

func _on_play_button_up():
	print("Here")
	get_tree().change_scene_to_packed(game)


func _on_exit_button_up():
	get_tree().quit()
