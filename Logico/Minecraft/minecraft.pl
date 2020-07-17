jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


% a

tieneItem(Jugador, Item) :-
    jugador(Jugador, Items, _),
    member(Item, Items). 

% b

sePreocupaPorSuSalud(Jugador) :-
    tieneItem(Jugador, UnItem),
    tieneItem(Jugador, OtroItem),
    comestible(UnItem),
    comestible(OtroItem),
    UnItem \= OtroItem.


% c



cantidadDelItem(Jugador, Item, Cantidad) :-
    tieneItem(_,Item),
    jugador(Jugador, _, _),
    findall(Item, tieneItem(Jugador, Item) , Repetidos),
    length(Repetidos, Cantidad).



% d

tieneMasDe(Jugador, Item) :-
    cantidadDelItem(Jugador,Item,CantidadMayor),
    findall(Cantidad, cantidadDelItem(_,Item,Cantidad), Cantidades),
    forall(member(CantidadMinima, Cantidades) , CantidadMayor >= CantidadMinima).




%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


% a

hayMounstruo(Lugar) :-
    lugar(Lugar,_,NivelDeOscuridad),
    NivelDeOscuridad > 6.

% b 

correPeligro(Jugador) :-
    estaEn(Jugador, Lugar),
    hayMounstruo(Lugar).

correPeligro(Jugador) :-
    estaEn(Jugador, _),
    tieneHambreSinMorfi(Jugador).


estaEn(Jugador, Lugar) :-
    jugador(Jugador, _, _),
    lugar(Lugar, Personas, _),
    member(Jugador, Personas).

tieneHambreSinMorfi(Jugador) :-
    tieneHambre(Jugador),
    forall(tieneItem(Jugador, Item), not(comestible(Item))).


tieneHambre(Jugador) :-
    jugador(Jugador, _, Hambre),
    Hambre < 4.



% c

estaPoblado(Lugar):-
    lugar(Lugar,Poblacion,_),
    length(Poblacion,C),
    C>0.

nivelPeligrosidad(Lugar, Nivel) :-
    estaPoblado(Lugar),
    not(hayMounstruo(Lugar)),
    nivelSegunPoblacion(Lugar, Nivel).

nivelPeligrosidad(Lugar, 100) :-
    estaPoblado(Lugar),
    hayMounstruo(Lugar).

nivelPeligrosidad(Lugar, Nivel) :-
    lugar(Lugar, _ , Oscuridad),
    not(estaPoblado(Lugar)),
    Nivel is Oscuridad * 10.
    

nivelSegunPoblacion(Lugar, Nivel) :-
    lugar(Lugar,Habitantes,_),
    hambrientos(Lugar, Hambrientos),
    length(Hambrientos, CantidadHambrientos),
    length(Habitantes, PoblacionTotal),
    Nivel is (CantidadHambrientos*100) / PoblacionTotal. 

hambrientos(Lugar, Hambrientos) :-
    lugar(Lugar,_,_),
    findall(Jugador, (tieneHambre(Jugador) , estaEn(Jugador, Lugar)), Hambrientos).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%


item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).



% puedeConstruir(Jugador, Item) :-
%     item(Item, Materiales),
%     forall(mecantidadDelItem(Jugador, Material, CuantoMaterial).
