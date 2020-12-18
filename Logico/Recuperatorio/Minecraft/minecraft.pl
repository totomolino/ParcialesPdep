
% jugador(nombre, items, nivelDeHambre)

jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).


% lugar(seccion, jugadores, nivelDeOscuridad )

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).


% comestible(Item)

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


% a  Relacionar un jugador con un ítem que posee. tieneItem/2


tieneItem(Jugador, Item):-
    jugador(Jugador, Items, _),
    member(Item , Items).


% b Saber si un jugador se preocupa por su salud, esto es si tiene entre sus ítems más de un tipo de comestible. (Tratar de resolver sin findall) sePreocupaPorSuSalud/1


sePreocupaPorSuSalud(Jugador):-
    tieneItem(Jugador, UnItem),
    tieneItem(Jugador, OtroItem),
    UnItem \= OtroItem,
    comestible(UnItem),
    comestible(OtroItem).


% c Relacionar un jugador con un ítem que existe (un ítem existe si lo tiene alguien), y la cantidad que tiene de ese ítem. Si no posee el ítem, la cantidad es 0. cantidadDeItem/3


esItem(Item):-
    tieneItem(_, Item).

cantidadDelItem(Jugador, Item, Cantidad):-
    esItem(Item),
    esJugador(Jugador),
    findall(Item, tieneItem(Jugador , Item), Items),
    length(Items, Cantidad).


esJugador(Jugador):-
    jugador(Jugador,_,_).


% d Relacionar un jugador con un ítem, si de entre todos los jugadores, es el que más cantidad tiene de ese ítem. tieneMasDe/2

tieneMasde(Jugador, UnItem):-
    esItem(UnItem),
    esJugador(Jugador),
    cantidadDelItem(Jugador, UnItem, Cantidad),
    forall((cantidadDelItem(OtroJugador, UnItem, OtraCantidad) , OtroJugador \= Jugador) , OtraCantidad < Cantidad).



%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

% a Obtener los lugares en los que hay monstruos. Se sabe que los monstruos aparecen en los lugares cuyo nivel de oscuridad es más de 6. hayMonstruos/1


hayMonstruos(UnLugar):-
    lugar(UnLugar,_,Nivel),
    Nivel > 6.


esLugar(UnLugar):- lugar(UnLugar,_,_).


% b Saber si un jugador corre peligro. Un jugador corre peligro si se encuentra en un lugar donde hay monstruos; o si está hambriento (hambre < 4) y no cuenta con ítems comestibles. correPeligro/1

correPeligro(UnJugador):-
    estaEn(UnJugador, UnLugar),
    hayMonstruos(UnLugar).

correPeligro(UnJugador):-
    estaHambriento(UnJugador),
    not(tieneComida(UnJugador)).


tieneComida(Jugador):-
    tieneItem(Jugador, Item),
    comestible(Item).


estaHambriento(Jugador):-
    jugador(Jugador, _ , NivelDeHambre),
    NivelDeHambre < 4.


estaEn(Jugador, Lugar):-
    lugar(Lugar, Lista, _),
    member(Jugador, Lista).


% c Obtener el nivel de peligrosidad de un lugar, el cual es un número de 0 a 100 y se calcula:
% - Si no hay monstruos, es el porcentaje de hambrientos sobre su población total.
% - Si hay monstruos, es 100.
% - Si el lugar no está poblado, sin importar la presencia de monstruos, es su nivel de oscuridad * 10. nivelPeligrosidad/2

estaPoblado(Lugar):-
    cantidadDeHabitantes(Lugar, Cantidad),
    Cantidad > 0.

cantidadDeHabitantes(Lugar, Cantidad):-
    lugar(Lugar, Poblacion,_),
    length(Poblacion, Cantidad).

nivelPeligrosidad(Lugar, NivelFinal):-
    not(estaPoblado(Lugar)),
    lugar(Lugar, _, Nivel),
    NivelFinal is Nivel * 10.

nivelPeligrosidad(Lugar, Nivel):-
    estaPoblado(Lugar),
    calcularNivel(Lugar, Nivel).

calcularNivel(Lugar, Nivel):-
    not(hayMonstruos(Lugar)),
    lugar(Lugar, Poblacion,_),
    length(Poblacion, Nivel).

calcularNivel(Lugar, 100):-
    hayMonstruos(Lugar).




%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%


item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).



puedeConstruir(Jugador, Item):-
    item(Item, Requerimientos),
    cumpleRequerimientos(Jugador, Requerimientos).

cumpleRequerimientos(Jugador, Requerimientos):-
    member(Requerimiento, Requerimientos),
    cumpleRequerimiento(Jugador, Requerimiento).

cumpleRequerimiento(Jugador, itemSimple(Item, Cantidad)):-
    cantidadDelItem(Jugador, Item, CantidadPoseida),
    CantidadPoseida >= Cantidad.

cumpleRequerimiento(Jugador, itemCompuesto(Item)):-
    puedeConstruir(Jugador, Item).




%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


% a)
% Lo que pasa es que desierto no es un lugar en nuestro universo, en el predicado nivelPelgrosidad/2 llama a estaPoblado/1 , donde necesariamente tiene que cumplir lugar(Lugar, _, _),
% en otras palabras, tiene que ser un lugar.


% b)

% Es mas dinamico, esta pensado para hacer consultas, tener una base de conocimiento y consultar hechos sobre esta, en funcional, ni se guardan las "variables" que creamos. No las podes modificar
% por lo tanto, no podriamos tener una base de conocimiento.

