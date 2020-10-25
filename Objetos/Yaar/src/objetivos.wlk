import barcoYPiratas.*



class CiudadCostera {
	
	const property ebriedadRequerida = 50
	
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
	
}
