import Pajaros.*
import eventos.*

class Isla {
	
	var property habitantes = []
	
	method pajarosMasPicantes(){
		return habitantes.filter({pajaro => pajaro.fuerzaMayorA(50)})
	}
	
	method fuerzaDeLaIsla(){
		return (self.pajarosMasPicantes()).sum({pajaro => pajaro.fuerza()})
	}
	
	method sucederEvento(evento){
		evento.sucederEn(habitantes)
	}
		
	
	
	
	
}
