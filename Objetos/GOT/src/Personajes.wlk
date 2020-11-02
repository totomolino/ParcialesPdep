


class Personaje {
	
	const property casa
	
	var conyuges = []
	
	var property acompaniantes
	
	var estado = vivo
	
	var aliados = self.aliados()
	
	const personalidad
	
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
	
	method complotarA(unaPersona){
		personalidad.complotar(unaPersona)
	}
	
	method morir(){
		estado = muerto
	}
	
	method derrocharDeSuCasa(unPorcentaje){
		casa.derrochar(unPorcentaje)
	}
	
	method esAliado(unaPersona){
		return aliados.contains(unaPersona) }
	
}

class Sutil {
	
	const todasLasCasas
	
	const casaMasPobre = todasLasCasas.min({casa => casa.patrimonio()})
	
	method losVivosDeLaMasPobre() {
		return casaMasPobre.miembros().filter({persona => persona.estaVivo()})
	}
	
	method complotar(unaPersona){
		const pobres = self.losVivosDeLaMasPobre()
		const unoPobre = pobres.anyOne()
		if(pobres.isEmpty()){self.error("No hay nadie con quien casarse")}
		unaPersona.casarseCon(unoPobre)
	}
	
}

object asesino {
	
	method complotar(unaPersona){
		unaPersona.morir()
	}
	
	
}


object asesinoPrecavido {
	
	method complotar(unaPersona){
		if(unaPersona.estaSolo()){
			unaPersona.morir()
		}
		
	}
	
	
	
}

class Disipados {
	
	const porcentaje
	
	method complotar(unaPersona){
		unaPersona.derrocharDeSuCasa(porcentaje)
	}
	
}

object miedosos {
	
	 method complotar(unaPersona){}
	
}



class Conspiracion {
	
	const complotados
	
	const unaVictima 
	
	method hacerUnComplot(){
		if(unaVictima.esPeligroso()){
			self.ejecutarConspiracion()
		}
		else self.error("No es peligroso la victima")
		}
		
	method cuantosComplotados(){
		return complotados.filter({persona => persona.esAliado(unaVictima)})		
		}
		
	method ejecutarConspiracion(){
		complotados.forEach({complotador => complotador.complotar(unaVictima)})
	}
	
	method conspiracionFunciono(){
		return not unaVictima.esPeligroso()
	}
	
	
	
}

object vivo{}

object muerto{}





class Casa {
	
	var patrimonio
	
	var ciudad
	
	var miembros

	
	
	method dejaCasarseA(unMiembro , otraPersona)
	
	method esRica(){
		return patrimonio > 1000
	}
	
	method derrochar(unPorcentaje){
		
		patrimonio -= ((patrimonio*unPorcentaje)/100)
		
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

















