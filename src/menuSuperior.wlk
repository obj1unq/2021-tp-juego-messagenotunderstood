import wollok.game.*
import tanque.*
import enemigos.*
import escenarios.*

object vidaDelHeroe {
	
	const vidas = 3
	
	const property position = game.at(0,12)
	
	method image(){
		 return self.sufijo() + self.vidaDelHeroe() + ".png"
	}
	
	method sufijo(){
		return "VIDA_"
	}
	
	method vidaDelHeroe(){
		return heroe.vida().div(10).roundUp() 
	}
	method impactar(algo){}
}

object leyendaEnemigos{
	method image(){
		return "leyenda_enemigos.png"
	}
	
	method position(){
		return game.at(7,12)
	}
	
	method impactar(algo){}
}

object contadorEnemigos{
	method image(){
		return self.cantidadDeEnemigos().toString() + ".png"
	}
	
	method position(){
		return game.at(11,12)
	}
	
	method cantidadDeEnemigos(){
		return (nivelActual.enemigosADestruirPorNivel() - gestorDeEnemigos.enemigosCaidos()).max(0)
	}
	method impactar(algo){}
}