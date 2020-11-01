import Inmuebles.*
import Personas.*


class Operacion {
	
	const inmueble 
	
	var property estado = disponible
	
	method zona(){
		return inmueble.zona()
	}
	
	method concretarPara(cliente){
		estado.concretarPara(self, cliente)
	}
	
	method reservarPara(cliente){
		estado.reservarPara(self, cliente)
	}
	
	
	
	
	
}

class Alquiler inherits Operacion {
	
	const cantidadDeMeses
	
	method comision() {
		return (cantidadDeMeses * inmueble.precio())/50000
	}
	
}


class Venta inherits Operacion {
	
	var porcentajeDeComision
	
	method comision(){
		return inmueble.precio() * porcentajeDeComision
	}
}


class EstadoDeOperacion {
	
	method reservarPara(operacion, cliente)
	
	method concretarPara(operacion, cliente){
		self.validarCierrePara(cliente)
		operacion.estado(cerrada)
	}
	
	method validarCierrePara(cliente){}
	
	
}


object disponible inherits EstadoDeOperacion {
	
	override method reservarPara(operacion, cliente){
		operacion.estado(new Reservada(clienteQueReservo = cliente))
	}
	
}

class Reservada inherits EstadoDeOperacion {
	
	const clienteQueReservo
	
	override method reservarPara(operacion, cliente){
		self.error("Ya esta reservada")
	}
	
	override method validarCierrePara(cliente){
		if(cliente != clienteQueReservo){ self.error("Ya esta reservada") }
	}
	
}


object cerrada inherits EstadoDeOperacion {
	
	override method reservarPara(operacion, cliente){ self.error("Ya se vendio")}
	
	override method validarCierrePara(cliente){self.error("Ya se cerro la operacion una vez")}
	
}
































