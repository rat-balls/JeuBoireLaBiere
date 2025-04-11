extends Control

@onready var mqtt:  = $MQTT

signal beerLevel(amount)
signal lift()
signal putback()

func _ready():
	mqtt.set_user_pass("pluton3", "nabil")
	mqtt.set_last_will("jeuboire/status", "game_connection")
	mqtt.connect_to_broker("wss://mqtt.noufele.fr:443")

func _on_mqtt_received_message(topic, message):
	if(topic == "jeuboire/beerLvl"):
		beerLevel.emit(message.to_float())
	elif(topic == "jeuboire/pump"):
		if(message == "lift"):
			lift.emit()
		if(message == "putback"):
			putback.emit()

func _on_mqtt_broker_connected():
	mqtt.subscribe("jeuboire/beerLvl")
	mqtt.subscribe("jeuboire/pump")
	mqtt.publish("jeuboire/pump", "unpause")
