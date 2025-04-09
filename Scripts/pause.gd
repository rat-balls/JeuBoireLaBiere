extends Control

var PauseScreen: ColorRect;

@onready var mqtt = $"../../MQTT"

func _ready():
	PauseScreen = get_parent().get_parent().get_node("HUD/UI/PauseScreen");

func PauseGame():
	var paused = !get_tree().paused;
	get_tree().paused = paused;
	PauseScreen.visible = paused;
	mqtt.publish("jeuboire/pump", "pause")

func _on_death_body_entered(body: Node2D):
	if(body.get_groups()[0].contains("Player")):
		PauseGame();
		PauseScreen.get_node("DrinkingProgress").text = "YOU DROWNED.";
		PauseScreen.get_node("Restart").visible = true;
		PauseScreen.get_node("Menu").visible = true;
		mqtt.publish("jeuboire/pump", "death")


func _on_restart_button_up():
	get_tree().call_deferred("reload_current_scene");
	PauseGame();


func _on_menu_button_up():
	#TODO
	pass


func _on_control_pause():
	PauseGame()
