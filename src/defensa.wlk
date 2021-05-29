import wollok.game.*


object defensa {
	
	var property vida = 200
	var property destruida = false
	
	method image() = "baseGit1.png"
	method position () = game.at( (game.width()) / 2,0)
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danio()	
		} else {
		//Implementar trigger de fin de juego por perder.
			game.removeVisual(self)

		}
	}
	method validaVida(){
		return vida > 0
	}
	
}
