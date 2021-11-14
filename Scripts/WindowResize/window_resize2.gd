extends Control

onready var parent = $"."
onready var panel = $VBoxContainer/Panel
onready var textedit = $VBoxContainer/TextEdit


onready var resize_area = $ResizeArea
onready var color_rect = $ColorRect
var resize_area_vec2 := Vector2(round(8), round(8))

func _ready() -> void:
	resize_area.rect_min_size = resize_area_vec2
	resize_area.rect_position = textedit.rect_size + textedit.rect_position - (resize_area.rect_min_size / 2)
	color_rect.rect_min_size = resize_area.rect_min_size
	color_rect.rect_position = resize_area.rect_position

func window_resize(event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		textedit.rect_size = get_local_mouse_position() - textedit.rect_position
	if Input.is_action_pressed("click"):
		textedit.rect_size = get_local_mouse_position() - textedit.rect_position
		
		resize_area.rect_position = textedit.rect_size + textedit.rect_position - resize_area.rect_min_size / 2
		
#		DEBUG
		color_rect.rect_position = resize_area.rect_position


func window_drag(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		rect_global_position += update_position(event)

func update_position(event: InputEvent):
	var new_vec2 = event.relative
	return new_vec2

func _on_Panel_tree_entered() -> void:
	var parent = $"."
	var child = parent.get_node("VBoxContainer/Panel")
	if child:
		child.connect('gui_input', self, 'window_drag')
#		print("connected")

func _on_Panel_tree_exited() -> void:
	var child = parent.get_node("VBoxContainer/Panel")
	if child:
		child.disconnect('gui_input', self, 'window_drag')
#		print("disconnected")

func _on_TextEdit_tree_entered() -> void:
	var parent = $"."
	var child = parent.get_node("VBoxContainer/TextEdit")
	if child:
		child.connect('gui_input', self, 'window_drag')
#		print("connected")

func _on_TextEdit_tree_exited() -> void:
	var child = parent.get_node("VBoxContainer/TextEdit")
	if child:
		child.disconnect('gui_input', self, 'window_drag')
#		print("disconnected")



func _on_ResizeArea_tree_entered() -> void:
	var parent = $"."
	var child = parent.get_node("ResizeArea")
	if child:
		child.connect('gui_input', self, 'window_resize')
#		print("connected")

func _on_ResizeArea_tree_exited() -> void:
	var child = parent.get_node("ResizeArea")
	if child:
		child.disconnect('gui_input', self, 'window_resize')
#		print("disconnected")



# DEBUG
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_home"):
		print("panel size is: " + str(panel.rect_size))
		print("textedit size is: " + str(textedit.rect_size))
#		print("resize_area position is: " + str(resize_area.rect_position))
#		print("resize_area size is: " + str(resize_area.rect_size))



