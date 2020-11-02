import Regalos.*

class ArbolNavidenio {
	
	var regalos 
	
	method capacidadDeRegalos()
	
	method agregarUnRegalo(unRegalo){
		
		if(not self.arbolLleno()){
			regalos.add(unRegalo)
		}
		else self.error("No hay mas lugar para poner regalos pa")
		
	}
	
	method arbolLleno(){
		return regalos.size() == self.capacidadDeRegalos() 
	}
	
	
	
}


class ArbolNatural inherits ArbolNavidenio{
	
	const vejez
	
	const tamanioDelTronco  // si bien ambos pueden cambiar en un entorno real, en este caso es innecesario
	
	
	override method capacidadDeRegalos(){
		
		return vejez * tamanioDelTronco
		
		
	}
	
	
	
}

class ArbolArtificial inherits ArbolNavidenio {
	
	const cantidadDeVaritas
	
	
	override method capacidadDeRegalos(){
		return cantidadDeVaritas
	}
	
}





