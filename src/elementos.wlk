import wollok.game.*
import tanque.*

object bala {

	var property seDisparo = false	
	
	method image() { 
		return if (self.seDisparo()){
			"balaArriba.png"
		}
		else {
			// aca no se deberia mostrar la bala lo puse para ver si funcionaba
			"balaArriba.png"
		}
	}
	
	method position(){
		return if(self.direccionALaQueApuntaElTanque("arriba")){		
				game.at(tanque.position().x(), tanque.position().y() + 1)
		}
		else if (self.direccionALaQueApuntaElTanque("abajo")){
				game.at(tanque.position().x() , tanque.position().y() - 2)
		}
		else if(self.direccionALaQueApuntaElTanque("derecha")){
				game.at(tanque.position().x() + 1, tanque.position().y() )
		}
		else {
			game.at(tanque.position().x() - 2, tanque.position().y() )
		}
	}

	method direccionALaQueApuntaElTanque(dir){
		return tanque.ultimoMovimiento() == dir
	}	
	
	method avavanzarBala(){
		
	}
}
