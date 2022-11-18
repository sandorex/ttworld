extends Node2D
class_name Card

const SLOT_GROUP = "cardslot"

export var follow_speed = 20
export(bool) var flipped = false
export(String) var card_id
export(String) var card_deck
export(NodePath) var card_slot_path

onready var card_slot = find_node(card_slot_path, true, false)
var card_slot_offset: Vector2 = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		# on release if holding this card
		if not event.pressed and Globals.dragged_node == self:
			Globals.dragged_node = null
			get_tree().set_input_as_handled()
			
			# did not leave original slot area
			if self.card_slot != null and self.card_slot.slot_selected(self):
				return
			
			# find card slot that is below
			for slot in get_tree().get_nodes_in_group(SLOT_GROUP):
				if slot.slot_selected(self) and slot.slot_test(self):
					if self.card_slot != null:
						self.card_slot.unslot_card(self)
					
					self.card_slot = slot
					self.card_slot_offset = Vector2.ZERO
					if slot.has_method("slot_card"):
						slot.slot_card(self)
					return
			
			if self.card_slot != null:
				self.card_slot.unslot_card(self)
				self.card_slot = null
				self.card_slot_offset = Vector2.ZERO

func _physics_process(delta):
	if Globals.dragged_node == self:
		global_position = lerp(global_position, get_global_mouse_position(), self.follow_speed * delta)
	else:
		# return home if it is not orphan
		if self.card_slot != null:
			global_position = lerp(global_position,
								   self.card_slot.global_position + self.card_slot_offset,
								   self.follow_speed * delta)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			Globals.dragged_node = self
			
			get_tree().set_input_as_handled()
