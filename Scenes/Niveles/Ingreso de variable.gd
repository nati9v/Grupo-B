extends Label

func _ready():
	CorpseManager.corpse_count_changed.connect(_update_label)
	_update_label(CorpseManager.corpses.size())

func _update_label(count):
	text = str(count)
