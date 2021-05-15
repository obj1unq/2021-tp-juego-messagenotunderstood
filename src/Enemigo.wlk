import config.*
import random.*
import elementos.*
import wollok.game.*

class Enemigo {
	
	var property vida = 100
<<<<<<< Updated upstream:src/enemigos.wlk
	var property position = game.at(10,10)
	var property direccion = "izquierda"
=======
	var property position = game.at(27,27)
	var property ultimoMovimiento = "izquierda"
	const direcciones = ["arriba", "izquierda","abajo","derecha"];
	
>>>>>>> Stashed changes:src/Enemigo.wlk
	
	method image() {
		return if (direccion == "arriba")  {"Leopard-up.png"}
		 else if  (direccion == "abajo")   {"Leopard-dw.png"}
		  else if (direccion == "derecha") {"Leopard-rh.png"}
		   else {"Leopard-lf.png"}
	}
	
<<<<<<< Updated upstream:src/enemigos.wlk
	method moverDisparandoAleatorio(){		
		game.onTick(800,  "moverse" , {self.avanzar()})
		game.onTick(3000, "disparar" , {self.disparar()})			
	}
	
	method disparar(){
		const bala = new Bala(danho = 14 , direccion = direccion, tanqueActual = self)
		bala.position(position, direccion)	
		bala.trayectoriaDe()
	}

	method avanzar(){
		direccion = self.direccionAleatoria()
		//self.disparar()
		if(self.validaPosicion(self.moverAl(direccion)) and not self.esObtaculo(self.moverAl(direccion))) {
				position = self.moverAl(direccion)
		} 
	}
	
	method esObtaculo(_position){
		return not game.getObjectsIn(_position).isEmpty()
	}
	
	
	method direccionAleatoria(){
		return ["arriba","izquierda","abajo","derecha"].anyOne()
	}
	

	
	method moverAl(_direccion){
		return if (_direccion == "arriba")  {position.up(1)}
		 else if  (_direccion == "derecha") {position.right(1)}
		  else if (_direccion == "abajo")   {position.down(1)}
		   else {position.left(1)}			
=======
	
	method moverAleatorio(){
		self.moverSiEstoyEnZona();
	}
	
	method moverSegun(direccion){
		return if (direccion == "arriba") position.up(1)
			   else if  (direccion == "derecha") position.right(1)
		       else if (direccion == "abajo") position.down(1)
		       else position.left(1)			
	}
	
	method moverSiEstoyEnZona(){
		ultimoMovimiento = direcciones.anyOne();
		if(self.estoyEnZona(self.moverSegun(ultimoMovimiento))) {
			position = self.moverSegun(ultimoMovimiento)
		} 
	}
	

	method estoyEnZona(lugarAMoverse){
		return (lugarAMoverse.y().between(0,game.width() -3) and lugarAMoverse.x().between(0, game.height() -3));
>>>>>>> Stashed changes:src/Enemigo.wlk
	}
		
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danho()	
		} else {
			game.removeTickEvent("disparar")
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}