import tanque.*
import wollok.game.*
import elementos.*
import enemigos.*

object config {

	method configurarTeclas() {
		keyboard.a().onPressDo({ heroe.irA(heroe.position().left(1), izquierda)})
		keyboard.d().onPressDo({ heroe.irA(heroe.position().right(1), derecha)})
		keyboard.w().onPressDo({ heroe.irA(heroe.position().up(1), arriba)})
		keyboard.s().onPressDo({ heroe.irA(heroe.position().down(1), abajo)})
		keyboard.space().onPressDo({ self.movimientoDe(heroe.balaDisparada()) })
	}
	
	method configurarColisiones(){
		// Working on it.
	}
	
	method configurarColision(bala){
		game.onCollideDo(bala, { algo => algo.impactar(bala) })
	}

	method configurarMovimientosYDisparosAleatoriosEnemigos(){
		game.onTick(5000, "TANQUESENEMIGOS", {gestorDeEnemigos.agregarEnemigos()})
	}
	
	method movimientoDe(bala){
		self.agregarYMover(bala)
		self.configurarColision(bala)
	}
	
	method agregarYMover(bala){
		bala.ubicarPosicion()
		game.addVisual(bala)
		game.onTick(10, "MOVIMIENTO_DE_BALA" + bala.identity(), {bala.desplazar()})	
	}
}