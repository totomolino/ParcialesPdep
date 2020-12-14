persona(bart).
persona(larry).
persona(otto).
persona(marge).


%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).

persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).


hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).


salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).


%Los beneficios son funtores confort(descripcion), confort(descripcion, caracteristica),
% dispersion(descripcion), economico(descripcion, monto).

gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio( burns , dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).



%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


aspiranteMagio(Persona) :-
    persona(Persona),
    not(esMagio(Persona)),
    esMagio(Magio),
    magioOPadre(Persona, Magio).

magioOPadre(Persona, Magio) :-
    salvo(Persona, Magio).

magioOPadre(Persona, Padre) :-
    hijo(Persona, Padre).
    


esMagio(Persona) :-
    magioAlMando(Persona, _).
    

esMagio(Persona) :-
    esMagioNovato(Persona).

esMagio(Persona) :-
    esElegido(Persona).

magioAlMando(Persona, Nivel) :-
    persona(alMando(Persona, Nivel)).

esMagioNovato(Persona) :-
    persona(novato(Persona)).

esElegido(Persona) :-
    persona(elElegido(Persona)).


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


puedeDarOrdenes(MagioJefe, Magio) :-
    magioAlMando(MagioJefe,_),
    esMagioNovato(Magio).

puedeDarOrdenes(MagioJefe, Magio) :-
    magioAlMando(MagioJefe, NivelMayor),
    magioAlMando(Magio, NivelMenor),
    NivelMayor >= NivelMenor.

puedeDarOrdenes(MagioJefe, Magio) :-
    esMagio(Magio),
    esElegido(MagioJefe).


%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%


sienteEnvidia(Envidioso, Personas) :-
    persona(Envidioso),
    forall(member(Persona, Personas) , tieneEnvidia(Envidioso, Persona)).


tieneEnvidia(Envidioso, Persona) :-
    aspiranteMagio(Envidioso),
    esMagio(Persona).

tieneEnvidia(Envidioso, Persona) :-
    persona(Envidioso),
    not(aspiranteMagio(Envidioso)),
    aspiranteMagio(Persona).

tieneEnvidia(Envidioso, Persona) :-
    esMagioNovato(Envidioso),
    magioAlMando(Persona, _).
    

%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


    


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


soloLoGoza(Persona, Beneficio) :-
    esMagio(Persona),
    gozaBeneficio(Persona, Beneficio),
    forall((esMagio(Magio) , Persona \= Magio), not(gozaBeneficio(Magio, Beneficio))).



%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%

tipoDeBeneficioMasAprovechado(Tipo) :-
    tipoDeBeneficio(_, Tipo),
    forall(tipoDeBeneficio(_, OtroTipo) , supera(Tipo, OtroTipo)).



supera(Tipo, OtroTipo) :-
    tipoDeBeneficio(_, Tipo),
    tipoDeBeneficio(_, OtroTipo),
    cuantosLoUsan(Tipo, Cuantos),
    cuantosLoUsan(OtroTipo, OtrosCuantos),
    Cuantos >= OtrosCuantos.


cuantosLoUsan(Tipo, Cuantos) :-
    gozaBeneficio(_, Beneficio),
    tipoDeBeneficio(Beneficio, Tipo),
    findall(Magio, gozaBeneficioPorTipo(Magio, Tipo) , Magios),
    length(Magios, Cuantos).



tipoDeBeneficio(confort(_), confort).
tipoDeBeneficio(confort(_, _), confort).
tipoDeBeneficio(dispersion(_), dispersion).
tipoDeBeneficio(economico(_,_), economico).


gozaBeneficioPorTipo(Magio, Tipo) :-
    gozaBeneficio(Magio, Beneficio),
    tipoDeBeneficio(Beneficio, Tipo).