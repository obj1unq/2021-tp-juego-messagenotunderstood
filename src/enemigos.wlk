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

		game.onTick(timeMove,  "moverse" + self.identity(), {self.avanzar()})
		game.onTick(shotTime, "disparar" + self.identity(), {self.disparar()})			

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
			bala.explotar()
			vida -= bala.danho()	
		} else {
			game.removeTickEvent("disparar"+ self.identity())
			game.removeTickEvent("moverse"+ self.identity())
			gestorDeEnemigos.removerElemento(self)

		}
	}
	
	method validaVida(){
		return vida > 0
	}
}