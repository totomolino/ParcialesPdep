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


satisfaceNecesidad(Persona, Herramienta):- tiene(Persona, Herramienta).

satisfaceNecesidad(Persona, aspiradora(PotenciaRequerida)):- 
    tiene(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.
%   between(0, Potencia, PotenciaRequerida).


% 6 

satisfaceNecesidad(Persona, ListaReemplazables):-
    member(Herramienta, ListaReemplazables),
    satisfaceNecesidad(Persona, Herramienta).


%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

puedeHacerTarea(Persona, Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Persona,varitaDeNeutrones).


puedeHacerTarea(Persona, Tarea):-
    tiene(Persona,_),
    herramientasRequeridas(Tarea, HerramientasRequeridas),
    forall(member(Herramienta, HerramientasRequeridas) , satisfaceNecesidad(Persona, Herramienta)).


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


tareaPedida(Cliente, Tarea , Area).

precio(Tarea, PrecioPorMetroCuadrado).


cuantoCobro(Cliente, PrecioFinal):-
    tareaPedida(Cliente, _, _),
    findall(Precio, valorTareaPedida(_, Cliente, Precio), Precios),
    sum_list(Precios, PrecioFinal).


valorTareaPedida(Tarea, CLiente, Precio):-
    tareaPedida(CLiente, Tarea, Area),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is Area * PrecioPorMetroCuadrado.



%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


tareaCompleja(limpiarTecho).

tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, CuantasHerramientas),
    CuantasHerramientas > 2.


aceptaPedido(Trabajador, Cliente):-
    puedeHacerPedido(Trabajador, Cliente),
    estaDispuestoAHacer(Trabajador, Cliente).


% estaDispuestoAHacer(Trabajador, Cliente)

estaDispuestoAHacer(peter, _).


estaDispuestoAHacer(ray, Cliente):-
    tareaPedida(Cliente, _ , _),
    not(tareaPedida(Cliente, limpiarTecho,_)).
 %   forall(tareaPedida(Cliente, Tarea, _) , Tarea \= limpiarTecho).

estaDispuestoAHacer(winston, Cliente):-
    cuantoCobro(Cliente, Precio),
    Precio >= 500.

estaDispuestoAHacer(egon, Cliente):-
    tareaPedida(Cliente,_ , _),
    not((tareaPedida(Cliente,Tarea,_) , tareaCompleja(Tarea))).
%    forall(tareaPedida(Cliente, Tarea, _) , not(tareaCompleja(Tarea))).


puedeHacerPedido(Trabajador, Cliente):-
    tareaPedida(Cliente, _, _),
    tiene(Trabajador,_),
    forall(tareaPedida(Cliente, Tarea, _) , puedeHacerTarea(Trabajador, Tarea)).



%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%