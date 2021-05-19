import wollok.game.*
import tanque.*
import enemigos.*
import random.*

class Bala {
	
	const direccion
	const property danho = 7
	const tanqueActual = tanque 
	//const nombreTick  = [1,2,3,4,5,6,7,8,9,10,11,12,13,15].anyOne().toString()
	
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
	
	method ubicarPosicion(){
		 if(self.dirALaQueApuntaElTanque("arriba")){		
				position = game.at(tanqueActual.position().x(), tanqueActual.position().y() + 0.4)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				position = game.at(tanqueActual.position().x() , tanqueActual.position().y() - 0.4)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){
				position = game.at(tanqueActual.position().x() + 0.4, tanqueActual.position().y() )
		}
		else {
			position = game.at(tanqueActual.position().x() - 0.4, tanqueActual.position().y()
			)
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
		game.removeTickEvent("DISPARO"+ self.identity())
		game.removeVisual(self)
		game.schedule(250, { 
		game.removeVisual( explocion)
		} )
	}

	method validaPosicion(_position){
		return _position.y().between(0, game.width() ) and _position.x().between(0, game.height() )
	
	}
	
	method impactar(algo){
		// No hace nada.
	}
	
	method detonar(){
		self.ubicarPosicion()
		game.addVisual(self)
		game.onTick(1, "DISPARO" + self.identity(), {self.desplazar()})
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
	
	method image() = "explosion1.png"
	
	method impactar(algo){}
}

object defensa {
	
	var property vida = 200
	
	method image() = "baseGit1.png"
	method position () = game.at( (game.width()) / 2,0)
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

object gestorDeEnemigos{
	const property enemigosEnMapa = []

	method agregarEnemigos() {
		if (self.enemigosEnMapa().size() <= 2 ) {
			self.agregarNuevaEnemigo()
			//self.enemigosEnMapa().forEach({tanqueEnemigo => tanqueEnemigo.moverDisparandoAleatorio() })
		}		
	}
	
	method agregarNuevaEnemigo(){
		const enemigosPosibles = [
			new EnemigoLeopard(position =  random.emptyPosition(), shotTime = 3000 , timeMove = 4000),
			new EnemigoLeopard(position =  random.emptyPosition(), shotTime = 2500,  timeMove = 3000 )		
		]
		const nuevoEnemigo = enemigosPosibles.anyOne()
		nuevoEnemigo.moverDisparandoAleatorio() 
		self.agregarElemento(nuevoEnemigo)
	}
	
	method agregarElemento(enemigo){
		enemigosEnMapa.add(enemigo)	 
		game.addVisual(enemigo)
		
	}
	
	method removerElemento(enemigo) {
		enemigosEnMapa.remove(enemigo)
		game.removeVisual(enemigo) 
	}
}

