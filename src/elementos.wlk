import wollok.game.*
import tanque.*
import enemigos.*
import random.*

class Bala {
	
	const direccion
	const property danio = 7
	const tanqueActual = tanque 
	
	var property position //= game.origin()
	
	method image() { 
		return "bala_" + direccion.sufijo()  + ".png"
	}
	
	method ubicarPosicion(){
		// Se utiliza para evitar la colision con el tanque que dispara
		self.desplazar()
	}
	
	method dirALaQueApuntaElTanque(dir){
		return direccion == dir
	}	
	
	method desplazar(){
		position = direccion.siguientePosicion(position)

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
	
	method image() = "muro.png"
	
	method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)
				
		} else {
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
	
	method removerElemento(){
		game.removeVisual(self)
	}
}

class Agua{
	
	var property position = null	
	
	method image() = "agua.png"
	
	//TODO: implementar que las balas puedan pasar sobre el agua pero los tanques no.
	
}

class Explocion {
	
	var property position

	method image() = "explosion1.png"

	method impactar(bala){
		//No hace nada.
	}
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
			new EnemigoLeopard(position =  random.emptyPosition(), shotTime = 2500,  timeMove = 3000)		
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

object arriba {
	method sufijo(){
		return "up"
	}
	method siguientePosicion(posicion){
		return posicion.up(2)
	}
}

object abajo {
	method sufijo(){
		return "down"
	}
	method siguientePosicion(posicion){
		return posicion.down(1)
	}
}

object izquierda {
	method sufijo(){
		return "left"
	}
	method siguientePosicion(posicion){
		return posicion.left(1)
	}
}

object derecha {
	method sufijo(){
		return "right"
	}
	method siguientePosicion(posicion){
		return posicion.right(1)
	}
}