import Pajaros.*



object sesionDeManejo {
	
	method sucederEn(habitantes){
		habitantes.forEach({pajaro => pajaro.tranquilizarse()})
	}
	
	
}


class InvasionCerditos {
	
	var cerditos
	
	method sucederEn(habitantes){
		habitantes.forEach({pajaro => pajaro.enojarseXVeces(cerditos/100)})
	}
	
}


class FiestaSorpresa {
	
	var homenajeados
	
	method sucederEn(habitantes){
		if(homenajeados.any({pajaro => habitantes.contains(pajaro)})){
			homenajeados.forEach({jugador => jugador.enojarse()})	
		}
		self.error("No hay ningun cumpleaniere")
	}	
}

class MuchosEventos {
	
	var serieDeEventos 
	
	method sucederEn(habitantes){
		serieDeEventos.forEach({evento => evento.sucederEn(habitantes)})
	}
	
	
}






