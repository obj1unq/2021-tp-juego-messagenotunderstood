import wollok.game.*

object random {	
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}
	
	method direccionAleatoria(){				
		return ["arriba","izquierda","abajo","derecha"].anyOne()	
	}
}
	

