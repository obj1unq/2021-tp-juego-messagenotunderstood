import wollok.game.*


object defensa {
	
	var property vida = 200
	var property destruida = false
	
	method image() = "Exhaust_Fire.png"
	method position () = game.at( (game.width()-1) / 2,0)
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danho()	
		} else {
		//Implementar trigger de fin de juego por perder.
			game.removeVisual(self)
		}
	}
	method validaVida(){
		return vida > 0
	}
	
}
