% atiende(empleado, dia, desde, hasta)

atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

atiende(vale, Dia, Desde, Hasta):- atiende(dodain, Dia, Desde, Hasta).
atiende(vale, Dia, Desde, Hasta):- atiende(juanC, Dia, Desde, Hasta).


%por universo cerrado no se hace nada en los ultimos dos puntos


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


quienAtiende(Dia, Hora, Persona):- 
    atiende(Persona, Dia, Desde, Hasta),
    Desde =< Hora,
    Hasta >= Hora.



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

persona(Persona):-atiende(Persona,_,_,_).

dia(Dia):-atiende(_,Dia,_,_).

% trabajaSola(Persona, Dia).


trabajaSola(Persona, Dia, Hora):-
    quienAtiende(Dia, Hora, Persona),
    not((quienAtiende(Dia,Hora,OtraPersona) , OtraPersona \= Persona)).



%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


posibilidadesAtencion(Dia, Personas):-
    findall(Persona, atiende(Persona, Dia, _, _), Quienes),
    combinar(Quienes, Personas).


combinar([] , []).
combinar([Posible | Posibles] , [Posible | Personas] ):- combinar(Posibles, Personas).
combinar([_ | Posibles] , Personas) :- combinar(Posibles, Personas).



%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


ventas(dodain, lunes, 10, 8, [golosinas(1200) , cigarrillos(jockey), golosinas(50)]).
ventas(dodain, miercoles, 12, 8, [bebidas(alcohilica, 8) , bebidas(noAlcoholica, 1) , golosinas(10)]).
ventas(martu, miercoles, 12, 8, [golosinas(1000), cigarrillos(chesterfield, colorado, parisiennes)]).
ventas(lucas, martes, 11, 8, [golosinas(600)]).
ventas(lucas, martes, 18, 8, [bebidas(noAlcoholica, 2) , cigarrillos(derby)]).


esVendedorSuertudo(Vendedor):-
    ventas(Vendedor,_,_,_,_),
    forall(ventas(Vendedor, _, _ , _, [PrimerProducto | _]) , esImportante(PrimerProducto) ).


esImportante(golosinas(Precio)):- Precio > 100.

esImportante(cigarrillos(Marcas)):- length(Marcas, CantidadMarcas), CantidadMarcas > 2.


esImportante(bebidas(alcohilica,_)).
esImportante(bebidas(_ ,Cantidad)):- Cantidad > 5.
