extends CardSlot

export var card_limit := 16
export(Array, String) var card_decks

var mouse_inside = false
var cards = []
var positions = []

func slot_selected(_card: Card):
	return self.mouse_inside

func slot_test(_card: Card):
	# for now accept any kind of card
	return len(cards) <= self.card_limit

func slot_card(card: Card):
	var pos = self.create_position()
	card.slot_position = pos
	self.cards.append(card)
	self.positions.append(pos)
	self.add_child(pos)

func unslot_card(card: Card):
	var index = self.cards.find(card)
	self.cards.remove(index)
	self.positions.remove(index)

func create_position():
	var pos = Position2D.new()
	pos.position = Vector2(100 + randi() % 300, -300)
	return pos

# shouldnt there be a better way?
func _on_Area2D_mouse_entered():
	self.mouse_inside = true

func _on_Area2D_mouse_exited():
	self.mouse_inside = false
