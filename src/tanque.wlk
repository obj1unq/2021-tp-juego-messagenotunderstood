import wollok.game.*
import elementos.*
import config.*
import escenarios.*

class Tanque inherits Elemento {
	
	var property direccion = arriba
	var property danioDisparo = 15
	var property cargador = 1 
	
	method image() {
		return "tanque_" + direccion.sufijo()  + ".png"
	}
	
	method nuevaBala(){
		return new Bala(danio = danioDisparo , direccion = direccion, position = position)
	}
	
	method sinObstaculo(_position){
		return game.getObjectsIn(_position).isEmpty()
	}
	
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
	method cargarBala(){
		cargador += 1
	}
	
	method recargar(){
	//Cooldown de recarga
		game.schedule(1500, { self.cargarBala() })
		
	}
	
	method disparar(){
	//Si tiene una bala dispara y recarga
		if (self.tieneBala()){
			cargador -= 1
			config.movimientoDe(self.nuevaBala())
			self.recargar()
		} else {
			//TODO: armar la logica para cambiar la visual del cargador en la barra superior.
		}
	}
	
	method tieneBala(){
		return cargador > 0
	}
}

object heroe inherits Tanque{
	
	var property cantidadDeVidas = 3
	
	method irA(_position, _direction){
		if (self.validaPosicion(_position) and self.sinObstaculo(_position)){
			position = _position
			direccion = _direction
		}
	}
	
	override method recibirDanio(bala) {
		super(bala)
		game.say(self, "Vida:" + self.vida().toString()) // msg para testear la cantidad de vida que quita.
	}
	
	override method destruido() {
		super()
		self.perderVida()	
	}
	
	method perderVida() {
		cantidadDeVidas -= 1
		nivelActual.reStartSiPuede() 
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