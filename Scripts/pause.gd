extends Control

var PauseScreen: ColorRect;

func _ready():
	PauseScreen = get_parent().get_parent().get_node("HUD/UI/PauseScreen");

func _process(delta):
	if(Input.is_action_just_pressed("Pause")):
		PauseGame();

func PauseGame():
	var paused = !get_tree().paused;
	get_tree().paused = paused;
	PauseScreen.visible = paused;


func _on_death_body_entered(body: Node2D):
	if(body.get_groups()[0].contains("Player")):
		PauseGame();
		PauseScreen.get_node("DrinkingProgress").text = "YOU DROWNED.";
		PauseScreen.get_node("Restart").visible = true;
		PauseScreen.get_node("Menu").visible = true;


func _on_restart_button_up():
	get_tree().call_deferred("reload_current_scene");
	PauseGame();


func _on_menu_button_up():
	#TODO
	pass
