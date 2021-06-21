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

//Pendiente: definir el tema de los danios de las balas y potenciaDisparo de los tanques

class Fireball inherits Bala {
	
//	const porcentajeDanioAQuitar = 2
	
	override method image(){
		return "fireball_" + direccion.sufijo()  + ".png"
	}
	
//	override method danio(_porcentajeDanioAQuitar){	
//		danio = (self.danio() / _porcentajeDanioAQuitar).roundUp(0)  // El disparo de fuego saca la mitad de daio de la bala por defecto
//	}

	override method danioPropio() {// El disparo de fuego hace menos danio que la bala por defecto
		return 10
	}
}


class Plasma inherits Bala {
	
//	const porcentajeExtraDanio = 2
	
	override method image(){
		return "plasma_" + direccion.sufijo()  + ".png"
	}
	
//	override method danio(_porcentajeExtraDanio){		
//		danio = (self.danio() * _porcentajeExtraDanio).roundUp(0)  // El disparo de plasma saca el doble de danio de la bala por defecto
//	}

	override method danioPropio() {// El disparo de plasma hace mas danio que la bala por defecto
		return 20
	}
}


class Elemento {
	
	var property position = game.origin()
	var property vida = 100
	
	method impactar(bala){
		if (self.validarVida(bala)){
			self.recibirDanio(bala)
		} else {
			bala.explotar()
			self.destruido()			
		}
	}
	
	method validarVida(bala){
		return vida > bala.danio()
	}
	
	method recibirDanio(bala) {
		bala.explotar()
		vida = (vida - bala.danio()).max(0)
	}
	
	method destruido(){
		game.removeVisual(self)	
	}
}


class Ladrillo inherits Elemento {

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

object defensa inherits Elemento {
	
	method image() = "baseAguila.png"
	
	override method position () = game.at( (game.width()) / 2,0)
	
	override method impactar(bala) {
		self.vida(1)
		super(bala)
	}
	
	override method destruido() {
		super()
		const lamento = game.sound("nooo.mp3")
		reproductor.play(lamento, 3000)
		game.say(heroe, "Noooooo Nooooooooooooooooooo!!!")		
		nivelActual.gameOver()
	}
	
	method estaDestruida() {
		return vida < 1
	}
}


class ElementoSinVida {
	
	const property position
	
	method impactar(bala) {
		//No hace nada
	}
}

class Pasto inherits ElementoSinVida{

	method image() = "pasto.png"
	
}

class Agua inherits ElementoSinVida {
	
	method image() = "agua.png"
	
}

class Metal inherits ElementoSinVida {
	
	method image() = "metal.jpg"
	
	override method impactar(bala) {
		bala.explotar()
	}
}

class Explosion inherits ElementoSinVida{

	method image() = "explosion2.png"

}


class Humo inherits ElementoSinVida{
	
	method image() = "humo.png"
	
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