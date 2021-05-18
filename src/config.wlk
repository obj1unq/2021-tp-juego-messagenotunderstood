import tanque.*
import wollok.game.*
import elementos.*

object config {

	method mapa(){
		game.title("Wollanzerkampfwagen")
		game.height(13)
		game.width(13)
		game.cellSize(50)
		
	}
		
	method teclas() {
		keyboard.a().onPressDo({ tanque.irA(tanque.position().left(1), "izquierda")})
		keyboard.d().onPressDo({ tanque.irA(tanque.position().right(1), "derecha")})
		keyboard.w().onPressDo({ tanque.irA(tanque.position().up(1), "arriba")})
		keyboard.s().onPressDo({ tanque.irA(tanque.position().down(1), "abajo")})
		keyboard.space().onPressDo({ tanque.disparar() })
	}
	
	method configurarColisiones(){
		
	}
	
	method configurarMovimientosYDisparosAleatoriosEnemigos(){
		
	}
}