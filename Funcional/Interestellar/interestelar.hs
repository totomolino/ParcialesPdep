import Text.Show.Functions

data Planeta = Planeta {
    nombre :: String,
    posicion :: Posicion, 
    tiempo :: (Int -> Int)
}deriving (Show)

type Posicion = (Float, Float, Float)

posX :: Planeta -> Float
posX planeta = coordX . posicion $ planeta

posY :: Planeta -> Float
posY planeta = coordY . posicion $ planeta

posZ :: Planeta -> Float
posZ planeta = coordZ . posicion $ planeta


coordX (x,_,_) = x
coordY (_,y,_) = y
coordZ (_,_,z) = z

data Astronauta = Astronauta {

    nombreAstronauta :: String,
    edad :: Int,
    planeta :: Planeta
}deriving (Show)

mapEdad :: (Int -> Int) -> Astronauta -> Astronauta
mapEdad funcion astronauta = astronauta {edad = funcion (edad astronauta)}

mapPlaneta :: (Planeta -> Planeta) -> Astronauta -> Astronauta
mapPlaneta funcion astronauta = astronauta {planeta = funcion (planeta astronauta)}


marte :: Planeta
marte =  Planeta{nombre = "Marte" , posicion = (123,532,64) , tiempo = tiempoMarte }

jupiter :: Planeta
jupiter =  Planeta{nombre = "Jupiter" , posicion = (128,4564,549) , tiempo = tiempoMarte }

tierra :: Planeta
tierra = Planeta {nombre = "Jupiter" , posicion =  (3,4,5) , tiempo = tiempoTierra}

tiempoTierra :: Int -> Int
tiempoTierra tiempo = tiempo

tiempoMarte :: Int -> Int
tiempoMarte tiempo = tiempo + 1


cooper :: Astronauta
cooper = Astronauta {nombreAstronauta = "Cooper" , edad = 45 , planeta = tierra }

murph :: Astronauta
murph  = Astronauta {nombreAstronauta = "Murphy" , edad = 15 , planeta = tierra }

matt :: Astronauta
matt  = Astronauta {nombreAstronauta = "Matt" , edad = 30 , planeta = marte }

-- Punto 1 

-- a)

distanciaEntre :: Planeta -> Planeta -> Float
distanciaEntre unPlaneta otroPlaneta = pitagoras (( posX unPlaneta) - ( posX otroPlaneta))  (( posY unPlaneta) - ( posY otroPlaneta))  (( posZ unPlaneta) - ( posZ otroPlaneta))

pitagoras :: Float -> Float -> Float -> Float
pitagoras x y z = sqrt((x**2) + (y**2) + (z**2))

-- b)

cuantoTardo :: Float -> Planeta -> Planeta -> Int
cuantoTardo velocidad unPlaneta otroPlaneta = round . (/velocidad) $ (distanciaEntre unPlaneta otroPlaneta) 


-- Punto 2 

pasarTiempo :: Int -> Astronauta -> Astronauta
pasarTiempo cantidadDeAnios unAstronauta = mapEdad ((+) $ aplicarTiempo (tiempo . planeta $ unAstronauta) cantidadDeAnios) unAstronauta

aplicarTiempo :: (Int -> Int) -> Int -> Int
aplicarTiempo tiempo edad = tiempo edad



-- Punto 3

-- a) 

type Nave = Planeta -> Planeta -> Int




naveVieja :: Int -> Nave
naveVieja tanques unPlaneta otroPlaneta | tanques < 6 = cuantoTardo 7 unPlaneta otroPlaneta
                                        | otherwise   = cuantoTardo 10 unPlaneta otroPlaneta

naveFuturistica :: Nave
naveFuturistica _ _ = 0 


viaje :: Nave -> Planeta -> Astronauta -> Astronauta
viaje nave otroPlaneta unAstronauta  = pasarTiempo (nave planetaOrigen otroPlaneta) . cambiarPlaneta otroPlaneta $ unAstronauta
 where planetaOrigen = planeta unAstronauta

cambiarPlaneta :: Planeta -> Astronauta -> Astronauta
cambiarPlaneta unPlaneta unAstronauta = mapPlaneta (const unPlaneta) unAstronauta

-- Punto 4

-- a)







rescate :: [Astronauta] -> Nave -> Astronauta -> [Astronauta]
rescate rescatistas nave  rescatado = 
   viajarDeAMuchos nave planetaOrigen . (pasarTiempo tiempoDeEspera rescatado :) . viajarDeAMuchos nave planetaDestino $ rescatistas
 where planetaDestino = planeta rescatado
       planetaOrigen  = planeta . head $ rescatistas 
       tiempoDeEspera = nave planetaDestino planetaOrigen 

viajarDeAMuchos :: Nave -> Planeta -> [Astronauta] -> [Astronauta]
viajarDeAMuchos unaNave destino unosAstronautas =
  map (viaje unaNave destino) unosAstronautas


-- b)

--alRescate :: [Astronauta] -> Nave -> [Astronauta] -> [String]
alRescate unosRescatistas unaNave unosRescatados =  filter ningunoEsMayor . map (rescate unosRescatistas unaNave) $ unosRescatados

 --map (nombreAstronauta) .

ningunoEsMayor :: [Astronauta] -> Bool
ningunoEsMayor unosAstronautas = not . any (> 90) . map (edad) $ unosAstronautas 
