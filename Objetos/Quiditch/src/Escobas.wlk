class Nimbus {
	
	const anioDeFabricacion
	
	var salud
	
	method aniosTotales(){
		const anioActual = new Date().year()
		return anioActual - anioDeFabricacion
	}
	
	method saludPorcentual(){
		return salud / 100
	}
	
	method velocidad(){
		
		
		return (80 - self.aniosTotales()) * self.saludPorcentual()
	}	
	
}


class SaetaDeFuego {
	
	const property velocidad = 100
	
}


object mercadoDeEscobas {
	
	var property valorArbitrario = 0.randomUpTo(200)
}
