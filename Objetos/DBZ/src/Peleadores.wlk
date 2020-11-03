class Guerrero {
	
	var potencialOfensivo
	
	var nivelDeExp
	
	var nivelDeEnergia
	
	
	method atacarA(otroGuerrero){
		otroGuerrero.recibirGolpeDe(self)
		
	}
	
	method recibirGolpeDe(unGuerrero){
		nivelDeEnergia -= (unGuerrero.potencialOfensivo() * 0.1)
	}
	
	method comerSemilla()
	
	
	
}