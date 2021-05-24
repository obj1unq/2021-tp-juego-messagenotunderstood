import wollok.game.*
import tanque.*
import enemigos.*
import random.*

class Bala {
	
	const direccion
	const property danio = 7
	const tanqueActual = tanque 
	
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
		
				position = game.at(tanqueActual.position().x(), tanqueActual.position().y() + 1)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				position = game.at(tanqueActual.position().x() , tanqueActual.position().y() - 1)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){

				position = game.at(tanqueActual.position().x() +1, tanqueActual.position().y() )
		}
		else {position = game.at(tanqueActual.position().x() - 1, tanqueActual.position().y()) }

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
		self.removerDisparo()
		self.agregarExplosion()		
	}	
	method removerDisparo(){
		game.removeTickEvent("MOVIMIENTO_DE_BALA"+ self.identity())
		game.removeVisual(self)
	}
	
	method agregarExplosion(){
		const explocion = new Explocion(position = position)
		game.addVisual( explocion)
		game.schedule(250, { game.removeVisual( explocion) })
	}

	method validaPosicion(_position){
		return _position.y().between(0, game.width() -1 ) and _position.x().between(0, game.height() -1)
	
	}
	
	method impactar(algo){
		// No hace nada.
	}
	
	method trayecto(){
		self.ubicarPosicion()
		game.addVisual(self)
		game.onTick(50, "MOVIMIENTO_DE_BALA" + self.identity(), {self.desplazar()})
		game.onCollideDo(self, { algo => algo.impactar(self) })
	}
}


class Pasto{
	var property position = null
	var vida = 20
	method image() = "pasto.png"

	method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)
		} else {
			self.removerElemento()			
		}
	}
	
	method removerElemento(){
		game.removeVisual(self)
	}
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danio()
	}
	
	method validaVida(){
		return vida > 0
	}
}

class Ladrillo{
	var property position
	var property vida = 100 
	
	method image() {
		return if (vida > 50) {"muro.png"}
		 else {"muro_rajado.png"}
	} 
	
	method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)
				
		} else {
			self.agregarHumo()
			self.removerElemento()
		}
	}
	
	
	method validaVida(){
		return vida > 0
	}
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danio()
	}
	
	method agregarExplosion(){
		const explocion = new Explocion(position = position)
		game.addVisual( explocion)
		game.schedule(250, { game.removeVisual( explocion) })
	}
	
	method agregarHumo() {
		const humo = new Humo(position = position)
		game.addVisual(humo)
		game.schedule(250, { game.removeVisual(humo) })
	}
	
	method removerElemento(){
		game.removeVisual(self)
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

class Humo {
	var property position

	method image() = "humo.png"
	
	method impactar(algo){}
}

object defensa {
	
	var property vida = 200
	
	method image() = "baseGit1.png"
	
	method position () = game.at( (game.width()) / 2,0)
	
	method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)	
		} else {
		//Implementar trigger de fin de juego por perder.			
			game.say(tanque, "Nooooooooooooooooooooooooo!!!")		
			game.removeVisual(self) 
			game.schedule(2000, {game.stop()})

		}
	}
	
	method validaVida(){
		return vida > 0
	}
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danio()
	}
	
	method removerElemento(){
		game.removeVisual(self)
	}
	
}

object gestorDeEnemigos{
	const property enemigosEnMapa = []
	var enemigosCaidos = 0 

	method agregarEnemigos() {
		if (self.enemigosEnMapa().size() <= 2 ) {
			self.agregarNuevaEnemigo()
			game.say(defensa,"¡CUIDADO! Se acerca un " + enemigosEnMapa.last().modelo() + ".")
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
		enemigosCaidos += 1
	}
}

