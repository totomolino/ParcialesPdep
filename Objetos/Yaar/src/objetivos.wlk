import barcoYPiratas.*



class CiudadCostera {
	
	const ebriedadRequerida = 50
	
	var property habitantes 
	
	method esVulnerableA(barco){
		return (self.superaLimite(barco.cantTripulantes())) or (barco.todosPasados())
	}
	
	method superaLimite(numero){
		return ((habitantes* 40)/ 100) <= numero
	}
	
	method aumentarHabitantes(numero){
		habitantes += numero
	}
	
	method vulnerabilidad(pirata){
		return pirata.alMenosXEbriedad(ebriedadRequerida)
	}
	
}
