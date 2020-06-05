import Text.Show.Functions

-- punto 1
-- a)

type Recurso = String

data Pais = Pais {
    ingresoPerCapita :: Float,
    sectorPublico :: Int,
    sectorPrivado :: Int,
    recursos  :: [Recurso],
    deuda     :: Float
} deriving (Show)

mapDeuda :: (Float -> Float) -> Pais -> Pais
mapDeuda funcion pais = pais {deuda = funcion (deuda pais)}

mapIngreso :: (Float -> Float) -> Pais -> Pais
mapIngreso funcion pais = pais {ingresoPerCapita = funcion (ingresoPerCapita pais)}

mapPublico :: (Int -> Int) -> Pais -> Pais
mapPublico funcion pais = pais {sectorPublico = funcion (sectorPublico pais)}

mapRecurso :: ([Recurso] -> [Recurso]) -> Pais -> Pais
mapRecurso funcion pais = pais {recursos = funcion (recursos pais)}

-- b)

namibia :: Pais
namibia = Pais {ingresoPerCapita = 4140 , sectorPublico = 400000 , sectorPrivado = 650000 , recursos = ["Mineria" , "Ecoturismo"] , deuda = 50}


-- 2) 
  
type Estrategia = Pais -> Pais

prestarDolares :: Float -> Estrategia 
prestarDolares cuanto unPais = mapDeuda (+ sacarPorcentaje 150 cuanto ) unPais

sacarPorcentaje :: Float -> Float -> Float
sacarPorcentaje porcentaje dinero = (/ 100) . (* porcentaje) $ dinero  
   

reducirPorPublico :: Int -> Estrategia
reducirPorPublico cantidadDePuestos pais = mapIngreso (cuantoSaco cantidadDePuestos) . mapPublico (subtract cantidadDePuestos) $ pais

cuantoSaco :: Int -> Float -> Float
cuantoSaco cantidadDePuestos ingreso |cantidadDePuestos > 100 = ((-) ingreso ) . sacarPorcentaje 20 $ ingreso
                                     | otherwise = ((-) ingreso ) . sacarPorcentaje 10 $ ingreso


explotarRecurso :: Recurso -> Estrategia
explotarRecurso recurso unPais = mapDeuda (subtract 2) . mapRecurso (sacarRecurso recurso) $ unPais 

sacarRecurso :: Recurso -> [Recurso] -> [Recurso]
sacarRecurso recurso unosRecursos = filter (/= recurso) unosRecursos


establecerBlindaje :: Estrategia
establecerBlindaje unPais = reducirPorPublico 500 . prestarDolares ((/2) $ pbi unPais) $  unPais


pbi :: Pais -> Float
pbi unPais = (sectorActivoDe unPais) * (ingresoPerCapita unPais)

sectorActivoDe :: Pais -> Float
sectorActivoDe unPais = fromIntegral (sectorPrivado unPais + sectorPublico unPais)


-- Punto 3 xd

-- a)

type Receta = [Estrategia]

receta :: Receta
receta = [prestarDolares 200 , explotarRecurso "Mineria"]

-- b)

aplicarRecetaA :: Pais -> Receta -> Pais
aplicarRecetaA unPais unaReceta = foldr ($) unPais unaReceta



-- Punto 4

-- a)

puedenZafar :: [Pais] -> [Pais]
puedenZafar unosPaises = filter (\unPais -> elem "Petroleo" . recursos $ unPais) unosPaises
--                          1

-- b)

deudaAFavor :: [Pais] -> Float
deudaAFavor paises = sum . map (deuda) $ paises 
--                                2

{- c)

Se utilizo orden superior en las 2 funciones, como en 1.

Se utilizo composicion en la funcion tienePetroleo, y en al funcion deudaAfavor

Se utilizo aplicacion parcial en todas las funciones, por ejemplo en  2. 

Las ventajas de estas son la misma funcionalidad de haskell, si yo no aplico parcialmente las funciones, no puedo
usar las funciones de orden superior, y componer deja el codigo mas limpio y entendible.

-}

-- Punto 5

receta1 :: Receta
receta1 = [prestarDolares 200 , explotarRecurso "Mineria" , establecerBlindaje]

estaOrdenada :: Pais -> [Receta] -> Bool
estaOrdenada unPais  [receta] = True
estaOrdenada unPais (receta1 : receta2 : recetas) = revisarPbi unPais receta1 <= revisarPbi unPais receta2 && estaOrdenada unPais (receta2 : recetas)  

revisarPbi :: Pais -> Receta -> Float
revisarPbi pais receta = pbi . aplicarRecetaA pais $ receta

-- Punto 6

recursosNaturalesInfinitos :: [Recurso]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

paisReLoco :: Pais
paisReLoco = Pais {ingresoPerCapita = 4140 , sectorPublico = 400000 , sectorPrivado = 650000 , recursos = recursosNaturalesInfinitos , deuda = 50}


{- 

a) se puede aplicar puedenZafar a paisReLoco?

No, porque la funcion puedenZafar va a intentar filtrar todos los que cumplan la condicion de la lista, y esta condicion implica fijarse
en sus recursos naturales. Aplica la funcion elem "Petroleo" a la lista infinita, esto no termina nunca, porque no termina de recorrer toda la lista
para ver si esta el "Petroleo" , pero como la lista es solo de "Energia", nunca termina de encontrarlo.

b) se puede aplicar deudaAFavor a paisReLoco?

Si, porque esta funcion no pasa por la lista de recursos. Solo entra al campo de deuda y calcula lo que tiene que calcular, no es necesario tocar
la lista infinita. 



-}
