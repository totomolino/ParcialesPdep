

cantante(megurineLuka, cancion(nightFever , 4)).
cantante(megurineLuka, cancion(foreverYoung , 5)).
cantante(hatsuneMiku, cancion(tellYourWorld , 4)).
cantante(gumi, cancion(foreverYoung, 4)).
cantante(gumi, cancion(tellYourWorld , 4)).
cantante(seeU, cancion(novemberRain, 6)).
cantante(seeU, cancion(nightFever, 5)).
cantante(seeU, cancion(nightFever, 5)).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%



esNovedoso(Vocaloid):-
    sabeAlMenos(Vocaloid , 2),
    tiempoTotalCanciones(Vocaloid, Tiempo),
    Tiempo < 15 .

% sabeAlMenos2(Vocaloid):-
% cantante(Vocaloid, UnaCancion),
% cantante(Vocaloid, OtraCancion),
% UnaCancion \= OtraCancion.


tiempoTotalCanciones(Vocaloid, TiempoTotal):-
    vocaloid(Vocaloid),
    findall(Tiempo, tiempoXCancion(Vocaloid, Tiempo) , TodosLosTiempos),
    sum_list(TodosLosTiempos, TiempoTotal).
    

tiempoXCancion(Vocaloid, Tiempo):-
    cantante(Vocaloid, Cancion),
    tiempoCancion(Cancion, Tiempo).


tiempoCancion(cancion(_,Tiempo), Tiempo).



%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

vocaloid(Vocaloid):- cantante(Vocaloid, _).


esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    not((tiempoXCancion(Vocaloid, Tiempo) , Tiempo > 4)).



%%%%%%%%%%%%%%%
%%  Parte 2  %%
%%%%%%%%%%%%%%%



%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%



% concierto(nombre, pais, cantidadDeFama, tipo)

% tipos: gigante(cantidadMinimaDeCanciones, DuracionTotalMinima)
%        mediano(DuracionTotalMaxima)
%        pequenio(DuracionMinimadeUnaCancion)




concierto(mikuExpo, eeuu, 2000 , gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100 , pequenio(4)).




%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


puedeParticipar(hatsuneMiku, Concierto):- concierto(Concierto, _, _ , _).

puedeParticipar(Vocaloid, Concierto):-
    vocaloid(Vocaloid),
    Vocaloid \= hatsuneMiku,
    concierto(Concierto, _, _ , Requiere),
    cumpleRequisitos(Vocaloid, Requiere).


cumpleRequisitos(Vocaloid, pequenio(DuracionMinima)):-
    tiempoXCancion(Vocaloid, Tiempo),
    Tiempo > DuracionMinima.

cumpleRequisitos(Vocaloid, mediano(DuracionTotalMaxima)):-
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    TiempoTotal < DuracionTotalMaxima.

cumpleRequisitos(Vocaloid, gigante(CantidadMinima, DuracionMinima)):-
    sabeAlMenos(Vocaloid, CantidadMinima),
    tiempoTotalCanciones(Vocaloid, TiempoTotal),
    TiempoTotal > DuracionMinima.


sabeAlMenos(Vocaloid, Cantidad):-
    cantidadDeCanciones(Vocaloid, CantidadDeCanciones),
    CantidadDeCanciones >= Cantidad.


cantidadDeCanciones(Vocaloid, Cantidad):-
    vocaloid(Vocaloid),
    findall(Cancion, cantante(Vocaloid, Cancion) , Canciones),
    length(Canciones, Cantidad).


%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%



nivelDeFama(Vocaloid, Nivel):-
    famaTotal(Vocaloid, FamaTotal),
    cantidadDeCanciones(Vocaloid, Cantidad),
    Nivel is FamaTotal * Cantidad.


famaTotal(Vocaloid, FamaTotal):-
    vocaloid(Vocaloid),
    findall(Fama, famaConcierto(Vocaloid, Fama), CantidadFamas),
    sum_list(CantidadFamas, FamaTotal).

famaConcierto(Vocaloid, Fama):-
    puedeParticipar(Vocaloid, concierto(_,_,Fama,_)).


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).



esUnico(Vocaloid, Concierto):-
    puedeParticipar(Vocaloid, Concierto),
    not((conocido(Vocaloid, OtroVocaloid), puedeParticipar(OtroVocaloid, Concierto))).

conocido(Vocaloid, OtroVocaloid):-
    conoce(Vocaloid, OtroVocaloid).

conocido(Vocaloid, OtroVocaloid):-
    conoce(Vocaloid, UnVocaloid),
    conoce(UnVocaloid, OtroVocaloid).


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%



% Habria que agregar una condicion a cumpleRequerimientos/2 para tener en cuenta el nuevo tipo de concierto y lo que hace. Esto es posible por el polimorfismo.






















































