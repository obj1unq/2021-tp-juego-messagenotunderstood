import wollok.game.*
import tanque.*
import enemigos.*
import escenarios.*

object barraDeVida {

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

object contadorDeVida{
	method position() {
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

//object textoVida{
//	method position(){
//		return game.at(3,12)
//	}
//	
//	method image(){
//		return "TEXTO_VIDA.png"
//	}
//}

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