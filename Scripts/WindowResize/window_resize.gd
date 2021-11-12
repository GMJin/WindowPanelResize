extends Control

onready var parent = $"."
onready var panel = $Panel
onready var resize_area = $ResizeArea
onready var color_rect = $ColorRect

# hard coding size of the area that will detect and indicate a diagonal window resize
var resize_area_vec2 := Vector2(round(8), round(8))

# setting the position and size of resize_area to the corner of the node we wish to resize
func _ready() -> void:
	resize_area.rect_min_size = resize_area_vec2
	
#		setting the area to stay on the corner of the node we wish to resize
#		subtracting half of resize_area.rect_min_size will center it to the corner of the node
#	resize_area.rect_position = panel.rect_size
	resize_area.rect_position = panel.rect_size - (resize_area.rect_min_size / 2)
	
#	DEBUG
	print("resize_area position is: " + str(resize_area.rect_position))
	
#	DEBUG
#	ColorRect node is unnecessary on project export but is useful for debugging/testing
	color_rect.rect_min_size = resize_area.rect_min_size
	color_rect.rect_position = resize_area.rect_position


func mouse_drag_management(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		panel.rect_size = get_global_mouse_position()
		resize_area.rect_position = panel.rect_size - resize_area.rect_min_size / 2
		
#		DEBUG
		color_rect.rect_position = resize_area.rect_position



func _on_ResizeArea_tree_entered() -> void:
	var parent = $"."
	var child = parent.get_node("ResizeArea")
	if child:
		child.connect('gui_input', self, 'mouse_drag_management')
		print("connected")


func _on_ResizeArea_tree_exited() -> void:
	var child = parent.get_node("ResizeArea")
	if child:
		child.disconnect('gui_input', self, 'mouse_drag_management')
		print("disconnected")


# DEBUG
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_home"):
		print("window/panel size is: " + str(panel.rect_size))
		print("resize_area position is: " + str(resize_area.rect_position))
		print("resize_area size is: " + str(resize_area.rect_size))





