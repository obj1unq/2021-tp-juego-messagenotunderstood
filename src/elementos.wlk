import wollok.game.*
import tanque.*

class Bala {
	//var property seDisparo = false	
	
	var property position 
	
	const posicionTanque
	
	//obligo a pasar la dir del tanque
	const direccion
	
	//Evaluar si nos puede servir
	const danho = 7
	
	method image() { 
		return if (self.dirALaQueApuntaElTanque("arriba")){
			"bala-up.png"
		}
		else if(self.dirALaQueApuntaElTanque("abajo")) {			
			"bala-dw.png"
		}
		else if(self.dirALaQueApuntaElTanque("derecha")) {					
			"bala-rh.png"
		}
		else{
			"bala-lf.png"
		}
	}
	
	//Revisar como podemos re implementar el mensaje position para que no devuelva siempre la misma posición
	method positionOrigen(){
		 if(self.dirALaQueApuntaElTanque("arriba")){		
				position = game.at(tanque.position().x(), tanque.position().y() + 2)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				position = game.at(tanque.position().x() , tanque.position().y() - 2)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){
				position = game.at(tanque.position().x() + 2, tanque.position().y() )
		}
		else {
			position = game.at(tanque.position().x() - 2, tanque.position().y() )
		}
	}
	
	method dirALaQueApuntaElTanque(dir){
		return direccion == dir
	}	
	
	method desplazar(){

		if (self.dirALaQueApuntaElTanque("arriba") and self.validaPosicion(position.up(1))){
			position = position.up(1) 
		} else if (self.dirALaQueApuntaElTanque("abajo") and self.validaPosicion(position.down(1))) {
			position = position.down(1)
		} else if (self.dirALaQueApuntaElTanque("derecha") and self.validaPosicion(position.right(1))) {
			position = position.right(1)
		} else if ( self.dirALaQueApuntaElTanque("izquierda")and self.validaPosicion(position.left(1))){
			position = position.left(1)
		} else {
			self.explotar()
		}
	}
	
	method explotar(){
		const explocion = new Explocion(position = position)
		//game.removeVisual(self)
		game.addVisual( explocion)
		//game.removeVisual(explocion
		game.removeTickEvent("Trayectoria")
		game.removeVisual(self)
		game.schedule(500, { 
			game.removeVisual( explocion)
			//game.removeVisual(explocion)
		} )
	}
	
	method validaPosicion(_position){
		return (_position.y().between(-1, game.width() - 1) and _position.x().between(-1, game.height() - 2 ))
	}
	
	method avanzar(){
		//position += self.dirADesplazar() 
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

class Explocion {
	var property position
	method image() = "explosion-b.png"
}