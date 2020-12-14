personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).


amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


esPeligroso(Personaje) :- 
    personaje(Personaje, mafioso(maton)).
    
   esPeligroso(Personaje) :-
    robaLicores(Personaje).
   
   esPeligroso(Personaje) :-
    empleadoPeligroso(Personaje).
    
   robaLicores(Personaje) :-
    personaje(Personaje, ladron([licorerias,_])).

empleadoPeligroso(Personaje) :-
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

duoTemible(Personaje1 , Personaje2) :-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    sonParejaOAmigos(Personaje1, Personaje2).


sonParejaOAmigos(Personaje1, Personaje2) :-
    pareja(Personaje1, Personaje2).

sonParejaOAmigos(Personaje1, Personaje2) :-
    amigo(Personaje1, Personaje2).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


estaEnProblemas(butch).

estaEnProblemas(Personaje) :-
    trabajaPara(Jefe, Personaje),
    esPeligroso(Jefe),
    pareja(Jefe, Pareja),
    encargo(Jefe, Personaje, cuidar(Pareja)).

estaEnProblemas(Personaje) :-
    encargo(_,Personaje, buscar(Boxeador, _)),
    esBoxeador(Boxeador).

esBoxeador(Boxeador) :-
    personaje(Boxeador, boxeador).



%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

% tieneCerca(Uno, Otro) :-
%     amigo(Otro, Uno).

sanCayetano(Persona) :-
    personaje(Persona,_),
    forall(tieneCerca(Persona,Alguien),leDaTrabajo(Persona,Alguien)).

tieneCerca(Uno, Otro) :-
    amigo(Uno, Otro).

tieneCerca(Uno, Otro) :-
    trabajaPara(Uno, Otro). 
    
leDaTrabajo(Persona,Alguien):-
    encargo(Persona,Alguien,_) .
    


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


elMasAtareado(PersonaAtareada) :- 
    personaje(PersonaAtareada, _),
    forall(personaje(Persona,_), not(supera(Persona, PersonaAtareada))).



supera(Persona1 , Persona2) :-
     cuantasTareas(Persona1, Tareas),
     cuantasTareas(Persona2, TareasPersona),
    Tareas > TareasPersona.



cuantasTareas(Persona, CuantasTareas) :-
    tareas(Persona, Tareas),
    length(Tareas, CuantasTareas).

    

tareas(Persona, Tareas) :-
    findall(Tarea, encargo(_,Persona, Tarea) , Tareas).



    

%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%


personajesRespetables(Respetables) :-
    findall(Personaje, esRespetable(Personaje), Respetables).

esRespetable(Personaje) :-
    nivel(Personaje, Nivel),
    Nivel > 9.

nivel(Personaje, Nivel) :-
    personaje(Personaje, actriz(Peliculas)),
    length(Peliculas, CuantasPelis),
    Nivel is CuantasPelis / 10.

nivel(Personaje, 10) :-
    personaje(Personaje, mafioso(resuelveProblemas)).

nivel(Personaje, 1) :-
    personaje(Personaje, mafioso(maton)).

nivel(Personaje, 10) :-
    personaje(Personaje, mafioso(capo)).

nivel(Personaje, 0) :-
    personaje(Personaje, _).


%%%%%%%%%%%%%
%% Punto 7 %%
%%%%%%%%%%%%%

hartoDe(Personaje1, Personaje2) :-
    personaje(Personaje1,_),
    personaje(Personaje2,_),
    forall(encargo(_,Personaje1,_) , interactuanCon(Personaje1, Personaje2)).

interactuanCon(Personaje1, Personaje2) :-
    encargo(_,Personaje1, cuidar(Personaje2)).

interactuanCon(Personaje1, Personaje2) :-
    encargo(_,Personaje1, buscar(Personaje2,_)).

interactuanCon(Personaje1, Personaje2) :-
    encargo(_,Personaje1, ayudar(Personaje2)).

interactuanCon(Personaje1, Personaje2) :-
    amigo(Personaje2, Amigo),
    encargo(_,Personaje1, cuidar(Amigo)).

interactuanCon(Personaje1, Personaje2) :-
    amigo(Personaje2, Amigo),
    encargo(_,Personaje1, buscar(Amigo,_)).

interactuanCon(Personaje1, Personaje2) :-
    amigo(Personaje2, Amigo),
    encargo(_,Personaje1, ayudar(Amigo)).


%%%%%%%%%%%%%
%% Punto 8 %%
%%%%%%%%%%%%%

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).


duoDiferenciable(Persona1, Persona2) :-
    sonParejaOAmigos(Persona1, Persona2),
    caracteristicas(Persona1, Caracs1),
    caracteristicas(Persona2, Caracs2),
    member(Carac, Caracs1),
    not(member(Carac, Caracs2)).
    