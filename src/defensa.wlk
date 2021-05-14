import wollok.game.*


object defensa {
	
	const property vida = 100
	var property destruida = false
	
	method image() = "Exhaust_Fire.png"
	
	method position () = game.at( (game.width()-1) / 2,0)
	
}
