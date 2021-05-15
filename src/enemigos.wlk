import config.*
import wollok.game.*

object enemigoLeopard {
	
	var property vida = 100
	var property position = game.at(27,27)
	var property ultimoMovimiento = "izquierda"
	
	
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
		
		game.onTick(500, "moverse" , {self.moverSiEstoyEnZona()})
		
	}
	

	
	method moverSegun(direccion){
		return if (direccion == "arriba") position.up(1)
		 else if  (direccion == "derecha") position.right(1)
		  else if (direccion == "abajo") position.down(1)
		   else position.left(1)			
	}
	
	method aleatorio(){
		return ["abajo", "izquierda","derecha"].anyOne()
	}
	
	method moverSiEstoyEnZona(){
		ultimoMovimiento = self.aleatorio()
		if(self.estoyEnZona(self.moverSegun(ultimoMovimiento))) {position = self.moverSegun(ultimoMovimiento)} 
	}
	

	method estoyEnZona(lugarAMoverse){
		return (lugarAMoverse.y().between(0,game.width() -3) and lugarAMoverse.x().between(0, game.height() -3))
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

