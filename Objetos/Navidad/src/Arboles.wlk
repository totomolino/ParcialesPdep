import Regalos.*

class ArbolNavidenio {
	
	var regalos 
	
	var tarjetas
	
	var regalosYTarjetas  = regalos + tarjetas 
	
	method capacidadDeRegalos()
	
	method agregarUnRegalo(unRegalo){
		
		if(not self.arbolLleno() && unRegalo.ocupaEspacio()){
			regalos.add(unRegalo)
		}
		else self.error("No hay mas lugar para poner regalos pa")
		
	}
	
	method arbolLleno(){
		return regalos.size() == self.capacidadDeRegalos() 
	}
	
	method beneficiarios(){
		return self.destinatariosDe(regalosYTarjetas) 
		}
	
	method destinatariosDe(unosPresentes){
		return unosPresentes.map({presente => presente.destinatario()})
	}
	
	method costoTotal(){
		return regalosYTarjetas.sum({regaloOTarjeta => regaloOTarjeta.precio() })
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





