extends Panel

const DEFAULT_PORT = 8910 # An arbitrary number.

onready var lobby_message = $LobbyMessage
onready var lobby_address = $LobbyAddress
onready var lobby_server_btn = $CreateServerBtn
onready var lobby_join_btn = $JoinServerBtn
onready var lobby_player_name = $LobbyPlayerName

var player_info = {}

var my_info = {
	'name' : "test_player"
}

func _ready():
	# Here you have all callback based on network signal (reroute to internal function)
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

# Player connected function
func _player_connected(_id):
	print("Player enter in lobby id : "+str(_id))
	rpc_id(_id, "register_player", my_info)

func _player_disconnected(_id):
	print("Player disconected id : "+str(_id))
	
func _connected_ok():
	print("Connexion ok")

func _connected_fail():
	print("connection failed")

func _server_disconnected():
	print("serveur disconnected")


func _on_CreateServerBtn_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	var err = host.create_server(DEFAULT_PORT, 1)
	if err != OK:
		lobby_message.set_text("Can't host, address in use.")
		return
	
	get_tree().set_network_peer(host)
	lobby_message.set_text("Waiting")
	lobby_server_btn.disabled = true
	
func _on_JoinServerBtn_pressed():
	var ip = lobby_address.get_text()
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
	lobby_message.set_text("Connecting to server : "+ip)
	
# Global function for all client connected (register new user)
remote func register_player(info):
	info['name'] = lobby_player_name.get_text()
	var id = get_tree().get_rpc_sender_id()
	player_info[id] = info
	print(player_info)
