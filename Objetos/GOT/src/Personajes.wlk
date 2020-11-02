class Personaje {
	
	const property casa
	
	var conyuges = []
	
	method noTienePareja(){
		return conyuges.isEmpty()
	}
	
	method puedeCasarseCon(otraPersona){
		return casa.dejaCasarseA(self, otraPersona)
	}
	
	method casarseCon(otraPersona){
		if(self.puedeCasarseCon(otraPersona)){
			conyuges.add(otraPersona)
			otraPersona.casarseCon(self)
		}
		self.error("No se pueden casar")
	}
	
	method patrimonioPropio(){
		return casa.patrimonio() / casa.size()
	}
	
}

class Casamiento {
	
	const marido
	
	const mujer
	
	
	method sePuedenCasar(){
		return marido.puedeCasarseCon(mujer) && mujer.puedeCasarseCon(marido)
		
	}
	
	method casarse(){
		
		marido.casarseCon(mujer)
		mujer.casarseCon(marido)
		
	}
	
}



class Casa {
	
	var patrimonio
	
	var ciudad
	
	var miembros

	
	
	method dejaCasarseA(unMiembro , otraPersona)
	
	method esRica(){
		return patrimonio > 1000
	}
	
	
	
	
	
}


object lannister inherits Casa {
	
	override method dejaCasarseA(unMiembro , otraPersona){
		return unMiembro.noTienePareja()
	}
	
	
}


object stark inherits Casa {
	
	override method dejaCasarseA(unMiembro , otraPersona){
		return unMiembro.casa() != otraPersona.casa()
	}
	
	
}



object guardiaDeLaNoche inherits Casa {
	
	override method dejaCasarseA(unMiembro , otraPersona){
		return false
	}
	
	
}

















