import Text.Show.Functions


data Jugador = Jugador {
nombre :: String,
padre :: String,
habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
fuerzaJugador :: Int,
precisionJugador :: Int
} deriving (Eq, Show)

mapPrecision :: (Int -> Int) -> Habilidad -> Habilidad
mapPrecision funcion unaHabilidad = unaHabilidad{ precisionJugador = funcion . precisionJugador $ unaHabilidad}

dividirPrecisionPor :: Int -> Habilidad -> Int
dividirPrecisionPor n unaHabilidad = div (precisionJugador unaHabilidad) n

multiplicarPrecisionPor :: Int -> Habilidad -> Int
multiplicarPrecisionPor n unaHabilidad = (*n) . precisionJugador $ unaHabilidad

-- Funciones útiles

between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)

mayorSegun f a b
 | f a > f b = a
 | otherwise = b


-- Jugadores de ejemplo
bart = Jugador "Bart" "Homero" (Habilidad 25 60)
todd = Jugador "Todd" "Ned" (Habilidad 15 80)
rafa = Jugador "Rafa" "Gorgory" (Habilidad 10 1)
chuck = Jugador "Chuck" "Dios" (Habilidad 1000 1000)

data Tiro = Tiro {
velocidad :: Int,
precision :: Int,
altura :: Int
} deriving (Eq, Show)

mapVelocidad :: (Int -> Int) -> Tiro -> Tiro 
mapVelocidad funcion unTiro = unTiro { velocidad = funcion . velocidad $ unTiro }

mapPrecisionTiro :: (Int -> Int) -> Tiro -> Tiro 
mapPrecisionTiro funcion unTiro = unTiro { precision = funcion . precision $ unTiro }

mapAltura :: (Int -> Int) -> Tiro -> Tiro 
mapAltura funcion unTiro = unTiro { altura = funcion . altura $ unTiro }

dividirAlturaPor :: Int -> Tiro -> Tiro
dividirAlturaPor n unTiro = unTiro {altura = div (altura unTiro) n }


type Puntos = Int



-----------
--Punto 1--
-----------

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = Tiro {velocidad = 10 , altura = 0 , precision = multiplicarPrecisionPor 2 habilidad }

madera :: Palo
madera habilidad = Tiro {velocidad = 100 , altura = 5 , precision = dividirPrecisionPor 2 habilidad}

hierro :: Int -> Palo
hierro n habilidad  = Tiro {velocidad = (*n) . fuerzaJugador $ habilidad , altura = (max 0) . subtract 3 $ n , precision = dividirPrecisionPor n habilidad }

hierros :: [Palo]
hierros = [hierro 1 , hierro 2 , hierro 3 , hierro 4 , hierro 5 , hierro 6 , hierro 7 , hierro 8 , hierro 9 , hierro 10]

palos :: [Palo]
palos = [putter , madera ] ++ hierros

-----------
--Punto 2--
-----------

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = unPalo . habilidad $ unJugador

-----------
--Punto 3--
-----------

data Obstaculo = Obstaculo {
    condicion :: Condicion,
    efecto    :: Efecto
}deriving (Show)

type Condicion = Tiro -> Bool
type Efecto    = Tiro -> Tiro

detener :: Efecto
detener unTiro = Tiro 0 0 0



tunelConRampita :: Obstaculo
tunelConRampita = Obstaculo {condicion = condicionRampa , efecto = efectoRampa}

condicionRampa :: Condicion
condicionRampa unTiro = (precisionMayorA 90 unTiro) && (alturaAlRas unTiro) 

efectoRampa :: Efecto
efectoRampa unTiro = mapVelocidad (*2) . mapPrecisionTiro (const 100) . mapAltura (const 0) $ unTiro
    
alturaAlRas :: Tiro -> Bool
alturaAlRas unTiro = ((== 0) . altura $ unTiro)

precisionMayorA :: Int -> Tiro -> Bool
precisionMayorA n unTiro = (>n) . precision $ unTiro



laguna :: Int -> Obstaculo
laguna largo = Obstaculo {condicion = condicionLaguna , efecto = efectoLaguna largo}

condicionLaguna :: Condicion
condicionLaguna unTiro = (precisionMayorA 80 unTiro) && alturaEntre 1 5 unTiro

efectoLaguna :: Int -> Efecto
efectoLaguna largo unTiro = dividirAlturaPor (largo) unTiro

alturaEntre :: Int -> Int -> Tiro -> Bool
alturaEntre x y unTiro = ((>x) . altura $ unTiro) && ((<y) . altura $ unTiro)



hoyo :: Obstaculo
hoyo = Obstaculo {condicion = condicionHoyo , efecto = efectoHoyo}

condicionHoyo :: Condicion
condicionHoyo unTiro = (precisionMayorA 95 unTiro) && (alturaAlRas unTiro) && (velocidadEntre 5 20 unTiro)

efectoHoyo :: Efecto
efectoHoyo unTiro = detener unTiro

velocidadEntre :: Int -> Int -> Tiro -> Bool
velocidadEntre x y unTiro = ((>x) .velocidad $ unTiro) && ((<y) .velocidad $ unTiro)


tiroLuegoDe :: Obstaculo -> Tiro -> Tiro
tiroLuegoDe unObstaculo unTiro 
   | cumpleCondicion unTiro unObstaculo = aplicarEfecto unTiro unObstaculo
   | otherwise = detener unTiro

cumpleCondicion :: Tiro -> Obstaculo -> Bool
cumpleCondicion unTiro unObstaculo = ($ unTiro) . condicion $ unObstaculo

aplicarEfecto :: Tiro -> Obstaculo -> Tiro
aplicarEfecto unTiro unObstaculo = ($ unTiro) . efecto $ unObstaculo



-----------
--Punto 4--
-----------

tiro1 :: Tiro 
tiro1 = Tiro 10 95 0

obstaculos :: [Obstaculo]
obstaculos = [tunelConRampita,tunelConRampita,hoyo]


-- A

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter (puedePasar unObstaculo unJugador) palos

puedePasar :: Obstaculo -> Jugador -> Palo -> Bool
puedePasar unObstaculo unJugador unPalo = pasaElTiro (golpe unJugador unPalo) unObstaculo


-- B

cuantosPuedoPasar :: [Obstaculo] -> Tiro -> Int
cuantosPuedoPasar unosObstaculos unTiro = length . takeWhile (pasaElTiro unTiro ) $ unosObstaculos

pasaElTiro :: Tiro -> Obstaculo -> Bool
pasaElTiro unTiro unObstaculo = cumpleCondicion unTiro unObstaculo


-- C

paloMasUtil :: Jugador -> [Obstaculo] -> Palo
paloMasUtil unJugador unosObstaculos = foldl1 (mejorPaloEntre (habilidad unJugador) unosObstaculos) palos 

mejorPaloEntre :: Habilidad -> [Obstaculo] -> Palo -> Palo -> Palo
mejorPaloEntre habilidad unosObstaculos unPalo otroPalo 
  | cuantosPuedoPasar unosObstaculos (unPalo habilidad) > cuantosPuedoPasar unosObstaculos (otroPalo habilidad) = unPalo
  | otherwise = otroPalo


-----------
--Punto 5--
-----------

type Podio = [(Jugador,Puntos)]

--quienPerdio :: Podio -> [String]
--quienPerdio unPodio = ganador unPodio 

--ganador :: Podio -> Puntos
ganador unPodio = map (snd) unPodio