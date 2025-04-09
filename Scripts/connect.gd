extends Control

@onready var mqtt:  = $MQTT

func _ready():
	mqtt.set_user_pass("pluton3", "nabil")
	mqtt.set_last_will("jeuboire/test", "connection")
	mqtt.connect_to_broker("wss://mqtt.noufele.fr:443")

func _on_mqtt_received_message(topic, message):
	print("Topic: " + topic)
	print("MSG: " + message)

func _on_mqtt_broker_connected():
	mqtt.subscribe("jeuboire/test")
	mqtt.publish("jeuboire/test", "test")
