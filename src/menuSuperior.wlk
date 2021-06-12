import wollok.game.*

object vidaDelHeroe {
	
	const property position = game.at(12,10)
	
	method image(){
		 return "vida.png"
	}
	
	
	
}


object tanques {
	
	const property position = game.at(11,10)
	
	method image(){
		 return "vida.png" // cambiar imagen por un tanque
	}
}
