class Personaje {
	
	const property casa
	
	var conyuges = []
	
	var property acompaniantes
	
	var estado = vivo
	
	var aliados = self.aliados()
	
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
	
	method estaSolo(){
		return acompaniantes.isEmpty()
	}
	
	method aliados(){
		return acompaniantes + conyuges + casa.miembros().remove(self)
	}
	
	method esPeligroso(){
		return self.estaVivo() && (self.aliadosTienenMasDe(10000) or self.todosLosConyugesRicos() or self.conoceUnPeligroso())
	}
	
	method estaVivo(){
		return estado == vivo
	}
	
	method aliadosTienenMasDe(unNumero){
		return aliados.sum({aliado => aliado.patrimonio()}) >= unNumero
	}
	
	method todosLosConyugesRicos(){
		return conyuges.all({conyuge => conyuge.esRico()})
	}
	
	method conoceUnPeligroso(){
		return aliados.any({aliado => aliado.esPeligroso()})
	}
	
	
}

object vivo{}

object muerto{}

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

















