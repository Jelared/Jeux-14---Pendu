extends Control

# Regroupement de bouttons
export(ButtonGroup) var groupe_clavier

#Variables
var lettre_clavier #lettre choisie
var mot #mot à trouver
var mot_separeL = [] #array avec les lettres séparées
var affichage = [] #Array avec les lettres trouvées
var affichage_ = "" #String avec les lettres trouvées
var perdu = 1

#Listes des mots
var list = [
	"apple",
	"turnip",
	"banana",
	"clock",
	"cup",
	"flower",
	"fork",
	"glasses",
	"oranage",
	"pencil",
	"spoon"
	]


func _ready():
	choix_mot()
	separation_mot()
	initialisation()
	bouttons()


#L'appuie sur un bouton envoie un signal 
func bouttons():
	for button in groupe_clavier.get_buttons():
		button.connect("pressed",self,"lettre")

#Le signal : met en mémoire la lettre (en minuscule) affiché sur le bouton et bloque le bouton qui ne peut plus etre utilisé
func lettre():
### lettre au clavier à voir si ajout
	lettre_clavier = groupe_clavier.get_pressed_button().text.to_lower()
	groupe_clavier.get_pressed_button().disabled = true
	print(lettre_clavier)
	test()
	
	
#Choix d'un mot dans une liste  : aléatoire randi(), entre %, 0 et le nombre total de mot dans la liste size()
func choix_mot():
	randomize()
	mot = list[randi()%list.size()]
	print(mot)
	

#Séparation des lettres du mot choisi : boucle for, dans la liste mot, variable lettreM, dans la liste Mot_separeL, append ajoute les lettreM 
func separation_mot():
	for lettreM in mot:
		mot_separeL.append(lettreM)
		print(mot_separeL)
		

#affichage des underscore au départ
func initialisation():
	for i in mot_separeL:
		affichage.append("_ ")
	for i in affichage:
		affichage_ += String(i)
		$Affichage.text = affichage_
		print (affichage)


#test pour la lettre choisie
func test():
	var position_L = mot_separeL.find(lettre_clavier)
	if position_L == -1:
		$Sonno.play()
		print("no")
		print (position_L)
		pendu()
	else :
		while position_L > -1: #boucle pour vérifier s'il existe plusieurs fois la lettre
			$Sonok.play()
			affichage_ = ""
			affichage[position_L] = lettre_clavier #affichage de la lettre à la bonne position
			for i in affichage:
				affichage_ += String(i)
				$Affichage.text = affichage_
			position_L = mot_separeL.find(lettre_clavier,position_L+1) # suite la boucle qui décale la position de 1 pour vérif
			gagner()
			print("ok")
			print (mot_separeL.find(lettre_clavier))
			print (affichage)


#Comptage de perte/Game-Over
func pendu():
	if perdu < 7 :
		$Pendu.frame = perdu
		perdu += 1
	if perdu == 7 :
		$Gameover_Win.text = "Game Over"
		Brejouer()


#Affichage gagner
func gagner():
	var a = mot_separeL
	print("g")
	var b = affichage
	if a==b :
		$Gameover_Win.text = "Gagner"
		Brejouer()


#Bouton de relance du jeux
func Brejouer():
	$HBoxContainer.visible = false #dispartion des boutons des lettres
	var buttonR = Button.new()
	buttonR.text = "Rejouer"
	buttonR.connect("pressed", self, "rejouer")
	add_child(buttonR)
	
#Relance du jeux
func rejouer():
	get_tree()
