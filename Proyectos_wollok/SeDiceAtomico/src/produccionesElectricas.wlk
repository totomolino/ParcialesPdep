import Ciudad.*

object burns {
	
	const property ciudad = springfield

	
	method produce(cantVarillas) {
		return 0.1 * cantVarillas
	}
	
	
	
}


object exBosque {
	
	const ciudad = springfield
	
	
	method produce(capacidadEnToneladas){
		return 0.5 + capacidadEnToneladas * ciudad.riqueza()
	}
	
}



object elSuspiro {
	
	const property ciudad = springfield
	
	var property cantidadTurbinas = 1
	
	method produce (){
		return cantidadTurbinas * (ciudad.vientos() * 0.2)
		
	}
	
}