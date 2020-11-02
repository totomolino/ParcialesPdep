import Regalos.*

class ArbolNavidenio {
	
	var regalos 
	
	var tarjetas
	
	var regalosYTarjetas  = regalos + tarjetas
	
	var adornos 
	
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
	
	method importanciaTotal(){
		adornos.sum({adorno => adorno.importancia()})
	}
	
	method adornoMasPesado(){
		return adornos.max({adorno => adorno.peso()})
	}
	
	method esArbolPortentoso(){
		return self.muchosRegalosTkm(5) or self.hayUnaTarjetaConValorMayorA(1000)
	}
	
	method muchosRegalosTkm(numero){
		return regalos.filter({regalo => regalo.esRegaloTkm()}).size() >= numero
	}
	
	method hayUnaTarjetaConValorMayorA(unNumero){
		
		return tarjetas.any({tarjeta => tarjeta.precio() >= unNumero })
		
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





