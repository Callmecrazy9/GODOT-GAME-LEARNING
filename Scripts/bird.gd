extends CharacterBody2D;

class_name Bird;

signal game_started;

const flap_force = -300;
const max_speed = 400;
var gravity = 850;
var rotation_speed = 3;
var started = false;
var process_input =true;
#setting up game stuff-------------------------
func jump():
	velocity.y = flap_force
	rotation = deg_to_rad(-30)

#--------------------------
func _ready():
	$AnimatedSprite2D.play("Idle")
	

#-------------------------
func tilt():
	if velocity.y > 0 and rad_to_deg(rotation <90):
		rotation += rotation_speed * rad_to_deg(1)
	elif  velocity.y <0 and rad_to_deg(rotation) > -30:



#----------------
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up") and process_input:
		if !started:
			$AnimatedSprite2D.play("Fly")
			game_started.emit()
			started = true
		jump()
	if started:
		return
		
	velocity.y +=gravity * delta
	
	if velocity.y > max_speed:
		velocity.y = max_speed
		
	move_and_collide(velocity * delta)
	tilt()
