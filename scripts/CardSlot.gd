extends Node2D
class_name CardSlot

func _ready():
	pass

# test if coliding the slot area
func slot_selected(_card: Card):
	return false

func slot_test(_card: Card):
	return false

func slot_card(_card: Card):
	pass

func unslot_card(_card: Card):
	pass
