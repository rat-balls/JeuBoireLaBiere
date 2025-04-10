extends Sprite2D

var evil = false;
var  i = 0;

var camera_2d: Camera2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	var n = (int)(randi() % 100);
	if(n <= 50):
		evil = true;
	i = (int)(randi() % 2 + 1);
	texture = load("Assets/Sprites/capsule " + str(i) + ".png");
	camera_2d = get_parent().get_parent().get_node("Camera2D");

func _process(delta):
	if(global_position <= camera_2d.global_position + Vector2.LEFT * 1200):
		get_parent().queue_free()

func _on_area_2d_body_entered(body: Node2D):
	if(body.get_groups()[0].contains("Player") && evil):
		texture = load("Assets/Sprites/capsule " + str(i + 2) + ".png");
		await platform_dies();
		
func platform_dies():
	await get_tree().create_timer(0.7).timeout
	get_parent().queue_free()
