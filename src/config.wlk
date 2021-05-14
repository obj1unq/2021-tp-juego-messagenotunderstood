import tanque.*
import wollok.game.*
import elementos.*

object config {

	method mapa(){
		game.title("Wollanzerkampfwagen")
		game.height(30)
		game.width(30)
		game.cellSize(20)
		
}
	
	method teclas() {
		keyboard.a().onPressDo({ tanque.irA(tanque.position().left(1), "izquierda")})
		keyboard.d().onPressDo({ tanque.irA(tanque.position().right(1), "derecha")})
		keyboard.w().onPressDo({ tanque.irA(tanque.position().up(1), "arriba")})
		keyboard.s().onPressDo({ tanque.irA(tanque.position().down(1), "abajo")})
		keyboard.space().onPressDo({ tanque.disparar() })
	}
	
	method trayectoriaDe(bala){
		game.addVisual(bala)
		game.onTick(1, "Trayectoria",  {bala.desplazar()})
		//game.onCollideDo(bala, { bala.impactar()})
		//game.removeVisual(bala)
	}
	
}