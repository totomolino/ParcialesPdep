%cocina(nombre, plato, puntos)
cocina(mariano, principal(ñoquis, 50), 80).
cocina(julia, principal(pizza, 100), 60).
cocina(hernan, postre(panqueque, dulceDeLeche, 100), 60).
cocina(hernan, postre(trufas, dulceDeLeche, 60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50), 50).
cocina(susana, postre(pastelito, dulceDeMembrillo, 50), 60).
cocina(melina, postre(torta, zanahoria, 60),50).

amigo(mariano, susana).
amigo(mariano, hernan).
amigo(hernan, pedro).
amigo(melina, carlos).
amigo(carlos, susana).

sonAmigos(Uno, Otro) :- amigo(Uno, Otro).
sonAmigos(Uno, Otro) :- amigo(Tercero, Otro), sonAmigos(Uno,Tercero).

% susana no tiene amigos: por el principio de "universo cerrado" del paradigma lógico, entonces este dato no forma parte de la base de conocimiento.

/*
Se sabe que algunos ingredientes son populares como por ejemplo: la carne, el
dulce de leche y el dulce de membrillo, etc. Se sabe en cambio que hay otros
ingredientes como la cebolla, la zanahoria que no son ingredientes populares.
● Completar la base de conocimiento con todo lo necesario, si hay algo que no
se agrega explicar por qué.
*/
popular(carne).
popular(dulceDeLeche).
popular(dulceDeMembrillo).

%Se sabe en cambio que hay otros ingredientes como la cebolla, la zanahoria que no son ingredientes populares
% Estos ingredientes que no son populares no son agregados a la base de conocimiento (principio de universo cerrado de paradigma lógico).

/*
Definir los siguientes predicados de maners que sean totalmente inversibles. Usar
recursividad sólo si es necesario.
*/

/*
1) Verificar si una comida es saludable, se considera saludable si es:
● postre tiene que tener menos de 100 calorías.
● entrada no puede superar las 60 calorías.
● plato principal tiene que estar entre 70 y 90 calorías.
*/
comidaSaludable(Comida):- cocina(_,Comida,_),esPlatoSaludable(Comida).
esPlatoSaludable(postre(_,_,Calorias)):- Calorias < 100.
esPlatoSaludable(entrada(_,_,Calorias)):- Calorias =<60.
esPlatoSaludable(principal(_,Calorias)):- between(70,90,Calorias).
/*
2) soloSalado/1 permite conocer si un cocinero no hace ningún postre.
*/

soloSalado(NombreCocinero) :- cocina(NombreCocinero, _, _), not(cocina(NombreCocinero, postre(_, _, _), _)).

/*
3) tieneUnaGranFama/1 verificar si un cocinero tiene el máximo nivel de
puntuación. El nivel de puntuación de un cocinero se calcula sumando el nivel
de puntuación de cada uno de los platos.
*/

nivelDePuntuacion(NombreCocinero, PuntuacionTotal) :-
    cocina(NombreCocinero, _, _), 
    findall(PuntuacionPlato, cocina(NombreCocinero, _, PuntuacionPlato), PuntosPorPlato),
    sum_list(PuntosPorPlato, PuntuacionTotal).

tieneUnaGranFama(NombreCocinero) :- 
    cocina(NombreCocinero, _, _), 
    nivelDePuntuacion(NombreCocinero, PuntuacionMaxima), 
    forall(nivelDePuntuacion(_, CualquierPuntuacion), CualquierPuntuacion =< PuntuacionMaxima).

/*
4) noEsSaludable/1 verificar si un cocinero no es saludable, es decir de todos
los platos que elabora hay uno sólo que es saludable el resto no lo son.
*/
noEsComidaSaludable(UnaComida):-not(comidaSaludable(UnaComida)).

noEsSaludable(Cocinero):- cocina(Cocinero,UnPlato,_),comidaSaludable(UnPlato),
    forall((cocina(Cocinero,OtroPlato,_), OtroPlato \= UnPlato),noEsComidaSaludable(OtroPlato)).
/*
5) noUsaIngredientesPopulares/1 verificar si un cocinero no usa ingredientes
populares en ninguno de sus platos.
*/

platoUsaIngrediente(postre(_, Ingrediente, _), Ingrediente) :- cocina(_, postre(_, Ingrediente, _), _).
platoUsaIngrediente(entrada(_, Ingredientes, _), Ingrediente) :- cocina(_, entrada(_, Ingredientes, _), _), member(Ingrediente, Ingredientes).

platoConIngredientePopular(postre(_, Ingrediente, _)) :- cocina(_, postre(_, Ingrediente, _), _), popular(Ingrediente).
platoConIngredientePopular(entrada(_, Ingredientes, _)) :- cocina(_, entrada(_, Ingredientes, _), _), member(Ingrediente, Ingredientes), popular(Ingrediente).

noUsaIngredientesPopulares(NombreCocinero) :-
    cocina(NombreCocinero, _, _), 
    forall(cocina(NombreCocinero, Plato, _), not(platoConIngredientePopular(Plato))).

/*
6) ingredientePopularMasUsado/2 relaciona un cocinero con el ingrediente
popular que más utiliza en sus comidas.
*/

ingrediente(Ingrediente) :- cocina(_, entrada(_, Ingredientes, _), _), member(Ingrediente, Ingredientes).
ingrediente(Ingrediente) :- cocina(_, postre(_, Ingrediente, _), _).

ingredientePopularMasUsado(NombreCocinero, Ingrediente) :-
    cocina(NombreCocinero, Plato, _), 
    ingrediente(Ingrediente),
    popular(Ingrediente),
    platoUsaIngrediente(Plato, Ingrediente).

/*
7) esRecomendadoPorColega/2 verificar si un cocinero puede ser
recomendado por otro si es un cocinero saludable y además se cumple que:
○ si es amigo de un cocinero.
○ O si es amigo de un amigo o de un amigo que es cocinero (tener en
cuenta cualquier nivel de amistad).
*/

esRecomendadoPorColega(UnCocinero, OtroCocinero) :- 
    cocina(UnCocinero, _, _), 
    cocina(OtroCocinero, _, _), 
    not(noEsSaludable(UnCocinero)),
    sonAmigos(OtroCocinero, UnCocinero).