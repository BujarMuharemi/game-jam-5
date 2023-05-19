extends CPUParticles2D

var has_exploded=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!self.is_emitting()):
		has_exploded=true
		#self.queue_free()
