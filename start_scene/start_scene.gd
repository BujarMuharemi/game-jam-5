extends CanvasLayer

# https://docs.godotengine.org/en/stable/tutorials/io/background_loading.html

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request("res://tutorial_scene/tutorial_scene.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_2_pressed():
	print("start this bitch up")
	var enemy_scene = ResourceLoader.load_threaded_get("res://tutorial_scene/tutorial_scene.tscn")
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	self.queue_free()
