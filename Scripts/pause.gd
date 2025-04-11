extends Control

var PauseScreen: ColorRect;

@onready var mqtt = $"../../MQTT"
var menu: PackedScene; 

func _ready():
	menu = load("res://Scenes/menu.tscn")
	PauseScreen = get_parent().get_parent().get_node("HUD/UI/PauseScreen");

func _process(delta):
	if(get_tree().paused == true && Input.is_action_just_pressed("Restart")):
		Restart()

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
	Restart()

func Restart():
	get_tree().call_deferred("reload_current_scene");
	PauseGame();

func _on_menu_button_up():
	PauseGame();
	get_tree().change_scene_to_packed(menu)

func _on_control_pause():
	PauseGame()
