import Text.Show.Functions


data Mascota = Mascota {
    nombreMascota :: String,
    edad :: Int,
    duenio :: Duenio,
    energia :: Int,
    trucos :: [Truco],
    estaDistraida :: Bool
}deriving (Show)

mapEnergia :: (Int -> Int) -> Mascota -> Mascota
mapEnergia funcion mascota = mascota{energia = funcion . energia $ mascota}

restarEnergia :: Int -> Mascota -> Mascota
restarEnergia n unaMascota = mapEnergia (subtract n) unaMascota

sumarEnergia :: Int -> Mascota -> Mascota
sumarEnergia n unaMascota = mapEnergia ((+) n) unaMascota

mapNombreMascota :: (String -> String) -> Mascota -> Mascota
mapNombreMascota funcion mascota = mascota{nombreMascota = funcion . nombreMascota $ mascota}

mapDistraccion :: (Bool -> Bool) -> Mascota -> Mascota
mapDistraccion funcion mascota = mascota{estaDistraida = funcion . estaDistraida $ mascota}

mapDuenio :: (Duenio -> Duenio) -> Mascota -> Mascota
mapDuenio funcion mascota = mascota{duenio = funcion . duenio $ mascota}

mapEdad :: (Int -> Int) -> Mascota -> Mascota
mapEdad funcion mascota = mascota{edad = funcion . edad $ mascota}

mapTrucos :: ([Truco] -> [Truco]) -> Mascota -> Mascota
mapTrucos funcion mascota = mascota{trucos = funcion . trucos $ mascota}

data Duenio = Duenio {
    nombreDuenio :: String,
    aniosExp :: Int
}deriving (Show,Eq)

mapAniosExp :: (Int -> Int) -> Duenio -> Duenio
mapAniosExp funcion duenio = duenio {aniosExp = funcion . aniosExp $ duenio}


type Truco = Mascota -> Mascota

firulais :: Mascota
firulais = Mascota "Firulais" 5 jose 100 [] False

jose :: Duenio
jose = Duenio "Jose" 50


despertar :: Mascota -> Mascota
despertar unaMascota = mapDistraccion (const False) unaMascota



-------------
-- Punto 1 --
-------------

ayudanteDeSanta :: Mascota
ayudanteDeSanta = Mascota {nombreMascota = "Ayudante de Santa" , edad = 10 , duenio = bart , energia = 50 , trucos = [sentarse , hacerseElMuerto , tomarAgua , mortalTriple] , estaDistraida = False}

bart :: Duenio
bart = Duenio {nombreDuenio = "Bart Simpson" , aniosExp = 5}


bolt :: Mascota
bolt = Mascota {nombreMascota = "Bolt" , edad = 5 , duenio = penny , energia = 100 , trucos = [perroMojado , hacerseElMuerto , sentarse , mortalTriple] , estaDistraida = False}

penny :: Duenio
penny = Duenio {nombreDuenio = "Penny" , aniosExp = 1}


tortuga :: Mascota
tortuga = Mascota {nombreMascota = "La tortuga" , edad = 32 , duenio = fede , energia = 30 , trucos = [sentarse , sentarse , sentarse , tomarAgua] , estaDistraida = True}

fede :: Duenio
fede = Duenio {nombreDuenio = "Fede Scarpa" , aniosExp = 30}



-------------
-- Punto 2 --
-------------


sentarse :: Truco
sentarse unaMascota = restarEnergia 5 unaMascota

tomarAgua :: Truco
tomarAgua unaMascota = sumarEnergia 5 unaMascota

perroMojado :: Truco
perroMojado unaMascota = restarEnergia 5 . pobrecito $ unaMascota

pobrecito :: Mascota -> Mascota
pobrecito unaMascota = mapNombreMascota ("Pobre " ++) unaMascota


hacerseElMuerto :: Truco
hacerseElMuerto unaMascota = sumarEnergia 10 . leAgarraSuenio $ unaMascota

leAgarraSuenio :: Mascota -> Mascota
leAgarraSuenio unaMascota = mapDistraccion (const True) unaMascota

mortalTriple :: Truco
mortalTriple unaMascota = restarEnergia 20 . (sumarAniosDeExperiencia 10) $ unaMascota

sumarAniosDeExperiencia :: Int -> Mascota -> Mascota
sumarAniosDeExperiencia n unaMascota = mapDuenio (sumarAnios n) unaMascota

sumarAnios :: Int -> Duenio -> Duenio
sumarAnios n unDuenio = mapAniosExp ((+) n) unDuenio


-------------
-- Punto 3 --
-------------

realizarPresentacion :: Mascota -> Mascota
realizarPresentacion unaMascota = aplicarTrucos unaMascota $ trucos unaMascota

aplicarTrucos :: Mascota -> [Truco] -> Mascota
aplicarTrucos unaMascota unosTrucos = foldl hacerTruco unaMascota unosTrucos

hacerTruco :: Mascota -> Truco -> Mascota
hacerTruco unaMascota unTruco 
 | puedeHacerTruco =  unTruco unaMascota
 | otherwise     = despertar unaMascota
 where puedeHacerTruco = (not . estaDistraida $ unaMascota) && (not . tieneEnergiaNeg $ unaMascota)

tieneEnergiaNeg :: Mascota -> Bool
tieneEnergiaNeg unaMascota = (<0) . energia $ unaMascota

 
-------------
-- Punto 4 --
-------------



type Resultados = (String , Int , Int , Int)

resultados :: Mascota -> Resultados
resultados unaMascota = (nombreMascota unaMascota , puntosEnergia . realizarPresentacion $ unaMascota , habilidad . realizarPresentacion $ unaMascota , ternura . realizarPresentacion $ unaMascota)

puntosEnergia :: Criterio
puntosEnergia unaMascota = ((*) . energia $ unaMascota) . edad $ unaMascota

habilidad :: Criterio
habilidad unaMascota = (length . trucos $ unaMascota) * (aniosExp . duenio $ unaMascota)

ternura :: Criterio
ternura unaMascota 
 | estaMojada unaMascota = 20
 | otherwise  = 20 - (edad unaMascota)

estaMojada :: Mascota -> Bool
estaMojada unaMascota = (take 5 . nombreMascota $ unaMascota) == "Pobre"


-------------
-- Punto 5 --
-------------

type Criterio = Mascota -> Int

ganadorDeCategoria :: Criterio -> [Mascota] -> Mascota
ganadorDeCategoria criterio mascotas = realizarPresentacion . foldl1 (leFueMejorSegun criterio) $ mascotas

leFueMejorSegun :: Criterio -> Mascota -> Mascota -> Mascota
leFueMejorSegun criterio unaMascota otraMascota 
 | criterio unaMascota > criterio otraMascota = unaMascota
 | otherwise                                  = otraMascota

-------------
-- Punto 6 --
-------------

ganadorDelConcurso :: [Mascota] -> Mascota
ganadorDelConcurso unasMascotas = laMejorSegun totalPuntos unasMascotas

laMejorSegun :: Criterio -> [Mascota] -> Mascota 
laMejorSegun criterio unasMascotas = foldl1 (leFueMejorSegun criterio) unasMascotas


totalPuntos :: Criterio
totalPuntos unaMascota = sumaDePuntos . resultados $ unaMascota

sumaDePuntos :: Resultados -> Int
sumaDePuntos (_,x,y,z) = x + y + z

-------------
-- Punto 7 --
-------------

{-7. Opcional
■ Queremos agregar que el truco Tomar agua además de recuperar energía,
le saque tiempo a nuestra mascota y haga que no pueda realizar el último
truco de su presentación.
○ ¿Se podría resolver de la misma manera?
○ Esperamos sus soluciones! si se animan....-}

sacarTiempo :: Int -> Mascota -> Mascota
sacarTiempo n unaMascota = mapEdad (subtract n) unaMascota

sacarUltimoTruco :: Mascota -> Mascota
sacarUltimoTruco unaMascota = mapTrucos (init) unaMascota

tomarAgua2 :: Truco
tomarAgua2 unaMascota = sacarUltimoTruco . sumarEnergia 5 $ unaMascota