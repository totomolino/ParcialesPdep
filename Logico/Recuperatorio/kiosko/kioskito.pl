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






