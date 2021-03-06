import wollok.game.*
import tanque.*
import enemigos.*
import random.*
import escenarios.*
import musica.*

class Bala {
	
	const property tanque
	const direccion
	var property position 
	
	method image() { 
		return "bala_" + direccion.sufijo()  + ".png"
	}
	
	method danio() {
		return self.danioPropio() + tanque.potenciaDisparo()
	}
	
	method danioPropio() {
		return 15
	}
	
	method ubicarPosicion(){
		// Se utiliza para evitar la colision con el tanque que dispara
		self.desplazar()
	}
	
	method desplazar(){
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
		game.addVisual(explocion)
		game.schedule(250, { game.removeVisual( explocion) })
	}
	
	method validaPosicion(_position){
		return _position.y().between(0, game.height() - 1) and _position.x().between(0, game.width() -1)
	}
	
	method impactar(bala){
		bala.explotar()
		self.removerDisparo()
	}
	
	method enElBorde(){
		return  self.margenesLaterales() or self.margenesSupEInf()
	}
	
	method margenesLaterales(){
		return position.x() > game.width() or position.x() < 0
	}
	
	method margenesSupEInf(){
		return position.y() > (game.height() - 2)  or position.y() < 0
	}
}


class Fireball inherits Bala {
	
	override method image(){
		return "fireball_" + direccion.sufijo()  + ".png"
	}

	override method danioPropio() {// El disparo de fuego hace menos danio que la bala por defecto
		return 10
	}
}


class Plasma inherits Bala {
		
	override method image(){
		return "plasma_" + direccion.sufijo()  + ".png"
	}

	override method danioPropio() {// El disparo de plasma hace mas danio que la bala por defecto
		return 20
	}
}




class Elemento {
	
	var property position = game.origin()
	
	method impactar(bala) {
		//No hace nada
	}
}

class Agua inherits Elemento {
	
	method image() = "agua.png"
}

class Metal inherits Elemento {
	
	method image() = "metal.jpg"
	
	override method impactar(bala) {
		bala.explotar()
	}
}

class Explosion inherits Elemento {

	method image() = "explosion2.png"
}

class Humo inherits Elemento {
	
	method image() = "humo.png"
}

object explosion inherits Elemento {

	method image() = "explosion1.png"
	
	method agregarExplosion() {
		reproductor.playExplosion()
		game.addVisualIn(self, heroe.position())
		game.schedule(250, { game.removeVisual(self) })
	}
}

class ElementoDestruible inherits Elemento {
	
	var property vida = 100
	
	override method impactar(bala){
		self.recibirDanio(bala)
		if (!self.leQuedaVida()) {self.destruido()}
	}
	
	method leQuedaVida(){
		return vida > 0
	}
	
	method recibirDanio(bala) {
		bala.explotar()
		vida = (vida - bala.danio()).max(0)
	}
	
	method destruido(){
		game.removeVisual(self)	
	}
}


class Ladrillo inherits ElementoDestruible {

	method image() {
		return if (vida > 50) {"muro.png"}
		 else {"muro_rajado.png"}
	} 

	override method destruido() {
		super()
		self.agregarHumo()
	}

	method agregarHumo() {
		const humo = new Humo(position = position)
		game.addVisual(humo)
		game.schedule(250, { game.removeVisual(humo) })
	}
}

object defensa inherits ElementoDestruible {
	
	method image() = "baseAguila.png"
	
	override method position () = game.at( (game.width()) / 2,0)
	
	override method impactar(bala) {
		self.vida(1)
		super(bala)
	}
	
	override method destruido() {
		super()
		reproductor.playLamento()
		game.say(heroe, "Noooooo Nooooooooooooooooooo!!!")		
		game.schedule(3300, {gameOver.iniciar()})
	}
}


object gestorDeElementos { // (y < y2)    (x < x2)
	
	
	method columnaDeLadrilloAPartirDe_Y_hasta_(x, y, y2) {
		(y..y2).forEach({n => game.addVisual(new Ladrillo(position = game.at(x,n)))})
	}
	
	method filaDeLadrilloAPartirDe_Y_hasta_(x, y, x2) {
		(x..x2).forEach({n => game.addVisual(new Ladrillo(position = game.at(n,y)))})
	}
	
	method columnaDeAguaAPartirDe_Y_hasta_(x, y, y2) {
		(y..y2).forEach({n => game.addVisual(new Agua(position = game.at(x,n)))})
	}
	
	method filaDeAguaAPartirDe_Y_hasta_(x, y, x2) {
		(x..x2).forEach({n => game.addVisual(new Agua(position = game.at(n,y)))})
	}
	
	method columnaDeMetalAPartirDe_Y_hasta_(x, y, y2) {
		(y..y2).forEach({n => game.addVisual(new Metal(position = game.at(x,n)))})
	}
	
	method filaDeMetalAPartirDe_Y_hasta_(x, y, x2) {
		(x..x2).forEach({n => game.addVisual(new Metal(position = game.at(n,y)))})
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