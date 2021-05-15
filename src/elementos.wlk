import wollok.game.*
import tanque.*

class Bala {
	// Obligo a pasar la direccion actual del tanque
	const direccion
	// Daño default
	const property danho = 7
	var nombreTick  = [1,2,3,4,5,6,7,8,9,10,11,12,13,15].anyOne().toString()
	var property position = game.origin()
	
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
	
	method position(_posicion, _direccion){
		 if(self.dirALaQueApuntaElTanque("arriba")){		
				position = game.at(tanque.position().x(), tanque.position().y() + 1)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				position = game.at(tanque.position().x() , tanque.position().y() - 1)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){
				position = game.at(tanque.position().x() + 1, tanque.position().y() )
		}
		else {
			position = game.at(tanque.position().x() - 1, tanque.position().y() )
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
		game.addVisual( explocion)
		game.removeTickEvent(nombreTick)
		game.removeVisual(self)
		game.schedule(250, { 
			game.removeVisual( explocion)
		} )
	}

	method validaPosicion(_position){
		return _position.y().between(-1, game.width() - 1) and _position.x().between(-1, game.height() - 2 )
	
	}
	
	method impactar(algo){
		//No hace nada.
	}
	
	method trayectoriaDe(){
		game.addVisual(self)
		game.onTick(1, nombreTick,  {self.desplazar()})
		game.onCollideDo(self, { algo => algo.impactar(self) })
	}
}


class Pasto{
	var property position = null
	var vida = 20
	method image() = "pasto.png"

	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danho()	
		} else {
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}

class Ladrillo{
	var property position
	var property vida = 100 
	
	method image() = "muro.png"
	
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danho()	
		} else {
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}

class Agua{
	var property position = null
	
	method image() = "agua.png"
}

class Explocion {
	var property position
	
	method image() = "explosion-b.png"
	
	method impactar(algo){}
}