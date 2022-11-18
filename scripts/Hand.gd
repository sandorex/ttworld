extends Node2D

export var card_limit := 16
export(Array, String) var card_decks

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
	var margin := 150 # TODO
	
	var pos = - margin * (count/2)
	
	# if it's odd number of children center one
	if count % 2 == 1:
		print("it's odd!!!")
		return
	
	for node in cards:
		node.card_slot_offset.x = pos
		pos += margin

# shouldnt there be a better way?
func _on_Area2D_mouse_entered():
	self.mouse_inside = true

func _on_Area2D_mouse_exited():
	self.mouse_inside = false
