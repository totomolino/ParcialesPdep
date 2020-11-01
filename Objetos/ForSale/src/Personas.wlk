import Inmuebles.*
import Operacion.*



class Inmobiliaria {
	
	var empleados
	
	var operaciones
	
	method mejorEmpleadoSegun(criterio){
		return empleados.max({empleado => criterio.cumple(empleado)})
		
		
	}
	
	
	
}


object criterioSegunComision {
	
	method cumple(unEmpleado){
		return unEmpleado.comisionesTotales()
	}
	
}
 
object criterioSegunOperacionesCerradas {
	
	method cumple(unEmpleado){
		return unEmpleado.cantidadDeOperacionesCerradas()
	}
	
}

object criterioSegunReservas {
	
	method cumple(unEmpleado){
		return unEmpleado.cantidadDeReservas()
	}
	
}




class Empleado {
	
	var operacionesCerradas
	
	var reservas
	
	method zonasOperadas(){
		return operacionesCerradas.map({operacion => operacion.zona()})
	}
	
	method cantidadDeReservas(){
		return reservas.size()
	}
	
	method cantidadDeOperacionesCerradas(){
		return operacionesCerradas.size()
	}
	
	method comisionesTotales(){
		return operacionesCerradas.sum({operacion => operacion.comision()})
	}
	
	method vaATenerProblemasCon(otroEmpleado){
		return self.operaronEnLaMismaZona(otroEmpleado) && self.algunoLeRoboAlOtro(otroEmpleado)
	}
	
	method operaronEnLaMismaZona(otroEmpleado){
		return self.zonasOperadas().any({zona => otroEmpleado.operoEn(zona)})
	}
	
	method operoEn(unaZona){
		return self.zonasOperadas().contains(unaZona)
	}
	
	method algunoLeRoboAlOtro(otroEmpleado){
		return self.leRoboA(otroEmpleado) or otroEmpleado.leRoboA(self)
	}
	
	method leRoboA(unEmpleado){
		return unEmpleado.reservas().any({reserva => self.hizoOperacion(reserva)})
	}
	
	method hizoOperacion(unaOperacion){
		return operacionesCerradas.contains(unaOperacion)
	}
	
	
	method reservar(operacion, cliente){
		operacion.reservarPara(cliente)
		reservas.add(operacion)
	}
	
	method concretarOperacion(operacion, cliente){
		operacion.concretarPara(cliente)
		operacionesCerradas.add(operacion)
	}
	
	
}

class Cliente {
	
}


