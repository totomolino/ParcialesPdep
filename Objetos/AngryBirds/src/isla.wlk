import Pajaros.*
import eventos.*
import obstaculos.*



class IslaPajaro {
	
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
	
	method atacarIsla(islaEnemiga){
		habitantes.forEach({pajaro => pajaro.atacarSiPuede(islaEnemiga)})
			
	}
	
	method recuperaronLosHuevos(islaEnemiga){
		self.atacarIsla(islaEnemiga)
		return islaEnemiga.perdieron()
	}
	
	
}

class IslaCerditos {
	
	var property obstaculos 
	
	
	method perdieron(){
		return obstaculos.isEmpty()
	}
	
	method obstaculoMasCercano(){
		
		obstaculos.head()
		
	}
	
}
