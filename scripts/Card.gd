extends Node2D
class_name Card

export var follow_speed := 20
export(bool) var flippable := true
export(String) var card_id
export(String) var card_deck

var parent: Node2D = null
var slot_position: Node2D = null

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.pressed and Globals.dragged_node == self:
			Globals.dragged_node = null
			get_tree().set_input_as_handled()
			
			# did not leave original slot area
			if self.parent != null and self.parent.slot_selected(self):
				return
			
			for slot in get_tree().get_nodes_in_group("cardslot"):
				if slot.slot_selected(self) and slot.slot_test(self):
					if self.parent != null:
						self.parent.unslot_card(self)
						self.parent = null
					
					self.parent = slot
					self.slot_position = slot
					slot.slot_card(self)
					return
			
			if self.parent != null:
				self.parent.unslot_card(self)
				self.parent = null
			
			self.slot_position = null

func _physics_process(delta):
	if Globals.dragged_node == self:
		global_position = lerp(global_position, get_global_mouse_position(), self.follow_speed * delta)
	else:
		if self.slot_position != null:
			# return home if it is not null
			global_position = lerp(global_position, self.slot_position.global_position, self.follow_speed * delta)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			Globals.dragged_node = self
			
			get_tree().set_input_as_handled()
