import wollok.game.*
import tanque.*

class Bala {
	//var property seDisparo = false	
	
	var property position 
	
	//obligo a pasar la dir del tanque
	const direccion
	
	//Evaluar si nos puede servir
	const danho = 7
	
	method image() { 
		return if (self.dirALaQueApuntaElTanque("arriba")){
			"bala-up.png"
		}
		else if(self.dirALaQueApuntaElTanque("abajo")) {			
			"bala-dw.png"
		}
		else if(self.dirALaQueApuntaElTanque("derecha")) {					
			"bala-rh.png"
		}
		else{
			"bala-lf.png"
		}
	}
	
	//Revisar como podemos re implementar el mensaje position para que no devuelva siempre la misma posición
	method positionOrigen(){
		 if(self.dirALaQueApuntaElTanque("arriba")){		
				position = game.at(tanque.position().x(), tanque.position().y() + 2)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				position = game.at(tanque.position().x() , tanque.position().y() - 2)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){
				position = game.at(tanque.position().x() + 2, tanque.position().y() )
		}
		else {
			position = game.at(tanque.position().x() - 2, tanque.position().y() )
		}
	}
	
	method dirALaQueApuntaElTanque(dir){
		return direccion == dir
	}	
	
	method desplazar(){
		if (self.dirALaQueApuntaElTanque("arriba") ){
			position = position.up(1) 
		} else if (self.dirALaQueApuntaElTanque("abajo")) {
			position = position.down(1)
		} else if (self.dirALaQueApuntaElTanque("derecha")) {
			position = position.right(1)
		} else {
			position = position.left(1)
		}
	}
	
	method avanzar(){
		//position += self.dirADesplazar() 
	}
	

	

}


class Pasto{
	var property position = null
	method image() = "pasto.png"
	
	
	
}

class Ladrillo{
	var property position = null
	method image() = "muro.png"
	
	method impactar(bala){
		game.say(bala, "Impacte contra algo")
		game.removeTickEvent("Trayectoria")
			
	}
}

class Agua{
	var property position = null
	method image() = "agua.png"
}
