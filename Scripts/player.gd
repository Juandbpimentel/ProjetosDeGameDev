extends CharacterBody2D
var grav = 10
var speed = 200
var jump_force = 300
var jumping = false
var jumpClick = false
var chave = false 
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


func _process(_delta):
	$CanvasLayer/Coins.text = str(Global.moedasPlayer0)
	if chave == true:
		$CanvasLayer/Key.text = '✅'
	else:
		$CanvasLayer/Key.text = '❌'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	jump_processing()
	movement_and_animation()
	move_and_slide()
	pass




func jump_processing():
	if !is_on_floor():
		velocity.y += grav
		jumping = true
	else:
		jumping = false
		if (Input.is_key_pressed(KEY_SPACE) || Input.is_joy_button_pressed(0,JOY_BUTTON_B) || Input.is_key_pressed(KEY_UP) || Input.is_key_pressed(KEY_W)) && !jumpClick :
			velocity.y -= jump_force
			jumpClick = true
			jumping = true
	if !Input.is_key_pressed(KEY_SPACE) && !Input.is_joy_button_pressed(0,JOY_BUTTON_B) && !Input.is_key_pressed(KEY_UP) && !Input.is_key_pressed(KEY_W) && is_on_floor():
		jumpClick = false




func movement_and_animation():
	if jumping:
		$AnimationPlayer.play("jumping")
		if Input.is_action_pressed('ui_right') || Input.is_key_pressed(KEY_D):
			velocity.x = speed
			$Sprite2D.flip_h = false

		elif Input.is_action_pressed('ui_left') || Input.is_key_pressed(KEY_A):
			velocity.x = -speed
			$Sprite2D.flip_h = true
		else:
			velocity.x = 0
	else:
		if Input.is_action_pressed('ui_right') || Input.is_key_pressed(KEY_D):
			velocity.x = speed
			$Sprite2D.flip_h = false
			$AnimationPlayer.play("walking")

		elif Input.is_action_pressed('ui_left') || Input.is_key_pressed(KEY_A):
			velocity.x = -speed
			$Sprite2D.flip_h = true
			$AnimationPlayer.play("walking")
		else:
			velocity.x = 0
			$AnimationPlayer.play("idle")

#func _input(event):
	#print(event.as_text())
	#if Input.is_joy_button_pressed(0,JOY_BUTTON_A):
	#	print('botão A')