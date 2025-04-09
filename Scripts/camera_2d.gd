extends Camera2D


const speed = 150;
var spawnTimer = 1.0;
var spawnTimer1 = 0.0;
var spawnTimer2 = 1.5;
var rand = RandomNumberGenerator.new();
var platform: PackedScene;
var beer: Area2D;
var beerProg = -25;

func _ready():
	platform = load("res://Scenes/platform.tscn");
	beer = get_node("Death");

func _process(delta):
	#Scrolls cam to the right
	global_translate(Vector2((float)(speed * delta), 0));

	if (Input.is_action_pressed("ui_down")):
		beerProg = 80;
	else:
		beerProg = -25;
	

	if(spawnTimer <= 0.0):
		var pos = Vector2(position.x + 900, rand.randf_range(-330, -100));
		SpawnPlatform(pos);
		spawnTimer = rand.randf_range(2.5, 4);
	else:
		spawnTimer -= (float)(1 * delta);

	if(spawnTimer1 <= 0.0):
		var pos1 = Vector2(position.x + 900, rand.randf_range(100, 330));
		SpawnPlatform(pos1);
		spawnTimer1 = rand.randf_range(2, 3.5);
	else:
		spawnTimer1 -= (float)(1 * delta);

	if(spawnTimer2 <= 0.0):
		var pos2 = Vector2(position.x + 900, rand.randf_range(-100, 100));
		SpawnPlatform(pos2);
		spawnTimer2 = rand.randf_range(3, 3.5);
	else:
		spawnTimer2 -= (float)(1 * delta);

	beer.translate(Vector2(0, (float)(beerProg * delta)));


func SpawnPlatform(pos: Vector2):
	var instance = platform.instantiate();
	get_parent().add_child(instance);
	(instance as Node2D).position = pos;
