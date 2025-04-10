extends CharacterBody2D


const SPEED = 500.0;
const JUMP_VELOCITY = -800.0;

var CoyoteTimer = 0.0;
var JumpInputTimer = 0.0;

var needJump = false;
var jumped = false;

var coyoteAvailable = false;

signal _pause;

@onready var mqtt = $"../../MQTT"
var fakeLvl = 0;

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_up"):
		fakeLvl += (randi() % 3);
		mqtt.publish("jeuboire/beerLvl", str(fakeLvl))
	
	if is_on_floor():
		jumped = false;
	
	if not is_on_floor():
		if(!jumped && coyoteAvailable && CoyoteTimer <= 0.0):
			coyoteAvailable = false;
			CoyoteTimer = 1;
		
		velocity += get_gravity() * delta

	if Input.is_action_pressed("Jump"):
		needJump = true;
		JumpInputTimer = 1;
	
	if (needJump && is_on_floor() || needJump && CoyoteTimer > 0.0):
		jumped = true;
		velocity.y = JUMP_VELOCITY;
		needJump = false;
		CoyoteTimer = 0.0;
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if(CoyoteTimer > 0.0):
			CoyoteTimer -= (float)(5 * delta);
	elif (CoyoteTimer <= 0.0 && is_on_floor()):
		coyoteAvailable = true;

	if(JumpInputTimer > 0.0):
		JumpInputTimer -= (float)(7 * delta);
	elif (JumpInputTimer <= 0.0):
		needJump = false;
