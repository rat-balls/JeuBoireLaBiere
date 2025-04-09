extends Label

var score = 0.0;

func _process(delta):
	score += (float)(10 * delta);
	text = "Score : " + str(floori(score));
