extends CharacterBody2D

@export var fox_speed = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * fox_speed
	move_and_slide()
