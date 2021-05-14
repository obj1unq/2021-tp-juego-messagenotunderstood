import wollok.game.*
import tanque.*

object bala {

	var property seDisparo = false	
	
	method image() { 
		return if (self.seDisparo() && self.dirALaQueApuntaElTanque("arriba")){
			"balaArriba.png"
		}
		else if(self.seDisparo() && self.dirALaQueApuntaElTanque("abajo")) {			
			"balaAbajo.png"
		}
		else if(self.seDisparo() && self.dirALaQueApuntaElTanque("derecha")) {					
			"balaDerecha.png"
		}
		else{
			"balaIzquierda.png"
		}
	}
	
	method position(){
		return if(self.dirALaQueApuntaElTanque("arriba")){		
				game.at(tanque.position().x(), tanque.position().y() + 1)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				game.at(tanque.position().x() , tanque.position().y() - 2)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){
				game.at(tanque.position().x() + 1, tanque.position().y() )
		}
		else {
			game.at(tanque.position().x() - 2, tanque.position().y() )
		}
	}

	method dirALaQueApuntaElTanque(dir){
		return tanque.ultimoMovimiento() == dir
	}	
	
	method avavanzarBala(){
		
	}
}


class Pasto{
	var property position = null
	method image() = "pasto.png"
	
}

class Ladrillo{
	var property position = null
	method image() = "muro.png"
}

class Agua{
	var property position = null
	method image() = "agua.png"
}

