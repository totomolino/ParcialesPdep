

class Maquina{
	
	const property requiereHerramientas 
	
	const property complejidad
	
	const property dificultad = 2 * complejidad
	
	const property herramientasRequeridas = []
	
	method herramientasSirven(herramientas){
		return herramientas.all({herramienta => herramientasRequeridas.contains(herramienta)})
	}
	
	
}