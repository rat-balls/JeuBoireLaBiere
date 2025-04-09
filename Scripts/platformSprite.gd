extends Sprite2D

var evil = false;
var  i = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	var n = (int)(randi() % 100);
	if(n <= 50):
		evil = true;
	i = (int)(randi() % 2 + 1);
	texture = load("Assets/Sprites/capsule " + str(i) + ".png");

func _on_area_2d_body_entered(body: Node2D):
	if(body.get_groups()[0].contains("Player") && evil):
		texture = load("Assets/Sprites/capsule " + str(i + 2) + ".png");
		await platform_dies();
		
func platform_dies():
	await get_tree().create_timer(0.7).timeout
	get_parent().queue_free()
