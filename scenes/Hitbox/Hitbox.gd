extends Area2D

onready var collider := $Collider

func enable():
	monitorable = true

func disable():
	monitorable = false
