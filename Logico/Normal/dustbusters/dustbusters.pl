herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

satisfaceHerramienta(Persona, Herramienta) :-
    tiene(Persona, Herramienta).

satisfaceHerramienta(Persona, aspiradora(NivelRequerido)) :-
    tiene(Persona, aspiradora(NivelPersona)),
    NivelPersona >= NivelRequerido.


%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%


puedeRealizarTarea(Persona, Tarea) :-
    herramientasRequeridas(Tarea, _),
    tiene(Persona, varitaDeNeutrones).

puedeRealizarTarea(Persona, Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    tiene(Persona, _),
    forall(member(Herramienta, Herramientas),satisfaceHerramienta(Persona,Herramienta)).



%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

% tareaPedida(Cliente, Tarea, MetrosCuadrados).

tareaPedida(jose, ordenarCuarto, 30).

% precio(Tarea, Precio).

precio(ordenarCuarto, 5).

precioPorTarea(Cliente, Tarea, Precio) :-
    tareaPedida(Cliente, Tarea, Metros),
    precio(Tarea, PrecioXMetro),
    Precio is PrecioXMetro * Metros.
    

cobrarCliente(Cliente, PrecioFinal) :-
    tareaPedida(Cliente,_, _),
    findall(Precio, precioPorTarea(Cliente, _, Precio), TodosLosPrecios),
    sum_list(TodosLosPrecios, PrecioFinal).
    

%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


aceptaPedido(Empleado, Cliente) :-
    puedeHacerlo(Empleado, Cliente),
    estaDispuestoHacerlo(Empleado, Cliente).


puedeHacerlo(Empleado, Cliente) :-
    tiene(Empleado, _),
    tareaPedida(Cliente, _,_),
    forall(tareaPedida(Cliente,Tarea,_) , puedeHacerlo(Empleado, Tarea)).

estaDispuestoHacerlo(peter, _).

estaDispuestoHacerlo(ray, Cliente) :-
    not(tareaPedida(Cliente, limpiarTecho, _)).

estaDispuestoHacerlo(winston, Cliente) :-
    cobrarCliente(Cliente, PrecioFinal),
    PrecioFinal > 500.

estaDispuestoHacerlo(egon, Cliente) :-
    forall(tareaPedida(Cliente, Tarea, _), not(tareaCompleja(Tarea))).


tareaCompleja(limpiarTecho).

tareaCompleja(Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, CuantasHerramientas),
    CuantasHerramientas > 2.
    

%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%

% es teorico alta paja
