import wollok.game.*
import tanque.*
import enemigos.*
import random.*

class Fireball inherits Bala {
	
	const porcentajeDanioAQuitar = 2
	
	override method image(){
		return "fireball_" + direccion.sufijo()  + ".png"
	}
	
	override method danio(_porcentajeDanioAQuitar){	
		danio = (self.danio() / _porcentajeDanioAQuitar).roundUp(0)  // El disparo de fuego saca la mitad de daio de la bala por defecto
	}
}


class Plasma inherits Bala {
	
	const porcentajeExtraDanio = 2
	
	override method image(){
		return "plasma_" + direccion.sufijo()  + ".png"
	}
	
	override method danio(_porcentajeExtraDanio){		
		danio = (self.danio() * _porcentajeExtraDanio).roundUp(0)  // El disparo de plasma saca el doble de danio de la bala por defecto
	}
}


class Bala {
	
	const direccion
	var property danio = 7

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
		//Hay que revisar error en nuevo desplazamiento de la bala
		if (not self.enElBorde()) {
			position = direccion.siguientePosicion(position)
		} else{
			self.removerDisparo()
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
		const explocion = new Explosion(position = position)
		game.addVisual( explocion)
		game.schedule(250, { game.removeVisual( explocion) })
	}

	method validaPosicion(_position){
		return _position.y().between(0, game.width() -1 ) and _position.x().between(0, game.height() -1)
	}
	
	method impactar(algo){
		// No hace nada.
	}
	
	method enElBorde(){
		return  self.margenesLaterales() or self.margenesSupEInf()
	}
	
	method margenesLaterales(){
		return position.x() > game.width() or position.x() < 0
	}
	
	method margenesSupEInf(){
		return position.y() > game.height() or position.y() < 0
	}
}

class Obstaculo {
	var property position
	var property vida = 1
	
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
	method impactar(bala){
		//No hace nada
	}
}

class Pasto inherits Obstaculo{
	//var property position = null
	//var vida = 20
	method image() = "pasto.png"

	override method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)
		} else {
			self.removerElemento()			
		}
	}
	
}

class Ladrillo inherits Obstaculo{
	//var property position
	//var property vida = 100 
	
	method image() {
		return if (vida > 50) {"muro.png"}
		 else {"muro_rajado.png"}
	} 
	
	override method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)
		} else {
			self.agregarHumo()
			self.removerElemento()
		}
	}
	
	method agregarExplosion(){
		const explocion = new Explosion(position = position)
		game.addVisual( explocion)
		game.schedule(250, { game.removeVisual( explocion) })
	}
	
	method agregarHumo() {
		const humo = new Humo(position = position)
		game.addVisual(humo)
		game.schedule(250, { game.removeVisual(humo) })
	}
	
}

class Agua inherits Obstaculo{
	
	method image() = "agua.png"
	
	//TODO: implementar que las balas puedan pasar sobre el agua pero los tanques no.
	
}

object defensa inherits Obstaculo{
	
	method image() = "baseAguila.png"
	
	override method position () = game.at( (game.width()) / 2,0)
	
	override method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)	
		} else {
		//Implementar trigger de fin de juego por perder.			
			game.say(heroe, "Nooooooooooooooooooooooooo!!!")		
			game.removeVisual(self) 
			game.schedule(2000, {game.stop()})
		}
	}
}

class Explosion {
	
	var property position

	method image() = "explosion2.png"

	method impactar(bala){
		//No hace nada.
	}
}

class Humo {
	var property position

	method image() = "humo.png"
	
	method impactar(algo){}
}

object gestorDeEnemigos{
	
	const property enemigosEnMapa = []
	
	var enemigosCaidos = 0 

	method agregarEnemigos() {
		if (self.enemigosEnMapa().size() <= 4 ) {
			self.agregarNuevaEnemigo()
			game.say(defensa,"¡CUIDADO! Se acerca un " + enemigosEnMapa.last().modelo() + ".")
		}		
	}
	
	method agregarNuevaEnemigo(){
		const enemigosPosibles = [
			new Leopard(  position =  random.emptyPosition(), danioDisparo= 20, shotTime = 3000 , timeMove = 4000),		
			new MBT70 (   position =  random.emptyPosition(), danioDisparo= 12, shotTime = 2500,  timeMove = 3000),
			new T62 (     position =  random.emptyPosition(), danioDisparo= 25, shotTime = 2500,  timeMove = 3000),
			new T62 (     position =  random.emptyPosition(), danioDisparo= 25, shotTime = 2500,  timeMove = 3000)				
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
		return posicion.up(1)
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