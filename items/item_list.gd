class_name GameItemList
extends Node

@export var items : Array[Item]

func get_item_by_name(item_name : String) -> Item:
	for item in items:
		if item.name == item_name:
			return item
	return null
	
