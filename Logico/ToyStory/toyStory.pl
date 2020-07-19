% Relaciona al dueño con el nombre del juguete
% y la cantidad de años que lo ha tenido

duenio(andy, woody, 8).
duenio(andy, buzz, 1).
duenio(sam, jessie, 3).

% Relaciona al juguete con su nombre
% los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)

juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa, caraDePapa([ original(pieIzquierdo), original(pieDerecho), repuesto(nariz) ])).



% Dice si un juguete es raro

esRaro(deAccion(stacyMalibu, 1, [sombrero])).

% Dice si una persona es coleccionista

esColeccionista(sam).

%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

% a

tematica(Juguete, caraDePapa) :-
    juguete(Juguete, caraDePapa(_)).

tematica(Juguete, Tematica) :-
    juguete(Juguete, Tipo),
    tematicaTipo(Tipo, Tematica).

tematicaTipo(deTrapo(Tematica), Tematica).
tematicaTipo(deAccion(Tematica, _), Tematica).
tematicaTipo(miniFiguras(Tematica, _), Tematica).


% b 

esDePlastico(Juguete) :-
    esCaraDePapa(Juguete).

esDePlastico(Juguete) :-
    juguete(Juguete, miniFiguras(_,_)).

    
esCaraDePapa(Juguete) :-
    juguete(Juguete, caraDePapa(_)).

% c

esDeColeccion(Juguete) :-
    juguete(Juguete, Caracteristicas),
    esJugueteDeAccionOCaraDePapa(Juguete),
    esRaro(Caracteristicas).

esDeColeccion(Juguete) :-
    esJugueteDeTrapo(Juguete).

esJugueteDeAccionOCaraDePapa(Juguete) :-
    esCaraDePapa(Juguete).

esJugueteDeAccionOCaraDePapa(Juguete) :-
    esJugueteDeAccion(Juguete).

esJugueteDeAccion(Juguete) :-
    juguete(Juguete, deAccion(_, _)).

esJugueteDeTrapo(Juguete) :-
    juguete(Juguete, deTrapo(_)).


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%






amigoFiel(Duenio, Juguete) :-
    duenio(Duenio, Juguete, Tiempo),
    not(esDePlastico(Juguete)),    
    forall((duenio(Duenio, OtroJuguete, MenorTiempo), not(esDePlastico(OtroJuguete))), Tiempo >= MenorTiempo).




%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%


superValioso(Juguete) :-
    esDeColeccion(Juguete),
    not(duenioColeccionista(Juguete)),
    todasPartesOriginales(Juguete).


duenioColeccionista(Juguete) :-
    duenio(Duenio, Juguete, _),
    esColeccionista(Duenio).

todasPartesOriginales(Juguete) :-
    juguete(Juguete, deAccion(_, Partes)),
    forall(member(Parte, Partes) , esOriginal(Parte)).

todasPartesOriginales(Juguete) :-
    juguete(Juguete, deTrapo(_)).


esOriginal(original(_)).


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

duoDinamico(Duenio, UnJuguete, OtroJuguete) :-
    duenio(Duenio, UnJuguete, _),
    duenio(Duenio, OtroJuguete, _),
    UnJuguete \= OtroJuguete,
    buenaPareja(UnJuguete, OtroJuguete).


buenaPareja(woody, buzz).

buenaPareja(UnJuguete, OtroJuguete) :-
    tematica(UnJuguete, Tematica),
    tematica(OtroJuguete, Tematica).