import config.*
import wollok.game.*

class Enemigo {
	
	var property vida = 100
	var property position = game.at(27,27)
	var property ultimoMovimiento = "izquierda"
	const direcciones = ["arriba", "izquierda","abajo","derecha"];
	
	
	method image() {
		if (ultimoMovimiento == "arriba"){  
			return "Leopard-up.png"
		} else if (ultimoMovimiento == "abajo"){
			return "Leopard-dw.png"
		} else if (ultimoMovimiento == "derecha"){
			return "Leopard-rh.png"
		} else {
			return "Leopard-lf.png"	
		}
	}
	
	
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
	}
}

