import config.*
import random.*
import elementos.*
import random.*
import wollok.game.*

class EnemigoLeopard {
	
	var property vida = 100
	var property position = game.at(10,10)
	var property direccion = "izquierda"
	const danioDisparo = 15
	var timeMove
	var shotTime

	method image() {
		return if (direccion == "arriba")  {"Leopard-up.png"}
		 else if  (direccion == "abajo")   {"Leopard-dw.png"}
		  else if (direccion == "derecha") {"Leopard-rh.png"}
		   else {"Leopard-lf.png"}
	}
	
	method moverDisparandoAleatorio(){		

		game.onTick(timeMove,  "MOVER_ENEMIGO" + self.identity(), {self.avanzar()})
		game.onTick(shotTime,  "DISPARAR_ENEMIGO" + self.identity(), {self.disparar()})			

	}
	method disparar(){
		const bala = new Bala(danho = danioDisparo , direccion = direccion, tanqueActual = self)
		bala.trayecto()
	}

	method avanzar(){
		direccion = random.direccionAleatoria()
		if(self.validaPosicion(self.moverAl(direccion)) and self.sinObstaculo(self.moverAl(direccion))) {
				position = self.moverAl(direccion)
		} 
	}
	
	method sinObstaculo(_position){
		return game.getObjectsIn(_position).isEmpty()
	}
	

	method moverAl(_direccion){
		return if (_direccion == "arriba")  {position.up(1)}
		 else if  (_direccion == "derecha") {position.right(1)}
		  else if (_direccion == "abajo")   {position.down(1)}
		   else {position.left(1)}			
	}
		
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
	method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)	
		} else {
			self.removerEnemigo()
		}
	}
	
	method removerEnemigo(){
		game.removeTickEvent("DISPARAR_ENEMIGO"+ self.identity())
		game.removeTickEvent("MOVER_ENEMIGO"+ self.identity())
		gestorDeEnemigos.removerElemento(self)
	}
	
	method removerElemento(){
		game.removeVisual(self)
	}
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danho()
	}
	
	method validaVida(){
		return vida > 0
	}
}