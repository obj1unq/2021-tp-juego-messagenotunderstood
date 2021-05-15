import config.*
import random.*
import wollok.game.*

object enemigoLeopard {
	
	var property vida = 100
	var property position = game.at(10,10)
	var property direccion = "izquierda"
	
	method image() {
		return if (direccion == "arriba")  {"Leopard-up.png"}
		 else if  (direccion == "abajo")   {"Leopard-dw.png"}
		  else if (direccion == "derecha") {"Leopard-rh.png"}
		   else {"Leopard-lf.png"}
	}
	
	method moverAleatorio(){		
		game.onTick(800, "moverse" , {self.avanzar()})		
	}
	
	method disparar(){
		// falta implementar
	}
 //game.at((position.up - 1 ),(game.height() - 1))
	method avanzar(){
		direccion = self.direccionAleatoria()
		if(self.validaPosicion(self.moverAl(direccion)) and not self.esObtaculo(self.moverAl(direccion))) {
				position = self.moverAl(direccion)
		} 
	}
	
	method esObtaculo(_position){
		return not game.getObjectsIn(_position).isEmpty()
	}
	
	
	method direccionAleatoria(){
		return ["arriba,izquierda","abajo","derecha"].anyOne()
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
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}