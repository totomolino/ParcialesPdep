import trajes.*

class Guerrero {
	
	var potencialOfensivo
	
	var nivelDeExp
	
	var nivelDeEnergia
	
	const nivelDeEnergiaOriginal
	
	var property traje
	
	method atacarA(otroGuerrero){
		otroGuerrero.recibirGolpeDe(self)
	}
	
	method recibirGolpeDe(unGuerrero){
		self.aumentarExperienciaEn(1)
		self.restarEnergia(unGuerrero.potencialOfensivo() * 0.1 - traje.recibirGolpe())
	}
	
	
	
	method aumentarExperienciaEn(unNumero){
		nivelDeExp += unNumero * traje.aumentaExp()
	}
	
	
	method comerSemilla(){
		nivelDeEnergia = nivelDeEnergiaOriginal
	}
	
	method restarEnergia(unNumero){
		nivelDeEnergia -= unNumero
	}
	
	
}

























