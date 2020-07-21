% a)

vocaloid(megurineLuka, cancion(nightFever,4)).
vocaloid(megurineLuka, cancion(foreverYoung,5)).
vocaloid(hatsuneMiku, cancion(tellYourWorld, 4)).
vocaloid(gumi, cancion(tellYourWorld, 5)).
vocaloid(gumi, cancion(foreverYoung, 4)).
vocaloid(seeU, cancion(novemberRain, 6)).
vocaloid(seeU, cancion(nightFever, 5)).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


vocaloidNovedoso(Vocaloid) :-
    vocaloid(Vocaloid, _),
    cuantasCanciones(Vocaloid, Cuantas),
    tiempoTotal(Vocaloid, Tiempo),
    Cuantas >= 2,
    Tiempo < 15.
    
    
cuantasCanciones(Vocaloid, Cuantas) :-    
    canciones(Vocaloid, Canciones),
    length(Canciones, Cuantas).

tiempoTotal(Vocaloid, Tiempo) :-
    findall(Duracion, (cuantoDura(Cancion, Duracion), vocaloid(Vocaloid, Cancion)) , Duraciones),
    sum_list(Duraciones, Tiempo).
    
cuantoDura(cancion(_,Duracion) , Duracion).




canciones(Vocaloid, Canciones) :-
    findall(Cancion, vocaloid(Vocaloid, Cancion) , Canciones).



%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


acelerado(Vocaloid) :-
    vocaloid(Vocaloid, _),
    %forall(vocaloid(Vocaloid, Cancion) , duraMenosDe4(Cancion)).
    not((vocaloid(Vocaloid, Cancion) , not(duraMenosDe4(Cancion)))).


duraMenosDe4(Cancion) :-
    cuantoDura(Cancion, Duracion),
    Duracion =< 4.


%  b)

% concierto(Nombre, Lugar, Fama, Tipo).

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100 , pequenio(4)).

% 2)

puedeParticipar(hatsuneMiku, Concierto) :-
    concierto(Concierto, _, _,_).

puedeParticipar(Cantante, Concierto):-
	vocaloid(Cantante, _),
	Cantante \= hatsuneMiku,
	concierto(Concierto, _, _, Requisitos),
	cumpleRequisitos(Cantante, Requisitos).



cumpleRequisitos(Vocaloid, gigante(MinimoCanciones, TiempoMinimo)) :-
    cuantasCanciones(Vocaloid, CuantasCanciones),
    tiempoTotal(Vocaloid, Tiempo),
    CuantasCanciones > MinimoCanciones,
    Tiempo >= TiempoMinimo.

cumpleRequisitos(Vocaloid, mediano(TiempoMaximo)) :-
    tiempoTotal(Vocaloid, Tiempo),
    Tiempo =< TiempoMaximo.

cumpleRequisitos(Vocaloid, pequenio(Duracion)) :-
    vocaloid(Vocaloid, Cancion),
    cuantoDura(Cancion, Tiempo),
    Tiempo > Duracion.


% 3 



elMasFamoso(Vocaloid) :-
    nivelDeFama(Vocaloid, FamaMayor),
    forall(nivelDeFama(_, OtroNivel) , FamaMayor >= OtroNivel).





nivelDeFama(Vocaloid, Fama) :-
    vocaloid(Vocaloid, _),
    cuantasCanciones(Vocaloid, Canciones),
    famaPorConciertos(Vocaloid, FamaConcierto),
    Fama is FamaConcierto * Canciones.


famaPorConciertos(Vocaloid, Fama) :-
    findall(Nivel, puedeParticiparConNivel(Vocaloid, _, Nivel) , ListaFama),
    sum_list(ListaFama, Fama).
    



puedeParticiparConNivel(Vocaloid, Concierto, Nivel) :-
    puedeParticipar(Vocaloid, Concierto),
    concierto(Concierto, _, Nivel, _).



% 4

conoceA(megurineLuka, hatsuneMiku).
conoceA(megurineLuka, gumi).
conoceA(gumi, seeU).
conoceA(seeU, kaito).


esConocido(Vocaloid, OtroVocaloid) :-
    conoceA(Vocaloid, OtroVocaloid).

esConocido(Vocaloid, OtroVocaloid) :-
    conoceA(Vocaloid, OtroMasVocaloid),
    conoceA(OtroMasVocaloid, OtroVocaloid).



participaSolo(Vocaloid, Concierto) :-
    vocaloid(Vocaloid, _),
    concierto(Concierto, _, _, _),
    forall(puedeParticipar(OtroVocaloid, Concierto) , not(esConocido(Vocaloid, OtroVocaloid))).



% 5

% teniendo los datos necesarios, agregaria un tipo mas de concierto, cambiando, por ejemplo. si puede participar en el concierto