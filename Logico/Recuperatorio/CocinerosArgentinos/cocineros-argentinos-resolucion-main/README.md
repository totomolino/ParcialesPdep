## cocineros-argentinos-resolucion

Créditos @martorres-utn

# Enunciado

## Cocineros Argentinos

Un grupo de jóvenes cocinero abrieron una empresa de comidas y nos pidieron un sistema que los ayude con la organización de sus platos

Sabemos que hay 3 tipos de comidas:
* **Plato principal** del cual conocemos el nombre de la comida y la cantidad de calorías.
* **Entrada** de la cual sabemos el nombre, los ingredientes y la cantidad de calorías.
* **Postre** del cual se conoce el nombre, el sabor principal y la cantidad de calorías que aporta.

Además se conoce de cada cocinero la comida que sabe realizar y el nivel de puntuación de dicho plato. Inicialmente nos dan esta base de conocimiento, pero se puede ampliar en un futuro. Se sabe:

```prolog
%cocina(nombre, plato, puntos)
cocina(mariano, principal(nioquis, 50), 80).
cocina(julia, principal(pizza, 100), 60).
cocina(hernan, postre(panqueque, dulceDeLeche, 100), 60).
cocina(hernan, postre(trufas, dulceDeLeche, 60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50), 50).
cocina(susana, postre(pastelito, dulceDeMembrillo, 50), 60).
cocina(melina, postre(torta, zanahoria, 60),50).
```
Mariano es amigo de Susana y de Hernán
Hernán es amigo de Pedro
Melina es amiga de Carlos
Carlos es amigo de Susana
Susana no tiene amigos

Se sabe que algunos ingredientes son populares como por ejemplo: la carne, el dulce de leche y el dulce de membrillo, etc. Se sabe en cambio que hay otros ingredientes como la cebolla, la zanahoria que no son ingredientes populares.
* Completar la base de conocimiento con todo lo necesario, si hay algo que no se agrega explicar por qué.
Definir los siguientes predicados de manera que sean **totalmente inversibles**. Usar recursividad sólo si es necesario.

1)	Verificar si una comida es saludable, se considera saludable si es:
* postre tiene que tener menos de 100 calorías.
* entrada no puede superar las 60 calorías.
* plato principal tiene que estar entre 70 y 90 calorías.

2)	soloSalado/1 permite conocer si un cocinero no hace ningún postre.

3)	tieneUnaGranFama/1 verificar si un cocinero tiene el máximo nivel de puntuación. El nivel de puntuación de un cocinero se calcula sumando el nivel de puntuación de cada uno de los platos.

4)	noEsSaludable/1 verificar si un cocinero no es saludable, es decir de todos los platos que elabora hay uno sólo que es saludable el resto no lo son.

5)	noUsaIngredientesPopulares/1 verificar si un cocinero no usa ingredientes populares en ninguno de sus platos.

6)	ingredientePopularMasUsado/2 relaciona un cocinero con el ingrediente popular que más utiliza en sus comidas.

7)	esRecomendadoPorColega/2 verificar si un cocinero puede ser recomendado por otro si es un cocinero saludable y además se cumple que:
*	si es amigo de un cocinero.
*	O si es amigo de un amigo o de un amigo que es cocinero (tener en cuenta cualquier nivel de amistad).
