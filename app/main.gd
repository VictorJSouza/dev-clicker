extends Node2D

# Variáveis principais do jogo
var codigo_total: int = 0
var codigo_por_clique: int = 1
var codigo_por_segundo: int = 0

# Referências aos elementos da cena
@onready var label_codigo = $CanvasLayer/LabelCodigo
@onready var botao_click = $CanvasLayer/BotaoClick
@onready var timer_auto_codigo = $Timer

func _ready() -> void:
	atualizar_interface()
	timer_auto_codigo.wait_time = 1.0
	timer_auto_codigo.start()

func _on_botao_click_pressed() -> void:
	codigo_total += codigo_por_clique
	atualizar_interface()

func _on_Timer_timeout() -> void:
	codigo_total += codigo_por_segundo
	atualizar_interface()

func atualizar_interface():
	label_codigo.text = "Código: %d" % codigo_total

# Upgrades simples (por enquanto você pode chamá-los manualmente no script)
func comprar_upgrade_clique():
	var custo = 50
	if codigo_total >= custo:
		codigo_total -= custo
		codigo_por_clique += 1
		atualizar_interface()

func comprar_upgrade_automatico():
	var custo = 100
	if codigo_total >= custo:
		codigo_total -= custo
		codigo_por_segundo += 1
		atualizar_interface()


func _on_botao_upgrade_pressed(quantidadeCompra: int) -> void:
	if codigo_total >= quantidadeCompra:
		codigo_total -= quantidadeCompra
		atualizar_interface()
		while true:
			codigo_total += 1 * quantidadeCompra
			await get_tree().create_timer(3.0).timeout
			atualizar_interface()
