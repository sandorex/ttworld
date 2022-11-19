extends Node2D

export var card_limit := 16
export(Array, String) var card_decks
export var card_margin = 150

var mouse_inside = false
var cards = []

func slot_selected(_card: Card):
	return self.mouse_inside

func slot_test(_card: Card):
	# for now accept any kind of card
	return len(cards) < self.card_limit

func slot_card(card: Card):
	cards.append(card)
	reshuffle()

func unslot_card(card: Card):
	cards.erase(card)
	reshuffle()

func reshuffle():
	var count := len(cards)
	var z_index = count
	var pos = -self.card_margin * (count/2)
	
	# TODO: does not seeme exactly centered
	#if count % 2 == 0:
	#	pos += self.card_margin
	
	for node in cards:
		node.card_slot_offset.x = pos
		node.z_index = z_index
		
		pos += self.card_margin / 2
		z_index -= 1

# shouldnt there be a better way?
func _on_Area2D_mouse_entered():
	self.mouse_inside = true

func _on_Area2D_mouse_exited():
	self.mouse_inside = false
