
class Revolver {
	
	var cantDeBalas
	
	method usar(victima){
		if(cantDeBalas > 0){
			self.gastarBala()
			victima.morir()
		}
		
	}
	
	method gastarBala(){
		cantDeBalas -= 1
	}
	
}


object escopeta {
	
	method usar(victima){
		if(victima.estaHerida()){victima.morir()}
		victima.herir()
	}
	
	
	
}


class CuerdaDePiano{
	
	const esDeBuenaCalidad
	
	method usar(victima){
		if(esDeBuenaCalidad){victima.morir()}
	}
	
}



