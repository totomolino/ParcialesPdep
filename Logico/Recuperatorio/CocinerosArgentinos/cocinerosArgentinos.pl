
% principal(nombre, calorias)
% entrada(nombre, ingredientes, calorias)
% posatre(nombre , saborPrincipal, calorias)




%cocina(nombre, plato, puntos)
cocina(mariano, principal(nioquis, 50), 80).
cocina(julia, principal(pizza, 100), 60).
cocina(hernan, postre(panqueque, dulceDeLeche, 100), 60).
cocina(hernan, postre(trufas, dulceDeLeche, 60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50), 50).
cocina(susana, postre(pastelito, dulceDeMembrillo, 50), 60).
cocina(melina, postre(torta, zanahoria, 60),50).


esAmigo(mariano, susana).
esAmigo(mariano, hernan).
esAmigo(hernan, pedro).
esAmigo(melina, carlos).
esAmigo(carlos, susana).




%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

esComidaSaludable(Comida):-
    cocina(_, Comida , _),
    esPlatoSaludable(Comida).


esPlatoSaludable(postre(_,_, Calorias)):- Calorias < 100.

esPlatoSaludable(entrada(_, _, Calorias)):- Calorias =< 60.

esPlatoSaludable(principal(_,Calorias)):- 
    between(70, 90, Calorias).


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

% soloSalado/1 permite conocer si un cocinero no hace ningún postre.


soloSalado(Cocinero):-
    cocinero(Cocinero),
    not(cocina(Cocinero, postre(_,_,_) , _)).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

    
% tieneUnaGranFama/1 verificar si un cocinero tiene el máximo nivel de puntuación. El nivel de puntuación de un cocinero se calcula sumando el nivel de puntuación de cada uno de los platos.

cocinero(Cocinero):-
cocina(Cocinero, _, _).


tieneUnaGranFama(Cocinero):-
    cocinero(Cocinero),
    famaTotal(Cocinero, PuntacionMaxima),
    forall(famaTotal(_ , OtraPuntuacion) , PuntacionMaxima >= OtraPuntuacion ).



famaTotal(Cocinero , FamaTotal):-
    cocinero(Cocinero),
    findall(Punto , cocina(Cocinero, _ , Punto ), PuntosPorPlato),
    sum_list(PuntosPorPlato, FamaTotal).


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


noEsSaludable(Cocinero) :-
    cocina(Cocinero, Plato, _),
    esPlatoSaludable(Plato),
    forall((cocina(Cocinero, OtroPlato ,_) , OtroPlato \= Plato ) , not(esPlatoSaludable(OtroPlato)) ).


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


popular(carne).
popular(dulceDeLeche).
popular(dulceDeMembrillo).




noUsaIngredientesPopulares(Cocinero):-
    cocinero(Cocinero),
    forall(cocina(Cocinero, Plato, _) , not(platoConIngredientePopular(Plato))).

platoConIngredientePopular(postre(_,Ingrediente, _)):-
    cocina(_, postre(_, Ingrediente,_) , _),
    popular(Ingrediente).

platoConIngredientePopular(entrada(_,Ingredientes , _)) :- 
    cocina(_, entrada(_,Ingredientes, _) , _),
    member(Ingrediente, Ingredientes),
    popular(Ingrediente).



%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%

platoUsaIngrediente(postre(_, Ingrediente, _), Ingrediente) :- cocina(_, postre(_, Ingrediente, _), _).
platoUsaIngrediente(entrada(_, Ingredientes, _), Ingrediente) :- cocina(_, entrada(_, Ingredientes, _), _), member(Ingrediente, Ingredientes).


ingrediente(Ingrediente) :- cocina(_, entrada(_, Ingredientes, _), _), member(Ingrediente, Ingredientes).
ingrediente(Ingrediente) :- cocina(_, postre(_, Ingrediente, _), _).


ingredientePopularMasUsado(Cocinero, Ingrediente):-
    cocinero(Cocinero),
    ingrediente(Ingrediente),
    popular(Ingrediente),
    platoUsaIngrediente(Plato , Ingrediente).


%%%%%%%%%%%%%
%% Punto 7 %%
%%%%%%%%%%%%%


esRecomendadoPorColega(UnCocinero, OtroCocinero):-
    cocinero(UnCocinero),
    cocinero(OtroCocinero),
    not(noEsSaludable(OtroCocinero)),
    amistad(UnCocinero, OtroCocinero).

amistad(Uno, Otro):-
    esAmigo(Uno, Otro).

amistad(Uno, Otro) :-
    esAmigo(Uno, E),
    esAmigo(E, Otro).












