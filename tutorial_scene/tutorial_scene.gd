extends Control


func _ready():
	ResourceLoader.load_threaded_request("res://main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("start this bitch up")
	var enemy_scene = ResourceLoader.load_threaded_get("res://main.tscn")
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	self.queue_free()

