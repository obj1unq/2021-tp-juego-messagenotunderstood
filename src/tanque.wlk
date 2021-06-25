import wollok.game.*
import elementos.*
import config.*
import escenarios.*
import musica.*

class Tanque inherits Elemento {
	
	var property direccion = arriba
	var property potenciaDisparo = 15
	
	method nuevaBala(){
		return new Bala(tanque = self, direccion = direccion, position = position)
	}
	
	method sinObstaculo(_position){
		return game.getObjectsIn(_position).isEmpty()
	}
	
	method validaPosicion(_position){
		return (_position.y().between(0,game.height() -2) and _position.x().between(0, game.width() -1))
	}
	
	method image() {
		return self.modelo() + "_"+ direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "tanque"
	}
}

object heroe inherits Tanque{
	
	var property cantidadDeVidas = 3
	var property cargador = 1 
	
	method irA(_position, _direction){
		if (self.validaPosicion(_position) and self.sinObstaculo(_position)){
			position = _position
			direccion = _direction
		}
	}
	
	method disparar(){
	//Si tiene una bala dispara y recarga
		if (self.tieneBala()){
			self.agregarSonidoDisparo()
			self.descargar()
			config.movimientoDe(self.nuevaBala())
			self.recargar()
		} else {
			//TODO: armar la logica para cambiar la visual del cargador en la barra superior.
		}
	}
	
	method tieneBala(){
		return cargador > 0
	}
	
	method agregarSonidoDisparo() {
		const disparo = game.sound("cañon.mp3")
		reproductor.play(disparo, 1000)
	}
	
	method descargar() {
		cargador -= 1
	}
	
	method recargar(){
	//Cooldown de recarga
		game.schedule(1000, { self.cargarBala() })
	}
	
	method cargarBala(){
		cargador += 1
	}
	
	override method impactar(bala) {
		self.agregarSonidoDisparo()
		const doh = game.sound("homero doh.mp3")
		reproductor.play(doh, 1000)
		super(bala)
	}

	override method destruido() {
		game.say(self, "Me Muerooo")
		game.schedule(1000, {super()})
		self.perderVida()	
	}
	
	method perderVida() {
		cantidadDeVidas -= 1
		game.schedule(1000, {nivelActual.reStartSiPuede()})
	}
	
	method leQuedanVidas() {
		return cantidadDeVidas > 0
	}
	
	method resetValores() {
		position = game.origin()
		direccion = arriba
		vida = 100
		cargador = 1
	}
}