import tanque.*
import wollok.game.*
import elementos.*
import enemigos.*

object config {

	method configurarTeclas() {
		keyboard.a().onPressDo({ tanque.irA(tanque.position().left(1), "izquierda")})
		keyboard.d().onPressDo({ tanque.irA(tanque.position().right(1), "derecha")})
		keyboard.w().onPressDo({ tanque.irA(tanque.position().up(1), "arriba")})
		keyboard.s().onPressDo({ tanque.irA(tanque.position().down(1), "abajo")})
		keyboard.space().onPressDo({ self.mecanicaDe(tanque.balaDisparada()) })
	}
	
	method configurarColisiones(){
		
	}
	

	method configurarMovimientosYDisparosAleatoriosEnemigos(){
		game.onTick(5000, "TANQUESENEMIGOS", {gestorDeEnemigos.agregarEnemigos()})

	}
	
	method mecanicaDe(bala){
		bala.ubicarPosicion()
		game.addVisual(bala)
		game.onTick(50, "MOVIMIENTO_DE_BALA" + bala.identity(), {bala.desplazar()})
		game.onCollideDo(bala, { algo => algo.impactar(bala) })
	}
}