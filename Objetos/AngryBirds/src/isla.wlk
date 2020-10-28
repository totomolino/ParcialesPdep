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
		
			
	}
	
	
	
	
}

class IslaCerditos {
	
	var property obstaculos 
	
	method serAtacadaPor(pajaros){
		if(pajaros.first().puedeAtacar(obstaculos.first()){
			obstaculos.remove(obstaculos.first())
			self.serAtacadaPor(pajaros.remove(pajaros.first()))
		}
		
		
		)
	}
	
}
