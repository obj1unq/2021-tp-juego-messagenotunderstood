import wollok.game.*
import tanque.*

class Bala {

	const direccion
	const property danio = 7
	const tanqueActual = tanque 
	const nombreTick  = [1,2,3,4,5,6,7,8,9,10,11,12,13,15].anyOne().toString()
	var property position = game.origin()
	
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
	
	method position(_posicion, _direccion){
		 if(self.dirALaQueApuntaElTanque("arriba")){		
				position = game.at(tanqueActual.position().x(), tanqueActual.position().y() + 1)
		}
		else if (self.dirALaQueApuntaElTanque("abajo")){
				position = game.at(tanqueActual.position().x() , tanqueActual.position().y() - 1)
		}
		else if(self.dirALaQueApuntaElTanque("derecha")){
				position = game.at(tanqueActual.position().x() + 1, tanqueActual.position().y() )
		}
		else {
			position = game.at(tanqueActual.position().x() - 1, tanqueActual.position().y() )
		}
	}
	
	method dirALaQueApuntaElTanque(dir){
		return direccion == dir
	}	
	
	method desplazar(){

		if (self.dirALaQueApuntaElTanque("arriba") and self.validaPosicion(position.up(1))){
			position = position.up(1) 
		} else if (self.dirALaQueApuntaElTanque("abajo") and self.validaPosicion(position.down(1))) {
			position = position.down(1)
		} else if (self.dirALaQueApuntaElTanque("derecha") and self.validaPosicion(position.right(1))) {
			position = position.right(1)
		} else if ( self.dirALaQueApuntaElTanque("izquierda")and self.validaPosicion(position.left(1))){
			position = position.left(1)
		} else {
			self.explotar()
		}
	}
	
	method explotar(){
		self.agregarExplocionYRemoverBala( new Explocion(position = position))
		self.removerBala()
		
	}
	
	method removerBala(){
		game.removeVisual(self)
		game.removeTickEvent(nombreTick)
		
	}
	
	method agregarExplocionYRemoverBala(explocion){
		game.addVisual( explocion)
		game.schedule(250, { 
			game.removeVisual( explocion)
		} )
	}

	method validaPosicion(_position){
		return _position.y().between(0, game.width() - 1) and _position.x().between(0, game.height() - 1 )
	
	}
	
	method impactar(algo){
		//No hace nada.
	}
	
	method trayectoriaDe(){
		game.addVisual(self)
		game.onTick(1, nombreTick,  {self.desplazar()})
		game.onCollideDo(self, { algo => algo.impactar(self) })
	}
}


class Pasto{
	var property position = null
	var vida = 20
	method image() = "pasto.png"

	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danio()	
		} else {
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}

class Ladrillo{
	var property position
	var property vida = 100 
	
	method image() = "muro.png"
	
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danio()	
		} else {
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}

class Agua{
	var property position = null
	method impactar(bala){
		// No hace nada
	}
	method image() = "agua.png"
}

class Explocion {
	var property position	
	method image() = "explosion1.png"
	method impactar(algo){}
}


object defensa {
	
	var property vida = 200
	
	method image() = "baseGit1.png"
	method position () = game.at( (game.width()) / 2,0)
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danio()	
		} else {
		//Implementar trigger de fin de juego por perder.
			game.removeVisual(self)

		}
	}
	method validaVida(){
		return vida > 0
	}
	
}
