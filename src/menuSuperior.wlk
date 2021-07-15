import wollok.game.*
import tanque.*
import enemigos.*
import escenarios.*
import elementos.*

object barraDeVida inherits Elemento {

	override method position() { 
		return game.at(0,12)
	}
	
	method image(){
		 return self.sufijo() + self.vidaDelHeroe() + ".png"
	}
	
	method sufijo(){
		return "VIDA_"
	}
	
	method vidaDelHeroe(){
		return heroe.vida().div(10).roundUp() 
	}
}

object contadorDeVida inherits Elemento {
	
	override method position() {
		return game.at(3,12)
	}	
	
	method image(){
		return self.sufijo() + self.cantVidasDelHeroe() + ".png"
	}
	
	method sufijo(){
		return "CORAZON_"
	}
	
	method cantVidasDelHeroe(){
		return heroe.cantidadDeVidas()
	}
}

object leyendaEnemigos inherits Elemento {
	
	method image(){
		return "leyenda_enemigos.png"
	}
	
	override method position(){
		return game.at(7,12)
	}
	
}

object contadorEnemigos inherits Elemento {
	
	method image(){
		return self.cantidadDeEnemigos().toString() + ".png"
	}
	
	override method position(){
		return game.at(11,12)
	}
	
	method cantidadDeEnemigos(){
		return (nivelActual.enemigosADestruirPorNivel() - gestorDeEnemigos.enemigosCaidos()).max(0)
	}
	
}